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

<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
<head><title><%=ApplicationConfigurator.LanguageManager.getString("Associazioni.unità.organizzativa/attività.lavorativa")%></title></head>
<link rel="stylesheet" href="../_styles/style.css">
<script>
window.dialogWidth="700px";
window.dialogHeight="240px";
</script>
<body style="margin:0 0 0 0;">
<%
  long lCOD_MAN=0;  	//1
  long lCOD_UNI_ORG=0;
  String strNOM_UNI_ORG = "";
  String strNOM_MAN = "";
  long lCOD_AZL=Security.getAzienda();
  
IAttivitaLavorative attivitaLavorative=null;
IAttivitaLavorativeHome attLavHome=(IAttivitaLavorativeHome)PseudoContext.lookup("AttivitaLavorativeBean"); 

IUnitaOrganizzativa bean=null;	

 if(request.getParameter("ID_PARENT")!=null){
		String strID = (String)request.getParameter("ID_PARENT");
	 	IUnitaOrganizzativaHome home=(IUnitaOrganizzativaHome)PseudoContext.lookup("UnitaOrganizzativaBean");	
		Long id=new Long(strID);
		bean = home.findByPrimaryKey(id);
		strNOM_UNI_ORG=bean.getNOM_UNI_ORG();
		lCOD_UNI_ORG = bean.getCOD_UNI_ORG();
 }// if request
 else{
 	
 }
 if (request.getParameter("ID")!=null){
	Checker c= new Checker();
	lCOD_MAN = c.checkLong("",request.getParameter("ID"), false);
	attivitaLavorative = attLavHome.findByPrimaryKey(new AttivitaLavorativePK(lCOD_AZL, lCOD_MAN));
	strNOM_MAN = attivitaLavorative.getNOM_MAN();
 }
%>

<form action="ANA_UNI_ORG_Attach.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<table cellpadding="0" cellspacing="0" border='0' width="100%">
  <tr><td style="height:5px"></td></tr>
  <tr><td class="title"><%=ApplicationConfigurator.LanguageManager.getString("Associazioni.unità.organizzativa/attività.lavorativa")%></td></tr>

<tr><td>
	<table>
		<tr>
			<td>
<!-- ############################################################################## -->
  		<%@ include file="../_include/ToolBar.jsp" %>
		<%ToolBar.bShowSearch=false;%>
		<%ToolBar.bShowDelete=false;%>
		<%ToolBar.bShowPrint=false;%>
		<%ToolBar.bShowReturn=false;%>
		<%ToolBar.bCanSave = (request.getParameter("ID")==null); %>
		<%=ToolBar.build(4)%>
<!-- ############################################################################## -->
		</td></tr>
	</table>

  <tr>
  <td align="center"  valign="top" class="title" height="100%">
  <fieldset style="width:100%">
   <table cellpadding="2" cellspacing="2" width="100%">
     <tr>
                     <td align="right" style="white-space:nowrap"><b><%=ApplicationConfigurator.LanguageManager.getString("Unità.organizzativa")%>&nbsp;</b></td>
		 <td colspan="2" style="width:100%">
		 	<input name="ID_PARENT" id="ID_PARENT" type="hidden" value="<%=lCOD_UNI_ORG%>">	
			
			<input name="NOM_UNI_ORG" style="width:100%" id="NOM_UNI_ORG" type="text" readonly value="<%=strNOM_UNI_ORG%>">	
		 </td>
      <tr>
	  	<td align="right" style="white-space:nowrap">
			<b><%=ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa")%>&nbsp;</b>
		</td>
		<td style="width:100%">
			<select id="ID" name="ID" style="width:100%">
				<% if (lCOD_MAN!=0){ %>
				<option value="<%= lCOD_MAN%>"><%= strNOM_MAN%></option>
				<% } else{%>
				<option value="0"></option>
				<%
						if (bean!=null){
							Collection col = bean.getAllAttivitaLavorativaView(lCOD_AZL);
							String attLav_cmb=BuildAttivitaLavorativaComboBox(col, lCOD_MAN);
					 		out.print(attLav_cmb);
						}
				   }
			%>
			</select></td>
	 </tr>
   </table></fieldset></td>
 </tr>
 <tr><td>&nbsp;</td></tr> 
</table>
</form>
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
<script>
	var btnRet, btnSave;
	function init(){
		btnRet = ToolBar.Return.getButton();
		btnSave = ToolBar.Save.getButton();
		btnSave.onclick=OnReturn;
	}
	function OnReturn(){
		obj = document.all["ID"];
		tb_url_Attach +="&ID="+obj.options[obj.selectedIndex].value;
		ToolBar.Return.OnClick();
	}
</script>
</body>
</html>
<%!

String BuildAttivitaLavorativaComboBox(java.util.Collection col, long SELECTED_ID){
	
	String str="";
	//java.util.Collection col = homeU.getAllAttivitaLavorativaView(lCOD_AZL);
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		AttivitaLavorativaView dt=(AttivitaLavorativaView)it.next();
		String strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.lCOD_MAN){strSEL="selected";} }
            str=str+"<option "+strSEL+" value=\""+Formatter.format(dt.lCOD_MAN)+"\">"+Formatter.format(dt.strNOM_MAN)+"</option>";
  	}
	return str;
}
%>
