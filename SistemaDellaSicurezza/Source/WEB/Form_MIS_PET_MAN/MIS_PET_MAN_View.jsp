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
    <version number="1.0" date="27/02/2004" author="Roman Chumachenko">
	      <comments>
			<comment date="27/02/2004" author="Roman Chumachenko">
				<description>MIS_PET_MAN_View.jsp</description>
			</comment>
      </comments> 
    </version>
  </versions>
</file> 
*/

response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server

%>
<%@ page import="com.apconsulting.luna.ejb.AssMisuraAttivita.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<html>
<body>
<div id="divContent">
<%
long WHE_AZL=Security.getAzienda();
IAssMisuraAttivitaHome home=(IAssMisuraAttivitaHome)PseudoContext.lookup("AssMisuraAttivitaBean");
Collection col = home.getAssMisuraAttivita_View(WHE_AZL);
Iterator it = col.iterator();
%>
	<table class="VIEW_TABLE" border=0>
	<tr class="VIEW_HEADER_TR">
		<td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</td>
		<td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Versione")%>&nbsp;</td>
		<td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione")%>&nbsp;</td>
		<td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Stato")%>&nbsp;</td>
		<td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.compilazine")%>&nbsp;</td>
		<td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione")%>&nbsp;</td>
	</tr>
<%
int i=1;
while(it.hasNext()){
	AssMisuraAttivita_View view = (AssMisuraAttivita_View)it.next();
	%>
		<tr class="VIEW_TR" valign="top" INDEX="<%=view.COD_MIS_PET_MAN%>" onclick="g_Handler.OnRowClick(this)"  ondblclick="g_Handler.OnRowDblClick(this)">
			<td>&nbsp;<%=i++%>&nbsp;</td>
			<td>&nbsp;<%=Formatter.format(view.VER_MIS_PET)%>&nbsp;</td>
			<td>&nbsp;<%=Formatter.format(view.DAT_PNZ_MIS_PET)%>&nbsp;</td>
			<td>&nbsp;<%=Formatter.format(view.STA_MIS_PET)%>&nbsp;</td>
			<td>&nbsp;<%=Formatter.format(view.DAT_CMP)%>&nbsp;</td>
			<td>&nbsp;<%=Formatter.format(view.NOM_MIS_PET)%>&nbsp;</td>
 		</tr>
	<%
}
%>
	</table>
</div>

<script>
	function OnBeforeDelete(id, tr){
		return confirm(arraylng["MSG_0016"]);
	}
	function OnViewLoad(){
			parent.g_Handler.setCaptionHTML("<%=ApplicationConfigurator.LanguageManager.getString("Elenco.misure.di.prevenzione")%>");
			parent.g_Handler.New.URL="/luna/WEB/Form_MIS_PET_MAN/MIS_PET_MAN_Form.jsp";
			parent.g_Handler.New.Width=55;
			parent.g_Handler.New.Height=25;
			parent.g_Handler.Open=parent.g_Handler.New;
			parent.g_Handler.Delete.URL="/luna/WEB/Form_MIS_PET_MAN/MIS_PET_MAN_Delete.jsp"; 
			parent.g_Handler.Delete.OnBefore=OnBeforeDelete;	
	}
</script>
<script>
	parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>


