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

<%@ page import="com.apconsulting.luna.ejb.Presidi.*" %>
<%@ page import="com.apconsulting.luna.ejb.SchedeInterventoPSD.*" %>
<%@ page import="com.apconsulting.luna.ejb.CategoriePreside.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
//--------------------------------------------------------------------------------------

if ( "LOV_CAG".equals(request.getParameter("LOCAL_MODE")) ){
	ICategoriePreside cbean = null;
	ICategoriePresideHome chome = (ICategoriePresideHome)PseudoContext.lookup("CategoriePresideBean");

	Long ID = new Long(request.getParameter("ID"));
	cbean = chome.findByPrimaryKey(ID);
	String	strNOM_CAG_PSD_ACD = cbean.getNOM_CAG_PSD_ACD();
%>
	<script type="text/javascript">
<!--
	parent.document.all['COD_CAG_PSD_ACD'].value = "<%=Formatter.format(request.getParameter("ID"))%>";
	parent.document.all['NB_NOM_CAG_PSD_ACD'].value = "<%=Formatter.format(strNOM_CAG_PSD_ACD)%>";
// -->
	</script>
<%
}

if ( "LOV_PSD".equals(request.getParameter("LOCAL_MODE")) ){
	IPresidi pbean = null;
	IPresidiHome phome = (IPresidiHome)PseudoContext.lookup("PresidiBean");
	ICategoriePreside cbean = null;
	ICategoriePresideHome chome = (ICategoriePresideHome)PseudoContext.lookup("CategoriePresideBean");

	Long ID = new Long(request.getParameter("ID"));
	pbean = phome.findByPrimaryKey(ID);
	long COD_CAG_PSD_ACD = pbean.getCOD_CAG_PSD_ACD();
	String strIDE_PSD_ACD = pbean.getIDE_PSD_ACD();
	cbean = chome.findByPrimaryKey(new Long(COD_CAG_PSD_ACD));
	String strNOM_CAG_PSD_ACD = cbean.getNOM_CAG_PSD_ACD();
%>
	<script type="text/javascript">
<!--
	parent.document.all['COD_PSD_ACD'].value = "<%=Formatter.format(request.getParameter("ID"))%>";
	parent.document.all['COD_CAG_PSD_ACD'].value = "<%=Formatter.format(COD_CAG_PSD_ACD)%>";
	parent.document.all['NB_IDE_PSD_ACD'].value = "<%=Formatter.format(strIDE_PSD_ACD)%>";
	parent.document.all['NB_NOM_CAG_PSD_ACD'].value = "<%=Formatter.format(strNOM_CAG_PSD_ACD)%>";
// -->
	</script>
<%
}

if ( "LOV_DPD".equals(request.getParameter("LOCAL_MODE")) ){
	ISchedeInterventoPSD bean = null;
	ISchedeInterventoPSDHome home = (ISchedeInterventoPSDHome)PseudoContext.lookup("SchedeInterventoPSDBean");

	Long ID = new Long(request.getParameter("ID"));
	bean = home.findByPrimaryKey(ID);
	String strNOM_RSP_INR = bean.getNOM_RSP_INR();
%>
	<script type="text/javascript">
<!--
	parent.document.all['NB_NOM_RSP_INR'].value = "<%=Formatter.format(strNOM_RSP_INR)%>";
// -->
	</script>
<%
}
%>
