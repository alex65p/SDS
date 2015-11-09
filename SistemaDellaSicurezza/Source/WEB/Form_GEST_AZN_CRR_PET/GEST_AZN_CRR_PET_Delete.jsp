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
<%@ page import="com.apconsulting.luna.ejb.AzioniCorrectivePreventive.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
    var err = false;
    var stype = false;
</script>

<%
    IAzioniCorrectivePreventive AzioniCorrPrev = null;
    if (request.getParameter("ID") != null) {
        String ID_TO_DEL = request.getParameter("ID");
        IAzioniCorrectivePreventiveHome home = (IAzioniCorrectivePreventiveHome) PseudoContext.lookup("AzioniCorrectivePreventiveBean");
        Long vst_med_id = new Long(ID_TO_DEL);
        try {
            String strLocalMode = Formatter.format(request.getParameter("LOCAL_MODE"));
            if (strLocalMode.equals("doc")) {
                String strCOD_AZN_CRR_PET = Formatter.format(request.getParameter("ID_PARENT"));
                AzioniCorrPrev = home.findByPrimaryKey(new Long(strCOD_AZN_CRR_PET));
                AzioniCorrPrev.removeDOC_GEST_AZN_CRR_PET(ID_TO_DEL);
            } else {
                home.remove(vst_med_id);
                out.print("<script>stype=true;</script>");
            }
        } catch (Exception ex) {
            manageException(request, out, ex);
        }
    }
%>
<script>
    if (!err) {
        Alert.Success.showDeleted();
        if (stype) {
            parent.g_Handler.OnRefresh();
        }
        else {
            parent.del_localRow();
        }
        parent.returnValue = "OK";
    } else {
        Alert.Error.showDelete();
        parent.returnValue = "CANCEL";
    }
    /* 
     if (parent.dialogArguments){
     if (!err){	
     Alert.Success.showDeleted();
     parent.returnValue="OK"; 
     }else{
     parent.returnValue="CANCEL"; 
     }
     parent.close();
     }	
     else{
     if (!err){
     Alert.Success.showDeleted();
     if(parent.ToolBar != null){
     parent.ToolBar.OnDelete();
     }
     parent.g_Handler.OnRefresh();
     }else{
     Alert.Error.showDelete();	
     }	
     }*/
</script>

