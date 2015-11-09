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
    <version number="1.0" date="26/01/2004" author="Artur Denysenko">		
      <comments>
			   <comment date="17/02/2004" author="Pogrebnoy Yura">
				   izmenil dlya formi ANA_FAT_RSO_Form
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
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>
<%@ page import="com.apconsulting.luna.ejb.IndirizzoPostaElettronica.*" %>
<%@ page import="com.apconsulting.luna.ejb.CollegamentoInternet.*" %>
<%@ page import="com.apconsulting.luna.ejb.RischioFattore.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script>
	var err = false;
</script>
<div id="dContent">
<%
	String strCOD_FAT_RSO="";
	IRischioFattore bean=null;
	String strID = (String)request.getParameter("ID_PARENT");
	try{
		IRischioFattoreHome home=(IRischioFattoreHome)PseudoContext.lookup("RischioFattoreBean");
		long l = Long.parseLong(strID);
		bean = home.findByPrimaryKey( new Long(l));
		strCOD_FAT_RSO=new Long(bean.getCOD_FAT_RSO()).toString();
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}
	
	ICollegamentoInternetHome homa=(ICollegamentoInternetHome)PseudoContext.lookup("CollegamentoInternetBean");
	IIndirizzoPostaElettronicaHome homi=(IIndirizzoPostaElettronicaHome)PseudoContext.lookup("IndirizzoPostaElettronicaBean");
  IAnagrDocumentoHome dhome=(IAnagrDocumentoHome)PseudoContext.lookup("AnagrDocumentoBean");
	try{
	if (bean!=null){	
		if(request.getParameter("TAB_NAME").equals("tab1")){
			out.println(BuildCollegamentoInternetTab(homa, strCOD_FAT_RSO));
		}
		
		else if(request.getParameter("TAB_NAME").equals("tab2")){
			out.println(BuildIndirizzoPostaElettronicaTab(homi, strCOD_FAT_RSO));
		}
		
		else if(request.getParameter("TAB_NAME").equals("tab3")){
			out.println(BuildAnagraficaDocumenteTab(dhome, strCOD_FAT_RSO));
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
String BuildCollegamentoInternetTab(ICollegamentoInternetHome home, String strCOD_FAT_RSO){
	String str="";
	java.util.Collection col_int = home.getCollegamentoInternet_View(strCOD_FAT_RSO);
	str="<table border='0' align='left' width='724' id='CollegamentoInternetHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='724'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Indirizzo.collegamento.internet") + "</strong></td></tr>";
	str+="<table align='left' width='724' id='CollegamentoInternet' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr INDEX='"+strCOD_FAT_RSO+"' id='' style='display:none;'>";
	str+="<td class='dataTd'><input type='text' readonly class='dataInput' value=''></td></tr>";
	if ( !strCOD_FAT_RSO.equals("") ){
		java.util.Iterator it_int = col_int.iterator();
 		while(it_int.hasNext()){
			CollegamentoInternet_View ci=(CollegamentoInternet_View)it_int.next();
			str+="<tr INDEX='"+strCOD_FAT_RSO+"' id='"+Formatter.format(ci.COD_COL_INT)+"'>";
			str+="<td class='dataTd'><input type='text' class='inputstyle' readonly style='width: 724px;' value=\""+ci.IDZ_COL_INT+"\"></td>";
			str+="</tr>";
  	}
	}
	str+="</table>";
	return str;
}
String BuildIndirizzoPostaElettronicaTab(IIndirizzoPostaElettronicaHome home, String strCOD_FAT_RSO){
	String str="";
	java.util.Collection col_ipe = home.getIndirizzoPostaElettronica_View(strCOD_FAT_RSO);
	str="<table border='0' align='left' width='724' id='IndirizzoPostaElettronicaHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='724'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Indirizzo.di.posta.elettronica") + "</strong></td></tr>";
	str+="<table align='left' width='724' id='IndirizzoPostaElettronica' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr INDEX='"+strCOD_FAT_RSO+"' id='' style='display:none'>";
	str+="<td class='dataTd' width='724'><input type='text' readonly class='dataInput'  value=''></td></tr>";
	if ( !strCOD_FAT_RSO.equals("") ){
		java.util.Iterator it_ipe = col_ipe.iterator();
 		while(it_ipe.hasNext()){
			IndirizzoPostaElettronica_View ipe=(IndirizzoPostaElettronica_View)it_ipe.next();
			str+="<tr INDEX='"+strCOD_FAT_RSO+"' id='"+Formatter.format(ipe.COD_IDZ_PSA_ELT)+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 724px;' class='inputstyle' value=\""+ipe.IDZ_PSA_ELT+"\"></td>";
			str+="</tr>";
  	}
	}
	str+="</table>";
	return str;
}
String BuildAnagraficaDocumenteTab(IAnagrDocumentoHome home, String strCOD_FAT_RSO){
	String str="";
	java.util.Collection col_andoc = home.getAnagraficaDocumente_View(strCOD_FAT_RSO);
	str="<table border='0' align='left' width='724' id='AnagraficaDocumenteHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile.documento") + "</strong></td>";
	str+="<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td>";
	str+="<td width='384'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong></td></tr>";
	str+="<table align='left' width='724' id='AnagraficaDocumente' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr INDEX='"+strCOD_FAT_RSO+"' id='' style='display:none'>";
	str+="<td class='dataTd'><input type='text' readonly class='dataInput' style='display:none' value=''></td>";
	str+="<td class='dataTd'><input type='text' readonly class='dataInput' style='display:none' value=''></td>";
	str+="<td class='dataTd'><input type='text' readonly class='dataInput' style='display:none' value=''></td>";
	str+="</tr>";
	if ( !strCOD_FAT_RSO.equals("") ){
		java.util.Iterator it_andoc = col_andoc.iterator();
 		while(it_andoc.hasNext()){
			Documente_View andoc_view=(Documente_View)it_andoc.next();
			str+="<tr INDEX='"+strCOD_FAT_RSO+"' id='"+Formatter.format(andoc_view.COD_DOC)+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value=\""+Formatter.format(andoc_view.RSP_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 140px;' class='inputstyle'  value=\""+Formatter.format(andoc_view.DAT_REV_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 384px;' class='inputstyle'  value=\""+Formatter.format(andoc_view.TIT_DOC)+"\"></td>";
			str+="</tr>";
  		}
	}
	str+="</table>";
	return str;
}
%>
