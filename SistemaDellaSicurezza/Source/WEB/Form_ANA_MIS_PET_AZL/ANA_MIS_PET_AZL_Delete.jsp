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
     <description>Shablon formi ANA_MIS_PET_AZL_Delete.jsp</description>
     </comment>		
     </comments> 
     </version>
     </versions>
     </file> 
     */
%>
<%@ page import="com.apconsulting.luna.ejb.MisurePreventProtettiveAz.*" %>

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
    IMisurePreventProtettiveAz bean = null;
    long ID = 0;
    long lCOD_DOC = 0;
    long lCOD_NOR_SEN = 0;

    String LOCAL_MODE = request.getParameter("LOCAL_MODE");
    if (LOCAL_MODE != null) {
        ID = c.checkLong("MISURA PREVENTIVA", request.getParameter("ID_PARENT"), true);
        if (LOCAL_MODE.equals("doc")) {
            lCOD_DOC = c.checkLong("Documento", request.getParameter("ID"), true);
        }
        if (LOCAL_MODE.equals("nor")) {
            lCOD_NOR_SEN = c.checkLong("Normativa sentenza", request.getParameter("ID"), true);
        }
    } else {
        ID = c.checkLong("Misura preventiva", request.getParameter("ID"), true);
    }

    if (c.isError) {
        out.println("<script>err=true;alert(\"" + c.printErrors() + "\");</script>");
        return;
    }
    IMisurePreventProtettiveAzHome home = (IMisurePreventProtettiveAzHome) PseudoContext.lookup("MisurePreventProtettiveAzBean");
    try {
        if (LOCAL_MODE != null) {
            bean = home.findByPrimaryKey(new Long(ID));
            if (LOCAL_MODE.equals("doc")) {
                bean.deleteDocument(lCOD_DOC);
                out.print("local doc deleted");
            }
            if (LOCAL_MODE.equals("nor")) {
                bean.deleteNormativa(lCOD_NOR_SEN);
                out.println("local normativa deleted");
            }
        } else {
            home.remove(new Long(ID));
            out.println("bean deleted");
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
    if (err) {
        if (divErr)
            Alert.Error.showDelete();//alert(divErr.innerText);
    }
    else {
        Alert.Success.showDeleted()
    <% 		if (LOCAL_MODE != null) { %>
        parent.del_localRow();

    <% } else { %>
        parent.g_Handler.OnRefresh();
    <% }%>
    }
</script>
