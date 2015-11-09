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
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package s2s.luna.reports.pageChild;

import com.apconsulting.luna.ejb.AttivitaLavorative.IAttivitaLavorative;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.reports.Report_REP_MAN;
import s2s.report.CenterMiddleTable;
import s2s.report.Report;

/**
 *
 * @author BDP
 */
public class Report_ChildAgentiChimici extends Report_REP_MAN {

    public Report report;

    public Report_ChildAgentiChimici(long lCOD_MAN, long lCOD_AZL, Report report) {
        super(lCOD_MAN, lCOD_AZL);
        this.report = report;
    }

    public Report_ChildAgentiChimici(long lCOD_MAN, long lCOD_AZL, boolean _IncludeLogo, Report report) {
        super(lCOD_MAN, lCOD_AZL, _IncludeLogo);
        this.report = report;
    }

    public void writeRecordCard(Object superBean_man) throws DocumentException {
        IAttivitaLavorative bean_man = (IAttivitaLavorative) superBean_man;
        //
        //Esttraggo i dati relativi alle schede AgentiChimici.
        //

        if (this.allModuleByProfile.booleanValue()) {
            report.writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Valutazione.rischio.chimico"));

            CenterMiddleTable tbl = new CenterMiddleTable(2);
            int width[] = {30, 70};
            tbl.setWidths(width);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Indice.rischio.chimico"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Note"));
            tbl.endHeaders();
            tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                //Collection<AttLavAGE_CHI_View> listaAgentiChimici = bean_man.getAgentiChimici_View_Report();

            // for (AttLavAGE_CHI_View agente : listaAgentiChimici) {
            if ((bean_man.getRSO_VAL() != 0) || (!bean_man.getNOTE().equals(""))) {

                String a = Long.toString(bean_man.getRSO_VAL());

                switch (Integer.valueOf(a)) {
                    case 0:
                        a = "";
                        break;
                    case 1:
                        a = "moderato";
                        break;
                    case 2:
                        a = "non moderato";
                        break;
                }
                tbl.addCell(a);
                tbl.addCell(bean_man.getNOTE());
                report.m_document.add(tbl);
            } else {

                tbl.endHeaders();
                tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                report.m_document.add(tbl);
                report.writeParagraph3(DATI_NON_PRESENTI);
            }
            //  if (listaAgentiChimici.isEmpty()) {
            //      writeParagraph3(DATI_NON_PRESENTI);
            //  }

        }
        /**
         * Se il profilo Attivo nel Sistema è MSR E Ci sono dati relativi Alle
         * Schede AgentiChimici Si stampa la scheda Altrimenti NON si stampa
         * nulla.
         *
         */
        if (!this.allModuleByProfile.booleanValue()) {
            if ((bean_man.getRSO_VAL() != 0) || (!bean_man.getNOTE().equals(""))) {
                report.writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Valutazione.rischio.chimico"));

                CenterMiddleTable tbl = new CenterMiddleTable(2);
                int width[] = {30, 70};
                tbl.setWidths(width);
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Indice.rischio.chimico"));
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Note"));
                tbl.endHeaders();
                tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                String a = Long.toString(bean_man.getRSO_VAL());

                switch (Integer.valueOf(a)) {
                    case 0:
                        a = "";
                        break;
                    case 1:
                        a = "moderato";
                        break;
                    case 2:
                        a = "non moderato";
                        break;
                }
                tbl.addCell(a);
                tbl.addCell(bean_man.getNOTE());
                report.m_document.add(tbl);
                report.writeLine();
            }
        }
        
    }
}
