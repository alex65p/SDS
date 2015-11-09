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

<%@ page import="s2s.luna.util.ExceptionInfo" %>
<%@ page import="s2s.utils.text.StringManager" %>
<%@ page import="s2s.luna.util.DBInfo"%>
<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
    Exception Ex = (Exception)session.getAttribute("ex");
    ExceptionInfo EInfo = new ExceptionInfo(Ex);
    DBInfo DB = new DBInfo();
%>
<%!
    String BuildErrMail(Exception Ex, DBInfo DB){
        return  StringManager.prepare(
            "subject=Sistema della Sicurezza - " + 
            ApplicationConfigurator.LanguageManager.getString("Segnalazione") + 
            " &amp;body=" +
            ApplicationConfigurator.LanguageManager.getString("Segnalazione.testo").toUpperCase() + 
                "<br><br>" + Ex.getMessage() + "<br><br>" +
            ApplicationConfigurator.LanguageManager.getString("Versione.del.software") +
                ": " + APP_VERSION + "<br>" +
            ApplicationConfigurator.LanguageManager.getString("Versione.del.database") +
                ": " + APP_DB_VERSION + "<br>" +
            ApplicationConfigurator.LanguageManager.getString("Cliente") +
                ": " + ApplicationConfigurator.CUSTOMER_NAME + "<br><br>" +
            ApplicationConfigurator.LanguageManager.getString("Database.produttore") +
                ": " + DB.getDatabaseProductName() + "<br>" +
            ApplicationConfigurator.LanguageManager.getString("Database.versione") +
                ": " + DB.getDatabaseProductVersion());
    }
%>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<html>
    <head>
        <title><%=ApplicationConfigurator.LanguageManager.getString("segnalazione.gestione")%></title>
    </head>
    <link rel="stylesheet" href="../_styles/style.css">
    <body>
        <table border="0">
            <tr>
                <td align="center" class="title" colspan="2">
                    <%=ApplicationConfigurator.LanguageManager.getString("segnalazione.gestione.avviso")%>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <%@ include file="../_include/ToolBar.jsp" %>
                    <table border="0">
                        <tr>
                            <td>
                                <%
                                    ToolBar.bShowNew = false;
                                    ToolBar.bShowSearch = false;
                                    ToolBar.bShowSave = false;
                                    ToolBar.bShowDelete = false;
                                    ToolBar.bShowPrint = false;
                                    out.println(ToolBar.build());
                                %>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td  colspan="2" class="title_warning">
                    <%=ApplicationConfigurator.LanguageManager.getString("segnalazione.attenzione.operazione.non.completata")%> - 
                    <b><%=EInfo.getUserMessage()%></b>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <fieldset style="border:4px double black; width:485">
                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Segnalazione.testo").toUpperCase()%></legend>
                        <div style="width:485; height:175; overflow:auto">
                        <table border="0">
                            <tr>
                                <td>
                                    <%=EInfo.get_Message()%>
                                </td>
                            </tr>
                        </table>
                        </div>
                    </fieldset>
                </td>
                <td rowspan="2">
                    <fieldset style="width:490">
                        <legend><%=ApplicationConfigurator.LanguageManager.getString("segnalazione.cause.soluzioni").toUpperCase()%></legend>
                        <div style="width:490; height:375; overflow:auto">
                        <table border="0">
                            <tr>
                                <td width="50%">
                                    <%=ApplicationConfigurator.LanguageManager.getString("segnalazione.tipologia")%>:
                                </td>
                                <td>
                                    <%=EInfo.getUserCategory()%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b><%=ApplicationConfigurator.LanguageManager.getString("segnalazione.messaggio.di.errore")%>:</b>
                                </td>
                                <td>
                                    <%=EInfo.getUserMessage()%>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <b><%=ApplicationConfigurator.LanguageManager.getString("segnalazione.possibili.cause")%></b>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <%=EInfo.get_Cause()%>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <b><%=ApplicationConfigurator.LanguageManager.getString("segnalazione.possibili.soluzioni")%></b>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <%=EInfo.getSolution()%>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <a href="mailto:supporto@s2sprodotti.it?<%=BuildErrMail(Ex, DB)%>"><%=ApplicationConfigurator.LanguageManager.getString("segnalazione.invia.al.supporto").toUpperCase()%></a>
                                </td>
                            </tr>
                        </table>
                        </div>
                    </fieldset>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <fieldset style="width:490">
                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dettaglio")%></legend>
                        <div style="width:490; height:175; overflow:auto">
                        <table border="0">
                            <tr>
                                <td>
                                    <%=EInfo.getDetail()%>
                                </td>
                            </tr>
                        </table>
                        </div>
                    </fieldset>
                </td>
            </tr>
        </table>
    </body>
</html>
