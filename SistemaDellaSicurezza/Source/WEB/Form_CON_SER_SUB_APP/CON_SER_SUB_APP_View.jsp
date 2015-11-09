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
    Document   : CON_SER_SUB_APP_View
    Created on : 12-mag-2008, 9.08.42
    Author     : Giancarlo Servadei
--%>
<%    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.ContServSubApp.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        Checker c = new Checker();
        IContServSubAppHome home = (IContServSubAppHome) PseudoContext.lookup("ContServSubAppBean");
        IContServSubApp ContServSubApp = null;

        //  Dichiarare solo gli attributi da passare al FindEx
        long lCOD_AZL = Security.getAzienda();
        long lCOD_SRV = c.checkLong(ApplicationConfigurator.LanguageManager.getString("ID.Contratto/Servizio"), request.getParameter("lCOD_SRV"), false);

        long lCOD_DTE = c.checkLong(ApplicationConfigurator.LanguageManager.getString("ID.Fornitore.personale/servizi"), request.getParameter("lCOD_DTE"), false);
        String strRES_LOC_NOM = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Nominativo.del.responsabile"), request.getParameter("RES_LOC_NOM"), false);

        Collection col = home.findEx_SubApp(
                lCOD_AZL,
                lCOD_SRV,
                lCOD_DTE,
                strRES_LOC_NOM,
                0);
        Iterator it = col.iterator();
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
              
                <th><%=ApplicationConfigurator.LanguageManager.getString("Numero")%></th>
             
                <th><%=ApplicationConfigurator.LanguageManager.getString("Progressivo.contr./serv.")%></th>
                <th><%=ApplicationConfigurator.LanguageManager.getString("Ditta.subappaltatrice")%></th>
                <th><%=ApplicationConfigurator.LanguageManager.getString("Data.inizio.lavori")%></th>
                <th><%=ApplicationConfigurator.LanguageManager.getString("Data.fine.lavori")%></th>
                <th><%=ApplicationConfigurator.LanguageManager.getString("Descrizione.intervento")%></th>
            </tr>
        </thead>
        <tbody>
            <%
                int iCount = 0;
                while (it.hasNext()) {
                    SubApp_View view = (SubApp_View) it.next();
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=view.COD_SUB_APP%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                <%
                   
                        out.println("<td>" + ++iCount + "</td>"
                                + "<td>" + Formatter.format(view.PRO_CON) + "</td>"
                                + "<td>" + Formatter.format(view.RAG_SCL_DTE) + "</td>"
                                + "<td>" + Formatter.format(view.DAT_INI_LAV) + "</td>"
                                + "<td>" + Formatter.format(view.DAT_FIN_LAV) + "</td>"
                                + "<td>" + Formatter.format(view.INT_ASS_DES) + "</td>"
                                + "</tr>");
                     
                   
                 }
                %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
               
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
               
                <th><input type="text" name="cerca_Progressivo.contr./serv." value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Progressivo.contr./serv.")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Ditta.subappaltatrice" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Ditta.subappaltatrice")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.inizio.lavori" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.inizio.lavori")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.fine.lavori" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.fine.lavori")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Descrizione.intervento" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Descrizione.intervento")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script type="text/javascript">
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0182"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuContrattiServizi, 3));

        parent.g_Handler.New.URL = "/luna/WEB/Form_CON_SER_SUB_APP/CON_SER_SUB_APP_Form.jsp";
        parent.g_Handler.New.Width = 50;
        parent.g_Handler.New.Height = 41;

        parent.g_Handler.Open = parent.g_Handler.New;

        parent.g_Handler.Delete.URL = "/luna/WEB/Form_CON_SER_SUB_APP/CON_SER_SUB_APP_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_CON_SER_SUB_APP/CON_SER_SUB_APP_Help.jsp";
          parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "10%", "aTargets": [1], "sType": "string"},
                        {"sWidth": "20%", "aTargets": [2], "sType": "string"} ,
                        {"sWidth": "10%", "aTargets": [3], "sType": "date-eu"} ,
                        {"sWidth": "10%", "aTargets": [4], "sType": "date-eu"} ,
                        {"sWidth": "20%", "aTargets": [5], "sType": "string"}    ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
