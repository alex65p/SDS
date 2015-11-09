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

<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="java.text.*"%>
<%@ page import="java.sql.Date"%>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.FunzioniAziendali.*" %>
<%@ page import="com.apconsulting.luna.ejb.DittaEsterna.*" %>
<%@ page import="com.apconsulting.luna.ejb.ErogazioneCorsi.*" %>
<%@ page import="com.apconsulting.luna.ejb.Nazionalita.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Localization.jsp"%>

<%@ include file="ANA_DPD_Utils.jsp"%>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../_include/ComboBuilder.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<html>
    <head>
        <script type="text/javascript">
            function beforeSave(){
                return ControllaDataCessazione();
            }          
            document.write("<title>" + getCompleteMenuPath(SubMenuAzienda,4) + "</title>");
        </script>
        <!-- autocompose data field -->
        <script type="text/javascript" src="../_scripts/calendar/utility.js"></script>
        <!-- import the calendar script -->
        <script type="text/javascript" src="../_scripts/calendar/calendar.js"></script>
        <!-- import the language module -->
        <script type="text/javascript" src="../_scripts/calendar/lang.js"></script>
        <!-- import calendar utility function -->
        <script type="text/javascript" src="../_scripts/calendar/showCalendar.js"></script>
        <!-- import ANA_DPD.js -->
        <script type="text/javascript" src="ANA_DPD.js"></script>
        <!-- style sheet for calendar -->
        <link rel="stylesheet" type="text/css" media="all" href="../_styles/calendar/skins/aqua/theme.css" title="Aqua" />

        <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script type="text/javascript" src="../_scripts/tabs.js"></script>
        <script type="text/javascript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <script type="text/javascript" src="../_scripts/utility.js"></script>
        <script type="text/javascript" src="../_scripts/textarea.js"></script>
        <script type="text/javascript">
            <%
                if (ApplicationConfigurator.isModuleEnabled(MODULES.MORE_DPD_INFO)) {
                    out.println("var height_new = \"480px\"");
                    out.println("var height_mod = \"720px\"");
                } else {
                    out.println("var height_new = \"445px\"");
                    out.println("var height_mod = \"685px\"");
                }
            %>
                window.dialogWidth="910px";
                window.dialogHeight=height_mod;
        </script>
    </head>
    <body>
        <%
            long lCOD_DPD = 0;				//0
            long lCOD_AZL = Security.getAzienda();	//1
            long lCOD_DTE = 0;				//2 - Nullable
            long lCOD_FUZ_AZL = 0;			//3
            String strSTA_DPD = "0";			//4
            String strMTR_DPD = "";			//5
            String strCOG_DPD = "";			//6
            String strNOM_DPD = "";			//7
            String strCOD_FIS_DPD = "";		//8 - Nullable
            long lCOD_STA = 0;				//9 - Nullable - For Debug
            String strLUO_NAS_DPD = "";		//10 - Nullable
            String strDAT_NAS_DPD = "";		//11
            String strIDZ_DPD = "";			//12 - Nullable
            String strNUM_CIC_DPD = "";		//13 - Nullable
            String strCAP_DPD = "";			//14 - Nullable
            String strCIT_DPD = "";			//15 - Nullable
            String strPRV_DPD = "";			//16 - Nullable
            String strIDZ_PSA_ELT_DPD = "";	//17 - Nullable
            String strRAP_LAV_AZL = "";		//18
            String strDAT_ASS_DPD = "";            //19 - Nullable
            String strLIV_DPD = "";                //20 - Nullable
            String strDAT_CES_DPD = "";            //21 - Nullable
            String strNOT_DPD = "";
            String strNOM_AZL = "";			//22 - Computing from COD_AZL
            String strAttSubj = request.getParameter("ATTACH_SUBJECT");
            //--- mary for upload
            AnagDocumentoFileInfo info = null;
            AnagDocumentoFileInfo infoLink = null;
            IAnagrDocumento anagrDoc = null;
            IAnagrDocumentoHome homeanagrDoc = (IAnagrDocumentoHome) PseudoContext.lookup("AnagrDocumentoBean");

            IDipendente Dipendente = null;
            IDipendenteHome home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");

            IErogazioneCorsiHome home1 = (IErogazioneCorsiHome) PseudoContext.lookup("ErogazioneCorsiBean");
            IErogazioneCorsi ErogazioneCorsi = null;
            if (request.getParameter("ID") != null) {
                String strCOD_DPD = request.getParameter("ID");

                Long dpd_id = new Long(strCOD_DPD);
                Dipendente = home.findByPrimaryKey(dpd_id);

                lCOD_DPD = dpd_id.longValue();
                lCOD_AZL = Dipendente.getCOD_AZL();							//1
                lCOD_DTE = Dipendente.getCOD_DTE();							//2 - Nullable
                lCOD_FUZ_AZL = Dipendente.getCOD_FUZ_AZL();					//3
                strSTA_DPD = Dipendente.getSTA_DPD();						//4
                strMTR_DPD = Dipendente.getMTR_DPD();						//5
                strCOG_DPD = Dipendente.getCOG_DPD();						//6
                strNOM_DPD = Dipendente.getNOM_DPD();						//7
                strCOD_FIS_DPD = Dipendente.getCOD_FIS_DPD();				//8 - Nullable
                lCOD_STA = Dipendente.getCOD_STA();							//9 - Nullable
                strLUO_NAS_DPD = Dipendente.getLUO_NAS_DPD();				//10 - Nullable
                strDAT_NAS_DPD = Formatter.format(Dipendente.getDAT_NAS_DPD());	//11
                strIDZ_DPD = Dipendente.getIDZ_DPD();						//12 - Nullable
                strNUM_CIC_DPD = Dipendente.getNUM_CIC_DPD();				//13 - Nullable
                strCAP_DPD = Dipendente.getCAP_DPD();						//14 - Nullable
                strCIT_DPD = Dipendente.getCIT_DPD();						//15 - Nullable
                strPRV_DPD = Dipendente.getPRV_DPD();						//16 - Nullable
                strIDZ_PSA_ELT_DPD = Dipendente.getIDZ_PSA_ELT_DPD();		//17 - Nullable
                strRAP_LAV_AZL = Dipendente.getRAP_LAV_AZL();				//18
                strDAT_ASS_DPD = Formatter.format(Dipendente.getDAT_ASS_DPD()); //19 - Nullable
                strLIV_DPD = Dipendente.getLIV_DPD();         //20 - Nullable
                strDAT_CES_DPD = Formatter.format(Dipendente.getDAT_CES_DPD()); //21 - Nullable
                strNOT_DPD = Formatter.format(Dipendente.getNOT_DPD()); //21 - Nullable

                strNOM_AZL = Dipendente.getNOM_AZL();						//22 - Computing from COD_AZL

                //--- mary for upload
                info = homeanagrDoc.getFileInfoU("ANA_DPD_TAB", new Long(strCOD_DPD).longValue());
                infoLink = homeanagrDoc.getFileInfoULink("ANA_DPD_TAB", new Long(strCOD_DPD).longValue());
            }
            String strSubject = (String) request.getParameter("ATTACH_SUBJECT");
            System.out.println(strSubject);
            IAziendaHome aHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");
            IFunzioniAziendaliHome fHome = (IFunzioniAziendaliHome) PseudoContext.lookup("FunzioniAziendaliBean");
            INazionalitaHome nHome = (INazionalitaHome) PseudoContext.lookup("NazionalitaBean");
            IDittaEsternaHome h1 = (IDittaEsternaHome) PseudoContext.lookup("DittaEsternaBean");

            // Get Aziende/Ente
            Long azl_id = new Long(lCOD_AZL);
            IAzienda azienda = aHome.findByPrimaryKey(azl_id);
            strNOM_AZL = azienda.getRAG_SCL_AZL();						//22 - Computing from COD_AZL

            boolean dipCessato = (strDAT_CES_DPD != null
                    && !strDAT_CES_DPD.equals("")
                    && home.dipendenteCessato(new Date(new SimpleDateFormat("dd/MM/yyyy").parse(strDAT_CES_DPD).getTime())))
                    || (request.getParameter("azlPre") != null
                    && Boolean.valueOf(request.getParameter("azlPre")).booleanValue() == true);
            boolean windowReadOnly = ApplicationConfigurator.isModuleEnabled(MODULES.GEST_DPD_EXT);
            boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.ENABLE_RECORD);
        %>

        <!-- form for addind Dipendente -->
        <form action="ANA_DPD_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;" ENCTYPE="multipart/form-data">
            <input type="hidden" name="SBM_MODE" value="<%=(lCOD_DPD == 0) ? "new" : "edt"%>">
            <input type="hidden" name="COD_DPD" value="<%=lCOD_DPD%>">
            <input type="hidden" name="COD_AZL" value="<%=lCOD_AZL%>">
            <input type="hidden" name="ATTACH_SUBJECT" value="<%=strAttSubj%>">
            <table width="100%" border="0">
                <tr>
                    <td valign="top">
                        <table  width="100%" border="0">
                            <tr><td class="title">
                                    <script type="text/javascript">
                                        <%
                                            if (dipCessato || windowReadOnly) {
                                                out.print("document.write(getCompleteMenuPath(SubMenuAzienda,4) + ' - " + ApplicationConfigurator.LanguageManager.getString("Sola.consultazione") + "')");
                                            } else {
                                                out.print("document.write(getCompleteMenuPathFunction(SubMenuAzienda,4," + request.getParameter("ID") + "))");
                                            }
                                        %>
                                    </script>
                                </td></tr>
                            <tr>
                                <td>
                                    <table border="0" width="100%">
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%
                                            ToolBar.bCanDelete = (Dipendente != null);
                                            ToolBar.bShowPrint = true;
                                            if (Dipendente != null) {
                                                ToolBar.bCanPrint = true;
                                                ToolBar.strPrintUrl = "SchedaDipendente.jsp?";
                                                if (dipCessato || windowReadOnly) {
                                                    
                                                    
                                                    if (!ifMsr) {                                                    
                                                    ToolBar.bShowDelete = false;
                                                    
                                                    //Se il profilo è MSR, viene creato un apposito bottone sulla toolbar che permette di riabilitare un lavoratore cessato,
                                                    //e viene gestito attraverso la toolbar.java, toolbar.js e la ANA_DPD_Enable.jsp  
                                                    } else {        
                                                    ToolBar.bShowDelete = false;
                                                    ToolBar.bShowEnable = true;
                                                    ToolBar.bCanEnable = true;
                                                    }
                                                    
                                                    if (dipCessato) {
                                                        ToolBar.setMessage(ApplicationConfigurator.LanguageManager.getString("Dipendente.dimesso.mess.1"));
                                                        ToolBar.bShowSave = false;
                                                       
                                                    } else if (windowReadOnly) {
                                                        ToolBar.setMessage(ApplicationConfigurator.LanguageManager.getString("Anagrafica.in.sola.consultazione"));
                                                        ToolBar.bShowSave = true;
                                                      
                                                    }
                                                }
                                            } else {
                                                if (windowReadOnly) {
                                                    ToolBar.setMessage(ApplicationConfigurator.LanguageManager.getString("Anagrafica.in.sola.consultazione"));
                                                    ToolBar.bShowSave = false;
                                                    ToolBar.bShowDelete = false;
                                                    
                                                }
                                            }
                                        %>
                                        <%=ToolBar.build(3)%>
                                        
                                                                           
                                    </table>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.lavoratore")%></legend>

                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td align="right">
                                                    <b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b>
                                                </td>
                                                <td colspan="3" >
                                                    <input size="53%" type="text" name="NOM_AZL" readonly value="<%=strNOM_AZL%>">
                                                </td>
                                                 <%if ((strAttSubj==null)||(strAttSubj.equals(""))||(strAttSubj.equals("DPD_INT"))){%>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Fornitore.personale/servizi")%>&nbsp;
                                                </td>
                                                <%}else{%>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Fornitore.personale/servizi")%>&nbsp;</b>
                                                </td>
                                                <%}%>

                                                
                                                <%if ((strAttSubj==null)||(strAttSubj.equals(""))||(strAttSubj.equals("DPD_EST"))||(strAttSubj.equals("TES_VRF"))){%>
                                                <td>
                                                    <%if (Dipendente != null) {%>
                                                        <select name="COD_DTE" id="COD_DTE" style="width:210">
                                                        <option></option>
                                                        <%
                                                            String str = "";
                                                            String strSEL = "";
                                                            java.util.Collection col = home1.getErogazioneCorsi_DTEGet_View();
                                                            java.util.Iterator it = col.iterator();
                                                            while (it.hasNext()) {
                                                                ErogazioneCorsi_DTEGet_View dt = (ErogazioneCorsi_DTEGet_View) it.next();
                                                                long var1 = dt.COD_DTE;
                                                                if (lCOD_DTE == var1) {
                                                                    strSEL = "selected";
                                                                } else {
                                                                    strSEL = "";
                                                                }
                                                                str = str + "<option " + strSEL + " value=\"" + var1 + "\">" + dt.RAG_SCL_DTE + "</option>";
                                                            }
                                                            out.print(str);
                                                        %>
                                                    </select>
                                                    <%}  if (Dipendente == null ){%>
                                                    <select name="COD_DTE" id="COD_DTE" style="width:210">
                                                        <option></option>
                                                        <%
                                                            String str = "";
                                                            String strSEL = "";
                                                            java.util.Collection col = home1.getErogazioneCorsi_DTEGet_View();
                                                            java.util.Iterator it = col.iterator();
                                                            while (it.hasNext()) {
                                                                ErogazioneCorsi_DTEGet_View dt = (ErogazioneCorsi_DTEGet_View) it.next();
                                                                long var1 = dt.COD_DTE;
                                                                if (lCOD_DTE == var1) {
                                                                    strSEL = "selected";
                                                                } else {
                                                                    strSEL = "";
                                                                }
                                                                str = str + "<option " + strSEL + " value=\"" + var1 + "\">" + dt.RAG_SCL_DTE + "</option>";
                                                            }
                                                            out.print(str);
                                                        %>
                                                    </select>
                                                    <%}%>
                                                </td>
                                                <%}else if(strAttSubj.equals("DPD_INT")){%>
                                                <td>
                                                    <%if (Dipendente != null && (dipCessato || windowReadOnly)) {%>
                                                    <input type="hidden" name="COD_DTE" value="<%=lCOD_DTE%>">
                                                    <input type="text" name="DTE_DES" SIZE="30" value="<%=lCOD_DTE > 0 ? h1.findByPrimaryKey(lCOD_DTE).getRAG_SCL_DTE() : ""%>">
                                                    <%} else {%>
                                                    <select name="COD_DTE" disabled id="COD_DTE" style="width:210">
                                                        <option></option>
                                                        <%
                                                            String str = "";
                                                            String strSEL = "";
                                                            java.util.Collection col = home1.getErogazioneCorsi_DTEGet_View();
                                                            java.util.Iterator it = col.iterator();
                                                            while (it.hasNext()) {
                                                                ErogazioneCorsi_DTEGet_View dt = (ErogazioneCorsi_DTEGet_View) it.next();
                                                                long var1 = dt.COD_DTE;
                                                                if (lCOD_DTE == var1) {
                                                                    strSEL = "selected";
                                                                } else {
                                                                    strSEL = "";
                                                                }
                                                                str = str + "<option " + strSEL + " value=\"" + var1 + "\">" + dt.RAG_SCL_DTE + "</option>";
                                                            }
                                                            out.print(str);
                                                        %>
                                                    </select>
                                                    <%}%>
                                                </td>
                                                <%}%>
                                            </tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Funz.Aziendale")%>&nbsp;</b></td>
                                                <td colspan="3" >
                                                    <%if (Dipendente != null && (dipCessato || windowReadOnly)) {%>
                                                    <input type="hidden" name="COD_FUZ_AZL" value="<%=lCOD_FUZ_AZL%>">
                                                    <input type="text" name="FUZ_AZL_DES" SIZE="53" value="<%=lCOD_FUZ_AZL > 0 ? fHome.findByPrimaryKey(lCOD_FUZ_AZL).getNOM_FUZ_AZL() : ""%>">
                                                    <%} else {%>
                                                    <select name="COD_FUZ_AZL" style="width:290px;">
                                                        <option></option>
                                                        <%=BuildFunzAziendale(fHome, lCOD_FUZ_AZL)%>
                                                    </select>
                                                    <%}%>
                                                </td>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Stato")%></b>&nbsp;</td>
                                                <td>
                                                    <%if (Dipendente != null && (dipCessato || windowReadOnly)) {%>
                                                    <input type="hidden" name="STA_DPD" value="<%=strSTA_DPD%>">
                                                    <input type="text" name="STA_DPD_DES" SIZE="20" value="<%=strSTA_DPD.equals("1") ? ApplicationConfigurator.LanguageManager.getString("ATTIVO") : ApplicationConfigurator.LanguageManager.getString("DISATTIVO")%>">
                                                    <%} else {%>
                                                    <select name="STA_DPD" style="width:110px">
                                                        <option value="0" <%=(strSTA_DPD.equals("0")) ? "selected" : ""%>><%=ApplicationConfigurator.LanguageManager.getString("DISATTIVO")%></option>
                                                        <option value="1" <%=(strSTA_DPD.equals("1")) ? "selected" : ""%>><%=ApplicationConfigurator.LanguageManager.getString("ATTIVO")%></option>
                                                    </select>
                                                    <%}%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Matricola")%>&nbsp;</b></td>
                                                <td><input size="10%" type="text" maxlength="10" name="MTR_DPD" value="<%=strMTR_DPD%>"></td>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Cognome")%>&nbsp;</b></td>
                                                <td><input size="50%" type="text" maxlength="50" name="COG_DPD" value="<%=strCOG_DPD%>"></td>
                                                <td align="right"> <div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b> </div></td>
                                                <td><input size="36" type="text" name="NOM_DPD" maxlength="30" value="<%=strNOM_DPD%>">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  align="right"><%=ApplicationConfigurator.LanguageManager.getString("Cod.fiscale")%>&nbsp;</td>
                                                <td colspan="3" ><input size="53%" type="text" name="COD_FIS_DPD" maxlength="16" value="<%=strCOD_FIS_DPD%>">&nbsp;
                                                    &nbsp;&nbsp;
                                                </td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Nazione")%>&nbsp;</td>
                                                <td>
                                                    <%if (Dipendente != null && (dipCessato || windowReadOnly)) {%>
                                                    <input type="hidden" name="COD_STA" value="<%=lCOD_STA%>">
                                                    <input type="text" name="NAZ_DES" SIZE="30" value="<%=lCOD_STA > 0 ? nHome.findByPrimaryKey(lCOD_STA).getNOM_STA() : ""%>">
                                                    <%} else {%>
                                                    <select name="COD_STA" style="width:210px;">
                                                        <%long COD_LNG = Localization.getCurrentLanguageCode();%>
                                                        <option value=0></option>
                                                        <%=BuildNazionalitaComboBox(nHome, lCOD_STA, COD_LNG)%>
                                                    </select>
                                                    <%}%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  align="right"><%=ApplicationConfigurator.LanguageManager.getString("Luogo.di.nascita")%>&nbsp;</td>
                                                <td colspan="3" ><input size="53%" type="text" maxlength="30" name="LUO_NAS_DPD" value="<%=strLUO_NAS_DPD%>">&nbsp;</td>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Data.di.nascita")%>&nbsp;</b></td>
                                                <td><s2s:Date id="DAT_NAS_DPD" name="DAT_NAS_DPD" value="<%=strDAT_NAS_DPD%>"/></td>
                                            </tr>
                                            <tr>
                                                <td  align="right"><%=ApplicationConfigurator.LanguageManager.getString("Indirizzo")%>&nbsp;</td>
                                                <td colspan="3" ><input size="53%" type="text" maxlength="50" name="IDZ_DPD" value="<%=strIDZ_DPD%>">
                                                </td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Numero.civico")%>&nbsp;</td>
                                                <td><input size="10%" type="text" name="NUM_CIC_DPD" maxlength="30" value="<%=strNUM_CIC_DPD%>"></td>
                                            </tr>
                                            <tr>
                                                <td  align="right"><%=ApplicationConfigurator.LanguageManager.getString("C.a.p.")%>&nbsp;</td>
                                                <td><input size="10%" type="text" name="CAP_DPD" maxlength="15" value="<%=strCAP_DPD%>"></td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Città")%>&nbsp;</td>
                                                <td><input size="50%" type="text" name="CIT_DPD" maxlength="30" value="<%=strCIT_DPD%>"></td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Provincia")%>&nbsp;</td>
                                                <td><input size="2%" maxlength="2" type="text" name="PRV_DPD" value="<%=strPRV_DPD%>"></td>
                                            </tr>
                                            <tr>
                                                <td  align="right"><%=ApplicationConfigurator.LanguageManager.getString("Posta.elettronica")%>&nbsp;</td>
                                                <td colspan="3"><input size="53%" type="text" name="IDZ_PSA_ELT_DPD" maxlength="50" value="<%=strIDZ_PSA_ELT_DPD%>"></td>
                                                <td align="right" ><%=ApplicationConfigurator.LanguageManager.getString("Rappresentante.(RLS)")%>&nbsp;</td>
                                                <td>
                                                    <%if (Dipendente != null && (dipCessato || windowReadOnly)) {%>
                                                    <input type="hidden" name="RAP_LAV_AZL" value="<%=strRAP_LAV_AZL%>">
                                                    <%=strRAP_LAV_AZL.equals("S") ? "SI" : "NO"%>
                                                    <%} else {%>
                                                    <input type="checkbox" name="RAP_LAV_AZL" class="checkbox" <%=strRAP_LAV_AZL.equals("S") ? "checked" : ""%>>
                                                    <%}%>
                                                </td>
                                            </tr>
                                            <%
                                                if (ApplicationConfigurator.isModuleEnabled(MODULES.MORE_DPD_INFO)) {
                                                    out.println("<tr>");
                                                } else {
                                                    out.println("<tr style=\"display:none\">");
                                                }
                                            %>
                                            <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.assunzione")%>&nbsp;</td>
                                            <td><s2s:Date id="DAT_ASS_DPD"  name="DAT_ASS_DPD" value="<%=strDAT_ASS_DPD%>"/></td>
                                            <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Livello")%>&nbsp;</td>
                                            <td><input size="20" type="text" maxlength="10" name="LIV_DPD" value="<%=strLIV_DPD%>"></td>
                                            <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.cessazione")%>&nbsp;</td>
                                            <td><s2s:Date id="DAT_CES_DPD" name="DAT_CES_DPD" value="<%=strDAT_CES_DPD%>"/></td>
                                            </tr>
                                            <tr>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Note")%>&nbsp;</td>
                                                <td colspan="3"><s2s:textarea cols="70" rows="2" maxlength="4000" name="NOT_DPD"><%=strNOT_DPD%></s2s:textarea></td>
                                                <td colspan="2">&nbsp;</td>
                                            </tr>
                                            <!-- 	upload	 -->
                                            <tr>
                                                <td width="100%" colspan="6">
                                                    <table width="100%" border="0">
                                                        <tr>
                                                            <td width="50%">
                                                                <fieldset >
                                                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("File")%></legend>
                                                                    <div style="height:50px;overflow:hidden;">
                                                                        <table width=100% border="0">
                                                                            <%if (info != null) {
                                                                                    NumberFormat nf = NumberFormat.getInstance();
                                                                                    nf.setMinimumFractionDigits(2);
                                                                                    nf.setMaximumFractionDigits(3);
                                                                            %>
                                                                            <tr>
                                                                                <td>
                                                                                    <input type="checkbox" id="delete_file_id" name="ATTACHMENT_ACTION" value="delete" class=checkbox><%=ApplicationConfigurator.LanguageManager.getString("Delete")%>
                                                                                </td>
                                                                                <td align="left">
                                                                                    <a href="../_include/SHOW_File.jsp?ID=<%=lCOD_DPD%>&NOM_TAB=ANA_DPD_TAB&TYPE=FILE"><%=info.strName%></a>
                                                                                </td>

                                                                                <td>
                                                                                    <%=ApplicationConfigurator.LanguageManager.getString("Dimensione.(KB)")%>:&nbsp;&nbsp;<%=Formatter.format(nf.format((float) info.lSize / 1024))%>
                                                                                </td>
                                                                                <td>
                                                                                    <%=ApplicationConfigurator.LanguageManager.getString("Ultima.modifica")%>:&nbsp;&nbsp;<%=Formatter.format(info.dtModified)%>
                                                                                </td>
                                                                            </tr>
                                                                            <%} else {%>
                                                                            <tr>
                                                                                <td width=100% colspan="3">
                                                                                    <input id="add_file_id" name="ATTACHMENT_FILE" type="file" style="width:100%">
                                                                                </td>
                                                                            </tr>
                                                                            <%}%>
                                                                        </table>
                                                                    </div>
                                                                </fieldset>
                                                            </td>
                                                            <%
                                                                if (ApplicationConfigurator.isModuleEnabled(MODULES.DOC_LINK)) {
                                                                    out.println("<td width=\"50%\">");
                                                                } else {
                                                                    out.println("<td width=\"50%\" style=\"display:none\">");
                                                                }
                                                            %>
                                                            <!-- Inizio modifica gestione link esterno documenti -->
                                                        <fieldset>
                                                            <legend><%=ApplicationConfigurator.LanguageManager.getString("File.link")%></legend>
                                                            <div style="height:50px;overflow:hidden;">
                                                                <table width=100% border="0">
                                                                    <%if (infoLink != null) {
                                                                            NumberFormat nf = NumberFormat.getInstance();
                                                                            nf.setMinimumFractionDigits(2);
                                                                            nf.setMaximumFractionDigits(3);
                                                                    %>
                                                                    <tr>
                                                                        <td>
                                                                            <input type="checkbox" id="delete_file_link_id" name="ATTACHMENT_ACTION_LINK" value="delete" class=checkbox><%=ApplicationConfigurator.LanguageManager.getString("Delete")%>
                                                                        </td>
                                                                        <td align="left">
                                                                            <!--a href="../_include/SHOW_File.jsp?ID=<%=lCOD_DPD%>&NOM_TAB=ANA_DPD_TAB&TYPE=FILE_LINK"><%=infoLink.strName%></a-->
                                                                            <a href="<%=infoLink.strLinkDocument%>" target="_blank"><%=infoLink.strName%></a>
                                                                        </td>
                                                                        <td>
                                                                            <%=ApplicationConfigurator.LanguageManager.getString("Dimensione.(KB)")%>:&nbsp;&nbsp;<%=Formatter.format(nf.format((float) infoLink.lSize / 1024))%>
                                                                        </td>
                                                                        <td>
                                                                            <%=ApplicationConfigurator.LanguageManager.getString("Ultima.modifica")%>:&nbsp;&nbsp;<%=Formatter.format(infoLink.dtModified)%>
                                                                        </td>
                                                                    </tr>
                                                                    <%} else {%>
                                                                    <tr>
                                                                        <td width=100% colspan="3">
                                                                            <input id="add_file_link_id" name="ATTACHMENT_FILE_LINK" type="file" style="width:100%">
                                                                        </td>
                                                                    </tr>
                                                                    <%}%>
                                                                </table>
                                                            </div>
                                                        </fieldset>
                                                        <!-- Fine modifica gestione link esterno documenti-->
                                                </td>
                                            </tr>
                                        </table>
                                </td>
                                <!--/tr-->
                                <!-- 	upload	 -->
                        </table>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="100%"><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
    </tr>
</table>
</form>
<!-- /form for addind Dipendente -->
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>

<%
    if (Dipendente != null) {
%>

<script type="text/javascript" src="../_scripts/index.js"></script>
<script type="text/javascript">
    <!--
    //--------BUTTONS description-----------------------
    btnParams = new Array();
    btnParams[0] = {"id":"btnNew",
        "onclick":addRow,
        "action":"AddNew"
    };
    btnParams[1] = {"id":"btnEdit",
        "onclick":editRow,
        "action":"Edit"
    };
    btnParams[2] = {"id":"btnCancel",
        "onclick":delRow,
        "action":"Delete"
    };
    /*     btnParams[3] = {"id":"btnHelp",
                                        "onmousedown":btnDown, 	
                                        "onmouseup":btnOver,
                                        "onmouseover":btnOver,
                                        "onmouseout":btnOut,
                                        "onclick":windowHelp,
                                        "src":"../_images/HELP.GIF",
                                        "action":"Help"
                                        }; */
   
    //--------creating tabs--------------------------
    var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
    var btnBar = new ButtonPanel("batPanel1", btnParams);
    tabbar.addButtonBar(btnBar);

    tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Numeri.telefonici")%>", tabbar));
    tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Ditte.precedenti")%>", tabbar));
    tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Lingue.straniere")%>", tabbar));
    tabbar.addTab(new Tab("tab4", "<%=ApplicationConfigurator.LanguageManager.getString("Titoli.di.studio")%>", tabbar));
    tabbar.addTab(new Tab("tab5", "<%=ApplicationConfigurator.LanguageManager.getString("Percorsi.formativi")%>", tabbar));
    tabbar.addTab(new Tab("tab6", "<%=ApplicationConfigurator.LanguageManager.getString("Corsi")%>", tabbar));
    tabbar.addTab(new Tab("tab7", "<%=ApplicationConfigurator.LanguageManager.getString("Consegne.D.P.I.breve")%>", tabbar));
    tabbar.addTab(new Tab("tab8", "<%=ApplicationConfigurator.LanguageManager.getString("Attivita.lavorative")%>", tabbar));

    tabbar.idParentRecord = <%=lCOD_DPD%>;
    tabbar.refreshTabUrl="ANA_DPD_Tabs.jsp?dipCessato=<%=dipCessato%>&strCOD_FIS_DPD=<%=strCOD_FIS_DPD%>";
    
    tabbar.activeColumnsSorting(<%=ApplicationConfigurator.isModuleEnabled(MODULES.TAB_COL_ORD)%>);
    tabbar.RefreshAllTabs();

    //----add action parameters to tabs
    tabbar.tabs[0].tabObj.actionParams ={
        "Feachures":NUM_TEL_FOR_Feachures,
        "AddNew":	{"url":"../Form_NUM_TEL_DPD/NUM_TEL_Form.jsp",
            "buttonIndex":0,
            "disabled": <%=dipCessato%>
        },
        "Delete":	{"url":"../Form_NUM_TEL_DPD/NUM_TEL_Delete.jsp",
            "buttonIndex":2,
            "target_element":document.all["ifrmWork"],
            "disabled": <%=dipCessato%>
        },
        "Edit":	{"url":"../Form_NUM_TEL_DPD/NUM_TEL_Form.jsp",
            "buttonIndex":1,
            "disabled": <%=dipCessato%>
        },
        "Help":	{"url":"../Form_NUM_TEL/NUM_TEL_Help.jsp",
            "buttonIndex":3
        }
    };
    tabbar.tabs[1].tabObj.actionParams ={
        "Feachures":DIT_PRC_DPD_Feachures,
        "AddNew":	{"url":"../Form_DIT_PRC_DPD/DIT_PRC_DPD_Form.jsp",
            "buttonIndex":0,
            "disabled": <%=dipCessato%>
        },
        "Delete":	{"url":"../Form_DIT_PRC_DPD/DIT_PRC_DPD_Delete.jsp?LOCAL_MODE=DPD",
            "buttonIndex":2,
            "target_element":document.all["ifrmWork"],
            "disabled": <%=dipCessato%>
        },
        "Edit":	{"url":"../Form_DIT_PRC_DPD/DIT_PRC_DPD_Form.jsp",
            "buttonIndex":1
        },
        "Help":	{"url":"../Form_DIT_PRC_DPD/DIT_PRC_DPD_Help.jsp",
            "buttonIndex":3
        }
    };
    tabbar.tabs[2].tabObj.actionParams ={
        "Feachures":LNG_STR_DPD_Feachures,
        "AddNew":	{"url":"../Form_LNG_STR_DPD/LNG_STR_DPD_Form.jsp",
            "buttonIndex":0,
            "disabled": <%=dipCessato%>
        },
        "Delete":	{"url":"../Form_LNG_STR_DPD/LNG_STR_DPD_Delete.jsp",
            "buttonIndex":2,
            "target_element":document.all["ifrmWork"],
            "disabled": <%=dipCessato%>
        },
        "Edit":	{"url":"../Form_LNG_STR_DPD/LNG_STR_DPD_Form.jsp",
            "buttonIndex":1,
            "disabled": <%=dipCessato%>
        },
        "Help":	{"url":"../Form_LNG_STR_DPD/LNG_STR_DPD_Help.jsp",
            "buttonIndex":3
        }
    };
    tabbar.tabs[3].tabObj.actionParams ={
        "Feachures":TIT_STU_SPC_Feachures,
        "AddNew":	{"url":"../Form_TIT_STU_SPC/TIT_STU_SPC_Form.jsp",
            "buttonIndex":0,
            "disabled": <%=dipCessato%>
        },
        "Delete":	{"url":"../Form_TIT_STU_SPC/TIT_STU_SPC_Delete.jsp",
            "buttonIndex":2,
            "target_element":document.all["ifrmWork"],
            "disabled": <%=dipCessato%>
        },
        "Edit":	{"url":"../Form_TIT_STU_SPC/TIT_STU_SPC_Form.jsp",
            "buttonIndex":1,
            "disabled": <%=dipCessato%>
        },
        "Help":	{"url":"../Form_TIT_STU_SPC/TIT_STU_SPC_Help.jsp",
            "buttonIndex":3
        }
    };
    tabbar.tabs[4].tabObj.actionParams ={
        "Feachures":ANA_PCS_FRM_Feachures,
        "AddNew":	{"url":"../Form_ANA_PCS_FRM/ANA_PCS_FRM_Form.jsp?ATTACH_URL=Form_ANA_DPD/ANA_DPD_Attach.jsp&ATTACH_SUBJECT=PCS_FRM",
            "buttonIndex":0,
            "disabled": <%=dipCessato%>
        },
        "Delete":	{"url":"../Form_ANA_DPD/ANA_DPD_Delete.jsp?LOCAL_MODE=PCS_FRM",
            "buttonIndex":2,
            "target_element":document.all["ifrmWork"],
            "disabled": <%=dipCessato%>
        },
        "Edit":	{"url":"../Form_ANA_PCS_FRM/ANA_PCS_FRM_Form.jsp?ATTACH_URL=Form_ANA_DPD/ANA_DPD_Attach.jsp&ATTACH_SUBJECT=PCS_FRM",
            "buttonIndex":1,
            "disabled": <%=dipCessato%>
        },
        "Help":	{"url":"../Form_ANA_PCS_FRM/ANA_PCS_FRM_Help.jsp",
            "buttonIndex":3
        }
    };
    tabbar.tabs[5].tabObj.actionParams ={
        "Feachures":COR_DPD_Feachures,
        "AddNew":	{"url":"../Form_COR_DPD/COR_DPD_Form.jsp",                                                                            "buttonIndex":0,
            "disabled": <%=dipCessato%>
        },
        "Delete":	{"url":"../Form_ANA_DPD/ANA_DPD_Delete.jsp?LOCAL_MODE=COR_DPD",
            "buttonIndex":2,
            "target_element":document.all["ifrmWork"],
            "disabled": <%=dipCessato%>
        },
        "Edit":	{"url":"../Form_COR_DPD/COR_DPD_Form.jsp",
            "buttonIndex":1,
            "disabled": <%=dipCessato%>
        },
        "Help":	{"url":"../Form_COR_DPD/COR_DPD_Help.jsp",
            "buttonIndex":3
        }
    };
    tabbar.tabs[6].tabObj.actionParams ={
        "Feachures":DPI_DPD_Feachures,
        "AddNew":	{"url":"../Form_DPI_DPD/DPI_DPD_Form.jsp",
            "buttonIndex":0,
            "disabled": <%=dipCessato%>
        },
        "Delete":	{"url":"../Form_DPI_DPD/DPI_DPD_Delete.jsp?LOCAL_MODE=A",
            "buttonIndex":2,
            "target_element":document.all["ifrmWork"],
            "disabled": <%=dipCessato%>
        },
        "Edit":	{"url":"../Form_DPI_DPD/DPI_DPD_Form.jsp",
            "buttonIndex":1,
            "disabled": <%=dipCessato%>
        },
        "Help":	{"url":"../Form_DPI_DPD/DPI_DPD_Help.jsp",
            "buttonIndex":3
        }
    };
    tabbar.tabs[7].tabObj.actionParams ={
        "Feachures":MAN_DPD_Feachures,
        "AddNew":	{"url":"../Form_MAN_DPD/MAN_DPD_Form.jsp?ATTACH_URL=Form_ANA_DPD/ANA_DPD_Attach.jsp&ATTACH_SUBJECT=MAN_DPD",
            "buttonIndex":0,
            "disabled": <%=dipCessato%>
        },
        "Delete":	{"url":"../Form_MAN_DPD/MAN_DPD_Delete.jsp",
            "buttonIndex":2,
            "target_element":document.all["ifrmWork"],
            "disabled": <%=dipCessato%>

        },
        "Edit":	{"url":"../Form_MAN_DPD/MAN_DPD_Form.jsp?ATTACH_URL=Form_ANA_DPD/ANA_DPD_Attach.jsp&ATTACH_SUBJECT=MAN_DPD",
            "buttonIndex":1,
            "disabled": <%=dipCessato%>
        },
        "Help":	{"url":"../Form_MAN_DPD/MAN_DPD_Help.jsp",
            "buttonIndex":3
        }
    };

    //-----activate first tab--------------------------
    tabbar.tabs[0].center.click();
    // -->
</script>
<%} else {%>
<script type="text/javascript">
    window.dialogHeight=height_new;
</script>
<%}%>
<%
    if (Dipendente != null) {
        if (dipCessato) {
            out.println("<script>ReadOnlyAllFormsFields(window, null);</script>");
        } else if (windowReadOnly) {
            out.println("<script>ReadOnlyAllFormsFields(window, new Array('add_file_id','add_file_link_id','delete_file_id','delete_file_link_id'));</script>");
        }
    }
%>
</body>
</html>
