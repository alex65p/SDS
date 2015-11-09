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
    <version number="1.0" date="13/02/2004" author="Roman Chumachenko">
	      <comments>
			<comment date="13/02/2004" author="Roman Chumachenko">
				<description>RSO_MAN_View.jsp</description>
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

<%@ page import="com.apconsulting.luna.ejb.AssRischioAttivita.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<html>
<body>
<div id="divContent">
<%
//long WHE_AZL=Security.getAzienda();

IAssRischioAttivitaHome aHome=(IAssRischioAttivitaHome)PseudoContext.lookup("AssRischioAttivitaBean");
Collection col = aHome.getAssRischioAttivita_View();
Iterator it = col.iterator();
%>
	<table class="VIEW_TABLE" border=0>
	<tr class="VIEW_HEADER_TR">
		<td style="width:10%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</td>
		<td style="width:10%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nominativo.rilevatore")%>&nbsp;</td>
		<td style="width:10%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Probabilità.dell'evento.lesivo")%>&nbsp;</td>
		<td style="width:10%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Entità.del.danno")%>&nbsp;</td>
		<td style="width:10%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Stima.numerica.del.rischio")%>&nbsp;</td>
		<td style="width:10%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.rifacimento.valutazione.rischio")%>&nbsp;</td>
		<td style="width:10%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Stima.numerica.del.rischio")%>&nbsp;</td>
		<td style="width:10%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Rischio")%>&nbsp;</td>
		<td style="width:10%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Fattore.rischio")%>&nbsp;</td>
		
	</tr>
<%
int i=1;
String stat="VALUTATO";
while(it.hasNext()){
	AssRischioAttivita_View view = (AssRischioAttivita_View)it.next();
	%>
		<tr class="VIEW_TR" valign="top" INDEX="<%=view.COD_RSO_MAN%>" onclick="g_Handler.OnRowClick(this)"  ondblclick="g_Handler.OnRowDblClick(this)">
			<td>&nbsp;<%=i++%>&nbsp;</td>
			<td>&nbsp;<%=Formatter.format(view.NOM_RIL_RSO)%>&nbsp;</td>
			<td>&nbsp;<%=Formatter.format(view.PRB_EVE_LES)%>&nbsp;</td>
			<td>&nbsp;<%=Formatter.format(view.ENT_DAN)%>&nbsp;</td>
			<td>&nbsp;<%=Formatter.format(view.STM_NUM_RSO)%>&nbsp;</td>
			<td>&nbsp;<%=Formatter.format(view.DAT_RFC_VLU_RSO)%>&nbsp;</td>
			<%if( Formatter.format(view.STA_RSO).equals("R") ){stat="RIVALUTATO";}%>
			<td>&nbsp;<%=stat%>&nbsp;</td>
			<td>&nbsp;<%=Formatter.format(view.NOM_RSO)%>&nbsp;</td>
			<td>&nbsp;<%=Formatter.format(view.NOM_FAT_RSO)%>&nbsp;</td>

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
			parent.g_Handler.setCaptionHTML("<%=ApplicationConfigurator.LanguageManager.getString("Elenco.rischi/mansioni")%>");
			parent.g_Handler.New.URL="/luna/WEB/Form_RSO_MAN/RSO_MAN_Form.jsp";
			parent.g_Handler.New.Width=55;
			parent.g_Handler.New.Height=25;
			parent.g_Handler.Open=parent.g_Handler.New;
			parent.g_Handler.Delete.URL="/luna/WEB/Form_RSO_MAN/RSO_MAN_Delete.jsp"; 
			parent.g_Handler.Delete.OnBefore=OnBeforeDelete;	
	}
</script>
<script>
	parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>


