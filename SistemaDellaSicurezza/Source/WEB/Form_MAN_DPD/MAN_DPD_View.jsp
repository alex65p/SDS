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
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>

    <body>
<div id="divContent">
<table border="0" width="80%" class="VIEW_TABLE">
<tr class="VIEW_HEADER_TR">
 <td width="10%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%></td>
 <td width="30%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa")%></td>
 <td width="30%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Unità.organizzativa")%></td>
 <td width="15%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.inizio")%></td>
 <td width="15%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.fine")%></td>  
</tr>
<%
String ID_PARENT = request.getParameter("ID_PARENT");
IDipendenteHome home=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
IDipendente Dipendente=null;
java.util.Collection col = home.getDipendenti_Lavoratori_View(new Long(ID_PARENT).longValue());
java.util.Iterator it = col.iterator();
 int	nCount = 0;
while(it.hasNext()){
		Dipendenti_Lavoratori_View obj=(Dipendenti_Lavoratori_View)it.next();
%>		<tr 
			class="VIEW_TR" valign="top"
			INDEX="obj.COD_DPD" ID='<%=obj.COD_UNI_ORG+"|"+obj.COD_MAN%>' onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)"
			>
<%
	out.println("<td>&nbsp;" + ++nCount + "&nbsp;</td><td>&nbsp;"+
							 Formatter.format(obj.NOM_MAN)+"&nbsp;</td></td><td>&nbsp;"+
								 Formatter.format(obj.NOM_UNI_ORG)+"&nbsp;</td><td>&nbsp;"+
								 Formatter.format(obj.DAT_INZ)+"&nbsp;</td><td>&nbsp;"+
								 Formatter.format(obj.DAT_FIE)+"&nbsp;</td></tr>");
}
%>
</table>

</div>
<script>
	function OnBeforeDelete(id, tr){
		return confirm(arraylng["MSG_0016"]);
	}
	function OnViewLoad(){
			
			parent.g_Handler.setCaptionHTML("<%=ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa.del.lavoratore")%>");
			
			parent.g_Handler.New.URL="/luna/WEB/Form_MAN_DPD/MAN_DPD_Form.jsp";
			parent.g_Handler.New.Width=55;
			parent.g_Handler.New.Height=29;

			parent.g_Handler.Open=parent.g_Handler.New;
			
			parent.g_Handler.Delete.URL="/luna/WEB/Form_MAN_DPD/MAN_DPD_Delete.jsp";
			parent.g_Handler.Delete.OnBefore=OnBeforeDelete;	
	}
</script>

<script>
	parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
