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
     <version number="1.0" date="16/02/2004" author="Roman Chumachenko">
     <comments>
     <comment date="16/02/2004" author="Roman Chumachenko">
     <description>RSO_MAN_Delete.jsp</description>
     </comment>	
     </comments> 
     </version>
     </versions>
     </file> 
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server

%>
<%@ page import="com.apconsulting.luna.ejb.AssRischioAttivita.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script>
    var err = false;
</script>
<%    if (request.getParameter("ID") != null) {
        String ID_TO_DEL = request.getParameter("ID");
        IAssRischioAttivitaHome home = (IAssRischioAttivitaHome) PseudoContext.lookup("AssRischioAttivitaBean");
        Long id = new Long(ID_TO_DEL);
        try {
            home.remove(id);
        } catch (Exception ex) {
            manageException(request, out, ex);
        }
    } else {
        out.print("<script>err=true;</script>");
    }
%>
<script>
    if (parent.dialogArguments) {
        if (!err) {
            Alert.Success.showDeleted();
            parent.returnValue = "OK";
        } else {
            parent.returnValue = "CANCEL";
        }
        parent.close();
    }
    else {
        if (!err) {
            Alert.Success.showDeleted();
            if (parent.ToolBar != null) {
                parent.ToolBar.OnDelete();
            }
            parent.g_Handler.OnRefresh();
        } else {
            Alert.Error.showDelete();
        }
    }
</script>
