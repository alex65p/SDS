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
     <version number="1.0" date="14/01/2004" author="Mike Kondratyuk">		
     <comments>

     </comments> 
     </version>
     </versions>
     </file> 
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

 <%
        IDipendenteHome home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
  %>
 
<div id="divContent">
   
    <%   String labelDipendentiAttiviCessati="";
        if (ifMsr) {
        %>
    <%@ include file="../global/generalControl_ANA_DPD.jsp" %>  
    <%@ include file="./ANA_DPD_View_TableMSR.jsp" %>     
       
    <% } else {%>
    <%@ include file="./ANA_DPD_View_Table.jsp" %>  
    <% }%>
</div>

<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0017"]);
    }
    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuAzienda, 4));
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_DPD/ANA_DPD_Form.jsp";
        parent.g_Handler.New.Width = "915px";
        parent.g_Handler.New.Height = "700px";
        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_DPD/ANA_DPD_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_DPD/ANA_DPD_Help.jsp";
       
        parent.g_Handler.dataTableOn="Y";
       <% if(ifMsr){  %>
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "7%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "25%", "aTargets": [1],    "sType": "string"},
                        {"sWidth": "23%", "aTargets": [2], "sType": "string"},
                        {"sWidth": "30%", "aTargets": [3], "sType": "string"},
                        {"sWidth": "15%", "aTargets": [4], "sType": "date-eu"}   ]   ;
        <%}%>
        <% if(!ifMsr){  %>
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "7%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "10%", "aTargets": [1], "sType":  "string" },
                        {"sWidth": "15%", "aTargets": [2], "sType": "string"},
                        {"sWidth": "15%", "aTargets": [3], "sType": "string"},
                        {"sWidth": "15%", "aTargets": [4], "sType": "string"},
                        {"sWidth": "17%", "aTargets": [5], "sType": "string"},
                        {"sWidth": "14%", "aTargets": [6], "sType": "date-eu"},
                        {"sWidth": "7%", "aTargets": [7], "sType": "string"}  ]   ;
        <%}%>    
         
    <%if (ApplicationConfigurator.isModuleEnabled(MODULES.GEST_DPD_EXT)) {%>
        parent.g_Handler.Delete.getButton().disabled = true;
    <%}%>
    }
</script>
<script>
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
