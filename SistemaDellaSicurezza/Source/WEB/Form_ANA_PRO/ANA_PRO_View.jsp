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
<%@ page import="com.apconsulting.luna.ejb.AnagrProcedimento.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        Checker c = new Checker();
        long lCOD_AZL = Security.getAzienda();
        long lCOD_PRO = c.checkLong("Procedimento", request.getParameter("COD_PRO"), false);
        String strDES = c.checkStringEx("Descrizione", request.getParameter("DES"), false);
        String strNOM_RUP = c.checkStringEx("Nome R.U.P", request.getParameter("NOM_RUP"), false);
        String dtDAT_AMM = c.checkStringEx("Data", request.getParameter("DAT_AMM"), false);
        String strCOD = c.checkStringEx("Codice", request.getParameter("COD"), false);

        if (c.isError) {
            String err = c.printErrors();
    %><script>alert("<%=err%>");</script><%
            return;
        }
        IAnagrProcedimentoHome home = (IAnagrProcedimentoHome) PseudoContext.lookup("AnagrProcedimentoBean");
        Collection col = home.findEx(lCOD_AZL, strDES, strNOM_RUP, dtDAT_AMM, strCOD);
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Codice")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome.RUP")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                Iterator it = col.iterator();

                int i = 1;
                while (it.hasNext()) {
                    AnagrProcedimento_All_View v = (AnagrProcedimento_All_View) it.next();
                    lCOD_PRO = v.COD_PRO;
                    strCOD = v.COD;
                    strDES = v.DES;
                    strNOM_RUP = v.NOM_RUP;
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=lCOD_PRO%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                <td>&nbsp;<%=i++%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(strCOD)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(strDES)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(strNOM_RUP)%>&nbsp;</td>
            </tr>
            <%}%>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Codice" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Codice")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Descrizione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Nome.RUP" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Nome.RUP")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0026"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuAnagraficagenerale, 0));
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_PRO/ANA_PRO_Form.jsp";
        parent.g_Handler.New.Width = "900px";       //  54;
        parent.g_Handler.New.Height = "400px";      //  34;
        //  parent.g_Handler.New.Height="630px";    //  34;

        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_PRO/ANA_PRO_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_PRO/ANA_PRO_Help.jsp";
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
    <%if (Security.isExtendedMode()) {%>
    parent.g_Handler.Delete.getButton().disabled = false;
    <%}%>
</script>
