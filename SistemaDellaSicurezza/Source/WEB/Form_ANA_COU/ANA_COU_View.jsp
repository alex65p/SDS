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
<%@ page import="com.apconsulting.luna.ejb.Consulente.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border=0>
        <thead>
            <tr class="VIEW_HEADER_TR">
               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                 
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nominativo")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Ruolo")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.attivazione")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.disattivazione")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                Checker c = new Checker();

                String strNOM_COU = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Nominativo"), request.getParameter("NOM_COU"), false);
                String strUSD_COU = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Userid"), request.getParameter("USD_COU"), false);
                String strRUO_COU = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Ruolo"), request.getParameter("RUO_COU"), false);
                String strSTA_COU = c.checkString(ApplicationConfigurator.LanguageManager.getString("Stato"), request.getParameter("STA_COU"), false);
                java.sql.Date dDAT_ATT = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.attivazione"), request.getParameter("DAT_ATT"), false);
                java.sql.Date dDAT_DIS = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.disattivazione"), request.getParameter("DAT_DIS"), false);

                if (c.isError) {
                    String err = c.printErrors();
            %><script>alert("<%=err%>");</script><%
                    return;
                }

                IConsultantHome aHome = (IConsultantHome) PseudoContext.lookup("ConsultantBean");
                java.util.Collection col = aHome.findEx(strNOM_COU, strUSD_COU, strRUO_COU, strSTA_COU, dDAT_ATT, dDAT_DIS, 0);//getConsultant_View();
                java.util.Iterator it = col.iterator();
                int iCount = 0;
                while (it.hasNext()) {
                    ConsultantiByAZLID_View obj = (ConsultantiByAZLID_View) it.next();
        %>
        <tr	class="VIEW_TR" valign="top"	INDEX="<%=obj.COD_COU%>"
            onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
            
            <%  
            out.println("<td>&nbsp;" + ++iCount + "&nbsp;</td><td>&nbsp;"
            
                            + Formatter.format(obj.NOM_COU) + "&nbsp;</td><td>&nbsp;"
                            + Formatter.format(obj.RUO_COU) + "&nbsp;</td><td>&nbsp;"
                            + Formatter.format(obj.DAT_ATT) + "&nbsp;</td><td>&nbsp;"
                            + Formatter.format(obj.DAT_DIS) + "&nbsp;</td></tr>");
                
            }
                
            %>
           
            
            </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
               
                <th><input type="text" name="cerca_Nominativo" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Nominativo")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Ruolo" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Ruolo")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.attivazione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.attivazione")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.disattivazione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.disattivazione")%>" class="search_init" /></th>
            </tr>
        </tfoot>        
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0018"]);
    }
    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuAccessi, 0));

        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_COU/ANA_COU_Form.jsp";
        parent.g_Handler.New.Width = 55;
        parent.g_Handler.New.Height = 30;

        parent.g_Handler.Open = parent.g_Handler.New;

        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_COU/ANA_COU_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_COU/ANA_COU_Help.jsp";
         parent.g_Handler.dataTableOn="Y";
         parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "40%", "aTargets": [1], "sType": "string"} ,
                        {"sWidth": "30%", "aTargets": [2], "sType": "string"} ,
                        {"sWidth": "10%", "aTargets": [3], "sType": "date-eu"} ,
                        {"sWidth": "10%", "aTargets": [4], "sType": "date-eu"}]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
