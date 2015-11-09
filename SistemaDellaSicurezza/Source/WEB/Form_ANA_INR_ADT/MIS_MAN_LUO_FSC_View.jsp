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
    <version number="1.0" date="02/03/2004" author="Alex Kyba">
      <comments>
				  <comment date="02/03/2004" author="Alex Kyba">
				   <description>vieW</description>
				 </comment>
      </comments>
    </version>
  </versions>
</file>
*/
%>
<%@ page import="com.apconsulting.luna.ejb.InterventoAudut.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp"%>

<html>
    <head>
       <title><%=ApplicationConfigurator.LanguageManager.getString("Elenco.misure.di.prevenzione")%></title>
    </head>
    <body>
<div id="divContent">
<%
Checker c = new Checker();
String err = null ;
long lCOD_AZL = Security.getAzienda();
String viewType = c.checkString("",request.getParameter("vType"),true);
String strNOM_MIS_PET =  request.getParameter("NOM_MIS_PET");//c.checkString("", request.getParameter("NOM_MIS_PET"), false);
String customHeader = "";
if (c.isError){
	err = c.printErrors();
	%><script>alert("<%=err%>");</script><%
	return;
}

	IInterventoAudut bean=null;
	IInterventoAudutHome home=(IInterventoAudutHome)PseudoContext.lookup("InterventoAudutBean");

	Collection col;
	Iterator it;


	if (viewType.equals("LUO_FSC")){
		col = home.getMisurePreventiveAllByLuogo(lCOD_AZL, strNOM_MIS_PET);
		customHeader=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico");
	}
	else{
		col= home.getMisurePreventiveAllByAttivita(lCOD_AZL, strNOM_MIS_PET);
		customHeader=ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa");
	}
	it = col.iterator();
%>

        
         <table class="VIEW_TABLE" border=0>
	<tr class="VIEW_HEADER_TR">
		<td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione")%>&nbsp;</td>
		<td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.audit")%>&nbsp;</td>
		<td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Rischio")%>&nbsp;</td>
		<td>&nbsp;<%= customHeader %>&nbsp;</td>
	</tr>
<%
	int i=1;
	if (it!=null){
		while(it.hasNext()){
			MisuraPreventivaView view = (MisuraPreventivaView)it.next();
		%>
		<tr
			class="VIEW_TR" valign="top"
			INDEX="<%if (viewType.equals("LUO_FSC")) out.print(Formatter.format(view.lCOD_MIS_RSO_LUO)); else out.print(Formatter.format(view.lCOD_MIS_PET_MAN));%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)"
		>
			<td>&nbsp;<%=Formatter.format(view.strNOM_MIS_PET)%>&nbsp;</td>
			<td>&nbsp;<%=Formatter.format(view.dtDAT_PNZ_MIS_PET)%>&nbsp;</td>
			<td>&nbsp;<%=Formatter.format(view.strNOM_RSO)%>&nbsp;</td>
			<td>&nbsp;
				<% if (viewType.equals("LUO_FSC")){
					out.println(Formatter.format(view.strNOM_LUO_FSC));
				}
				else{
					out.println(Formatter.format(view.strNOM_MAN));
				}
				%>
			&nbsp;</td>
		</tr>
	<%
		}
	}else{
	err=ApplicationConfigurator.LanguageManager.getString("MSG_DATI");

	} %>
	</table>
</div>
<script>
	<% if (err!=null){%>
		alert("<%=err%>");
	<%	} %>
	function OnBeforeDelete(id, tr){
		return confirm(arraylng["MSG_0022"]);
	}
	function OnViewLoad(){
			parent.g_Handler.New.URL="/luna/WEB/Form_ANA_INR_ADT/ANA_INR_ADT_Form.jsp";
			parent.g_Handler.New.Width="850px";
			parent.g_Handler.New.Height="670px";
			parent.g_Handler.setCaptionHTML("<%=ApplicationConfigurator.LanguageManager.getString("Elenco.misure.di.prevenzione")%>");
			parent.g_Handler.Open=parent.g_Handler.New;
			parent.g_Handler.Delete.URL="/luna/WEB/Form_ANA_INR_ADT/ANA_INR_ADT_Delete.jsp"; //?ID=32233223
			parent.g_Handler.Delete.OnBefore=OnBeforeDelete;
	}
</script>
<script>
	parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>


