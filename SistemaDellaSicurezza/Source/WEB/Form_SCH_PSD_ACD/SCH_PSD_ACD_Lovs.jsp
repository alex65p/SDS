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
    <version number="1.0" date="09/03/2004" author="Pogrebnoy Yura">		
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
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.Presidi.*" %>
<%@ page import="com.apconsulting.luna.ejb.SchedeInterventoPSD.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>


<%@ include file="../src/com/apconsulting/luna/ejb/Presidi/PresidiBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/Presidi/PresidiBean.jsp" %>

<%@ include file="SCH_PSD_ACD_Util.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/CategoriaDocumento/CategoriaDocumentoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/CategoriaDocumento/CategoriaDocumentoBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
<body>
<div id="divContent">
<%
	String caption = "";
	ICategoriePresideHome chome = (ICategoriePresideHome)PseudoContext.lookup("CategoriePresideBean");
	IPresidiHome phome = (IPresidiHome)PseudoContext.lookup("PresidiBean");
	ISchedeInterventoPSDHome dhome = (ISchedeInterventoPSDHome)PseudoContext.lookup("SchedeInterventoPSDBean");
%>
<table border="0" class="VIEW_TABLE">
<%
if ( "LOV_CAG".equals(request.getParameter("LOCAL_MODE")) ){
  String strNOM_CAG_PSD_ACD = request.getParameter("NOM_CAG_PSD_ACD");
	long COD_AZL = new Long (request.getParameter("COD_AZL")).longValue();

	out.print( Build_CAG_Lov(chome,COD_AZL,strNOM_CAG_PSD_ACD) );
	caption = ApplicationConfigurator.LanguageManager.getString("Elenco.categorie.presidi");
}

if ( "LOV_PSD".equals(request.getParameter("LOCAL_MODE")) ){
  String strNOM_CAG_PSD_ACD = request.getParameter("NOM_CAG_PSD_ACD");
	String strIDE_PSD_ACD = request.getParameter("IDE_PSD_ACD");
	long COD_AZL      = new Long (request.getParameter("COD_AZL")).longValue();
	long COD_PSD_ACD  = new Long (request.getParameter("COD_PSD_ACD")).longValue();
	long COD_CAG_PSD_ACD = new Long (request.getParameter("COD_CAG_PSD_ACD")).longValue();

	out.print( Build_PSD_Lov(phome,COD_AZL,COD_CAG_PSD_ACD,COD_PSD_ACD,strNOM_CAG_PSD_ACD,strIDE_PSD_ACD) );
	caption = ApplicationConfigurator.LanguageManager.getString("Elenco.presidi.antincendio");
}

if ( "LOV_DPD".equals(request.getParameter("LOCAL_MODE")) ){
	String WHE_IN_AZL = request.getParameter("COD_AZL");
	long COD_PSD_ACD  = new Long (request.getParameter("COD_PSD_ACD")).longValue();

	out.print( Build_DPD_Lov(dhome, COD_PSD_ACD, WHE_IN_AZL) );
	caption = ApplicationConfigurator.LanguageManager.getString("Elenco.responsabili");
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
	parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
</body>
</html>
