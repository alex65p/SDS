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
    <version number="1.0" date="14/12/2004" author="Artur Denysenko">
	      <comments>
				  <comment date="14/12/2004" author="Artur Denysenko">
				   <description>ANA_DOC_Delete.jsp</description>
				 </comment>
      </comments>
    </version>
  </versions>
</file>
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumentiGestioneCantieri.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script>
	var err=false;
	var errDescr;
</script>

<%

Checker c = new Checker();

long ID;


String LOCAL_MODE=request.getParameter("LOCAL_MODE");

if(LOCAL_MODE!=null){
	ID=c.checkLong("Documento",request.getParameter("ID_PARENT"),true);

}
else{
		ID=c.checkLong("Documento",request.getParameter("ID"),true);
}

/*if (c.isError){
	out.println("<script>err=true;alert(\""+ c.printErrors()+"\");</script>");
	return;
}*/



try{
	if(LOCAL_MODE!=null){

		
	}
	else {
		IAnagrDocumentiGestioneCantieriHome home=(IAnagrDocumentiGestioneCantieriHome)PseudoContext.lookup("AnagrDocumentiGestioneCantieriBean");

		home.remove(new Long(ID));
	}

}
catch(Exception ex){
%>
		<script>err=true;</script>
<%
}

%>

<script>
	if (err) Alert.Error.showDelete();
	else{
			Alert.Success.showDeleted();
			<%if(LOCAL_MODE==null){%>
				parent.g_Handler.OnRefresh();
			<%} else {%>
				parent.del_localRow();
			<%}%>
	}
</script>
