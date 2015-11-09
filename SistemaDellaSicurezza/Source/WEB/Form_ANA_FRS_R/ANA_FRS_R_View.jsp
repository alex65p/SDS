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
     <file>
     <versions>
     <version number="1.0" date="24/12/2004" author="Khomenko Juliya">
     <comments>
     <comment date="24/12/2004" author="Khomenko Juliya">
     <description>Chernovik vieW</description>
     </comment>
     <comment date="13/03/2004" author="Khomenko Juliya">
     <description>pereveden findAll -> view</description>
     </comment>
     <comment date="27/03/2004" author="Khomenko Juli">
     <description>Transform View</description>
     </comment>		
     </comments>
     </version>
     </versions>
     </file>
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/FraseR/FraseRBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/FraseR/FraseRBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("INA")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("C.C.P")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("ING")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("IRR")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("ESP")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Unico")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                Checker c = new Checker();

                //- checking for required fields		
                String strNUM_FRS_R = c.checkStringEx("Nome", request.getParameter("NOME"), false);
                String strDES_FRS_R = c.checkStringEx("Descrizione", request.getParameter("DESC"), false);
                //- checking for not required fields		

                double lVAL_INA = c.checkDouble("INA", request.getParameter("INA"), false);
                double lVAL_CCP = c.checkDouble("CCP", request.getParameter("CCP"), false);
                double lVAL_ING = c.checkDouble("ING", request.getParameter("ING"), false);
                double lVAL_IRR = c.checkDouble("IRR", request.getParameter("IRR"), false);
                double lVAL_ESP = c.checkDouble("ESP", request.getParameter("ESP"), false);
                double lVAL_UNI = c.checkDouble("UNI", request.getParameter("UNI"), false);

                if (c.isError) {
                    String err = c.printErrors();
                    out.println("<script>alert(\"" + err + "\");</script>");
                    return;
                }

                IFraseRHome home = (IFraseRHome) PseudoContext.lookup("FraseRBean");
                IFraseR FraseR;
                Collection col = home.findEx(strNUM_FRS_R, strDES_FRS_R, lVAL_INA, lVAL_CCP, lVAL_ING, lVAL_IRR, lVAL_ESP, lVAL_UNI, 0);
                Iterator it = col.iterator();
                int iCount = 0;
                while (it.hasNext()) {
                    FraseR_View view = (FraseR_View) it.next();
            %>
            <tr	class="VIEW_TR" valign="top"	INDEX="<%=view.lCOD_FRS_R%>"
                onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                <%  
                        out.println("<td>&nbsp;" + ++iCount + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(view.strNUM_FRS_R) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(view.strDES_FRS_R) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(view.strVAL_INA) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(view.strVAL_CCP) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(view.strVAL_ING) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(view.strVAL_IRR) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(view.strVAL_ESP) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(view.strVAL_UNI) + "&nbsp;</td></tr>");
                  
                 
                }
                %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                
                <th><input type="text" name="cerca_Nome" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Nome")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Descrizione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_INA" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("INA")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_C.C.P" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("C.C.P")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_ING" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("ING")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_IRR" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("IRR")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_ESP" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("ESP")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Unico" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Unico")%>" class="search_init" /></th>
            </tr>
        </tfoot>        
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }
    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuAgentiChimici, 0));

        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_FRS_R/ANA_FRS_R_Form.jsp";
        parent.g_Handler.New.Width = "750px";
        parent.g_Handler.New.Height = "340px";

        parent.g_Handler.Open = parent.g_Handler.New;

        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_FRS_R/ANA_FRS_R_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_FRS_R/ANA_FRS_R_Help.jsp";
        parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "7%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "15%", "aTargets": [1], "sType": "string"} ,  
                        {"sWidth": "33%", "aTargets": [2], "sType": "string"} ,
                        {"sWidth": "7%", "aTargets": [3], "sType": "string"},
                        {"sWidth": "7%", "aTargets": [4], "sType": "string"},
                        {"sWidth": "7%", "aTargets": [5], "sType": "string"},
                        {"sWidth": "7%", "aTargets": [6], "sType": "string"},
                         {"sWidth": "7%", "aTargets": [7], "sType": "string"},
                       {"sWidth": "10%", "aTargets": [8], "sType": "string"} ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
