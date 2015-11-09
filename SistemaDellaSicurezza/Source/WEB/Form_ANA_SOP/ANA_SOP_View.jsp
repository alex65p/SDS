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

<%    response.setHeader("Cache-Control", "no-cache");         //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Sopraluogo.*" %>
<%@ page import="java.sql.Date" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        Checker c = new Checker();
        Long lCOD_PRO = c.checkLongEx(ApplicationConfigurator.LanguageManager.getString("Procedimento"), request.getParameter("procedimento"), false);
        Long lCOD_CAN = c.checkLongEx(ApplicationConfigurator.LanguageManager.getString("Cantiere"), request.getParameter("cantiere"), false);
        Long lCOD_OPE = c.checkLongEx(ApplicationConfigurator.LanguageManager.getString("Opera"), request.getParameter("opera"), false);
        String sNUM_SOP = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Numero.sopralluogo"), request.getParameter("NUM_SOP"), false);
        Date dDAT_SOP = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data"), request.getParameter("DAT_SOP"), false);

        ISopraluogoHome aHome = (ISopraluogoHome) PseudoContext.lookup("SopraluogoBean");
        Collection col = aHome.findEx(Security.getAzienda(),
                lCOD_PRO, lCOD_OPE, lCOD_CAN, sNUM_SOP, dDAT_SOP, null);

        Iterator it = col.iterator();
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero.sopralluogo")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Procedimento")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Cantiere")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Opera")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                int i = 1;
                while (it.hasNext()) {
                    findEx_sop view = (findEx_sop) it.next();
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=view.COD_SOP%>" onclick="g_Handler.OnRowClick(this)"  ondblclick="g_Handler.OnRowDblClick(this)">
                <td><%=i++%></td>
                <td><%=Formatter.format(view.NUM_SOP)%></td>
                <td><%=Formatter.format(view.DAT_SOP)%></td>
                <td><%=Formatter.format(view.NOME_PRO)%></td>
                <td><%=Formatter.format(view.NOME_CAN)%></td>
                <td><%=Formatter.format(view.NOME_OPE)%></td>
            </tr>
            <%
                }
            %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Numero.sopralluogo" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero.sopralluogo")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Procedimento" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Procedimento")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Cantiere" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Cantiere")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Opera" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Opera")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }
    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuSopralluoghi, 3));

        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_SOP/ANA_SOP_Form.jsp";
        parent.g_Handler.New.Width = 60;
        parent.g_Handler.New.Height = 17;

        parent.g_Handler.Open = parent.g_Handler.New;

        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_SOP/ANA_SOP_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
    }

    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
