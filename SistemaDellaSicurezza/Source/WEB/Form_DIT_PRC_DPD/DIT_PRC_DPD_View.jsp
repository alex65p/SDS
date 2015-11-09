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
    <version number="1.0" date="20/02/2004" author="Treskina Maria">		
      <comments>

				  <comment date="20/02/2004" author="Treskina Maria">
				   <description>view dla DIT_PRC_DPD</description>
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

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/DipendentePrecedenti/DipendentePrecedentiBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DipendentePrecedenti/DipendentePrecedentiBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%
long lCOD_DPD=new Long(request.getParameter("ID_PARENT")).longValue();
//long lCOD_AZL = Security.getAzienda();
	
IDipendentePrecedentiHome aHome=(IDipendentePrecedentiHome)PseudoContext.lookup("DipendentePrecedentiBean");

Collection col = aHome.getDipendentePrecedenti_Tipology_Number_View(lCOD_DPD);
Iterator it = col.iterator();
%>


<div id="divContent">
<script type="text/javascript">
//alert(document.location);
</script>
<table class="VIEW_TABLE" border=0>
	<tr class="VIEW_HEADER_TR">
		<td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</td>
                <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Attività.svolta")%>&nbsp;</td>
                <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Ragione.sociale")%>&nbsp;</td>
	</tr>
<%
int i=1;
while(it.hasNext()){
	DipendentePrecedenti_Tipology_Number_View  view = (DipendentePrecedenti_Tipology_Number_View)it.next();
	%>
	
	
			<tr 
			class="VIEW_TR" valign="top"
			INDEX="<%=view.COD_DIT_PRC_DPD%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
			<td>&nbsp;<%=i++%>&nbsp;</td>
			<td>&nbsp;<%=view.DES_ATI_SVO_DIT_PRC%>&nbsp;</td>
			<td>&nbsp;<%=view.RAG_SCL_DIT_PRC%>&nbsp;</td>
		</tr>
<%
}
%>
</table>

</div>

<script>
	function OnBeforeDelete(id, tr){
		return confirm(arraylng["MSG_0032"]);
	}
	function OnViewLoad(){
			//alert("Loaded!!")<%//=ID_PARENT%>
			
			parent.g_Handler.setCaptionHTML("<%=ApplicationConfigurator.LanguageManager.getString("Ditte.precedenti")%>");
			
			parent.g_Handler.New.URL="/luna/WEB/Form_DIT_PRC_DPD/DIT_PRC_DPD_Form.jsp?ID_PARENT=<%=lCOD_DPD%>";
			parent.g_Handler.New.Width=55;
			parent.g_Handler.New.Height=39;

			parent.g_Handler.Open=parent.g_Handler.New;
			
			parent.g_Handler.Delete.URL="/luna/WEB/Form_DIT_PRC_DPD/DIT_PRC_DPD_Delete.jsp"; //?ID=32233223
			parent.g_Handler.Delete.OnBefore=OnBeforeDelete;
                        parent.g_Handler.Help.URL="/luna/WEB/Form_DIT_PRC_DPD/DIT_PRC_DPD_Help.jsp";
	}
</script>

<script>
	//alert("Ready")
	parent.g_Handler.OnViewChange(divContent, OnViewLoad);
	//InitView();
</script>


