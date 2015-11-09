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
import com.apconsulting.luna.ejb.Dipendente.DipendentiByAZLID_View;
import com.apconsulting.luna.ejb.Dipendente.IDipendenteHome;
import com.apconsulting.luna.ejb.Immobili3lv.IImmobili3lvHome;
import com.apconsulting.luna.ejb.Immobili3lv.Immobili3liv_View;
import com.apconsulting.luna.ejb.Nazionalita.INazionalita;
import com.apconsulting.luna.ejb.Nazionalita.INazionalitaHome;
import com.lowagie.text.BadElementException;
import com.lowagie.text.Cell;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Rectangle;
import java.io.IOException;
import java.util.Iterator;
import s2s.ejb.pseudoejb.PseudoContext;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.report.CenterMiddleTable;
import s2s.report.Report;
import s2s.utils.plain.Formatter;
import s2s.utils.text.StringManager;

/**
 *
 * @author Dario
 */
public class Report_REP_AZL_GSE extends Report {

    public long lCOD_AZL = 0;
    private boolean IncludeLogo = true;

    public Report_REP_AZL_GSE(long lCOD_AZL) {
        this.lCOD_AZL = lCOD_AZL;
    }

    public Report_REP_AZL_GSE(long lCOD_FAT_RSO, boolean _IncludeLogo) {
        this(lCOD_FAT_RSO);
        this.IncludeLogo = _IncludeLogo;
    }

    @Override
    public void doReport() throws DocumentException, IOException, BadElementException, Exception {
        String strTemp = "";
        IAziendaHome home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
        IAzienda bean = home.findByPrimaryKey(new Long(lCOD_AZL));

        initDocument("the doc", null, IncludeLogo
                ? ApplicationConfigurator.LanguageManager.getString("SCHEDA.AZIENDALE")
                : ApplicationConfigurator.LanguageManager.getString("Informazioni.preliminari"), bean.getRAG_SCL_AZL(), null);
        if (IncludeLogo) {
            AddImage();
        }
        // writeIndent();
        {
            CenterMiddleTable tbl = new CenterMiddleTable(1);
            tbl.addHeaderCellB(IncludeLogo
                    ? ApplicationConfigurator.LanguageManager.getString("SCHEDA.AZIENDALE")
                    : ApplicationConfigurator.LanguageManager.getString("Informazioni.preliminari"));
            tbl.addTitleCell(bean.getRAG_SCL_AZL());
            m_document.add(tbl);
        }
        {// Dati anagrafici
            writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Dati.anagrafici"));
            CenterMiddleTable tbl = new CenterMiddleTable(2);
            tbl.toLeft();
            int width[] = {30, 79};
            tbl.setWidths(width);

            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Attività.svolta")); //ok
            tbl.addCell(bean.getDES_ATI_SVO_AZL());
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
            strTemp = "";
            INazionalitaHome h = (INazionalitaHome) PseudoContext.lookup("NazionalitaBean");
            INazionalita b = h.findByPrimaryKey(new Long(bean.getCOD_STA()));
            tbl.addCell(b.getNOM_STA());
            m_document.add(tbl);
        }
        {// Dati sulla sicurezza
            writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Dati.sulla.sicurezza"));
            CenterMiddleTable tbl = new CenterMiddleTable(2);
            tbl.toLeft();
            int width[] = {30, 79};
            tbl.setWidths(width);

            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro"));// ok
            tbl.addCell(bean.getNOM_RSP_AZL());
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Qualifica.del.datore.lavoro"));//ok
            tbl.addCell(bean.getQLF_RSP_AZL());

            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Resp.aziendale.SPP"));// ok
            tbl.addCell(bean.getNOM_RSP_SPP_AZL());
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Medico.competente"));// ok
            tbl.addCell(bean.getNOM_MED_AZL());
            m_document.add(tbl);
        }
        {// Altro
            writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Altro"));
            CenterMiddleTable tbl = new CenterMiddleTable(2);
            tbl.toLeft();
            int width[] = {30, 79};
            tbl.setWidths(width);

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
            m_document.add(tbl);
        }
        {// Rappresentanti dei lavoratori
            writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Rappresentanti.dei.lavoratori"));
            CenterMiddleTable tbl = new CenterMiddleTable(2);
            tbl.toLeft();
            int width[] = {30, 79};
            tbl.setWidths(width);

            Cell rlsCell = new Cell(ApplicationConfigurator.LanguageManager.getString("R.L.S."));
            rlsCell.setVerticalAlignment(Element.ALIGN_TOP);
            tbl.addCell(rlsCell);//ok
            strTemp = "";
            IDipendenteHome home_dpd = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
            java.util.Iterator it_dip = home_dpd.getDipendentiByAZLID_RLS_View(lCOD_AZL).iterator();
            while (it_dip.hasNext()) {
                DipendentiByAZLID_View dt = (DipendentiByAZLID_View) it_dip.next();
                strTemp += Formatter.format(dt.COG_DPD);
                strTemp += " " + Formatter.format(dt.NOM_DPD);
                if (it_dip.hasNext()) {
                    strTemp += "\n";
                }
            }
            tbl.addCell(strTemp);
            m_document.add(tbl);
        }
        {// Siti aziendali
            writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Sedi"));
            CenterMiddleTable tbl = new CenterMiddleTable(5);
            tbl.toLeft();
            int width[] = {22, 25, 25, 20, 8};
            tbl.setWidths(width);

            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Sede"));// ok
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Immobile"));// ok
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Indirizzo"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Città.C.A.P."));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Prov."));
            tbl.endHeaders();

            IImmobili3lvHome imm3lv = (IImmobili3lvHome) PseudoContext.lookup("Immobili3lvBean");
            Iterator imm3lv_it = imm3lv.findEx
                    (lCOD_AZL, null, null, null, null, null, null, null, null, 0).iterator();
            String previousNOM_SIT_AZL = "";
            while (imm3lv_it.hasNext()) {
                Immobili3liv_View immobile3lv = (Immobili3liv_View) imm3lv_it.next();
                Cell nomSitAzlCell = null;
                // Cambio sede
                if (previousNOM_SIT_AZL.equals(immobile3lv.NOM_SIT_AZL) == false) {
                    nomSitAzlCell = new Cell(immobile3lv.NOM_SIT_AZL);
                    if (imm3lv_it.hasNext()) {
                        nomSitAzlCell.setBorder(Rectangle.TOP | Rectangle.LEFT | Rectangle.RIGHT);
                    }
                // Sede uguale alle precedente
                } else {
                    nomSitAzlCell = new Cell("");
                    if (imm3lv_it.hasNext()) {
                        nomSitAzlCell.setBorder(Rectangle.LEFT | Rectangle.RIGHT);
                    } else {
                        nomSitAzlCell.setBorder(Rectangle.LEFT | Rectangle.RIGHT | Rectangle.BOTTOM);
                    }
                }
                tbl.addCell(nomSitAzlCell);
                previousNOM_SIT_AZL = immobile3lv.NOM_SIT_AZL;
                tbl.addCell(Formatter.format(immobile3lv.NOM_IMM));
                tbl.addCell
                        (Formatter.format(immobile3lv.IND_IMM) + 
                        (StringManager.isNotEmpty(immobile3lv.IND_IMM)&&StringManager.isNotEmpty(immobile3lv.NUM_CIV_IMM)?", ":"") + 
                        Formatter.format(immobile3lv.NUM_CIV_IMM));
                tbl.addCell
                        (Formatter.format(immobile3lv.CIT_IMM) + 
                        (StringManager.isNotEmpty(immobile3lv.CIT_IMM)&&StringManager.isNotEmpty(immobile3lv.CAP_IMM)?" - ":"") + 
                        Formatter.format(immobile3lv.CAP_IMM));
                tbl.addCell(Formatter.format(immobile3lv.PRO_IMM));
            }
            m_document.add(tbl);
        }
        closeDocument();
    }
}
