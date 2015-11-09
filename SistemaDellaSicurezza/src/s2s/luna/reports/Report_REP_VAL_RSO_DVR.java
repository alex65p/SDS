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

import com.apconsulting.luna.ejb.Azienda.Azienda_MOD_CLC_RSO;
import com.apconsulting.luna.ejb.Azienda.IAzienda;
import com.apconsulting.luna.ejb.Azienda.IAziendaHome;
import com.apconsulting.luna.ejb.Rischio.IRischioHome;
import com.apconsulting.luna.ejb.Rischio.Rischio_Nome_Fattore_View;
import com.lowagie.text.BadElementException;
import com.lowagie.text.Cell;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Phrase;
import java.io.IOException;
import java.util.Collection;
import s2s.ejb.pseudoejb.PseudoContext;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.util.SecurityWrapper;
import s2s.report.CenterMiddleTable;
import s2s.report.Report;
import s2s.report.ZREPORT_SETTINGS;
import s2s.utils.text.StringManager;

/**
 *
 * @author Dario
 */
public class Report_REP_VAL_RSO_DVR extends Report {

    public long lCOD_AZL = 0;

    public Report_REP_VAL_RSO_DVR(long lCOD_AZL) {
        this.lCOD_AZL = lCOD_AZL;
    }

    @Override
    public void doReport() throws DocumentException, IOException, BadElementException, Exception {
        SecurityWrapper Security = SecurityWrapper.getInstance();
        IAziendaHome home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
        IAzienda bean = home.findByPrimaryKey(new Long(lCOD_AZL));
        
        initDocument("the doc", null, 
                ApplicationConfigurator.LanguageManager.getString("Tabella.valutazione.rischio"), 
                bean.getRAG_SCL_AZL(), null);
        
        writeIndent();
        {
            ZREPORT_SETTINGS repSetting = new ZREPORT_SETTINGS ();
            int tableFontSize = 10;
            int numberOfColumns = 4;
            short sMOD_CLC_RSO = Security.getAziendaModalitaCalcoloRischio();
            numberOfColumns = (sMOD_CLC_RSO==Azienda_MOD_CLC_RSO.MOD_EXTENDED)?numberOfColumns+2:numberOfColumns;
                    
            // Intestazione generale
            CenterMiddleTable tblTopHeader = new CenterMiddleTable(1);
            tblTopHeader.toCenter();
            tblTopHeader.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Tabella.valutazione.rischio"));
            m_document.add(tblTopHeader);
            
            writeLine();
            
            // Intestazione di dettaglio
            CenterMiddleTable tblData = new CenterMiddleTable(numberOfColumns);
            if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_BASE) {
                int width[] = {55, 15, 15, 15};
                tblData.setWidths(width);
            } else if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {
                int width[] = {40, 12, 12, 12, 12, 12};
                tblData.setWidths(width);
            }
            tblData.toCenter();
            tblData.toMiddle();

            tblData.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Rischio"), 1, true, 12);            
            tblData.addHeaderCellFirstBold(
                    ApplicationConfigurator.LanguageManager.getString("P") + "\n" + 
                    StringManager.bracket(ApplicationConfigurator.LanguageManager.getString("Probabilità")),1,true,12,10);
            tblData.addHeaderCellFirstBold(
                    ApplicationConfigurator.LanguageManager.getString("D") + "\n" + 
                    StringManager.bracket(ApplicationConfigurator.LanguageManager.getString("Entità.del.danno")),1,true,12,10);
            if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED){
                    tblData.addHeaderCellFirstBold(
                            ApplicationConfigurator.LanguageManager.getString("F") + "\n" + 
                            StringManager.bracket(ApplicationConfigurator.LanguageManager.getString("Frequenza.dell'attività.a.rischio")),1,true,12,10);
                    tblData.addHeaderCellFirstBold(
                            ApplicationConfigurator.LanguageManager.getString("N") + "\n" + 
                            StringManager.bracket(ApplicationConfigurator.LanguageManager.getString("Numero.di.incidenti/infortuni.(negli.ultimi.3.anni)")),1,true,12,10);
            }
            tblData.addHeaderCellFirstBold(
                    ApplicationConfigurator.LanguageManager.getString("R") + "\n" + 
                            StringManager.bracket(ApplicationConfigurator.LanguageManager.getString("Stima.numerica.del.rischio")),1,true,12,10);
            
            // Dati
            IRischioHome home_rso = (IRischioHome) PseudoContext.lookup("RischioBean");
            Collection<Rischio_Nome_Fattore_View> listaRischi = home_rso.findEx
                    (lCOD_AZL, null, null, null, null, null, null, null, null, null, null, null, null, 0);
            for (Rischio_Nome_Fattore_View rischio: listaRischi){
                Cell rischioCell = new Cell(new Phrase(rischio.strNOM_RSO, repSetting.ftText10));
                rischioCell.setHorizontalAlignment(Element.ALIGN_LEFT);
                tblData.addCell(rischioCell);
                tblData.addCell(Long.toString(rischio.PRB_EVE_LES),tableFontSize);
                tblData.addCell(Long.toString(rischio.ENT_DAN),tableFontSize);
                if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED){
                    tblData.addCell(Long.toString(rischio.FRQ_RIP_ATT_DAN),tableFontSize);
                    tblData.addCell(Long.toString(rischio.NUM_INC_INF),tableFontSize);
                }
                tblData.addCellB(Long.toString(rischio.STM_NUM_RSO),tableFontSize,1);
            }
            m_document.add(tblData);
        }
        closeDocument();
    }
}
