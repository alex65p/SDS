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
import com.apconsulting.luna.ejb.UnitaSicurezza.IUnitaSicurezza;
import com.apconsulting.luna.ejb.UnitaSicurezza.IUnitaSicurezzaHome;
import com.apconsulting.luna.ejb.UnitaSicurezza.USResponsabileView;
import com.apconsulting.luna.ejb.UnitaSicurezza.UnitaSicurezzaView;
import com.lowagie.text.BadElementException;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import java.io.IOException;
import java.util.Iterator;
import s2s.ejb.pseudoejb.PseudoContext;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.conf.ModuleManager.MODULES;
import s2s.luna.util.SecurityWrapper;
import s2s.report.CenterMiddleTable;
import s2s.report.Report;

/**
 *
 * @author Dario
 */
public class Report_REP_ANA_UNI_SIC extends Report {

    public long lCOD_UNI_SIC = 0;
    private boolean IncludeLogo = true;

    public Report_REP_ANA_UNI_SIC() {
    }

    public Report_REP_ANA_UNI_SIC(boolean _IncludeLogo) {
        this();
        this.IncludeLogo = _IncludeLogo;
    }

    @Override
    public void doReport() throws DocumentException, IOException, BadElementException, Exception { //----------------------------------------------------------------------
        SecurityWrapper Security = SecurityWrapper.getInstance();

        IUnitaSicurezzaHome home_uni = (IUnitaSicurezzaHome) PseudoContext.lookup("UnitaSicurezzaBean");
        IUnitaSicurezza bean_uni = home_uni.findByPrimaryKey(new Long(lCOD_UNI_SIC));
        lCOD_AZL = bean_uni.getCOD_AZL();

        IAziendaHome home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
        IAzienda bean_az = home.findByPrimaryKey(new Long(lCOD_AZL));

        initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("Organigramma.della.sicurezza"), bean_az.getRAG_SCL_AZL(), null);

        if (IncludeLogo) {
            AddImage();
        }

        writeTitle("\n" + ApplicationConfigurator.LanguageManager.getString("Organigramma.della.sicurezza"));// bean_uni.getNOM_UNI_ORG()

        {
            CenterMiddleTable tbl = new CenterMiddleTable(1);
            if (bStandAlone) {
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
                tbl.addCell(bean_az.getRAG_SCL_AZL());//
            }
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Responsabile.azienda"));
            tbl.addCell(bean_az.getNOM_RSP_AZL());

            m_document.add(tbl);
        }
        {

            CenterMiddleTable tbl = null;
            if (ApplicationConfigurator.isModuleEnabled(MODULES.UNI_SIC_4_DIP)) {
                tbl = new CenterMiddleTable(3);

                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Nome.unità.sic."));
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Lavoratori"));
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Ruoli.sicurezza"));
                tbl.endHeaders();
                tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                tbl.addCell(bean_uni.getNOM_UNI_SIC());
                USResponsabileView dpd_ruo_sic = getResponsabileSicurezza(bean_uni);
                tbl.addCell(dpd_ruo_sic.strNOM_RESP_SIC);
                tbl.addCell(dpd_ruo_sic.strNOM_RUO_SIC);
                drawChildrenSicurezza(tbl, home_uni, bean_uni, 1);
            } else {
                tbl = new CenterMiddleTable(2);

                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Nome.unità.sic."));
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Responsabili"));
                tbl.endHeaders();
                tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                tbl.addCell(bean_uni.getNOM_UNI_SIC());
                tbl.addCell(getResponsabile(bean_uni));
                drawChildren(tbl, home_uni, bean_uni, 1);
            }
            m_document.add(tbl);
        }
        closeDocument();
    }

    String getResponsabile(IUnitaSicurezza bean_uni) {
        Iterator it = bean_uni.getResponsabile().iterator();
        String strTemp = "";
        while (it.hasNext()) {
            USResponsabileView w = (USResponsabileView) it.next();
            strTemp += w.strCOG_DPD + " " + w.strNOM_DPD;
            if (it.hasNext()) {
                strTemp += "\n";
            }
        }
        return strTemp;
    }

    USResponsabileView getResponsabileSicurezza(IUnitaSicurezza bean_uni) {
        Iterator it_ruo_sic = bean_uni.getResponsabiliSicurezza().iterator();
        USResponsabileView dpd_ruo_sic = new USResponsabileView();
        dpd_ruo_sic.strNOM_RESP_SIC = "";
        dpd_ruo_sic.strNOM_RUO_SIC = "";
        while (it_ruo_sic.hasNext()) {
            USResponsabileView w = (USResponsabileView) it_ruo_sic.next();
            dpd_ruo_sic.strNOM_RESP_SIC += w.strCOG_DPD + " " + w.strNOM_DPD;
            dpd_ruo_sic.strNOM_RUO_SIC += w.strNOM_RUO_SIC;
            if (it_ruo_sic.hasNext()) {
                dpd_ruo_sic.strNOM_RESP_SIC += "\n";
                dpd_ruo_sic.strNOM_RUO_SIC += "\n";
            }
        }
        return dpd_ruo_sic;
    }

    void drawChildren(CenterMiddleTable tbl, IUnitaSicurezzaHome home_uni, IUnitaSicurezza bean_uni, int iLevel) throws Exception {
        Iterator it = bean_uni.getChildren(bean_uni.getCOD_AZL()).iterator();
        while (it.hasNext()) {
            UnitaSicurezzaView uw = (UnitaSicurezzaView) it.next();
            String strTemp = "";
            for (int i = 0; i < iLevel; i++) {
                strTemp += "  ";
            }
            tbl.addCell(strTemp + " - " + uw.strNOM_UNI_SIC);

            IUnitaSicurezza bean_u = home_uni.findByPrimaryKey(new Long(uw.lCOD_UNI_SIC));
            tbl.addCell(getResponsabile(bean_u));
            drawChildren(tbl, home_uni, bean_u, iLevel + 1);
        }

    }

    void drawChildrenSicurezza(CenterMiddleTable tbl, IUnitaSicurezzaHome home_uni, IUnitaSicurezza bean_uni, int iLevel) throws Exception {
        Iterator it = bean_uni.getChildren(bean_uni.getCOD_AZL()).iterator();
        while (it.hasNext()) {
            UnitaSicurezzaView uw = (UnitaSicurezzaView) it.next();
            String strTemp = "";
            for (int i = 0; i < iLevel; i++) {
                strTemp += "  ";
            }
            tbl.addCell(strTemp + " - " + uw.strNOM_UNI_SIC);

            IUnitaSicurezza bean_u = home_uni.findByPrimaryKey(new Long(uw.lCOD_UNI_SIC));
            USResponsabileView dpd_ruo_sic = getResponsabileSicurezza(bean_u);
            tbl.addCell(dpd_ruo_sic.strNOM_RESP_SIC);
            tbl.addCell(dpd_ruo_sic.strNOM_RUO_SIC);
            drawChildrenSicurezza(tbl, home_uni, bean_u, iLevel + 1);
        }

    }
}
