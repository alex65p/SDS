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
     <version number="1.0" date="30/12/2004" author="Mike Kondratyuk">		
     <comments>
     <comment date="30/12/2004" author="Mike Kondratyuk">
     <description>AZN_CRR_PET_View.jsp</description>
     </comment>		
     <comment date="01/02/2004" author="Alexey Kolesnik">
     <description>Adopted to new form AZN_CRR_PET</description>
     </comment>		
     <comment date="02/03/2004" author="Roman Chumachenko">
     <description>Remake to new requirements (Home View)</description>
     </comment>	
     <comment date="17/03/2004" author="Podmasteriev Alexandr">
     <description>Vse peredelal soglasno ishodniku</description>
     </comment>		
     <comment date="29/03/2004" author="Malyuk Sergey">
     <description> Peredelka view
     </description>	
     </comments> 
     </version>
     </versions>
     </file> 
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AzioniCorrectivePreventive.*" %>

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
        Checker c = new Checker();

        Long lCOD_INR_ADT = c.checkLongEx(ApplicationConfigurator.LanguageManager.getString("Descrizione.intervento.d'audit"), request.getParameter("COD_INR_ADT"), false);
        String strDES_AZN_RCH = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Azione.richiesta"), request.getParameter("DES_AZN_RCH"), false);
        String strRCH_AZN_CRR_PET = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Richiesta.di"), request.getParameter("RCH_AZN_CRR_PET"), false);
        java.sql.Date dtDAT_RCH = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.richiesta"), request.getParameter("DAT_RCH"), false);

        IAzioniCorrectivePreventiveHome home = (IAzioniCorrectivePreventiveHome) PseudoContext.lookup("AzioniCorrectivePreventiveBean");
        //  java.util.Collection col = home.getAzioniCorrectivePreventive_View();
        long lCOD_AZL = Security.getAzienda();

        Collection col = home.findEx(lCOD_AZL, lCOD_INR_ADT, strDES_AZN_RCH, strRCH_AZN_CRR_PET, dtDAT_RCH, 0);
        java.util.Iterator it = col.iterator();
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Richiesta")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.richiesta")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Attivazione")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azione")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.azione")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione.intervento.d'audit")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                int i = 0;
                while (it.hasNext()) {
                    AzioniCorrectivePreventive_View view = (AzioniCorrectivePreventive_View) it.next();
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=view.COD_AZN_CRR_PET%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                
                <td>&nbsp;<%=++i%>&nbsp;</td>
              
                <td>&nbsp;<%if ("C".equals(view.RCH_AZN_CRR_PET)) {
                        out.print("AZIONE CORRETTIVA");
                    }
                    if ("P".equals(view.RCH_AZN_CRR_PET)) {
                        out.print("AZIONE PREVENTIVA");
                    }%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.DAT_RCH)%>&nbsp;</td>
                <td>&nbsp;<%if ("U".equals(view.TPL_ATT)) {
                        out.print("ATTIVATA CON URGENZA");
                    }
                    if ("R".equals(view.TPL_ATT)) {
                        out.print("RIMANDATA");
                    }
                    if ("E".equals(view.TPL_ATT)) {
                        out.print("RESPINTA");
                    }
                    if ("N".equals(view.TPL_ATT)) {
                        out.print("NON ATTIVATA");
                    }%>&nbsp;</td>
                <td>&nbsp;<%if ("C".equals(view.TPL_AZN)) {
                        out.print("CONCLUSA EFFICACEMENTE");
                    }
                    if ("R".equals(view.TPL_AZN)) {
                        out.print("NON RISOLTA");
                    }
                    if ("S".equals(view.TPL_AZN)) {
                        out.print("SOSPESA");
                    }
                    if ("N".equals(view.TPL_AZN)) {
                        out.print("NESSUNA");
                    }%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.DAT_AZN)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.DES_INR_ADT)%>&nbsp;</td>
            </tr>
            <%}%>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
               
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
              
                <th><input type="text" name="cerca_Richiesta" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Richiesta")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.richiesta" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.richiesta")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Attivazione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Attivazione")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Azione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Azione")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.azione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.azione")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Descrizione.intervento.d'audit" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Descrizione.intervento.d'audit")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuVerificheSPP, 3));
        parent.g_Handler.New.URL = "/luna/WEB/Form_AZN_CRR_PET/AZN_CRR_PET_Form.jsp";
        parent.g_Handler.New.Width = 56;
        parent.g_Handler.New.Height = 35;
        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_AZN_CRR_PET/AZN_CRR_PET_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_AZN_CRR_PET/AZN_CRR_PET_Help.jsp";
          parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "20%", "aTargets": [1], "sType": "string"},
                        {"sWidth": "10%", "aTargets": [2], "sType": "date-eu"},
                        {"sWidth": "10%", "aTargets": [3], "sType": "string"},
                        {"sWidth": "20%", "aTargets": [4], "sType": "string"},
                        {"sWidth": "10%", "aTargets": [5], "sType": "date-eu"},
                        {"sWidth": "20%", "aTargets": [6], "sType": "string"}  ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
