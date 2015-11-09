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
    <version number="1.0" date="26/02/2004" author="Treskina Mary">		
      <comments>
			   <comment date="26/02/2004" author="Treskina Mary">
					<description>sozdanie taba dla ANA_TES_VRF</description>
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

<%@ include file="../src/com/apconsulting/luna/ejb/TestVerifica/TestVerificaBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TestVerifica/TestVerificaBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script>
	var err = false;
</script>

<div id="dContent">

<% long lCOD_TES_VRF=0;
	 long lNUM_MAX_PTG=0;
   String s;
	ITestVerifica bean=null;
	String strID = (String)request.getParameter("ID_PARENT");
	try{
		ITestVerificaHome home=(ITestVerificaHome)PseudoContext.lookup("TestVerificaBean");
		bean = home.findByPrimaryKey(new Long(strID));
		lCOD_TES_VRF=bean.getCOD_TES_VRF();
		lNUM_MAX_PTG=bean.getNUM_MAX_PTG();
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}


//out.print("<script>parent.document.all["MAX"].value="+lNUM_MAX_PTG+";</script>");
	
	
try{
	if (bean!=null){	
		String strCOD_TES_VRF = new Long(lCOD_TES_VRF).toString();
		
		if(request.getParameter("TAB_NAME").equals("tab1")){
			ITestVerificaHome d_home=(ITestVerificaHome)PseudoContext.lookup("TestVerificaBean");
			s=BuildDomandeTab( d_home,  strCOD_TES_VRF);
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
 parent.document.all["MAX"].value=<%=lNUM_MAX_PTG %>;
 if (!err){
	  parent.tabbar.ReloadTabTable(document);
 }	
 </script>
 
<%!
//---------------FUNCTIONS FOR TABS-------------------------

/* 	--- Domande --- 
  ITestVerificaHome home = Home intarface of TestVerifica
	String COD_TES_VRF = COD_TES_VRF of current TestVerifica
*/
String BuildDomandeTab(ITestVerificaHome home, String COD_TES_VRF)
{
	String str;
	String str1;
	java.util.Collection col_dmd = home.getDomandeByTESVRFID_View(new Long(COD_TES_VRF).longValue());
	
	str="<table border='0' align='left' width='814' id='DomandeHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='614'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Domanda") + "</strong></td>";
	str+="<td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Punteggio.domanda") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='814' id='Domande' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_TES_VRF)+"'><td width='614' class='dataTd'><input type='text' name='IDE_DMD' class='dataInput' readonly  value=''></td>";
	str+="<td width='200' class='dataTd'><input type='text' name='DOMANDE' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_TES_VRF.equals("") ){
		java.util.Iterator it_dmd = col_dmd.iterator();
 		while(it_dmd.hasNext()){
		str1="";
			DomandeByTESVRFID_View dmd=(DomandeByTESVRFID_View)it_dmd.next();
			if (dmd.NUM_PTG_DMD!=0){str1=Formatter.format(dmd.NUM_PTG_DMD);}
    	str+="<tr INDEX='"+Formatter.format(COD_TES_VRF)+"' ID='"+dmd.COD_DMD+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 614px;' class='inputstyle'  value=\""+Formatter.format(dmd.NOM_DMD)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value=\""+str1+"\"></td>";
			str+="</tr>";
  		}
	}// TestVerifica = null	
	str+="</table>";
	return str;
} 

%>
