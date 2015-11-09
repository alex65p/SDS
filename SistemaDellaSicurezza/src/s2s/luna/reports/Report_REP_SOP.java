/**   ======================================================================== */
/**                                                                            */
/** @copyright Copyright (c) 2010-2015, S2S s.r.l. */
/** @license   http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2 */
/** @version   6.0  */
/** This file is part of SdS - Sistema della Sicurezza  . */
/** SdS - Sistema della Sicurezza   is free software: you can redistribute it and/or modify */
/** it under the terms of the GNU General Public License as published by  */
/** the Free Software Foundation, either version 3 of the License, or  */
/** (at your option) any later version.  */

/** SdS - Sistema della Sicurezza  is distributed in the hope that it will be useful, */
/** but WITHOUT ANY WARRANTY; without even the implied warranty of */
/** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the */
/** GNU General Public License for more details. */

/** You should have received a copy of the GNU General Public License */
/** along with SdS - Sistema della Sicurezza .  If not, see <http://www.gnu.org/licenses/gpl-2.0.html>  GNU Public License v.2 */
/**                                                                            */
/**   ======================================================================== */

package s2s.luna.reports;

import com.apconsulting.luna.ejb.AnagrDocumentiGestioneCantieri.IAnagrDocumentiGestioneCantieri;
import com.apconsulting.luna.ejb.AnagrDocumentiGestioneCantieri.IAnagrDocumentiGestioneCantieriHome;
import com.apconsulting.luna.ejb.AnagrDocumento.AnagDocumentoFileInfo;
import com.apconsulting.luna.ejb.AnagrDocumento.IAnagrDocumento;
import com.apconsulting.luna.ejb.AnagrDocumento.IAnagrDocumentoHome;
import com.apconsulting.luna.ejb.AnagrProcedimento.IAnagrProcedimento;
import com.apconsulting.luna.ejb.Azienda.IAzienda;
import com.apconsulting.luna.ejb.Azienda.IAziendaHome;
import com.apconsulting.luna.ejb.Dipendente.DipendentiBySOP_View;
import com.apconsulting.luna.ejb.Sopraluogo.ISopraluogo;
import com.apconsulting.luna.ejb.Sopraluogo.ISopraluogoHome;
import com.apconsulting.luna.ejb.Dipendente.IDipendenteHome;
import com.apconsulting.luna.ejb.AnagrOpere.IAnagrOpereHome;
import com.apconsulting.luna.ejb.Cantiere.ICantiereHome;
import com.apconsulting.luna.ejb.AnagrProcedimento.IAnagrProcedimentoHome;
import com.apconsulting.luna.ejb.AnagrOpere.IAnagrOpere;
import com.apconsulting.luna.ejb.Cantiere.ICantiere;
import com.apconsulting.luna.ejb.Media.jbMedia;
import com.apconsulting.luna.ejb.Sopraluogo.jbConstatazione;
import com.apconsulting.luna.ejb.Sopraluogo.DocumentiAssociati_Sopralluogo_View;
import com.lowagie.text.BadElementException;
import com.lowagie.text.Cell;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Image;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfWriter;
import java.io.IOException;
import java.util.Collection;
import s2s.ejb.pseudoejb.PseudoContext;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.util.SecurityWrapper;
import s2s.report.CenterMiddleTable;
import s2s.report.Report;
import s2s.report.ZREPORT_SETTINGS;
import s2s.utils.Alphabet;
import s2s.utils.plain.Formatter;
import s2s.utils.text.StringManager;
import com.lowagie.text.Document;
import java.io.File;
import java.util.Iterator;

public class Report_REP_SOP extends Report {

    public long lCOD_SOP = 0;
    private boolean IncludeLogo = true;
    private ZREPORT_SETTINGS REPORT_SETTINGS = new ZREPORT_SETTINGS();
    private byte defaultFontSize = 9;

    public Report_REP_SOP(long lCOD_SOP) {
        this.lCOD_SOP = lCOD_SOP;
    }

    public Report_REP_SOP(long lCOD_SOP, boolean _IncludeLogo) {
        this(lCOD_SOP);
        this.IncludeLogo = _IncludeLogo;
    }

    public String formatPlain(java.util.Date dt) {
        if (dt == null) {
            return "";
        }
        return new java.text.SimpleDateFormat("dd/MM/yyyy").format(dt);
    }

    public String formatPlain(int i) {
        return Integer.toString(i);
    }

    private boolean StampaDocumenti(ISopraluogoHome home_sop, long lCOD_COD_SOP,
            Document document, PdfWriter writer) throws Exception {

        /* NB, il metodo stampa documenti torna true non se ho stampato i documenti
         * ma se la evantuale stampa dei documenti finisce con una pagina nuova o meno.
         */

        boolean endWithNewPage = false;

        // Estraggo i documenti legati al sopralluogo
        Collection sop_doc_list = home_sop.getDocumentiCantiereSOP_STAMPA(lCOD_SOP);
        // ... se ne trovo...
        if (sop_doc_list != null && !sop_doc_list.isEmpty()) {
            //writePage();
            Iterator it_prg_doc = sop_doc_list.iterator();
            int i = 0;
            while (it_prg_doc.hasNext()) {
                DocumentiAssociati_Sopralluogo_View sop_doc = (DocumentiAssociati_Sopralluogo_View) it_prg_doc.next();
                if (i > 0) {
                   writePage();
                }
                // Stampo i file allegati al documento
                /* NB, il metodo stampa documento torna true non se ho stampato un
                 * documento ma se ho stampato gli allegati di tale documento.
                 * Solo in questo caso infatti, è necessario andare a pagina nuova.
                 */
                if (StampaDocumento(sop_doc.lCOD_DOC, document, writer)) {
                    endWithNewPage = true;
                } else {
                    writeLine();
                    endWithNewPage = false;
                }
                i = i + 1;
            }

        }
        return endWithNewPage;
    }

    private boolean StampaDocumento(Long lCOD_DOC, Document document, PdfWriter writer) throws Exception {
        IAnagrDocumentiGestioneCantieriHome doc_home = (IAnagrDocumentiGestioneCantieriHome) PseudoContext.lookup("AnagrDocumentiGestioneCantieriBean");
        IAnagrDocumentiGestioneCantieri doc_can_bean = null;

        // NB, il metodo stampa documento torna true non se ho stampato un
        // documento ma se ho stampato gli allegati di tale documento.
        //

        // Se stò trattando un documento valido...
        if (lCOD_DOC != null && lCOD_DOC.compareTo(new Long(0)) > 0) {

            // Estraggo il documento al quale sono allegati i file.
            doc_can_bean = doc_home.findByPrimaryKey(lCOD_DOC);

           
            Stampa_documento stampa_documento = new Stampa_documento();
            // Se trovo il documento e se lo stesso contiene allegati..
            if (doc_can_bean != null && stampa_documento.checkAllegati(lCOD_DOC)) {
                //writePage();

                //stampo il titolo del documento
                writeTitle(Formatter.format(doc_can_bean.getTIT_DOC()));

                boolean printedFiles = false;

                // Stampo l'allegato 1 (File)
                if (stampa_documento.StampaAllegato(lCOD_DOC, Stampa_documento.TIPO_ALLEGATO.FILE, document, writer)) {
                    printedFiles = true;
                }

                // Stampo l'allegato 2 (File Link)
                if (stampa_documento.StampaAllegato(lCOD_DOC, Stampa_documento.TIPO_ALLEGATO.FILE_LINK, document, writer)) {
                    printedFiles = true;
                }

                // Se ho stampato degli allegati, vado a pagina nuova.
                return printedFiles;
            }
        }
        return false;
    }

    @Override
    public void doReport() throws DocumentException, IOException, BadElementException, Exception {

        SecurityWrapper Security = SecurityWrapper.getInstance();
        ISopraluogoHome home1 = (ISopraluogoHome) PseudoContext.lookup("SopraluogoBean");
        ISopraluogo bean = home1.findByPrimaryKey(new Long(new Long(request.getParameter("ID"))));
        IAnagrProcedimentoHome home_pro = (IAnagrProcedimentoHome) PseudoContext.lookup("AnagrProcedimentoBean");
        IAnagrProcedimento bean_pro = home_pro.findByPrimaryKey(new Long(bean.getCOD_PRO()));
        IDipendenteHome home_dpd = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");

        ICantiereHome home_can = (ICantiereHome) PseudoContext.lookup("CantiereBean");
        ICantiere bean_can = home_can.findByPrimaryKey(new Long(bean.getCOD_CAN()));

        IAnagrOpereHome home_ope = (IAnagrOpereHome) PseudoContext.lookup("AnagrOpereBean");
        IAnagrOpere bean_ope = null;
        long COD_OPE = bean.getCOD_OPE();
        if (COD_OPE != 0) {
            bean_ope = home_ope.findByPrimaryKey(COD_OPE);
        }

        lCOD_AZL = Security.getAziendaR();
        IAziendaHome home_az = (IAziendaHome) PseudoContext.lookup("AziendaBean");
        IAzienda bean_az = home_az.findByPrimaryKey(new Long(lCOD_AZL));

        initDocument(
                "the doc",
                // Intestazione - Cella a sinistra
                bean_pro.getstrDES(),
                // Intestazione - Cella centrale
                bean_can.getNOM_CAN() + " - " + bean.getNUM_SOP(),
                // Piè di pagina Cella a sinistra
                bean_az.getRAG_SCL_AZL(),
                // Piè di pagina Cella a destra
                formatPlain(bean.getDAT_SOP()));

        m_handler.bShowDate = false;

        // LOGO E TITOLO
        {
            CenterMiddleTable tbl = new CenterMiddleTable(2);
            tbl.setDefaultCellBorder(0);
            int width[] = {15, 75};
            tbl.setWidths(width);
            if (IncludeLogo) {
                Image png = loadImage("LOGO");
                png.scalePercent(50);
                png.setAlignment(Image.ALIGN_LEFT);
                Cell cImage = new Cell(png);
                tbl.addCell(cImage);
            } else {
                tbl.addCell("");
            }
            CenterMiddleTable tbl2 = new CenterMiddleTable(1);
            tbl2.setDefaultCellBorder(0);
            tbl2.addCellBU(ApplicationConfigurator.CUSTOMER_NAME.toUpperCase(), 15);
            tbl2.addCellBU(ApplicationConfigurator.LanguageManager.getString("Coordinamento.sicurezza.cantieri").toUpperCase(), 15);

            Cell cText = new Cell(tbl2);
            tbl.addCell(cText);
            m_document.add(tbl);
        }

        writeIndent();
        {
            CenterMiddleTable tbl = new CenterMiddleTable(1);
            if (bStandAlone) {
            }
            m_document.add(tbl);
        }

        // DATI DEL SOPRALLUOGO
        {
            CenterMiddleTable tbl = new CenterMiddleTable(4);
            tbl.toLeft();
            int width[] = {30, 20, 25, 25};
            tbl.setWidths(width);
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Sopralluogo.N") + "  " + bean.getNUM_SOP(), defaultFontSize);
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("del") + "  " + formatPlain(bean.getDAT_SOP()), defaultFontSize);
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Inizio.h") + (bean.getORA_INI() != null ? bean.getORA_INI().toString().substring(0, 5) : ""), defaultFontSize);
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Fine.h") + (bean.getORA_FIN() != null ? bean.getORA_FIN().toString().substring(0, 5) : ""), defaultFontSize);
            m_document.add(tbl);
        }
        {
            CenterMiddleTable tbl = new CenterMiddleTable(3);
            tbl.toLeft();
            int width[] = {34, 33, 33};
            tbl.setWidths(width);
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Linea") + ":  " + bean_pro.getstrDES(), defaultFontSize);
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Stazione") + ":  " + bean_can.getNOM_CAN(), defaultFontSize);
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Opera") + ":  " + (bean_ope != null ? bean_ope.getstrNOM_OPE() : ""), defaultFontSize);
            m_document.add(tbl);
        }

        // PRESENTI AZIENDA
        {
            CenterMiddleTable tbl = new CenterMiddleTable(2);
            tbl.toLeft();
            int width[] = {25, 70};
            tbl.setWidths(width);
            tbl.border();
            java.util.Collection col = home_dpd.getDipendentiBySOP_View(lCOD_SOP);
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Presenti.RM"), defaultFontSize);
            java.util.Iterator it = col.iterator();
            String presentiRM = "";
            while (it.hasNext()) {
                DipendentiBySOP_View obj = (DipendentiBySOP_View) it.next();
                presentiRM += (StringManager.isEmpty(presentiRM) ? "" : ", ")
                        + obj.COG_DPD + " " + obj.NOM_DPD;
            }
            tbl.addCell(presentiRM, defaultFontSize);
            m_document.add(tbl);
        }

        // PRESENTI IMPRESA
        {
            CenterMiddleTable tbl = new CenterMiddleTable(2);
            tbl.toLeft();
            tbl.setPadding(1 / 2);
            int width[] = {25, 70};
            tbl.setWidths(width);
            tbl.border();
            java.util.Collection col = home_dpd.getDipendentiEstBySOP_View(lCOD_SOP);
            java.util.Iterator it = col.iterator();
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Presenti.impresa"), defaultFontSize);
            String presentiIMP = "";
            while (it.hasNext()) {
                DipendentiBySOP_View obj = (DipendentiBySOP_View) it.next();
                presentiIMP += (StringManager.isEmpty(presentiIMP) ? "" : ", ")
                        + obj.COG_DPD + " " + obj.NOM_DPD + " (" + obj.IMPRESA + ")";
            }
            tbl.addCell(presentiIMP, defaultFontSize);
            m_document.add(tbl);
        }
        writeLine();

        // CONSTATAZIONI
        {
            CenterMiddleTable tbl = new CenterMiddleTable(1);
            tbl.toLeft();
            int width[] = {100};
            tbl.setWidths(width);
            tbl.addHeaderCellB2(ApplicationConfigurator.LanguageManager.getString("CONSTATAZIONI"), 1, false, 11);
            m_document.add(tbl);
        }
        {
            CenterMiddleTable tbl = new CenterMiddleTable(2);
            tbl.toLeft();
            int width[] = {5, 85};
            tbl.setWidths(width);
            java.util.Collection col = home1.getConstatazioniSop(lCOD_SOP);
            java.util.Iterator it = col.iterator();
            tbl.setWidths(width);
            String constElementSeparator = " - ";
            Alphabet c = new Alphabet();
            String REV1 = c.getNextElement("1");
            while (it.hasNext()) {
                jbConstatazione obj = (jbConstatazione) it.next();

                // Numerazione alfabetica
                Cell cell = new Cell(new Phrase(Formatter.format(REV1), REPORT_SETTINGS.ftText9B));
                cell.setVerticalAlignment(Element.ALIGN_TOP);
                tbl.addCell(cell);

                // Constatazione
                tbl.addCell(Formatter.format(
                        (StringManager.isNotEmpty(obj.sRAG_SCL_DTE) ? obj.sRAG_SCL_DTE + constElementSeparator : "")
                        + (StringManager.isNotEmpty(obj.sNOM_ATT) ? obj.sNOM_ATT + constElementSeparator : "")
                        + (StringManager.isNotEmpty(obj.sDES_LIB) ? obj.sDES_LIB + constElementSeparator : "")
                        + obj.sDESC), defaultFontSize);
                REV1 = c.getNextElement(REV1);
            }
            m_document.add(tbl);
        }
        writeLine();

        // DISPOSIZIONI
        {
            CenterMiddleTable tbl = new CenterMiddleTable(1);
            tbl.toLeft();
            int width[] = {85};
            tbl.setWidths(width);
            tbl.addHeaderCellB2(ApplicationConfigurator.LanguageManager.getString("DISPOSIZIONI"), 1, false, 11);
            m_document.add(tbl);
        }
        {
            CenterMiddleTable tbl = new CenterMiddleTable(2);
            tbl.toLeft();
            int width[] = {5, 85};
            java.util.Collection col = home1.getConstatazioniSop(lCOD_SOP);
            java.util.Iterator it = col.iterator();
            tbl.setWidths(width);
            Alphabet c = new Alphabet();
            String REV2 = c.getNextElement("1");
            while (it.hasNext()) {
                jbConstatazione obj = (jbConstatazione) it.next();

                // Numerazione alfabetica
                Cell cell = new Cell(new Phrase(Formatter.format(REV2), REPORT_SETTINGS.ftText9B));
                cell.setVerticalAlignment(Element.ALIGN_TOP);
                tbl.addCell(cell);

                // Disposizione generata
                tbl.addCell(Formatter.format(obj.sDIS_GEN), defaultFontSize);
                REV2 = c.getNextElement(REV2);
            }
            m_document.add(tbl);
        }

        // FIRME
        // Spazio per le firme
        for (int i = 1; i <= 5; i++) {
            writeLine();
        }
        {
            CenterMiddleTable tbl = new CenterMiddleTable(2);
            int width[] = {50, 50};
            tbl.setWidths(width);
            tbl.setDefaultCellBorder(0);

            // Firme del personale dell'azienda
            Cell cell = new Cell(
                    new Phrase(ApplicationConfigurator.CUSTOMER_NAME.toUpperCase(),
                    REPORT_SETTINGS.ftText9));
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            tbl.addCell(cell);

            // Firme del personale delle imprese
            Cell cell2 = new Cell(
                    new Phrase(ApplicationConfigurator.LanguageManager.getString("Impresa").toUpperCase(),
                    REPORT_SETTINGS.ftText9));
            cell2.setHorizontalAlignment(Element.ALIGN_RIGHT);
            tbl.addCell(cell2);

            m_document.add(tbl);
        }

        // FOTO
        {
            Collection<jbMedia> listaFoto = home1.getMediaSOP(lCOD_SOP);
            if (listaFoto != null && listaFoto.size() > 0) {

                // STAMPA L'INDICE DELLE FOTO.
                boolean firstFoto = true;
                int fotoIndex = 0;
                for (jbMedia foto : listaFoto) {
                    try {
                        // Verifica che l'immagine sia in un formato supportato.
                        Image.getInstance(foto.mediaData);
                        fotoIndex++;
                        if (firstFoto) {
                            writePage();
                            writeTitle(ApplicationConfigurator.LanguageManager.getString("Indice.foto.allegate"));
                            firstFoto = false;
                        }
                        writeLine();
                        // Stampo il progessivo della foto, nel formato "Foto n".
                        writeText2Bold(ApplicationConfigurator.LanguageManager.getString("Foto") + " " + fotoIndex);
                        // Stampo il "nome" o se questo è assente, "il nome file".
                        writeText2(StringManager.isNotEmpty(foto.sNOM_MED) ? Formatter.format(foto.sNOM_MED) : Formatter.format(foto.sFile));
                        // Stampo, se presente, la "descrizione".
                        writeText2(StringManager.isNotEmpty(foto.sDES_MED) ? Formatter.format(foto.sDES_MED) : "");
                    } catch (Exception ex) {
                        // Eccezione silenziosa.
                        // Gestisce il caso in cui l'allegato non sia un immagine
                    }
                }
                // STAMPA LE FOTO.
                firstFoto = true;
                fotoIndex = 0;
                byte SPACE_FOR_TITLE = 20;
                byte SPACE_FOR_BOTTOM_MARGIN = 20;
                boolean strictImageSequence = m_writer.isStrictImageSequence();
                m_writer.setStrictImageSequence(true);
                for (jbMedia foto : listaFoto) {
                    Element image = prepareImage(m_document, foto.mediaData);
                    if (image != null) {
                        fotoIndex++;
                        if (firstFoto) {
                            writePage();
                            firstFoto = false;
                        }
                        if (m_document.getPageSize().getHeight() - m_document.topMargin() + 20 < getAvailablePageSpace(m_document, m_writer)) {
                            writeLine();
                        }
                        if (getAvailablePageSpace(m_document, m_writer)
                                - (SPACE_FOR_TITLE + SPACE_FOR_BOTTOM_MARGIN)
                                < ((Image) image).getScaledHeight()) {
                            writePage();
                        }
                        // Stampo il progessivo della foto, nel formato "Foto n".
                        writeText2(ApplicationConfigurator.LanguageManager.getString("Foto") + " " + fotoIndex);
                        // Stampo l'immagine.
                        m_document.add(image);
                    }
                }
                m_writer.setStrictImageSequence(strictImageSequence);
            }
        }
        // DOCUMENTI ALLEGATI
        Collection<DocumentiAssociati_Sopralluogo_View> listadocumenti = home1.getDocumentiCantiereSOP_STAMPA(lCOD_SOP);
        if (listadocumenti != null && listadocumenti.size() > 0) {

            // STAMPA L'INDICE DEI DOCUMENTI ALLEGATI
            // i documenti allegati sono quei documenti la cui tipologia risulta avere attivo
            //il flag di stampa in sopralluogo.
            boolean firstdocument = true;
            int documentIndex = 0;
            for (DocumentiAssociati_Sopralluogo_View documento : listadocumenti) {
                try {
                    // Verifica che l'immagine sia in un formato supportato.
                    documentIndex++;
                    if (firstdocument) {
                        writePage();
                        writeTitle(ApplicationConfigurator.LanguageManager.getString("Indice.documenti.allegati"));
                        firstdocument = false;
                    }
                    writeLine();
                    // Stampo il "titolo" del documento.
                    writeText3Bold(documentIndex + ")" + (StringManager.isNotEmpty(documento.TIT_DOC) ? Formatter.format(documento.TIT_DOC) : Formatter.format(documento.NOM_TPL_DOC)));
                    // Stampo, se presente, la "descrizione".
                    if(!(documento.DES).equals("")){
                    writeLine();}
                    writeText3_3(StringManager.isNotEmpty(documento.DES) ? Formatter.format(documento.DES) : "");

                    IAnagrDocumentoHome doc_home = (IAnagrDocumentoHome) PseudoContext.lookup("AnagrDocumentoBean");
                    AnagDocumentoFileInfo fileInfo = null;
                    AnagDocumentoFileInfo fileInfoLink = null;
                    fileInfo = doc_home.getFileInfoU("", documento.lCOD_DOC);
                    fileInfoLink = doc_home.getFileInfoULink("", documento.lCOD_DOC);

                    // se esiste stampo il file allegato
                    if (fileInfo != null) {
                        writeLine();
                        writeText3_3(Formatter.format("   " + "File Allegato:  " + fileInfo.strName));
                    } else {
                        writeLine();
                        writeText3_3(Formatter.format("   " + "File Allegato:  "));
                    }

                    // se esiste stampo il file link allegato
                    if (fileInfoLink != null) {
                        writeText3_3(Formatter.format("   " + "File Link Allegato:  " + fileInfoLink.strName));
                    } else {
                        writeText3_3(Formatter.format("   " + "File Link Allegato:  "));
                    }
                    writeLine();
                } catch (Exception ex) {
                    // Eccezione silenziosa.
                    // Gestisce il caso in cui l'allegato non sia un immagine
                }

            }
            writePage();
            // Stampa documenti allegati
            boolean endWithNewPage = false;
            endWithNewPage = StampaDocumenti(home1, bean.getCOD_SOP(), m_document, m_writer);

        }
        closeDocument();
    }
}
