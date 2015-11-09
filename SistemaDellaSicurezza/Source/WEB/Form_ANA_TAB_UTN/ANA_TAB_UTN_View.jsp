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
    <version number="1.0" date="24/01/2004" author="Malyuk Sergey">
	      <comments>
				  <comment date="24/01/2004" author="Malyuk Sergey">
				   <description></description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.GestioneTabellare.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_include/Checker.jsp" %>

<html>
<body>
<div id="divContent">

<table border="0" width="80%" class="VIEW_TABLE">
<tr class="VIEW_HEADER_TR">
 <td width="10%"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</strong></td>
 <td width="45%"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>&nbsp;</strong></td>
</tr>
<%
IGestioneTabellareHome home=(IGestioneTabellareHome)PseudoContext.lookup("GestioneTabellareBean");
IGestioneTabellare GestioneTabellare=null;
Checker c = new Checker();

String ID_PARENT = request.getParameter("ID_PARENT");
java.util.Collection col = home.getGestioneTabellare_View(c.checkLong("COD_PRG",ID_PARENT,true));
if (c.isError){
	String err = c.printErrors();
	out.print("<script>alert(\""+err+"\");</script>");
	return;
}

java.util.Iterator it = col.iterator();
int	nCount = 0;
while(it.hasNext()){
		GestioneTabellare_View obj=(GestioneTabellare_View)it.next();
%>		<tr	class="VIEW_TR" valign="top"	INDEX="<%=obj.COD_TAB_UTN%>"
       onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
<%
	out.println("<td>&nbsp;" + ++nCount + "&nbsp;</td><td>&nbsp;"+
								 Formatter.format(obj.TIT_TAB)+"&nbsp;</td></tr>");
  }
%>
</table>
</div>
<script>
	function OnBeforeDelete(id, tr){
		return confirm(arraylng["MSG_0016"]);
	}
	function OnViewLoad(){
			parent.g_Handler.setCaptionHTML("<%=ApplicationConfigurator.LanguageManager.getString("Gestione.delle.tabelle")%>");
			
			parent.g_Handler.New.URL="/luna/WEB/Form_ANA_TAB_UTN/ANA_TAB_UTN_Form.jsp";
			parent.g_Handler.New.Width=55;
			parent.g_Handler.New.Height=31;

			parent.g_Handler.Open=parent.g_Handler.New;
			
			parent.g_Handler.Delete.URL="/luna/WEB/Form_ANA_TAB_UTN/ANA_TAB_UTN_Delete.jsp"; 
			parent.g_Handler.Delete.OnBefore=OnBeforeDelete;	
	}
	parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>


