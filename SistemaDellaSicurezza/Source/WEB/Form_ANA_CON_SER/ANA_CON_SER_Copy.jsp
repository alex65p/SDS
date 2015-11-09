<%--   ======================================================================== --%>
<%--                                                                            --%>
<%-- @copyright Copyright (c) 2010-2015, S2S s.r.l. --%>
<%-- @license   http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2 --%>
<%-- @version   6.0  --%>
<%-- This file is part of SdS - Sistema della Sicurezza  . --%>
<%-- SdS - Sistema della Sicurezza   is free software: you can redistribute it and/or modify --%>
<%-- it under the terms of the GNU General Public License as published by  --%>
<%-- the Free Software Foundation, either version 3 of the License, or  --%>
<%-- (at your option) any later version.  --%>

<%-- SdS - Sistema della Sicurezza  is distributed in the hope that it will be useful, --%>
<%-- but WITHOUT ANY WARRANTY; without even the implied warranty of --%>
<%-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the --%>
<%-- GNU General Public License for more details. --%>

<%-- You should have received a copy of the GNU General Public License --%>
<%-- along with SdS - Sistema della Sicurezza .  If not, see <http://www.gnu.org/licenses/gpl-2.0.html>  GNU Public License v.2 --%>
<%--                                                                            --%>
<%--   ======================================================================== --%>

<%--
            Document   : ANA_CON_SER_Delete
            Created on : 29-apr-2008, 10.44.56
            Author     : Giancarlo Servadei
--%>

<%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>
<%@ page import="com.apconsulting.luna.ejb.SubAppAnalisiRischi.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServLuoghiEsecuzione.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServSubApp.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServCentriEmergenza.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServServiziSanitari.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServFluidi.*" %>
<%@ page import="com.apconsulting.luna.ejb.AppProdottiSostanze.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/ContServRischiInterferenza/ContServRischiInterferenzaBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ContServRischiInterferenza/ContServRischiInterferenzaBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/ContServPrestitoMateriali/ContServPrestitoMaterialiBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ContServPrestitoMateriali/ContServPrestitoMaterialiBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/ContServIspezioni/ContServIspezioniBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ContServIspezioni/ContServIspezioniBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/ContServReferentiLoco/ContServReferentiLocoBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ContServReferentiLoco/ContServReferentiLocoBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/AppReferentiLoco/AppReferentiLocoBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/AppReferentiLoco/AppReferentiLocoBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/AppPersonaleCoinvolto/AppPersonaleCoinvoltoBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/AppPersonaleCoinvolto/AppPersonaleCoinvoltoBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/AppAnalisiRischi/AppAnalisiRischiBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/AppAnalisiRischi/AppAnalisiRischiBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/SubAppPersonaleCoinvolto/SubAppPersonaleCoinvoltoBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/SubAppPersonaleCoinvolto/SubAppPersonaleCoinvoltoBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/SubAppProdottiSostanze/SubAppProdottiSostanzeBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/SubAppProdottiSostanze/SubAppProdottiSostanzeBean.jsp"%>

<%@ page import="java.util.*"%>
<%@ page import="s2s.utils.text.StringManager"%>

<script type="text/javascript" src="../_scripts/Alert.js"></script>

<script type="text/javascript">
	var err=false;
</script>

<%
    Checker c = new Checker();

    //- checking for required fields
    long lCOD_SRV = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Copia.da"), request.getParameter("COPIA_DA"), true);
    
    if (c.isError) {
        String err = c.printErrors();
        out.println(
                "<script>" +
                    "alert(\"" + err + "\");" +
                    "err=true;" +
                "</script>");
        return;
    }
    
    IAnaContServHome ContrattoOriginale_Home=(IAnaContServHome)PseudoContext.lookup("AnaContServBean");
    IAnaContServ ContrattoOriginale_Bean = null;
    IAnaContServ NuovoContratto_Bean = null;
    
    Collection col = null;
    Collection nested_col = null;
    Iterator it = null;
    Iterator nested_it = null;
    String returnMessage = null;
    
    IContServLuoghiEsecuzioneHome ContrattoOriginale_LuoghiEsecuzioneHome=
            (IContServLuoghiEsecuzioneHome)PseudoContext.lookup("ContServLuoghiEsecuzioneBean");
    
    IContServSubAppHome ContrattoOriginale_DettaglioSubappalatriciHome=
            (IContServSubAppHome)PseudoContext.lookup("ContServSubAppBean");
    IContServSubApp NuovoContratto_SubApp_Bean = null;

    IContServRischiInterferenzaHome ContrattoOriginale_RischiInterferenzaHome=
            (IContServRischiInterferenzaHome)PseudoContext.lookup("ContServRischiInterferenzaBean");
    IContServRischiInterferenza NuovoContratto_RischiInterferenza_Bean = null;

    IContServCentriEmergenzaHome ContrattoOriginale_CentriEmergenzaHome=
            (IContServCentriEmergenzaHome)PseudoContext.lookup("ContServCentriEmergenzaBean");
    IContServCentriEmergenza NuovoContratto_CentriEmergenza_Bean = null;
    
    IContServServiziSanitariHome ContrattoOriginale_ServiziSanitariHome=
            (IContServServiziSanitariHome)PseudoContext.lookup("ContServServiziSanitariBean");
    IContServServiziSanitari NuovoContratto_ServiziSanitari_Bean = null;

    IContServFluidiHome ContrattoOriginale_FluidiHome=
            (IContServFluidiHome)PseudoContext.lookup("ContServFluidiBean");
    IContServFluidi NuovoContratto_Fluidi_Bean = null;

    IContServPrestitoMaterialiHome ContrattoOriginale_PrestitoMaterialiHome=
            (IContServPrestitoMaterialiHome)PseudoContext.lookup("ContServPrestitoMaterialiBean");
    IContServPrestitoMateriali NuovoContratto_PrestitoMateriali_Bean = null;

    IContServIspezioniHome ContrattoOriginale_IspezioniHome=
            (IContServIspezioniHome)PseudoContext.lookup("ContServIspezioniBean");
    IContServIspezioni NuovoContratto_Ispezioni_Bean = null;
    
    IContServReferentiLocoHome ContrattoOriginale_ReferentiLocoHome=
            (IContServReferentiLocoHome)PseudoContext.lookup("ContServReferentiLocoBean");
    IContServReferentiLoco NuovoContratto_ReferentiLoco_Bean = null;
    
    IAppReferentiLocoHome ContrattoOriginale_AppReferentiLocoHome=
            (IAppReferentiLocoHome)PseudoContext.lookup("AppReferentiLocoBean");
    IAppReferentiLoco NuovoContratto_AppReferentiLoco_Bean = null;
    
    IAppPersonaleCoinvoltoHome ContrattoOriginale_AppPersonaleCoinvoltoHome=
            (IAppPersonaleCoinvoltoHome)PseudoContext.lookup("AppPersonaleCoinvoltoBean");
    IAppPersonaleCoinvolto NuovoContratto_AppPersonaleCoinvolto_Bean = null;
    
    IAppProdottiSostanzeHome ContrattoOriginale_AppProdottiSostanzeHome=
            (IAppProdottiSostanzeHome)PseudoContext.lookup("AppProdottiSostanzeBean");
    IAppProdottiSostanze NuovoContratto_AppProdottiSostanze_Bean = null;
    
    IAppAnalisiRischiHome ContrattoOriginale_AppAnalisiRischiHome=
            (IAppAnalisiRischiHome)PseudoContext.lookup("AppAnalisiRischiBean");
    IAppAnalisiRischi NuovoContratto_AppAnalisiRischi_Bean = null;
    
    ISubAppPersonaleCoinvoltoHome ContrattoOriginale_SubAppPersonaleCoinvoltoHome=
            (ISubAppPersonaleCoinvoltoHome)PseudoContext.lookup("SubAppPersonaleCoinvoltoBean");
    ISubAppPersonaleCoinvolto NuovoContratto_SubAppPersonaleCoinvolto_Bean = null;
    
    ISubAppProdottiSostanzeHome ContrattoOriginale_SubAppProdottiSostanzeHome=
            (ISubAppProdottiSostanzeHome)PseudoContext.lookup("SubAppProdottiSostanzeBean");
    ISubAppProdottiSostanze NuovoContratto_SubAppProdottiSostanze_Bean = null;
    
    ISubAppAnalisiRischiHome ContrattoOriginale_SubAppAnalisiRischiHome=
            (ISubAppAnalisiRischiHome)PseudoContext.lookup("SubAppAnalisiRischiBean");
    ISubAppAnalisiRischi NuovoContratto_SubAppAnalisiRischi_Bean = null;
    
    try {
        // Estraggo il contratto di partenza, da copiare.
        ContrattoOriginale_Bean = 
                ContrattoOriginale_Home.findByPrimaryKey(lCOD_SRV);

        // Ottengo il progressivo per il nuovo contratto.
        String strPRO_CON = ContrattoOriginale_Home.getProgressivoContratto
                        (ContrattoOriginale_Bean.getCOD_AZL(), 
                        String.valueOf(Calendar.getInstance().get(Calendar.YEAR)));    

        // Inserisco il nuovo contratto
        NuovoContratto_Bean = ContrattoOriginale_Home.create(
                ContrattoOriginale_Bean.getCOD_AZL(), 
                strPRO_CON, 
                ContrattoOriginale_Bean.getAPP_COD_DTE());

        // Completo l'inserimento del nuovo contratto.

        // CONTRATTO

        // Descrizione
        NuovoContratto_Bean.setDES_CON(ContrattoOriginale_Bean.getDES_CON());
        // Riferimento contratto
        NuovoContratto_Bean.setRIF_CON(ContrattoOriginale_Bean.getRIF_CON());
        // Servizio responsabile
        NuovoContratto_Bean.setCOD_UNI_ORG(ContrattoOriginale_Bean.getCOD_UNI_ORG());
        // Data inizio lavori
        NuovoContratto_Bean.setDAT_INI_LAV(ContrattoOriginale_Bean.getDAT_INI_LAV());
        // Data fine lavori
        NuovoContratto_Bean.setDAT_FIN_LAV(ContrattoOriginale_Bean.getDAT_FIN_LAV());
        // Numero lavoratori in cantiere
        NuovoContratto_Bean.setNUM_LAV_PRE(ContrattoOriginale_Bean.getNUM_LAV_PRE());
        // Orario di lavoro
        NuovoContratto_Bean.setORA_LAV(ContrattoOriginale_Bean.getORA_LAV());
        // Lavoro notturno
        NuovoContratto_Bean.setLAV_NOT(ContrattoOriginale_Bean.getLAV_NOT());

        // DESCRIZIONI COMUNI

        // Centri di emergenza
        NuovoContratto_Bean.setCEN_EME_DES(ContrattoOriginale_Bean.getCEN_EME_DES());
        // Servizi sanitari
        NuovoContratto_Bean.setSER_SAN_DES_1(ContrattoOriginale_Bean.getSER_SAN_DES_1());
        NuovoContratto_Bean.setSER_SAN_DES_2(ContrattoOriginale_Bean.getSER_SAN_DES_2());
        NuovoContratto_Bean.setSER_SAN_DES_3(ContrattoOriginale_Bean.getSER_SAN_DES_3());
        // Fluidi
        NuovoContratto_Bean.setFLU_DES_1(ContrattoOriginale_Bean.getFLU_DES_1());
        NuovoContratto_Bean.setFLU_DES_2(ContrattoOriginale_Bean.getFLU_DES_2());
        // Materiali
        NuovoContratto_Bean.setPRE_MAT_DES_1(ContrattoOriginale_Bean.getPRE_MAT_DES_1());
        NuovoContratto_Bean.setPRE_MAT_DES_2(ContrattoOriginale_Bean.getPRE_MAT_DES_2());
        NuovoContratto_Bean.setPRE_MAT_ASS_APP_RAD(ContrattoOriginale_Bean.getPRE_MAT_ASS_APP_RAD());
        NuovoContratto_Bean.setPRE_MAT_ASS_TEL_CEL(ContrattoOriginale_Bean.getPRE_MAT_ASS_TEL_CEL());

        // COMMITTENTE

        // Nominativo
        NuovoContratto_Bean.setCOM_COD_DPD(ContrattoOriginale_Bean.getCOM_COD_DPD());
        // Telefono
        NuovoContratto_Bean.setCOM_RES_TEL(ContrattoOriginale_Bean.getCOM_RES_TEL());

        // APPALTATRICE

        // Telefono
        NuovoContratto_Bean.setAPP_TEL(ContrattoOriginale_Bean.getAPP_TEL());
        // Fax
        NuovoContratto_Bean.setAPP_FAX(ContrattoOriginale_Bean.getAPP_FAX());
        // Email
        NuovoContratto_Bean.setAPP_EMAIL(ContrattoOriginale_Bean.getAPP_EMAIL());
        // Responsabile
        // Nominativo
        NuovoContratto_Bean.setAPP_RES_NOM(ContrattoOriginale_Bean.getAPP_RES_NOM());
        // Qualifica
        NuovoContratto_Bean.setAPP_RES_QUA(ContrattoOriginale_Bean.getAPP_RES_QUA());
        // Telefono
        NuovoContratto_Bean.setAPP_RES_TEL(ContrattoOriginale_Bean.getAPP_RES_TEL());
        // Intervento assegnato
        // Descrizione
        NuovoContratto_Bean.setAPP_INT_ASS_DES(ContrattoOriginale_Bean.getAPP_INT_ASS_DES());
        // Orario di lavoro
        NuovoContratto_Bean.setAPP_INT_ASS_ORA_LAV(ContrattoOriginale_Bean.getAPP_INT_ASS_ORA_LAV());
        // Consegna
        NuovoContratto_Bean.setAPP_INT_ASS_COD_CON(ContrattoOriginale_Bean.getAPP_INT_ASS_COD_CON());
        // Consegna, altro.
        NuovoContratto_Bean.setAPP_INT_ASS_CON_DES(ContrattoOriginale_Bean.getAPP_INT_ASS_CON_DES());

        // DESCRIZIONI COMUNI

        // Prodotti/Sostanze
        NuovoContratto_Bean.setPRO_SOS_DES(ContrattoOriginale_Bean.getPRO_SOS_DES());

        // CONTRATTO - LUOGHI ESECUZIONE

        // Estraggo i luoghi di esecuzione del contratto da copiare.
        col = ContrattoOriginale_LuoghiEsecuzioneHome.getContServLuoghiEsecuzione_View(lCOD_SRV);
        it = col.iterator();
        ContServLuoghiEsecuzione_View luo_ese = null;
        // Copio i luoghi fisici nel nuovo contratto.
        while (it.hasNext()){
            luo_ese = (ContServLuoghiEsecuzione_View)it.next();
            ContrattoOriginale_LuoghiEsecuzioneHome.create
                    (NuovoContratto_Bean.getCOD_SRV(), luo_ese.COD_LUO_FSC, luo_ese.DES_SER);
        }

        // CONTRATTO - RISCHI INTERFERENZA

        // Estraggo i rischi di interferenza del contratto da copiare.
        col = ContrattoOriginale_RischiInterferenzaHome.
                                    getContServRischiInterferenza_View(lCOD_SRV);
        it = col.iterator();
        ContServRischiInterferenza_View ris_int = null;
        while (it.hasNext()){
            ris_int = (ContServRischiInterferenza_View)it.next();
            NuovoContratto_RischiInterferenza_Bean = 
                    ContrattoOriginale_RischiInterferenzaHome.create
                            (NuovoContratto_Bean.getCOD_SRV(), ris_int.RIS);
            // Fase di lavoro
            NuovoContratto_RischiInterferenza_Bean.setFAS_LAV(ris_int.FAS_LAV);
            // Tipo di interferenza
            NuovoContratto_RischiInterferenza_Bean.setTIP_INT(ris_int.TIP_INT);
            // Impresa interessata
            NuovoContratto_RischiInterferenza_Bean.setIMP_INT(ris_int.IMP_INT);
            // Misura di prevenzione
            NuovoContratto_RischiInterferenza_Bean.setMIS_PRE(ris_int.MIS_PRE);
        }

        // CONTRATTO - CENTRI EMERGENZA

        // Estraggo i centri di emergenza del contratto da copiare.
        col = ContrattoOriginale_CentriEmergenzaHome.findEx_CentriEmergenza
                                                    (lCOD_SRV, 0, null, null, 0);
        it = col.iterator();
        CentriEmergenza_View cen_eme = null;
        while (it.hasNext()){
            cen_eme = (CentriEmergenza_View)it.next();
            NuovoContratto_CentriEmergenza_Bean = 
                    ContrattoOriginale_CentriEmergenzaHome.create
                            (NuovoContratto_Bean.getCOD_SRV(), cen_eme.RIF);
            // Descrizione
            NuovoContratto_CentriEmergenza_Bean.setDES(cen_eme.DES);
        }

        // CONTRATTO - SERVIZI SANITARI

        // Estraggo i servizi sanitari del contratto da copiare.
        col = ContrattoOriginale_ServiziSanitariHome.findEx_ServiziSanitari
                                        (lCOD_SRV, 0, null, null, null, null, 0);
        it = col.iterator();
        ServiziSanitari_View ser_san = null;
        while (it.hasNext()){
            ser_san = (ServiziSanitari_View)it.next();
            NuovoContratto_ServiziSanitari_Bean = 
                    ContrattoOriginale_ServiziSanitariHome.create
                            (NuovoContratto_Bean.getCOD_SRV(), ser_san.DES_SRV_VIT);
            // Orario d'impiego
            NuovoContratto_ServiziSanitari_Bean.setORA_IMP(ser_san.ORA_IMP);
            // Data inizio impiego
            NuovoContratto_ServiziSanitari_Bean.setDAT_INI_IMP(ser_san.DAT_INI_IMP);
            // Data fine impiego
            NuovoContratto_ServiziSanitari_Bean.setDAT_FIN_IMP(ser_san.DAT_FIN_IMP);
        }

        // CONTRATTO - FLUIDI

        // Estraggo i fluidi del contratto da copiare.
        col = ContrattoOriginale_FluidiHome.findEx_Fluidi
                                        (lCOD_SRV, 0, null, null, null, null, 0);
        it = col.iterator();
        Fluidi_View flu = null;
        while (it.hasNext()){
            flu = (Fluidi_View)it.next();
            NuovoContratto_Fluidi_Bean = ContrattoOriginale_FluidiHome.create
                            (NuovoContratto_Bean.getCOD_SRV(), flu.TIP_FLU_DIS);
            // Luogo di collegamento
            NuovoContratto_Fluidi_Bean.setLUO_COL(flu.LUO_COL);
            // Data inizio consegna
            NuovoContratto_Fluidi_Bean.setDAT_INI_CON(flu.DAT_INI_CON);
            // Data fine consegna
            NuovoContratto_Fluidi_Bean.setDAT_FIN_CON(flu.DAT_FIN_CON);
        }

        // CONTRATTO - PRESTITO MATERIALE

        // Estraggo i materiali del contratto da copiare.
        col = ContrattoOriginale_PrestitoMaterialiHome.findEx_PrestitoMateriali
                                            (lCOD_SRV, 0, null, null, null, null, 0);
        it = col.iterator();
        PrestitoMateriali_View pre_mat = null;
        while (it.hasNext()){
            pre_mat = (PrestitoMateriali_View)it.next();
            NuovoContratto_PrestitoMateriali_Bean = 
                    ContrattoOriginale_PrestitoMaterialiHome.create
                            (NuovoContratto_Bean.getCOD_SRV(), pre_mat.TIP_MAT);
            // Luogo di messa a disposizione
            NuovoContratto_PrestitoMateriali_Bean.setLUO_MES_DIS(pre_mat.LUO_MES_DIS);
            // Data inizio prestito
            NuovoContratto_PrestitoMateriali_Bean.setDAT_INI_PRE(pre_mat.DAT_INI_PRE);
            // Data fine prestito
            NuovoContratto_PrestitoMateriali_Bean.setDAT_FIN_PRE(pre_mat.DAT_FIN_PRE);
       }

        // CONTRATTO - ISPEZIONI

        // Estraggo i materiali del contratto da copiare.
        col = ContrattoOriginale_IspezioniHome.findEx_Ispezioni(lCOD_SRV);
        it = col.iterator();
        Ispezioni_View isp = null;
        while (it.hasNext()){
            isp = (Ispezioni_View)it.next();
            NuovoContratto_Ispezioni_Bean = ContrattoOriginale_IspezioniHome.create
                    (NuovoContratto_Bean.getCOD_SRV(), 
                    isp.FILE_NAME, 
                    isp.CONTENT_TYPE, 
                    ContrattoOriginale_IspezioniHome.downloadFile(isp.COD_ISP));
        }

        // COMMITTENTE - REFERENTI IN LOCO

        // Estraggo i referenti in loco del contratto da copiare.
        col = ContrattoOriginale_ReferentiLocoHome.findEx_ReferentiLocoCmt
                (ContrattoOriginale_Bean.getCOD_AZL(), lCOD_SRV, 0, null);
        it = col.iterator();
        ComReferentiLoco_View ref_loc = null;
        while (it.hasNext()){
            ref_loc = (ComReferentiLoco_View)it.next();
            NuovoContratto_ReferentiLoco_Bean = ContrattoOriginale_ReferentiLocoHome.create
                    (ref_loc.COD_AZL, NuovoContratto_Bean.getCOD_SRV(), ref_loc.COD_DPD);
            // Telefono
            NuovoContratto_ReferentiLoco_Bean.setTEL(ref_loc.TEL);
        }

        // APPALTATRICE - REFERENTI IN LOCO

        // Estraggo i referenti in loco del contratto da copiare, relativi all'appaltatrice.
        col = ContrattoOriginale_AppReferentiLocoHome.findEx_ReferentiLocoApp
                (lCOD_SRV, 0, null, null, null, 0);
        it = col.iterator();
        AppReferentiLoco_View ref_loc_app = null;
        while (it.hasNext()){
            ref_loc_app = (AppReferentiLoco_View)it.next();
            NuovoContratto_AppReferentiLoco_Bean = ContrattoOriginale_AppReferentiLocoHome.create
                    (NuovoContratto_Bean.getCOD_SRV(), ref_loc_app.NOM);
            // Qualifica
            NuovoContratto_AppReferentiLoco_Bean.setQUA(ref_loc_app.QUA);
            // Telefono
            NuovoContratto_AppReferentiLoco_Bean.setTEL(ref_loc_app.TEL);
        }

        // APPALTATRICE - PERSONALE COINVOLTO

        // Estraggo il personale coinvolto del contratto da copiare, relativo all'appaltatrice.
        col = ContrattoOriginale_AppPersonaleCoinvoltoHome.findEx_PersonaleCoinvoltoApp
                                                    (lCOD_SRV, 0, null, null, 0);
        it = col.iterator();
        AppPersonaleCoinvolto_View per_con_app = null;
        while (it.hasNext()){
            per_con_app = (AppPersonaleCoinvolto_View)it.next();
            NuovoContratto_AppPersonaleCoinvolto_Bean = 
                    ContrattoOriginale_AppPersonaleCoinvoltoHome.create
                        (NuovoContratto_Bean.getCOD_SRV(), per_con_app.NOM);
            // Qualifica
            NuovoContratto_AppPersonaleCoinvolto_Bean.setQUA(per_con_app.QUA);
        }

        // APPALTATRICE - PRODOTTI/SOSTANZE

        // Estraggo i prodotti/sostanze del contratto da copiare, relativi all'appaltatrice.
        col = ContrattoOriginale_AppProdottiSostanzeHome.findEx_ProdottiSostanzeApp
                                                        (lCOD_SRV, 0, null, 0);
        it = col.iterator();
        ProdottiSostanzeApp_View pro_sos_app = null;
        while (it.hasNext()){
            pro_sos_app = (ProdottiSostanzeApp_View)it.next();
            NuovoContratto_AppProdottiSostanze_Bean = ContrattoOriginale_AppProdottiSostanzeHome.create
                    (NuovoContratto_Bean.getCOD_SRV(), pro_sos_app.DES);
        }

        // APPALTATRICE - ANALISI DEI RISCHI

        // Estraggo i rischi del contratto da copiare, relativi all'appaltatrice.
        col = ContrattoOriginale_AppAnalisiRischiHome.findEx_AnalisiRischiApp(lCOD_SRV);
        it = col.iterator();
        AnalisiRischiApp_View ana_ris_app = null;
        while (it.hasNext()){
            ana_ris_app = (AnalisiRischiApp_View)it.next();
            NuovoContratto_AppAnalisiRischi_Bean = ContrattoOriginale_AppAnalisiRischiHome.create
                    (NuovoContratto_Bean.getCOD_SRV(), ana_ris_app.RIS);
            // Fase di lavoro
            NuovoContratto_AppAnalisiRischi_Bean.setFAS_LAV(ana_ris_app.FAS_LAV);
            // Modalità operative
            NuovoContratto_AppAnalisiRischi_Bean.setMOD_OPE(ana_ris_app.MOD_OPE);
            // Materiali/Prodotti impiegati
            NuovoContratto_AppAnalisiRischi_Bean.setMAT_PRO_IMP(ana_ris_app.MAT_PRO_IMP);
            // Misure di prevenzione e protezione adottate
            NuovoContratto_AppAnalisiRischi_Bean.setMIS_PRE_PRO(ana_ris_app.MIS_PRE_PRO);        
        }

        // CONTRATTO - DETTAGLIO SUBAPPALTATRICI

        // Estraggo le subappaltatrici del contratto da copiare.
        col = ContrattoOriginale_DettaglioSubappalatriciHome.findEx_SubApp
                                    (ContrattoOriginale_Bean.getCOD_AZL(), lCOD_SRV, 0, null, 0);
        it = col.iterator();
        SubApp_View sub_app = null;
        while (it.hasNext()){
            sub_app = (SubApp_View)it.next();

            // Copio la subappaltatrice nel nuovo contratto
            NuovoContratto_SubApp_Bean = 
                    ContrattoOriginale_DettaglioSubappalatriciHome.create
                                (NuovoContratto_Bean.getCOD_SRV(), sub_app.COD_DTE);
            // Telefono
            NuovoContratto_SubApp_Bean.setTEL(sub_app.TEL);
            // Fax
            NuovoContratto_SubApp_Bean.setFAX(sub_app.FAX);
            // Email
            NuovoContratto_SubApp_Bean.setEMAIL(sub_app.EMAIL);
            // Responsabile        
            // Nominativo
            NuovoContratto_SubApp_Bean.setRES_LOC_NOM(sub_app.RES_LOC_NOM);
            // Qualifica
            NuovoContratto_SubApp_Bean.setRES_LOC_QUA(sub_app.RES_LOC_QUA);
            // Qualifica
            NuovoContratto_SubApp_Bean.setRES_LOC_TEL(sub_app.RES_LOC_TEL);
            // Intervento assegnato
            // Descrizione
            NuovoContratto_SubApp_Bean.setINT_ASS_DES(sub_app.INT_ASS_DES);
            // Data inizio lavori
            NuovoContratto_SubApp_Bean.setDAT_INI_LAV(sub_app.DAT_INI_LAV);
            // Data fine lavori
            NuovoContratto_SubApp_Bean.setDAT_FIN_LAV(sub_app.DAT_FIN_LAV);
            // Orario di lavoro
            NuovoContratto_SubApp_Bean.setORA_LAV(sub_app.ORA_LAV);
            // Lavoro notturno
            NuovoContratto_SubApp_Bean.setLAV_NOT(sub_app.LAV_NOT);
            // Consegna
            NuovoContratto_SubApp_Bean.setCOD_CON(sub_app.COD_CON);
            // Consegna, altro
            NuovoContratto_SubApp_Bean.setCON_DES(sub_app.CON_DES);

            // ...per ogni subappaltatrice copiata nel nuovo contratto gestisco

            // SUBAPPALTATRICI - PERSONALE COINVOLTO

            // Estraggo il personale coinvolto del contratto da copiare
            nested_col = ContrattoOriginale_SubAppPersonaleCoinvoltoHome.findEx_PersonaleCoinvoltoSubApp
                                        (sub_app.COD_SUB_APP, 0, null, null, 0);
            nested_it = nested_col.iterator();
            SubAppPersonaleCoinvolto_View sub_app_per_coi = null;

            while (nested_it.hasNext()){
                sub_app_per_coi = (SubAppPersonaleCoinvolto_View)nested_it.next();
                NuovoContratto_SubAppPersonaleCoinvolto_Bean = 
                        ContrattoOriginale_SubAppPersonaleCoinvoltoHome.create
                        (NuovoContratto_SubApp_Bean.getCOD_SUB_APP(), sub_app_per_coi.NOM);
                // Qualifica
                NuovoContratto_SubAppPersonaleCoinvolto_Bean.setQUA(sub_app_per_coi.QUA);
            }

            // SUBAPPALTATRICI - PRODOTTI SOSTANZE

            // Estraggo i prodotti/sostanze del contratto da copiare
            nested_col = ContrattoOriginale_SubAppProdottiSostanzeHome.findEx_ProdottiSostanzeSubApp
                                                (sub_app.COD_SUB_APP, 0, null, 0);
            nested_it = nested_col.iterator();
            ProdottiSostanzeSubApp_View sub_app_pro_sos = null;
            while (nested_it.hasNext()){
                sub_app_pro_sos = (ProdottiSostanzeSubApp_View)nested_it.next();
                NuovoContratto_SubAppProdottiSostanze_Bean = 
                        ContrattoOriginale_SubAppProdottiSostanzeHome.create
                        (NuovoContratto_SubApp_Bean.getCOD_SUB_APP(), sub_app_pro_sos.DES);
            }

            // SUBAPPALTATRICI - ANALISI DEI RISCHI

            // Estraggo i prodotti/sostanze del contratto da copiare
            nested_col = ContrattoOriginale_SubAppAnalisiRischiHome
                            .findEx_AnalisiRischiSubApp(sub_app.COD_SUB_APP);
            nested_it = nested_col.iterator();
            AnalisiRischiSubApp_View sub_app_ris = null;
            while (nested_it.hasNext()){
                sub_app_ris = (AnalisiRischiSubApp_View)nested_it.next();
                NuovoContratto_SubAppAnalisiRischi_Bean = 
                        ContrattoOriginale_SubAppAnalisiRischiHome.create
                        (NuovoContratto_SubApp_Bean.getCOD_SUB_APP(), sub_app_ris.RIS);
                // Fase di lavoro
                NuovoContratto_SubAppAnalisiRischi_Bean.setFAS_LAV(sub_app_ris.FAS_LAV);
                // Modalità operative
                NuovoContratto_SubAppAnalisiRischi_Bean.setMOD_OPE(sub_app_ris.MOD_OPE);
                // Materiali/Prodotti impiegati
                NuovoContratto_SubAppAnalisiRischi_Bean.setMAT_PRO_IMP(sub_app_ris.MAT_PRO_IMP);
                // Misure di prevenzione e protezione adottate
                NuovoContratto_SubAppAnalisiRischi_Bean.setMIS_PRE_PRO(sub_app_ris.MIS_PRE_PRO);
            }
        }

        // DESCRIZIONI COMUNI

        // Prodotti/Sostanze
        NuovoContratto_Bean.setPRO_SOS_SUB_APP_DES(ContrattoOriginale_Bean.getPRO_SOS_SUB_APP_DES());
        
        // Copia effettuata con successo.
        returnMessage = ApplicationConfigurator.LanguageManager.getString("Copia.da.msg3");
    } catch (Exception e) {
        returnMessage =
                ApplicationConfigurator.LanguageManager.getString("Error.msg.1")
                + "\\n"
                + (StringManager.isEmpty(e.getMessage())
                    ?
                    ApplicationConfigurator.LanguageManager.getString("Errore.non.determinabile").toUpperCase()
                    :
                    StringManager.prepareForJavaScript(e.getMessage()))
                + "\\n\\n"
                + ApplicationConfigurator.LanguageManager.getString("Copia.da.msg4");
        e.printStackTrace();
    }
            
%>
<script>
    alert("<%=returnMessage%>");
</script>
