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

import com.apconsulting.luna.ejb.AnagrDocumento.AnagDocumentoFileInfo;
import com.apconsulting.luna.ejb.AnagrDocumento.IAnagrDocumentoHome;
import com.lowagie.text.Cell;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Image;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfImportedPage;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfWriter;
import s2s.ejb.pseudoejb.PseudoContext;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.report.CenterMiddleTable;
import s2s.report.Report;

/**
 *
 * @author Alessandro
 */
public class Stampa_documento extends Report {

    public enum TIPO_ALLEGATO {

        FILE, FILE_LINK
    };

    private enum FORMATI_SUPPORTATI {

        BMP, GIF, JPEG, JPG, PNG, TIFF, TIF, WMF, // Formati immagine
        PDF;                                        // Altri formati

        public String getName() {
            switch (this) {
                // Formati immagine
                case BMP:
                    return "bmp";
                case GIF:
                    return "gif";
                case JPEG:
                    return "pjpeg";
                case JPG:
                    return "pjpeg";
                case PNG:
                    return "x-png";
                case TIFF:
                    return "tiff";
                case TIF:
                    return "tiff";
                case WMF:
                    return "x-wmf";
                // Altri formati
                case PDF:
                    return "pdf";
            }
            return null;
        }
    }

    private FORMATI_SUPPORTATI checkSupportedFormat(String docFormat) {
        docFormat = docFormat.substring(docFormat.lastIndexOf("/") + 1);
        if (docFormat != null && docFormat.equals("") == false) {
            docFormat = docFormat.toLowerCase();
            for (FORMATI_SUPPORTATI formato : FORMATI_SUPPORTATI.values()) {
                if (formato.getName().equals(docFormat)) {
                    return formato;
                }
            }
        }
        return null;
    }

    // metodo che verifica l'esistenza di allegati
    public boolean checkAllegati(long lCOD_DOC) throws Exception {
        IAnagrDocumentoHome doc_home = (IAnagrDocumentoHome) PseudoContext.lookup("AnagrDocumentoBean");
        return
            doc_home.getFileInfoU("", lCOD_DOC) != null ||
            doc_home.getFileInfoULink("", lCOD_DOC) != null;
    }


    public boolean StampaAllegato(long lCOD_DOC,
            Stampa_documento.TIPO_ALLEGATO tipoAllegato,
            Document document,
            PdfWriter writer) throws Exception {
        AnagDocumentoFileInfo fileInfo = null;
        IAnagrDocumentoHome doc_home = (IAnagrDocumentoHome) PseudoContext.lookup("AnagrDocumentoBean");
        String Titolo = null;
        // Estraggo le informazioni sull'allegato.
        switch (tipoAllegato) {
            case FILE:
                fileInfo = doc_home.getFileInfoU("", lCOD_DOC);
                Titolo = ApplicationConfigurator.LanguageManager.getString("Allegato.1.File");
                break;
            case FILE_LINK:
                fileInfo = doc_home.getFileInfoULink("", lCOD_DOC);
                Titolo = ApplicationConfigurator.LanguageManager.getString("Allegato.2.File.link");
                break;
        }
        // Se ottengo delle informazioni valide...
        if (fileInfo != null
                && fileInfo.strContentType != null
                && fileInfo.strContentType.equals("") == false) {
            // Verifico che l'allegato sia in uno dei formati supportati.
            Stampa_documento.FORMATI_SUPPORTATI formatoFile = checkSupportedFormat(fileInfo.strContentType);
            // Se il formato è supportato...
            if (formatoFile != null) {
                byte[] fileContent = null;
                // Carico l'allegato sotto forma di array di byte.
                switch (tipoAllegato) {
                    case FILE:
                        fileContent = doc_home.downloadFileU("", lCOD_DOC);
                        break;
                    case FILE_LINK:
                        fileContent = doc_home.downloadFileULink("", lCOD_DOC);
                        break;
                }
                // Se il contenuto del file è valido...
                if (fileContent != null && fileContent.length > 0) {
                    // Avvio la relativa operazione di import dell'allegato nel Sopralluogo.
                    switch (formatoFile) {
                        // Formati immagine
                        case BMP:
                        case GIF:
                        case JPEG:
                        case JPG:
                        case PNG:
                        case TIFF:
                        case TIF:
                        case WMF:
                            Element Allegato = prepareImage(document, fileContent);

                            // Se sono riuscito a costruire correttamente l'allegato...
                            if (Allegato != null) {
                                // lo includo nel Sopralluogo.
                                CenterMiddleTable tbl = new CenterMiddleTable(1);
                                int width[] = {100};
                                tbl.setWidths(width);
                                tbl.toLeft();
                                tbl.setDefaultCellBorder(Rectangle.NO_BORDER);
                                tbl.addCell(new Cell(Allegato));
                                document.add(tbl);
                                return true;
                            }
                            break;
                        // Altri formati
                        case PDF:
                            if (addPDF(Titolo, fileContent, document, writer)) {
                                return true;
                            }
                            break;
                    }
                } else {
                    CenterMiddleTable tbl = new CenterMiddleTable(1);
                    int width[] = {100};
                    tbl.setWidths(width);
                    tbl.toLeft();
                    tbl.setDefaultCellBorder(Rectangle.NO_BORDER);
                    tbl.addCell(
                            ApplicationConfigurator.LanguageManager.getString("File.not.found") + " \"" + fileInfo.strLinkDocument + fileInfo.strName + "\"");
                    document.add(tbl);
                }
            }
        }
        return false;
    }

    @SuppressWarnings("CallToThreadDumpStack")
    private boolean addPDF(String titolo, byte[] fileContent,
            Document document, PdfWriter writer) {
        try {
            // Inizializzo il contenitore del pdf da importare.
            PdfContentByte cb = writer.getDirectContent();

            // Inizializzo la variabile dove appoggerò (una alla volta)
            // le pagine del pdf da importare.
            PdfImportedPage page;

            // Apro in lettura il pdf da importare.
            PdfReader pdfReader = new PdfReader(fileContent);

            // Ne determino il numero di pagine totali.
            int pdfPageNumber = pdfReader.getNumberOfPages();

            // Inzializzo il contatore delle pagine.
            int pageOfCurrentReaderPDF = 1;

            // Per ogni pagina...
            while (pageOfCurrentReaderPDF <= pdfPageNumber) {
                // Creo una nuova pagina vuota sul pdf di destinazione.
                document.newPage();
                // Estraggo la pagina dal pdf da importare.
                page = writer.getImportedPage(pdfReader, pageOfCurrentReaderPDF);
                // Coverto la pagina in un immagine.
                Image pageImg = Image.getInstance(page);
                // Aggiungo la pagina estratta al pdf di destinazione, ruotandola se necessario.
                PdfPTable table = new PdfPTable(1);
                PdfPCell defaultCell = table.getDefaultCell();
                defaultCell.setRotation(-pdfReader.getPageRotation(pageOfCurrentReaderPDF));
                defaultCell.setBorder(Rectangle.NO_BORDER);
                table.addCell(pageImg);
                document.add(table);
                // Incremento il contatore delle pagine
                pageOfCurrentReaderPDF++;  
            }
            return true;
        } catch (Exception ex) {
            // Eccezione silenziosa.
            // Gestisce il caso in cui si verifica un errore non previsto
            ex.printStackTrace();
            return false;
        }
    }
}
