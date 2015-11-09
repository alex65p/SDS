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
    <version number="1.0" date="05/02/2004" author="Alex Kyba">		
      <comments>
	  	<comment date="05/02/2004" author="Alex Kyba">
		   <description>Chernovik vieW</description>
		</comment>
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>


<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp"%>

<html>
<body>
<div id="divContent">
<%
Checker c = new Checker();
String err = null ;

if (c.isError){
	err = c.printErrors();
	%><script>alert("<%=err%>");</script><%
	return;
}
%>
</div>
<script>
<% if (err!=null){%>
	alert("<%=err%>");
<%}%>
</script>
<script>
	parent.g_Handler.New.URL="/luna/WEB/Form_ASS_MAN_SAP_S2S/ASS_MAN_SAP_S2S_Form.jsp";
	parent.g_Handler.New.Width="850px";
	parent.g_Handler.New.Height="620px";
	parent.g_Handler.setCaptionHTML("");
	parent.tblAll.style.display="none";
	parent.g_OnNew(document.all["btnNew"]);
        parent.g_Handler.Help.URL="/luna/WEB/Form_ASS_MAN_SAP_S2S/ASS_MAN_SAP_S2S_Help.jsp";
</script>
