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
<%@ page import="com.apconsulting.luna.ejb.Corsi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/DocentiCorso/DocentiCorsoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DocentiCorso/DocentiCorsoBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/TipologiaCorsi/TipologiaCorsiBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TipologiaCorsi/TipologiaCorsiBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script>
  var err=false;
//alert('<%=request.getParameter("TAB_NAME")%>');
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<div id="dContent">

<%

	long lCOD_COR = new Long(request.getParameter("ID_PARENT")).longValue();
	
	try{
    	if(request.getParameter("TAB_NAME").equals("tab1")){
				ICorsiHome lfHome=(ICorsiHome)PseudoContext.lookup("CorsiBean");
   			out.println(BuildTestVerificaTab(lfHome, lCOD_COR));
    	}
	else
    	if(request.getParameter("TAB_NAME").equals("tab2")){
			ICorsiHome lfHome=(ICorsiHome)PseudoContext.lookup("CorsiBean");
			out.println(BuildMaterialeCorsoTab(lfHome, lCOD_COR));
    	}
		else
    	if(request.getParameter("TAB_NAME").equals("tab3")){
			IDocentiCorsoHome dcHome=(IDocentiCorsoHome)PseudoContext.lookup("DocentiCorsoBean");
			out.println(BuildDocentiCorsoTab(dcHome, lCOD_COR));
    	}
		else
	return;
	
	}
	catch(Exception ex){
			out.print(printErrAlert("divErr", "Error.alert",ex));
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
String BuildTestVerificaTab(ICorsiHome home, long lCOD_COR)
{
	String str = "";
	java.util.Collection col = home.getTestVerifica_View(lCOD_COR);
	
	str="<table border='0' align='left' width='750' id='TestVerificaHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
	str+="<td width='370'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.test") + "</strong></td>";
	str+="<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Punteggio.minimo") + "</strong></td>";
	str+="<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Punteggio.massimo") + "</strong></td>";
	str+="<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("N.Domande") + "</strong></td>";
	str+="</tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='750' id='TestVerifica' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_COR)+"'>";
	str+="<td width='370' class='dataTd'><input type='text' name='NOM_TES_VRF' class='dataInput' readonly  value=''></td>";
	str+="<td width='140' class='dataTd'><input type='text' name='NUM_MIN_PTG' class='dataInput' readonly  value=''></td>";
	str+="<td width='140' class='dataTd'><input type='text' name='NUM_MAX_PTG' class='dataInput' readonly  value=''></td>";
	str+="<td width='100' class='dataTd'><input type='text' name='TOT_DMD' class='dataInput' readonly  value=''></td>";
	str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		TestVerifica_View obj=(TestVerifica_View)it.next();
    	str+="<tr INDEX='"+Formatter.format(lCOD_COR)+"' ID='"+obj.COD_TES_VRF+"'>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 370px;' class='inputstyle'  value=\""+Formatter.format(obj.NOM_TES_VRF)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 140px;' class='inputstyle'  value=\""+Formatter.format(obj.NUM_MIN_PTG)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 140px;' class='inputstyle'  value=\""+Formatter.format(obj.NUM_MAX_PTG)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 100px;' class='inputstyle'  value=\""+Formatter.format(obj.TOT_DMD)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}

String BuildMaterialeCorsoTab(ICorsiHome home, long lCOD_COR)
{
	String str = "";
	java.util.Collection col = home.getMaterialeCorso_View(lCOD_COR);
	
	str="<table border='0' align='left' width='750' id='MaterialeCorsoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
	str+="<td width='250'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong></td>";
	str+="<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.di.emissione") + "</strong></td>";
	str+="<td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile.documento") + "</strong></td>";
	str+="<td width='160'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("File") + "</strong></td>";
	str+="</tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='750' id='MaterialeCorso' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_COR)+"'>";
	str+="<td width='250' class='dataTd'><input type='text' name='NOM_TES_VRF' class='dataInput' readonly  value=''></td>";
	str+="<td width='140' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td width='200' class='dataTd'><input type='text' name='RSP_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td width='160' class='dataTd'><input type='text' name='NOME_FILE' class='dataInput' readonly  value=''></td>";
	str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		MaterialeCorso_View obj=(MaterialeCorso_View)it.next();
    	str+="<tr INDEX='"+Formatter.format(lCOD_COR)+"' ID='"+obj.COD_DOC+"'>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 250px;' class='inputstyle'  value=\""+Formatter.format(obj.TIT_DOC)+"\"></td>";
		str+="<td class='dataTd'><input type='text' style='width: 140px;' class='inputstyle'  value=\""+Formatter.format(obj.DAT_REV_DOC)+"\"></td>";
		str+="<td class='dataTd'><input type='text' style='width: 200px;' class='inputstyle'  value=\""+Formatter.format(obj.RSP_DOC)+"\"></td>";
		str+="<td class='dataTd'><input type='text' style='width: 160px;' class='inputstyle'  value=\""+Formatter.format(obj.NOME_FILE)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}

String BuildDocentiCorsoTab(IDocentiCorsoHome home, long lCOD_COR)
{
	String str = "";
	java.util.Collection col = home.getDocentiCorso_View(lCOD_COR);
	
	str="<table border='0' align='left' width='750' id='DocentiCorsoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
	str+="<td width='470'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Docente") + "</strong></td>";
	str+="<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Inizio") + "</strong></td>";
	str+="<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Fine") + "</strong></td>";
	str+="</tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='750' id='DocentiCorso' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_COR)+"'>";
	str+="<td width='470' class='dataTd'><input type='text' name='NOM_DCT' class='dataInput' readonly  value=''></td>";
	str+="<td width='140' class='dataTd'><input type='text' name='DAT_INZ' class='dataInput' readonly  value=''></td>";
	str+="<td width='140' class='dataTd'><input type='text' name='DAT_FIE' class='dataInput' readonly  value=''></td>";
	str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		DocentiCorso_View obj=(DocentiCorso_View)it.next();
    	str+="<tr INDEX='"+Formatter.format(lCOD_COR)+"' ID='"+obj.COD_DCT_COR+"'>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 470px;' class='inputstyle'  value=\""+Formatter.format(obj.NOM_DCT)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 140px;' class='inputstyle'  value=\""+Formatter.format(obj.DAT_INZ)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 140px;' class='inputstyle'  value=\""+Formatter.format(obj.DAT_FIE)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}
%>
