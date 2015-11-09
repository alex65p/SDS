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
     <version number="1.0" date="11/02/2004" author="Mike Kondratyuk">
     <comments>
     <comment date="11/02/2004" author="Mike Kondratyuk">
     <description>Chernovik vieW</description>
     </comment>
     <comment date="27/03/2004" author="Treskina Maria">
     <description>Search</description>
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
<%@ page import="com.apconsulting.luna.ejb.AssociativaAgentoChimico.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        Checker c = new Checker();
        String strNOM_COM_SOS = c.checkStringEx("Nome sostanza/preparato", request.getParameter("NOM_COM_SOS"), false);
        String strDES_SOS = c.checkStringEx("Descrizione", request.getParameter("DES_SOS"), false);
        String strSIM_RIS = c.checkStringEx("Simbolo", request.getParameter("SIM_RIS"), false);
        Long lCOD_STA_FSC = c.checkLongEx("Stato Fisic", request.getParameter("COD_STA_FSC"), false);
        Long lCOD_SIM = c.checkLongEx("Descrizione Simbolo", request.getParameter("COD_SIM"), false);
        Long lCOD_CLF_SOS = c.checkLongEx("Classificazione", request.getParameter("COD_CLF_SOS"), false);
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);

        IAssociativaAgentoChimicoHome home = (IAssociativaAgentoChimicoHome) PseudoContext.lookup("AssociativaAgentoChimicoBean");
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
              
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome.sostanza")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Simbolo.risorsa")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Stato.fisico")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Classificazione")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                //  java.util.Collection col = home.getSOS_CHI_View();
                java.util.Collection col = home.findEx(strNOM_COM_SOS, strDES_SOS, strSIM_RIS, lCOD_STA_FSC, lCOD_SIM, lCOD_CLF_SOS, 0);

                java.util.Iterator it = col.iterator();
                int iCount = 1;
                while (it.hasNext()) {
                    SOS_CHI_View AssociativaAgentoChimico = (SOS_CHI_View) it.next();
            %>		<tr class="VIEW_TR" valign="top" INDEX="<%=AssociativaAgentoChimico.COD_SOS_CHI%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
               
              
                <td><%=iCount++%></td>
                <%  out.println("<td>&nbsp;" + Formatter.format(AssociativaAgentoChimico.NOM_COM_SOS) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(AssociativaAgentoChimico.SIM_RIS) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(AssociativaAgentoChimico.DES_STA_FSC) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(AssociativaAgentoChimico.DES_CLF_SOS) + "&nbsp;</td></tr>");
                 
                 }
                %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                 
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                
                <th><input type="text" name="cerca_Nome.sostanza" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Nome.sostanza")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Simbolo.risorsa" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Simbolo.risorsa")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Stato.fisico" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Stato.fisico")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Classificazione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Classificazione")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuAgentiChimici, 3));
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_SOS_CHI/ANA_SOS_CHI_Form.jsp";
        parent.g_Handler.New.Width = "880px";
        parent.g_Handler.New.Height = "540px";
        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_SOS_CHI/ANA_SOS_CHI_Delete.jsp"; //?ID=32233223
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_SOS_CHI/ANA_SOS_CHI_Help.jsp";
        parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "20%", "aTargets": [1], "sType": "string"} ,  
                        {"sWidth": "15%", "aTargets": [2], "sType": "string"} ,
                        {"sWidth": "20%", "aTargets": [3], "sType": "string"},
                       {"sWidth": "35%", "aTargets": [3], "sType": "string"}]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
    //  InitView();
</script>
