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
    <version number="1.0" date="19/02/2004" author="Khomenko Juliya">
      <comments>
				  <comment date="19/02/2004" author="Khomenko Juliya">
				   <description>Create vieW</description>
				 </comment>
				  <comment date="13/03/2004" author="Khomenko Juliya">
				   <description>pereveden findAll -> view</description>
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
<html>
<body>
<%@ include file="../src/com/apconsulting/luna/ejb/TitoliStudio/TitoliStudioBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TitoliStudio/TitoliStudioBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<div id="divContent">

<%
ITitoliStudioHome home=(ITitoliStudioHome)PseudoContext.lookup("TitoliStudioBean");
ITitoliStudio TitoliStudio;

long lCOD_AZL = Security.getAzienda();

Collection col = home.getTitoliStudio_View(lCOD_AZL);
Iterator it = col.iterator();

%>

	<table class="VIEW_TABLE" border=0>
	<tr class="VIEW_HEADER_TR">
		<td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</td>
                 <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%>&nbsp;</td>
                 <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
	</tr>
<%

 int iCount=0;
 while(it.hasNext()){
     TitoliStudio_View view = (TitoliStudio_View)it.next();
%>		<tr
			class="VIEW_TR" valign="top"
			INDEX="<%=view.COD_TIT_STU_SPC%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)"
		>
<%
	out.println("<td>&nbsp;"+ ++iCount +"&nbsp;</td><td>&nbsp;"+
								 Formatter.format(view.NOM_TIT_STU_SPC)+"&nbsp;</td><td>&nbsp;"+
								 Formatter.format(view.DES_TIT_STU_SPC)+"&nbsp;</td></tr>");
  }
%>

	</table>

</div>

<script>

	function OnBeforeDelete(id, tr){
		return confirm(arraylng["MSG_0016"]);
	}
	function OnViewLoad(){
			//alert("Loaded!!")

			parent.g_Handler.setCaptionHTML("<%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.titoli.di.studio")%>");

			parent.g_Handler.New.URL="/luna/WEB/Form_ANA_PNO/ANA_PNO_Form.jsp";
			parent.g_Handler.New.Width=45;
			parent.g_Handler.New.Height=15;

			parent.g_Handler.Open=parent.g_Handler.New;

			parent.g_Handler.Delete.URL="/luna/WEB/Form_ANA_PNO/ANA_PNO_Delete.jsp"; //?ID=32233223
			parent.g_Handler.Delete.OnBefore=OnBeforeDelete;
	}
</script>

<script>
	//alert("Ready")
	parent.g_Handler.OnViewChange(divContent, OnViewLoad);
	//InitView();
</script>
