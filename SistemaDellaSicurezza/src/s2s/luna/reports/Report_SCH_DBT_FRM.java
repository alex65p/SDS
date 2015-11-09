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
import com.apconsulting.luna.ejb.Dipendente.Dipendenti_FOD_DBT_View;
import com.apconsulting.luna.ejb.Dipendente.IDipendenteHome;
import com.lowagie.text.BadElementException;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import java.io.IOException;
import s2s.ejb.pseudoejb.PseudoContext;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.report.CenterMiddleTable;
import s2s.report.Report;
import s2s.luna.util.SecurityWrapper;
import s2s.utils.plain.Formatter;

/**
 *
 * @author Dario
 */
public class Report_SCH_DBT_FRM extends Report {

    public long lCOD_AZL = 0;
    private String NOM_MAN = "";
    //---------------------

    public Report_SCH_DBT_FRM(String NOM_MAN) {
        this.NOM_MAN = NOM_MAN;
    }
    //------------------------------------------------------------------------------------------

    @Override
    public void doReport() throws DocumentException, IOException, BadElementException, Exception {
        SecurityWrapper Security = SecurityWrapper.getInstance();
        lCOD_AZL = Security.getAziendaR();
        IAziendaHome azienda_home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
        IAzienda azienda = azienda_home.findByPrimaryKey(new Long(lCOD_AZL));
        
        IDipendenteHome home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
        initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("DEBITO.FORMATIVO"), azienda.getRAG_SCL_AZL(), null);
        AddImage();
        writeIndent();
        {
            CenterMiddleTable tbl = new CenterMiddleTable(1);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
            tbl.addCell(azienda.getRAG_SCL_AZL());
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("DEBITO.FORMATIVO"));
            m_document.add(tbl);
        }
        {
            CenterMiddleTable tbl = new CenterMiddleTable(3);
            tbl.toLeft();
            int width[] = {40, 40, 20};
            tbl.setWidths(width);
            tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dipendente"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Corso"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.corso"));
            java.util.Iterator it = home.getDipendenti_FOD_DBT_View(lCOD_AZL, NOM_MAN, false).iterator();
            while (it.hasNext()) {
                Dipendenti_FOD_DBT_View w = (Dipendenti_FOD_DBT_View) it.next();
                tbl.addCell(Formatter.format(w.COG_DPD + " " + w.NOM_DPD));
                tbl.addCell(Formatter.format(w.NOM_COR));
                tbl.addCell(Formatter.format(w.DAT_COR));
            }
            m_document.add(tbl);
        }
        closeDocument();
    }
}
