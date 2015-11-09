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
    <version number="1.0" date="22/12/2004" author="Mike Kondratyuk">		
      <comments>

				  <comment date="22/12/2004" author="Mike Kondratyuk">
				   <description>Chernovik vieW</description>
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
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.GestioniSezioni.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<html>
<body>
<div id="divContent">

<%
String ID_PARENT = request.getParameter("ID_PARENT");

IGestioniSezioniHome home=(IGestioniSezioniHome)PseudoContext.lookup("GestioniSezioniBean");
%>
	
	<table class="VIEW_TABLE" border=0>
	<tr class="VIEW_HEADER_TR">
		<td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</td>
                 <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</td>
	</tr>
<%

 java.util.Collection col = home.getGestioniSezioni_CplAre_View(new Long(ID_PARENT).longValue(), Security.getAzienda());
 java.util.Iterator it = col.iterator();
 int iCount=0;
 while(it.hasNext()){
	GestioniSezioni_CplAre_View GestioniSezioni=(GestioniSezioni_CplAre_View)it.next();
%>		<tr class="VIEW_TR" valign="top" INDEX="<%=GestioniSezioni.COD_CPL%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
<%
	out.println("<td>&nbsp;"+ ++iCount +"&nbsp;</td><td>&nbsp;"+
								 GestioniSezioni.DES_CPL_ARE+"&nbsp;</td></tr>");
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
			
			parent.g_Handler.setCaptionHTML("<%=ApplicationConfigurator.LanguageManager.getString("Associazione.capitoli/sezioni")%>");
			
			parent.g_Handler.New.URL="/luna/WEB/Form_CPL_ARE/CPL_ARE_Form.jsp?ID_PARENT=<%=ID_PARENT%>";
			parent.g_Handler.New.Width=50;
			parent.g_Handler.New.Height=32;

			parent.g_Handler.Open=parent.g_Handler.New;
			
			parent.g_Handler.Delete.URL="/luna/WEB/Form_CPL_ARE/CPL_ARE_Delete.jsp"; //?ID=32233223
			parent.g_Handler.Delete.OnBefore=OnBeforeDelete;	
	}
</script>

<script>
	//alert("Ready")
	parent.g_Handler.OnViewChange(divContent, OnViewLoad);
	//InitView();
</script>


