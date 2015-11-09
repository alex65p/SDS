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
<%@ page import="com.apconsulting.luna.ejb.InterventoAudut.*" %>

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
	long lCOD_MIS_PET=0;
    long lCOD_MIS_RSO_LUO=0;
    long lCOD_MIS_PET_MAN=0;
	String strNOM_MIS_PET="";
	
	String vType = "";
	String selLuogo="";
	String selAttivita="checked";
	long lCOD_AZL = Security.getAzienda();
	//---------------------------

//------------------------------------------------------------------
//----------------Interfaces & Beans--------------------------------
//------------------------------------------------------------------
	//----MisuraPreventiva-----------
	IInterventoAudut bean=null;
	IInterventoAudutHome home=(IInterventoAudutHome)PseudoContext.lookup("InterventoAudutBean");

	vType = request.getParameter("vType");
	
if(request.getParameter("ID")!=null)
{
 	// getting parameters of azienda
	try{
		long ID = new Long(request.getParameter("ID")).longValue();
		MisuraPreventivaView mis; 
								
		if (vType.equals("LUO_FSC")){
			mis = home.getMisuraPreventivaByLuogo(ID, lCOD_AZL);
			lCOD_MIS_RSO_LUO=ID;
			lCOD_MIS_PET=mis.lCOD_MIS_PET;
			strNOM_MIS_PET=mis.strNOM_MIS_PET;
			selLuogo="checked";
			selAttivita="";
		}else 
		if (vType.equals("MAN")){
			mis = home.getMisuraPreventivaByAttivita(ID, lCOD_AZL);
			lCOD_MIS_PET_MAN = ID;
			lCOD_MIS_PET=mis.lCOD_MIS_PET;
			strNOM_MIS_PET=mis.strNOM_MIS_PET;
			selAttivita="checked";
			selLuogo="";
		}
	}
	catch(Exception ex){
		out.print("<strong>"+ex.getMessage()+"</strong>");
		return;
	}
}
%>
<div id="divContent">
<fieldset style="width:100%">
	<legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.misura.di.prevenzione.applicata.a")%></legend>
	<table cellpadding="0" cellspacing="0" width="100%" style="margin: 5 0 9 0" border="0">
		<tr>
			<td>&nbsp;&nbsp;</td>
			<td align="right" nowrap>
				&nbsp;<LABEL for="RB_LUO_FSC"><%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%>&nbsp;</LABEL>
			</td>
			<td  align="left" width="10%" id="">
				<input type="radio" style="" <%= selLuogo %> class="checkbox" value="L" id="RB_LUO_FSC" name="RB_LUO_FSC_MAN">
			</td>
			<td align="right" nowrap>
				&nbsp;<LABEL for="RB_MAN"><%=ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa")%>&nbsp;</LABEL>
			</td>
			<td align="left" style="width:10%">
				<input type="radio" class="checkbox" <%= selAttivita %> style="width:" value="M" id="RB_MAN" name="RB_LUO_FSC_MAN">
			</td>
			<td align="right">
				&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Misura")%>&nbsp;
			</td>
			<td align="left" style="width:60%">
				<input type="hidden" style="width:100%"  value="<%= Formatter.format(lCOD_MIS_RSO_LUO) %>" id="COD_MIS_RSO_LUO" name="COD_MIS_RSO_LUO">
				<input type="hidden" style="width:100%"  value="<%= Formatter.format(lCOD_MIS_PET_MAN) %>" id="COD_MIS_PET_MAN" name="COD_MIS_PET_MAN">
				<input type="hidden" style="width:100%"  value="<%= Formatter.format(lCOD_MIS_PET) %>" id="COD_MIS_PET" name="COD_MIS_PET">
				<input type="text"  style="width:100%"  value="<%= Formatter.format(strNOM_MIS_PET) %>" id="NOM_MIS_PET" name="NOM_MIS_PET">
			</td>
			<td>
				<button class="getlist" onclick="getMisPetList()" id="btnMisPet">
					<strong>&middot;&middot;&middot;</strong>
				</button>							
			</td>
			<td>&nbsp;</td>
		</tr>
	</table>
</fieldset>
</div>
<script>
	parent.MISURA.innerHTML=document.all["divContent"].innerHTML;
</script>


