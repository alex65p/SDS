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
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.Table;
import java.awt.Color;
import s2s.utils.text.StringManager;

/**
 *
 * @author Dario
 */
public class MiddleTable extends Table {

    private ZREPORT_SETTINGS REPORT_SETTINGS = null;

    public MiddleTable(int iColumns) throws BadElementException {
        this(iColumns, false);
    }

    public MiddleTable(int iColumns, boolean bNoWidth) throws BadElementException {
        super(iColumns);
        REPORT_SETTINGS = new ZREPORT_SETTINGS();
        this.setPadding(2);
        if (!bNoWidth) {
            this.setWidth(100);
        }
        this.setBorder(Rectangle.NO_BORDER);
        this.setDefaultVerticalAlignment(Element.ALIGN_MIDDLE);
        this.setDeafaultOffset();
    }

    public void toCenter() {
        this.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
    }

    public void toLeft() {
        this.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
    }

    public void toRight() {
        this.setDefaultHorizontalAlignment(Element.ALIGN_RIGHT);
    }

    public void toBottom() {
        this.setDefaultVerticalAlignment(Element.ALIGN_BOTTOM);
    }

    public void toMiddle() {
        this.setDefaultVerticalAlignment(Element.ALIGN_MIDDLE);
    }

    public void toTop() {
        this.setDefaultVerticalAlignment(Element.ALIGN_TOP);
    }
    
    public void toAlign() {
        this.setDefaultVerticalAlignment(ALIGN_JUSTIFIED);
    }

    public void color() {
        this.setBackgroundColor(REPORT_SETTINGS.clTableHeader);
    }

    public void BorderColor() {
        this.getDefaultCell().setBorderColor(Color.white);
    }

    public void addTitleCell(String strTitle) throws BadElementException {
        Paragraph prTitle = new Paragraph(strTitle, REPORT_SETTINGS.ftDocumentTitle);
        //prTitle.setAlignment(Element.ALIGN_CENTER);
        super.addCell(prTitle);
    }
    
    public void addTitleCell(String strTitle, String tipoScheda) throws BadElementException {
        Font fontSpecifico = null;
        if (tipoScheda.equalsIgnoreCase("MACC_ATT")) {
            fontSpecifico = REPORT_SETTINGS.ftDocumentTitleMaccAtt;
        }
        if (fontSpecifico != null) {
            Paragraph prTitle = new Paragraph(strTitle, fontSpecifico);
            //prTitle.setAlignment(Element.ALIGN_CENTER);
            super.addCell(prTitle);
        }
    } 

    public void addCell1(String strTitle) throws BadElementException {
        Paragraph prTitle = new Paragraph(strTitle.trim(), REPORT_SETTINGS.ftParagraph3);
        prTitle.setIndentationLeft(15f);
        super.addCell(prTitle);
    }

    public void addCell2(String strTitle1) throws BadElementException {
        Paragraph prTitle1 = new Paragraph(strTitle1.trim(), REPORT_SETTINGS.ftParagraph2);
        prTitle1.setIndentationLeft(10f);
        super.addCell(prTitle1);
    }
    
    public void addHeaderCell(String strCaption, int iColspan) throws BadElementException {
        Cell cl = new Cell(new Phrase(strCaption == null ? "" : strCaption, REPORT_SETTINGS.ftTableHeader));
        cl.setBackgroundColor(REPORT_SETTINGS.clTableHeader);
        cl.setColspan(iColspan);
        this.addCell(cl);
    }

    public void addHeaderCell(String strCaption) throws BadElementException {
        addHeaderCell(strCaption, 1);
    }

    public void addHeaderCellMagenta(String strCaption, int iColspan) throws BadElementException {
        Cell cl = new Cell(new Phrase(strCaption == null ? "" : strCaption, REPORT_SETTINGS.ftTableHeader));
        cl.setBackgroundColor(REPORT_SETTINGS.magenta);
        cl.setColspan(iColspan);
        this.addCell(cl);
    }

    public void addHeaderCellMagenta(String strCaption) throws BadElementException {
        addHeaderCellMagenta(strCaption, 1);
    }

    public void addHeaderCellB(String strCaption, int iColspan, boolean bColor, int iSize) throws BadElementException {
        Cell cell = null;
        switch (iSize) {
            case 8:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftTableHeader8B));
                break;
            case 9:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftTableHeader9B));
                break;
            case 10:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftTableHeader10B));
                break;
            case 12:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftTableHeader12B));
                break;
            case 16:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftTableHeader16B));
                break;
            default:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftTableHeaderB));
                break;
        }
        if (bColor) {
            cell.setBackgroundColor(REPORT_SETTINGS.clTableHeader);
        }
        cell.setColspan(iColspan);
        this.addCell(cell);
    }
    public void addHeaderCellB2(String strCaption, int iColspan, boolean bColor, int iSize) throws BadElementException {
        Cell cell = null;
        switch (iSize) {
            case 8:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftTableHeader8B));
                break;
            case 9:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftTableHeader9B));
                break;
            case 10:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftTableHeader10B));
                break;
            case 11:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftTableHeader11B));
                break;
            case 12:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftTableHeader12B));
                break;
            default:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftTableHeaderB));
                break;
        }
        
        cell.setColspan(iColspan);
        this.addCell(cell);
    }

    public void addHeaderCellB(String strCaption, int iColspan, boolean bColor) throws BadElementException {
        addHeaderCellB(strCaption, iColspan, bColor, 14);
    }
    
    public void addHeaderCellB(String strCaption, int iColspan) throws BadElementException {
        addHeaderCellB(strCaption, iColspan, true);
    }
    
    public void addHeaderCellB(String strCaption) throws BadElementException {
        addHeaderCellB(strCaption, 1);
    }
    public void addHeaderCellB2(String strCaption, int iColspan, boolean bColor) throws BadElementException {
        addHeaderCellB2(strCaption, iColspan, bColor, 14);
    }

    public void addHeaderCellB2(String strCaption, int iColspan) throws BadElementException {
        addHeaderCellB2(strCaption, iColspan, true);
    }

    public void addHeaderCellB2(String strCaption) throws BadElementException {
        addHeaderCellB2(strCaption, 1);
    }

    public void addHeaderCellFirstBold(String strCaption) throws BadElementException {
        addHeaderCellFirstBold(strCaption, 1);
    }

    public void addHeaderCellFirstBold(String strCaption, int iColspan) throws BadElementException {
        addHeaderCellFirstBold(strCaption, iColspan, true);
    }

    public void addHeaderCellFirstBold(String strCaption, int iColspan, boolean bColor) throws BadElementException {
        addHeaderCellFirstBold(strCaption, iColspan, bColor, 14);
    }
    
    public void addHeaderCellFirstBold(String strCaption, int iColspan, boolean bColor, int iSize) throws BadElementException {
        addHeaderCellFirstBold(strCaption, iColspan, bColor, iSize, iSize);
    }

    public void border() {
        this.getDefaultCell().setBorder(0);
    }
    
    public void addHeaderCellFirstBold(String strCaption, int iColspan, boolean bColor, int iSize, int iSecondSize) throws BadElementException {
        Font firstFont = null;
        Font secondFont = null;
        switch (iSize) {
            case 8:
                firstFont = REPORT_SETTINGS.ftTableHeader8B;
                break;
            case 9:
                firstFont = REPORT_SETTINGS.ftTableHeader9B;
                break;
            case 12:
                firstFont = REPORT_SETTINGS.ftTableHeader12B;
                break;
            default:
                firstFont = REPORT_SETTINGS.ftTableHeaderB;
                break;
        }
        switch (iSecondSize) {
            case 8:
                secondFont = REPORT_SETTINGS.ftTableHeader8;
                break;
            case 9:
                secondFont = REPORT_SETTINGS.ftTableHeader9;
                break;
            case 12:
                secondFont = REPORT_SETTINGS.ftTableHeader12;
                break;
            default:
                secondFont = REPORT_SETTINGS.ftTableHeader;
                break;
        }
        String firstChar = (StringManager.isNotEmpty(strCaption)?String.valueOf(strCaption.charAt(0)):"");
        String otherPart = (StringManager.isNotEmpty(strCaption)?strCaption.substring(1, strCaption.length()):"");
        
        Chunk firstCharChunk = new Chunk(firstChar, firstFont);
        Phrase str = new Phrase(otherPart, secondFont);
        str.add(0, firstCharChunk);
        Cell cl = new Cell(str);
        if (bColor) {
            cl.setBackgroundColor(REPORT_SETTINGS.clTableHeader);
        }
        cl.setColspan(iColspan);
        this.addCell(cl);
    }

    public void addCellFirstLineBold(String strCaption) throws BadElementException {
        addCellFirstLineBold(strCaption, 1);
    }

    public void addCellFirstLineBold(String strCaption, int iColspan) throws BadElementException {
        addCellFirstLineBold(strCaption, iColspan, 12);
    }

    public void addCellFirstLineBold(String strCaption, int iColspan, int iSize) throws BadElementException {
        addCellFirstLineBold(strCaption, iColspan, iSize, iSize);
    }
    
    public void addCellFirstLineBold(String strCaption, int iColspan, int iSize, int iSecondSize) throws BadElementException {
        Font firstFont = null;
        Font secondFont = null;
        switch (iSize) {
            case 8:
                firstFont = REPORT_SETTINGS.ftText8B;
                break;
            case 9:
                firstFont = REPORT_SETTINGS.ftText9B;
                break;
            default:
                firstFont = REPORT_SETTINGS.ftText12B;
                break;
        }
        switch (iSecondSize) {
            case 8:
                secondFont = REPORT_SETTINGS.ftText8;
                break;
            case 9:
                secondFont = REPORT_SETTINGS.ftText9;
                break;
            default:
                secondFont = REPORT_SETTINGS.ftText12;
                break;
        }
        String newLineChar = "\n";
        String firstPart = StringManager.isNotEmpty(strCaption)
                ?strCaption.substring(0,strCaption.indexOf(newLineChar)+newLineChar.length())
                :"";
        String otherPart = StringManager.isNotEmpty(strCaption)
                ?strCaption.substring(firstPart.length())
                :"";
                
        Chunk firstCharChunk = new Chunk(firstPart, firstFont);
        Phrase str = new Phrase(otherPart, secondFont);
        str.add(0, firstCharChunk);
        Cell cl = new Cell(str);
        cl.setColspan(iColspan);
        this.addCell(cl);
    }
    
    public void setDeafaultOffset() {
        this.setOffset(5);
    }

    public void addCellUrl(String strCaption) throws Exception {
        Chunk ph = new Chunk(strCaption);
        ph.setAnchor(strCaption);
        super.addCell(new Cell(ph));
    }

    public void addCellBU(String strCaption) throws BadElementException {
        addCellBU(strCaption, 12);
    }

    public void addCellBU(String strCaption, int iSize) throws BadElementException {
        addCellBU(strCaption, iSize, 1);
    }

    public void addCellBU(String strCaption, int iSize, int iColspan) throws BadElementException {
        strCaption=strCaption==null?"":strCaption;
        Cell cell = null;
        switch (iSize) {
            case 8:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText8BU));
                break;
            case 9:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText9BU));
                break;
            case 10:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText10BU));
                break;
            case 11:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText11BU));
                break;
            case 12:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText12BU));
                break;
            case 13:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText13BU));
                break;
            case 14:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText14BU));
                break;
            case 15:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText15BU));
                break;
            case 16:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText16BU));
                break;
            case 17:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText17BU));
                break;
            case 18:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText18BU));
                break;
            case 19:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText19BU));
                break;
            default:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText12BU));
                break;
        }
        cell.setColspan(iColspan);
        this.addCell(cell);
    }
    
    public void addCellB(String strCaption) throws BadElementException {
        addCellB(strCaption, 12);
    }

    public void addCellB(String strCaption, int iSize) throws BadElementException {
        addCellB(strCaption, iSize, 1);
    }

    public void addCellB(String strCaption, int iSize, int iColspan) throws BadElementException {
        strCaption=strCaption==null?"":strCaption;
        Cell cell = null;
        switch (iSize) {
            case 8:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText8B));
                break;
            case 9:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText9B));
                break;
            case 10:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText10B));
                break;
            case 11:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText11B));
                break;
            case 12:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText12B));
                break;
            case 13:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText13B));
                break;
            case 14:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText14B));
                break;
            case 15:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText15B));
                break;
            case 16:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText16B));
                break;
            case 17:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText17B));
                break;
            case 18:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText18B));
                break;
            case 19:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText19B));
                break;
            default:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText12B));
                break;
        }
        cell.setColspan(iColspan);
        this.addCell(cell);
    }

    @Override
    public void addCell(String strCaption) throws BadElementException {
        super.addCell(strCaption == null ? "" : strCaption);
    }
    
    public void addCell(String strCaption, int iSize) throws BadElementException {
        addCell(strCaption, iSize, 1);
    }

    public void addCell(String strCaption, int iSize, int iColspan) throws BadElementException {
        addCell(strCaption, iSize, iColspan, 1);
    }
    public void addCell(String strCaption, int iSize, int iColspan, int iRowspan) throws BadElementException {
        strCaption=strCaption==null?"":strCaption;
        Cell cell = null;
        switch (iSize) {
            case 8:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText8));
                break;
            case 9:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText9));
                break;
            case 10:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText10));
                break;
            case 11:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText11));
                break;
            case 12:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText12));
                break;
            case 13:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText13));
                break;
            case 14:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText14));
                break;
            case 15:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText15));
                break;
            case 16:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText16));
                break;
            case 17:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText17));
                break;
            case 18:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText18));
                break;
            case 19:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftText19));
                break;
            default:
                cell = new Cell(strCaption);
                break;
        }
        cell.setColspan(iColspan);
        cell.setRowspan(iRowspan);
        this.addCell(cell);
    }

    public void addHeaderCellI(String strCaption) throws BadElementException {
        this.addHeaderCellI(strCaption, 1);
    }

    public void addHeaderCellI(String strCaption, int iColspan) throws BadElementException {
        this.addHeaderCellI(strCaption, iColspan, true);
    }
    
    public void addHeaderCellI(String strCaption, int iColspan, boolean bColor) throws BadElementException {
        addHeaderCellI(strCaption, iColspan, bColor, 14);
    }
    
    public void addHeaderCellI(String strCaption, int iColspan, boolean bColor, int iSize) throws BadElementException {
        Cell cell = null;
        switch (iSize) {
            case 9:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftTableHeader9I));
                break;
            case 12:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftTableHeader12I));
                break;
            default:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftTableHeaderI));
                break;
        }
        if (bColor) {
            cell.setBackgroundColor(REPORT_SETTINGS.clTableHeader);
        }
        cell.setColspan(iColspan);
        this.addCell(cell);
    }

    public void addHeaderCellBI(String strCaption) throws BadElementException {
        this.addHeaderCellBI(strCaption, 1);
    }

    public void addHeaderCellBI(String strCaption, int iColspan) throws BadElementException {
        this.addHeaderCellBI(strCaption, iColspan, true);
    }
    
    public void addHeaderCellBI(String strCaption, int iColspan, boolean bColor) throws BadElementException {
        addHeaderCellBI(strCaption, iColspan, bColor, 14);
    }
    
    public void addHeaderCellBI(String strCaption, int iColspan, boolean bColor, int iSize) throws BadElementException {
        Cell cell = null;
        switch (iSize) {
            case 8:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftTableHeader8BI));
                break;
            case 9:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftTableHeader9BI));
                break;
            case 10:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftTableHeader10BI));
                break;
            case 12:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftTableHeader12BI));
                break;
            default:
                cell = new Cell(new Phrase(strCaption, REPORT_SETTINGS.ftTableHeaderBI));
                break;
        }
        if (bColor) {
            cell.setBackgroundColor(REPORT_SETTINGS.clTableHeader);
        }
        cell.setColspan(iColspan);
        this.addCell(cell);
    }

    /*
    @todo setDefaultColspan
     *  METODO RIDEFINITO PER DIFFERENTE VERSIONE DI ITEXT
     *  MIGRAZIONE DALLA VERSIONE 0.9.9 ALLA VERSIONE 2.1.7
     */
    public void setDefaultColspan(int value) {
        this.getDefaultCell().setColspan(value);
    }

    /*
    @todo setDefaultHorizontalAlignment
     *  METODO RIDEFINITO PER DIFFERENTE VERSIONE DI ITEXT
     *  MIGRAZIONE DALLA VERSIONE 0.9.9 ALLA VERSIONE 2.1.7
     */
    public void setDefaultHorizontalAlignment(int value) {
        this.getDefaultCell().setHorizontalAlignment(value);
    }

    /*
    @todo setDefaultVerticalAlignment
     *  METODO RIDEFINITO PER DIFFERENTE VERSIONE DI ITEXT
     *  MIGRAZIONE DALLA VERSIONE 0.9.9 ALLA VERSIONE 2.1.7
     */
    public void setDefaultVerticalAlignment(int value) {
        this.getDefaultCell().setVerticalAlignment(value);
    }

    /*
    @todo setDefaultCellBorder
     *  METODO RIDEFINITO PER DIFFERENTE VERSIONE DI ITEXT
     *  MIGRAZIONE DALLA VERSIONE 0.9.9 ALLA VERSIONE 2.1.7
     */
    public void setDefaultCellBorder(int value) {
        this.getDefaultCell().setBorder(value);
    }
}
