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
            Document   : ANA_CON_SER_View
            Created on : 24-apr-2008, 12.04.18
            Author     : Giancarlo Servadei
--%>

<%    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>

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
        IAnaContServHome home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");
        IAnaContServ AnaContServ = null;

        long lCOD_AZL = Security.getAzienda();

        String strPRO_CON = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Progressivo.contratto/servizio"), request.getParameter("PRO_CON"), false);
        String strDES_CON = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Descrizione"), request.getParameter("DES_CON"), false);
        String strRIF_CON = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Riferimento.contratto"), request.getParameter("RIF_CON"), false);
        long lCOD_UNI_ORG = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Servizio.responsabile"), request.getParameter("COD_UNI_ORG"), false);
        java.sql.Date dtDAT_INI_LAV = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.inizio.lavori"), request.getParameter("DAT_INI_LAV"), false);
        java.sql.Date dtDAT_FIN_LAV = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.fine.lavori"), request.getParameter("DAT_FIN_LAV"), false);
        String strORA_LAV = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Orario.di.lavoro"), request.getParameter("ORA_LAV"), false);
        long lAPP_COD_DTE = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Ditta.appaltatrice"), request.getParameter("APP_COD_DTE"), false);
        String strLAV_NOT = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Lavoro.notturno"), request.getParameter("LAV_NOT"), false);
        int iNUM_LAV_PRE = c.checkInt(ApplicationConfigurator.LanguageManager.getString("N.ro.lavoratori.in.cantiere"), request.getParameter("NUM_LAV_PRE"), false);

        Collection col = home.findEx_AnaContServ(
                lCOD_AZL,
                strPRO_CON,
                strDES_CON,
                strRIF_CON,
                lCOD_UNI_ORG,
                dtDAT_INI_LAV,
                dtDAT_FIN_LAV,
                strORA_LAV,
                strLAV_NOT,
                iNUM_LAV_PRE,
                lAPP_COD_DTE,
                1);
        Iterator it = col.iterator();
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
               
                <th><%=ApplicationConfigurator.LanguageManager.getString("Numero")%></th>
              
                <th><%=ApplicationConfigurator.LanguageManager.getString("Progressivo.contr./serv.")%></th>
                <th><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%></th>
                <th><%=ApplicationConfigurator.LanguageManager.getString("Ditta.appaltatrice")%></th>
                <th><%=ApplicationConfigurator.LanguageManager.getString("Data.inizio.lavori")%></th>
                <th><%=ApplicationConfigurator.LanguageManager.getString("Data.fine.lavori")%></th>
            </tr>
        </thead>
        <tbody>
            <%
                int iCount = 0;
                while (it.hasNext()) {
                    AnaContServ_View view = (AnaContServ_View) it.next();
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=view.COD_SRV%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">        
              
                <%  
                                out.println("<td>" + ++iCount + "</td>"
                                + "<td>" + Formatter.format(view.PRO_CON) + "</td>"
                                + "<td>" + Formatter.format(view.DES_CON) + "</td>"
                                + "<td>" + Formatter.format(view.RAG_SCL_DTE) + "</td>"
                                + "<td>" + Formatter.format(view.DAT_INI_LAV) + "</td>"
                                + "<td>" + Formatter.format(view.DAT_FIN_LAV) + "</td>"
                                + "</tr>");
                 }
                %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                  
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
              
                <th><input type="text" name="cerca_Progressivo.contr./serv." value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Progressivo.contr./serv.")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Descrizione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Ditta.appaltatrice" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Ditta.appaltatrice")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.inizio.lavori" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.inizio.lavori")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.fine.lavori" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.fine.lavori")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0182"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuContrattiServizi, 0));

        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_CON_SER/ANA_CON_SER_Form.jsp";
        parent.g_Handler.New.Width = 50;
        parent.g_Handler.New.Height = 41;

        parent.g_Handler.Open = parent.g_Handler.New;

        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_CON_SER/ANA_CON_SER_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_CON_SER/ANA_CON_SER_Help.jsp";
        parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "10%", "aTargets": [1], "sType": "date-eu"},
                        {"sWidth": "30%", "aTargets": [2], "sType": "string"} ,
                        {"sWidth": "30%", "aTargets": [3], "sType": "string"} ,
                        {"sWidth": "10%", "aTargets": [4], "sType": "date-eu"} ,
                        {"sWidth": "10%", "aTargets": [5], "sType": "date-eu"}   ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
