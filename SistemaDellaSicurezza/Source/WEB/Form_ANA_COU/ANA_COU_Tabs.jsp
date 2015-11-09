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
    <version number="1.0" date="18/02/2004" author="Malyuk Sergey">		
      <comments>
			   <comment date="18/02/2004" author="Malyuk Sergey">
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
<%@ page import="com.apconsulting.luna.ejb.Consulente.*" %>

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
	long lCOD_COU=0;
	IConsultant bean=null;
	IConsultantHome home=null;
	String strID = (String)request.getParameter("ID_PARENT");
	try{
		home=(IConsultantHome)PseudoContext.lookup("ConsultantBean");
		bean = home.findByPrimaryKey(new Long(strID));
		lCOD_COU=bean.getCOD_COU();
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}

try{
	if (bean!=null){	
		if(request.getParameter("TAB_NAME").equals("tab1")){
			out.println(BuildConsultanteTab(home,new Long(lCOD_COU).toString()));
		}
		else{
			return;
		}
	}
}
catch(Exception ex){
	// out.print(printErrAlert("divErr", "Error.alert", ex));
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
String BuildConsultanteTab(IConsultantHome home, String COD_COU){
	String str="";
	java.util.Collection col_azass = home.getAziendeAssociateByCOUID_View(COD_COU);
	str="<table border='0' align='left' width='863' id='AziendeAssociateHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='289'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Ragione.sociale") + "</strong></td>";
	str+="<td width='287'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro") + "</strong></td>";
	str+="<td width='287'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile.S.P.P.") + "</strong></td></tr>";
	str+="</table>";
        str+="<table border='0'align='left' width='863' id='AziendeAssociate' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr INDEX='"+COD_COU+"' id='' style='display:none'>";
	str+="<td width='289' class='dataTd'><input type='text' readonly class='inputstyle'  value=\"\"></td>";
	str+="<td width='287' class='dataTd'><input type='text' readonly class='inputstyle'  value=\"\"></td>";
	str+="<td width='287' class='dataTd'><input type='text' readonly class='inputstyle'  value=\"\"></td>";
	str+="</tr>";
	if ( !COD_COU.equals("") ){
		java.util.Iterator it_azass = col_azass.iterator();
 		while(it_azass.hasNext()){
			AziendeAssociateByCOUID_View azass=(AziendeAssociateByCOUID_View)it_azass.next();
			str+="<tr INDEX='"+COD_COU+"' id='"+Formatter.format(azass.COD_AZL)+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 289px;' class='inputstyle'  value=\""+Formatter.format(azass.RAG_SCL_AZL)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 287px;' class='inputstyle'  value=\""+Formatter.format(azass.NOM_RSP_AZL)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 287px;' class='inputstyle'  value=\""+Formatter.format(azass.NOM_RSP_SPP_AZL)+"\"></td>";
			str+="</tr>";
  		}
	}
	str+="</table>";
	return str;
}
	
%>
