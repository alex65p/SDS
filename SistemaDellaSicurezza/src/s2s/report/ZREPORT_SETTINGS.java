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

import java.awt.Color;
import com.lowagie.text.Font;

/**
 *
 * @author Dario
 */
public class ZREPORT_SETTINGS {

    public int i = 0;
    
    // COLORI
    public Color border = new Color(0x00, 0x00, 0x00);
    public Color clTableHeader = Color.yellow;
    public Color clTableHeader1 = Color.ORANGE;
    public Color magenta	= new Color(254, 254, 197);
    
    // CARATTERI
    public Font ftDocumentHeader = new Font(Font.HELVETICA, 12, Font.NORMAL, border);
    public Font ftDocumentTitle = new Font(Font.HELVETICA, 24, Font.BOLD, border);
    public Font ftDocumentTitleMaccAtt = new Font(Font.HELVETICA, 12, Font.BOLD, border);
    public Font ftBig = new Font(Font.HELVETICA, 18, Font.BOLD, border);
    
    public Font ftParagraph = new Font(Font.HELVETICA, 14, Font.BOLD, border);
    public Font ftParagraph2 = new Font(Font.HELVETICA, 12, Font.NORMAL, border);
    public Font ftParagraph3 = new Font(Font.HELVETICA, 11, Font.BOLD, border);
    public Font ftParagraph3_1 = new Font(Font.HELVETICA, 11, Font.NORMAL, border);
    public Font ftParagraph3_2 = new Font(Font.HELVETICA, 12, Font.BOLD, border);
    
    public Font ftText2 = new Font(Font.HELVETICA, 11, Font.NORMAL, border);
    public Font ftText3 = new Font(Font.HELVETICA, 10, Font.NORMAL, border);
    public Font ftText3_2 = new Font(Font.HELVETICA, 11, Font.NORMAL, border);
    
    public Font ftText8 = new Font(Font.HELVETICA, 8, Font.NORMAL, border);
    public Font ftText9 = new Font(Font.HELVETICA, 9, Font.NORMAL, border);
    public Font ftText10 = new Font(Font.HELVETICA, 10, Font.NORMAL, border);
    public Font ftText11 = new Font(Font.HELVETICA, 11, Font.NORMAL, border);
    public Font ftText12 = new Font(Font.HELVETICA, 12, Font.NORMAL, border);
    public Font ftText13 = new Font(Font.HELVETICA, 13, Font.NORMAL, border);
    public Font ftText14 = new Font(Font.HELVETICA, 14, Font.NORMAL, border);
    public Font ftText15 = new Font(Font.HELVETICA, 15, Font.NORMAL, border);
    public Font ftText16 = new Font(Font.HELVETICA, 16, Font.NORMAL, border);
    public Font ftText17 = new Font(Font.HELVETICA, 17, Font.NORMAL, border);
    public Font ftText18 = new Font(Font.HELVETICA, 18, Font.NORMAL, border);
    public Font ftText19 = new Font(Font.HELVETICA, 19, Font.NORMAL, border);
    
    public Font ftText2B = new Font(Font.HELVETICA, 11, Font.BOLD, border);
    public Font ftText3B = new Font(Font.HELVETICA, 10, Font.BOLD, border);
    
    public Font ftText8B = new Font(Font.HELVETICA, 8, Font.BOLD, border);
    public Font ftText9B = new Font(Font.HELVETICA, 9, Font.BOLD, border);
    public Font ftText10B = new Font(Font.HELVETICA, 10, Font.BOLD, border);
    public Font ftText11B = new Font(Font.HELVETICA, 11, Font.BOLD, border);
    public Font ftText12B = new Font(Font.HELVETICA, 12, Font.BOLD, border);
    public Font ftText13B = new Font(Font.HELVETICA, 13, Font.BOLD, border);
    public Font ftText14B = new Font(Font.HELVETICA, 14, Font.BOLD, border);
    public Font ftText15B = new Font(Font.HELVETICA, 15, Font.BOLD, border);
    public Font ftText16B = new Font(Font.HELVETICA, 16, Font.BOLD, border);
    public Font ftText17B = new Font(Font.HELVETICA, 17, Font.BOLD, border);
    public Font ftText18B = new Font(Font.HELVETICA, 18, Font.BOLD, border);
    public Font ftText19B = new Font(Font.HELVETICA, 19, Font.BOLD, border);

    public Font ftText8BU = new Font(Font.HELVETICA, 8, Font.BOLD|Font.UNDERLINE, border);
    public Font ftText9BU = new Font(Font.HELVETICA, 9, Font.BOLD|Font.UNDERLINE, border);
    public Font ftText10BU = new Font(Font.HELVETICA, 10, Font.BOLD|Font.UNDERLINE, border);
    public Font ftText11BU = new Font(Font.HELVETICA, 11, Font.BOLD|Font.UNDERLINE, border);
    public Font ftText12BU = new Font(Font.HELVETICA, 12, Font.BOLD|Font.UNDERLINE, border);
    public Font ftText13BU = new Font(Font.HELVETICA, 13, Font.BOLD|Font.UNDERLINE, border);
    public Font ftText14BU = new Font(Font.HELVETICA, 14, Font.BOLD|Font.UNDERLINE, border);
    public Font ftText15BU = new Font(Font.HELVETICA, 15, Font.BOLD|Font.UNDERLINE, border);
    public Font ftText16BU = new Font(Font.HELVETICA, 16, Font.BOLD|Font.UNDERLINE, border);
    public Font ftText17BU = new Font(Font.HELVETICA, 17, Font.BOLD|Font.UNDERLINE, border);
    public Font ftText18BU = new Font(Font.HELVETICA, 18, Font.BOLD|Font.UNDERLINE, border);
    public Font ftText19BU = new Font(Font.HELVETICA, 19, Font.BOLD|Font.UNDERLINE, border);

    public Font ftTableHeaderB = new Font(Font.HELVETICA, 14, Font.BOLD, border);
    public Font ftTableHeader8B = new Font(Font.HELVETICA, 8, Font.BOLD, border);
    public Font ftTableHeader9B = new Font(Font.HELVETICA, 9, Font.BOLD, border);
    public Font ftTableHeader10B = new Font(Font.HELVETICA, 10, Font.BOLD, border);
    public Font ftTableHeader11B = new Font(Font.HELVETICA, 11, Font.BOLD, border);
    public Font ftTableHeader12B = new Font(Font.HELVETICA, 12, Font.BOLD, border);
    public Font ftTableHeader16B = new Font(Font.HELVETICA, 16, Font.BOLD, border);
    
    public Font ftTableHeader = new Font(Font.HELVETICA, 14, Font.NORMAL, border);
    public Font ftTableHeader8 = new Font(Font.HELVETICA, 8, Font.NORMAL, border);
    public Font ftTableHeader9 = new Font(Font.HELVETICA, 9, Font.NORMAL, border);
    public Font ftTableHeader10 = new Font(Font.HELVETICA, 10, Font.NORMAL, border);
    public Font ftTableHeader12 = new Font(Font.HELVETICA, 12, Font.NORMAL, border);
    
    public Font ftTableHeaderI = new Font(Font.HELVETICA, 14, Font.ITALIC, border);
    public Font ftTableHeader9I = new Font(Font.HELVETICA, 9, Font.ITALIC, border);
    public Font ftTableHeader12I = new Font(Font.HELVETICA, 12, Font.ITALIC, border);
    
    public Font ftTableHeaderBI = new Font(Font.HELVETICA, 14, Font.BOLDITALIC, border);
    public Font ftTableHeader8BI = new Font(Font.HELVETICA, 8, Font.BOLDITALIC, border);
    public Font ftTableHeader9BI = new Font(Font.HELVETICA, 9, Font.BOLDITALIC, border);
    public Font ftTableHeader10BI = new Font(Font.HELVETICA, 10, Font.BOLDITALIC, border);
    public Font ftTableHeader12BI = new Font(Font.HELVETICA, 12, Font.BOLDITALIC, border);
}
