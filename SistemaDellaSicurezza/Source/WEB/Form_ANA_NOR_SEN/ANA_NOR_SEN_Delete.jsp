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
     <version number="1.0" date="27/01/2004" author="Alexey Kolesnik">
     <comments>
     <comment date="27/01/2004" author="Alexey Kolesnik">
     <description> Shablon formi ANA_NOR_SEN_Delete.jsp </description>
     </comment>
     <comment date="30/01/2004" author="Treskina Maria">
     <description> Podpravleno ydalenie: dobavlena obrabotka oshibok </description>
     </comment>
     <comment date="31/01/2004" author="Alexey Kolesnik">
     <description> Added new toolbar </description>
     </comment>
     <comment date="04/02/2004" author="Alexey Kolesnik">
     <description> Rebiuld for new UI (TabBar) </description>
     </comment>
     <comment date="04/02/2004" author="Treskina Maria">
     <description> Rebiuld for delete from tabs </description>
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
<%@ page import="com.apconsulting.luna.ejb.NormativeSentenze.*" %>

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

    long ID;
    long lCOD_DOC = 0;

    String LOCAL_MODE = request.getParameter("LOCAL_MODE");
    if (LOCAL_MODE != null) {
        ID = c.checkLong("Tipologia DPI", request.getParameter("ID_PARENT"), true);
        if (LOCAL_MODE.equals("d")) {
            lCOD_DOC = c.checkLong("Documento", request.getParameter("ID"), true);
        }
    } else {
        ID = c.checkLong("Normative Sentanze", request.getParameter("ID"), true);
    }

    if (c.isError) {
        out.println("<script>err=true;alert(\"" + c.printErrors() + "\");</script>");
        return;
    }

    INormativeSentenze normative = null;
    INormativeSentenzeHome home = (INormativeSentenzeHome) PseudoContext.lookup("NormativeSentenzeBean");

    try {
        if (LOCAL_MODE != null) {
            normative = home.findByPrimaryKey(new Long(ID));
            if (lCOD_DOC != 0) {
                normative.removeCOD_DOC(lCOD_DOC);
            } else {
                throw new Exception("Invalid operation");
            }
        } else {
            home.remove(new Long(ID));
        }
    } catch (Exception ex) {
        manageException(request, out, ex);
%>
<div id="divErr">
    <%=ex.getMessage()%>
</div>
<script>err = true;</script>
<%
    }
%>
<script>
            if (err)   Alert.Error.showDelete();
            // 	alert(divErr.innerText);

    <%
        if (LOCAL_MODE == null) {
    %>
    else{
    Alert.Success.showDeleted();
            parent.g_Handler.OnRefresh();
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
