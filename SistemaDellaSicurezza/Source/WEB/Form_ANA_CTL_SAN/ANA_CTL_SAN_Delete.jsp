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
<%@ page import="com.apconsulting.luna.ejb.CartelleSanitarie.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script>
    var err = false;</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
    long ID = 0;
    long ID_PARENT = 0;
    String LOCAL_MODE = null;
    if (request.getParameter("LOCAL_MODE") != null) {
        LOCAL_MODE = request.getParameter("LOCAL_MODE");
    }
    ICartelleSanitarieHome home = (ICartelleSanitarieHome) PseudoContext.lookup("CartelleSanitarieBean");
    Checker c = new Checker();
    if (request.getParameter("LOCAL_MODE") != null) {
        ID_PARENT = c.checkLong("ANA_CTL_SAN", request.getParameter("ID_PARENT"), true);
        if (LOCAL_MODE.equals("DOC")) {
            ID = c.checkLong("Documenti", request.getParameter("ID"), true);
        }
        if (LOCAL_MODE.equals("PRO_SAN")) {
            ID = c.checkLong("Protocolle Sanitarie", request.getParameter("ID"), true);
        }
    } else {
        ID = c.checkLong("Controlle Sanitarie", request.getParameter("ID"), true);
    }
    if (c.isError) {
        out.println("<script>err=true;alert(\"" + c.printErrors() + "\");</script>");
        return;
    }

    try {
        if (request.getParameter("LOCAL_MODE") != null) {
            ICartelleSanitarie bean = home.findByPrimaryKey(new Long(ID_PARENT));

            if (LOCAL_MODE.equals("DOC")) {
                bean.removeCOD_DOC(ID);
            }

            if (LOCAL_MODE.equals("PRO_SAN")) {
                bean.removeCOD_PRO_SAN(ID);
            }
        } else {
            home.remove(new Long(ID));
        }
    } catch (Exception ex) {
        manageException(request, out, ex);
    }
%>

<script>
            if (err)
    {
    }
    <%
        if (request.getParameter("LOCAL_MODE") != null) {
    %>
    //else parent.g_Handler.OnRefresh();
    else
    {
    Alert.Success.showDeleted();
            parent.del_localRow();
    }
    <%} else {
    %>
    else{
    Alert.Success.showDeleted();
            parent.g_Handler.OnRefresh();
            //parent.ToolBar.OnDelete();
    }
    <%    }
    %>
</script>
