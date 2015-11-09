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
     <version number="1.0" date="21/01/2004" author="Treskina Maria">
     <comments>

     <comment date="27/03/2004" author="Yuriy Kushkarov">
     <description>Change View for new Search (findEx)</description>
     </comment>
     <comment date="21/01/2004" author="Treskina Maria">
     <description>Chernovik vieW</description>
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
<%@ page import="com.apconsulting.luna.ejb.Utente.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border=0>
        <thead>
            <tr class="VIEW_HEADER_TR">
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Matricola")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nominativo")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Userid")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.attivazione")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.disattivazione")%>&nbsp;</th>
                <th><%=ApplicationConfigurator.LanguageManager.getString("Stato.utenza")%></th>
            </tr>
        </thead>
        <tbody>
            <%
                Checker c = new Checker();
                IUtenteHome home = (IUtenteHome) PseudoContext.lookup("UtenteBean");
                IUtente Utente = null;

                long lCOD_AZL = Security.getAzienda();
                String strUSD_UTN = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Userid"), request.getParameter("USER_ID"), false);
                String strPSW_UTN = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Password"), request.getParameter("PASSWORD"), false);
                String strSTA_UTN = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Stato.utenza"), request.getParameter("STATO"), false);
                Long COD_DPD = c.checkLongEx(ApplicationConfigurator.LanguageManager.getString("Dipendente"), request.getParameter("COD_DPD"), false);
                java.sql.Date dDAT_ATT = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.attivazione"), request.getParameter("DATA_ATT"), false);
                java.sql.Date dDAT_DIS = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.disattivazione"), request.getParameter("DATA_DIS"), false);

                /*if (c.isError)
                 {
                 String err = c.printErrors();
                 out.println("<script>alert(\""+err+"\");</script>");
                 return;
                 }*/
                long lCOD_DPD = 0;
                if (COD_DPD != null) {
                    lCOD_DPD = COD_DPD.longValue();
                }
                //out.print (lCOD_DPD); 
                int k = 1;
                Collection col = home.findEx(lCOD_AZL, lCOD_DPD, strUSD_UTN, strSTA_UTN, dDAT_ATT, dDAT_DIS, 1);
                Iterator it = col.iterator();
                while (it.hasNext()) {
                    findEx_utn view = (findEx_utn) it.next();
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=view.COD_UTN%>" 
                onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
              
                <td>&nbsp;<%=k++%>&nbsp;</td>
              
                <td>&nbsp;<%=Formatter.format(view.MTR_DPD)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.COG_DPD) + " " + Formatter.format(view.NOM_DPD)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.USD_UTN)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.DAT_ATT)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.DAT_DIS)%>&nbsp;</td>
                <td>&nbsp;<%if ("A".equals(view.STA_UTN)) {
                        out.print("ATTIVO");
                    } else {
                        out.print("DISATTIVO");
                    }%>&nbsp;</td>
            </tr>
            <%
                }
            %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
               
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                
                <th><input type="text" name="cerca_Matricola" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Matricola")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Nominativo" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Nominativo")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Userid" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Userid")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.attivazione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.attivazione")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.disattivazione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.disattivazione")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Stato.utenza" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Stato.utenza")%>" class="search_init" /></th>
            </tr>
        </tfoot>        
    </table>
</div>

<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0030"]);
    }
    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuAccessi, 1));
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_UTN/ANA_UTN_Form.jsp";
        parent.g_Handler.New.Width = 55;
        parent.g_Handler.New.Height = "460px";
        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_UTN/ANA_UTN_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_UTN/ANA_UTN_Help.jsp";
         parent.g_Handler.dataTableOn="Y";
         parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "7%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "10%", "aTargets": [1], "sType": "string"} ,
                        {"sWidth": "23%", "aTargets": [2], "sType": "string"} ,
                        {"sWidth": "10%", "aTargets": [3], "sType": "string"} ,
                        {"sWidth": "10%", "aTargets": [4], "sType": "date-eu"},
                         {"sWidth": "10%", "aTargets": [5], "sType": "date-eu"},
                        {"sWidth": "20%", "aTargets": [6], "sType": "string"}]   ;
    }
</script>
<script>
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
