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

<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
//------------------------------------------------------------------------------------

if ( "LOV_MAC".equals(request.getParameter("LOCAL_MODE")) ){
	IMacchina bean = null;
	IMacchinaHome home = (IMacchinaHome)PseudoContext.lookup("MacchinaBean");

	Long ID = new Long(request.getParameter("ID"));
	bean = home.findByPrimaryKey(new MacchinaPK(Security.getAzienda(), ID.longValue()) );
	String	strNOM_MAC = bean.getIDE_MAC();
	String  strDES_MAC = bean.getDES_MAC();
%>
	<script type="text/javascript">
<!--
	parent.document.all['COD_MAC'].value = "<%=Formatter.format(request.getParameter("ID"))%>"; 
	parent.document.all['NOM_MAC'].value = "<%=Formatter.format(strNOM_MAC)%>";
	parent.document.all['DES_MAC'].value = "<%=Formatter.format(strDES_MAC)%>"; 
// -->
	</script>
<%
}
%>
