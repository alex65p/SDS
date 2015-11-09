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

<%-- 
    Document   : APP_PRO_SOS_Delete
    Created on : 26-mag-2008, 9.16.37
    Author     : Giancarlo Servadei
--%>

<%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache");        //HTTP 1.0
            response.setDateHeader("Expires", 0);          //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>
<%@ page import="com.apconsulting.luna.ejb.AppProdottiSostanze.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script type="text/javascript" src="../_scripts/Alert.js"></script>
<script type="text/javascript">
    var err=false;
</script>
<%
    IAppProdottiSostanze AppProdottiSostanze = null;
    IAnaContServ AnaContServ = null;
    String strCOD_PRO_SOS = request.getParameter("ID");
    if ( strCOD_PRO_SOS != null) {
        IAppProdottiSostanzeHome home = (IAppProdottiSostanzeHome) PseudoContext.lookup("AppProdottiSostanzeBean");
        IAnaContServHome con_ser_home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");
        try {
            long lCOD_SRV = Long.parseLong(request.getParameter("ID_PARENT"));
            long lCOD_PRO_SOS = Long.parseLong(strCOD_PRO_SOS);
            home.remove(new AppProdottiSostanzePK(lCOD_SRV, lCOD_PRO_SOS));
            
            boolean vuoto = home.getInfoOnDescProdottiSostanzeApp(lCOD_SRV);
            if (vuoto) {
                con_ser_home.deleteDescProdottiSostanzeApp(lCOD_SRV);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            out.print("<script>	Alert.Error.showDelete();err=true;</script>");
            return;
        }
    }	
%>

<script type="text/javascript">	
    if (!err){
        Alert.Success.showDeleted();
        <%
            String strDeleteFrom = request.getParameter("DELETE_FROM");
            if (strDeleteFrom != null && strDeleteFrom.equals("tab")) {
                out.println("parent.del_localRow();");
            } else {
                out.println("parent.ToolBar.OnDelete();");
            }
        %>
        }else{
        Alert.Error.showDelete();
    }	
</script>
