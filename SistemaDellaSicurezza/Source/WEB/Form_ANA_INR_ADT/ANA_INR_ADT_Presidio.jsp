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
    <version number="1.0" date="01/03/2004" author="Alex Kyba">
	      <comments>
				  <comment date="01/03/2004" author="AlexKyba">
				   <description></description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Presidi.*" %>

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
	long lCOD_PSD_ACD=0;
	String strNOM_CAG_PSD_ACD="";
	String strIDE_PSD_ACD="";

	//---------------------------

//------------------------------------------------------------------
//----------------Interfaces & Beans--------------------------------
//------------------------------------------------------------------
	//------ Presidio ------
	IPresidiHome home=(IPresidiHome)PseudoContext.lookup("PresidiBean");
	IPresidi Presidi=null;

if(request.getParameter("ID")!=null)
{
 	// getting parameters of azienda
	try{
		long ID = new Long(request.getParameter("ID")).longValue();
		PresidioView p =home.getPresidio(ID);
		lCOD_PSD_ACD =ID;
		strNOM_CAG_PSD_ACD=p.strNOM_CAG_PSD_ACD;
		strIDE_PSD_ACD = p.strIDE_PSD_ACD;
	}
	catch(Exception ex){
		out.print("<strong>"+ex.getMessage()+"</strong>");
		return;
	}
}
%>
<div id="divContent">
<fieldset style="width:100%">
	<legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.presidio.antincendio")%></legend>
	<table width="100%"  cellpadding="0" cellspacing="0" style="margin: 5 0 9 0" border="0">
		<tr>
			<td>&nbsp;&nbsp;</td>
			<td align="right" nowrap>
				&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Categoria")%>&nbsp;
			</td>
			<td align="left" width="70%" id="">
				<input type="hidden" style="width:100%" value="<%= Formatter.format(lCOD_PSD_ACD) %>"  id="COD_PSD_ACD" name="COD_PSD_ACD">
				<input type="text"  style="width:100%" value="<%= Formatter.format(strNOM_CAG_PSD_ACD) %>"  id="NOM_CAG_PSD_ACD" name="NOM_CAG_PSD_ACD">
			</td>
			<td align="right" nowrap>
				&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Identificativo")%>&nbsp;
			</td>
			<td align="left" style="width:20%">
				<input type="text"  style="width:100%" value="<%= Formatter.format(strIDE_PSD_ACD) %>" id="IDE_PSD_ACD" name="IDENTIFICATORE">
			</td>
			<td>
				<button class="getlist" onclick="getPresidiList()" id="btnMisPet">
					<strong>&middot;&middot;&middot;</strong>
				</button>							
			</td>
			<td>&nbsp;</td>
		</tr>
	</table>
</fieldset>
</div>
<script>
	parent.PRESIDIO.innerHTML=document.all["divContent"].innerHTML;
</script>


