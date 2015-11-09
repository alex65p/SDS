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
package s2s.report;

import com.lowagie.text.BadElementException;
import com.lowagie.text.Cell;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.util.SecurityWrapper;

/**
 *
 * @author Dario
 */
public class Report extends HttpServlet {

    public boolean bStandAlone = true;
    public boolean bRotate = false;
    public long lCOD_AZL = 0;
    public HttpServletRequest request;
    public HttpServletResponse response;
    public PdfWriter m_writer;
    public ByteArrayOutputStream m_out;
    public Document m_document;
    public MyPageEvents m_handler;
    private ZREPORT_SETTINGS REPORT_SETTINGS = new ZREPORT_SETTINGS();
    
    protected final String DATI_NON_PRESENTI =
            ApplicationConfigurator.LanguageManager.getString("Dati.non.previsti");
    protected final String EMPTY_STRING = "\u2205";
    private String documentName = "";

    public String getDocumentName(){
        return documentName;
    }

    public float getAvailablePageSpace(Document doc, PdfWriter writer){
        // Determina lo spazio ancora disponibile, in verticale, sulla pagina corrente.
        // Il metodo va chiamato preferibilmente a documento aperto.
        // Al contrario sembra riportare un valore errato.
        
        // Tiene automaticamente anche conto degli evenatuali margini (superiore ed inferiore) 
        // impostati per il documento, sottraendoli allo spazio disponibile
        return writer.getVerticalPosition(true);
    }
    
    public Element prepareImage(Document doc, byte[] fileContent) {
        return prepareImage(doc, fileContent, true, 10);
    }

    public Element prepareImage(Document doc, byte[] fileContent, boolean marginConsider, float distanceFromBottomMargin) {
        try {
            Image img = Image.getInstance(fileContent);

            // Detemino le dimensioni della pagina, margini esclusi.
            float pageWidth =
                    doc.getPageSize().getWidth()
                    - (marginConsider ? doc.leftMargin() + doc.topMargin() : 0);
            float pageHeight =
                    doc.getPageSize().getHeight()
                    - (marginConsider ? doc.topMargin() + doc.bottomMargin() : 0)
                    - (distanceFromBottomMargin > 0 ? distanceFromBottomMargin : 0);

            // Se l'immagine è più larga e/o più alta della pagina, 
            // esclusi i margini...
            if (img.getWidth() > pageWidth || img.getHeight() > pageHeight) {

                // Determino le percentuali di riduzione di entrambi le grandezze 
                // dell'immagine (larghezza ed altezza).
                float reducePrecentWidth = (img.getWidth() - pageWidth) > 0
                        ?(pageWidth * 100) / img.getWidth()
                        :100;
                float reducePrecentHeight = (img.getHeight() - pageHeight) > 0
                        ?(pageHeight * 100) / img.getHeight()
                        :100;

                // Determino la percentuale di riduzione
                float ReducePrecent = reducePrecentWidth;
                ReducePrecent = reducePrecentHeight < ReducePrecent 
                        ? reducePrecentHeight 
                        : ReducePrecent;

                img.scalePercent(ReducePrecent);
            }
            return img;
        } catch (Exception ex) {
            // Eccezione silenziosa.
            // Gestisce il caso in cui l'allegato non sia un immagine
            ex.printStackTrace();
            return null;
        }
    }
    
    public void AddImage() throws Exception {
        if (ApplicationConfigurator.VIEW_REPORT_IMAGE == true) {
            //carica immagine logo
            writeTitle("\n");
            Image png = loadImage("LOGO");
            png.setAlignment(Image.MIDDLE);
            m_document.add(png);
            writeTitle("\n");
        }
    }
    
    public void AddScaledImage(float percentScale) throws Exception {
        if (ApplicationConfigurator.VIEW_REPORT_IMAGE == true) {
            //carica immagine logo
            writeTitle("\n");
            Image png = loadImage("LOGO");
            png.scalePercent(percentScale);
            png.setAlignment(Image.MIDDLE);
            m_document.add(png);
            writeTitle("\n");
        }
    }

    public Image loadImage(String strName) throws Exception {

        SecurityWrapper Security = SecurityWrapper.getInstance();
        String strPath = request.getServletPath();
        String strRealPath = request.getRealPath(strPath);

        strPath = Security.Replace(strPath, "/", File.separator);
        strRealPath = Security.Replace(strRealPath, strPath, "") + Security.Replace("/WEB/_images/report/", "/", File.separator);

        if (strName.equals("LOGO")) {
            return Image.getInstance(strRealPath + "626.gif");
        }
        return null;
    }

    public void writeSezione(String strName) throws BadElementException, DocumentException {
        CenterMiddleTable tbl = new CenterMiddleTable(1);
        tbl.toLeft();
        tbl.addHeaderCellB(strName, 1, true, 16);
        m_document.add(tbl);
    }

    public void writeCapitolo(String strName) throws BadElementException, DocumentException {
        CenterMiddleTable tbl = new CenterMiddleTable(1);
        tbl.toLeft();
        tbl.addHeaderCellB(strName);
        m_document.add(tbl);
    }

    public void writeParagrafo(String strName) throws BadElementException, DocumentException {
        Paragraph pr = new Paragraph("", REPORT_SETTINGS.ftParagraph2);
        //pr.setIndentationLeft(10f);

        Paragraph pr1 = new Paragraph(strName, REPORT_SETTINGS.ftTableHeader);
        pr1.setIndentationLeft(10f);

        Cell cl = new Cell(pr1);
        cl.setBackgroundColor(REPORT_SETTINGS.clTableHeader);

        CenterMiddleTable tbl = new CenterMiddleTable(1);
        tbl.toLeft();
        tbl.addCell(cl);

        pr.add(tbl);
        m_document.add(pr);
    }

    public void writePage() throws DocumentException {
        m_document.newPage();
    }

    public void writeParagraph1(String strText) throws BadElementException, DocumentException {
        m_document.add(new Paragraph(strText!=null?strText.trim():"", REPORT_SETTINGS.ftParagraph));
    }

    public void writeParagraph2(String strText) throws BadElementException, DocumentException {
        Paragraph pr = new Paragraph(strText!=null?strText.trim():"", REPORT_SETTINGS.ftParagraph2);
        pr.setAlignment(Element.ALIGN_JUSTIFIED);
        pr.setIndentationLeft(10f);
        m_document.add(pr);
    }

    public void writeParagraph3(String strText) throws BadElementException, DocumentException {
        Paragraph pr = new Paragraph(strText!=null?strText.trim():"", REPORT_SETTINGS.ftParagraph3);
        pr.setAlignment(Element.ALIGN_JUSTIFIED);
        pr.setIndentationLeft(15f);
        m_document.add(pr);
    }

    public void writeParagraph3(String strText, int iLevel) throws BadElementException, DocumentException {
        Paragraph pr = new Paragraph(strText!=null?strText.trim():"", REPORT_SETTINGS.ftParagraph3);
        pr.setIndentationLeft(5 * iLevel);
        m_document.add(pr);
    }

    public void writeParagraph3_1(String strText) throws BadElementException, DocumentException {
        Paragraph pr = new Paragraph(strText!=null?strText.trim():"", REPORT_SETTINGS.ftParagraph3_1);
        pr.setIndentationLeft(15f);
        m_document.add(pr);
    }

    public void writeParagraph3_2(String strText) throws BadElementException, DocumentException {
        Paragraph pr = new Paragraph(strText!=null?strText.trim():"", REPORT_SETTINGS.ftParagraph3_2);
        pr.setIndentationLeft(15f);
        m_document.add(pr);
    }

    public void writeText2(String strText) throws BadElementException, DocumentException {
        Paragraph pr = new Paragraph(strText!=null?strText.trim():"", REPORT_SETTINGS.ftText2);
        pr.setIndentationLeft(10f);
        m_document.add(pr);
    }
    
    public void writeText2Bold(String strText) throws BadElementException, DocumentException {
        Paragraph pr = new Paragraph(strText!=null?strText.trim():"", REPORT_SETTINGS.ftText2B);
        pr.setIndentationLeft(10f);
        m_document.add(pr);
    }
    public void writeText3Bold(String strText) throws BadElementException, DocumentException {
        Paragraph pr = new Paragraph(strText!=null?strText.trim():"", REPORT_SETTINGS.ftText13B);
        pr.setIndentationLeft(10f);
        m_document.add(pr);
    }
    
    public void writeText2BoldAndIndent(String strText, byte indentationLevel) throws BadElementException, DocumentException {
        Paragraph pr = new Paragraph(strText!=null?strText.trim():"", REPORT_SETTINGS.ftText2B);
        if (indentationLevel < 1) indentationLevel = 1;
        pr.setIndentationLeft(10f + (20f*(indentationLevel-1)));
        m_document.add(pr);
    }

    public void writeText2Justified(String strText) throws BadElementException, DocumentException {
        Paragraph pr = new Paragraph(strText!=null?strText.trim():"", REPORT_SETTINGS.ftText2);
        pr.setAlignment(Element.ALIGN_JUSTIFIED);
        pr.setIndentationLeft(10f);
        m_document.add(pr);
    }

    public void writeText2JustifiedAndIndent(String strText, byte indentationLevel) throws BadElementException, DocumentException {
        Paragraph pr = new Paragraph(strText!=null?strText.trim():"", REPORT_SETTINGS.ftText2);
        pr.setAlignment(Element.ALIGN_JUSTIFIED);
        if (indentationLevel < 1) indentationLevel = 1;
        pr.setIndentationLeft(10f + (20f*(indentationLevel-1)));
        m_document.add(pr);
    }

    public void writeText3(String strText, int iLevel) throws BadElementException, DocumentException {
        Paragraph pr = new Paragraph(strText!=null?strText.trim():"", REPORT_SETTINGS.ftText3);
        pr.setIndentationLeft(5 * iLevel);
        m_document.add(pr);
    }

    public void writeText3(String strText) throws BadElementException, DocumentException {
        Paragraph pr = new Paragraph(strText!=null?strText.trim():"", REPORT_SETTINGS.ftText3);
        pr.setIndentationLeft(15f);
        m_document.add(pr);
    }

    public void writeText3_2(String strText) throws BadElementException, DocumentException {
        Paragraph pr = new Paragraph(strText!=null?strText.trim():"", REPORT_SETTINGS.ftText3_2);
        pr.setIndentationLeft(15f);
        m_document.add(pr);
    }

    public void writeText3_3(String strText) throws BadElementException, DocumentException {
        Paragraph pr = new Paragraph(strText!=null?strText.trim():"", REPORT_SETTINGS.ftText2);
        pr.setIndentationLeft(25f);
        m_document.add(pr);
    }

    public void writeLine() throws DocumentException {
        m_document.add(Chunk.NEWLINE);
    }

    public void writeTitle(String strTitle) throws DocumentException {
        Paragraph prTitle = new Paragraph(strTitle, REPORT_SETTINGS.ftDocumentTitle);
        prTitle.setAlignment(Element.ALIGN_CENTER);
        m_document.add(prTitle);
        m_document.add(new Paragraph("", REPORT_SETTINGS.ftText10));
        writeLine();
    }

    public void writeBig(String strTitle) throws DocumentException {
        Paragraph prTitle = new Paragraph(strTitle, REPORT_SETTINGS.ftBig);
        prTitle.setAlignment(Element.ALIGN_CENTER);
        m_document.add(prTitle);
    }

    public void writeIndent() throws DocumentException {
        m_document.add(new Paragraph("", REPORT_SETTINGS.ftText10));
        writeLine();
    }

    //------------------------------------------------------------------------------------------------
    public void doReport(ByteArrayOutputStream out, Document document) throws DocumentException, IOException, BadElementException, Exception {
        m_out = out;
        m_document = document;
        bStandAlone = false;
        this.doReport();
    }

    public void initDocument(String strFileName) throws DocumentException {
        initDocument(strFileName, null, null, null, null);
    }

    public void initDocument(
            String strFileName, String strTopLeft, String strTopCenter, 
            String strBottomLeft, String strBottomRight) throws DocumentException {
        initDocument(strFileName, strTopLeft, strTopCenter, null, null, strBottomLeft, strBottomRight);
    }
    
    public void initDocument(
            String strFileName, String strTopLeft, String strTopCenter, 
            String strFirstBottomLeft, String strFirstBottomRight, 
            String strBottomLeft, String strBottomRight) throws DocumentException {
        if (!bStandAlone) {
            return;
        }
        initDocumentEx(strFileName);
        setHeaders();
        
        // Imposta gli eventuali valori delle celle (sinistra e centro) 
        // di intestazione.
        if (strTopLeft != null) {
            m_handler.strTopLeft = strTopLeft;
        }
        if (strTopCenter != null) {
            m_handler.strTopCenter = strTopCenter;
        }
        
        // Imposta gli eventuali valori delle celle (sinistra e destra) di un 
        // ulteriore piè di pagina, precedente a quello standard, senza bordi di 
        // tabella.
        // In questo caso inoltre accorcio i margini del documento in modo da
        // lasciare spazio per tale ulteriore piè di pagina.
        if (strFirstBottomLeft != null || strFirstBottomRight != null) {
            m_document.setMargins(30, 30, 60, 160);
            if (strFirstBottomLeft != null) {
                m_handler.strFirstBottomLeft = strFirstBottomLeft;
            }
            if (strFirstBottomRight != null) {
                m_handler.strFirstBottomRight = strFirstBottomRight;
            }
        }
        
        // Imposta gli eventuali valori delle celle (sinistra e destra) 
        // del piè di pagina standard.
        if (strBottomLeft != null) {
            m_handler.strBottomLeft = strBottomLeft;
        }
        if (strBottomRight != null) {
            if (strBottomRight.length() < 60) {
                m_handler.strBottomRight = strBottomRight;
            } else {
                m_handler.strBottomRight = strBottomRight.substring(0, 60) + "...";
            }
        }
        
        m_document.open();
    }

    public void setHeaders() {
        response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
        response.setHeader("Pragma", "public"); 			//HTTP 1.0
        response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
        response.reset();
        response.setContentType("application/pdf");
    }

    public void initDocumentEx(String strFileName) throws DocumentException {

        m_out = new ByteArrayOutputStream();
        m_document = new Document(bRotate ? PageSize.A4.rotate() : PageSize.A4, 30, 30, 60, 60);
        m_writer = PdfWriter.getInstance(m_document, m_out);
        m_writer.setViewerPreferences(PdfWriter.PageLayoutTwoColumnLeft);
        m_document.addCreator("");
        m_document.addAuthor("S2S s.r.l.");
        m_document.addCreationDate();

        m_handler = new MyPageEvents();
        m_handler.bRotate = bRotate;
        m_writer.setPageEvent(m_handler);
    }

    public void closeDocument() throws IOException, DocumentException {
        if (!bStandAlone) {
            return;
        }
        m_document.close();
        response.setContentLength(m_out.size());
        ServletOutputStream out = response.getOutputStream();
        m_out.writeTo(out);
        out.flush();
        out.close();
    }

    public void doReport() throws DocumentException, IOException, BadElementException, Exception {
    }

    public void doReport(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException, Exception {

        this.request = request;
        this.response = response;

        try {
            doReport();
        } catch (DocumentException de) {
            documentName = "";
            System.err.println(de.getMessage());
            de.printStackTrace(System.err);
        }
    }
    //---alex

    public void doReport4Generate(HttpServletRequest request, HttpServletResponse response, String _documentName)
            throws IOException, ServletException, Exception {
        documentName = _documentName;
        doReport(request, response);
        documentName = "";
    }

    public void doReport(java.util.ArrayList lst) throws DocumentException, IOException, BadElementException, Exception {
    }

    public void doReport(HttpServletRequest request, HttpServletResponse response, java.util.ArrayList lst)
            throws IOException, ServletException, Exception {

        this.request = request;
        this.response = response;

        try {
            doReport(lst);
        } catch (DocumentException de) {
            System.err.println(de.getMessage());
            de.printStackTrace();
        }
    }
    public  Report getCurrentReport(){
        return this;
    }
    //-----
}//----

