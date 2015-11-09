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
     <version number="1.0" date="28/01/2004" author="Kushkarov Yura">		
     <comments>
     <comment date="28/01/2004" author="Kushkarov Yura">
     <description>SCH)EGZ_COR_View.jsp</description>
     </comment>		
     <comment date="29/03/2004" author="Khomenko Juli">
     <description>Transform View</description>
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
<%@ page import="com.apconsulting.luna.ejb.ErogazioneCorsi.*" %>

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

        //  - checking for required fields
        Long lCOD_COR = c.checkLongEx("Dati Corso", request.getParameter("COD_COR"), false);
        String strSTA_EGZ_COR = c.checkStringEx("Stato Erogazione", request.getParameter("STA_EGZ_COR"), false);            //4
        java.sql.Date dtDAT_PIF_EGZ_COR = c.checkDate("Data Pianificazione", request.getParameter("DAT_PIF_EGZ_COR"), false);        //6
        java.sql.Date dtDAT_EFT_EGZ_COR = c.checkDate("Data Inizio Erogazione", request.getParameter("DAT_EFT_EGZ_COR"), false);        //7
        String strNB_DUR_COR_GOR = c.checkStringEx("COR_DUR", request.getParameter("COR_DUR"), false);            //4
        String strNB_NOM_TPL_COR = c.checkStringEx("COR_TPL", request.getParameter("COR_TPL"), false); 
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);//4

        if (c.isError) {
            String err = c.printErrors();
            out.println("<script>alert(\"" + err + "\");err=true;</script>");
            return;
        }

        IErogazioneCorsiHome aHome = (IErogazioneCorsiHome) PseudoContext.lookup("ErogazioneCorsiBean");
        IErogazioneCorsi ErogazioneCorsi;
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
              
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Durata")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Inizio.erogazione")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                Long lCOD_AZL = new Long(Security.getAzienda());
                java.util.Collection col = aHome.findEx(lCOD_AZL, lCOD_COR, dtDAT_PIF_EGZ_COR, dtDAT_EFT_EGZ_COR, strNB_DUR_COR_GOR, strSTA_EGZ_COR, strNB_NOM_TPL_COR, 0);
                java.util.Iterator it = col.iterator();
                int iCount = 0;
                while (it.hasNext()) {
                    ErogazioneCorsiNames_View obj = (ErogazioneCorsiNames_View) it.next();
                    long var1 = obj.COD_SCH_EGZ_COR;
            %>
            <tr class="VIEW_TR" valign="top"	INDEX="<%=var1%>" onclick="g_Handler.OnRowClick(this)"  ondblclick="g_Handler.OnRowDblClick(this)">
                
                <td>&nbsp;<%=++iCount%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(obj.DUR_COR_GOR)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(obj.NOM_COR)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(obj.DAT_PIF_EGZ_COR)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(obj.DAT_EFT_EGZ_COR)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(obj.DES_COR)%>&nbsp;</td>
				
				 
            </tr>
            <%}%>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
               
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
              
                <th><input type="text" name="cerca_Durata" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Durata")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Nome" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Nome")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.pianificazione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Inizio.erogazione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Inizio.erogazione")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Descrizione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuCorsi, 2));
        parent.g_Handler.New.URL = "/luna/WEB/Form_SCH_EGZ_COR/SCH_EGZ_COR_Form.jsp";
        parent.g_Handler.New.Width = "820px";
        parent.g_Handler.New.Height = "400px";
        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_SCH_EGZ_COR/SCH_EGZ_COR_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_SCH_EGZ_COR/SCH_EGZ_COR_Help.jsp";
         parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "10%", "aTargets": [1], "sType": "string"} ,  
                        {"sWidth": "30%", "aTargets": [2], "sType": "date-eu"} ,
                        {"sWidth": "10%", "aTargets":  [3], "sType": "date-eu"},
                        {"sWidth": "10%", "aTargets":  [4], "sType": "date-eu"},
                        {"sWidth": "30%", "aTargets": [5], "sType": "string"}  ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
