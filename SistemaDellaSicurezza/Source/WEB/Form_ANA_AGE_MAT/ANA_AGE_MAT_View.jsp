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
    /*
     * <file> <versions> <version number="1.0" date="26/01/2004"
     * author="Valentina Ruggieri"> <comments> <comment date="26/01/2004"
     * author="Valentina Ruggieri"> <description>ANA_AGE_MAT_View</description>
     * </comment> </comments> </version> </versions> </file>
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AgenteMateriale.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        Checker c = new Checker();
        Long COD_CAG_AGE_MAT = c.checkLongEx("Categoria", request.getParameter("COD_CAG_AGE_MAT"), true);
        String strNOM_AGE_MAT = c.checkStringEx("Descrizione", request.getParameter("NOM_AGE_MAT"), true);
        if (c.isError) {
            String err = c.printErrors();
    %><script>alert("<%=err%>");</script><%
            return;
        }
        long lCOD_CAG = 0;
        if (COD_CAG_AGE_MAT != null) {
            lCOD_CAG = COD_CAG_AGE_MAT.longValue();
        }
        IAgenteMaterialeHome home = (IAgenteMaterialeHome) PseudoContext.lookup("AgenteMaterialeBean");
        Collection col = home.findEx(lCOD_CAG, strNOM_AGE_MAT, 1);
        Iterator it = col.iterator();
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
              
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Agente.materiale")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                int i = 1;
                while (it.hasNext()) {
                    findEx_age_mat view = (findEx_age_mat) it.next();
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=view.COD_AGE_MAT%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
              
                <td>&nbsp;<%=i++%>&nbsp;</td>
           
                <td>&nbsp;<%=view.NOM_AGE_MAT%>&nbsp;</td>
            </tr>
            <%
                }
            %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
              
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
              
                <th><input type="text" name="cerca_Agente.materiale" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Agente.materiale")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0015"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuInfortuni, 3));
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_AGE_MAT/ANA_AGE_MAT_Form.jsp";
        parent.g_Handler.New.Width = 36;
        parent.g_Handler.New.Height = 11;
        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_AGE_MAT/ANA_AGE_MAT_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        
        parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "7%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "93%", "aTargets": [1], "sType": "string"}   ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>

