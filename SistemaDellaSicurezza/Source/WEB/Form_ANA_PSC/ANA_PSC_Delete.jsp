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
    Document   : ANA_PSC_Delete
    Created on : 12-apr-2011, 10.08.17
    Author     : Alessandro
--%>

<%@ page import="com.apconsulting.luna.ejb.PSC.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script>var err=false;</script>

<%
    if (request.getParameter("ID") != null) {
        String COD_PSC_DEL = request.getParameter("ID");
        IPSCHome home = (IPSCHome) PseudoContext.lookup("PSCBean");
        Long lCOD_PSC = new Long(COD_PSC_DEL);
        try {
            home.remove(lCOD_PSC);
        } catch (Exception ex) {
            out.print("<script>err=true;Alert.Error.showDelete();</script>");
            return;
        }
    } else {
        out.print("<script>err=true;</script>");
    }
%>
<script>
    if (err) Alert.Error.showDelete();
    else {
        Alert.Success.showDeleted();
        //parent.g_Handler.OnRefresh();
        parent.ToolBar.OnDelete();
    }
</script>
