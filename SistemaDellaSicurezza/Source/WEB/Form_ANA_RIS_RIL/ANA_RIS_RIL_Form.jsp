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
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<html>
    <head>
        <script>
            // document.write("<title>" + getCompleteMenuPath(SubMenuSopralluoghi,0) + "</title>");
            document.write("<title>" +"Rischi rilevati"+ "</title>");
        </script>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
    </head>
    <script>
        window.dialogWidth="816px";
        window.dialogHeight="260px";
    </script>
    <script language="JavaScript" src="../_scripts/textarea.js"></script>
    <body>
        <%

        %>

        <!-- form for addind  -->
        <form action="TPL_DOC_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <table width="100%" border="0">
                <tr>
                    <td width="10" height="100%" valign="top">
                    </td>
                    <td valign="top">
                        <table  width="100%" border="0">
                            <tr><td class="title" colspan="2">
                                    <%=ApplicationConfigurator.LanguageManager.getString("Rischi.rilevati")%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="100%">
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%=ToolBar.build(2)%>
                                    </table>
                                    <fieldset>
                                        <legend></legend>
                                        <table  width="100%" border="0">
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Procedimento")%>&nbsp;</b></td>
                                                <td >Linea B1
                                                </td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Opera")%>&nbsp;</td>
                                                <td></td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Cantiere")%>&nbsp;</td>
                                                <td>Pi30</td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Numero.sopralluogo")%>&nbsp;</b></td>
                                                <td >A</td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data")%>&nbsp;</td>
                                                <td >03/09/2010</td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Ora")%>&nbsp;</b></td>
                                                <td >06:01</td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Progressivo")%>&nbsp;</b></td>
                                                <td ><input tabindex="4" size="10" type="text" maxlength="10" name="" value=""></td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                                <td colspan="3" width="60%"> <s2s:textarea tabindex="1" cols="1" rows="3" maxlength="200"><%=0%></s2s:textarea></td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Rischi.rilevati")%>&nbsp;</b></td>
                                                <td colspan="5"><select name="" rows="1" tabindex="1">
                                                        <option>Altro</option>
                                                        <option>Caduta</option>
                                                        <option>Elettrocuzione</option>
                                                        <option>Inciampo</option>
                                                        <option>Scivolamento</option>
                                                    </select>
                                                    <input tabindex="4" size="20" type="text" maxlength="10" name="" value="">
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>




