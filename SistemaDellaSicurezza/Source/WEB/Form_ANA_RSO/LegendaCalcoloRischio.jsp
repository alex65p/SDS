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
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
    <head>
        <title>
            <%=ApplicationConfigurator.LanguageManager.getString("Modalità.di.calcolo.del.rischio-Legenda")%>
        </title>
    </head>
    <link rel="stylesheet" href="../_styles/style.css">
    <body>
        <table border="0" width='100%'>
            <tr>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0"  width='100%'>
                        <tr>
                            <td align="center" class="title">
            <%=ApplicationConfigurator.LanguageManager.getString("Modalità.di.calcolo.del.rischio-Legenda")%>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <fieldset>
                        <table border="0" width="100%" cellpadding="0" cellspacing="5">
                            <tr>
                                <td>
                                    <%=ApplicationConfigurator.LanguageManager.getString("E.D.")%>
                                </td>
                                <td>
                                    <%=ApplicationConfigurator.LanguageManager.getString("Entità.del.danno")%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <%=ApplicationConfigurator.LanguageManager.getString("P.E.L.")%>
                                </td>
                                <td>
                                   <%=ApplicationConfigurator.LanguageManager.getString("Probabilità.dell'evento.lesivo")%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <%=ApplicationConfigurator.LanguageManager.getString("F.A.R.")%>
                                </td>
                                <td>
                                    <%=ApplicationConfigurator.LanguageManager.getString("Frequenza.dell'attività.a.rischio")%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <%=ApplicationConfigurator.LanguageManager.getString("F.M.")%>
                                </td>
                                <td>
                                    <%=ApplicationConfigurator.LanguageManager.getString("Fattore.moltiplicativo")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <%=ApplicationConfigurator.LanguageManager.getString("(1+(N.I.I.-1)*0.5)")%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <%=ApplicationConfigurator.LanguageManager.getString("N.I.I.")%>
                                </td>
                                <td>
                                    <%=ApplicationConfigurator.LanguageManager.getString("Numero.di.incidenti/infortuni.(negli.ultimi.3.anni)")%>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
        </table>
    </body>
</html>


