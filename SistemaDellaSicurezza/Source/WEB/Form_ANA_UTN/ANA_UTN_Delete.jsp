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
     <version number="1.0" date="21/01/2004" author="Treskina Maria">
     <comments>
     <comment date="21/01/2004" author="Treskina Maria">
     <description>ydalenie ANA_UTN</description>
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
<%@ page import="com.apconsulting.luna.ejb.Utente.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
    var err=false;
    var errDescr;
</script>

<%
    Checker c = new Checker();
    IUtente utente = null;
    long ID_TO_DEL = 0;
    long lCOD_CAG_DOC = 0;
    long lCOD_TPL_DOC = 0;
    long lCOD_RUO = 0;
//String ID_TO_DEL="";
    IUtente Utente = null;
    IUtenteHome home = (IUtenteHome) PseudoContext.lookup("UtenteBean");
    String LOCAL_MODE = request.getParameter("LOCAL_MODE");
    if (LOCAL_MODE != null) {
	ID_TO_DEL = c.checkLong("Utente", request.getParameter("ID_PARENT"), true);

	if (LOCAL_MODE.equals("cag")) {
	    lCOD_CAG_DOC = c.checkLong("Categoria", request.getParameter("ID"), true);
	}
	if (LOCAL_MODE.equals("tpl")) {
	    lCOD_TPL_DOC = c.checkLong("Tipologia", request.getParameter("ID"), true);
	}
	if (LOCAL_MODE.equals("ruo")) {
	    lCOD_RUO = c.checkLong("Ruoli", request.getParameter("ID"), true);
	}
    } else {
	ID_TO_DEL = c.checkLong("Utnte", request.getParameter("ID"), true);
    }

    if (c.isError) {
	out.println("<script>err=true;alert(\"" + c.printErrors() + "\");</script>");
	return;
    }
    try {
	if (LOCAL_MODE != null) {
	    Utente = home.findByPrimaryKey(new Long(ID_TO_DEL));

	    if (lCOD_CAG_DOC != 0) {
		Utente.removeCOD_CAG_DOC(lCOD_CAG_DOC);
	    } else if (lCOD_TPL_DOC != 0) {
		Utente.removeCOD_TPL_DOC(lCOD_TPL_DOC);
	    } else if (lCOD_RUO != 0) {
		Utente.removeCOD_RUO(lCOD_RUO);
	    } else {
		throw new Exception("Invalid operation");
	    }
	} else {
	    home.remove(new Long(ID_TO_DEL));
	}
    } catch (Exception ex) {
	manageException(request, out, ex);
%>
<script>err=true;</script>
<%
    }
%>
<script>
    if (err)
    {     Alert.Error.showDelete();}
    <%
    if (LOCAL_MODE == null) {
    %>
    //else parent.g_Handler.OnRefresh();
    else{
	Alert.Success.showDeleted();
	parent.g_Handler.OnRefresh();
	//parent.ToolBar.OnDelete();
    }
    <%} else {
    %>

    else{
	parent.del_localRow();
	Alert.Success.showDeleted();
    }

    <%    }
    %>
</script>
