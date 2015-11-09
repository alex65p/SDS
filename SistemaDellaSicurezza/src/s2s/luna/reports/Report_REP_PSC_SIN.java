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

package s2s.luna.reports;

/**
 *
 * @author Alessandro
 */
import com.apconsulting.luna.ejb.PSC.IPSC;
import com.apconsulting.luna.ejb.PSC.IPSCHome;
import com.apconsulting.luna.ejb.SezioneGenerale.IsezioneGeneraleHome;
import com.apconsulting.luna.ejb.SezioneParticolare.ISezioneParticolareHome;
import com.apconsulting.luna.ejb.SchedediSicurezza.ISchedediSicurezzaHome;
import com.apconsulting.luna.ejb.Fascicolo.IFascicoloHome;
import com.apconsulting.luna.ejb.Azienda.IAzienda;
import com.apconsulting.luna.ejb.Azienda.IAziendaHome;
import com.apconsulting.luna.ejb.PSC.Fascicolo_All_View;
import com.apconsulting.luna.ejb.PSC.SchedeSicurezza_All_View;
import com.apconsulting.luna.ejb.PSC.SezioneParticolare_All_View;
import com.apconsulting.luna.ejb.SezioneGenerale.SezioneGenerale_View;

import com.lowagie.text.BadElementException;
import com.lowagie.text.DocumentException;
import java.io.IOException;
import s2s.ejb.pseudoejb.PseudoContext;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.report.CenterMiddleTable;
import s2s.report.Report;
import s2s.utils.plain.Formatter;
import s2s.luna.util.SecurityWrapper;

/**
 *
 * @author Dario
 */
public class Report_REP_PSC_SIN extends Report {

    public long lCOD_PSC = 0;
    private boolean IncludeLogo = true;

    public Report_REP_PSC_SIN(long lCOD_PSC) {
        this.lCOD_PSC = lCOD_PSC;
    }

    public Report_REP_PSC_SIN(long lCOD_PSC, boolean _IncludeLogo) {
        this(lCOD_PSC);
        this.IncludeLogo = _IncludeLogo;
    }

    @Override
    public void doReport() throws DocumentException, IOException, BadElementException, Exception { //----------------------------------------------------------------------

        SecurityWrapper Security = SecurityWrapper.getInstance();
        IPSCHome home = (IPSCHome) PseudoContext.lookup("PSCBean");
        IPSC bean = home.findByPrimaryKey(new Long(lCOD_PSC));

        IsezioneGeneraleHome home_sg = (IsezioneGeneraleHome) PseudoContext.lookup("SezioneGeneraleBean");
        ISchedediSicurezzaHome home_ss = (ISchedediSicurezzaHome) PseudoContext.lookup("SchedediSicurezzaBean");
        IFascicoloHome home_fo = (IFascicoloHome) PseudoContext.lookup("FascicoloBean");
        ISezioneParticolareHome home_sp = (ISezioneParticolareHome) PseudoContext.lookup("SezioneParticolareBean");

        lCOD_AZL = Security.getAziendaR();
        IAziendaHome home_az = (IAziendaHome) PseudoContext.lookup("AziendaBean");
        IAzienda bean_az = home_az.findByPrimaryKey(new Long(lCOD_AZL));

        bRotate = true;
        initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("SOMMARIO.PSC"), bean_az.getRAG_SCL_AZL(), bean.getstrCOD());
        writeTitle(ApplicationConfigurator.LanguageManager.getString("Schema.sinottico.PSC"));
        if (IncludeLogo) {
            AddImage();
        }

        writeTitle("Piano di Sicurezza e Coordinamento");

        writePage();
        writeIndent();
        {
            CenterMiddleTable tbl = new CenterMiddleTable(1);
            if (bStandAlone) {
                //  tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
                //  tbl.addCell(bean_az.getRAG_SCL_AZL());
            }
            tbl.addHeaderCellB(bean.getstrTIT());
            m_document.add(tbl);
        }
        {
            CenterMiddleTable tbl = new CenterMiddleTable(6);
            tbl.toLeft();
            int width[] = {15, 32, 12, 11, 10, 20};
            tbl.setWidths(width);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Sezioni"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Oggetto"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Rev."));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.emiss"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.prot"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Codice.elaborato"));
            m_document.add(tbl);
        }

        {
            CenterMiddleTable tbl = new CenterMiddleTable(6);
            tbl.toLeft();
            int width[] = {15, 32, 12, 11, 10, 20};
            tbl.setWidths(width);
            java.util.Collection col = home_sg.getSezioneGeneralePSCByID_View_SINTETICA(lCOD_PSC,bean.getlCOD_PRO());
            java.util.Iterator it = col.iterator();
            while (it.hasNext()) {
            SezioneGenerale_View obj = (SezioneGenerale_View) it.next();
                tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Sezione.generale"));
                tbl.addCell(obj.OGG);
                if (obj.REV.equals("1")) {
                    String REV = "Emiss.";
                    tbl.addCell(REV);
                }
                if (obj.REV.equals("0")) {
                    String REV = "In Lav.";
                    tbl.addCell(REV);
                }
                if ((!obj.REV.equals("0")) && (!obj.REV.equals("1"))) {
                    tbl.addCell(obj.REV);
                }
                tbl.addCell(Formatter.format(obj.DAT_EMI));
                tbl.addCell(Formatter.format(obj.DAT_PRO));
                tbl.addCell(obj.DOC_COL);
            }
            m_document.add(tbl);

        }
        {
            CenterMiddleTable tbl = new CenterMiddleTable(6);
            tbl.toLeft();
            int width[] = {15, 32, 12, 11, 10, 20};
            tbl.setWidths(width);

            java.util.Collection col = home_ss.getSchedediSicurezzaPSCByID_View_SINTETICA(lCOD_PSC,bean.getlCOD_PRO());
            java.util.Iterator it = col.iterator();
            while (it.hasNext()) {
                SchedeSicurezza_All_View obj = (SchedeSicurezza_All_View) it.next();
                tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Schede.di.sicurezza"));
                tbl.addCell(obj.OGG);
                if (obj.REV.equals("1")) {
                    String REV = "Emiss.";
                    tbl.addCell(REV);
                }
                if (obj.REV.equals("0")) {
                    String REV = "In Lav.";
                    tbl.addCell(REV);
                }
                if ((!obj.REV.equals("0")) && (!obj.REV.equals("1"))) {

                    tbl.addCell(obj.REV);
                }
                tbl.addCell(Formatter.format(obj.DAT_EMI));
                tbl.addCell(Formatter.format(obj.DAT_PRO));
                tbl.addCell(obj.DOC_COL);
            }
            m_document.add(tbl);
        }
        {
            CenterMiddleTable tbl = new CenterMiddleTable(6);
            tbl.toLeft();
            int width[] = {15, 32, 12, 11, 10, 20};
            tbl.setWidths(width);
            java.util.Collection col = home_fo.getFascicoloPSCByID_View_SINTETICA(lCOD_PSC,bean.getlCOD_PRO());
            java.util.Iterator it = col.iterator();
            while (it.hasNext()) {
                Fascicolo_All_View obj = (Fascicolo_All_View) it.next();
                tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Fascicolo.dell.opera"));
                tbl.addCell(obj.OGG);
                if (obj.REV.equals("1")) {
                    String REV = "Emiss.";
                    tbl.addCell(REV);
                }
                if (obj.REV.equals("0")) {
                    String REV = "In Lav.";
                    tbl.addCell(REV);
                }
                if ((!obj.REV.equals("0")) && (!obj.REV.equals("1"))) {
                    tbl.addCell(obj.REV);
                }
                tbl.addCell(Formatter.format(obj.DAT_EMI));
                tbl.addCell(Formatter.format(obj.DAT_PRO));
                tbl.addCell(obj.DOC_COL);
            }
            m_document.add(tbl);
        }
        {
            CenterMiddleTable tbl = new CenterMiddleTable(6);
            tbl.toLeft();
            int width[] = {15, 32, 12, 11, 10, 20};
            tbl.setWidths(width);
            java.util.Iterator it = home_sp.getSezioneParticolarePSCByID_View_SINTETICA(lCOD_PSC,bean.getlCOD_PRO(),lCOD_AZL).iterator();
            while (it.hasNext()) {
                SezioneParticolare_All_View obj = (SezioneParticolare_All_View) it.next();
                tbl.addCell(obj.COD + "-" + obj.TIT);
                tbl.addCell(obj.OGG);
                if (obj.REV.equals("1")) {
                    String REV = "Emiss.";
                    tbl.addCell(REV);
                }
                if (obj.REV.equals("0")) {
                    String REV = "In Lav.";
                    tbl.addCell(REV);
                }
                if ((!obj.REV.equals("0")) && (!obj.REV.equals("1"))) {
                    tbl.addCell(obj.REV);
                }
                tbl.addCell(Formatter.format(obj.DAT_EMI));
                tbl.addCell(Formatter.format(obj.DAT_PRO));
                tbl.addCell(obj.DOC_COL);
            }
            m_document.add(tbl);
        }

        closeDocument();
    }
}
