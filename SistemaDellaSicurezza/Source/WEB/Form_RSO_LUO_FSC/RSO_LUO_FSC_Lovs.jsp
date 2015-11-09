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
    <version number="1.0" date="12/03/2004" author="Alexey Kolesnik">		
      <comments>
								Template Created
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>

<html>
<body>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="RSO_LUO_FSC_Util.jsp" %>

<div id="divContent">
<%
	String caption = "";
	IRischioHome RischioHome=(IRischioHome)PseudoContext.lookup("RischioBean");
%>
<table border="0" class="VIEW_TABLE">
<%
if ("LOV_RSO".equals(request.getParameter("LOCAL_MODE")))
{
	long lCOD_AZL = new Long(request.getParameter("COD_AZL")).longValue();
	long lCOD_FAT_RSO = new Long(request.getParameter("COD_FAT_RSO")).longValue();
	out.print(BuildRischiLOV(RischioHome, lCOD_AZL, lCOD_FAT_RSO));
	caption = ApplicationConfigurator.LanguageManager.getString("Elenco.rischi");
}
%>
</table>

</div>

<script type="text/javascript">
<!--
	function OnViewLoad(){
		parent.g_Handler.setCaptionHTML("<%=caption%>");
	}
//-->
</script>
<script>
	parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>


