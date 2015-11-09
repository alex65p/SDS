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
    <version number="1.0" date="05/02/2004" author="Alex Kyba">		
      <comments>
	  	<comment date="05/02/2004" author="Alex Kyba">
		   <description>Chernovik vieW</description>
		</comment>
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
<body>
<div id="divContent">
<%
Checker c = new Checker();
String err = null ;
long COD_AZL = 0;
boolean isLocalView= (request.getParameter("local")!=null);

if (c.isError){
	err = c.printErrors();
	%><script>alert("<%=err%>");</script><%
	return;
}

if (isLocalView){
	IUnitaOrganizzativa bean=null;
	IUnitaOrganizzativaHome home=(IUnitaOrganizzativaHome)PseudoContext.lookup("UnitaOrganizzativaBean");
	Collection col;
	Iterator it;
	COD_AZL = Security.getAzienda();
	//col = home.getMacchineAttrezzatureAll_View(COD_AZL);
	//it = col.iterator();
%>
	<table class="VIEW_TABLE" border=0>
	<tr class="VIEW_HEADER_TR">
		 <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                 <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Modello")%>&nbsp;</td>
                 <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Targa")%>&nbsp;</td>
                 <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Identificativo")%>&nbsp;</td>
	</tr>
<%
/*	int i=1;
	if (it!=null){
		while(it.hasNext()){
			MacchineAttrezzatureAll_View  view = (MacchineAttrezzatureAll_View)it.next();
*/		%>
		<tr class="VIEW_TR" valign="top" INDEX="<%//=Formatter.format(view.lCOD_MAC)%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
			<td style="display:none"><%//=Formatter.format(view.lCOD_MAC)%></td>
			<td><%//=Formatter.format(view.strDES_MAC)%>&nbsp;</td>
			<td><%//=Formatter.format(view.strMDL_MAC)%>&nbsp;</td>
			<td><%//=Formatter.format(view.strTAR_MAC)%>&nbsp;</td>			
			<td><%//=Formatter.format(view.strIDE_MAC)%>&nbsp;</td>			
		</tr>
	<%
		/*}
	}else{
	err=ApplicationConfigurator.LanguageManager.getString("MSG_DATI");
	
	} */ %>
	</table>
<%} %>
</div>
<script>
<% if (err!=null){%>
	alert("<%=err%>");
<%	} %>
function OnBeforeDelete(id, tr){
	return confirm(arraylng["MSG_0022"]);
}
</script>
<script>
	parent.g_Handler.New.URL="/luna/WEB/Form_ANA_UNI_ORG/ANA_UNI_ORG_Form.jsp";
	parent.g_Handler.New.Width="850px";
	parent.g_Handler.New.Height="620px";
	parent.g_Handler.setCaptionHTML("");
	parent.tblAll.style.display="none";
	parent.g_OnNew(document.all["btnNew"]);
        parent.g_Handler.Help.URL="/luna/WEB/Form_ANA_UNI_ORG/ANA_UNI_ORG_Help.jsp";
</script>


