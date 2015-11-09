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
    <version number="1.0" date="11/02/2004" author="Alexey Kolesnik">		
      <comments>

				  <comment date="11/02/2004" author="Alexey Kolesnik">
				   <description> Initial template </description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.LuogoFisicoRischio.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<html>
<body>
<div id="divContent">
<%
ILuogoFisicoRischioHome aHome=(ILuogoFisicoRischioHome)PseudoContext.lookup("LuogoFisicoRischioBean");

Collection col = aHome.getLuogoFisicoRischio_List_View(Security.getAzienda());
Iterator it = col.iterator();
%>
	
	<table class="VIEW_TABLE" border=0>
	<tr class="VIEW_HEADER_TR">
		<td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</td>
                 <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nominativo.rilevatore")%>&nbsp;</td>
                 <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Rischio")%>&nbsp;</td>
	</tr>
<%
int i=1;
while(it.hasNext()){
	LuogoFisicoRischio_List_View  view = (LuogoFisicoRischio_List_View)it.next();
	%>
		<tr class="VIEW_TR" valign="top" INDEX="<%=view.COD_RSO_LUO_FSC%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
			<td>&nbsp;<%=i++%>&nbsp;</td>
			<td>&nbsp;<%=view.NOM_RIL_RSO%>&nbsp;</td>
			<td>&nbsp;<%=view.NOM_RSO%>&nbsp;</td>
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
			//alert("Loaded!!")
			
			parent.g_Handler.setCaptionHTML("<%=ApplicationConfigurator.LanguageManager.getString("Associazione.luoghi.fisici.rischi")%>");
			
			parent.g_Handler.New.URL="/luna/WEB/Form_RSO_LUO_FSC/RSO_LUO_FSC_Form.jsp";
			parent.g_Handler.New.Width=52;
			parent.g_Handler.New.Height=34;

			parent.g_Handler.Open=parent.g_Handler.New;
			
			parent.g_Handler.Delete.URL="/luna/WEB/Form_RSO_LUO_FSC/RSO_LUO_FSC_Delete.jsp"; //?ID=32233223
			parent.g_Handler.Delete.OnBefore=OnBeforeDelete;	
	}
</script>

<script>
	parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>


