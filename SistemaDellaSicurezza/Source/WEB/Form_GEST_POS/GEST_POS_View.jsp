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
    Document   : ANA_PRO_View
    Created on : 8-apr-2011, 11.34.42
    Author     : Alessandro
--%>
<%    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@page import="com.apconsulting.luna.ejb.AnagrPOS.AnagrPOS_All_View"%>
<%@page import="com.apconsulting.luna.ejb.AnagrPOS.IAnagrPOSHome"%>
<%@page import="com.apconsulting.luna.ejb.AnagrPOS.IAnagrPOS"%>
<%@page import="com.apconsulting.luna.ejb.AnagrCantieri.AnagrCantieri_All_View"%>
<%@page import="com.apconsulting.luna.ejb.AnagrCantieri.IAnagrCantieriHome"%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

S<div id="divContent">
    <%
        Checker c = new Checker();
        long lCOD_POS = c.checkLong("POS", request.getParameter("COD_POS"), false);
        long lCOD_DTE = c.checkLong("DTE", request.getParameter("COD_IMP"), false);
        long lCOD_DOC = c.checkLong("DOC", request.getParameter("COD_DOC"), false);
        long lCOD_PRO = c.checkLong("PRO", request.getParameter("COD_PRO"), false);
        long lCOD_OPE = c.checkLong("OPE", request.getParameter("COD_OPE"), false);
        String strTIT = c.checkStringEx("Titolo", request.getParameter("TIT"), false);
        String strUFF = c.checkStringEx("Ufficio", request.getParameter("UFF"), false);
        String strSTA = c.checkStringEx("Stanza", request.getParameter("STA"), false);
        String strFAL = c.checkStringEx("Faldone", request.getParameter("FAL"), false);
        String strPRO = c.checkStringEx("Progressivo", request.getParameter("PRG"), false);
        java.sql.Date datData = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data"), request.getParameter("DATA"), false);

        if (c.isError) {
            String err = c.printErrors();
    %><script>alert("<%=err%>");</script><%
            return;
        }

        IAnagrPOSHome home = (IAnagrPOSHome) PseudoContext.lookup("AnagrPOSBean");
        IAnagrPOS bean;
        //  Collection col = home.findEx("xxx","xxx");
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Procedimento")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Cantiere")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Opera")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Impresa")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero.documento")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                java.util.Collection col = home.findEx(Security.getAzienda(), lCOD_DTE, lCOD_DOC,
                        strTIT, strUFF, strSTA, strFAL, strPRO,
                        datData);
                java.util.Iterator it = col.iterator();
                int i = 1;
                while (it.hasNext()) {
                    AnagrPOS_All_View obj = (AnagrPOS_All_View) it.next();
            %>		<tr class="VIEW_TR" valign="top" INDEX="<%=obj.COD_POS%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                <td>&nbsp;<%=i++%>&nbsp;</td>
                <%
                        out.println("<td>&nbsp;" + Formatter.format(obj.PRO) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.CAN) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.OPE) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.TIT) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.IMP) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.Data) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.NUM_DOC) + "&nbsp;</td></tr>");
                    }
                %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Procedimento" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Procedimento")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Cantiere" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Cantiere")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Opera" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Opera")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Titolo" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Impresa" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Impresa")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Numero.documento" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero.documento")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0026"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuGestionecantieri, 4));
        parent.g_Handler.New.URL = "/luna/WEB/Form_GEST_POS/GEST_POS_Form.jsp";
        parent.g_Handler.New.Width = 100;
        parent.g_Handler.New.Height = 17;
        //  parent.g_Handler.New.Height="630px";//34;

        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_GEST_POS/GEST_POS_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        //  parent.g_Handler.Help.URL="/luna/WEB/Form_ANA_RSO/ANA_RSO_Help.jsp";
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
