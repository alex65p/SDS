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
import com.apconsulting.luna.ejb.AttivitaLavorative.ReportAttLav_Documenti_View;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import java.util.Collection;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.reports.Report_REP_MAN;
import s2s.report.CenterMiddleTable;
import s2s.report.Report;

/**
 *
 * @author BDP
 */
public class Report_ChildDocumentazione extends Report_REP_MAN {

    public Report report;

    public Report_ChildDocumentazione(long lCOD_MAN, long lCOD_AZL, Report report) {
        super(lCOD_MAN, lCOD_AZL);
        this.report = report;
    }

    public Report_ChildDocumentazione(long lCOD_MAN, long lCOD_AZL, boolean _IncludeLogo, Report report) {
        super(lCOD_MAN, lCOD_AZL, _IncludeLogo);
        this.report = report;
    }

    public void writeRecordCard(Object superBean_man) throws DocumentException {
        IAttivitaLavorative bean_man = (IAttivitaLavorative) superBean_man;
        //
        //Esttraggo i dati relativi alle schede Documentazione
        //
        Collection<ReportAttLav_Documenti_View> listaDocumenti = bean_man.getReportDocumenti_View();

        if (this.allModuleByProfile.booleanValue()) {
            report.writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Documenti"));
            CenterMiddleTable tbl = new CenterMiddleTable(1);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Titolo.del.documento"));
            tbl.endHeaders();
            tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);

            for (ReportAttLav_Documenti_View Documento : listaDocumenti) {
                tbl.addCell(Documento.TIT_DOC);
            }
            report.m_document.add(tbl);
            if (listaDocumenti.isEmpty()) {
                report.writeParagraph3(DATI_NON_PRESENTI);
            }

        }
        /**
         * Se il profilo Attivo nel Sistema è MSR E Ci sono dati relativi Alle
         * Schede Documenti Si stampa la scheda Altrimenti NON si stampa nulla.
         *
         */
        if (!this.allModuleByProfile.booleanValue() && !listaDocumenti.isEmpty()) {
            report.writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Documenti"));
            CenterMiddleTable tbl = new CenterMiddleTable(1);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Titolo.del.documento"));
            tbl.endHeaders();
            tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);

            for (ReportAttLav_Documenti_View Documento : listaDocumenti) {
                tbl.addCell(Documento.TIT_DOC);
            }
            report.m_document.add(tbl);

        }

    }
}
