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

<%    response.setHeader("Cache-Control", "no-cache");         //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        Checker c = new Checker();

        String strRAG_SCL_AZL = c.checkStringEx("Azienda", request.getParameter("AZIENDA"), false);
        String strDES_ATI_SVO_AZL = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Attività.svolta"), request.getParameter("ATTIVITA_SVOLTA"), false);
        String strIDZ_AZL = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Indirizzo"), request.getParameter("INDIRIZZO"), false);
        String strCIT_AZL = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Città"), request.getParameter("CITTA"), false);
        String strCAG_AZL = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Categoria"), request.getParameter("CATEGORIA"), false);
        String strNUM_CIC_AZL = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Numero.civico"), request.getParameter("NCIVOCO"), false);
        String strPRV_AZL = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Provincia"), request.getParameter("PROVINCIA"), false);
        String strCAP_AZL = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("C.a.p."), request.getParameter("CAP"), false);
        String strQLF_RSP_AZL = c.checkStringEx("Qualifica", request.getParameter("QUALIFICA"), false);
        String strNOM_RSP_AZL = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro"), request.getParameter("DATORE"), false);
        String strNOM_RSP_SPP_AZL = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Responsabile.S.P.P."), request.getParameter("RESPONSABLE"), false);
        String strNOM_MED_AZL = c.checkStringEx("Medico", request.getParameter("MEDICO"), false);
        Short sMOD_CLC_RSO = c.checkShortEx("Modalità di calcolo del rischio", request.getParameter("MOD_CLC_RSO"), false);
        String strCOD_FIS_AZL = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Codice.fiscale"), request.getParameter("COD_FIS_AZL"), false);
        String strPAR_IVA_AZL = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Partita.iva"), request.getParameter("PAR_IVA_AZL"), false);

        IAziendaHome aHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");
        java.util.ArrayList WHE_IN_AZL = Security.getAziende();

        Collection col = aHome.findEx(WHE_IN_AZL, strCAG_AZL, strDES_ATI_SVO_AZL, strRAG_SCL_AZL, strIDZ_AZL, strNUM_CIC_AZL, strCIT_AZL, strPRV_AZL, strCAP_AZL, strQLF_RSP_AZL, strNOM_RSP_AZL, strNOM_RSP_SPP_AZL, strNOM_MED_AZL, sMOD_CLC_RSO, strCOD_FIS_AZL, strPAR_IVA_AZL);
        Iterator it = col.iterator();
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border="0" cellspacing="2" cellpadding="2">
        <thead>
            <tr class="VIEW_HEADER_TR">
              
                <th><%=ApplicationConfigurator.LanguageManager.getString("Numero")%></th>
              
                <th><%=ApplicationConfigurator.LanguageManager.getString("Azienda")%></th>
                <th><%=ApplicationConfigurator.LanguageManager.getString("Indirizzo.azienda")%></th>
                <th><%=ApplicationConfigurator.LanguageManager.getString("Città")%></th>
                <th><%=ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro")%></th>
                <th><%=ApplicationConfigurator.LanguageManager.getString("Responsabile.S.P.P.")%></th>
            </tr>
        </thead>
        <tbody>
            <%
                int i = 1;
                while (it.hasNext()) {
                    findEx_azl view = (findEx_azl) it.next();
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=view.COD_AZL%>" onclick="g_Handler.OnRowClick(this)"  ondblclick="g_Handler.OnRowDblClick(this)">
              
                <td><%=i++%></td>
              
                <td><%=Formatter.format(view.RAG_SCL_AZL)%></td>
                <td><%=Formatter.format(view.IDZ_AZL)%></td>
                <td><%=Formatter.format(view.CIT_AZL)%></td>
                <td><%=Formatter.format(view.NOM_RSP_AZL)%></td>
                <td><%=Formatter.format(view.NOM_RSP_SPP_AZL)%></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuAzienda, 0));
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_AZL/ANA_AZL_Form.jsp";
        parent.g_Handler.New.Width = 51;
        parent.g_Handler.New.Height = 40;
        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_AZL/ANA_AZL_Delete.jsp"; //?ID=32233223
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_AZL/ANA_AZL_Help.jsp";
           
        parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "7%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "23%", "aTargets": [1], "sType": "string"} ,
                        {"sWidth": "25%", "aTargets": [2], "sType": "string"} ,
                        {"sWidth": "10%", "aTargets": [3], "sType": "string"} ,
                        {"sWidth": "25%", "aTargets": [4], "sType": "string"} ,
                        {"sWidth": "25%", "aTargets": [5], "sType": "string"} ]   ;
    <%
        if (Security.isUser()) { %>
        parent.g_Handler.New.getButton().disabled = true;
        parent.g_Handler.Delete.getButton().disabled = true;
    <%  }%>
    }
</script>
<script>
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
