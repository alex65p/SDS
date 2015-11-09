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
    Document   : ANA_PSC_View
    Created on : 21-mar-2011, 15.47.54
    Author     : Alessandro
--%>
<%
    /*
     * <file> <versions> <version number="1.0" date="23/01/2004"
     * author="Pogrebnoy Yura"> <comments>
     *
     * <comment date="23/01/2004" author="Pogrebnoy Yura">
     * <description>Chernovik vieW</description> </comment> </comments>
     * </version> </versions> </file>
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.PSC.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Codice")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Procedimento")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Oggetto")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                Checker c = new Checker();
                long lCOD_PRO = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Procedimento"), request.getParameter("COD_PRO"), false);
                String strTIT = c.checkString(ApplicationConfigurator.LanguageManager.getString("Titolo"), request.getParameter("TIT"), false);
                String strCOD = c.checkString(ApplicationConfigurator.LanguageManager.getString("Codice"), request.getParameter("COD"), false);
                String strOGG = c.checkString(ApplicationConfigurator.LanguageManager.getString("Oggetto"), request.getParameter("OGG"), false);
                String strCOD_ELA = c.checkString(ApplicationConfigurator.LanguageManager.getString("Codifica.elaborato"), request.getParameter("COD_ELA"), false);

                if (c.isError) {
                    String err = c.printErrors();
                    out.println("<script>alert(\"" + err + "\");</script>");
                    return;
                }

                IPSCHome home = (IPSCHome) PseudoContext.lookup("PSCBean");
                java.util.Collection col = home.findEx(Security.getAzienda(), lCOD_PRO, strCOD, strTIT, strOGG, strCOD_ELA, 0);
                java.util.Iterator it = col.iterator();
                int i = 1;
                while (it.hasNext()) {
                    PSC_All_View obj = (PSC_All_View) it.next();
            %>		<tr class="VIEW_TR" valign="top" INDEX="<%=obj.COD_PSC%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                <td>&nbsp;<%=i++%>&nbsp;</td>
                <%
                        out.println("<td>&nbsp;" + Formatter.format(obj.COD) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.DES) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.TIT) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.OGG) + "&nbsp;</td></tr>");
                    }
                %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Codice" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Codice")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Procedimento" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Procedimento")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Titolo" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Oggetto" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Oggetto")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuGestionecantieri, 3));

        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_PSC/ANA_PSC_Form.jsp";
        parent.g_Handler.New.Width = 60;
        parent.g_Handler.New.Height = 17;
        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_PSC/ANA_PSC_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
    }

    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
