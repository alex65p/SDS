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
    response.setHeader("Pragma", "no-cache");         //HTTP 1.0
    response.setDateHeader("Expires", 0);             //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.OpzioniUtilizzatore.*" %>
<%@ page import="com.apconsulting.luna.ejb.Utente.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%
        IUtenteHome utenteHome = (IUtenteHome)PseudoContext.lookup("UtenteBean");
        IOpzioniUtilizzatoreHome home = (IOpzioniUtilizzatoreHome) PseudoContext.lookup("OpzioniUtilizzatoreBean");
        
        // Determino il codice dell'utente connesso.
        long lCOD_UTN = 
                ((view_sc_users)utenteHome.getUserS2S(Security.getUserPrincipal().getName()).iterator().next()).CODICE;
        
        boolean BIModule = ApplicationConfigurator.isModuleEnabled(MODULES.REPORT_BO);
%>
<html>
    <head>
        <script type="text/javascript">
            document.write("<title>" + getCompleteMenuPath(SubMenuGestione, 2) + "</title>");
        </script>
        <script type="text/javascript" src="../_scripts/ajax.js"></script>
        <script type="text/javascript" src="SDS_OPT.js"></script>
        <link rel="stylesheet" href="../_styles/style.css">
    </head>
    <body>
        <form id="frmMain" action="SDS_OPT_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <table cellpadding="2" cellspacing="2" width="100%" border="0">
                <tr>
                    <td align="center" class="title">
                        <script type="">
                            document.write(getCompleteMenuPath(SubMenuGestione, 2));
                        </script>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table border="0" cellpadding="1" cellspacing="0" width="100%" style="border-style:solid;border-width:1px;">
                            <tr>
                                <td>
                                    <!-- Opzioni utente -->
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td id="td-panelBO" style="text-align:center; background-color: #C1DAD7;">
                                                <a href="#" onclick="selectPanel('panelBO');" onmouseover="underlinePanel('panelBO');">
                                                    <img src="../_images/BO-properties.png" alt="<%=ApplicationConfigurator.LanguageManager.getString("ReportBI")%>" style="border-style: none;">
                                                </a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="1" style="white-space:nowrap; background-color: #CAE8EA; text-align: center; font-weight: normal; color: darknavy;"><%=ApplicationConfigurator.LanguageManager.getString("Opzioni.utente")%></td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <!-- Opzioni di sistema -->
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="display: none;">
                                        <tr>
                                            <td id="td-panelGenerale" style="display: block; text-align:center; background-color: #00a8ec;">
                                                <a href="#" onclick="selectPanel('panelGenerale');" onmouseover="underlinePanel('panelGenerale');">
                                                    <img src="../_images/Application-properties.png" alt="<%=ApplicationConfigurator.LanguageManager.getString("Generale")%>" style="border-style: none;">
                                                </a>
                                            </td>
                                            <td id="td-panelEmail" style="display: block; text-align:center; background-color: #00a8ec;">
                                                <a href="#" onclick="selectPanel('panelEmail');" onmouseover="underlinePanel('panelEmail');">
                                                    <img src="../_images/mail-properties.png" alt="<%=ApplicationConfigurator.LanguageManager.getString("Email")%>" style="border-style: none;">
                                                </a>
                                            </td>
                                            <td id="td-panelLDAP" style="display: block; text-align:center; background-color: #00a8ec;">
                                                <a href="#" onclick="selectPanel('panelLDAP');" onmouseover="underlinePanel('panelLDAP');">
                                                    <img src="../_images/ldap-properties.png" alt="<%=ApplicationConfigurator.LanguageManager.getString("LDAP")%>" style="border-style: none;">
                                                </a>
                                            </td>
                                            <td id="td-panelLog4j" style="display: block; text-align:center; background-color: #00a8ec;">
                                                <a href="#" onclick="selectPanel('panelLog4j');" onmouseover="underlinePanel('panelLog4j');">
                                                    <img src="../_images/log4j-properties.png" alt="<%=ApplicationConfigurator.LanguageManager.getString("Log4j")%>" style="border-style: none;">
                                                </a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" style="white-space:nowrap; background-color: #CAE8EA; text-align: center; font-weight: bold; color: darknavy;"><%=ApplicationConfigurator.LanguageManager.getString("Opzioni.sistema")%></td>
                                        </tr>
                                    </table>
                                </td>
                                <td>&nbsp;</td>
                                <td>
                                    <!-- Tabella della toolbar di navigazione -->
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%
                                            ToolBar.bShowNew = false;
                                            ToolBar.bShowSearch = false;
                                            ToolBar.bShowDelete = false;
                                            ToolBar.bShowHelp = true;
                                            
                                            ToolBar.bShowSave = BIModule;
                                        %>
                                        <%=ToolBar.build(3)%>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <!-- panelBO -->
                        <fieldset id="panelBO" style="height:200px;">
                            <legend><b><%=ApplicationConfigurator.LanguageManager.getString("Opzioni.utente") 
                                    + " - " + ApplicationConfigurator.LanguageManager.getString("ReportBI")%></b></legend>
                            <div style="width:100%; height:220px; overflow:auto;border:0px solid gray;">
                                <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                    <tr <%=!BIModule?"disabled":""%>>
                                        <td style="white-space:nowrap;">
                                            <b><%=ApplicationConfigurator.LanguageManager.getString("Firefox.path")%>:</b>
                                        </td>
                                        <td>
                                            <div id="FOX_PTH-AjaxWorker">
                                                <script type="text/javascript">
                                                    eseguiChiamataAjax("SDS_OPT_FOX_PTH.jsp?COD_UTN=<%=lCOD_UTN%>&BIModule=<%=BIModule%>",document.getElementById("FOX_PTH-AjaxWorker"));
                                                </script>
                                            </div>
                                        </td>
                                        <td style="display: <%=!BIModule?"none":"block"%>;">
                                            <a href="<%=ApplicationConfigurator.getApplicationURI()%>downloadManager?appName=Firefox" target="ifrmWork">
                                                <img src="../_images/download.png" alt="<%=ApplicationConfigurator.LanguageManager.getString("Scarica")%>" style="border-style: none">
                                            </a>
                                        </td>
                                        <td style="display: <%=!BIModule?"none":"block"%>;">
                                            <a href="#" onclick="g_openHelpWindow(tb_url_Help + '?HelpFrom=CONTEXT-FIREFOX')">
                                                <img src="../_images/context-help.png" alt="<%=ApplicationConfigurator.LanguageManager.getString("Informazioni.elemento")%>" style="border-style: none">
                                            </a>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </fieldset>
                        <!-- panelGenerale -->
                        <fieldset id="panelGenerale" style="height:200px; display:none;">
                            <legend>
                                <b><%=ApplicationConfigurator.LanguageManager.getString("Opzioni.sistema") 
                                        + " - " + ApplicationConfigurator.LanguageManager.getString("Generale")%></b></legend>
                            <div style="width:100%; height:220px; overflow:auto;border:0px solid gray;">
                                <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </fieldset>
                        <!-- panelEmail -->
                        <fieldset id="panelEmail" style="height:200px; display:none;">
                            <legend>
                                <b><%=ApplicationConfigurator.LanguageManager.getString("Opzioni.sistema") 
                                        + " - " + ApplicationConfigurator.LanguageManager.getString("Email")%></b></legend>
                            <div style="width:100%; height:220px; overflow:auto;border:0px solid gray;">
                                <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </fieldset>
                        <!-- panelLDAP -->
                        <fieldset id="panelLDAP" style="height:200px; display:none;">
                            <legend>
                                <b><%=ApplicationConfigurator.LanguageManager.getString("Opzioni.sistema") 
                                        + " - " + ApplicationConfigurator.LanguageManager.getString("LDAP")%></b></legend>
                            <div style="width:100%; height:220px; overflow:auto;border:0px solid gray;">
                                <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </fieldset>
                        <!-- panelLog4j -->   
                        <fieldset id="panelLog4j" style="height:200px; display:none;">
                            <legend>
                                <b><%=ApplicationConfigurator.LanguageManager.getString("Opzioni.sistema") 
                                        + " - " + ApplicationConfigurator.LanguageManager.getString("Log4j")%></b></legend>
                            <div style="width:100%; height:220px; overflow:auto;border:0px solid gray;">
                                <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </form>
        <script type="text/javascript">
            g_openHelpWindow(tb_url_Help + '?HelpFrom=CONTEXT-FIREFOX');
        </script>
        <iframe name="ifrmWork" src="../empty.txt" class="ifrmWork" style="display:none;"></iframe>
    </body>
</html>
