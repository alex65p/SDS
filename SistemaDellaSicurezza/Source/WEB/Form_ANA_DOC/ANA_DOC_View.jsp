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
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>
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
        String RSP_DOC = c.checkStringEx("Responsabile", request.getParameter("RSP_DOC"), false);
        String APV_DOC = c.checkStringEx("Resp.Appr.", request.getParameter("APV_DOC"), false);
        String EMS_DOC = c.checkStringEx("Resp. Emissione", request.getParameter("EMS_DOC"), false);
        String NUM_DOC = c.checkStringEx("N. Documento", request.getParameter("NUM_DOC"), false);
        Long EDI_DOC = c.checkLongEx("Edizione", request.getParameter("EDI_DOC"), false);
        String REV_DOC = c.checkStringEx("Revisione", request.getParameter("REV_DOC"), false);
        java.sql.Date DAT_REV_DOC = c.checkDate("Data", request.getParameter("DAT_REV_DOC"), false);
        Long MES_REV_DOC = c.checkLongEx("Mese", request.getParameter("MES_REV_DOC"), false);
        java.sql.Date DAT_FUT_REV_DOC = c.checkDate("Data Futura", request.getParameter("DAT_FUT_REV_DOC"), false);
        String DES_REV_DOC = c.checkStringEx("Descrizione", request.getParameter("DES_REV_DOC"), false);
        String PRG_RIF_DOC = c.checkStringEx("Paragrafo di Riferimento", request.getParameter("PRG_RIF_DOC"), false);
        String PGN_RIF_DOC = c.checkStringEx("Pag. rif.", request.getParameter("PGN_RIF_DOC"), false);
        String TIT_DOC = c.checkStringEx("Titolo", request.getParameter("TIT_DOC"), false);
        Long COD_CAG_DOC = c.checkLongEx("Categoria", request.getParameter("COD_CAG_DOC"), false);
        Long COD_TPL_DOC = c.checkLongEx("Tipologia", request.getParameter("COD_TPL_DOC"), false);
        Long COD_LUO_FSC = c.checkLongEx("Luogo Fisico", request.getParameter("COD_LUO_FSC"), false);
        String NOT_LUO_CON = c.checkStringEx("Descrizione", request.getParameter("NOT_LUO_CON"), false);
        Long PER_CON_YEA = c.checkLongEx("Periodicità Annuale", request.getParameter("PER_CON_YEA"), false);

        if (c.isError) {
            out.println("<script>alert(\"" + c.printErrors() + "\");</script>");
            return;
        }

        IAnagrDocumentoHome home = (IAnagrDocumentoHome) PseudoContext.lookup("AnagrDocumentoBean");
        Collection col = home.findEx(COD_AZL,
                RSP_DOC, EMS_DOC, NUM_DOC,
                EDI_DOC, DAT_REV_DOC, MES_REV_DOC,
                TIT_DOC, COD_CAG_DOC,
                COD_TPL_DOC, DAT_FUT_REV_DOC,
                PRG_RIF_DOC, PGN_RIF_DOC,
                COD_LUO_FSC, NOT_LUO_CON,
                PER_CON_YEA, 2);
        Iterator it = col.iterator();
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);

        if (!ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_MSR) == true) {
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("N.Documento")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Categoria")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                int i = 1;
                while (it.hasNext()) {
                    AnagrDocumento_View v = (AnagrDocumento_View) it.next();
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=v.lCOD_DOC%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                <td>&nbsp;<%=i++%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(v.strTIT_DOC)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(v.strNUM_DOC)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(v.strNOM_CAG_DOC)%>&nbsp;</td>
            </tr>
            <%
                }
            %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Titolo" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_N.Documento" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("N.Documento")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Categoria" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Categoria")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
    <%
    } else {
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Categoria")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                int i = 1;
                while (it.hasNext()) {
                    AnagrDocumento_View v = (AnagrDocumento_View) it.next();
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=v.lCOD_DOC%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
               
                <td>&nbsp;<%=i++%>&nbsp;</td>
               
                <td>&nbsp;<%=Formatter.format(v.strNOM_CAG_DOC)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(v.strTIT_DOC)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(v.dtDAT_REV_DOC)%>&nbsp;</td>
            </tr>
            <%
                }
            %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
               
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                
                <th><input type="text" name="cerca_Categoria" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Categoria")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Titolo" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
    <%
        }
    %>
</div>
<script>
    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuDocumenti, 2));
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_DOC/ANA_DOC_Form.jsp";
        parent.g_Handler.New.Width = "750px";
        parent.g_Handler.New.Height = "700px";
        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_DOC/ANA_DOC_Delete.jsp";
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_DOC/ANA_DOC_Help.jsp";
          parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "40%", "aTargets": [1], "sType": "string"},
                        {"sWidth": "40%", "aTargets": [2], "sType": "string"} ,
                        {"sWidth": "10%", "aTargets": [3], "sType": "date-eu"}  ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
    <%if (Security.isExtendedMode()) {%>
    parent.g_Handler.Delete.getButton().disabled = true;
    <%}%>
</script>
