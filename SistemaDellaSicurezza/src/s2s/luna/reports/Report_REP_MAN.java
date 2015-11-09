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

import com.apconsulting.luna.ejb.AnagrLuoghiFisici.AnagrLuoghiFisici_4Sede_List_View;
import com.apconsulting.luna.ejb.AnagrLuoghiFisici.AnagrLuoghiFisici_List_View;
import com.apconsulting.luna.ejb.AnagrLuoghiFisici.IAnagrLuoghiFisiciHome;
import com.apconsulting.luna.ejb.AttivitaLavorative.AttLav_Corsi_View;
import com.apconsulting.luna.ejb.AttivitaLavorative.AttLav_DPI_ViewEx;
import com.apconsulting.luna.ejb.AttivitaLavorative.AttLav_OperazioniSvolte_View;
import com.apconsulting.luna.ejb.AttivitaLavorative.AttLav_VisteMediche_View;
import com.apconsulting.luna.ejb.AttivitaLavorative.AttivitaLavorativePK;
import com.apconsulting.luna.ejb.AttivitaLavorative.IAttivitaLavorative;
import com.apconsulting.luna.ejb.AttivitaLavorative.IAttivitaLavorativeHome;
import com.apconsulting.luna.ejb.AttivitaLavorative.MacchinaByAttivitaLavorative_View;
import com.apconsulting.luna.ejb.AttivitaLavorative.ReportAttLav_Documenti_View;
import com.apconsulting.luna.ejb.AttivitaLavorative.ReportAttLav_MisurePreventive_View;
import com.apconsulting.luna.ejb.Azienda.Azienda_MOD_CLC_RSO;
import com.apconsulting.luna.ejb.Azienda.IAzienda;
import com.apconsulting.luna.ejb.Azienda.IAziendaHome;
import com.apconsulting.luna.ejb.CategorieFattoreRischio.CategorioRischio_Name_Address_View;
import com.apconsulting.luna.ejb.CategorieFattoreRischio.ICategorioRischioHome;
import com.apconsulting.luna.ejb.OperazioneSvolta.IOperazioneSvolta;
import com.apconsulting.luna.ejb.OperazioneSvolta.IOperazioneSvoltaHome;
import com.apconsulting.luna.ejb.OperazioneSvolta.OpSvolte_Macchine_View;
import com.apconsulting.luna.ejb.Rischio.IRischioHome;
import com.apconsulting.luna.ejb.Rischio.ReportRischioMachineAttrezzature_Numero_Modelo_Descr_View;
import com.apconsulting.luna.ejb.Rischio.ReportRischioSostanzeChimiche_View;
import com.apconsulting.luna.ejb.RischioFattore.IRischioFattoreHome;
import com.apconsulting.luna.ejb.RischioFattore.Report_RischioFattore_RischioView;
import com.apconsulting.luna.ejb.RischioFattore.RischioFattore_ComboView2;
import com.lowagie.text.BadElementException;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import java.io.IOException;
import java.util.Collection;
import java.util.Iterator;
import s2s.ejb.pseudoejb.PseudoContext;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.conf.ModuleManager.MODULES;
import s2s.luna.reports.pageChild.Report_ChildAgentiChimici;
import s2s.luna.reports.pageChild.Report_ChildCorsi;
import s2s.luna.reports.pageChild.Report_ChildDPI;
import s2s.luna.reports.pageChild.Report_ChildDocumentazione;
import s2s.luna.reports.pageChild.Report_ChildMacchineAttrezzature;
import s2s.luna.reports.pageChild.Report_ChildSorveglianzaSanitaria;

import s2s.luna.util.SecurityWrapper;
import s2s.report.CenterMiddleTable;
import s2s.report.MiddleTable;
import s2s.report.Report;

/**
 *
 * @author Dario
 */
public class Report_REP_MAN extends Report {

    public long lCOD_AZL = 0;
    public long lCOD_MAN = 0;
    
    public boolean bAttivitaSvolte = true;
    public boolean bLuoghiLavoro = true;
    public boolean bRischi = true;
    public boolean bInformazioneFormazione = true;
    public boolean bAgentiChimici = true;
    public boolean bDocumentazione = true;
    public boolean bDPI = true;
    public boolean bSorveglianzaSanitaria = true;
    public boolean bMacchineAttrezature = true;
    public boolean bMacchineAttrezatureMansioni = true;
    
    private boolean IncludeLogo = true;
    protected Boolean allModuleByProfile = null;

    public Report_REP_MAN(long lCOD_MAN, long lCOD_AZL) {
        this.lCOD_MAN = lCOD_MAN;
        this.lCOD_AZL = lCOD_AZL;
         

/**  Richieste da MSR 3.10.2014 - 
 *   Doc. Rif. "Analisi Requisiti Utente del 3/10/2014.doc"
 *   In sintesi MSR richiede che alcuni campi/dati del DVR non devono essere stampati.
 *   Il documento di analisi
 
 **/
        
        allModuleByProfile =(ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_DVR_FIELD) ? new Boolean(false):new Boolean(true)); 
        

    }

    public Report_REP_MAN(long lCOD_MAN, long lCOD_AZL, boolean _IncludeLogo) {
        this(lCOD_MAN, lCOD_AZL);
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
        IAttivitaLavorativeHome home_man = (IAttivitaLavorativeHome) PseudoContext.lookup("AttivitaLavorativeBean");
        IAttivitaLavorative bean_man = home_man.findByPrimaryKey(new AttivitaLavorativePK(lCOD_AZL, lCOD_MAN));
        lCOD_AZL = bean_man.getCOD_AZL();
        IAziendaHome home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
        IAzienda bean_az = home.findByPrimaryKey(new Long(lCOD_AZL));
        IOperazioneSvoltaHome home_opesvo = (IOperazioneSvoltaHome) PseudoContext.lookup("OperazioneSvoltaBean");
     
        initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("SCHEDA.ATTIVITA'.LAVORATIVA"), bean_az.getRAG_SCL_AZL(), bean_man.getNOM_MAN());

        if (IncludeLogo) {
            AddImage();
        }

        writeIndent();
        {
            // AZIENDA / ENTE
            CenterMiddleTable tbl = new CenterMiddleTable(1);
            if (bStandAlone) {
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
                tbl.addCell(bean_az.getRAG_SCL_AZL());
            }

            // SCHEDA ATTIVITA' LAVORATIVA
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("SCHEDA.ATTIVITA'.LAVORATIVA"));
            tbl.addTitleCell(bean_man.getNOM_MAN());
            m_document.add(tbl);
        }
        writeLine();

        // REPARTO
        if (ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_GSE) == false) {
            {
                MiddleTable tbl = new MiddleTable(1);

                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Reparto"));
                String strTemp
                        = ApplicationConfigurator.LanguageManager.getString("Descrizione") + "\n"
                        + ApplicationConfigurator.LanguageManager.getString("Responsabilità.e.competenze") + "\n";
                //ApplicationConfigurator.LanguageManager.getString("Indice.rischio.chimico") + "\n";

                if (bLuoghiLavoro) {
                    strTemp = strTemp
                            + ApplicationConfigurator.LanguageManager.getString("Luoghi.di.lavoro") + "\n";
                }
                if (bAttivitaSvolte) {
                    strTemp = strTemp
                            + ApplicationConfigurator.LanguageManager.getString("Operazioni.svolte") + "\n";
                    if (bRischi) {
                        strTemp = strTemp
                                + ApplicationConfigurator.LanguageManager.getString("Rischi") + "\n";
                    }
                }
                if (bAgentiChimici) {
                    strTemp = strTemp
                            + ApplicationConfigurator.LanguageManager.getString("Valutazione.rischio.chimico") + "\n";
                }
                if (bInformazioneFormazione) {
                    strTemp = strTemp
                            + ApplicationConfigurator.LanguageManager.getString("Informazione.e.formazione") + "\n";
                }
                if (bDPI) {
                    strTemp = strTemp
                            + ApplicationConfigurator.LanguageManager.getString("D.P.I.") + "\n";
                }
                if (bSorveglianzaSanitaria) {
                    strTemp = strTemp
                            + ApplicationConfigurator.LanguageManager.getString("Sorveglianza.sanitaria") + "\n";
                }
                if (bMacchineAttrezatureMansioni) {
                    strTemp = strTemp
                            + ApplicationConfigurator.LanguageManager.getString(
                                    ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                    ? "Macchine.attrezzature.impianti.associate.mansioni"
                                    : "Macchine/Attrezzature.associate.mansioni") + "\n";
                }
                if (bDocumentazione) {
                    strTemp = strTemp
                            + ApplicationConfigurator.LanguageManager.getString("Documentazione") + "\n";
                }

                tbl.addCell(strTemp);
                m_document.add(tbl);
            }
            writePage();
        }

        {
            // DESCRIZIONE
            writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Descrizione"));
            writeParagraph2(bean_man.getDES_MAN());
            writeLine();
        }
        if (ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_GSE) == false) {
            {
                // RESPONSABILITA' E COMPETENZE
                writeParagraph1(
                        ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_SDP)
                        ? ApplicationConfigurator.LanguageManager.getString("Gruppi.omogenei.di.rferimento")
                        : ApplicationConfigurator.LanguageManager.getString("Descrizione.responsabilità.e.competenze")
                );
                writeParagraph2(bean_man.getDES_RSP_COM());
                writeLine();
            }
        }
        /*
         {
         // INDICE RISCHIO CHIMICO
         writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Indice.rischio.chimico"));
         double IDX_RSO_CHI = bean_man.getIDX_RSO_CHI();
         String livelloRischio = "";
         switch((int)bean_man.getRSO_VAL()){
         case 1: livelloRischio = ApplicationConfigurator.LanguageManager.getString("Moderato"); break;
         case 2: livelloRischio = ApplicationConfigurator.LanguageManager.getString("Non.moderato"); break;
         }
         writeParagraph2(
         IDX_RSO_CHI +
         " ("+bean_man.getDescRischio(IDX_RSO_CHI)+")" +
         (!livelloRischio.equals("")?" - "+livelloRischio:""));
         }
         */

        // LUOGHI DI LAVORO
        if (bLuoghiLavoro) {
            IAnagrLuoghiFisiciHome home_lfis = (IAnagrLuoghiFisiciHome) PseudoContext.lookup("AnagrLuoghiFisiciBean");

            if (ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_GSE)) {
                // Disegno questa parte secondo uno schema tabellare richiestoci da GSE.
                Collection<AnagrLuoghiFisici_4Sede_List_View> listaLuoghiFisici
                        = home_lfis.getAnagrLuoghiFisici_4Sede_List_View(lCOD_AZL, lCOD_MAN);
                if (listaLuoghiFisici != null && listaLuoghiFisici.isEmpty() == false) {
                    writePage();
                    long codice_sede = -1;
                    long codice_immobile = -1;
                    CenterMiddleTable tbl = null;
                    for (AnagrLuoghiFisici_4Sede_List_View luogoFisico : listaLuoghiFisici) {
                        // Stampo le informazioni relative alla sede.
                        if (codice_sede != luogoFisico.COD_SIT_AZL) {
                            if (tbl != null) {
                                m_document.add(tbl);
                                writeLine();
                                codice_immobile = -1;
                            }
                            tbl = new CenterMiddleTable(2);
                            tbl.setDeafaultOffset();
                            int width[] = {70, 30};
                            tbl.setWidths(width);
                            tbl.addHeaderCellB(
                                    ApplicationConfigurator.LanguageManager.getString("Luoghi.di.lavoro") + "\n"
                                    + ApplicationConfigurator.LanguageManager.getString("Sede") + ": "
                                    + luogoFisico.NOM_SIT_AZL, 2);
                            tbl.endHeaders();
                            tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                        }
                        // Stampo le informazioni relative all'immobile.
                        if (codice_immobile != luogoFisico.COD_IMO) {
                            tbl.addCellB(
                                    ApplicationConfigurator.LanguageManager.getString("Immobile") + ": "
                                    + (luogoFisico.NOM_IMO == null ? "" : luogoFisico.NOM_IMO), 13, 2);
                            tbl.addCellB(ApplicationConfigurator.LanguageManager.getString("Luogo.di.lavoro"), 13, 1);
                            tbl.addCellB(ApplicationConfigurator.LanguageManager.getString("Piano"), 13, 1);
                        }
                        // Stampo le informazioni relative al luogo fisico.
                        tbl.addCell(luogoFisico.NOM_LUO_FSC);
                        tbl.addCell(luogoFisico.NOM_PNO);

                        codice_sede = luogoFisico.COD_SIT_AZL;
                        codice_immobile = luogoFisico.COD_IMO;
                    }
                    if (tbl != null) {
                        m_document.add(tbl);
                    }
                }
            } else {
                java.util.Iterator itt = home_lfis.getAnagrLuoghiFisici_List_View(lCOD_AZL, lCOD_MAN).iterator();
                if (itt.hasNext()) {
                    writePage();
                    writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Luoghi.di.lavoro"));
                    {
                        CenterMiddleTable tbl = new CenterMiddleTable(1);
                        tbl.setDeafaultOffset();
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Luogo.di.lavoro"));
                        tbl.endHeaders();
                        tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);

                        while (itt.hasNext()) {
                            AnagrLuoghiFisici_List_View w = (AnagrLuoghiFisici_List_View) itt.next();
                            tbl.addCell(w.NOM_LUO_FSC);
                        }
                        m_document.add(tbl);
                    }
                }
            }
        }

        // OPERAZIONI SVOLTE
        Collection<AttLav_OperazioniSvolte_View> op_svo_list = null;
        if (bAttivitaSvolte) {
            op_svo_list = bean_man.getOperazioniSvolte_View();
            if (op_svo_list != null && op_svo_list.isEmpty() == false) {
                writePage();
                writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Operazioni.svolte"));
                {
                    CenterMiddleTable tbl = new CenterMiddleTable(1);
                    tbl.setDeafaultOffset();
                    tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Descrizione.dell'attività"));
                    tbl.endHeaders();
                    tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                    for (AttLav_OperazioniSvolte_View w : op_svo_list) {
                        tbl.addCell(w.NOM_OPE_SVO);
                    }
                    m_document.add(tbl);
                }
            }

            // RISCHI
            IRischioFattoreHome home_fatr = (IRischioFattoreHome) PseudoContext.lookup("RischioFattoreBean");
            IRischioHome home_ris = (IRischioHome) PseudoContext.lookup("RischioBean");

            // Estraggo le categorie dei fattori di rischio.
            ICategorioRischioHome home_cr = (ICategorioRischioHome) PseudoContext.lookup("CategorioRischioBean");
            Collection<CategorioRischio_Name_Address_View> cat_ris_list = home_cr.getCategorioRischio_Name_Address_View();
            int count2 = 0;
            {
                // Determino se raggruppare i rischi per:
                // - CATEGORIA DEL FATTORE DI RISCIO (GSE)
                // - OPERAZIONE SVOLTA (DEFAULT)
                for (Object item
                        : ApplicationConfigurator.isModuleEnabled(MODULES.REP_MAN_BY_CAG_FAT) ? cat_ris_list : op_svo_list) {
                    java.util.Iterator it3
                            = (item instanceof CategorioRischio_Name_Address_View)
                            ? home_fatr.getReport_RischioFattore_ComboView_CAG_FAT_RSO(lCOD_AZL, lCOD_MAN, ((CategorioRischio_Name_Address_View) item).COD_CAG_FAT_RSO).iterator()
                            : home_fatr.getReport_RischioFattore_ComboView(lCOD_AZL, lCOD_MAN, ((AttLav_OperazioniSvolte_View) item).COD_OPE_SVO).iterator();

                    if (it3.hasNext()) {
                        {
                            // Scrivo l'operazione svolta / categoria fattore di rischio
                            writePage();
                            CenterMiddleTable tbl = new CenterMiddleTable(1);
                            tbl.setDeafaultOffset();
                            tbl.addHeaderCellB(
                                    (item instanceof CategorioRischio_Name_Address_View)
                                    ? ((CategorioRischio_Name_Address_View) item).NOM_CAG_FAT_RSO
                                    : ApplicationConfigurator.LanguageManager.getString("Operazione.svolta") + "\n" + ((AttLav_OperazioniSvolte_View) item).NOM_OPE_SVO.toUpperCase());
                            tbl.endHeaders();
                            m_document.add(tbl);
                        }
                        // Scrivo la descrizione dell'operazione svolta
                        if (!(item instanceof CategorioRischio_Name_Address_View)) {
                            writeLine();
                            writeParagraph2(((AttLav_OperazioniSvolte_View) item).DES_OPE_SVO);
                        }
                        if ((ApplicationConfigurator.isModuleEnabled(MODULES.DVR_MAC_4_OPE_SVO) == true) && (ApplicationConfigurator.isModuleEnabled(MODULES.REP_MAN_BY_CAG_FAT) == false)) {
                            if (bMacchineAttrezature) {

                                IOperazioneSvolta bean_ope = home_opesvo.findByPrimaryKey(((AttLav_OperazioniSvolte_View) item).COD_OPE_SVO);
                                java.util.Collection col = bean_ope.getMacchine_View(lCOD_AZL);
                                java.util.Iterator it = col.iterator();
                                if (it.hasNext() != false) {
                                    writeLine();
                                    writeLine();
                                    writeParagraph3_2(ApplicationConfigurator.LanguageManager.getString(
                                            ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                            ? "Elenco.macchine.attrezzature.impianti.associate.al.rischio"
                                            : "Elenco.macchine/attrezzature.associate.al.rischio"));
                                    CenterMiddleTable tbl = new CenterMiddleTable(2);
                                    tbl.setDeafaultOffset();
                                    int width[] = {40, 60};
                                    tbl.setWidths(width);
                                    tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString(
                                            ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                            ? "Nome.macchina.attrezzatura.impianto"
                                            : "Nome.macchina/attrezzatura"));
                                    tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Descrizione"));
                                    tbl.endHeaders();
                                    tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                                    while (it.hasNext()) {

                                        OpSvolte_Macchine_View rc = (OpSvolte_Macchine_View) it.next();
                                        tbl.addCell(rc.IDE_MAC);
                                        tbl.addCell(rc.DES_MAC);

                                    }
                                    m_document.add(tbl);
                                }

                            }
                        }
                        int count = 0;
                        while (it3.hasNext()) { // FATTORE DI RISCHIO
                            RischioFattore_ComboView2 w = (RischioFattore_ComboView2) it3.next();

                            if (!bRischi) {
                                continue;
                            }
                            Iterator it31
                                    = (item instanceof CategorioRischio_Name_Address_View)
                                    ? home_fatr.getReport_RischioFattore_RischioView(lCOD_AZL, lCOD_MAN, w.lCOD_FAT_RSO).iterator()
                                    : home_fatr.getReport_RischioFattore_RischioView(lCOD_AZL, lCOD_MAN, ((AttLav_OperazioniSvolte_View) item).COD_OPE_SVO, w.lCOD_FAT_RSO).iterator();
                            if (it31.hasNext()) {
                                // Scrivo il nome del fattore di rischio
                                writeLine();
                                if (ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_GSE) == true) {

                                    CenterMiddleTable tbll = new CenterMiddleTable(1);
                                    tbll.toLeft();
                                    tbll.addHeaderCell(w.strNOM_FAT_RSO);
                                    if (ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_GSE) == false) {
                                        writeLine();
                                    } else if (count >= 1) {
                                        writePage();
                                    } else {
                                        writeLine();
                                    }
                                    m_document.add(tbll);
                                } else {
                                    writeParagraph2(w.strNOM_FAT_RSO);
                                }
                                while (it31.hasNext()) { // RISCHIO
                                    Report_RischioFattore_RischioView ww = (Report_RischioFattore_RischioView) it31.next();
                                    // Scrivo il nome e la descrizione del rischio
                                    writeLine();
                                    writeLine();
                                    if (ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_GSE) == true) {
                                        CenterMiddleTable tbll = new CenterMiddleTable(1);
                                        tbll.toLeft();
                                        //tbll.addHeaderCellB(ww.strNOM_RSO, 1, false);
                                        tbll.addHeaderCellMagenta(ww.strNOM_RSO);
                                        tbll.addCell(ww.strDES_RSO);
                                        m_document.add(tbll);
                                        //writeLine();
                                    } else {
                                        writeParagraph3_2(ww.strNOM_RSO);
                                        writeLine();
                                        writeText3_2(ww.strDES_RSO);
                                        writeLine();
                                    }
                                    {
                                        CenterMiddleTable tbl = null;
                                        short sMOD_CLC_RSO = Security.getAziendaModalitaCalcoloRischio();

                                        if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_BASE) {
                                            tbl = new CenterMiddleTable(3);
                                            tbl.setWidth(50);
                                        } else if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {
                                            tbl = new CenterMiddleTable(5);
                                            tbl.setWidth(100);
                                        }
                                        tbl.setDeafaultOffset();
                                        tbl.setAlignment(Element.ALIGN_LEFT);
                                        {
                                            tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Probabilità"));
                                            tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Danno"));
                                            if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {
                                                tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Frequenza"));
                                                tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Numero"));
                                            }
                                            tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Rischio"));
                                            tbl.addCell(ww.lPRB_EVE_LES + "");
                                            tbl.addCell(ww.lENT_DAN + "");
                                            if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {
                                                tbl.addCell(ww.lFRQ_RIP_ATT_DAN + "");
                                                tbl.addCell(ww.lNUM_INC_INF + "");
                                            }
                                            tbl.addCell(ww.lSTM_NUM_RSO + "");
                                        }
                                        m_document.add(tbl);
                                    }
                                    if (ApplicationConfigurator.isModuleEnabled(MODULES.DVR_MAC_4_OPE_SVO) == false) {
                                        // MACCHINE ATTREZZATURE
                                        if (bMacchineAttrezature) {
                                            Iterator it32
                                                    = (item instanceof CategorioRischio_Name_Address_View)
                                                    ? home_ris.getReportRischioMachineAttrezzature_Numero_Modelo_Descr_View(lCOD_AZL, ww.lCOD_RSO).iterator()
                                                    : home_ris.getReportRischioMachineAttrezzature_Numero_Modelo_Descr_View(lCOD_AZL, ((AttLav_OperazioniSvolte_View) item).COD_OPE_SVO, ww.lCOD_RSO).iterator();
                                            if (it32.hasNext()) {
                                                writeLine();
                                                writeLine();
                                                writeParagraph3_2(ApplicationConfigurator.LanguageManager.getString(
                                                        ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                                        ? "Elenco.macchine.attrezzature.impianti.associate.al.rischio"
                                                        : "Elenco.macchine/attrezzature.associate.al.rischio"));
                                                CenterMiddleTable tbl = new CenterMiddleTable(2);
                                                tbl.setDeafaultOffset();
                                                int width[] = {40, 60};
                                                tbl.setWidths(width);
                                                tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString(
                                                        ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                                        ? "Nome.macchina.attrezzatura.impianto"
                                                        : "Nome.macchina/attrezzatura"));
                                                tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Descrizione"));
                                                tbl.endHeaders();
                                                tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                                                while (it32.hasNext()) {
                                                    ReportRischioMachineAttrezzature_Numero_Modelo_Descr_View ww1 = (ReportRischioMachineAttrezzature_Numero_Modelo_Descr_View) it32.next();
                                                    tbl.addCell(ww1.strMDL_MAC);
                                                    tbl.addCell(ww1.strDES_MAC);
                                                }
                                                m_document.add(tbl);
                                            }
                                        }
                                    }
                                    // MISURE DI PREVENZIONE E PROTEZIONE
                                    if (ApplicationConfigurator.isModuleEnabled(MODULES.MIS_PET_ISTR_OPE) == true) {
                                        // MILANO SERRAVALLE
                                        Iterator it32 = bean_man.getMisurePreventiveView(ww.lCOD_RSO).iterator();
                                        if (it32.hasNext()) {
                                            writeLine();
                                            writeParagraph3_2(ApplicationConfigurator.LanguageManager.getString("Elenco.misure.prevenzione.e.protezione.associate.al.rischio"));
                                     
                                          int colonneTabella=3;
                                          int width[] = {30, 50, 20};
                                          
                                          if (!this.allModuleByProfile.booleanValue()) {
                                             colonneTabella=2;
                                            int  width1[] =  { 70, 30};
                                            width=width1;
                                         }
                                            CenterMiddleTable tbl = new CenterMiddleTable(colonneTabella);
                                            tbl.setDeafaultOffset();
                                            
                                           
                                            tbl.setWidths(width);
                                            if (this.allModuleByProfile.booleanValue()) {
                                                tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Nome.misura"));
                                            }
                                            tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Descrizione"));
                                            tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Istruzioni.Operative.correlate"));
                                            tbl.endHeaders();
                                            tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                                            while (it32.hasNext()) {
                                                ReportAttLav_MisurePreventive_View ww1 = (ReportAttLav_MisurePreventive_View) it32.next();
                                               if (this.allModuleByProfile.booleanValue()) {
                                                  tbl.addCell(ww1.NOM_MIS_PET);
                                               }
                                                tbl.addCell(ww1.DES_MIS_PET);
                                                tbl.addCell(ww1.IST_OPE_COR);
                                            }
                                            m_document.add(tbl);
                                        }
                                    } else {
                                        Iterator it32 = bean_man.getMisurePreventiveView(ww.lCOD_RSO).iterator();
                                        if (it32.hasNext()) {
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
                                            while (it32.hasNext()) {
                                                ReportAttLav_MisurePreventive_View ww1 = (ReportAttLav_MisurePreventive_View) it32.next();
                                                tbl.addCell(ww1.NOM_MIS_PET);
                                                tbl.addCell(ww1.DES_MIS_PET);
                                            }
                                            m_document.add(tbl);
                                        }
                                    }
                                    // SOSTANZE CHIMICHE
                                    {
                                        Iterator it33
                                                = (item instanceof CategorioRischio_Name_Address_View)
                                                ? home_ris.getReportRischioSostanzeChimiche_View(lCOD_AZL, lCOD_MAN).iterator()
                                                : home_ris.getReportRischioSostanzeChimiche_View(ww.lCOD_RSO, ((AttLav_OperazioniSvolte_View) item).COD_OPE_SVO, lCOD_MAN, lCOD_AZL).iterator();
                                        if (it33.hasNext()) {
                                            writeLine();
                                            writeParagraph3_2(ApplicationConfigurator.LanguageManager.getString("Elenco.sostanze.chimiche.associate.al.rischio"));
                                            CenterMiddleTable tbl = new CenterMiddleTable(4);
                                            tbl.setDeafaultOffset();
                                            tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Nome.sostanza/preparato"));
                                            tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Stato.fisico"));
                                            //tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Frasi.R"));
                                            //tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Cons.S"));
                                            tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Simbolo"));
                                            tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Descrizione"));
                                            tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                                            tbl.endHeaders();
                                            tbl.setAlignment(Element.ALIGN_LEFT);
                                            while (it33.hasNext()) {
                                                ReportRischioSostanzeChimiche_View ww2 = (ReportRischioSostanzeChimiche_View) it33.next();
                                                tbl.addCell(ww2.strNOM_COM_SOS);
                                                tbl.addCell(ww2.strDES_STA_FSC);
                                                //tbl.addCell(ww2.strFRS_R);
                                                //tbl.addCell(ww2.strFRS_S);
                                                tbl.addCell(ww2.strDES_SIM);
                                                tbl.addCell(ww2.strDES_SOS_CHI);
                                            }
                                            m_document.add(tbl);
                                        }
                                    }
                                } // RISCHIO
                                count2 = count2 + 1;
                            }
                            count = count + 1;
                        } // FATTORE DI RISCHIO
                    }
                } // OPERAZIONE SVOLTA
            }
        }

        /**
         *
         * ALLEGATI (CORSI, DOCUMENTI, DPI, MACCHINARI MANSIONE, SORVEGLIANZA
         * SANITARIA)
         *
         *
         */
        if (bAgentiChimici || bInformazioneFormazione || bDocumentazione || bDPI || bSorveglianzaSanitaria || bMacchineAttrezatureMansioni) {
            writePage();

            if (bStandAlone) {
                writeBig(ApplicationConfigurator.LanguageManager.getString("Allegato.1"));
                writeLine();
            }

            // AgentiChimici
            if (bAgentiChimici) {
                Report_ChildAgentiChimici childAgentiChimici = new Report_ChildAgentiChimici(lCOD_MAN, lCOD_AZL, IncludeLogo, this.getCurrentReport());
                childAgentiChimici.writeRecordCard(bean_man);

//                writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Valutazione.rischio.chimico"));
//
//                CenterMiddleTable tbl = new CenterMiddleTable(2);
//                int width[] = {30, 70};
//                tbl.setWidths(width);
//                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Indice.rischio.chimico"));
//                    tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Note"));
//                    tbl.endHeaders();
//                    tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
//                //Collection<AttLavAGE_CHI_View> listaAgentiChimici = bean_man.getAgentiChimici_View_Report();
//
//                // for (AttLavAGE_CHI_View agente : listaAgentiChimici) {
//                if ((bean_man.getRSO_VAL() != 0) || (!bean_man.getNOTE().equals(""))) {
//                   
//                    String a = Long.toString(bean_man.getRSO_VAL());
//
//                    switch (Integer.valueOf(a)) {
//                        case 0:
//                            a = "";
//                            break;
//                        case 1:
//                            a = "moderato";
//                            break;
//                        case 2:
//                            a = "non moderato";
//                            break;
//                    }
//                    tbl.addCell(a);
//                    tbl.addCell(bean_man.getNOTE());
//                    m_document.add(tbl);
//                } else {
//
//                    tbl.endHeaders();
//                    tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
//                    m_document.add(tbl);
//                    writeParagraph3(DATI_NON_PRESENTI);
//                }
//                //  if (listaAgentiChimici.isEmpty()) {
//                //      writeParagraph3(DATI_NON_PRESENTI);
//                //  }
//                    
//                writeLine();
            }

            // CORSI
            if (bInformazioneFormazione) {
                Report_ChildCorsi childCorsi = new Report_ChildCorsi(lCOD_MAN, lCOD_AZL, IncludeLogo, this.getCurrentReport());
                childCorsi.writeRecordCard(bean_man);

//                writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Informazione.e.formazione"));
//
//                CenterMiddleTable tbl = new CenterMiddleTable(1);
//                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Corso"));
//                tbl.endHeaders();
//                tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
//                Collection<AttLav_Corsi_View> listaCorsi = bean_man.getCorsi_View();
//                for (AttLav_Corsi_View corso : listaCorsi) {
//                    tbl.addCell(corso.NOM_COR);
//                }
//                m_document.add(tbl);
//                if (listaCorsi.isEmpty()) {
//                    writeParagraph3(DATI_NON_PRESENTI);
//                }
//                writeLine();
            }

            // DPI
            if (bDPI) {
                Report_ChildDPI childDPI = new Report_ChildDPI(lCOD_MAN, lCOD_AZL, IncludeLogo, this.getCurrentReport());
                childDPI.writeRecordCard(bean_man);

//                writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Tipologia.D.P.I."));
//                writeText2(ApplicationConfigurator.LanguageManager.getString("MSG_REP_0012"));
//                CenterMiddleTable tbl = new CenterMiddleTable(2);
//                int width[] = {30, 79};
//                tbl.setWidths(width);
//                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Tipologia.D.P.I."));
//                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Descrizione"));
//                tbl.endHeaders();
//                tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
//                Collection<AttLav_DPI_ViewEx> listaDPI = bean_man.getDPI_ViewEx();
//                for (AttLav_DPI_ViewEx DPI : listaDPI) {
//                    tbl.addCell(DPI.NOM_TPL_DPI);
//                    tbl.addCell(DPI.DES_CAR_DPI);
//                }
//                m_document.add(tbl);
//                if (listaDPI.isEmpty()) {
//                    writeParagraph3(DATI_NON_PRESENTI);
//                }
//                writeLine();
            }

            // SORVEGLIANZA SANITARIA
            if (bSorveglianzaSanitaria) {
                Report_ChildSorveglianzaSanitaria childorveglianzaSanitaria = new Report_ChildSorveglianzaSanitaria(lCOD_MAN, lCOD_AZL, IncludeLogo, this.getCurrentReport());
                childorveglianzaSanitaria.writeRecordCard(bean_man);

//                writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Sorveglianza.sanitaria"));
//                writeText2(ApplicationConfigurator.LanguageManager.getString("MSG_REP_0011"));
//                CenterMiddleTable tbl = new CenterMiddleTable(2);
//                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Esami.dell'attività.lavorativa"));
//                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Periodicità"));
//                tbl.endHeaders();
//                tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
//                Collection<AttLav_VisteMediche_View> listaVisite = bean_man.getVisteMediche_View();
//                for (AttLav_VisteMediche_View Visita : listaVisite) {
//                    tbl.addCell(Visita.NOM_VST_IDO);
//                    // Periodicità Mensile
//                    if (Visita.FAT_PER.equals("M")) {
//                        if (Visita.PER_VSTL == 1) {
//                            tbl.addCell(Visita.PER_VSTL + " "
//                                    + ApplicationConfigurator.LanguageManager.getString("mese"));
//                        } else {
//                            tbl.addCell(Visita.PER_VSTL + " "
//                                    + ApplicationConfigurator.LanguageManager.getString("mesi"));
//                        }
//                        // Periodicità Unica
//                    } else if (Visita.FAT_PER.equals("U")) {
//                        tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Unica"));
//                    }
//                }
//                m_document.add(tbl);
//                if (listaVisite.isEmpty()) {
//                    writeParagraph3(DATI_NON_PRESENTI);
//                }
//                writeLine();
            }

            //  MACCHINE/ATTREZZATURE ASSOCIATE ALLE MANSIONI
            if (ApplicationConfigurator.isModuleEnabled(MODULES.ATT_LAV_MAC) && bMacchineAttrezatureMansioni) {
                //
                //Esttraggo i dati relativi alle schede Macchine/Attrezzaure
                //

                Report_ChildMacchineAttrezzature childMacchineAttrezzature = new Report_ChildMacchineAttrezzature(lCOD_MAN, lCOD_AZL, IncludeLogo, this.getCurrentReport());
                childMacchineAttrezzature.writeRecordCard(bean_man);
//                Collection<MacchinaByAttivitaLavorative_View> listaMacchina = bean_man.getMacchina_View();
//               
//                writeParagraph1(ApplicationConfigurator.LanguageManager.getString(
//                        ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
//                        ? "Macchine.attrezzature.impianti.associate.mansioni"
//                        : "Macchine/Attrezzature.associate.mansioni"));
//                //Se non ci sono dati per il solo profilo MSR il DVR non riporta alcuna informazione
//                if (!listaMacchina.isEmpty()) {
//                CenterMiddleTable tbl = new CenterMiddleTable(1);
//                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString(
//                        ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
//                        ? "Macchine.attrezzature.impianti"
//                        : "Macchine/Attrezzature"));
//                tbl.endHeaders();
//                tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
//               
//                for (MacchinaByAttivitaLavorative_View macchina : listaMacchina) {
//                    tbl.addCell(macchina.DES_MAC);
//                }
//                m_document.add(tbl);
//                if (listaMacchina.isEmpty()) {
//                    writeParagraph3(DATI_NON_PRESENTI);
//                }
//                }
//                writeLine();
            }

            // DOCUMENTI
            if (bDocumentazione) {
                Report_ChildDocumentazione childDocumentazione = new Report_ChildDocumentazione(lCOD_MAN, lCOD_AZL, IncludeLogo, this.getCurrentReport());
                childDocumentazione.writeRecordCard(bean_man);

//                writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Documenti"));
//                CenterMiddleTable tbl = new CenterMiddleTable(1);
//                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Titolo.del.documento"));
//                tbl.endHeaders();
//                tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
//                Collection<ReportAttLav_Documenti_View> listaDocumenti = bean_man.getReportDocumenti_View();
//                for (ReportAttLav_Documenti_View Documento : listaDocumenti) {
//                    tbl.addCell(Documento.TIT_DOC);
//                }
//                m_document.add(tbl);
//                if (listaDocumenti.isEmpty()) {
//                    writeParagraph3(DATI_NON_PRESENTI);
//                }
            }
        }
        closeDocument();
    }

}
