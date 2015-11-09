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

<%    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache");        //HTTP 1.0
    response.setDateHeader("Expires", 0);          //prevents caching at the proxy server
%>
<%@ page import="s2s.luna.conf.ApplicationConfigurator" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>
<%@ page import="java.util.Collection" %>
<%@ page import="s2s.luna.conf.ModuleManager" %>
<%@ page import="s2s.luna.conf.ModuleManager.LANGUAGES" %>
<%@ include file="changeLogo.jsp" %>


<%@ taglib uri="http://jakarta.apache.org/taglibs/session-1.0" prefix="sess" %>
<%@ include file="../WEB/_include/Global.jsp" %>
<%
    boolean loginByLdap = false;
    if (ApplicationConfigurator.isModuleEnabled(MODULES.LDAP)) {
        loginByLdap
                = (ApplicationConfigurator.LOGINMODE != null
                && ApplicationConfigurator.LOGINMODE.trim().equals("LDAP"));
    }
    boolean ldapVerified = (session.getAttribute("ldapVerified") != null);
    session.removeAttribute("ldapVerified");

    String username = request.getParameter("j_username");
    String password = request.getParameter("j_password");
    username = username != null ? username : "";
    password = password != null ? password : "";

    String securitySource = ApplicationConfigurator.getApplicationURI() + "_security/";

%>
<sess:invalidate/>
<html>
    <head>
        <%
            if (request.getParameter("USER_LANGUAGE") != null) {
                request.getSession(true).setAttribute("USER_LANGUAGE", request.getParameter("USER_LANGUAGE"));
                return;
            } else {
                if (request.getSession(true).getAttribute("USER_LANGUAGE") == null) {
                    request.getSession(true).setAttribute("USER_LANGUAGE", "it");
                }
            }
        %>
        <meta http-equiv=imagetoolbar content=no/>
        <title><%=APP_WINDOW_TITLE%> - <%=request.getSession(true).getAttribute("USER_LANGUAGE")%></title>
        <!--<link rel="stylesheet" href="../WEB/_styles/index.css" type="text/css">-->
        
        
        <style type="text/css">
            body
            {
                font-family:Tahoma;
                
                background: #15138a; /* Old browsers */

            }
            input  { color: black;   font-family: Tahoma;}
            select { color: black;   font-family: Tahoma;}
        </style>
        <script type="text/javascript">
            function onLanguageChange(obj) {
                return;
                document.all["fLanguage"].src = "logon.jsp?USER_LANGUAGE=" + obj.options[obj.selectedIndex].value;
            }
            function onFormSubmit(obj) {
                document.all["fLanguage"].outerHTML = "";
            }
            function changeDB(dbName) {
                document.all["ifrmWork"].src = 'changeDB.jsp?DATABASE_SELECTOR=' + dbName;
            }
            
            function changeLanguage(languageName) {
                document.all["ifrmWork"].src = 'changeLanguage.jsp?LANGUAGE_SELECTOR=' + languageName;
            }

            function centerToScreen(win, width, height) {
                var x = screen.availWidth - width - ((screen.availWidth - width) / 2);
                var y = screen.availHeight - height - ((screen.availHeight - height) / 2);
                win.moveTo(x, y);
            }
        </script>
    </head>
    <body>
        <script type="text/javascript">
            window.resizeTo(590, 620);
            centerToScreen(window, 590, 620);
        </script>
        <table width="100%" style="height: 100%;" border="0">
            <tr>
                <td colspan="3" align="center" style="padding-left: 40px;" >
                    <img  
                        id="idLogo" name="idLogo" style="height: 90px; border:0px;"
                        <% String logo=ApplicationConfigurator.getProfile().getName();%>
                         src="<%=securitySource%>logoCliente/<%=logo%>.png"
                      
                         
                         alt="<%=ApplicationConfigurator.LanguageManager.getString("Profilo")%>">
                         
                </td>
            </tr>
            <tr>
                <td colspan="3" >
                    <table border="0" align="center" style="color:white" width="100%">
                        <tr>
                            <td width="25%">
                                &nbsp;
                            </td>
                            <td style="padding-left: 40px;" align="center" width="50%">
                                <h2>
                                    <%=ApplicationConfigurator.LanguageManager.getString("Autenticazione")%>
                                    <%
                                        if (loginByLdap || ldapVerified) {
                                            out.println(
                                                    "<img src=\"" + securitySource
                                                    + "ldapAuthentication.png\" height=\"48\" width=\"48\">");
                                        }
                                    %>
                                </h2>
                            </td>
                            <td width="25%">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td width="25%">
                                &nbsp;
                            </td>
                            <td colspan="2">
                                <%
                                    if (request.getParameter("ldapError") != null) {
                                        out.println("<h5><font color=brown>" + request.getParameter("ldapError") + "</font><h5>");
                                    } else {
                                        out.println("&nbsp;");
                                    }
                                %>
                            </td>
                        </tr>
                        <tr>
                            <td width="25%">
                                &nbsp;
                            </td>
                            <td width="50%">
                                <!-- Login -->
                                <%
                                    if (loginByLdap == true && ldapVerified == false) {
                                        out.println("<form id=\"form_id\" action=\"" + securitySource + "ldap.jsp\" method=\"post\" onsubmit=\"onFormSubmit()\">");
                                    } else {
                                        out.println("<form id=\"form_id\" action=\"" + ApplicationConfigurator.getApplicationURI() + "loginManager\" method=\"post\" onsubmit=\"onFormSubmit()\">");
                                    }
                                %>
                                <table border="0"  style="color:white" align="center" width="100%">
                                    <tr>
                                        <td align="right">
                                            <B>
                                                <font face="Tahoma" size="3">
                                                <%=ApplicationConfigurator.LanguageManager.getString("Utente")%>&nbsp;
                                                </font>
                                            </B>
                                        </td>
                                        <td align="left">
                                            <input id="j_username_id" name="j_username" type="text" style="width: 100%;" value="<%=username%>">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <b>
                                                <font face="Tahoma" size="3">
                                                <%=ApplicationConfigurator.LanguageManager.getString("Password")%>&nbsp;
                                                </font>
                                            </b>
                                        </td>
                                        <td align="left">
                                            <input id="j_password_id" name="j_password" type="password" style="width: 100%;" value="<%=password%>">
                                        </td>
                                    </tr>
                                    <!-- Lista di selezione del profilo -->
                                    <tr style="display: <%=ApplicationConfigurator.PROFILE_CHANGE ? "table-row" : "none"%>">
                                        <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Profilo")%>&nbsp;</td>
                                        <td align="left">
                                            <select id ="PROFILE_SELECTOR" name="PROFILE_SELECTOR" style="width: 100%;"  onchange="LoadLogoCliente(this);">
                                                <%
                                                    Collection<ModuleManager> ProfilesList = ApplicationConfigurator.getProfiles();
                                                    String profileName = "";
                                                    for (ModuleManager Profile : ProfilesList) {
                                                        profileName = Profile.getProfile().getName();
                                                        out.println(
                                                                "<option "
                                                                + (ApplicationConfigurator.getProfile().getName().equals(profileName) ? "selected" : "")
                                                                + " value=\"" + profileName + "\">"
                                                                + Profile.getProfile().getDesc()
                                                                + "</option>"
                                                        );
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!-- Lista di selezione del database -->
                                    <tr style="display: <%=ApplicationConfigurator.DATABASE_CHANGE ? "table-row" : "none"%>">
                                        <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Database")%>&nbsp;</td>
                                        <td align="left">
                                            <select name="DATABASE_SELECTOR" onchange="changeDB(this.value);" style="width: 100%;">
                                                <%
                                                    Collection<String> DatabaseList = ApplicationConfigurator.getDefinedDB();
                                                    String defaultDatabase = ApplicationConfigurator.getDatabase();
                                                    for (String Database : DatabaseList) {
                                                        out.println(
                                                                "<option "
                                                                + (defaultDatabase.equals(Database) ? "selected" : "")
                                                                + " value=\"" + Database + "\">"
                                                                + Database
                                                                + "</option>"
                                                        );
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!-- Lista dei linguaggi supportati -->
                                    <tr style="display: <%=ApplicationConfigurator.LANGUAGE_CHANGE ? "table-row" : "none"%>">
                                        <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Lingua")%>&nbsp;</td>
                                        <td align="left">
                                            <select name="LANGUAGE_SELECTOR" onchange="changeLanguage(this.value);" style="width: 100%;">
                                                <%
                                                    String selectedLanguage
                                                            = ApplicationConfigurator.getLanguage().getName();
                                                    for (LANGUAGES language : ModuleManager.LANGUAGES.values()) {
                                                        out.println(
                                                                "<option "
                                                                + (language.getName().equals(selectedLanguage) ? "selected" : "")
                                                                + " value=\"" + language.getName() + "\">"
                                                                + language.getDesc()
                                                                + "</option>"
                                                        );
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            &nbsp;
                                        </td>
                                        <td align="left">
                                            <table border="0" align="left" style="width: 100%; text-align: center;">
                                                <td>
                                                    <input type="submit" value="  <%=ApplicationConfigurator.LanguageManager.getString("Login")%>   " style="font-size: 12pt; width: 107px; font-family: Tahoma; height: 28px" size=22>
                                                </td>
                                                <td>
                                                    <input type="reset" value="  <%=ApplicationConfigurator.LanguageManager.getString("Annulla")%>  " style="font-size: 12pt; font-family: Tahoma" >
                                                </td>
                                            </table>
                                        </td>
                                    </tr>                
                                </table>
                            </td>
                            <td width="25%">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr></tr>
            <tr></tr>
            <tr></tr>
            <tr>
                <td align="left" valign="bottom">
                    <%
                        if (ApplicationConfigurator.VIEW_CERT_IMAGE) {
                            out.println(
                                    "<img src=\"" + securitySource
                                    + "logocertificazione.gif\" width=\"90\" height=\"66\">");
                        }
                    %>
                </td>
                <td align="left" valign="bottom" style="padding-bottom: 10px;">
                    <img src="<%=securitySource%>626.gif" width="106" height="71" 
                         alt="<%=ApplicationConfigurator.LanguageManager.getString("Sistema.della.Sicurezza")%>">
                </td>
                <td align="right" valign="bottom" >
                    <img src="<%=securitySource%>sviluppatoDa.png" 
                         alt="<%=ApplicationConfigurator.LanguageManager.getString("Sviluppato.da.S2S.s.r.l.Open.Software")%>">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="left" valign="baseline" 
                    style="padding-bottom: 1px;color:white;font-family:Tahoma;font-size:12">
                    Ottimizzato per Risoluzioni Video 1280x768
                </td>
                <td colspan="1" align="right" valign="baseline" 
                    style="padding-bottom: 1px;color:white;font-family:Tahoma;font-size:12">
                    <a  target="_blank"  style="color: white" href="<%=securitySource%>ConfigurazioneIE.pdf" download >
                        <img height="32" border="0" width="32" src="<%=securitySource%>pdf-icon.png" /><%=ApplicationConfigurator.LanguageManager.getString("Come.Configurare.IE")%></a> 
                </td>  
            </tr>
        </table>
        <script type="text/javascript">
            <%
                if (loginByLdap && ldapVerified) {
                    out.print("document.forms[0].submit();");
                } else {
                    out.print("document.forms[0].j_username.value=\"\";");
                    out.print("document.forms[0].j_password.value=\"\";");
                }
            %>
        </script>
        <iframe id="fLanguage" name="fLanguage" src="../empty.txt" style="DISPLAY: none"></iframe>
        <iframe name="ifrmWork" class="ifrmWork" style="DISPLAY: none" src="../empty.txt" ></iframe>
    </body>
</html>
