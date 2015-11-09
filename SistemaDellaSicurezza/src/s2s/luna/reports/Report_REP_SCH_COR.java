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

import com.apconsulting.luna.ejb.Azienda.IAzienda;
import com.apconsulting.luna.ejb.Azienda.IAziendaHome;
import com.apconsulting.luna.ejb.Corsi.DOC_CorsoMateriali_View;
import com.apconsulting.luna.ejb.Corsi.DocentiForCorso_List_View;
import com.apconsulting.luna.ejb.Corsi.ErogazioneForCorso_List_View;
import com.apconsulting.luna.ejb.Corsi.ICorsi;
import com.apconsulting.luna.ejb.Corsi.ICorsiHome;
import com.lowagie.text.BadElementException;
import com.lowagie.text.DocumentException;
import java.io.IOException;
import s2s.ejb.pseudoejb.PseudoContext;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.report.CenterMiddleTable;
import s2s.report.Report;
import com.lowagie.text.Element;
import s2s.utils.plain.Formatter;
import s2s.luna.util.SecurityWrapper;

/**
 *
 * @author Dario
 */
public class Report_REP_SCH_COR extends Report {

    public long lCOD_AZL = 0;
    public long lCOD_COR = 0;
    //---------------------------------------

    public Report_REP_SCH_COR(long lCOD_COR) {
        this.lCOD_COR = lCOD_COR;
    }
    //------------------------------------------------------------------------------------------

    @Override
    public void doReport() throws DocumentException, IOException, BadElementException, Exception {
        //----------------------------------------------------------------------
        SecurityWrapper Security = SecurityWrapper.getInstance();
        lCOD_AZL = Security.getAziendaR();
        IAziendaHome azienda_home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
        IAzienda azienda = azienda_home.findByPrimaryKey(new Long(lCOD_AZL));
        //
        ICorsiHome corso_home = (ICorsiHome) PseudoContext.lookup("CorsiBean");
        ICorsi corso = corso_home.findByPrimaryKey(new Long(lCOD_COR));
        initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("SCHEDA.CORSO"), azienda.getRAG_SCL_AZL(), null);
        AddImage();
        writeIndent();
        //
        {
            CenterMiddleTable tbl = new CenterMiddleTable(1);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
            tbl.addCell(azienda.getRAG_SCL_AZL());
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("SCHEDA.CORSO"));
            tbl.addCell(Formatter.format(corso.getNOM_COR()));
            m_document.add(tbl);
        }
        //
        {
            CenterMiddleTable tbl = new CenterMiddleTable(2);
            tbl.toLeft();
            int width[] = {25, 75};
            tbl.setWidths(width);
            tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Descrizione"), 2);
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Descrizione"));
            tbl.addCell(Formatter.format(corso.getDES_COR()));
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Durata"));
            tbl.addCell(Formatter.format(corso.getDUR_COR_GOR()));
            String att_freq = ApplicationConfigurator.LanguageManager.getString("si");
            String punteggio = ApplicationConfigurator.LanguageManager.getString("si");
            if (corso.getUSO_ATE_FRE_COR().equals("N")) {
                att_freq = ApplicationConfigurator.LanguageManager.getString("no");
            }
            if (corso.getUSO_PTG_COR().equals("N")) {
                punteggio = ApplicationConfigurator.LanguageManager.getString("no");
            }
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Attestato.di.frequenza"));
            tbl.addCell(att_freq);
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Punteggio.test"));
            tbl.addCell(punteggio);
            m_document.add(tbl);
        }
        //
        {
            CenterMiddleTable tbl = new CenterMiddleTable(2);
            tbl.toLeft();
            int width[] = {85, 15};
            tbl.setWidths(width);
            tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Elenco.materiale"), 2);
            tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Titolo"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data"));
            tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
            //------------------------------------------------------
            java.util.Iterator it = corso.getDocCorsoMateriali_List_View().iterator();
            while (it.hasNext()) {
                DOC_CorsoMateriali_View w = (DOC_CorsoMateriali_View) it.next();
                tbl.addCell(Formatter.format(w.TIT_DOC));
                tbl.addCell(Formatter.format(w.DAT_REV_DOC));
            }
            m_document.add(tbl);
        }
        //
        {
            CenterMiddleTable tbl = new CenterMiddleTable(3);
            tbl.toLeft();
            int width[] = {60, 20, 20};
            tbl.setWidths(width);
            tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Elenco.docenti"), 3);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Nominativo"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Inizio.docenza"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Fine.docenza"));
            //------------------------------------------------------
            java.util.Iterator it = corso.getDocentiForCorso_List_View().iterator();
            while (it.hasNext()) {
                DocentiForCorso_List_View w = (DocentiForCorso_List_View) it.next();
                tbl.addCell(Formatter.format(w.NOM_DCT));
                tbl.addCell(Formatter.format(w.DAT_INZ));
                tbl.addCell(Formatter.format(w.DAT_FIE));
            }
            m_document.add(tbl);
        }
        //
        {
            CenterMiddleTable tbl = new CenterMiddleTable(1);
            tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Elenco.erogazioni.aziendali"));
            tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
            tbl.addCell(azienda.getRAG_SCL_AZL());
            m_document.add(tbl);
        }
        //
        {
            CenterMiddleTable tbl = new CenterMiddleTable(5);
            tbl.toLeft();
            int width[] = {15, 15, 25, 25, 20};
            tbl.setWidths(width);
            tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dati.erogazione"), 5);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.pianificata"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.effettiva"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Cognome"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Nome"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Stato"));
            //------------------------------------------------------
            java.util.Iterator it = corso.getErogazioneForCorso_List_View(this.lCOD_AZL).iterator();
            while (it.hasNext()) {
                ErogazioneForCorso_List_View w = (ErogazioneForCorso_List_View) it.next();
                tbl.addCell(Formatter.format(w.DAT_PIF_EGZ_COR));
                tbl.addCell(Formatter.format(w.DAT_EFT_EGZ_COR));
                tbl.addCell(Formatter.format(w.COG_DPD));
                tbl.addCell(Formatter.format(w.NOM_DPD));
                tbl.addCell(Formatter.format(w.STA_EGZ_COR));
            }
            m_document.add(tbl);
        }
        //----------------------
        closeDocument();
    }
}
