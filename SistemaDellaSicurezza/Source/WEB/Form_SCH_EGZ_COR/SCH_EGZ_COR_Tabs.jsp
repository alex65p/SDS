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
    <version number="1.0" date="13/05/2004" author="Treskina Mary">		
      <comments>
			   <comment date="13/05/2004" author="Treskina Mary">
				file Tabs for SCH_EGZ_COR
			   </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.ErogazioneCorsi.*" %>

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
<% long lCOD_SCH_EGZ_COR=0, lCOD_AZL=0;
	  String	strRAG_SCL_AZL;
   String s;
	IErogazioneCorsi bean=null;
	IAzienda azienda;

	String strID = (String)request.getParameter("ID_PARENT");
	
	try{
		IErogazioneCorsiHome home=(IErogazioneCorsiHome)PseudoContext.lookup("ErogazioneCorsiBean");
		bean = home.findByPrimaryKey(new Long(strID));
		lCOD_SCH_EGZ_COR=bean.getCOD_SCH_EGZ_COR();
		lCOD_AZL		=bean.getCOD_AZL();
		
		IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");
		Long azl_id=new Long(lCOD_AZL);
		azienda = AziendaHome.findByPrimaryKey(azl_id);
		strRAG_SCL_AZL= azienda.getRAG_SCL_AZL();
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}

try{
	if (bean!=null){	
		String strCOD_SCH_EGZ_COR = new Long(lCOD_SCH_EGZ_COR).toString();
		if(request.getParameter("TAB_NAME").equals("tab1")){
			IErogazioneCorsiHome rst_home=(IErogazioneCorsiHome)PseudoContext.lookup("ErogazioneCorsiBean");
			s=ErogazioneCorsiTab(rst_home, lCOD_SCH_EGZ_COR, strRAG_SCL_AZL);
			out.print(s);
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
String ErogazioneCorsiTab(IErogazioneCorsiHome home, long COD_SCH_EGZ_COR, String RAG_AZL)
{
	String str;
	String sRAG_SCL="";
	java.util.Collection col_rst = home.getErogazioneCorsi_ForTabDPD_View(COD_SCH_EGZ_COR);

	str="<table border='0' align='left' width='750' id='ErogazioneCorsiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='250'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nominativo.lavoratore") + "</strong></td>";
	str+="<td width='250'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Azienda/Ente") + "</strong></td>";
	str+="<td width='250'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Matricola") + "</strong></td></tr>";

	//java.util.Collection col_rst = home.getErogazioneCorsi_ForTabDPD_View(COD_SCH_EGZ_COR);
	str="<table border='0' align='left' width='750' id='ErogazioneCorsiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='250'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nominativo.lavoratore") + "</strong></td>";
	str+="<td width='250'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Azienda/Ente") + "</strong></td>";
	str+="<td width='250'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Matricola") + "</strong></td></tr>";

	str+="</table>";
	
	str+="<table border='0' aligne='left' width='750' id='ErogazioneCorsi' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' IDCORSI='' INDEX=\""+Formatter.format(COD_SCH_EGZ_COR)+"\"><td width='250' class='dataTd'><input type='text' name='RSP_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td width='250' class='dataTd'><input type='text' name='TIT_DOC' readonly class='dataInput'  value=''></td><td width='250' class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='dataInput'  value=''></td></tr>";
	if ( COD_SCH_EGZ_COR!=0 ){
		java.util.Iterator it_rst = col_rst.iterator();
 		while(it_rst.hasNext()){
			ErogazioneCorsi_ForTabDPD_View rst=(ErogazioneCorsi_ForTabDPD_View)it_rst.next();
	    if (rst.COD_AZL!=0){
			sRAG_SCL = home.getErogazioneCorsi_ForTabByAZL_View(rst.COD_AZL);
	    }else{
			if (rst.COD_DTE!=0){
			sRAG_SCL=home.getErogazioneCorsi_ForTabByDTE_View(rst.COD_DTE);
		}
		}
	    str+="<tr INDEX=\""+Formatter.format(COD_SCH_EGZ_COR)+"\"ID=\""+rst.COD_DPD+"\">";
			str+="<td class='dataTd'><input type='text' readonly style='width: 250px;' class='inputstyle'  value=\""+Formatter.format(rst.COG_DPD)+" "+Formatter.format(rst.NOM_DPD)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 250px;' class='inputstyle'  value=\""+Formatter.format(RAG_AZL)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 250px;' class='inputstyle'  value=\""+Formatter.format(rst.MTR_DPD)+"\"></td>";
			str+="</tr>";
  		}
	}// 	
	str+="</table>";
	return str;
}

%>
