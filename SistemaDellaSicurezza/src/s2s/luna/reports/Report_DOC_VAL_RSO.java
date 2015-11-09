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

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package s2s.luna.reports;

import com.apconsulting.luna.ejb.AnagrDocumento.IAnagrDocumento;
import com.apconsulting.luna.ejb.AnagrDocumento.IAnagrDocumentoHome;
import com.apconsulting.luna.ejb.AnagrLuoghiFisici.IAnagrLuoghiFisici;
import com.apconsulting.luna.ejb.AnagrLuoghiFisici.IAnagrLuoghiFisiciHome;
import com.apconsulting.luna.ejb.AttivitaLavorative.AttivitaLavorativePK;
import com.apconsulting.luna.ejb.AttivitaLavorative.IAttivitaLavorative;
import com.apconsulting.luna.ejb.AttivitaLavorative.IAttivitaLavorativeHome;
import com.apconsulting.luna.ejb.Azienda.IAzienda;
import com.apconsulting.luna.ejb.Azienda.IAziendaHome;
import com.apconsulting.luna.ejb.GestioneTabellare.CLN_View;
import com.apconsulting.luna.ejb.GestioneTabellare.GestioneTabellare_View;
import com.apconsulting.luna.ejb.GestioneTabellare.IGestioneTabellare;
import com.apconsulting.luna.ejb.GestioneTabellare.IGestioneTabellareHome;
import com.apconsulting.luna.ejb.GestioniSezioni.IGestioniSezioniHome;
import com.apconsulting.luna.ejb.GestioniSezioni.ReportGestioniSezioni_CplAre_View;
import com.apconsulting.luna.ejb.Immobili3lv.IImmobili3lv;
import com.apconsulting.luna.ejb.Immobili3lv.IImmobili3lvHome;
import com.apconsulting.luna.ejb.Macchina.IMacchina;
import com.apconsulting.luna.ejb.Macchina.IMacchinaHome;
import com.apconsulting.luna.ejb.Macchina.MacchinaPK;
import com.apconsulting.luna.ejb.MisuraPreventiva.IMisuraPreventiva;
import com.apconsulting.luna.ejb.MisuraPreventiva.IMisuraPreventivaHome;
import com.apconsulting.luna.ejb.MisuraPreventiva.MisuraPreventivaPK;
import com.apconsulting.luna.ejb.Paragrafo.IParagrafoHome;
import com.apconsulting.luna.ejb.Paragrafo.ParagrafoDocumentiByID_View;
import com.apconsulting.luna.ejb.Paragrafo.ReportParagrafi_byAreCpl_View;
import com.apconsulting.luna.ejb.Piano.IPiano;
import com.apconsulting.luna.ejb.Piano.IPianoHome;
import com.apconsulting.luna.ejb.Rischio.IRischio;
import com.apconsulting.luna.ejb.Rischio.IRischioHome;
import com.apconsulting.luna.ejb.Rischio.RischioPK;
import com.apconsulting.luna.ejb.RischioFattore.IRischioFattore;
import com.apconsulting.luna.ejb.RischioFattore.IRischioFattoreHome;
import com.apconsulting.luna.ejb.SchedeParagrafo.ISchedeParagrafoHome;
import com.apconsulting.luna.ejb.SchedeParagrafo.SchedeParagrafo_GetType_View;
import com.apconsulting.luna.ejb.SchedeParagrafo.TipoParagrafo;
import com.apconsulting.luna.ejb.UnitaOrganizzativa.IUnitaOrganizzativa;
import com.apconsulting.luna.ejb.UnitaOrganizzativa.IUnitaOrganizzativaHome;
import com.apconsulting.luna.ejb.UnitaSicurezza.IUnitaSicurezza;
import com.apconsulting.luna.ejb.UnitaSicurezza.IUnitaSicurezzaHome;
import com.apconsulting.luna.ejb.ValutazioneRischi.IValutazioneRischi;
import com.apconsulting.luna.ejb.ValutazioneRischi.IValutazioneRischiHome;
import com.apconsulting.luna.ejb.ValutazioneRischi.ValutazioneRischiAllegati;
import com.apconsulting.luna.ejb.ValutazioneRischi.ValutazioneRischiSezioniByID_View;
import com.lowagie.text.*;
import com.lowagie.text.pdf.PdfWriter;
import java.io.IOException;
import java.util.Collection;
import java.util.Iterator;
import s2s.ejb.pseudoejb.PseudoContext;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.conf.ModuleManager.MODULES;
import s2s.luna.util.SecurityWrapper;
import s2s.report.CenterMiddleTable;
import s2s.report.MiddleTable;
import s2s.report.Report;
import s2s.report.ZREPORT_SETTINGS;
import s2s.utils.plain.Formatter;
import s2s.utils.text.StringManager;

/**
 *
 * @author Dario Massaroni
 */
public class Report_DOC_VAL_RSO extends Report {

    public long lCOD_AZL = 0;
    public long lCOD_DOC_VLU = 0;
    long lCOD_UNI_ORG = 0;
    private int iIndexPageCount;
    ZREPORT_SETTINGS REPORT_SETTINGS = new ZREPORT_SETTINGS();

    public Report_DOC_VAL_RSO() {
    }
    Pair ROOT = new Pair();

    Pair addPair(String strName, Pair parent) {
        Pair p = new Pair();
        p.strName = strName;
        p.iPage = m_writer.getPageNumber();
        if (parent != null) {
            parent.Children.add(p);
        }
        return p;
    }

    public void writeIndex(Report report) throws Exception {
        ROOT.strName = "ROOT";

        CenterMiddleTable tbl = new CenterMiddleTable(4);
        int width[] = {5, 5, 80, 10};
        tbl.setWidths(width);
        tbl.toLeft();
        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Indice"), 4);
        tbl.setDefaultCellBorder(0);
        tbl.addCell("", 10, 4);
        tbl.setDefaultCellBorder(Rectangle.BOTTOM);
        writePair(tbl, ROOT, 0);
        report.m_document.add(tbl);
    }

    public void writePair(CenterMiddleTable tbl, Pair pair, int iLevel) throws Exception {
        if (iLevel != 0) {
            if (iLevel > 1) {
                Cell cell = new Cell();
                cell.setColspan(iLevel - 1);
                cell.setBorder(0);
                tbl.addCell(cell);
            }

            tbl.toLeft();
            tbl.addCell(pair.strName, 14 - ((iLevel - 1) * 2), 4 - iLevel);

            tbl.toRight();
            tbl.addCell((pair.iPage + iIndexPageCount) + "", 14 - ((iLevel - 1) * 2));
        }

        Iterator it = pair.Children.iterator();
        while (it.hasNext()) {
            Pair pp = (Pair) it.next();
            writePair(tbl, pp, iLevel + 1);
        }
    }

    public void reorderPages() throws DocumentException {
        int max = m_writer.reorderPages(null);
        int order[] = new int[max];
        int i;
        order[0] = 1;
        for (i = 1; i <= iIndexPageCount; i++) {
            order[i] = max - iIndexPageCount + i;
        }

        for (int l = i; l < max; l++) {
            order[l] = l - iIndexPageCount + 1;
        }
        m_writer.reorderPages(order);
    }

    public void calculateIndexPage(IValutazioneRischiHome home_vr, IValutazioneRischi bean_vr, IGestioniSezioniHome home_sez, IParagrafoHome home_prg) {
        Collection col_sez = home_vr.getValutazioneRischiSezioniByID_View(bean_vr.getCOD_DOC_VLU());
        Iterator it_sez = col_sez.iterator();

        // SCORRO LE SEZIONI - Inizio
        while (it_sez.hasNext()) {
            ValutazioneRischiSezioniByID_View sezione = (ValutazioneRischiSezioniByID_View) it_sez.next();

            Pair SECTION = addPair(sezione.NOM_RSP_DOC, ROOT);
            {
                // SCORRO I CAPITOLI - Inizio
                Collection col_cap = home_sez.getReportGestioniSezioni_CplAre_View(sezione.COD_ARE, lCOD_AZL);
                Iterator it_cap = col_cap.iterator();

                while (it_cap.hasNext()) {
                    ReportGestioniSezioni_CplAre_View capitolo = (ReportGestioniSezioni_CplAre_View) it_cap.next();
                    Pair CAPITOLO = addPair(capitolo.NOM_CPL, SECTION);
                    {
                        // SCORRO I PARAGRAFI - Inizio
                        Iterator it_prg = home_prg.getReportParagrafi_byAreCpl_View(sezione.COD_ARE, lCOD_AZL, capitolo.COD_CPL).iterator();
                        while (it_prg.hasNext()) {
                            ReportParagrafi_byAreCpl_View paragrafo = (ReportParagrafi_byAreCpl_View) it_prg.next();
                            addPair(paragrafo.NOM_PRG, CAPITOLO);
                        }
                        // SCORRO I PARAGRAFI - Fine
                    }
                }
                // SCORRO I CAPITOLI - Fine
            }
        }
        // SCORRO LE SEZIONI - Fine
        
        // Se abilitato da modulo aggiungo la parte degli allegati DVR.
        if (ApplicationConfigurator.isModuleEnabled(MODULES.DVR_ALLEGATI) == true &&
            home_vr.getAllegatiCount(lCOD_DOC_VLU) > 0){
                addPair("ALLEGATI", ROOT);
        }
    }

    @Override
    public void doReport() throws DocumentException, IOException, BadElementException, Exception {
        SecurityWrapper Security = SecurityWrapper.getInstance();

        lCOD_AZL = Security.getAziendaR();
        IAziendaHome home_az = (IAziendaHome) PseudoContext.lookup("AziendaBean");
        IAzienda bean_az = home_az.findByPrimaryKey(new Long(lCOD_AZL));

        IValutazioneRischiHome home_vr = (IValutazioneRischiHome) PseudoContext.lookup("ValutazioneRischiBean");
        IValutazioneRischi bean_vr = home_vr.findByPrimaryKey(new Long(lCOD_DOC_VLU));

        IGestioniSezioniHome home_sez = (IGestioniSezioniHome) PseudoContext.lookup("GestioniSezioniBean");
        IParagrafoHome home_prg = (IParagrafoHome) PseudoContext.lookup("ParagrafoBean");

        IGestioneTabellareHome home_tab = (IGestioneTabellareHome) PseudoContext.lookup("GestioneTabellareBean");
        ISchedeParagrafoHome home_sch = (ISchedeParagrafoHome) PseudoContext.lookup("SchedeParagrafoBean");

        lCOD_UNI_ORG = bean_vr.getCOD_UNI_ORG();
        String strAzienda = bean_az.getRAG_SCL_AZL();
        boolean isUniOrg = false;
        String strUniOrgName = "";

        if (lCOD_UNI_ORG != 0) {
            isUniOrg = true;
            IUnitaOrganizzativaHome home_uni = (IUnitaOrganizzativaHome) PseudoContext.lookup("UnitaOrganizzativaBean");
            IUnitaOrganizzativa bean_uni = home_uni.findByPrimaryKey(new Long(lCOD_UNI_ORG));
            strUniOrgName = bean_uni.getNOM_UNI_ORG();
        }

        initDocumentEx("the doc");
        setHeaders();
        m_writer.setLinearPageMode();
        m_handler.bShowHeader = false;
        m_handler.bShowDate = false;
        m_handler.strTopLeft = isUniOrg ? strUniOrgName : strAzienda;
        m_handler.strTopCenter = ApplicationConfigurator.LanguageManager.getString("Documento.di.valutazione.dei.rischi");

        String documentName = getDocumentName();
        if (StringManager.isNotEmpty(documentName)) {
            m_handler.strBottomLeft =
                    ApplicationConfigurator.LanguageManager.getString("Nome.documento")
                    + ": " + documentName + "\n"
                    + ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro")
                    + ": " + bean_az.getNOM_RSP_AZL();
        } else {
            m_handler.strBottomLeft =
                    ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro")
                    + ":\n" + bean_az.getNOM_RSP_AZL();
        }

        m_handler.strBottomRight = ApplicationConfigurator.LanguageManager.getString("Data.redazione")
                + ": " + Formatter.format(bean_vr.getDAT_DOC_VLU()) + "\n"
                + ApplicationConfigurator.LanguageManager.getString("Versione")
                + ":           " + Formatter.format(bean_vr.getVER_DOC());

        // Costruisce l'indice e lo scrive su un documento separato.
        calculateIndexPage(home_vr, bean_vr, home_sez, home_prg);
        Report reportIndex = new Report();
        reportIndex.initDocumentEx("the doc");
        reportIndex.m_handler = m_handler.copy();
        reportIndex.m_document.open();
        writeIndex(reportIndex);

        // Determina il numero di pagine occupate dall'indice.
        iIndexPageCount = reportIndex.m_writer.getPageNumber();

        // Nella numerazione delle pagine, 
        // tiene conto di quelle occupate dall'indice.
        m_handler.setIndexPageCount(iIndexPageCount);

        // Verifica se l'ultima pagina dell'indice e' pari o e' dispari
        ROOT.Children.clear();

        m_document.open();
        AddImage();

        writeTitle("\n" + 
                (ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_GSE)
                    ?ApplicationConfigurator.LanguageManager.getString("MSG_REP_0014")
                    :ApplicationConfigurator.LanguageManager.getString("MSG_REP_0007"))
                + "\n");

        writeBig(ApplicationConfigurator.LanguageManager.getString("(D.Lgs.626/94.art.4.comma.2)"));
        writeTitle("\n");

        if (isUniOrg) {
            Paragraph pr = new Paragraph(strUniOrgName, REPORT_SETTINGS.ftText16);
            pr.setAlignment(Element.ALIGN_CENTER);
            m_document.add(pr);
        }

        Paragraph pr = new Paragraph(bean_az.getRAG_SCL_AZL(), REPORT_SETTINGS.ftText18);
        pr.setAlignment(Element.ALIGN_CENTER);
        m_document.add(pr);

        pr = new Paragraph(bean_az.getCIT_AZL() + ", " + bean_az.getIDZ_AZL(), REPORT_SETTINGS.ftText3);
        pr.setAlignment(Element.ALIGN_CENTER);
        m_document.add(pr);

        m_handler.bShowHeader = true;

        // STAMPA SEZIONI - Inizio.
        Collection col_sez = home_vr.getValutazioneRischiSezioniByID_View(bean_vr.getCOD_DOC_VLU());
        Iterator it_sez = col_sez.iterator();
        {
            while (it_sez.hasNext()) {
                
                // Se la pagina precedente alla nuova sezione è dispari (fronte del foglio),
                // viene aggiunta una pagina bianca pari (retro del foglio) 
                // prima di proseguire con la stampa della sezione.
                // Questo, nella stampa fronte-retro, garantisce che la nuova sezione sia
                // sempre su pagina dispari (parte frontale del foglio).
                if ((m_writer.getPageNumber() + iIndexPageCount) % 2 == 1){
                    
                    // Questa regola non è applicata per GSE.
                    if (ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_GSE)==false){
                        writePage();                        
                    }
                }
                
                // Scrive ogni sezione su una nuova pagina
                writePage();
                
                boolean primoCapitoloDellaSezione = true;
                ValutazioneRischiSezioniByID_View sezione = (ValutazioneRischiSezioniByID_View) it_sez.next();
                Pair SECTION = addPair(sezione.NOM_RSP_DOC, ROOT);
                writeSezione(sezione.NOM_RSP_DOC);                
                {
                    // STAMPA CAPITOLI - Inizio.
                    Collection col_cap = home_sez.getReportGestioniSezioni_CplAre_View(sezione.COD_ARE, lCOD_AZL);
                    Iterator it_cap = col_cap.iterator();
                    while (it_cap.hasNext()) {
                        if (primoCapitoloDellaSezione)
                        {
                            writeLine();
                        } else 
                        {
                            writePage();
                        }
                        boolean primoParagrafoDelCapitolo = true;
                        ReportGestioniSezioni_CplAre_View capitolo = (ReportGestioniSezioni_CplAre_View) it_cap.next();
                        Pair CAPITOLO = addPair(capitolo.NOM_CPL, SECTION);
                        writeCapitolo(capitolo.NOM_CPL);
                        CenterMiddleTable tbl = new CenterMiddleTable(1);
                        tbl.BorderColor();
                        tbl.setDefaultHorizontalAlignment(Element.ALIGN_JUSTIFIED);
                        tbl.addCell2(Formatter.format(capitolo.DES_CPL_ARE));
                        m_document.add(tbl);
                        {
                            // STAMPA PARAGRAFI - Inizio.
                            Iterator it_prg = home_prg.getReportParagrafi_byAreCpl_View(sezione.COD_ARE, lCOD_AZL, capitolo.COD_CPL).iterator();
                            boolean endWithNewPage = false;
                            while (it_prg.hasNext()) {
                                if (primoParagrafoDelCapitolo && 
                                    StringManager.isEmpty(capitolo.DES_CPL_ARE)) 
                                {
                                    writeLine();
                                } else 
                                {
                                    writePage();
                                }
                                ReportParagrafi_byAreCpl_View paragrafo = (ReportParagrafi_byAreCpl_View) it_prg.next();
                                addPair(paragrafo.NOM_PRG, CAPITOLO);
                                writeParagrafo(Formatter.format(paragrafo.NOM_PRG));

                                if (StampaDescrizioneParagrafo(paragrafo) &&
                                    checkContenutoParagrafo(home_tab, home_prg, home_sch, paragrafo.COD_PRG))
                                {
                                    writePage();
                                }
                                // Stampa del tab "DOCUMENTI" - Inizio
                                {
                                    /* NB, il metodo stampa documenti torna true 
                                     * se la eventuale stampa dei documenti finisce
                                     * con una pagina nuova.
                                     */
                                    endWithNewPage = StampaDocumenti(home_prg, paragrafo.COD_PRG, m_document, m_writer);
                                }
                                // Stampa del tab "DOCUMENTI" - Fine
                                // Stampa del tab "TABELLE" - Inizio
                                {
                                    /* NB, il metodo stampa tabelle torna true
                                     * se ho stampato una o piu tabelle.
                                     */
                                    if (StampaTabelle(home_tab, paragrafo.COD_PRG, m_document) == true) {
                                        endWithNewPage = true;
                                    }
                                }
                                // Stampa schede - Inizio
                                {
                                    /* NB, il metodo stampa schede torna true
                                     * se ho stampato una o piu schede di paragrafo.
                                     */
                                    if (StampaSchede(bean_az, home_sch, paragrafo.COD_PRG, lCOD_AZL, endWithNewPage) == true) {
                                        endWithNewPage = false;
                                    }
                                }
                                // Stampa schede - Fine
                                primoParagrafoDelCapitolo = false;
                            }
                            // STAMPA PARAGRAFI - Fine.
                            if (it_cap.hasNext() && endWithNewPage == false) {
                                // Non eliminare, valutare se aggiungere uno writePage();
                            }
                        }
                        primoCapitoloDellaSezione = false;
                    }
                    // STAMPA CAPITOLI - Fine.
                }
            }
            // STAMPA SEZIONI - Fine.

            if (ApplicationConfigurator.isModuleEnabled(MODULES.DVR_ALLEGATI) == true) {
                // STAMPA TABELLA "DOCUMENTI ALLEGATI" - Inizio
                Collection<ValutazioneRischiAllegati> allegati_dvr_list;
                allegati_dvr_list = home_vr.getValutazioneRischiAllegati(lCOD_DOC_VLU);
                if (allegati_dvr_list != null && allegati_dvr_list.isEmpty() == false) {
                    writePage();
                    addPair("ALLEGATI", ROOT);
                    writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Documenti.allegati"));
                    {
                        CenterMiddleTable tbl = new CenterMiddleTable(1);
                        tbl.setDeafaultOffset();
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Titolo.del.documento"));
                        tbl.endHeaders();
                        tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                        for (ValutazioneRischiAllegati allegato : allegati_dvr_list) {
                            tbl.addCell(allegato.TIT_DOC);

                        }
                        m_document.add(tbl);
                    }
                }
                // STAMPA TABELLA "DOCUMENTI ALLEGATI" - Fine
            }
            // Scrive l'indice alla fine del documento.
            m_handler.startIndex();
            writePage();// 3 PAGE
            writeIndex(this);
            m_handler.endIndex();
            // Porta l'indice dopo la prima pagina.
            writePage();
            reorderPages();
            closeDocument();
        }
    }
    //verifico l'esistenza di informazioni(documenti,tabelle,schede) legate al paragrafo senza stamparle
    //il metodo torna true se ho informazioni altrimenti torna false

    private boolean checkContenutoParagrafo(
            IGestioneTabellareHome home_tab, IParagrafoHome home_prg, ISchedeParagrafoHome home,
            long lCOD_PRG) {
        if ( // Verifico che ci siano tabelle da stampare.
                home_tab.getGestioneTabellare_View(lCOD_PRG).iterator().hasNext()
                || // Verifico che ci siano dei documenti da stampare.
                home_prg.getParagrafoDocumentiByID_View(lCOD_PRG).iterator().hasNext()
                || // Verifico che ci siano delle schede paragrafo da stampare.
                home.getSchedeParagrafo_GetType_View_BASE(lCOD_PRG, lCOD_UNI_ORG).iterator().hasNext()) {
            return true;
        }
        return false;
    }

    private boolean StampaDescrizioneParagrafo(ReportParagrafi_byAreCpl_View paragrafo) throws Exception {
        ISchedeParagrafoHome home_sch = (ISchedeParagrafoHome) PseudoContext.lookup("SchedeParagrafoBean");

        writeLine();
        if (StringManager.isNotEmpty(paragrafo.DES_PRG)) {
            writeText2Justified(Formatter.format(paragrafo.DES_PRG));
            writeLine();
        }

        Collection<SchedeParagrafo_GetType_View> listaSchedeDescr =
                home_sch.getSchedeParagrafo_GetType_View_DESC(paragrafo.COD_PRG, lCOD_UNI_ORG);
        for (SchedeParagrafo_GetType_View schedaParagrafo : listaSchedeDescr) {
            if (schedaParagrafo.TPL_SCH.equals(TipoParagrafo.DESCRIZIONI_ATTIVITA_LAVORATIVA.getType())) {
                IAttivitaLavorativeHome home_man = (IAttivitaLavorativeHome) PseudoContext.lookup("AttivitaLavorativeBean");
                IAttivitaLavorative bean_man = home_man.findByPrimaryKey(new AttivitaLavorativePK(lCOD_AZL, schedaParagrafo.COD_MAN));
                writeText2BoldAndIndent(Formatter.format(bean_man.getNOM_MAN()), schedaParagrafo.STL_IND);
                writeText2JustifiedAndIndent(Formatter.format(bean_man.getDES_MAN()), schedaParagrafo.STL_IND);
                writeLine();
            } else if (schedaParagrafo.TPL_SCH.equals(TipoParagrafo.DESCRIZIONI_IMMOBILI.getType())) {
                IImmobili3lvHome home_imm_3lv = (IImmobili3lvHome) PseudoContext.lookup("Immobili3lvBean");
                IImmobili3lv bean_imm_3lv = home_imm_3lv.findByPrimaryKey(schedaParagrafo.COD_IMM_3LV);
                writeText2BoldAndIndent(Formatter.format(bean_imm_3lv.getNOM_IMM()), schedaParagrafo.STL_IND);
                writeText2JustifiedAndIndent(Formatter.format(bean_imm_3lv.getDES_IMM()), schedaParagrafo.STL_IND);
                writeLine();
            } else if (schedaParagrafo.TPL_SCH.equals(TipoParagrafo.DESCRIZIONI_PIANI.getType())) {
                IPianoHome home_pno = (IPianoHome) PseudoContext.lookup("PianoBean");
                IPiano bean_pno = home_pno.findByPrimaryKey(schedaParagrafo.COD_PNO);
                writeText2BoldAndIndent(Formatter.format(bean_pno.getNOM_PNO()), schedaParagrafo.STL_IND);
                writeText2JustifiedAndIndent(Formatter.format(bean_pno.getDES_PNO()), schedaParagrafo.STL_IND);
                writeLine();
            } else if (schedaParagrafo.TPL_SCH.equals(TipoParagrafo.DESCRIZIONI_LUOGO_FISICO.getType())) {
                IAnagrLuoghiFisiciHome home_luo_fsc = (IAnagrLuoghiFisiciHome) PseudoContext.lookup("AnagrLuoghiFisiciBean");
                IAnagrLuoghiFisici bean_luo_fsc = home_luo_fsc.findByPrimaryKey(schedaParagrafo.COD_LUO_FSC);
                writeText2BoldAndIndent(Formatter.format(bean_luo_fsc.getNOM_LUO_FSC()), schedaParagrafo.STL_IND);
                writeText2JustifiedAndIndent(Formatter.format(bean_luo_fsc.getDES_LUO_FSC()), schedaParagrafo.STL_IND);
                writeLine();
            } else if (schedaParagrafo.TPL_SCH.equals(TipoParagrafo.DESCRIZIONI_MACCHINA_ATTREZZATURA.getType())) {
                IMacchinaHome home_mac = (IMacchinaHome) PseudoContext.lookup("MacchinaBean");
                IMacchina bean_mac = home_mac.findByPrimaryKey(new MacchinaPK(lCOD_AZL, schedaParagrafo.COD_MAC));
                writeText2BoldAndIndent(Formatter.format(bean_mac.getMDL_MAC()), schedaParagrafo.STL_IND);
                writeText2JustifiedAndIndent(Formatter.format(bean_mac.getDES_MAC()), schedaParagrafo.STL_IND);
                writeLine();
            } else if (schedaParagrafo.TPL_SCH.equals(TipoParagrafo.DESCRIZIONI_RISCHI.getType())) {
                IRischioHome home_rso = (IRischioHome) PseudoContext.lookup("RischioBean");
                IRischioFattoreHome home_fat_rso = (IRischioFattoreHome) PseudoContext.lookup("RischioFattoreBean");
                IRischio bean_rso = home_rso.findByPrimaryKey(new RischioPK(lCOD_AZL, schedaParagrafo.COD_RSO));
                IRischioFattore bean_fat_rso = home_fat_rso.findByPrimaryKey(bean_rso.getCOD_FAT_RSO());
                writeText2BoldAndIndent(Formatter.format(bean_fat_rso.getNOM_FAT_RSO() + " - " + bean_rso.getNOM_RSO()), schedaParagrafo.STL_IND);
                writeText2JustifiedAndIndent(Formatter.format(bean_rso.getDES_RSO()), schedaParagrafo.STL_IND);
                writeLine();
            } else if (schedaParagrafo.TPL_SCH.equals(TipoParagrafo.DESCRIZIONI_MISURA_PP.getType())) {
                IMisuraPreventivaHome home_mis_pet = (IMisuraPreventivaHome) PseudoContext.lookup("MisuraPreventivaBean");
                IMisuraPreventiva bean_mis_pet = home_mis_pet.findByPrimaryKey(new MisuraPreventivaPK(lCOD_AZL, schedaParagrafo.COD_MIS_PET));
                writeText2BoldAndIndent(Formatter.format(bean_mis_pet.getNOM_MIS_PET()), schedaParagrafo.STL_IND);
                writeText2JustifiedAndIndent(Formatter.format(bean_mis_pet.getDES_MIS_PET()), schedaParagrafo.STL_IND);
                writeLine();
            } else if (schedaParagrafo.TPL_SCH.equals(TipoParagrafo.DESCRIZIONI_UNITA_ORGANIZZATIVA.getType())) {
                IUnitaOrganizzativaHome home_uni_org = (IUnitaOrganizzativaHome) PseudoContext.lookup("UnitaOrganizzativaBean");
                IUnitaOrganizzativa bean_uni_org = home_uni_org.findByPrimaryKey(schedaParagrafo.COD_UNI_ORG);
                writeText2BoldAndIndent(Formatter.format(bean_uni_org.getNOM_UNI_ORG()), schedaParagrafo.STL_IND);
                writeText2JustifiedAndIndent(Formatter.format(bean_uni_org.getDES_UNI_ORG()), schedaParagrafo.STL_IND);
                writeLine();
            } else if (schedaParagrafo.TPL_SCH.equals(TipoParagrafo.DESCRIZIONI_UNITA_SICUREZZA.getType())) {
                IUnitaSicurezzaHome home_uni_sic = (IUnitaSicurezzaHome) PseudoContext.lookup("UnitaSicurezzaBean");
                IUnitaSicurezza bean_uni_sic = home_uni_sic.findByPrimaryKey(schedaParagrafo.COD_UNI_SIC);
                writeText2BoldAndIndent(Formatter.format(bean_uni_sic.getNOM_UNI_SIC()), schedaParagrafo.STL_IND);
                writeText2JustifiedAndIndent(Formatter.format(bean_uni_sic.getDES_UNI_SIC()), schedaParagrafo.STL_IND);
                writeLine();
            }
        }
        return 
                StringManager.isNotEmpty(paragrafo.DES_PRG) ||
                listaSchedeDescr.size() > 0;
    }

    private boolean StampaSchede(IAzienda bean_az, ISchedeParagrafoHome home_sch,
            long lCOD_PRG, long lCOD_AZL, boolean startWithNewPage) throws Exception {
        boolean buildSchede = false;
        if (BuildSchede(bean_az, home_sch, lCOD_PRG, lCOD_AZL,
                TipoParagrafo.ANAGRAFICA_AZIENDA.getType(), startWithNewPage)) {
            buildSchede = true;
        }
        if (BuildSchede(bean_az, home_sch, lCOD_PRG, lCOD_AZL,
                TipoParagrafo.VALUTAZIONE_RISCHIO.getType(), startWithNewPage)) {
            buildSchede = true;
        }
        if (BuildSchede(bean_az, home_sch, lCOD_PRG, lCOD_AZL,
                TipoParagrafo.SCHEDA_RISCHI.getType(), startWithNewPage)) {
            buildSchede = true;
        }
        if (BuildSchede(bean_az, home_sch, lCOD_PRG, lCOD_AZL,
                TipoParagrafo.MACCHINA_ATTREZZATURA.getType(), startWithNewPage)) {
            buildSchede = true;
        }
        if (BuildSchede(bean_az, home_sch, lCOD_PRG, lCOD_AZL,
                TipoParagrafo.UNITA_ORGANIZZATIVA.getType(), startWithNewPage)) {
            buildSchede = true;
        }
        if (BuildSchede(bean_az, home_sch, lCOD_PRG, lCOD_AZL,
                TipoParagrafo.UNITA_SICUREZZA.getType(), startWithNewPage)) {
            buildSchede = true;
        }
        if (BuildSchede(bean_az, home_sch, lCOD_PRG, lCOD_AZL,
                TipoParagrafo.SOSTANZA_CHIMICA.getType(), startWithNewPage)) {
            buildSchede = true;
        }
        if (BuildSchede(bean_az, home_sch, lCOD_PRG, lCOD_AZL,
                TipoParagrafo.ATTIVITA_LAVORATIVA.getType(), startWithNewPage)) {
            buildSchede = true;
        }
        if (BuildSchede(bean_az, home_sch, lCOD_PRG, lCOD_AZL,
                TipoParagrafo.LUOGO_FISICO.getType(), startWithNewPage)) {
            buildSchede = true;
        }
        if (BuildSchede(bean_az, home_sch, lCOD_PRG, lCOD_AZL,
                TipoParagrafo.FATTORE_DI_RISCHIO.getType(), startWithNewPage)) {
            buildSchede = true;
        }
        return buildSchede;
    }

    public boolean StampaDocumenti(IParagrafoHome home_prg, long lCOD_PRG,
            Document document, PdfWriter writer) throws Exception {

        /* NB, il metodo stampa documenti torna true non se ho stampato i documenti
         * ma se la evantuale stampa dei documenti finisce con una pagina nuova o meno.
         */

        boolean endWithNewPage = false;

        // Estraggo i documenti legati al paragrafo
        Collection prg_doc_list = home_prg.getParagrafoDocumentiByID_View(lCOD_PRG);
        // ... se ne trovo...
        if (prg_doc_list != null && !prg_doc_list.isEmpty()) {
            writeLine();
            writeBig(ApplicationConfigurator.LanguageManager.getString("Documenti.allegati"));
            writeLine();
            Iterator it_prg_doc = prg_doc_list.iterator();
            int i = 0;
            while (it_prg_doc.hasNext()) {
                ParagrafoDocumentiByID_View prg_doc = (ParagrafoDocumentiByID_View) it_prg_doc.next();
                if (i > 0) {
                    writePage();
                }
                // Stampo i file allegati al documento
                /* NB, il metodo stampa documento torna true non se ho stampato un
                 * documento ma se ho stampato gli allegati di tale documento.
                 * Solo in questo caso infatti, è necessario andare a pagina nuova.
                 */
                if (StampaDocumento(prg_doc.COD_DOC, document, writer)) {
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

    private boolean StampaTabelle(IGestioneTabellareHome home_tab, long lCOD_PRG, Document document) throws Exception {
        boolean stampateTabelle = false;
        Iterator it_tab = home_tab.getGestioneTabellare_View(lCOD_PRG).iterator();
        while (it_tab.hasNext()) {
            IParagrafoHome home_prg = (IParagrafoHome) PseudoContext.lookup("ParagrafoBean");
            if (home_prg.getParagrafoDocumentiByID_View(lCOD_PRG).iterator().hasNext()) {
                writePage();
            }
            GestioneTabellare_View tabella = (GestioneTabellare_View) it_tab.next();
            {
                IGestioneTabellare bean_tab = home_tab.findByPrimaryKey(new Long(tabella.COD_TAB_UTN));
                int lColumns = (int) bean_tab.getNUM_CLN();

                MiddleTable tb = new MiddleTable(lColumns, true);
                tb.toCenter();
                tb.addHeaderCellB(bean_tab.getTIT_TAB(), lColumns);
                tb.toLeft();
                {
                    if (lColumns > 0) {
                        tb.addHeaderCell(bean_tab.getNOM_TIT_1());
                    }
                    if (lColumns > 1) {
                        tb.addHeaderCell(bean_tab.getNOM_TIT_2());
                    }
                    if (lColumns > 2) {
                        tb.addHeaderCell(bean_tab.getNOM_TIT_3());
                    }
                    if (lColumns > 3) {
                        tb.addHeaderCell(bean_tab.getNOM_TIT_4());
                    }
                    if (lColumns > 4) {
                        tb.addHeaderCell(bean_tab.getNOM_TIT_5());
                    }
                }
                tb.endHeaders();
                Iterator it_cols = home_tab.getCLN_View(tabella.COD_TAB_UTN).iterator();

                while (it_cols.hasNext()) {
                    CLN_View wcol = (CLN_View) it_cols.next();
                    if (lColumns > 0) {
                        tb.addCell(wcol.NOM_CLN_1);
                    }
                    if (lColumns > 1) {
                        tb.addCell(wcol.NOM_CLN_2);
                    }
                    if (lColumns > 2) {
                        tb.addCell(wcol.NOM_CLN_3);
                    }
                    if (lColumns > 3) {
                        tb.addCell(wcol.NOM_CLN_4);
                    }
                    if (lColumns > 4) {
                        tb.addCell(wcol.NOM_CLN_5);
                    }
                }
                tb.setOffset(32);
                document.add(tb);
                stampateTabelle = true;
            }
        }
        return stampateTabelle;
    }

    public boolean StampaDocumento(Long lCOD_DOC, Document document, PdfWriter writer) throws Exception {
        IAnagrDocumentoHome doc_home = (IAnagrDocumentoHome) PseudoContext.lookup("AnagrDocumentoBean");
        IAnagrDocumento doc_bean = null;

        // NB, il metodo stampa documento torna true non se ho stampato un
        // documento ma se ho stampato gli allegati di tale documento.

        // Se stò trattando un documento valido...
        if (lCOD_DOC != null && lCOD_DOC.compareTo(new Long(0)) > 0) {

            // Estraggo il documento al quale sono allegati i file.
            doc_bean = doc_home.findByPrimaryKey(lCOD_DOC);

            // Se trovo il documento...
            if (doc_bean != null) {

                // Scrivo le informazioni di base del documento (Titolo e data)
                CenterMiddleTable tbl = new CenterMiddleTable(2);
                int width[] = {70, 30};
                tbl.setWidths(width);
                tbl.toLeft();
                tbl.addHeaderCell(ApplicationConfigurator.LanguageManager.getString("Informazioni.sul.documento"), 2);
                tbl.addCell(Formatter.format(doc_bean.getTIT_DOC()));
                tbl.addCell(Formatter.format(doc_bean.getDAT_REV_DOC()));
                m_document.add(tbl);

                boolean printedFiles = false;
                Stampa_documento stampa_documento = new Stampa_documento();
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

    private boolean BuildSchede(IAzienda bean_az, ISchedeParagrafoHome home,
            long lCOD_PRG, long lCOD_AZL, String strType, boolean startWithNewPage) throws Exception {
        String TYPE = "";
        long lCOD_MAC = 0;
        long lCOD_UNI_ORG = 0;
        long lCOD_UNI_SIC = 0;
        long lCOD_SOS_CHI = 0;
        long lCOD_MAN = 0;
        long lCOD_LUO_FSC = 0;
        long lCOD_FAT_RSO = 0;
        java.util.Collection col = home.getReportSchedeParagrafo_GetType_View(lCOD_PRG, strType, this.lCOD_UNI_ORG);
        java.util.Iterator it = col.iterator();
        SchedeParagrafo_GetType_View obj = null;
        Report report;
        boolean BuildSchede = false;
        int i = 0;
        while (it.hasNext()) {
            if (i > 0 || (i == 0 && startWithNewPage)) {
                writePage();
            }
            report = null;
            obj = (SchedeParagrafo_GetType_View) it.next();
            TYPE = obj.TPL_SCH;
            lCOD_MAC = obj.COD_MAC;
            lCOD_UNI_ORG = obj.COD_UNI_ORG;
            lCOD_UNI_SIC = obj.COD_UNI_SIC;
            lCOD_SOS_CHI = obj.COD_SOS_CHI;
            lCOD_MAN = obj.COD_MAN;
            lCOD_LUO_FSC = obj.COD_LUO_FSC;
            lCOD_FAT_RSO = obj.COD_FAT_RSO;

            if (TYPE.equals(TipoParagrafo.MACCHINA_ATTREZZATURA.getType())) {
                Report_REP_MAC_ATT rpt = new Report_REP_MAC_ATT(lCOD_MAC, false);
                report = rpt;
            }
            if (TYPE.equals(TipoParagrafo.UNITA_ORGANIZZATIVA.getType())) {
                Report_UNI_ORG rpt = new Report_UNI_ORG(false);
                rpt.lCOD_UNI_ORG = lCOD_UNI_ORG;
                report = rpt;
            }
            if (TYPE.equals(TipoParagrafo.UNITA_SICUREZZA.getType())) {
                Report_REP_ANA_UNI_SIC rpt = new Report_REP_ANA_UNI_SIC(false);
                rpt.lCOD_UNI_SIC = lCOD_UNI_SIC;
                report = rpt;
            }
            if (TYPE.equals(TipoParagrafo.SOSTANZA_CHIMICA.getType())) {
                Report_REP_SOS_CHI rpt = new Report_REP_SOS_CHI(lCOD_SOS_CHI, false);
                report = rpt;
            }
            if (TYPE.equals(TipoParagrafo.ATTIVITA_LAVORATIVA.getType())) {
                Report_REP_MAN rpt = new Report_REP_MAN(lCOD_MAN, lCOD_AZL, false);
                report = rpt;
            }
            if (TYPE.equals(TipoParagrafo.LUOGO_FISICO.getType())) {
                Report_REP_LUO_FSC rpt = new Report_REP_LUO_FSC(lCOD_LUO_FSC, false);
                report = rpt;
            }
            if (TYPE.equals(TipoParagrafo.FATTORE_DI_RISCHIO.getType())) {
                Report_REP_FAT_RSO rpt = new Report_REP_FAT_RSO(lCOD_FAT_RSO, false);
                report = rpt;
            }
            if (TYPE.equals(TipoParagrafo.ANAGRAFICA_AZIENDA.getType())) {
                Report rpt = ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_GSE)
                        ? new Report_REP_AZL_GSE(lCOD_AZL, false)
                        : new Report_REP_AZL(lCOD_AZL, false);
                report = rpt;
            }
            if (TYPE.equals(TipoParagrafo.VALUTAZIONE_RISCHIO.getType())) {
                Report_REP_VAL_RSO_DVR rpt = new Report_REP_VAL_RSO_DVR(lCOD_AZL);
                report = rpt;
            }
            if (TYPE.equals(TipoParagrafo.SCHEDA_RISCHI.getType())) {
                /* Questo report non è più utilizzato, valutare se eliminarlo
                 * Report_REP_SCH_RSO_DVR rpt = new Report_REP_SCH_RSO_DVR(lCOD_AZL); */
                Report_REP_SCH_RSO_NEW_DVR rpt = new Report_REP_SCH_RSO_NEW_DVR(lCOD_AZL);
                report = rpt;
            }
            if (report != null) {
                writeLine();
                report.doReport(m_out, m_document);
                BuildSchede = true;
            }
            i = i + 1;
        }
        return BuildSchede;
    }
}
