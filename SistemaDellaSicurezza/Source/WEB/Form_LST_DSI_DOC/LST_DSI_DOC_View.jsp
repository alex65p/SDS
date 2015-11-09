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
    <version number="1.0" date="28/01/2004" author="Artur Denysenko">		
      <comments>
			   <comment date="28/01/2004" author="Artur Denysenko">
				   <description>ANA_RSO_View.jsp</description>
			   </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_include/Checker.jsp" %>

<html>
<body>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<div id="divContent">
<%
IAnagrDocumentoHome home=(IAnagrDocumentoHome)PseudoContext.lookup("AnagrDocumentoBean");
Collection col = home.getView(Security.getAzienda());
Iterator it = col.iterator();
%>
	
	<table class="VIEW_TABLE" border=0>
	<tr class="VIEW_HEADER_TR">
		<td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</td>
                 <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Titolo.documento")%>&nbsp;</td>
                 <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("N.Documento")%>&nbsp;</td>
                 <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome.categoria.documento")%>&nbsp;</td>
	</tr>
<%
int i=1;
while(it.hasNext()){
		AnagrDocumento_View v=(AnagrDocumento_View) it.next();
	%>
		<tr 
			class="VIEW_TR" valign="top"
			INDEX="<%=v.lCOD_DOC%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)"
		>
			<td>&nbsp;<%=i++%>&nbsp;</td>
			<td>&nbsp;<%=Formatter.format(v.strTIT_DOC)%>&nbsp;</td>
			<td>&nbsp;<%=Formatter.format(v.strNUM_DOC)%>&nbsp;</td>
			<td>&nbsp;<%=Formatter.format(v.strNOM_CAG_DOC)%>&nbsp;</td>
		</tr>
	<%
}
%>
	</table>

</div>
<script>
	function OnViewLoad(){
			parent.g_Handler.setCaptionHTML("<%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.documenti/versioni")%>");
			parent.g_Handler.New.URL="/luna/WEB/Form_ANA_DOC/ANA_DOC_Form.jsp";
			parent.g_Handler.New.Width=50;
			parent.g_Handler.New.Height=45;
			parent.g_Handler.Open=parent.g_Handler.New;
			parent.g_Handler.Delete.URL="/luna/WEB/Form_ANA_DOC/ANA_DOC_Delete.jsp";
	}
</script>
<script>
	//alert("Ready")
	parent.g_Handler.OnViewChange(divContent, OnViewLoad);
	//InitView();
</script>
