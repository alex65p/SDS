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
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.UnitaSicurezza.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<body>
<div id="divContent">
<table border="0" width="80%" class="VIEW_TABLE">
<tr class="VIEW_HEADER_TR">
 <td width="10%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</td>
 <td width="45%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</td>
 <td width="45%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
</tr>
<%/*
IUnitaSicurezzaHome home=(IUnitaSicurezzaHome)PseudoContext.lookup("UnitaSicurezzaBean");
long lCOD_AZL=Security.getAzienda();
java.util.Collection col = home.getUnitaSicurezza_View(lCOD_AZL);
java.util.Iterator it = col.iterator();
 int	nCount = 0;
 while(it.hasNext()){
   UnitaSicurezzaView obj = (UnitaSicurezzaView)it.next();
*/
%>		<tr	class="VIEW_TR" valign="top" INDEX="<%//=obj.lCOD_UNI_SIC%>"
         onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
<%/*
	out.println("<td>&nbsp;" + ++nCount + "&nbsp;</td><td>&nbsp;"+
								 Formatter.format(obj.strNOM_UNI_SIC)+"&nbsp;</td><td>&nbsp;"+
								 Formatter.format(obj.strDES_UNI_SIC)+"&nbsp;</td></tr>");
  }*/
%>
</table>
</div>
<script>
	function OnBeforeDelete(id, tr){
		return confirm(arraylng["MSG_0029"]);
	}
	function OnViewLoad(){
			parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuOrganizzazione,4));
			
			parent.g_Handler.New.URL="/luna/WEB/Form_ANA_UNI_SIC/ANA_UNI_SIC_Form.jsp";
			parent.g_Handler.New.Width=55;
			parent.g_Handler.New.Height=37;

			parent.g_Handler.Open=parent.g_Handler.New;
			
			parent.g_Handler.Delete.URL="/luna/WEB/Form_ANA_UNI_SIC/ANA_UNI_SIC_Delete.jsp"; 
			parent.g_Handler.Delete.OnBefore=OnBeforeDelete;	
	}
	parent.g_Handler.New.URL="/luna/WEB/Form_ANA_UNI_SIC/ANA_UNI_SIC_Form.jsp";
	parent.g_Handler.New.Width="750px";
	parent.g_Handler.New.Height="500px";
	parent.g_Handler.setCaptionHTML("");
	parent.tblAll.style.display="none";
	parent.g_OnNew(document.all["btnNew"]);

</script>


