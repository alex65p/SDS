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
    <version number="1.0" date="18/02/2004" author="Treskina Mary">		
      <comments>
			   <comment date="18/02/2004" author="Treskina Mary">
						<description>sozdanie tabov</description>
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

<%@ page import="com.apconsulting.luna.ejb.NormativeSentenze.*" %>

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

<% long lCOD_NOR_SEN=0;
   String s;
	INormativeSentenze bean=null;
	String strID = (String)request.getParameter("ID_PARENT");
	try{
		INormativeSentenzeHome home=(INormativeSentenzeHome)PseudoContext.lookup("NormativeSentenzeBean");
		bean = home.findByPrimaryKey(new Long(strID));
		lCOD_NOR_SEN=bean.getCOD_NOR_SEN();
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}

try{
	if (bean!=null){	
		String strCOD_NOR_SEN = new Long(lCOD_NOR_SEN).toString();
		if(request.getParameter("TAB_NAME").equals("tab1")){
			INormativeSentenzeHome ns_home=(INormativeSentenzeHome)PseudoContext.lookup("NormativeSentenzeBean");
			s=BuildNormativeSentenzeTab(ns_home, strCOD_NOR_SEN);
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
/* 	INormativeSentenzeHome home = Home intarface of NormativeSentenze
	String COD_NOR_SEN = COD_NOR_SEN of current NormativeSentenze
*/
String BuildNormativeSentenzeTab(INormativeSentenzeHome doc_home, String COD_NOR_SEN)
{
	String str;
	java.util.Collection cod_doc = doc_home.getNormativeSentenzeDocumenteByDOCID_View(new Long(COD_NOR_SEN).longValue());
	
	str="<table border='0' align='left' width='675' id='NormativeSentenzeHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='325'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong></td>";
	str+="<td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>";
	str+="<td width='150'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='675' id='NormativeSentenze' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_NOR_SEN)+"'>";
	str+="<td class='dataTd'><input type='text' name='TIT_DOC' class='inputstyle' readonly  value=''></td>";
	str+="<td class='dataTd'><input type='text' name='RSP_DOC' readonly class='inputstyle'  value=''></td>";
	str+="<td class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='inputstyle'  value=''></td></tr>";
	if ( !COD_NOR_SEN.equals("") ){
		java.util.Iterator it_doc = cod_doc.iterator();
 		while(it_doc.hasNext()){
			NormativeSentenzeDocumenteByDOCID_View tel=(NormativeSentenzeDocumenteByDOCID_View)it_doc.next();
	    str+="<tr INDEX='"+Formatter.format(COD_NOR_SEN)+"' ID='"+tel.COD_DOC+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 325px;' class='inputstyle'  value=\""+Formatter.format(tel.TIT_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value=\""+Formatter.format(tel.RSP_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 150px;' class='inputstyle'  value=\""+Formatter.format(tel.DAT_REV_DOC)+"\"></td>";
			str+="</tr>";
  		}
	}	
	str+="</table>";
	return str;
}
%>
