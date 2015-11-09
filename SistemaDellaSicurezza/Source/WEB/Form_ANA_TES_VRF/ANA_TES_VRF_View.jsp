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
     <version number="1.0" date="24/01/2004" author="Malyuk Sergey">
     <comments>
     <comment date="24/01/2004" author="Malyuk Sergey">
     <description></description>
     </comment>		
     <comment date="29/01/2004" author="Mike Kondratyuk">
     <description>Peredelal na FindEX()</description>
     </comment>
     </comments> 
     </version>
     </versions>
     </file> 
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/TestVerifica/TestVerificaBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TestVerifica/TestVerificaBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table border="0" class="VIEW_TABLE">
        <thead>
            <tr class="VIEW_HEADER_TR">
           
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome.test")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione.test")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Punteggio.minimo")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Punteggio.massimo")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                Checker c = new Checker();

                String strNOM_TES_VRF = c.checkStringEx("Nome", request.getParameter("Nome"), false);
                String strDES_TES_VRF = c.checkStringEx("Descrizione", request.getParameter("DESC"), false);
                Long lNUM_MIN_PTG = c.checkLongEx("MIN", request.getParameter("MIN"), false);
                Long lNUM_MAX_PTG = c.checkLongEx("Periodicita Visita", request.getParameter("MAX"), false);

                if (c.isError) {
                    String err = c.printErrors();
                    out.println("<script>alert(\"" + err + "\");</script>");
                    return;
                }

                ITestVerificaHome home = (ITestVerificaHome) PseudoContext.lookup("TestVerificaBean");
                ITestVerifica TestVerifica;

                //java.util.Collection col = home.getTestVerificaNames_View();
                java.util.Collection col = home.findEx(strNOM_TES_VRF, strDES_TES_VRF, lNUM_MIN_PTG, lNUM_MAX_PTG, 0);
                java.util.Iterator it = col.iterator();
                int nCount = 0;
                while (it.hasNext()) {
                    TestVerificaNames_View obj = (TestVerificaNames_View) it.next();
            %>		<tr class="VIEW_TR" valign="top" INDEX="<%=obj.COD_TES_VRF%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                
            <%
              out.println("<td>&nbsp;" + ++nCount + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.NOM_TES_VRF) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.DES_TES_VRF) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.NUM_MIN_PTG) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.NUM_MAX_PTG) + "&nbsp;</td></tr>");
				
         	   
                 }
                %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
             
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
              
                <th><input type="text" name="cerca_Nome.test" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Nome.test")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Descrizione.test" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Descrizione.test")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Punteggio.minimo" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Punteggio.minimo")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Punteggio.massimo" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Punteggio.massimo")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0028"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuTestVerifica, 0));

        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_TES_VRF/ANA_TES_VRF_Form.jsp";
        parent.g_Handler.New.Width = "820px";
        parent.g_Handler.New.Height = "550px";

        parent.g_Handler.Open = parent.g_Handler.New;

        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_TES_VRF/ANA_TES_VRF_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_TES_VRF/ANA_TES_VRF_Help.jsp";
           parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "40%", "aTargets": [1], "sType": "string"} ,  
                        {"sWidth": "30%", "aTargets": [2], "sType": "string"} ,
                        {"sWidth": "10%", "aTargets":  [3], "sType": "string"},
                        {"sWidth": "10%", "aTargets":  [4], "sType": "string"} ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
    //  InitView();
</script>


