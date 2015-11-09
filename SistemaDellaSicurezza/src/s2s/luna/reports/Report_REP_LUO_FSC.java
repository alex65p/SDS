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

import com.apconsulting.luna.ejb.AnagrLuoghiFisici.IAnagrLuoghiFisici;
import com.apconsulting.luna.ejb.AnagrLuoghiFisici.IAnagrLuoghiFisiciHome;
import com.apconsulting.luna.ejb.AnagrLuoghiFisici.ReportAnagrLuoghiFisici_Rischi_View;
import com.apconsulting.luna.ejb.Azienda.Azienda_MOD_CLC_RSO;
import com.apconsulting.luna.ejb.Azienda.IAzienda;
import com.apconsulting.luna.ejb.Azienda.IAziendaHome;
import com.apconsulting.luna.ejb.Immobili3lv.IImmobili3lv;
import com.apconsulting.luna.ejb.Immobili3lv.IImmobili3lvHome;
import com.apconsulting.luna.ejb.LuogoFisicoRischio.ILuogoFisicoRischioHome;
import com.apconsulting.luna.ejb.Rischio.IRischioHome;
import com.apconsulting.luna.ejb.Rischio.RischioMisurePp_Nome_Descrizione_View;
import com.apconsulting.luna.ejb.SediAziendali.ISitaAziende;
import com.apconsulting.luna.ejb.SediAziendali.ISitaAziendeHome;
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
public class Report_REP_LUO_FSC extends Report {

    public long lCOD_LUO_FSC = 0;
   
    private boolean IncludeLogo = true;
    protected Boolean allModuleByProfile = null;

    public Report_REP_LUO_FSC(long lCOD_LUO_FSC) {
        this.lCOD_LUO_FSC = lCOD_LUO_FSC;
        allModuleByProfile =(ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_DVR_FIELD) ? new Boolean(false):new Boolean(true)); 
    }

    public Report_REP_LUO_FSC(long lCOD_LUO_FSC, boolean _IncludeLogo) {
        this(lCOD_LUO_FSC);
        this.IncludeLogo = _IncludeLogo;
        allModuleByProfile =(ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_DVR_FIELD)?new Boolean(false):new Boolean(true));  
    }
    
   
    
    @Override
    public void doReport() throws DocumentException, IOException, BadElementException, Exception { //----------------------------------------------------------------------
        SecurityWrapper Security = SecurityWrapper.getInstance();

        IAnagrLuoghiFisiciHome home_lf = (IAnagrLuoghiFisiciHome) PseudoContext.lookup("AnagrLuoghiFisiciBean");
        IAnagrLuoghiFisici bean_lf = home_lf.findByPrimaryKey(new Long(lCOD_LUO_FSC));
        IRischioHome home_ris = (IRischioHome) PseudoContext.lookup("RischioBean");
        lCOD_AZL = bean_lf.getCOD_AZL();
        IAziendaHome home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
        IAzienda bean_az = home.findByPrimaryKey(new Long(lCOD_AZL));
        boolean luoghiFisici3Livelli = ApplicationConfigurator.isModuleEnabled(MODULES.LUOGHI_FISICI_3_LIVELLI);

        initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("SCHEDA.LUOGO.FISICO"), bean_az.getRAG_SCL_AZL(), bean_lf.getNOM_LUO_FSC());
        if (IncludeLogo) {
            AddImage();
        }

        writeIndent();
        {
            CenterMiddleTable tbl = new CenterMiddleTable(1);
            if (bStandAlone) {
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
                tbl.addCell(bean_az.getRAG_SCL_AZL());
            }
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("SCHEDA.LUOGO.FISICO"));
            tbl.addTitleCell(bean_lf.getNOM_LUO_FSC());
            m_document.add(tbl);
            writeLine();
        }
        {
            CenterMiddleTable tbl = new CenterMiddleTable(1);
            tbl.toLeft();
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Descrizione.luogo.fisico"));
            tbl.addCell(bean_lf.getDES_LUO_FSC());

            m_document.add(tbl);
        }
        {
            CenterMiddleTable tbl = new CenterMiddleTable(2);
            tbl.toLeft();
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Responsabile.del.luogo.fisico"), 2);
            tbl.setDefaultColspan(1);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Nome/Cognome/Qualifica"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("E-mail"));
            tbl.endHeaders();
            tbl.addCell(bean_lf.getNOM_RSP_LUO_FSC() + "/" + bean_lf.getQLF_RSP_LUO_FSC());
            tbl.addCell(bean_lf.getIDZ_PSA_ELT_RSP_LUO_FSC());
            m_document.add(tbl);
        }
        {
            int colNums = luoghiFisici3Livelli ? 2 : 1;
            CenterMiddleTable tbl = new CenterMiddleTable(colNums);
            tbl.toLeft();
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Sito.aziendale"));
            if (luoghiFisici3Livelli) {
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Immobile"));
            }
            tbl.endHeaders();
            ISitaAziendeHome home_sit_azl = (ISitaAziendeHome) PseudoContext.lookup("SitaAziendeBean");
            ISitaAziende bean_sit_azl = null;
            if (luoghiFisici3Livelli) {
                IImmobili3lvHome imm3lvHome = (IImmobili3lvHome) PseudoContext.lookup("Immobili3lvBean");
                IImmobili3lv imm3lvBean = imm3lvHome.findByPrimaryKey(bean_lf.getCOD_IMM_3LV());
                bean_sit_azl = home_sit_azl.findByPrimaryKey(imm3lvBean.getCOD_SIT_AZL());
                tbl.addCell(bean_sit_azl.getNOM_SIT_AZL());
                tbl.addCell(imm3lvBean.getNOM_IMM());
            } else {
                if (bean_lf.getCOD_SIT_AZL() != 0) {
                    bean_sit_azl = home_sit_azl.findByPrimaryKey(bean_lf.getCOD_SIT_AZL());
                    tbl.addCell(bean_sit_azl.getNOM_SIT_AZL());
                }
            }
            m_document.add(tbl);
        }

        Iterator it = bean_lf.getReportAnagrLuoghiFisici_Rischi_View().iterator();
        {
                CenterMiddleTable t = new CenterMiddleTable(1);
                t.toLeft();
                t.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Lista.dei.rischi.associati"));
                m_document.add(t);
            }
        while (it.hasNext()) {
            ReportAnagrLuoghiFisici_Rischi_View w = (ReportAnagrLuoghiFisici_Rischi_View) it.next();
            {
                CenterMiddleTable t = new CenterMiddleTable(2);
                t.toLeft();
                //t.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Lista.dei.rischi.associati"), 2);
                //t.setDefaultColspan(1);
                t.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Rischio"));
                t.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Descrizione"));
                t.endHeaders();


                t.addCell(w.strNOM_RSO);
                t.addCell(w.strDES_RSO);
                m_document.add(t);
            }
           if(ApplicationConfigurator.isModuleEnabled(MODULES.LUO_FSC_MIS_PET) == true){

            {// TABELLA DEL RISCHIO - INIZIO
                CenterMiddleTable tbl = null;
                short sMOD_CLC_RSO = Security.getAziendaModalitaCalcoloRischio();

                if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_BASE) {
                    tbl = new CenterMiddleTable(3);
                    tbl.setWidth(50);
                } else if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {
                    tbl = new CenterMiddleTable(5);
                    tbl.setWidth(100);
                }
                tbl.setAlignment(Element.ALIGN_LEFT);
                {
                    tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Probabilità"));
                    tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Danno"));
                    if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {
                        tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Frequenza"));
                        tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Numero"));
                    }
                    tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Rischio"));
                    tbl.endHeaders();
                    tbl.addCell(w.lPRB_EVE_LES + "");
                    tbl.addCell(w.lENT_DAN + "");
                    if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {
                        tbl.addCell(w.lFRQ_RIP_ATT_DAN + "");
                        tbl.addCell(w.lNUM_INC_INF + "");
                    }
                    tbl.addCell(w.lSTM_NUM_RSO + "");
                }
                m_document.add(tbl);
            }
            {// MISURE DI PREVENZIONE E PROTEZIONE - INIZIO
                // bug 2015.02.20 MSR
               
              
                Iterator it4 = home_ris.getMisurePpView(w.lCOD_RSO, lCOD_AZL ,lCOD_LUO_FSC).iterator();
                  // bug 2015.02.20 MSR
                if (it4.hasNext()) {
                    writeLine();
                    writeParagraph3_2(ApplicationConfigurator.LanguageManager.getString("Elenco.misure.prevenzione.e.protezione.associate.al.rischio"));
                   
                    CenterMiddleTable tbl = null;
                    
                    if (this.allModuleByProfile.booleanValue()) {
                        tbl = new CenterMiddleTable(2);
                        tbl.setDeafaultOffset();
                        int width[] = {30, 70};
                        tbl.setWidths(width);
                        tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Nome.misura"));
                        tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Descrizione"));
                        tbl.endHeaders();
                        tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                        while (it4.hasNext()) {
                            RischioMisurePp_Nome_Descrizione_View w1 = (RischioMisurePp_Nome_Descrizione_View) it4.next();
                            tbl.addCell(w1.strNOM_MIS_PET);
                            tbl.addCell(w1.strDES_MIS_PET);
                        }
                    }
                    
                      if (!this.allModuleByProfile.booleanValue()) {
                         tbl =  new CenterMiddleTable(1);
                        tbl.setDeafaultOffset();
                        int width[] = { 70};
                        tbl.setWidths(width);
                        tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Descrizione"));
                        tbl.endHeaders();
                        tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                        while (it4.hasNext()) {
                            RischioMisurePp_Nome_Descrizione_View w1 = (RischioMisurePp_Nome_Descrizione_View) it4.next();
                            tbl.addCell(w1.strDES_MIS_PET);
                        }
                    }
                    m_document.add(tbl);
                }
            }// MISURE DI PREVENZIONE E PROTEZIONE - FINE
        }}
        closeDocument();
    }
}
