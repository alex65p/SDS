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
    <version number="1.0" date="06/02/2004" author="Khomenko Juliya">
      <comments>

				  <comment date="06/02/2004" author="Khomenko Juliya">
				   <description></description>
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
<%@ page import="com.apconsulting.luna.ejb.Collegamenti.*" %>

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

ICollegamentiHome home=(ICollegamentiHome)PseudoContext.lookup("CollegamentiBean");
ICollegamenti Collegamenti;

Collection col = home.getCollegamento_View();
Iterator it = col.iterator();
%>

	<table class="VIEW_TABLE" border=0>
	<tr class="VIEW_HEADER_TR">
		<td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</td>
                 <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Indirizzo")%>&nbsp;</td>
                 <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
	</tr>
<%
 int iCount=0;
 while(it.hasNext()){
      Collegamento_View view = (Collegamento_View)it.next();
%>		<tr
			class="VIEW_TR" valign="top"
			INDEX="<%=view.COD_COL_INT_PRG%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
<%
	out.println("<td>&nbsp;"+ ++iCount +"&nbsp;</td><td>&nbsp;"+
								 Formatter.format(view.IDZ_COL_INT)+"&nbsp;</td><td>&nbsp;"+
								 Formatter.format(view.DES_COL_INT)+"&nbsp;</td></tr>");
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

			parent.g_Handler.setCaptionHTML("<%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.collegamenti")%>");

			parent.g_Handler.New.URL="/luna/WEB/Form_COL_INT_PRG/COL_INT_PRG_Form.jsp";
			parent.g_Handler.New.Width=45;
			parent.g_Handler.New.Height=15;

			parent.g_Handler.Open=parent.g_Handler.New;

			parent.g_Handler.Delete.URL="/luna/WEB/Form_COL_INT_PRG/COL_INT_PRG_Delete.jsp"; //?ID=32233223
			parent.g_Handler.Delete.OnBefore=OnBeforeDelete;
	}
</script>

<script>
	//alert("Ready")
	parent.g_Handler.OnViewChange(divContent, OnViewLoad);
	//InitView();
</script>
