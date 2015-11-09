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
<%@ page import="com.apconsulting.luna.ejb.UnitaSicurezza.*" %>

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
	long lCOD_UNI_SIC=0;
	IUnitaSicurezza bean=null;
	IUnitaSicurezzaHome home=null;
	String strID = (String)request.getParameter("ID_PARENT");
	try{
		home=(IUnitaSicurezzaHome)PseudoContext.lookup("UnitaSicurezzaBean");
		bean = home.findByPrimaryKey(new Long(strID));
		lCOD_UNI_SIC=bean.getCOD_UNI_SIC();
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}

try{
	if (bean!=null){	
		if(request.getParameter("TAB_NAME").equals("tab1")){
			out.println(BuildUnitaSicurezzaTab(home,lCOD_UNI_SIC));
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
String BuildUnitaSicurezzaTab(IUnitaSicurezzaHome home, long COD_UNI_SIC){
	String str="";
	java.util.Collection col_org = home.getOrganizativaByUNISICID_View(COD_UNI_SIC);
	str="<table border='0' align=\"left\" id='OrganizativaHeader' class='dataTableHeader' cellpadding='0' cellspacing='0' style='width:95%'>";
	str+="<tr><td><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td></tr></table>";
	str+="<table border='1' id='Organizativa' align=\"left\" style=\"width:95%\" class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr INDEX=\""+COD_UNI_SIC+"\" id='' style='display:none'>";
	str+="<td class='dataTd' ><input type='text' readonly class='dataInput'  value=\"\"></td>";
	str+="</tr>";
	if ( COD_UNI_SIC!=0 ){
		java.util.Iterator it_org = col_org.iterator();
 		while(it_org.hasNext()){
			Organizativa_View org=(Organizativa_View)it_org.next();
			str+="<tr INDEX=\""+COD_UNI_SIC+"\" id=\""+Formatter.format(org.COD_UNI_ORG)+"&IDD="+org.COD_DPD+"'>";
			str+="<td class='dataTd'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(org.NOM_UNI_ORG)+"\"></td>";
			str+="</tr>";
  		}
	}
	str+="</table>";
	return str;
}
	
%>
