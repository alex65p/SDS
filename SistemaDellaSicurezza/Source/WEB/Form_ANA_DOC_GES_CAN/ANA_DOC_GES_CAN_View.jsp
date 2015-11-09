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
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumentiGestioneCantieri.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

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
        long COD_AZL = Security.getAzienda();
        String TIT_DOC = c.checkStringEx("Titolo", request.getParameter("TIT_DOC"), false);
        String NUM_DOC = c.checkStringEx("N.Documento", request.getParameter("NUM_DOC"), false);
        java.sql.Date DAT_DOC = c.checkDate("Data", request.getParameter("DAT_DOC"), false);
        String DES = c.checkStringEx("Descrizione", request.getParameter("DES"), false);
        Long COD_TPL_DOC = c.checkLongEx("Tipologia", request.getParameter("COD_TPL_DOC"), false);
        Long COD_SOP = c.checkLongEx("Sopralluogo", request.getParameter("COD_SOP"), false);
        Long COD_OPE = c.checkLongEx("Opera", request.getParameter("opera"), false);
        Long COD_CAN = c.checkLongEx("Cantiere", request.getParameter("cantiere"), false);
        Long COD_PRO = c.checkLongEx("Procedimento", request.getParameter("procedimento"), false);

        if (c.isError) {
            out.println("<script>alert(\"" + c.printErrors() + "\");</script>");
            return;
        }

        IAnagrDocumentiGestioneCantieriHome home = (IAnagrDocumentiGestioneCantieriHome) PseudoContext.lookup("AnagrDocumentiGestioneCantieriBean");
        Collection col = home.findEx(COD_AZL,
                TIT_DOC, NUM_DOC, DAT_DOC, COD_TPL_DOC, COD_SOP, COD_OPE, COD_CAN, COD_PRO, DES, 2);
        Iterator it = col.iterator();
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("N.Documento")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                int i = 1;
                while (it.hasNext()) {
                    AnagrDocumentoGestioneCantieri_View v = (AnagrDocumentoGestioneCantieri_View) it.next();
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=v.lCOD_DOC%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                <td>&nbsp;<%=i++%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(v.strNOM_TPL_DOC)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(v.strNUM_DOC)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(v.dtDAT_DOC)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(v.strTIT_DOC)%>&nbsp;</td>
            </tr>
            <%
                }
            %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Tipologia" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_N.Documento" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("N.Documento")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Titolo" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuDocumentiAreaSicurezza, 1));
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_DOC_GES_CAN/ANA_DOC_GES_CAN_Form.jsp";
        parent.g_Handler.New.Width = "750px";
        parent.g_Handler.New.Height = "700px";
        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_DOC_GES_CAN/ANA_DOC_GES_CAN_Delete.jsp";
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_DOC/ANA_DOC_Help.jsp";
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
