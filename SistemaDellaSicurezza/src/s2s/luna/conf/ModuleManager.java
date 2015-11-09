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
package s2s.luna.conf;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Iterator;

/**
 *
 * @author Dario
 */
public class ModuleManager {

    public enum LANGUAGES {

        FRANCESE("FRANCESE", "FRANCESE"),
        ITALIANO("ITALIANO", "ITALIANO");

        private final String name;
        private final String desc;

        LANGUAGES(String name, String desc) {
            this.name = name;
            this.desc = desc;
        }

        public String getName() {
            return name;
        }

        public String getDesc() {
            return desc;
        }
    }

    public enum PROFILES {

        //  PROFILO DI BASE DA UTILIZZARE PER LE NUOVE INSTALLAZIONI
        BASE("BASE", "BASE"),
        //  PROFILO DI BASE + SAFETY INTELLIGENCE
        BASE_SI("BASE_SI", "BASE + SAFETY INTELLIGENCE"),
        //  Profilo misto, utilizzato per le demo
        DEMO("DEMO", "DEMO"),
        GSE("GSE", "PROFILO  A"),
        RM("RM", " PROFILO  B"),
        MSR("MSR", "PROFILO  C"),
        AUV("AUV", "PROFILO  D"),
        SDP("SDP", "PROFILO  E"),
        //  Profilo usato durante sviluppo.
        SVILUPPO("SVILUPPO", "SVILUPPO");

        private final String name;
        private final String desc;

        PROFILES(String name, String desc) {
            this.name = name;
            this.desc = desc;
        }

        public String getName() {
            return name;
        }

        public String getDesc() {
            return desc;
        }
    }

    public enum MODULES {

        REPORT_BO(
                "Reportistica evoluta con BO",
                "Reportistica evoluta con BO"),
        REPORT_PENTAHO(
                "Reportistica evoluta con PENTAHO",
                "Reportistica evoluta con PENTAHO"),
        DUVRI(
                "D.U.V.R.I.",
                "D.U.V.R.I."),
        EMAIL_ASS_DPI(
                "Comunicazione di assegnazione D.P.I. via email",
                "Comunicazione di assegnazione D.P.I. via email"),
        DOC_LINK(
                "Link esterno al documento",
                "Link esterno al documento"),
        LDAP(
                "Integrazione LDAP",
                "Integrazione LDAP"),
        MORE_DPD_INFO(
                "Informazioni aggiuntive del personale",
                "Informazioni aggiuntive del personale"),
        ASSOC_SAP_S2S(
                "Associazione SAP-S2S",
                "Associazione SAP-S2S"),
        GEST_DPD_EXT(
                "Gestione estesa del dipendente",
                "Gestione estesa del dipendente"),
        ANA_RUO_SIC(
                "Gestione \"Ruoli per la sicurezza\"",
                "Gestione anagrafica dei \"Ruoli per la sicurezza\""),
        UNI_SIC_4_DIP(
                "Unità di sicurezza per dipendente",
                "Disattiva il tab (e la relativa gestione) delle \"Unità organizzative\" "
                + "all'interno della funzionalità \"Unità di sicurezza\". "
                + "Inserisce nella funzionalità \"Unità di sicurezza\" la gestione (tramite tab) "
                + "dei dipendenti e dei relativi ruoli per la sicurezza a questi associati."),
        ANA_TPL_CON(
                "Gestione \"Tipologie contrattuali\"",
                "Gestione anagrafica delle \"Tipologie contrattuali\""),
        DPD_UO_MAN_TPL_CON(
                "Attività lavorativa - \"Tipologie contrattuali\"",
                "Introduce la gestione delle \"Tipologie contrattuali\" all'interno della "
                + "funzionalità di \"Attività lavorativa\", legata all'anagrafica dipendente."),
        MOD_FORM_GSE(
                "Modifiche layout di maschera",
                "Modifiche varie alle maschere del \"Sistema della Sicurezza\""),
        MOD_DVR_GSE(
                "DVR - Modifiche layout di stampa",
                "Modifiche varie alla stampa del D.V.R."),
        PROP_LUO_FIS(
                "Propagazione \"Luoghi Fisici\"",
                "Abilità il meccanismo di \"propagazione ad altre aziende\" per la "
                + "funzionalità dei \"Luoghi Fisici\"."),
        TIT_4(
                "Gestione cantieri",
                "Gestione della parte cantieri del \"Titolo IV\""),
        REP_MAN_BY_CAG_FAT(
                "DVR - Stampa rischi per categoria",
                "All'interno della stampa della scheda di attività lavorativa "
                + "stampa i rischi raggruppandoli per categoria del fattore di rischio "
                + "invece che per operazione svolta."),
        MOD_FORM_MSR(
                "Modifiche layout di maschera",
                "Modifiche varie alle maschere del \"Sistema della Sicurezza\""),
        MOD_DVR_MSR(
                "DVR - Modifiche layout di stampa",
                "Modifiche varie alla stampa del D.V.R."),
        MOD_REPORT_MSR(
                "Modifiche layout di stampa",
                "Modifiche varie alle stampe prodotte dal \"Sistema della Sicurezza\""),
        DVR_ALLEGATI(
                "DVR - Gestione \"Documenti generali\"",
                "Abilita la gestione dei documenti generali legati al DVR. "
                + "Tali documenti vengono inseriti allo stesso livello delle sezioni."),
        DVR_MAC_4_OPE_SVO(
                "DVR - Stampa macchinari per Operazione svolta",
                "Stampa l'elenco dei macchinari legati all'operazione svolta "
                + "immediatamente sotto il titolo della stessa e non li presenta "
                + "più nella sezione di ogni rischio legato all'operazione svolta stessa."),
        MIS_PET_ISTR_OPE(
                "Istruzioni operative su M.P.P.",
                "Abilita la gestione delle istruzioni operative correlate alle "
                + "misure di prevenzione e protezione."),
        ATT_LAV_DOC(
                "Attività Lavorativa - \"Documenti\"",
                "Abilita la gestione dei documenti per l'attività lavorativa."),
        CORSI_4_ATT_LAV(
                "Associazione diretta \"Attività/Corsi\"",
                "Abilita la gestione dei corsi in maniera diretta sull'attività lavorativa "
                + "eliminando nel contempo tale gestione dai rischi."),
        PRO_SAN_4_ATT_LAV(
                "Associazione diretta \"Attività/Protocolli sanitari\"",
                "Abilita la gestione dei protocolli sanitari in maniera diretta "
                + "sull'attività lavorativa eliminando nel contempo tale gestione dai rischi."),
        DPI_4_ATT_LAV(
                "Associazione diretta \"Attività/D.P.I.\"",
                "Abilita la gestione dei DPI in maniera diretta sull'attività lavorativa "
                + "eliminando nel contempo tale gestione dai rischi."),
        ATT_LAV_MAC(
                "Associazione \"Attività/Macchinari\"",
                "Abilita la gestione dei macchinari correlati all'attività lavorativa."),
        AGE_CHI(
                "Associazione \"Attività/Agenti chimici\"",
                "Associazione \"Attività/Agenti chimici\""),
        IDX_RSO_CHI(
                "Nuova gestione indice rischio chimico",
                "Nuova gestione dell'indice di rischio chimico con inserimento del campo note."),
        LUO_FSC_MIS_PET(
                "DVR - Stampa rischi per luoghi fisici",
                "Nella stampa dei luoghi fisici sotto ogni rischio vengono stampati anche l'entita' del "
                + "danno e le misure di prevenzione e protezione associate al rischio stesso."),
        DOC_ASS(
                "Associazione \"Infortuni/Documenti\"",
                "Abilita la gestione dei documenti correlati agli infortuni."),
        GEST_INFO_EXTENDED(
                "Riapertura infortuni",
                "Aggiunge la gestione della riapertura infortuni"),
        LUOGHI_FISICI_3_LIVELLI(
                "Luoghi fisici su 3 livelli",
                "Gestisce i luoghi fisici sui 3 livelli \"Sede/Immobili/Luoghi Fisici\""),
        DVR_LINK_PARAGRAFO_DESCRIZIONI(
                "DVR - Link \"Paragrafo/Descrizioni\"",
                "Permette di legare le descrizioni di determinati elementi del \"Sistema della Sicurezza\" "
                + "alla descrizione del paragrafo"),
        DVR_SCHEDA_VALUTAZIONE_RISCHIO(
                "DVR - Scheda \"Valutazione del rischio\"",
                "Abilita la tipologia di scheda \"Tabella di valutazione del rischio\" nella stampa del DVR. "
                + "Tale scheda produce una tabella di calcolo composta dall'elenco anagrafico dei rischi e dalle loro rispettive magnitudo"),
        DVR_SCHEDA_RISCHI(
                "DVR - Scheda \"Rischi\"",
                "Abilita la tipologia di scheda \"Rischi\" nella stampa del DVR. "
                + "Tale scheda produce una stampa dei rischi cosi organizzata: "
                + "Categoria (del rischio) / Nome del rischio e descrizione / Misure di prevenzione associate"),
        SEG_REG_MON(
                "Registro di monitoraggio",
                "Estende la funzionalità \"Verifiche S.P.P. > Segnalazioni\" per la gestione di un "
                + "registro di monitoraggio delle segnalazioni stesse."),
        DVR_ARCHIVIO(
                "DVR - Archivio",
                "Abilita il meccanismo di archiviazione del DVR. "
                + "I DVR archiviati vengono inseriti allo stesso livello delle sezioni."),
        MIS_PET_LUO_FSC_DVR(
                "Stampa luoghi fisici",
                "Abilita la visualizzazione delle Misure di prevenzione "
                + "associate ai rischi nei luoghi fisici"),
        MOD_FORM_SDP(
                "Modifiche layout di maschera",
                "Modifiche varie alle maschere del \"Sistema della Sicurezza\""),
        MOD_DVR_SDP(
                "DVR - Modifiche layout di stampa",
                "Modifiche varie alla stampa del D.V.R."),
        DEL_MSG_EXT(
                "Messaggi parlanti sull'eliminazione record",
                "Durante il tentativo di eliminazione di un informazione il sistema verifica la presenza di eventuali legami, tra questa ed altri dati, che ne impediscono la cancellazione e se presenti li segnala"),
        TAB_COL_ORD(
                "Tab ordinabili",
                "Abilita la possibilità di ordinare le colonne dei \"tab\"."),
        ENHANCED_GRID(
                "Maschere elenco estese",
                "Abilita proprietà estese sulle maschere elenco, tre le quali: ordinamenti multipli delle colonne, filtri multipli, evidenza della riga al passaggio del mouse, ecc.."),
        ALL(
                "Tutti i moduli",
                "Abilita tutti i moduli del \"Sistema della Sicurezza\""),
        INVISIBLE_DVR_FIELD(
                "DVR: campi e parti invisibili",
                "Rende invisibili alcuni campi e parti del DVR: nome misura in elenco misure di prevenzione, l'allegato 1 relativo alla associazione luogo fisico - tipologia DPI, i rischi delle schede di reparto"),
        INVISIBLE_FIELD(
                "Campi invisibili",
                "Rende invisibili alcuni campi del sistema: tutte le colonne numero, data compilazione e versione in misure di prevenzione, data rilevazione, pianificazione rivalutazione del rischio e nominativo rilevatore nella maschera di gestione dei rischi, numero, matricola e fornitore personale e servizi nella maschera elenco dei lavoratori"),
        ENABLE_RECORD(
                "Abilita il record",
                "Permette la riattivazione di un dipendente dimesso grazie ad un apposito bottone nella maschera di un lavoratore in sola consultazione");

        private final String name;
        private final String desc;

        MODULES(String name, String desc) {
            this.name = name;
            this.desc = desc;
        }

        public String getName() {
            return name;
        }

        public String getDesc() {
            return desc;
        }
    }

    class enumProfileComparator implements Comparator<ModuleManager> {

        public int compare(ModuleManager o1, ModuleManager o2) {
            return o1.Profilo.getName().compareTo(o2.Profilo.getName());
        }
    }

    class enumModuleComparator implements Comparator<MODULES> {

        public int compare(MODULES o1, MODULES o2) {
            return o1.getName().compareTo(o2.getName());
        }
    }

    class enumLanguageComparator implements Comparator<LANGUAGES> {

        public int compare(LANGUAGES o1, LANGUAGES o2) {
            return o1.getName().compareTo(o2.getName());
        }
    }

    private static ModuleManager moduleManager = null;

    private ModuleManager() {
        //
    }

    private PROFILES Profilo = null;
    private List<MODULES> ListaModuli = new ArrayList<MODULES>();
    private List<ModuleManager> RoleTab = new ArrayList<ModuleManager>();

    private ModuleManager buildRolesTab() {
        enumProfileComparator profileComparator = null;
        enumModuleComparator moduleComparator = null;

        if (moduleManager == null) {

            moduleManager = new ModuleManager();
            ModuleManager newRole;
            profileComparator = new enumProfileComparator();
            moduleComparator = new enumModuleComparator();

            // BASE
            newRole = new ModuleManager();
            newRole.Profilo = PROFILES.BASE;
            newRole.ListaModuli.add(MODULES.DUVRI);
            newRole.ListaModuli.add(MODULES.DOC_LINK);
            newRole.ListaModuli.add(MODULES.LDAP);
            newRole.ListaModuli.add(MODULES.MORE_DPD_INFO);
            newRole.ListaModuli.add(MODULES.ANA_TPL_CON);
            newRole.ListaModuli.add(MODULES.DPD_UO_MAN_TPL_CON);
            Collections.sort(newRole.ListaModuli, moduleComparator);
            moduleManager.RoleTab.add(newRole);

            // BASE_SI
            // - Parte comune (BASE)
            newRole = new ModuleManager();
            newRole.Profilo = PROFILES.BASE_SI;
            newRole.ListaModuli.add(MODULES.DUVRI);
            newRole.ListaModuli.add(MODULES.DOC_LINK);
            newRole.ListaModuli.add(MODULES.LDAP);
            newRole.ListaModuli.add(MODULES.MORE_DPD_INFO);
            newRole.ListaModuli.add(MODULES.ANA_TPL_CON);
            newRole.ListaModuli.add(MODULES.DPD_UO_MAN_TPL_CON);
            // - Moduli AD-HOC
            newRole.ListaModuli.add(MODULES.REPORT_BO);
            Collections.sort(newRole.ListaModuli, moduleComparator);
            moduleManager.RoleTab.add(newRole);

            // DEMO
            // - Parte comune (BASE)
            newRole = new ModuleManager();
            newRole.Profilo = PROFILES.DEMO;
            newRole.ListaModuli.add(MODULES.DUVRI);
            newRole.ListaModuli.add(MODULES.DOC_LINK);
            newRole.ListaModuli.add(MODULES.LDAP);
            newRole.ListaModuli.add(MODULES.MORE_DPD_INFO);
            newRole.ListaModuli.add(MODULES.ANA_TPL_CON);
            newRole.ListaModuli.add(MODULES.DPD_UO_MAN_TPL_CON);
            // - Moduli AD-HOC
            newRole.ListaModuli.add(MODULES.DVR_ALLEGATI);
            newRole.ListaModuli.add(MODULES.ANA_RUO_SIC);
            newRole.ListaModuli.add(MODULES.UNI_SIC_4_DIP);
            newRole.ListaModuli.add(MODULES.DVR_LINK_PARAGRAFO_DESCRIZIONI);
            newRole.ListaModuli.add(MODULES.DVR_SCHEDA_RISCHI);
            newRole.ListaModuli.add(MODULES.SEG_REG_MON);
            newRole.ListaModuli.add(MODULES.REPORT_BO);
            newRole.ListaModuli.add(MODULES.ASSOC_SAP_S2S);
            newRole.ListaModuli.add(MODULES.DEL_MSG_EXT);
            newRole.ListaModuli.add(MODULES.TAB_COL_ORD);
            newRole.ListaModuli.add(MODULES.DVR_ARCHIVIO);
            newRole.ListaModuli.add(MODULES.TIT_4);
            newRole.ListaModuli.add(MODULES.ENHANCED_GRID);
            Collections.sort(newRole.ListaModuli, moduleComparator);
            moduleManager.RoleTab.add(newRole);

            // MSR
            // - Parte comune (BASE)
            newRole = new ModuleManager();
            newRole.Profilo = PROFILES.MSR;
            newRole.ListaModuli.add(MODULES.DUVRI);
            newRole.ListaModuli.add(MODULES.DOC_LINK);
            newRole.ListaModuli.add(MODULES.LDAP);
            newRole.ListaModuli.add(MODULES.MORE_DPD_INFO);
            newRole.ListaModuli.add(MODULES.ANA_TPL_CON);
            newRole.ListaModuli.add(MODULES.DPD_UO_MAN_TPL_CON);
            // - Moduli AD-HOC
            newRole.ListaModuli.add(MODULES.MOD_DVR_MSR);
            newRole.ListaModuli.add(MODULES.DVR_ALLEGATI);
            newRole.ListaModuli.add(MODULES.DVR_MAC_4_OPE_SVO);
            newRole.ListaModuli.add(MODULES.MIS_PET_ISTR_OPE);
            newRole.ListaModuli.add(MODULES.ATT_LAV_DOC);
            newRole.ListaModuli.add(MODULES.CORSI_4_ATT_LAV);
            newRole.ListaModuli.add(MODULES.PRO_SAN_4_ATT_LAV);
            newRole.ListaModuli.add(MODULES.DPI_4_ATT_LAV);
            newRole.ListaModuli.add(MODULES.GEST_INFO_EXTENDED);
            newRole.ListaModuli.add(MODULES.ATT_LAV_MAC);
            newRole.ListaModuli.add(MODULES.AGE_CHI);
            newRole.ListaModuli.add(MODULES.IDX_RSO_CHI);
            newRole.ListaModuli.add(MODULES.LUO_FSC_MIS_PET);
            newRole.ListaModuli.add(MODULES.MIS_PET_LUO_FSC_DVR);
            newRole.ListaModuli.add(MODULES.MOD_FORM_MSR);
            newRole.ListaModuli.add(MODULES.MOD_REPORT_MSR);
            newRole.ListaModuli.add(MODULES.TAB_COL_ORD);
            newRole.ListaModuli.add(MODULES.ENHANCED_GRID);
            newRole.ListaModuli.add(MODULES.REPORT_BO);
            newRole.ListaModuli.add(MODULES.ENABLE_RECORD);
            newRole.ListaModuli.add(MODULES.INVISIBLE_DVR_FIELD);
            newRole.ListaModuli.add(MODULES.INVISIBLE_FIELD);
            /*
             * Durante il tentativo di eliminazione di un informazione 
             * il sistema verifica la presenza di eventuali legami, 
             * tra questa ed altri dati, che ne impediscono la cancellazione 
             * e se presenti li segnala.
             */
            newRole.ListaModuli.add(MODULES.DEL_MSG_EXT);
            Collections.sort(newRole.ListaModuli, moduleComparator);
            moduleManager.RoleTab.add(newRole);

            // AUV
            // - Parte comune (BASE)
            newRole = new ModuleManager();
            newRole.Profilo = PROFILES.AUV;
            newRole.ListaModuli.add(MODULES.DUVRI);
            newRole.ListaModuli.add(MODULES.DOC_LINK);
            newRole.ListaModuli.add(MODULES.LDAP);
            newRole.ListaModuli.add(MODULES.MORE_DPD_INFO);
            newRole.ListaModuli.add(MODULES.ANA_TPL_CON);
            newRole.ListaModuli.add(MODULES.DPD_UO_MAN_TPL_CON);
            // - Moduli AD-HOC
            newRole.ListaModuli.add(MODULES.MOD_DVR_MSR);
            newRole.ListaModuli.add(MODULES.DVR_ALLEGATI);
            newRole.ListaModuli.add(MODULES.DVR_MAC_4_OPE_SVO);
            newRole.ListaModuli.add(MODULES.MIS_PET_ISTR_OPE);
            newRole.ListaModuli.add(MODULES.ATT_LAV_DOC);
            newRole.ListaModuli.add(MODULES.CORSI_4_ATT_LAV);
            newRole.ListaModuli.add(MODULES.PRO_SAN_4_ATT_LAV);
            newRole.ListaModuli.add(MODULES.DPI_4_ATT_LAV);
            newRole.ListaModuli.add(MODULES.GEST_INFO_EXTENDED);
            newRole.ListaModuli.add(MODULES.ATT_LAV_MAC);
            
            newRole.ListaModuli.add(MODULES.MIS_PET_LUO_FSC_DVR);
            newRole.ListaModuli.add(MODULES.MOD_FORM_MSR);
            newRole.ListaModuli.add(MODULES.MOD_REPORT_MSR);
            Collections.sort(newRole.ListaModuli, moduleComparator);
            moduleManager.RoleTab.add(newRole);

            // SDP
            // - Parte comune (BASE)
            newRole = new ModuleManager();
            newRole.Profilo = PROFILES.SDP;
            newRole.ListaModuli.add(MODULES.DUVRI);
            newRole.ListaModuli.add(MODULES.DOC_LINK);
            newRole.ListaModuli.add(MODULES.LDAP);
            newRole.ListaModuli.add(MODULES.MORE_DPD_INFO);
            newRole.ListaModuli.add(MODULES.ANA_TPL_CON);
            newRole.ListaModuli.add(MODULES.DPD_UO_MAN_TPL_CON);
            // - Moduli AD-HOC  
            newRole.ListaModuli.add(MODULES.MOD_DVR_MSR);
            newRole.ListaModuli.add(MODULES.DVR_ALLEGATI);
            newRole.ListaModuli.add(MODULES.DVR_MAC_4_OPE_SVO);
            newRole.ListaModuli.add(MODULES.MIS_PET_ISTR_OPE);
            newRole.ListaModuli.add(MODULES.ATT_LAV_DOC);
            newRole.ListaModuli.add(MODULES.CORSI_4_ATT_LAV);
            newRole.ListaModuli.add(MODULES.PRO_SAN_4_ATT_LAV);
            newRole.ListaModuli.add(MODULES.DPI_4_ATT_LAV);
            newRole.ListaModuli.add(MODULES.GEST_INFO_EXTENDED);
            newRole.ListaModuli.add(MODULES.ATT_LAV_MAC);
            newRole.ListaModuli.add(MODULES.AGE_CHI);
            newRole.ListaModuli.add(MODULES.IDX_RSO_CHI);
            newRole.ListaModuli.add(MODULES.LUO_FSC_MIS_PET);
            newRole.ListaModuli.add(MODULES.MIS_PET_LUO_FSC_DVR);
            newRole.ListaModuli.add(MODULES.MOD_FORM_MSR);
            newRole.ListaModuli.add(MODULES.MOD_REPORT_MSR);
            // - Moduli in aggiunta )    INIZIO
            newRole.ListaModuli.add(MODULES.MOD_FORM_SDP);
            newRole.ListaModuli.add(MODULES.MOD_DVR_SDP);
            newRole.ListaModuli.add(MODULES.ENHANCED_GRID);
            // - Moduli in aggiunta  )    FINE
            newRole.ListaModuli.add(MODULES.TAB_COL_ORD);
            newRole.ListaModuli.add(MODULES.REPORT_BO);
            /*
             * Durante il tentativo di eliminazione di un informazione 
             * il sistema verifica la presenza di eventuali legami, 
             * tra questa ed altri dati, che ne impediscono la cancellazione 
             * e se presenti li segnala.
             */
            newRole.ListaModuli.add(MODULES.DEL_MSG_EXT);
            Collections.sort(newRole.ListaModuli, moduleComparator);
            moduleManager.RoleTab.add(newRole);

            // GSE
            // - Parte comune (BASE)
            newRole = new ModuleManager();
            newRole.Profilo = PROFILES.GSE;
            newRole.ListaModuli.add(MODULES.DUVRI);
            newRole.ListaModuli.add(MODULES.DOC_LINK);
            newRole.ListaModuli.add(MODULES.LDAP);
            newRole.ListaModuli.add(MODULES.MORE_DPD_INFO);
            newRole.ListaModuli.add(MODULES.ANA_TPL_CON);
            newRole.ListaModuli.add(MODULES.DPD_UO_MAN_TPL_CON);
            // - Moduli AD-HOC
            newRole.ListaModuli.add(MODULES.ANA_RUO_SIC);
            newRole.ListaModuli.add(MODULES.UNI_SIC_4_DIP);
            newRole.ListaModuli.add(MODULES.MOD_FORM_GSE);
            /* Al momento il meccanismo di propagazione dei luoghi fisici
             * viene escluso perchè non piu compatibile con la gestione degli
             * stessi du 3 livelli.
             * newRole.ListaModuli.add(MODULES.PROP_LUO_FIS);
             */
            newRole.ListaModuli.add(MODULES.REP_MAN_BY_CAG_FAT);
            newRole.ListaModuli.add(MODULES.MOD_DVR_GSE);
            newRole.ListaModuli.add(MODULES.LUOGHI_FISICI_3_LIVELLI);
            newRole.ListaModuli.add(MODULES.DVR_LINK_PARAGRAFO_DESCRIZIONI);
            newRole.ListaModuli.add(MODULES.DVR_SCHEDA_VALUTAZIONE_RISCHIO);
            newRole.ListaModuli.add(MODULES.DVR_SCHEDA_RISCHI);
            newRole.ListaModuli.add(MODULES.SEG_REG_MON);
            newRole.ListaModuli.add(MODULES.REPORT_BO);
            newRole.ListaModuli.add(MODULES.DVR_ARCHIVIO);
            Collections.sort(newRole.ListaModuli, moduleComparator);
            moduleManager.RoleTab.add(newRole);

            // RM
            // - Parte comune (BASE)
            newRole = new ModuleManager();
            newRole.Profilo = PROFILES.RM;
            newRole.ListaModuli.add(MODULES.DUVRI);
            newRole.ListaModuli.add(MODULES.DOC_LINK);
            newRole.ListaModuli.add(MODULES.LDAP);
            newRole.ListaModuli.add(MODULES.MORE_DPD_INFO);
            newRole.ListaModuli.add(MODULES.ANA_TPL_CON);
            newRole.ListaModuli.add(MODULES.DPD_UO_MAN_TPL_CON);
            // - Moduli AD-HOC
            newRole.ListaModuli.add(MODULES.REPORT_BO);
            newRole.ListaModuli.add(MODULES.TIT_4);
            Collections.sort(newRole.ListaModuli, moduleComparator);
            moduleManager.RoleTab.add(newRole);

            // SVILUPPO
            // - Parte comune (BASE)
            newRole = new ModuleManager();
            newRole.Profilo = PROFILES.SVILUPPO;
            newRole.ListaModuli.add(MODULES.DUVRI);
            newRole.ListaModuli.add(MODULES.DOC_LINK);
            newRole.ListaModuli.add(MODULES.LDAP);
            newRole.ListaModuli.add(MODULES.MORE_DPD_INFO);
            newRole.ListaModuli.add(MODULES.ANA_TPL_CON);
            newRole.ListaModuli.add(MODULES.DPD_UO_MAN_TPL_CON);
            // - Moduli AD-HOC
            newRole.ListaModuli.add(MODULES.EMAIL_ASS_DPI);
            newRole.ListaModuli.add(MODULES.DVR_ALLEGATI);
            newRole.ListaModuli.add(MODULES.ANA_RUO_SIC);
            newRole.ListaModuli.add(MODULES.UNI_SIC_4_DIP);
            newRole.ListaModuli.add(MODULES.LUOGHI_FISICI_3_LIVELLI);
            newRole.ListaModuli.add(MODULES.DVR_LINK_PARAGRAFO_DESCRIZIONI);
            newRole.ListaModuli.add(MODULES.DVR_SCHEDA_RISCHI);
            newRole.ListaModuli.add(MODULES.SEG_REG_MON);
            newRole.ListaModuli.add(MODULES.REPORT_BO);
            newRole.ListaModuli.add(MODULES.ASSOC_SAP_S2S);
            newRole.ListaModuli.add(MODULES.TIT_4);
            newRole.ListaModuli.add(MODULES.DVR_ARCHIVIO);
            newRole.ListaModuli.add(MODULES.DEL_MSG_EXT);
            newRole.ListaModuli.add(MODULES.TAB_COL_ORD);
            newRole.ListaModuli.add(MODULES.ENHANCED_GRID);
            Collections.sort(newRole.ListaModuli, moduleComparator);
            moduleManager.RoleTab.add(newRole);
        }

        Collections.sort(moduleManager.RoleTab, profileComparator);
        return moduleManager;
    }

    static boolean isModuleEnable(PROFILES profiloToCheck, MODULES moduleToCheck) {
        if (moduleManager == null) {
            new ModuleManager().buildRolesTab();
        }

        ModuleManager profilo = null;
        MODULES modulo = null;
        boolean enabled = false;

        Iterator<ModuleManager> ListaProfili_it = moduleManager.RoleTab.iterator();
        while (ListaProfili_it.hasNext()) {
            profilo = ListaProfili_it.next();
            if (profilo.Profilo.equals(profiloToCheck)) {
                Iterator<MODULES> ModuliCliente_it = profilo.ListaModuli.iterator();
                while (ModuliCliente_it.hasNext()) {
                    modulo = ModuliCliente_it.next();
                    if (modulo.equals(moduleToCheck) || modulo.equals(modulo.ALL)) {
                        enabled = true;
                        break;
                    }
                }
                if (enabled) {
                    break;
                }
            }
        }
        return enabled;
    }

    static Collection getProfileModules(PROFILES profiloToCheck) {
        if (moduleManager == null) {
            new ModuleManager().buildRolesTab();
        }

        ModuleManager profilo = null;

        Iterator<ModuleManager> ListaProfili_it = moduleManager.RoleTab.iterator();
        while (ListaProfili_it.hasNext()) {
            profilo = ListaProfili_it.next();
            if (profilo.Profilo.equals(profiloToCheck)) {
                return profilo.ListaModuli;
            }
        }
        return null;
    }

    static Collection getProfiles() {
        if (moduleManager == null) {
            new ModuleManager().buildRolesTab();
        }
        return moduleManager.RoleTab;
    }

    public PROFILES getProfile() {
        return Profilo;
    }
}
