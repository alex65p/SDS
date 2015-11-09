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
     <version number="1.0" date="04/02/2004" author="Alex Kyba">
     <comments>
     <comment date="04/02/2004" author="Roman Chumachenko">
     <description>Shablon formi ANA_MIS_PET_Delete.jsp</description>
     </comment>		
     </comments> 
     </version>
     </versions>
     </file> 
     */
%>
<%@ page import="com.apconsulting.luna.ejb.InterventoAudut.*" %>
<%@ page import="com.apconsulting.luna.ejb.NonConformita.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
    var err = false;
    var errDescr;
</script>
<%    Checker c = new Checker();

    long ID = 0;
    long lCOD_NON_CFO = 0;

    String LOCAL_MODE = request.getParameter("LOCAL_MODE");
    if (LOCAL_MODE != null) {
        ID = c.checkLong("Intervento Audit", request.getParameter("ID_PARENT"), true);
        if (LOCAL_MODE.equals("non_cfo")) {
            lCOD_NON_CFO = c.checkLong("Non conformita", request.getParameter("ID"), true);
        }
        if (LOCAL_MODE.equals("inter_audit")) {
            ID = c.checkLong("Intervento Audit", request.getParameter("ID"), true);
        }
    } else {
        ID = c.checkLong("Intervento Audit", request.getParameter("ID"), true);
    }

    if (c.isError) {
        out.println("<script>err=true;alert(\"" + c.printErrors() + "\");</script>");
        return;
    }

    IInterventoAudutHome home = (IInterventoAudutHome) PseudoContext.lookup("InterventoAudutBean");
    try {
        if (LOCAL_MODE != null) {
            INonConformitaHome ncHome = (INonConformitaHome) PseudoContext.lookup("NonConformitaBean");
            if (LOCAL_MODE.equals("non_cfo")) {
                ncHome.remove(new Long(lCOD_NON_CFO));
                out.print("local Non conformita  deleted");
            }
            if (LOCAL_MODE.equals("inter_audit")) {
                home.remove(new Long(ID));
                out.println("bean deleted");
            }
        } else {
            home.remove(new Long(ID));
            out.println("bean deleted");
        }
    } catch (Exception ex) {
        manageException(request, out, ex);
%><script>err = true;</script><%
    }
%>

<script>
    if (err)
    {
        Alert.Error.showDelete();
    } else {
        Alert.Success.showDeleted()
    <%if (LOCAL_MODE != null) { %>
        parent.del_localRow();

    <%} else { %>
        parent.g_Handler.OnRefresh();
    <%}%>
    }
</script>
