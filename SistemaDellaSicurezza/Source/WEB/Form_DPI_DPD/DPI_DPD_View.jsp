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

<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteConsegneDPI/DipendenteConsegneDPIBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteConsegneDPI/DipendenteConsegneDPIBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
<body>
<div id="divContent">

<%
long lCOD_DPD=0;

IDipendenteHome homeDip=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
IDipendente Dipendente;
IDipendenteConsegneDPIHome home=(IDipendenteConsegneDPIHome)PseudoContext.lookup("DipendenteConsegneDPIBean");
IDipendenteConsegneDPI DipendenteConsegneDPI;
%>
<!-- list of Dipendentes -->
<table border="0" class="VIEW_TABLE">
<tr class="VIEW_HEADER_TR">
                 <td width='10%'>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</td>
		 <td width='65%'>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Tipologia.D.P.I.")%>&nbsp;</td>
		 <td width='10%'>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Quantità.consegnata.in.pezzi")%>&nbsp;</td>
		 <td width='15%'>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.consegna")%>&nbsp;</td>
</tr>
<%
	long lCOD_AZL = Security.getAzienda();
	
	java.util.Collection col = home.getDipendenti_DPI_View(lCOD_DPD);
	int	nCount = 0;
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Dipendenti_DPI_View obj=(Dipendenti_DPI_View)it.next();
%>		<tr class="VIEW_TR" valign="top" INDEX="<%=obj.COD_CSG_DPI%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
<%
 		out.println("<td>&nbsp;" + ++nCount + "&nbsp;</td><td>&nbsp;"+
								 Formatter.format(obj.NOM_TPL_DPI)+"&nbsp;</td><td>&nbsp;"+
								 Formatter.format(obj.QTA_CSG)+"&nbsp;</td><td>&nbsp;"+
								 Formatter.format(obj.DAT_CSG_DPI)+"&nbsp;</td></tr>");
  }
%>
</table>
<!-- /list of Dipendentes -->

</div>

<script>

	function OnBeforeDelete(id, tr){
		return confirm(arraylng["MSG_0017"]);
	}
	function OnViewLoad(){
			//alert("Loaded!!")
			
			parent.g_Handler.setCaptionHTML("<%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.lavoratori")%>");
			
			parent.g_Handler.New.URL="/luna/WEB/Form_DPI_DPD/DPI_DPD_Form.jsp";
			parent.g_Handler.New.Width=55;
			parent.g_Handler.New.Height=40;

			parent.g_Handler.Open=parent.g_Handler.New;
			
			parent.g_Handler.Delete.URL="/luna/WEB/Form_DPI_DPD/DPI_DPD_Delete.jsp"; //?ID=32233223
			parent.g_Handler.Delete.OnBefore=OnBeforeDelete;	
	}
</script>

<script>
	//alert("Ready")
	parent.g_Handler.OnViewChange(divContent, OnViewLoad);
	//InitView();
</script>


