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
    <version number="1.0" date="13/02/2004" author="Kushkarov Yuriy">		
      <comments>
			   <comment date="13/02/2004" author="Kushkarov Yuriy">
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
<%@ page import="com.apconsulting.luna.ejb.Presidi.*" %>
<%@ page import="com.apconsulting.luna.ejb.SchedeInterventoPSD.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script>
	var err = false;
</script>
<div id="dContent">

<% long lCOD_PSC_ACD=0;
   String s;
	 String q;
	IPresidi bean=null;
	String strID = (String)request.getParameter("ID_PARENT");
	try{
		IPresidiHome home=(IPresidiHome)PseudoContext.lookup("PresidiBean");
		bean = home.findByPrimaryKey(new Long(strID));
		
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}

try{
	if (bean!=null){	
		if(request.getParameter("TAB_NAME").equals("tab1")){
			IPresidiHome nr_home=(IPresidiHome)PseudoContext.lookup("PresidiBean");
			s=BuildPresidiDocumentiTab(nr_home, new Long(strID).longValue());
			out.println(s);
		}else{
		  if(request.getParameter("TAB_NAME").equals("tab2")){
			  ISchedeInterventoPSDHome d_home=(ISchedeInterventoPSDHome)PseudoContext.lookup("SchedeInterventoPSDBean");
				q=BuildSchedeInterventoPSDTab(d_home, new Long(strID).longValue());
				out.print(q);
		  }
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
 String BuildPresidiDocumentiTab(IPresidiHome home, long lCOD_PSD_ACD)
{
	String str = "";
	java.util.Collection col = home.getPresidiDocumentiByID_View(lCOD_PSD_ACD);
	
	str="<table border='0' align='left' width='650' id='DocumentiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
	str+="<td width='300'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong></td>";
	str+="<td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>";
	str+="<td width='150'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td>";
	str+="</tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='650' id='Documenti' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_PSD_ACD)+"'>";
	str+="<td class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td class='dataTd'><input type='text' name='RSP_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td class='dataTd'><input type='text' name='DAT_REV_DOC' class='dataInput' readonly  value=''></td>";
	str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		PresidiDocumentiByID_View obj=(PresidiDocumentiByID_View)it.next();
    	str+="<tr INDEX='"+Formatter.format(lCOD_PSD_ACD)+"' ID='"+obj.COD_DOC+"'>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 300px;' class='inputstyle'  value=\""+Formatter.format(obj.TIT_DOC)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value=\""+Formatter.format(obj.RSP_DOC)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 150px;' class='inputstyle'  value=\""+Formatter.format(obj.DAT_REV_DOC)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}


String BuildSchedeInterventoPSDTab(ISchedeInterventoPSDHome home, long lCOD_PSD_ACD)
{
	String str = "";
	String strStat = "";
	java.util.Collection col = home.getSchedeInterventoPSD_ForPresidi_View(lCOD_PSD_ACD);
	
	str="<table border='0' align='left' width='650' id='SchedeHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
	str+="<td width='210'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.responsabile.intervento") + "</strong></td>";
	str+="<td width='150'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.pianificazione") + "</strong></td>";
	str+="<td width='150'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.intervento") + "</strong></td>";
	str+="<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Esito.intervento") + "</strong></td>";
	str+="</tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='650' id='Schede' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_PSD_ACD)+"'>";
	str+="<td width='210' class='dataTd'><input type='text' name='NOM_RSP_INR' class='dataInput' readonly  value=''></td>";
	str+="<td width='150' class='dataTd'><input type='text' name='DAT_PIF_INR' class='dataInput' readonly  value=''></td>";
	str+="<td width='150' class='dataTd'><input type='text' name='DAT_INR' class='dataInput' readonly  value=''></td>";
	str+="<td width='140' class='dataTd'><input type='text' name='ESI_INR' class='dataInput' readonly  value=''></td>";
	str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		SchedeInterventoPSD_ForPresidi_View obj=(SchedeInterventoPSD_ForPresidi_View)it.next();
    str+="<tr INDEX='"+Formatter.format(lCOD_PSD_ACD)+"' ID='"+Formatter.format(obj.COD_SCH_INR_PSD)+"'>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 210px;' class='inputstyle'  value=\""+Formatter.format(obj.NOM_RSP_INR)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 150px;' class='inputstyle'  value=\""+Formatter.format(obj.DAT_PIF_INR)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 150px;' class='inputstyle'  value=\""+Formatter.format(obj.DAT_INR)+"\"></td>";
		strStat="";
		if (("P").equals(Formatter.format(obj.ESI_INR))) {strStat="POSITIVO";}
		if (("N").equals(Formatter.format(obj.ESI_INR))) {strStat="NEGATIVO";}
		if (("D").equals(Formatter.format(obj.ESI_INR))) {strStat="DA FARE";}
		str+="<td class='dataTd'><input type='text' readonly style='width: 140px;' class='inputstyle'  value=\""+Formatter.format(strStat)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}
 %>
