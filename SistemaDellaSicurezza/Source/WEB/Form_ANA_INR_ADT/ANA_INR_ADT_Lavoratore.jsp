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
    <version number="1.0" date="19/02/2004" author="Alex Kyba">
	      <comments>
				  <comment date="19/02/2004" author="AlexKyba">
				   <description>function, stroyaschaya strukturu unita organizzativa</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<% 
//-------------------------------------------------
			
	String strRAG_SCL_AZL = new String();
	//------------------
	long lCOD_DPD=0;
	String strNOM_DPD="";
	String strMTR_DPD="";
	String strCOG_DPD="";
	//---------------------------

//------------------------------------------------------------------
//----------------Interfaces & Beans--------------------------------
//------------------------------------------------------------------
	//------ Dipendente ---
	IDipendenteHome home=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
	IDipendente bean=null;

if(request.getParameter("ID")!=null)
{
 	// getting parameters of azienda
	try{
		Long ID = new Long(request.getParameter("ID"));
		bean=home.findByPrimaryKey(ID);
		lCOD_DPD=bean.getCOD_DPD();
		strNOM_DPD=bean.getNOM_DPD();
		strMTR_DPD = bean.getMTR_DPD();
		strCOG_DPD = bean.getCOG_DPD();
	}
	catch(Exception ex){
		out.print("<strong>"+ex.getMessage()+"</strong>");
		return;
	}
}
%>
<div id="divContent">
<fieldset style="width:100%">
	<legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.lavoratore")%></legend>
	<table  cellpadding="0" cellspacing="0" width="100%" style="margin: 5 0 9 0" border="0">
		<tr>
			<td>&nbsp;&nbsp;</td>
			<td align="right">
				&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Cognome")%>&nbsp;
			</td>
			<td  align="left" width="40%" id="">
				 <input type="hidden" size="20" maxlength="20"   name="COD_DPD" value="<%=Formatter.format(lCOD_DPD)%>">
				<input type="text" style="width:100%"  value="<%= Formatter.format(strCOG_DPD) %>" id="COG_DPD" name="COG_DPD">
			</td>
			<td align="right">
				&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;
			</td>
			<td align="left" style="width:25%">
				<input type="text" style="width:100%"  value="<%= Formatter.format(strNOM_DPD) %>" id="NOM_DPD" name="NOM_DPD">
			</td>
			<td align="right">
				&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Matricola")%>&nbsp;
			</td>
			<td align="left" style="width:20%">
				<input type="text" style="width:100%"  value="<%= Formatter.format(strMTR_DPD) %>" id="MTR_DPD" name="MTR_DPD">
			</td>
			<td>
				<button class="getlist" onclick="getLavoratoriList()" id="btnLavoratore">
					<strong>&middot;&middot;&middot;</strong>
				</button>							
			</td>
			<td>&nbsp;</td>
		</tr>
	</table>
</fieldset>
</div>
<script>
	if (parent.LAVORATORE){
		parent.LAVORATORE.innerHTML=document.all["divContent"].innerHTML;
	}	
</script>


