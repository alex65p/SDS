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
    <version number="1.0" date="23/02/2004" author="Treskina Mary">		
      <comments>
			   <comment date="23/02/2004" author="Treskina Mary">
				RischioFattore
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
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/DipendentePrecedenti/DipendentePrecedentiBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DipendentePrecedenti/DipendentePrecedentiBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/MansioneDittePrecedente/MansioneDittePrecedenteBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/MansioneDittePrecedente/MansioneDittePrecedenteBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script>
	var err = false;
</script>
<div id="dContent">

<% long lCOD_DIT_PRC_DPD=0;
   String s;
	IDipendentePrecedenti bean=null;
	String strID = (String)request.getParameter("ID_PARENT");
	try{
		IDipendentePrecedentiHome home=(IDipendentePrecedentiHome)PseudoContext.lookup("DipendentePrecedentiBean");
		bean = home.findByPrimaryKey(new Long(strID));
		lCOD_DIT_PRC_DPD=bean.getCOD_DIT_PRC_DPD();
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}

try{
	if (bean!=null){	
		String strCOD_DIT_PRC_DPD = new Long(lCOD_DIT_PRC_DPD).toString();
		if(request.getParameter("TAB_NAME").equals("tab1")){
			IMansioneDittePrecedenteHome md_home=(IMansioneDittePrecedenteHome)PseudoContext.lookup("MansioneDittePrecedenteBean");
			s=BuildMansioneDittePrecedenteTab(md_home, strCOD_DIT_PRC_DPD);
			out.println(s);
			
		}
		else{
			return;
		}
	}
}
catch(Exception ex){
	out.print(printErrAlert("divErr", "Error.alert", ex));
	return;
}
	 %>
</div>	
 <script>
 if (!err){
	  parent.tabbar.ReloadTabTable(document);
 }	
 </script>
 
<%! 
//---------------FUNCTIONS FOR TABS-------------------------
/* 	--- Normative di Riferimento
  ITipologiaDPIHome home = Home intarface of TipologiaDPI
	String COD_DIT_PRC_DPD = COD_DIT_PRC_DPD of current Tipologia
*/
String BuildMansioneDittePrecedenteTab(IMansioneDittePrecedenteHome home, String COD_DIT_PRC_DPD)
{
	String str;
	java.util.Collection col_nr = home.getMansioneDittePrecedenteByDIT_PRC_DPDID_View(new Long(COD_DIT_PRC_DPD).longValue());
	
	str="<table border='0' align='left' width='680' id='MansioneDittePrecedenteHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
        str+="<td  width='340'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa") + "</strong></td>";
	str+="<td width='340'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='680' id='MansioneDittePrecedente' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX=\""+Formatter.format(COD_DIT_PRC_DPD)+"\">";
        str+="<td width='340' class='dataTd'><input type='text' name='NOM_MAN_DIT_PRC' class='dataInput' readonly  value=''></td>";
        str+="<td width='340' class='dataTd'><input type='text' name='DESC_MAN_DIT_PRC' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_DIT_PRC_DPD.equals("") ){
		java.util.Iterator it_nr = col_nr.iterator();
 		while(it_nr.hasNext()){
			MansioneDittePrecedenteByDIT_PRC_DPDID_View nr=(MansioneDittePrecedenteByDIT_PRC_DPDID_View)it_nr.next();
	    	str+="<tr INDEX=\""+Formatter.format(COD_DIT_PRC_DPD)+"\" ID=\""+nr.COD_MAN_DIT_PRC+"\">";
			str+="<td class='dataTd'><input type='text' style='width: 340px;' readonly class='inputstyle'  value=\""+Formatter.format(nr.NOM_MAN_DIT_PRC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' style='width: 340px;' readonly class='inputstyle'  value=\""+Formatter.format(nr.DESC_MAN_DIT_PRC)+"\"></td>";
			str+="</tr>";
  		}
	}// Fornitore = null
	str+="</table>";
	return str;
}
%>
