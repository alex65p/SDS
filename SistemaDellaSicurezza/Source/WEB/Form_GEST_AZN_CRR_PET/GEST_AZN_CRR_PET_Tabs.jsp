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
			   <comment date="27/02/2004" author="Pogrebnoy Yura">
				   izmenil dlya formi GEST_AZN_CRR_PET_Form
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
<%@ page import="com.apconsulting.luna.ejb.AzioniCorrectivePreventive.*" %>

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
	String strCOD_AZN_CRR_PET="";
	IAzioniCorrectivePreventive bean=null;
	IAzioniCorrectivePreventiveHome home=(IAzioniCorrectivePreventiveHome)PseudoContext.lookup("AzioniCorrectivePreventiveBean");

	strCOD_AZN_CRR_PET = Formatter.format(request.getParameter("ID_PARENT"));
//	out.print("<script>alert();</script>");
	try{
		bean = home.findByPrimaryKey(new Long(strCOD_AZN_CRR_PET));
	}
	catch(Exception ex){
		out.print("<script>alert('try error');</script>");
		return;
	}
try{
	if (bean!=null){
		if(request.getParameter("TAB_NAME").equals("tab3")){
			out.println(BuildDocumentoTab(home, strCOD_AZN_CRR_PET));
		}else{
		   return;
		}
	}
}
catch(Exception ex){
	out.print("<script>alert('try2 error');</script>");
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
String BuildDocumentoTab(IAzioniCorrectivePreventiveHome acp_home, String COD_AZN_CRR_PET)
{
	String str;
	java.util.Collection col_nr = acp_home.getDocumentByAZN_CRR_ID_View(new Long(COD_AZN_CRR_PET).longValue());
	
	str="<table border='0' align='left' width='760' id='DocumentoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0' width='100%'>";
	str+="<tr><td width='410'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong></td>";
	str+="<td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>";
	str+="<td width='150'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='760' id='Documento' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX=\""+Formatter.format(COD_AZN_CRR_PET)+"\">";
	//TIT_DOC RSP_DOC DAT_REV_DOC
	str+="<td class='dataTd'><input type='text' name='' class='dataInput' readonly  value=''></td>";
	str+="<td class='dataTd'><input type='text' name='' readonly class='dataInput'  value=''></td>";
	str+="<td class='dataTd'><input type='text' name='' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_AZN_CRR_PET.equals("") ){
		java.util.Iterator it_nr = col_nr.iterator();
 		while(it_nr.hasNext()){
			DocumentByAZN_CRR_ID_View nr=(DocumentByAZN_CRR_ID_View)it_nr.next();
	    str+="<tr INDEX=\""+Formatter.format(COD_AZN_CRR_PET)+"\" ID=\""+nr.COD_DOC+"\">";
			str+="<td class='dataTd'><input type='text' readonly style='width: 410px;' class='inputstyle'  value=\""+Formatter.format(nr.TIT_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value=\""+Formatter.format(nr.RSP_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 150px;' class='inputstyle'  value=\""+Formatter.format(nr.DAT_REV_DOC)+"\"></td>";
			str+="</tr>";
  		}
	}
	str+="</table>";
	
	return str;
}
%>
