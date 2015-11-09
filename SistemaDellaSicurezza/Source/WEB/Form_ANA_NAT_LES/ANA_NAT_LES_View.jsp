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
     * <file> <versions> <version number="1.0" date="24/01/2004"
     * author="Kushkarov Yura"> <comments>
     *
     * <comment date="24/01/2004" author="Kushkarov Yura">
     * <description>Chernovik vieW</description> </comment> </comments>
     * </version> </versions> </file>
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>

<%@ page import="com.apconsulting.luna.ejb.NaturaLesione.*" %>

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
        INaturaLesioneHome aHome = (INaturaLesioneHome) PseudoContext.lookup("NaturaLesioneBean");
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Natura.della.lesione")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                Checker c = new Checker();
                String strNOM_NAT_LES = c.checkStringEx("Nome", request.getParameter("NOM_NAT_LES"), false);

                if (c.isError) {
                    String err = c.printErrors();
                    out.println("<script>alert(\"" + err + "\");err=true;</script>");
                    return;
                }
                java.util.Collection col_nr = aHome.findEx(strNOM_NAT_LES, 1);
                java.util.Iterator it_nr = col_nr.iterator();
                int iCount = 0;
                while (it_nr.hasNext()) {
                    ANA_NAT_LES_TAB_ByNOM_View nr = (ANA_NAT_LES_TAB_ByNOM_View) it_nr.next();
            %>
            <tr 
                class="VIEW_TR" valign="top"
                INDEX="<%=nr.COD_NAT_LES%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)"
                >
                <%  
                
                out.println("<td>&nbsp;" + ++iCount + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(nr.NOM_NAT_LES) + "&nbsp;</td></tr>");
                   
                
                }
                %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
             
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
               
                <th><input type="text" name="cerca_Natura.della.lesione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Natura.della.lesione")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuInfortuni, 1));

        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_NAT_LES/ANA_NAT_LES_Form.jsp";
        parent.g_Handler.New.Width = 38;
        parent.g_Handler.New.Height = 9;

        parent.g_Handler.Open = parent.g_Handler.New;

        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_NAT_LES/ANA_NAT_LES_Delete.jsp"; //?ID=32233223
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_NAT_LES/ANA_NAT_LES_Help.jsp";
        parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "90%", "aTargets": [1], "sType": "string"}   ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
