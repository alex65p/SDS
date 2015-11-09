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
     <version number="1.0" date="30/01/2004" author="Khomenko Juli">
     <comments>
     <comment date="30/01/2004" author="Khomenko Juli">
     <description>Create ANA_MAN_Delete.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.Presidi.*" %>
<%@ page import="com.apconsulting.luna.ejb.SchedeInterventoPSD.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
            var err = false;
            var errDescr;</script>

<%
    Checker c = new Checker();
    IPresidi Presidi = null;
    IPresidiHome home = (IPresidiHome) PseudoContext.lookup("PresidiBean");
    ISchedeInterventoPSDHome Schhome = (ISchedeInterventoPSDHome) PseudoContext.lookup("SchedeInterventoPSDBean");
    Long pre_id = null;
    long ID = 0;
    long lCOD_DOC = 0;
    long lCOD_SCH_PSD = 0;
    String LOCAL_MODE = request.getParameter("LOCAL_MODE");
    if (LOCAL_MODE != null) {
        ID = c.checkLong("Presedi ID", request.getParameter("ID_PARENT"), true);

        if (LOCAL_MODE.equals("d")) {
            lCOD_DOC = c.checkLong("Documento", request.getParameter("ID"), true);
        }
        if (LOCAL_MODE.equals("s")) {
            lCOD_SCH_PSD = c.checkLong("Schede Intervento", request.getParameter("ID"), true);
        }
    } else {
        String ID_TO_DEL = request.getParameter("ID");
        pre_id = new Long(ID_TO_DEL);
    }

    if (c.isError) {
        out.println("<script>err=true;alert(\"" + c.printErrors() + "\");</script>");
        return;
    }

    try {
        if (LOCAL_MODE != null) {
            Presidi = home.findByPrimaryKey(new Long(ID));

            if (lCOD_DOC != 0) {
                Presidi.removeCOD_DOC(lCOD_DOC);
            } else if (lCOD_SCH_PSD != 0) {
                Schhome.remove(new Long(lCOD_SCH_PSD));
            } else {
                throw new Exception("Invalid operation");
            }
        } else {
            home.remove(pre_id);
        }
    } catch (Exception ex) {
        manageException(request, out, ex);
%>
<script>err = true;</script>
<%
    }
%>
<script>
            if (err)
            Alert.Error.showDelete();
    <%
        if (LOCAL_MODE == null) {
    %>
    //else parent.g_Handler.OnRefresh();
    else{
    Alert.Success.showDeleted();
            parent.g_Handler.OnRefresh();
            //parent.ToolBar.OnDelete();
    }
    <%
    } else {
    %>

    else{
    parent.del_localRow();
            Alert.Success.showDeleted();
    }

    <%
        }
    %>
</script>
