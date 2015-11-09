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

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.PageSize;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfPageEventHelper;
import com.lowagie.text.pdf.PdfTemplate;
import com.lowagie.text.pdf.PdfWriter;
import java.io.IOException;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.utils.plain.Formatter;

/**
 *
 * @author Dario
 */
public class MyPageEvents extends PdfPageEventHelper implements Cloneable {

    public PdfContentByte cb;
    public PdfTemplate template;
    public BaseFont bf = null;
    public int m_iCount = 0;
    public boolean m_writeIndex = false;
    public boolean bRotate = false;
    public int m_iCurrentIndexPage = 1;
    public boolean bShowHeader = true;
    
    // Aggiunte per la gestione di un ulteriore piè di pagina, 
    // precedente a quello standard, senza bordi di tabella.
    public String strFirstBottomLeft = "";
    public String strFirstBottomRight = "";

    public String strBottomLeft = "";
    public String strBottomRight = "";
    public String strTopLeft = "Sistema della Sicurezza";
    public String strTopRight = "";
    public String strTopCenter = "";
    public boolean bShowDate = true;
    public Rectangle m_rect;
    public String act = "";
    private ZREPORT_SETTINGS REPORT_SETTINGS = new ZREPORT_SETTINGS();
    boolean IndexAlreadyWrited = false;

    public void setIndexPageCount(int iCount) {
        m_iCount = iCount;
    }

    public void startIndex() {
        m_writeIndex = true;
    }

    public void endIndex() {
        m_writeIndex = false;
        IndexAlreadyWrited = true;
    }

    @Override
    public void onOpenDocument(PdfWriter writer, Document m_document) {
        try {
            bf = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            cb = writer.getDirectContent();
            template = cb.createTemplate(50, 50);
            m_rect = bRotate ? PageSize.A4.rotate() : PageSize.A4;
        } catch (DocumentException de) {
            de.printStackTrace(System.err);
        } catch (IOException ioe) {
            ioe.printStackTrace(System.err);
        }
    }

    @Override
    public void onStartPage(PdfWriter writer, Document m_document) {
        if (!bShowHeader) {
            return;
        }
        int pageN = writer.getPageNumber();
        if (!m_writeIndex) {
            if (!IndexAlreadyWrited) {
                pageN += m_iCount;
            }
        } else {
            pageN = ++m_iCurrentIndexPage;
        }

        PdfPTable tbl = new PdfPTable(3);

        String text = "                 "
                + ApplicationConfigurator.LanguageManager.getString("Pag")
                + " " + pageN + " "
                + ApplicationConfigurator.LanguageManager.getString("Di") + " ";

        tbl.setTotalWidth(m_rect.getWidth() - 60);
        tbl.addCell(new Phrase(strTopLeft, REPORT_SETTINGS.ftText10));

        PdfPCell pc = new PdfPCell(new Phrase(strTopCenter, REPORT_SETTINGS.ftText11));
        pc.setHorizontalAlignment(Element.ALIGN_CENTER);
        tbl.addCell(pc);

        Phrase ph = new Phrase(text, REPORT_SETTINGS.ftText10);
        tbl.addCell(ph);
        tbl.writeSelectedRows(0, -1, 30, m_rect.getHeight() - 30, cb);

        cb.addTemplate(template, bRotate ? 647 : 500, m_rect.getHeight() - 30 - 12);
    }

    @Override
    public void onEndPage(PdfWriter writer, Document m_document) {
        if ((strBottomLeft.length() == 0) && (strBottomRight.length() == 0) && (bShowDate==false) &&
             strFirstBottomLeft.length() == 0 && strFirstBottomRight.length() == 0) {
            return;
        }
        int iColumns = 0;
        PdfPTable tbl1 = null;
        PdfPTable tbl2 = null;
        
        // Stampa gli eventuali valori delle celle (sinistra e destra) di un 
        // ulteriore piè di pagina, precedente a quello standard, senza bordi di 
        // tabella.
        if (strFirstBottomLeft.length() != 0 || strFirstBottomRight.length() != 0){
            if (strFirstBottomLeft.length() != 0) {
                iColumns++;
            }
            if (strFirstBottomRight.length() != 0) {
                iColumns++;
            }
            tbl1 = new PdfPTable(iColumns);
            tbl1.setTotalWidth(m_rect.getWidth() - 60);
            if (strFirstBottomLeft.length() != 0) {
                PdfPCell  cell = new PdfPCell(new Phrase(strFirstBottomLeft, REPORT_SETTINGS.ftText10));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                tbl1.addCell(cell);
            }
            if (strFirstBottomRight.length() != 0) {
                PdfPCell  cell = new PdfPCell(new Phrase(strFirstBottomRight, REPORT_SETTINGS.ftText10));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                tbl1.addCell(cell);
            }
        }

        // Stampa gli eventuali valori delle celle (sinistra e destra) 
        // del piè di pagina standard.
        if ((strBottomLeft.length() != 0) || (strBottomRight.length() != 0) || (bShowDate==true)){
            iColumns = 0;
            if (strBottomLeft.length() != 0) {
                iColumns++;
            }
            if (strBottomRight.length() != 0) {
                iColumns++;
            }
            if (bShowDate) {
                iColumns++;
            }

            tbl2 = new PdfPTable(iColumns);
            tbl2.setTotalWidth(m_rect.getWidth() - 60);
            if (strBottomLeft.length() != 0) {
                tbl2.addCell(new Phrase(strBottomLeft, REPORT_SETTINGS.ftText10));
            }
            if (strBottomRight.length() != 0) {
                tbl2.addCell(new Phrase(strBottomRight, REPORT_SETTINGS.ftText10));
            }
            if (bShowDate) {
                PdfPCell pc = new PdfPCell(new Phrase(Formatter.format(new java.sql.Date(System.currentTimeMillis())), REPORT_SETTINGS.ftText11));
                pc.setHorizontalAlignment(Element.ALIGN_CENTER);
                tbl2.addCell(pc);
            }
        }
        
        // Scrive il piè di pagina precedente a quello standard
        if (tbl1!=null){
            tbl1.writeSelectedRows(0, -1, 30, (tbl2!=null?150:100), cb);
        }
        // Scrive il piè di pagina standard
        if (tbl2!=null){
            tbl2.writeSelectedRows(0, -1, 30, 50, cb);            
        }
    }

    @Override
    public void onCloseDocument(PdfWriter writer, Document m_document) {
        int pageN = writer.getPageNumber() - 1;
        template.beginText();
        template.setFontAndSize(bf, 10);
        template.showText(String.valueOf(pageN));
        template.endText();
    }

    public MyPageEvents copy() throws CloneNotSupportedException {
        return (MyPageEvents) this.clone();
    }
}
