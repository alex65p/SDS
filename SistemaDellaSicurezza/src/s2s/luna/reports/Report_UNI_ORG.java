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

import com.apconsulting.luna.ejb.Azienda.Azienda_MOD_CLC_RSO;
import com.apconsulting.luna.ejb.Azienda.IAzienda;
import com.apconsulting.luna.ejb.Azienda.IAziendaHome;
import com.apconsulting.luna.ejb.CategorieFattoreRischio.CategorioRischio_LuogiFisici_View;
import com.apconsulting.luna.ejb.CategorieFattoreRischio.CategorioRischio_Name_Address_View;
import com.apconsulting.luna.ejb.CategorieFattoreRischio.ICategorioRischioHome;
import com.apconsulting.luna.ejb.Rischio.IRischioHome;
import com.apconsulting.luna.ejb.Rischio.RischioMisurePp_Nome_Descrizione_View;
import com.apconsulting.luna.ejb.RischioFattore.IRischioFattoreHome;
import com.apconsulting.luna.ejb.RischioFattore.Report_RischioFattore_RischioView;
import com.apconsulting.luna.ejb.RischioFattore.RischioFattore_ComboView2;
import com.apconsulting.luna.ejb.UnitaOrganizzativa.IUnitaOrganizzativa;
import com.apconsulting.luna.ejb.UnitaOrganizzativa.IUnitaOrganizzativaHome;
import com.apconsulting.luna.ejb.UnitaOrganizzativa.ReportUnitaOrganizzativa_AttivitaLavorativa_Eventuale_View;
import com.apconsulting.luna.ejb.UnitaOrganizzativa.ReportUnitaOrganizzativa_LuogoFisico_DPI_View;
import com.apconsulting.luna.ejb.UnitaOrganizzativa.ReportUnitaOrganizzativa_RefSicurezza_View;
import com.apconsulting.luna.ejb.UnitaOrganizzativa.ResponsabileView;
import com.lowagie.text.BadElementException;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import java.io.IOException;
import s2s.luna.util.SecurityWrapper;
import s2s.utils.plain.Formatter;
import java.util.Iterator;
import s2s.ejb.pseudoejb.PseudoContext;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.conf.ModuleManager.MODULES;
import s2s.report.CenterMiddleTable;
import s2s.report.Report;

/**
 *
 * @author Dario
 */
public class Report_UNI_ORG extends Report {

    public long lCOD_UNI_ORG = 0;
    private boolean IncludeLogo = true;
    protected Boolean allModuleByProfile = null;

    public Report_UNI_ORG() {
       
/**  Richieste da MSR 3.10.2014 - 
 *   Doc. Rif. "Analisi Requisiti Utente del 3/10/2014.doc"
 *   In sintesi MSR richiede che alcuni campi/dati del DVR non devono essere stampati.
 *   Il documento di analisi
 
 **/
 
        allModuleByProfile =(ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_DVR_FIELD) ? new Boolean(false):new Boolean(true)); 
    }

    public Report_UNI_ORG(boolean _IncludeLogo) {
        this();
        this.IncludeLogo = _IncludeLogo;
        
       
/**  Richieste da MSR 3.10.2014 - 
 *   Doc. Rif. "Analisi Requisiti Utente del 3/10/2014.doc"
 *   In sintesi MSR richiede che alcuni campi/dati del DVR non devono essere stampati.
 *   Il documento di analisi
 
 **/
          allModuleByProfile =(ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_DVR_FIELD) ? new Boolean(false):new Boolean(true)); 
       
    }

    @Override
    public void doReport() throws DocumentException, IOException, BadElementException, Exception {

        SecurityWrapper Security = SecurityWrapper.getInstance();

        IUnitaOrganizzativaHome home_uni = (IUnitaOrganizzativaHome) PseudoContext.lookup("UnitaOrganizzativaBean");
        IUnitaOrganizzativa bean_uni = home_uni.findByPrimaryKey(new Long(lCOD_UNI_ORG));
        lCOD_AZL = bean_uni.getCOD_AZL();
        IAziendaHome home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
        IAzienda bean_az = home.findByPrimaryKey(new Long(lCOD_AZL));

        initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("SCHEDA.DI.REPARTO"), bean_az.getRAG_SCL_AZL(), bean_uni.getNOM_UNI_ORG());

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
            if (ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_GSE)) {
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("SCHEDA.DI.SEDE"));
            } else {
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("SCHEDA.DI.REPARTO"));
            }
            tbl.addTitleCell(bean_uni.getNOM_UNI_ORG());
            m_document.add(tbl);
        }
        {

            if (ApplicationConfigurator.isModuleEnabled(MODULES.UNI_SIC_4_DIP) == false) {
                CenterMiddleTable tbl = new CenterMiddleTable(2);
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Ref.Sicurezza"));
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("E-mail"));

                java.util.Iterator it = bean_uni.getReportUnitaOrganizzativa_RefSicurezza_View().iterator();
                while (it.hasNext()) {
                    ReportUnitaOrganizzativa_RefSicurezza_View w = (ReportUnitaOrganizzativa_RefSicurezza_View) it.next();
                    tbl.addCell(w.strCOG_DPD + " " + w.strNOM_DPD);
                    tbl.addCell(Formatter.format(w.strIDZ_PSA_ELT_DPD));
                }

                m_document.add(tbl);
            }
        }
        if (ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_GSE) == false) {
            {
                CenterMiddleTable tbl = new CenterMiddleTable(2);
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Responsabile.uni.org"));
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("E-mail.Unita.Organizzativa"));

                java.util.Iterator it = bean_uni.getReportUnitaOrganizzativa_Resp_UnitàSicurezza_View().iterator();
                while (it.hasNext()) {
                    ResponsabileView w = (ResponsabileView) it.next();
                    tbl.addCell(w.strCOG_DPD + " " + w.strNOM_DPD);
                    tbl.addCell(w.strEMAIL);
                }
                m_document.add(tbl);
            }
            {
                CenterMiddleTable tbl = new CenterMiddleTable(2);
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Elenco.attività.lavorative.associate"));
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Eventuale/i.nominativo/i"));
                tbl.endHeaders();
                tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);

                java.util.Iterator it = bean_uni.getReportUnitaOrganizzativa_AttivitaLavorativa_Eventuale_View().iterator();
                /*
                long lTemp = -1;
                String strList = "";
                while (it.hasNext()) {
                ReportUnitaOrganizzativa_AttivitaLavorativa_Eventuale_View w = (ReportUnitaOrganizzativa_AttivitaLavorativa_Eventuale_View) it.next();
                if (lTemp != w.lCOD_MAN) {
                if (lTemp != -1) {
                tbl.addCell(strList);
                }
                tbl.addCell(w.strNOM_MAN);
                strList = "";
                lTemp = w.lCOD_MAN;
                }
                w.strNOM_COG_DPD = w.strNOM_COG_DPD == null ? "" : w.strNOM_COG_DPD;
                strList += w.strNOM_COG_DPD + "\n";
                }
                if (strList.length() != 0) {
                tbl.addCell(strList);
                }
                 */
                long lCOD_MAN_TEMP = 0;
                while (it.hasNext()) {
                    ReportUnitaOrganizzativa_AttivitaLavorativa_Eventuale_View w = (ReportUnitaOrganizzativa_AttivitaLavorativa_Eventuale_View) it.next();
                    if (lCOD_MAN_TEMP != w.lCOD_MAN) {
                        tbl.addCellB(w.strNOM_MAN, 14, 1);
                    } else {
                        tbl.addCell("");
                    }
                    tbl.addCell(w.strNOM_COG_DPD == null ? "" : w.strNOM_COG_DPD);
                    lCOD_MAN_TEMP = w.lCOD_MAN;
                }
                m_document.add(tbl);
            }
        }
        writeLine();
        {   
            if (this.allModuleByProfile.booleanValue()) {
            IRischioFattoreHome home_fr = (IRischioFattoreHome) PseudoContext.lookup("RischioFattoreBean");
            ICategorioRischioHome home_cr = (ICategorioRischioHome) PseudoContext.lookup("CategorioRischioBean");
            IRischioHome home_ris = (IRischioHome) PseudoContext.lookup("RischioBean");

            java.util.Iterator it = home_cr.getCategorioRischio_Name_Address_View().iterator();
            int count = 0;
            int count1 = 0;
            while (it.hasNext()) {// CATEGORIA DEL FATTORE DI RISCHIO
                CategorioRischio_Name_Address_View www = (CategorioRischio_Name_Address_View) it.next();
                java.util.Iterator itt1 = home_fr.getComboView(lCOD_AZL, lCOD_UNI_ORG, www.COD_CAG_FAT_RSO).iterator();
                if (count1 >= 1) {
                    writePage();
                } else {
                    writeLine();
                }

                {
                    if (itt1.hasNext()) {
                        writeLine();
                        CenterMiddleTable tbll = new CenterMiddleTable(1);
                        tbll.addHeaderCellB(www.NOM_CAG_FAT_RSO);
                        if (count >= 1) {
                            writePage();
                        }
                        m_document.add(tbll);
                    }
                }
                int count2 = 0;
                while (itt1.hasNext()) {// FATTORE DI RISCHIO - INIZIO
                    RischioFattore_ComboView2 ww1 = (RischioFattore_ComboView2) itt1.next();
                    java.util.Iterator it3 = home_fr.getReport_RischioFattore_RischioView_UO(lCOD_AZL, lCOD_UNI_ORG, ww1.lCOD_FAT_RSO).iterator();
                    if (it3.hasNext()) {
                        CenterMiddleTable tbll = new CenterMiddleTable(1);
                        tbll.toLeft();
                        tbll.addHeaderCell(ww1.strNOM_FAT_RSO);
                        if (ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_GSE) == false) {
                            writeLine();
                        } else if (count2 >= 1) {
                            writePage();
                        } else {
                            writeLine();
                        }
                        m_document.add(tbll);
                        { // RISCHIO - INIZIO
                            writeLine();
                            while (it3.hasNext()) {
                                Report_RischioFattore_RischioView ww = (Report_RischioFattore_RischioView) it3.next();
                                {
                                    CenterMiddleTable tbl = new CenterMiddleTable(1);
                                    tbl.toLeft();
                                    writeLine();
                                    writeLine();
                                    if (ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_GSE) == true) {
                                        tbl.addHeaderCellMagenta(ww.strNOM_RSO);
                                    } else {
                                        tbl.addHeaderCellB(ww.strNOM_RSO, 1, false);
                                    }
                                    tbl.addCell(ww.strDES_RSO);
                                    m_document.add(tbl);
                                }
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
                                        tbl.addCell(ww.lPRB_EVE_LES + "");
                                        tbl.addCell(ww.lENT_DAN + "");
                                        if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {
                                            tbl.addCell(ww.lFRQ_RIP_ATT_DAN + "");
                                            tbl.addCell(ww.lNUM_INC_INF + "");
                                        }
                                        tbl.addCell(ww.lSTM_NUM_RSO + "");
                                    }
                                    m_document.add(tbl);
                                }// TABELLA DEL RISCHIO - FINE
                                {// MISURE DI PREVENZIONE E PROTEZIONE - INIZIO
                                    Iterator it4 = home_ris.getMisurePpView(ww.lCOD_RSO, lCOD_AZL).iterator();
                                    if (it4.hasNext()) {
                                        writeLine();
                                        writeParagraph3_2(ApplicationConfigurator.LanguageManager.getString("Elenco.misure.prevenzione.e.protezione.associate.al.rischio"));
                                        CenterMiddleTable tbl = new CenterMiddleTable(2);
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
                                        m_document.add(tbl);
                                    }
                                }// MISURE DI PREVENZIONE E PROTEZIONE - FINE
                                // LUOGHI FISICI - INIZIO
                                if (ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_GSE) == true) {
                                    {
                                        java.util.Iterator itt = home_cr.getCategorioRischio_LuogiFisici_View(lCOD_AZL, lCOD_UNI_ORG, ww.lCOD_RSO).iterator();
                                        if (itt.hasNext()) {
                                            writeLine();
                                            writeParagraph3_2(ApplicationConfigurator.LanguageManager.getString("Elenco.luoghi.fisici.associati.al.rischio"));
                                            CenterMiddleTable tbl = new CenterMiddleTable(2);
                                            tbl.setAlignment(Element.ALIGN_LEFT);
                                            int width[] = {50, 50};
                                            tbl.setWidths(width);
                                            tbl.toLeft();
                                            tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Luoghi.fisici"));
                                            tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Piano"));
                                            tbl.endHeaders();
                                            while (itt.hasNext()) {// LUOGHI FISICI - INIZIO
                                                CategorioRischio_LuogiFisici_View w = (CategorioRischio_LuogiFisici_View) itt.next();
                                                tbl.addCell(w.strNOM_LUO_FSC);
                                                tbl.addCell(w.strNOM_PNO);
                                            }// LUOGHI FISICI - FINE
                                            m_document.add(tbl);
                                        }
                                    }
                                } else {
                                    {
                                        java.util.Iterator itt = home_cr.getCategorioRischio_LuogiFisici_View(lCOD_AZL, lCOD_UNI_ORG, ww.lCOD_RSO).iterator();
                                        if (itt.hasNext()) {
                                            writeLine();
                                            writeParagraph3_2(ApplicationConfigurator.LanguageManager.getString("Elenco.luoghi.fisici.associati.al.rischio"));
                                            CenterMiddleTable tbl = new CenterMiddleTable(1);
                                            tbl.setAlignment(Element.ALIGN_LEFT);
                                            tbl.setWidth(50);
                                            tbl.toLeft();
                                            tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Luoghi.fisici"));
                                            tbl.endHeaders();
                                            while (itt.hasNext()) {// LUOGHI FISICI - INIZIO
                                                CategorioRischio_LuogiFisici_View w = (CategorioRischio_LuogiFisici_View) itt.next();
                                                tbl.addCell(w.strNOM_LUO_FSC);
                                            }// LUOGHI FISICI - FINE
                                            m_document.add(tbl);
                                        }
                                    }
                                }
                                // LUOGHI FISICI - FINE
                            }
                        } // RISCHIO - FINE
                        count2 = count2 + 1;
                        count = count + 1;
                    }
                }// FATTORE DI RISCHIO - FINE

            } // CATEGORIA DEL FATTORE DI RISCHIO - FINE
            count1 = count1 + 1;
            }
        }
        {// ALLEGATI
            if (this.allModuleByProfile.booleanValue()) {
            writePage();
            writeBig(ApplicationConfigurator.LanguageManager.getString("Allegato.1"));
            {
                writeParagraph1(ApplicationConfigurator.LanguageManager.getString("D.P.I."));
                writeText2(ApplicationConfigurator.LanguageManager.getString("MSG_REP_0002") + ":");
                writeLine();
                CenterMiddleTable tbl = new CenterMiddleTable(2);
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Luogo.fisico"));
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Tipologia.D.P.I."));
                tbl.endHeaders();
                tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                Iterator it4 = bean_uni.getReportUnitaOrganizzativa_LuogoFisico_DPI_View().iterator();
                if (ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_GSE) && it4.hasNext() == false) {
                    writeParagraph3(ApplicationConfigurator.LanguageManager.getString("MSG_REP_0013"));
                    writeLine();
                }
                while (it4.hasNext()) {
                    ReportUnitaOrganizzativa_LuogoFisico_DPI_View w3 = (ReportUnitaOrganizzativa_LuogoFisico_DPI_View) it4.next();
                    tbl.addCell(w3.strNOM_LUO_FSC);
                    tbl.addCell(w3.strNOM_TPL_DPI);
                }
                m_document.add(tbl);
                writeLine();
                writeText2(ApplicationConfigurator.LanguageManager.getString("MSG_REP_0003")
                        + " "
                        + ApplicationConfigurator.LanguageManager.getString("MSG_REP_0004")
                        + ", "
                        + ApplicationConfigurator.LanguageManager.getString("MSG_REP_0005")
                        + ", "
                        + ApplicationConfigurator.LanguageManager.getString("MSG_REP_0006"));
            }
            }
            //aggiunta riga vuota per modifica DVR>ALLEGATO 1 PER MSR
            writeLine();
        }
        
        closeDocument();
    }
}
