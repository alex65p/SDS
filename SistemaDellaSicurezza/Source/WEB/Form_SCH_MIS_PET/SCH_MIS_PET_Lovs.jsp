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
    <version number="1.0" date="02/03/2004" author="Alexey Kolesnik">		
      <comments>
								Template Created
      </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.MisuraPreventiva.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="SCH_MIS_PET_Util.jsp" %>

<html>
<body>
<div id="divContent">
<%
	String caption = "";
	IMisuraPreventivaHome MisuraHome=(IMisuraPreventivaHome)PseudoContext.lookup("MisuraPreventivaBean");
%>
<table border="0" class="VIEW_TABLE">
<%
if ("LOV_MIS_PET".equals(request.getParameter("LOCAL_MODE")))
{
	out.print(BuildMisuraLOV(MisuraHome, Security.getAzienda()));
	caption = ApplicationConfigurator.LanguageManager.getString("Elenco.misure.di.prevenzione");
}

if ("LOV_MIS_PET_LUO_MAN".equals(request.getParameter("LOCAL_MODE")))
{
	String strCOD_AZL = request.getParameter("COD_AZL");
	if ("L".equals(request.getParameter("TYPE")))
	{
  	out.print(BuildMisuraLuoLOV(MisuraHome, strCOD_AZL));
  	caption = ApplicationConfigurator.LanguageManager.getString("Elenco.luoghi.fisici");
	} else {
  	out.print(BuildMisuraManLOV(MisuraHome, strCOD_AZL));
  	caption = ApplicationConfigurator.LanguageManager.getString("Elenco.attività.lavorative");
	}
}

if ("LOV_RSO".equals(request.getParameter("LOCAL_MODE")))
{
	String strCOD_AZL = request.getParameter("COD_AZL");
	String strType = request.getParameter("TYPE");
	out.print(BuildRischiLOV(MisuraHome, strCOD_AZL, strType));
	caption = ApplicationConfigurator.LanguageManager.getString("Elenco.rischi");
}
%>
</table>

</div>

<script language="JavaScript" type="text/javascript">
<!--
	function OnViewLoad(){
		parent.g_Handler.setCaptionHTML("<%=caption%>");
	}
//-->
</script>
<script>
	parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>


