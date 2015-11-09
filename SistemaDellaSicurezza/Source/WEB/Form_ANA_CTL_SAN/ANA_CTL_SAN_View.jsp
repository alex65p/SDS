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

<%    /*
     <file>
     <versions>	
     <version number="1.0" date="14/01/2004" author="Mike Kondratyuk">		
     <comments>

     </comments> 
     </version>
     </versions>
     </file> 
     */
    response.setHeader("Cache-Control", "no-cache");  //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.CartelleSanitarie.*" %>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<%
    boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    String labelDipendentiAttiviCessati="";
    if (ifMsr) {
       
        IDipendenteHome home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
%>
   <%@ include file="../global/generalControl_ANA_DPD.jsp" %>
<% }  %>

<div id="divContent">
    <table border="0" class="VIEW_TABLE">
        <thead>
            <tr class="VIEW_HEADER_TR">

               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>    
              
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Cognome.dipendente")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome.dipendente")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Matricola.dipendente")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.creazione.cartella.sanitaria")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Medico.responsabile")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                Checker c = new Checker();
                java.sql.Date datDAT_CRE_CTL_SAN = c.checkDate("Data", request.getParameter("DAT_CRE_CTL_SAN"), false);
                String strNOM_MED_RSP_CTL_SAN = c.checkStringEx("Medico Competente", request.getParameter("NOM_MED_RSP_CTL_SAN"), false);
                Long lCOD_DPD = c.checkLongEx("Dipendente", request.getParameter("COD_DPD"), false);
                long lCOD_AZL = Security.getAzienda();

                if (c.isError) {
                    String err = c.printErrors();
                    out.println("<script>alert(\"" + err + "\");</script>");
                    return;
                }

                ICartelleSanitarieHome home = (ICartelleSanitarieHome) PseudoContext.lookup("CartelleSanitarieBean");
                ICartelleSanitarie CartelleSanitarie;

                java.util.Collection col = home.findEx(lCOD_AZL, datDAT_CRE_CTL_SAN, strNOM_MED_RSP_CTL_SAN, lCOD_DPD, 0);
                java.util.Iterator it = col.iterator();
                int i = 1;
                while (it.hasNext()) {
                    CTL_SAN_All_View obj = (CTL_SAN_All_View) it.next();
            %>		<tr class="VIEW_TR" valign="top" INDEX="<%=obj.COD_CTL_SAN%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">

             
                <td>&nbsp;<%=i++%>&nbsp;</td>
                <%  
                        out.println("<td>&nbsp;" + Formatter.format(obj.COG_DPD) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.NOM_DPD) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.MTR_DPD) + "&nbsp;</td><td>&nbsp;"
                                +(ifMsr? Formatter.formatYYYYMMDD(obj.DAT_CRE_CTL_SAN) :Formatter.format(obj.DAT_CRE_CTL_SAN))+ "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.NOM_MED_RSP_CTL_SAN) + "&nbsp;</td></tr>");
                    }
                %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
 
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                 
                <th><input type="text" name="cerca_Cognome.dipendente" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Cognome.dipendente")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Nome.dipendente" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Nome.dipendente")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Matricola.dipendente" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Matricola.dipendente")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.creazione.cartella.sanitaria" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.creazione.cartella.sanitaria")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Medico.responsabile" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Medico.responsabile")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
    <%  if (ifMsr) {%>
    <div id="divContentFooter">
        <label ><%=labelDipendentiAttiviCessati%></label>
    </div>  
    <% }%>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0019"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuVerificheSanitarie, 2));
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_CTL_SAN/ANA_CTL_SAN_Form.jsp";
        parent.g_Handler.New.Width = 48;
        parent.g_Handler.New.Height = 33;
        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_CTL_SAN/ANA_CTL_SAN_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_CTL_SAN/ANA_CTL_SAN_Help.jsp";
          parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "20%", "aTargets": [1], "sType": "string"} ,  
                        {"sWidth": "20%", "aTargets": [2], "sType": "string"} ,
                        {"sWidth": "15%", "aTargets":  [3], "sType": "string"} ,
                        {"sWidth": "15%", "aTargets":  [4], "sType": "date-eu"}, 
                        {"sWidth": "20%", "aTargets":  [5], "sType": "string"} ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
