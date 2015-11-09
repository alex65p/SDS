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

<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
//----------------------------------------------------------------------------------

if ( "LOV_RSO".equals(request.getParameter("LOCAL_MODE")) ){
	IRischio bean = null;
	IRischioHome home = (IRischioHome)PseudoContext.lookup("RischioBean");
	Long ID = new Long(request.getParameter("ID"));
	bean = home.findByPrimaryKey(new RischioPK(Security.getAzienda(), ID.longValue()));
	String	strNOM_RSO = bean.getNOM_RSO();
	String  strCLF_RSO = bean.getCLF_RSO();
%>
	<script type="text/javascript">
<!--
	parent.document.all['COD_RSO'].value = "<%=Formatter.format(request.getParameter("ID"))%>"; 
	parent.document.all['NOM_RSO'].value = "<%=Formatter.format(strNOM_RSO)%>";
	parent.document.all['CLF_RSO'].value = "<%=Formatter.format(strCLF_RSO)%>"; 
// -->
	</script>
<%
}
%>
