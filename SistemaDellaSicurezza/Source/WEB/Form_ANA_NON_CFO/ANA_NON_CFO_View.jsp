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
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.NonConformita.*" %>

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
        long lINR_NON_CFO = 0;
        long lCOD_AZL = Security.getAzienda();

        Checker c = new Checker();
        String strDES_NON_CFO = c.checkStringEx("Descrizione Non Conformita", request.getParameter("DES_NON_CFO"), false);
        String strOSS_NON_CFO = c.checkStringEx("Osservazione Non Conformita", request.getParameter("OSS_NON_CFO"), false);
        java.sql.Date dtDAT_RIL_NON_CFO = c.checkDate("Data Rilievo Non Conformita", request.getParameter("DAT_RIL_NON_CFO"), false);
        String strNOM_RIL_NON_CFO = c.checkStringEx("Rilevatore Non Conformita", request.getParameter("NOM_RIL_NON_CFO"), false);
        Long lCOD_INR_ADT = null;
        if (request.getParameter("ATTACH_SUBJECT") != null) {
            if (request.getParameter("ATTACH_SUBJECT").equals("INR_NON_CFO")) {
                lCOD_INR_ADT = c.checkLongEx("Intervento Audit ID", request.getParameter("ID_PARENT"), false);
            }
        } else {
            lCOD_INR_ADT = c.checkLongEx("Intervento Audit ID", request.getParameter("COD_INR_ADT"), false);
        }
        if (c.isError) {
            String err = c.printErrors();
            out.println("<script>alert(\"" + err + "\");err=true;</script>");
            return;
        }

        INonConformitaHome home = (INonConformitaHome) PseudoContext.lookup("NonConformitaBean");
        INonConformita NonConformita;
        java.util.Collection col;
        java.util.Iterator it = null;
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
        
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
              
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
              
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione.non.conformità")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.rilievo.non.conformità")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                IAzienda azienda;
                IAziendaHome AziendaHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");

                int k = 1;

                /*
                 if (request.getParameter("ATTACH_SUBJECT") != null) {
                 if (request.getParameter("ATTACH_SUBJECT").equals("INR_NON_CFO")) {
                 lINR_NON_CFO = (new Long(request.getParameter("ID_PARENT"))).longValue();
                 col = home.getNonConformitaByInterventoAudit(lINR_NON_CFO);
                 it = col.iterator();
                 }
                 } else {
                 col = home.getNonConformita(lCOD_AZL);
                 it = col.iterator();
                 }
                 */
                col = home.findEx(strDES_NON_CFO, strOSS_NON_CFO, dtDAT_RIL_NON_CFO, strNOM_RIL_NON_CFO, lCOD_INR_ADT, 0);
                it = col.iterator();

                if (it != null) {
                    while (it.hasNext()) {
                        NonConformitaAllView w = (NonConformitaAllView) it.next();
            %>
            <tr  class="VIEW_TR" valign="top" INDEX="<%=w.lCOD_NON_CFO%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)"> 
               
                <td>&nbsp;<%=k++%>&nbsp;</td>
             
                <td>&nbsp;<%=Formatter.format(w.strDES_NON_CFO)%>&nbsp;</td>
                <td>&nbsp;<%= Formatter.format(w.dtDAT_RIL_NON_CFO)%>&nbsp;</td>
            </tr>
            <%
                    }
                }
            %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
               
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
               
                <th><input type="text" name="cerca_Descrizione.non.conformità" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Descrizione.non.conformità")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.rilievo.non.conformità" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.rilievo.non.conformità")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0023"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuVerificheSPP, 1));

        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_NON_CFO/ANA_NON_CFO_Form.jsp";
        parent.g_Handler.New.Width = 55;
        //  parent.g_Handler.New.Height="360px";
        parent.g_Handler.New.Height = "400px";

        parent.g_Handler.Open = parent.g_Handler.New;

        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_NON_CFO/ANA_NON_CFO_Delete.jsp"; //?ID=32233223
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_NON_CFO/ANA_NON_CFO_Help.jsp";
        parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "70%", "aTargets": [1], "sType": "string"},
                        {"sWidth": "20%", "aTargets": [2], "sType": "date-eu"}  ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
    //  InitView();
</script>
