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
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AssociativaAgentoChimico.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<html>
<body>
<div id="divContent">
<%
Checker c = new Checker();
String strNOM_COM_SOS=c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Nome.sostanza/preparato"),request.getParameter("NOM_COM_SOS"),false);
String strDES_SOS=c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_SOS"),false); 
long lCOD_CLF_SOS=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Classificazione"),request.getParameter("DES_CLF_SOS"),false);   
long lCOD_STA_FSC=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Stato.fisico"),request.getParameter("DES_STA_FSC"),false);   
if (c.isError){
	String err = c.printErrors();
	%><script>alert("<%=err%>");</script><%
	return;
}
IAssociativaAgentoChimicoHome aHome=(IAssociativaAgentoChimicoHome)PseudoContext.lookup("AssociativaAgentoChimicoBean");
Collection col = aHome.findEx(strNOM_COM_SOS, strDES_SOS, lCOD_STA_FSC, lCOD_CLF_SOS, 1);
Iterator it = col.iterator();
%>
	
	<table class="VIEW_TABLE" border=0>
	<tr class="VIEW_HEADER_TR">
		<td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</td>
		<td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome.sostanza")%>&nbsp;</td>
		<td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Simbolo.risorsa")%>&nbsp;</td>
	</tr>
<%
int i=1;
while(it.hasNext()){
	findEx_AssAgentiChimichi  view = (findEx_AssAgentiChimichi)it.next();
	%>
	<tr class="VIEW_TR" valign="top" INDEX="<%=view.COD_SOS_CHI%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
		<td>&nbsp;<%=i++%>&nbsp;</td>
		<td>&nbsp;<%=Formatter.format(view.NOM_COM_SOS)%>&nbsp;</td>
		<td>&nbsp;<%=Formatter.format(view.SIM_RIS)%>&nbsp;</td>
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
			parent.g_Handler.setCaptionHTML("<%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.agenti.chimici")%>");
			parent.g_Handler.New.URL="/luna/WEB/Form_SOS_CHI_OPE_SVO/SOS_CHI_OPE_SVO_Form.jsp";
			parent.g_Handler.New.Width=55;
			parent.g_Handler.New.Height=25;
			parent.g_Handler.Open=parent.g_Handler.New;
			parent.g_Handler.Delete.URL="/luna/WEB/Form_SOS_CHI_OPE_SVO/SOS_CHI_OPE_SVO_Delete.jsp"; 
			parent.g_Handler.Delete.OnBefore=OnBeforeDelete;
                         parent.g_Handler.Help.URL="/luna/WEB/Form_SOS_CHI_OPE_SVO/SOS_CHI_OPE_SVO_Help.jsp";
	}
</script>
<script>
	parent.g_Handler.OnViewChange(divContent, OnViewLoad);
	//InitView();
</script>


