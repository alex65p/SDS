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

import com.apconsulting.luna.ejb.AttivitaLavorative.AttLav_VisteMediche_View;
import com.apconsulting.luna.ejb.AttivitaLavorative.IAttivitaLavorative;
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
public class Report_ChildSorveglianzaSanitaria extends Report_REP_MAN {

    public Report report;

    public Report_ChildSorveglianzaSanitaria(long lCOD_MAN, long lCOD_AZL, Report report) {
        super(lCOD_MAN, lCOD_AZL);
        this.report = report;
    }

    public Report_ChildSorveglianzaSanitaria(long lCOD_MAN, long lCOD_AZL, boolean _IncludeLogo, Report report) {
        super(lCOD_MAN, lCOD_AZL, _IncludeLogo);
        this.report = report;
    }

    public void writeRecordCard(Object superBean_man) throws DocumentException {
        IAttivitaLavorative bean_man = (IAttivitaLavorative) superBean_man;
        //
        //Esttraggo i dati relativi alle schede Sorveglianza.sanitaria
        //
        Collection<AttLav_VisteMediche_View> listaVisite = bean_man.getVisteMediche_View();

        if (this.allModuleByProfile.booleanValue()) {
            report.writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Sorveglianza.sanitaria"));
            report.writeText2(ApplicationConfigurator.LanguageManager.getString("MSG_REP_0011"));

            CenterMiddleTable tbl = new CenterMiddleTable(2);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Esami.dell'attività.lavorativa"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Periodicità"));
            tbl.endHeaders();
            tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);

            for (AttLav_VisteMediche_View Visita : listaVisite) {
                tbl.addCell(Visita.NOM_VST_IDO);
                // Periodicità Mensile
                if (Visita.FAT_PER.equals("M")) {
                    if (Visita.PER_VSTL == 1) {
                        tbl.addCell(Visita.PER_VSTL + " "
                                + ApplicationConfigurator.LanguageManager.getString("mese"));
                    } else {
                        tbl.addCell(Visita.PER_VSTL + " "
                                + ApplicationConfigurator.LanguageManager.getString("mesi"));
                    }
                    // Periodicità Unica
                } else if (Visita.FAT_PER.equals("U")) {
                    tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Unica"));
                }
            }
            report.m_document.add(tbl);
            if (listaVisite.isEmpty()) {
                report.writeParagraph3(DATI_NON_PRESENTI);
            }

        }
        /**
         * Se il profilo Attivo nel Sistema è MSR E Ci sono dati relativi Alle
         * Schede Sorveglianza.sanitaria Si stampa la scheda Altrimenti NON si
         * stampa nulla.
         *
         */
        if (!this.allModuleByProfile.booleanValue() && !listaVisite.isEmpty()) {
            report.writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Sorveglianza.sanitaria"));
            report.writeText2(ApplicationConfigurator.LanguageManager.getString("MSG_REP_0011"));

            CenterMiddleTable tbl = new CenterMiddleTable(2);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Esami.dell'attività.lavorativa"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Periodicità"));
            tbl.endHeaders();
            tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);

            for (AttLav_VisteMediche_View Visita : listaVisite) {
                tbl.addCell(Visita.NOM_VST_IDO);
                // Periodicità Mensile
                if (Visita.FAT_PER.equals("M")) {
                    if (Visita.PER_VSTL == 1) {
                        tbl.addCell(Visita.PER_VSTL + " "
                                + ApplicationConfigurator.LanguageManager.getString("mese"));
                    } else {
                        tbl.addCell(Visita.PER_VSTL + " "
                                + ApplicationConfigurator.LanguageManager.getString("mesi"));
                    }
                    // Periodicità Unica
                } else if (Visita.FAT_PER.equals("U")) {
                    tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Unica"));
                }
            }
            report.m_document.add(tbl);
            report.writeLine();
        }
        report.writeLine();
    }
}
