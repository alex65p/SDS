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

import com.apconsulting.luna.ejb.AttivitaLavorative.AttivitaLavorative_Name_View;
import com.apconsulting.luna.ejb.AttivitaLavorative.IAttivitaLavorativeHome;
import com.apconsulting.luna.ejb.Azienda.IAzienda;
import com.apconsulting.luna.ejb.Azienda.IAziendaHome;
import com.apconsulting.luna.ejb.MisurePreventive.IMisurePreventiveHome;
import com.apconsulting.luna.ejb.MisurePreventive.ReportMisurePreventive_View;
import com.apconsulting.luna.ejb.Rischio.IRischioHome;
import com.apconsulting.luna.ejb.Rischio.ReportRischio_Name_View;
import com.apconsulting.luna.ejb.SediAziendali.ISitaAziendeHome;
import com.apconsulting.luna.ejb.SediAziendali.SiteAziendaleByAZLID_View;
import com.lowagie.text.BadElementException;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Rectangle;
import java.io.IOException;
import java.util.Iterator;
import s2s.ejb.pseudoejb.PseudoContext;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.report.CenterMiddleTable;
import s2s.report.Report;
import s2s.utils.plain.Formatter;

/**
 *
 * @author Dario
 */
public class Report_LIS_INR_MAN_AZL extends Report {

    public long lCOD_AZL = 0;
    public long lCOD_MAN = 0;
    public boolean bShowSito = true;

    public Report_LIS_INR_MAN_AZL(long lCOD_AZL) {
        this.lCOD_AZL = lCOD_AZL;
    }

    @Override
    public void doReport() throws DocumentException, IOException, BadElementException, Exception { //----------------------------------------------------------------------

        IAziendaHome home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
        IAzienda bean_az = home.findByPrimaryKey(new Long(lCOD_AZL));


        IAttivitaLavorativeHome h = (IAttivitaLavorativeHome) PseudoContext.lookup("AttivitaLavorativeBean");
        IRischioHome home_rs = (IRischioHome) PseudoContext.lookup("RischioBean");
        IMisurePreventiveHome home_mp = (IMisurePreventiveHome) PseudoContext.lookup("MisurePreventiveBean");


        this.bRotate = true;
        initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("LISTA.DEGLI.INTERVENTI.AZIENDALI"), bean_az.getRAG_SCL_AZL(), null);
        AddImage();
        {
            CenterMiddleTable tbl = new CenterMiddleTable(1);
            tbl.setOffset(0);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
            tbl.addCell(bean_az.getRAG_SCL_AZL());
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("LISTA.DEGLI.INTERVENTI.AZIENDALI"));
            m_document.add(tbl);
        }
        writeIndent();
        {
            CenterMiddleTable tbl = null;
            if (!bShowSito) {
                tbl = new CenterMiddleTable(8);
                int width[] = {5, 6, 12, 5, 25, 15, 7, 10};
                tbl.setWidths(width);
            } else {
                tbl = new CenterMiddleTable(9);
                int width[] = {5, 5, 6, 12, 5, 25, 15, 7, 10};
                tbl.setWidths(width);
            }

            tbl.toLeft();
            tbl.setDefaultCellBorder(Rectangle.BOTTOM | Rectangle.TOP | Rectangle.LEFT | Rectangle.RIGHT);

            if (!bShowSito) {
                Iterator it = h.getAttivitaLavorative_Name_View(lCOD_AZL).iterator();
                while (it.hasNext()) {
                    AttivitaLavorative_Name_View w = (AttivitaLavorative_Name_View) it.next();
                    drawLuogoFisico(home_rs, home_mp, tbl, w.NOM_MAN, w.COD_MAN, bShowSito);
                }
            } else {
                ISitaAziendeHome home_sa = (ISitaAziendeHome) PseudoContext.lookup("SitaAziendeBean");
                Iterator it = home_sa.getNonEmptySiteAziendaleByAZLID_View(lCOD_AZL).iterator();
                while (it.hasNext()) {
                    SiteAziendaleByAZLID_View w = (SiteAziendaleByAZLID_View) it.next();
                    tbl.setDefaultCellBorder(Rectangle.BOTTOM | Rectangle.TOP | Rectangle.LEFT | Rectangle.RIGHT);
                    tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Sito.aziendale"), 9);
                    tbl.addHeaderCellI(w.NOM_SIT_AZL, 9);

                    Iterator it2 = h.getAttivitaLavorative_Name_ViewBySito(w.COD_SIT_AZL).iterator();

                    while (it2.hasNext()) {
                        AttivitaLavorative_Name_View ww = (AttivitaLavorative_Name_View) it2.next();
                        drawLuogoFisico(home_rs, home_mp, tbl, ww.NOM_MAN, ww.COD_MAN, bShowSito);
                    }

                }
            }
            m_document.add(tbl);
        }
        closeDocument();
    }

    public void drawLuogoFisico(IRischioHome home_rs, IMisurePreventiveHome home_mp, CenterMiddleTable tbl, String strName, long lCOD_MAN, boolean bShowSito) throws BadElementException {

        int iTmp = bShowSito ? 1 : 0;
        tbl.setDefaultCellBorder(Rectangle.BOTTOM | Rectangle.TOP | Rectangle.LEFT | Rectangle.RIGHT);
        if (bShowSito) {
            tbl.setDefaultCellBorder(0);
            tbl.addCell("", 0, 1);
            tbl.setDefaultCellBorder(Rectangle.BOTTOM | Rectangle.TOP | Rectangle.LEFT | Rectangle.RIGHT);
        }
        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa"), 8);
        if (bShowSito) {
            tbl.setDefaultCellBorder(0);
            tbl.addCell("", 0, 1);
            tbl.setDefaultCellBorder(Rectangle.BOTTOM | Rectangle.TOP | Rectangle.LEFT | Rectangle.RIGHT);
        }
        tbl.addHeaderCellI(strName, 8);
        tbl.setDefaultCellBorder(0);
        {
            Iterator it2 = home_rs.getReportRischioByMAN_Name_View(lCOD_AZL, lCOD_MAN).iterator();
            while (it2.hasNext()) {
                ReportRischio_Name_View ww = (ReportRischio_Name_View) it2.next();
                tbl.addCell("", 0, 1 + iTmp);
                tbl.addCellB(ApplicationConfigurator.LanguageManager.getString("Rischio") + ":", 0, 1);
                tbl.addCell(Formatter.format(ww.strNOM_RSO), 0, 4);
                tbl.toRight();
                tbl.addCellB(ApplicationConfigurator.LanguageManager.getString("PxD") + ":", 0, 1);
                tbl.toLeft();
                tbl.addCell(Formatter.format(ww.lSTM_NUM_RSO));
                {
                    Iterator it3 = home_mp.getReportMisurePreventive_View(ww.lCOD_RSO_MAN).iterator();
                    while (it3.hasNext()) {
                        ReportMisurePreventive_View www = (ReportMisurePreventive_View) it3.next();
                        tbl.addCell("", 0, 2 + iTmp);
                        tbl.addCellB(ApplicationConfigurator.LanguageManager.getString("Misure") + ":", 0, 1);
                        tbl.addCell(www.strNOM_MIS_PET + "\n" + www.strDES_MIS_PET, 0, 3);
                        tbl.toRight();
                        tbl.addCellB(ApplicationConfigurator.LanguageManager.getString("Dt.Comp.") + ":", 0, 1);
                        tbl.toLeft();
                        tbl.addCell(Formatter.format(www.dtDAT_CMP));
                        //tbl.setDefaultColspan(7);
                        {
                            CenterMiddleTable tb = tbl;//new CenterMiddleTable(4);
                            //tb.toLeft();
                            tbl.addCell("", 0, 2 + iTmp);
                            tb.addCellB(ApplicationConfigurator.LanguageManager.getString("Data.pianificazione") + ":", 0, 2);
                            tb.addCellB(ApplicationConfigurator.LanguageManager.getString("Referente.dell'intervento") + ":", 0, 1);
                            tb.addCellB(ApplicationConfigurator.LanguageManager.getString("Data.bonifica") + ":", 0, 1);
                            tb.addCellB(ApplicationConfigurator.LanguageManager.getString("Costo.intervento") + ":", 0, 2);

                            tbl.addCell("", 0, 2 + iTmp);
                            tb.addCell(".... / .... / ....", 0, 2);
                            tb.addCell(".............................................");
                            tb.addCell(".... / .... / ....");
                            tb.addCell(".................................", 0, 2);
                            //tbl.insertTable(tb);
                        }
                        //tbl.setDefaultColspan(1);
                    }
                }
            }
        }

    }//end drawLuogo fiz
}
