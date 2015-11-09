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

<%
	 String q;
	ISchedeInterventoPSD bean=null;
	String strID = (String)request.getParameter("ID_PARENT");
	try{
		ISchedeInterventoPSDHome home=(ISchedeInterventoPSDHome)PseudoContext.lookup("SchedeInterventoPSDBean");
		bean = home.findByPrimaryKey(new Long(strID));
		
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}

try{
	if (bean!=null){	
		  if(request.getParameter("TAB_NAME").equals("tab1")){
			  ISchedeInterventoPSDHome d_home=(ISchedeInterventoPSDHome)PseudoContext.lookup("SchedeInterventoPSDBean");
				q=SchedeInterventoPSDTab(d_home, strID);
				out.print(q);
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
 String SchedeInterventoPSDTab(ISchedeInterventoPSDHome home, String COD_SCH_INR_PSD)
{
	String str;
	java.util.Collection col_rst = home.getSchedeInterventoPSD_ForTab_View(new Long(COD_SCH_INR_PSD).longValue());
	
	str="<table border='0' align='left' width='848' id='SchedeInterventoPSDHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>";
	str+="<td width='500'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo") + "</strong></td>";
	str+="<td width='148'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='848' id='SchedeInterventoPSD' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX=\""+Formatter.format(COD_SCH_INR_PSD)+"\"><td width='200' class='dataTd'><input type='text' name='RSP_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td width='500' class='dataTd'><input type='text' name='TIT_DOC' readonly class='dataInput'  value=''></td><td width='150' class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_SCH_INR_PSD.equals("") ){
		java.util.Iterator it_rst = col_rst.iterator();
 		while(it_rst.hasNext()){
			SchedeInterventoPSD_ForTab_View rst=(SchedeInterventoPSD_ForTab_View)it_rst.next();
	    str+="<tr INDEX=\""+Formatter.format(COD_SCH_INR_PSD)+"\" ID=\""+rst.COD_DOC+"\">";
			str+="<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value=\""+Formatter.format(rst.RSP_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 500px;' class='inputstyle'  value=\""+Formatter.format(rst.TIT_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 148px;' class='inputstyle'  value=\""+Formatter.format(rst.DAT_REV_DOC)+"\"></td>";
			str+="</tr>";
  		}
	}// 	
	str+="</table>";
	return str;
}
 %>
