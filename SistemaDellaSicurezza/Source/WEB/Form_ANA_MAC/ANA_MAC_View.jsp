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
     <version number="1.0" date="05/02/2004" author="Alex Kyba">		
     <comments>
     <comment date="05/02/2004" author="Alex Kyba">
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
<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        Checker c = new Checker();
        String err = null;
        //long lCOD_AZL=Security.getAzienda();

        long COD_AZL = 0;

        String strIDE_MAC = c.checkStringEx("Iden", request.getParameter("IDE_MAC"), false);
        String strDES_MAC = c.checkStringEx("Descrizione", request.getParameter("DES_MAC"), false);
        String strMDL_MAC = c.checkStringEx("Modello", request.getParameter("MDL_MAC"), false);
        String strDIT_CST_MAC = c.checkStringEx("DIT_CST_MAC", request.getParameter("DIT_CST_MAC"), false);
        String strFBR_MAC = c.checkStringEx("Fabbrica", request.getParameter("FBR_MAC"), false);
        Long lYEA_CST_MAC = c.checkLongEx("Anno", request.getParameter("YEA_CST_MAC"), false);
        String strTAR_MAC = c.checkStringEx("Targa", request.getParameter("TAR_MAC"), false);
        String strPPO_MAC = c.checkStringEx("Proprietario", request.getParameter("PPO_MAC"), false);
        String strMRC_MAC = c.checkStringEx("Marcatura", request.getParameter("MRC_MAC"), false);
        Long lPRT_MAC = c.checkLongEx("Portata", request.getParameter("PRT_MAC"), false);
        String strCAT_MAC = c.checkStringEx("Catalogazione", request.getParameter("CAT_MAC"), false);
        String strPRE_MAC = c.checkStringEx("Pressione", request.getParameter("PRE_MAC"), false);
        Long lCOD_TPL_MAC = c.checkLongEx("Tipologia", request.getParameter("COD_TPL_MAC"), false);

        if (c.isError) {
            err = c.printErrors();
    %><script>alert("<%=err%>");</script><%
            return;
        }

        IMacchina bean = null;
        IMacchinaHome home = (IMacchinaHome) PseudoContext.lookup("MacchinaBean");
        Collection col;
        Iterator it;
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);

        COD_AZL = Security.getAzienda();
        //col = home.getMacchineAttrezzatureAll_View(COD_AZL);
        col = home.findEx(COD_AZL, strIDE_MAC, strDES_MAC, strMDL_MAC, strDIT_CST_MAC, strFBR_MAC, lYEA_CST_MAC, strTAR_MAC, strPPO_MAC, strMRC_MAC, lPRT_MAC, strCAT_MAC, strPRE_MAC, lCOD_TPL_MAC, 0);
        it = col.iterator();
    %>
    
    
    
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                <th style="display:none">&nbsp;</th>
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>    
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Modello")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Targa")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Identificativo")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                int i = 1;
                if (it != null) {
                    while (it.hasNext()) {
                        MacchineAttrezzatureAll_View view = (MacchineAttrezzatureAll_View) it.next();
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=Formatter.format(view.lCOD_MAC)%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)"	>
                 <td>&nbsp;<%=i++%>&nbsp;</td>
                <td style="display:none"><%=Formatter.format(view.lCOD_MAC)%></td>
                <td>&nbsp;<%=Formatter.format(view.strDES_MAC)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.strMDL_MAC)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.strTAR_MAC)%>&nbsp;</td>			
                <td>&nbsp;<%=Formatter.format(view.strIDE_MAC)%>&nbsp;</td>			
            </tr>
            <%
                    }
                } else {
                    err = ApplicationConfigurator.LanguageManager.getString("MSG_DATI");

                }%>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                <th style="display:none"><input type="text" name="cerca_lCOD_MAC" value="Cerca lCOD_MAC" class="search_init" /></th>
            
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
               
                <th><input type="text" name="cerca_Descrizione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Modello" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Modello")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Targa" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Targa")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Identificativo" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Identificativo")%>" class="search_init" /></th>
            </tr>
        </tfoot>        
    </table>
</div>
<script>
    <% if (err != null) {%>
    alert("<%=err%>");
    <%	} %>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }
    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuMacchinari, 1));
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_MAC/ANA_MAC_Form.jsp";
        parent.g_Handler.New.Width = "850px";
        parent.g_Handler.New.Height = "450px";
        //  parent.g_Handler.New.Height="580px";

        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_MAC/ANA_MAC_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_MAC/ANA_MAC_Help.jsp";
        parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "30%", "aTargets": [1], "sType": "string"} ,  
                        {"sWidth": "30%", "aTargets": [2], "sType": "string"} ,
                        {"sWidth": "20%", "aTargets": [3], "sType": "string"},
                        {"sWidth": "10%", "aTargets": [4], "sType": "string"},
                        {"sWidth": "10%", "aTargets": [5], "sType": "string"}]   ;
        
    }

    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
    <%if (Security.isExtendedMode()) {%>
    parent.g_Handler.Delete.getButton().disabled = true;
    <%}%>
</script>


