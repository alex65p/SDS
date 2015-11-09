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
import com.apconsulting.luna.ejb.AziendaTelefono.AziendaTelefoniByAZLID_View;
import com.apconsulting.luna.ejb.AziendaTelefono.IAziendaTelefonoHome;
import com.apconsulting.luna.ejb.Consulente.ConsultantiByAZLID_View;
import com.apconsulting.luna.ejb.Consulente.IConsultantHome;
import com.apconsulting.luna.ejb.Dipendente.DipendentiByAZLID_View;
import com.apconsulting.luna.ejb.Dipendente.IDipendenteHome;
import com.apconsulting.luna.ejb.DittaEsterna.DittaEsterneByAZLID_View;
import com.apconsulting.luna.ejb.DittaEsterna.IDittaEsternaHome;
import com.apconsulting.luna.ejb.Nazionalita.INazionalita;
import com.apconsulting.luna.ejb.Nazionalita.INazionalitaHome;
import com.apconsulting.luna.ejb.SediAziendali.ISitaAziendeHome;
import com.apconsulting.luna.ejb.SediAziendali.SiteAziendaleByAZLID_View;
import com.lowagie.text.BadElementException;
import com.lowagie.text.DocumentException;
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
public class Report_REP_AZL extends Report {

    public long lCOD_AZL = 0;
    private boolean IncludeLogo = true;

    public Report_REP_AZL(long lCOD_AZL) {
        this.lCOD_AZL = lCOD_AZL;
    }

    public Report_REP_AZL(long lCOD_FAT_RSO, boolean _IncludeLogo) {
        this(lCOD_FAT_RSO);
        this.IncludeLogo = _IncludeLogo;
    }

    @Override
    public void doReport() throws DocumentException, IOException, BadElementException, Exception { //----------------------------------------------------------------------
        String strTemp = "";
        IAziendaHome home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
        IAzienda bean = home.findByPrimaryKey(new Long(lCOD_AZL));

        initDocument("the doc", null, IncludeLogo
                ? ApplicationConfigurator.LanguageManager.getString("SCHEDA.AZIENDALE")
                : ApplicationConfigurator.LanguageManager.getString("Informazioni.preliminari"), bean.getRAG_SCL_AZL(), null);
        if (IncludeLogo) {
            AddImage();
        }
        writeIndent();
        {
            CenterMiddleTable tbl = new CenterMiddleTable(1);
            tbl.addHeaderCellB(IncludeLogo
                    ? ApplicationConfigurator.LanguageManager.getString("SCHEDA.AZIENDALE")
                    : ApplicationConfigurator.LanguageManager.getString("Informazioni.preliminari"));
            tbl.addTitleCell(bean.getRAG_SCL_AZL());
            m_document.add(tbl);
        }
        {
            CenterMiddleTable tbl = new CenterMiddleTable(2);
            tbl.toLeft();
            int width[] = {30, 79};
            tbl.setWidths(width);

            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Categoria.di.appartenenza"));// ok
            tbl.addCell(bean.getCAG_AZL());
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Indirizzo.n.civico"));// ok
            tbl.addCell(bean.getIDZ_AZL() + ", " + bean.getNUM_CIC_AZL());
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Città.C.A.P."));// ok
            if (bean.getCAP_AZL() != null) {
                tbl.addCell(bean.getCIT_AZL() + " - " + bean.getCAP_AZL());
            } else {
                tbl.addCell(bean.getCIT_AZL());
            }

            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Provincia"));// ok
            tbl.addCell(bean.getPRV_AZL());

            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Nazionalità"));// ok
            {
                strTemp = "";
                INazionalitaHome h = (INazionalitaHome) PseudoContext.lookup("NazionalitaBean");
                INazionalita b = h.findByPrimaryKey(new Long(bean.getCOD_STA()));
                tbl.addCell(b.getNOM_STA());
            }

            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Attività.svolta")); //ok
            tbl.addCell(bean.getDES_ATI_SVO_AZL());
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro"));// ok
            tbl.addCell(bean.getNOM_RSP_AZL());
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Qualifica.del.datore.lavoro"));//ok
            tbl.addCell(bean.getQLF_RSP_AZL());

            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Resp.aziendale.SPP"));// ok
            tbl.addCell(bean.getNOM_RSP_SPP_AZL());
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Medico.competente"));// ok
            tbl.addCell(bean.getNOM_MED_AZL());
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("E-mail.aziendale"));// ok
            tbl.addCell(bean.getIDZ_PSA_ELT_RSP_AZL());
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Sito.internet.aziendale"));// ok
            tbl.addCell(bean.getSIT_INT_AZL());
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Azienda.associata"));
            if (bean.getCOD_AZL_ASC() == 0) {
                tbl.addCell("");
            } else {
                strTemp = "";
                IAziendaHome h = (IAziendaHome) PseudoContext.lookup("AziendaBean");
                IAzienda b = h.findByPrimaryKey(new Long(bean.getCOD_AZL_ASC()));

                tbl.addCell(b.getRAG_SCL_AZL());
            }
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Codice.ISTAT"));//ok
            tbl.addCell(bean.getCOD_IST_TAT_AZL());
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Telefoni.utili"));//ok
            {
                strTemp = "";
                IAziendaTelefonoHome h = (IAziendaTelefonoHome) PseudoContext.lookup("AziendaTelefonoBean");
                Iterator it = h.getAziendaTelefoniByAZLID_View(lCOD_AZL).iterator();
                while (it.hasNext()) {
                    AziendaTelefoniByAZLID_View w = (AziendaTelefoniByAZLID_View) it.next();
                    strTemp += w.NUM_TEL;
                    if (it.hasNext()) {
                        strTemp += ", ";
                    }
                }
                tbl.addCell(strTemp);
            }
            m_document.add(tbl);
        }
        if (IncludeLogo) {
            {//ditte esterne
                CenterMiddleTable tbl = new CenterMiddleTable(4);
                tbl.toLeft();
                int width[] = {32, 100 - 30 - 17 - 32, 30, 17};
                tbl.setWidths(width);

                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Ditte.esterne.associate"));// ok
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Categoria"));
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Responsabile"));
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Città"));
                tbl.endHeaders();

                IDittaEsternaHome h = (IDittaEsternaHome) PseudoContext.lookup("DittaEsternaBean");
                Iterator it = h.getDittaEsterneByAZLID_View(lCOD_AZL).iterator();
                while (it.hasNext()) {
                    DittaEsterneByAZLID_View w = (DittaEsterneByAZLID_View) it.next();
                    tbl.addCell(w.RAG_SCL_DTE);
                    tbl.addCell(w.CAG_DTE);
                    tbl.addCell(w.NOM_RSP_DTE);
                    tbl.addCell(w.CIT_DTE);
                }

                m_document.add(tbl);
            }
            {//consulenti
                CenterMiddleTable tbl = new CenterMiddleTable(4);
                tbl.toLeft();
                int width[] = {32, 100 - 15 - 17 - 32, 15, 17};
                tbl.setWidths(width);

                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Consulente"));// ok
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Ruolo"));
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dt.Attiv."));
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dt.Disattiv."));
                tbl.endHeaders();

                IConsultantHome h = (IConsultantHome) PseudoContext.lookup("ConsultantBean");
                Iterator it = h.getConsultantiByAZLID_View(lCOD_AZL).iterator();
                while (it.hasNext()) {
                    ConsultantiByAZLID_View w = (ConsultantiByAZLID_View) it.next();
                    tbl.addCell(w.NOM_COU);
                    tbl.addCell(w.RUO_COU);
                    tbl.addCell(Formatter.format(w.DAT_ATT));
                    tbl.addCell(Formatter.format(w.DAT_DIS));
                }

                m_document.add(tbl);
            }
            {//siti aziendali
                CenterMiddleTable tbl = new CenterMiddleTable(4);
                tbl.toLeft();
                int width[] = {32, 35, 25, 8};
                tbl.setWidths(width);

                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Sito.aziendale"));// ok
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Indirizzo.n.civico"));
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Città.C.A.P."));
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Prov."));

                tbl.endHeaders();

                ISitaAziendeHome h = (ISitaAziendeHome) PseudoContext.lookup("SitaAziendeBean");
                Iterator it = h.getSiteAziendaleByAZLID_View(lCOD_AZL).iterator();
                while (it.hasNext()) {
                    SiteAziendaleByAZLID_View w = (SiteAziendaleByAZLID_View) it.next();

                    tbl.addCell(w.NOM_SIT_AZL);
                    tbl.addCell(w.IDZ_SIT_AZL + ", " + Formatter.format(w.NUM_CIC_SIT_AZL));
                    if (w.CAP_SIT_AZL != null) {
                        tbl.addCell(w.CIT_SIT_AZL + " - " + Formatter.format(w.CAP_SIT_AZL));
                    } else {
                        tbl.addCell(w.CIT_SIT_AZL);
                    }
                    tbl.addCell(Formatter.format(w.PRV_SIT_AZL));
                }

                m_document.add(tbl);
            }
        }
        {//rappresentanti dei lavoratori
            writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Rappresentanti.dei.lavoratori"));
            CenterMiddleTable tbl = new CenterMiddleTable(4);
            tbl.toLeft();
            int width[] = {13, 31, 31, 25};
            tbl.setWidths(width);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Matricola"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Cognome"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Nome"));
            tbl.addHeaderCellB("");
            tbl.endHeaders();

            IDipendenteHome home_dpd = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
            java.util.Iterator it_dip = home_dpd.getDipendentiByAZLID_RLS_View(lCOD_AZL).iterator();
            while (it_dip.hasNext()) {
                DipendentiByAZLID_View dt = (DipendentiByAZLID_View) it_dip.next();
                tbl.addCell(Formatter.format(dt.MTR_DPD));
                tbl.addCell(Formatter.format(dt.COG_DPD));
                tbl.addCell(Formatter.format(dt.NOM_DPD));
                tbl.addCell("");
            }
            m_document.add(tbl);
        }
        closeDocument();
    }
}
