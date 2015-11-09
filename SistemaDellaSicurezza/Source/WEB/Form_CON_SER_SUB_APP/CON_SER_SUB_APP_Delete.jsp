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
    Document   : CON_SER_SUB_APP_Delete
    Created on : 13-mag-2008, 9.38.51
    Author     : Giancarlo Servadei
--%>

<%    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.ContServSubApp.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script type="text/javascript" src="../_scripts/Alert.js"></script>
<script language="JavaScript"type="text/javascript">
    var err = false;
</script>

<%
    if (request.getParameter("ID") != null) {
        IContServSubAppHome home = (IContServSubAppHome) PseudoContext.lookup("ContServSubAppBean");
        Long COD_SUB_APP = Long.parseLong(request.getParameter("ID"));
        try {
            home.remove(COD_SUB_APP);
        } catch (Exception ex) {
            manageException(request, out, ex);
        }
    }
%>
<script type="text/javascript">
    if (!err) {
        Alert.Success.showDeleted();
    <%
        String strDeleteFrom = request.getParameter("DELETE_FROM");
        if (strDeleteFrom != null && strDeleteFrom.equals("tab")) {
            out.println("parent.del_localRow();");
        } else {
            out.println("parent.ToolBar.OnDelete();");
        }
    %>
    } else {
        Alert.Error.showDelete();
    }
</script>
