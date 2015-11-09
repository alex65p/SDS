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
    <version number="1.0" date="02/03/2004" author="Mike Kondratyuk">		
      <comments>

      </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AssMisuraAttivita.*" %>
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.MisurePreventive.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.MisurePreventProtettiveAz.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="SCH_MIS_PET_AZL_Util.jsp" %>
<html>
<body>
<div id="divContent">
<%
	String caption = "";
	IMisurePreventProtettiveAzHome MisureHome=(IMisurePreventProtettiveAzHome)PseudoContext.lookup("MisurePreventProtettiveAzBean");
	IAssMisuraAttivitaHome MisureManHome=(IAssMisuraAttivitaHome)PseudoContext.lookup("AssMisuraAttivitaBean");
	IMisurePreventiveHome MisureLuoFscHome=(IMisurePreventiveHome)PseudoContext.lookup("MisurePreventiveBean");
	IRischioHome RischioHome=(IRischioHome)PseudoContext.lookup("RischioBean");
%>
<table border="0" class="VIEW_TABLE">
<%
if ("LOV_MIS_PET".equals(request.getParameter("LOCAL_MODE")))
{
	out.print(BuildMisureLOV(MisureHome, request.getParameter("APL_A")));
	caption = ApplicationConfigurator.LanguageManager.getString("Elenco.misure.di.prevenzione");
}
if ("LOV_MIS_PET_LUO_FSC".equals(request.getParameter("LOCAL_MODE")))
{
	out.print(BuildMisureLuoFscLOV(MisureLuoFscHome, request.getParameter("COD_AZL")));
	caption = ApplicationConfigurator.LanguageManager.getString("Elenco.misure.di.prevenzione.legate.ai.luoghi.fisici");
}
if ("LOV_MIS_PET_MAN".equals(request.getParameter("LOCAL_MODE")))
{
	out.print(BuildMisureManLOV(MisureManHome, request.getParameter("COD_AZL")));
	caption = ApplicationConfigurator.LanguageManager.getString("Elenco.misure.di.prevenzione.legate.alla.mansione");
}
if ("LOV_NOM_RSO".equals(request.getParameter("LOCAL_MODE")))
{
	long lCOD_AZL = new Long(request.getParameter("COD_AZL")).longValue();
	String strAPL_A = request.getParameter("APL_A");
	long lCOD_MIS_PET_LUO_MAN = new Long(request.getParameter("COD_MIS_PET_LUO_MAN")).longValue();

	out.print(BuildRischiLOV(RischioHome, lCOD_AZL, strAPL_A, lCOD_MIS_PET_LUO_MAN));
	caption = ApplicationConfigurator.LanguageManager.getString("Elenco.rischi");
}
%>
</table>

</div>

<script>
	function OnViewLoad(){
		parent.g_Handler.setCaptionHTML("<%=caption%>");
	}
</script>

<script>
	//alert("Ready")
	parent.g_Handler.OnViewChange(divContent, OnViewLoad);
	//InitView();
</script>

</body>
</html>

