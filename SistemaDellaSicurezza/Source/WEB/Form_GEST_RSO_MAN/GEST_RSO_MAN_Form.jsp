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
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server

%>
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="GEST_RSO_MAN_Util.jsp" %>

<html>
<head>
	<title><%=GET_WINDOW_TITLE(request.getParameter("ATTACH_SUBJECT"))%></title>
</head>
<link rel="stylesheet" href="../_styles/style.css">
<link rel="stylesheet" href="../_styles/tabs.css">
<body style="margin:0 0 0 0;">
<%
	long lCOD_AZL=Security.getAzienda();
	Checker c = new Checker();		//
	long lCOD_MAN=0;     			//
  	IAttivitaLavorative bean=null;	//
//if (true) return;

if(request.getParameter("ID_PARENT")!=null)
{
	lCOD_MAN=Long.parseLong( request.getParameter("ID_PARENT") );
  	IAttivitaLavorativeHome home=(IAttivitaLavorativeHome)PseudoContext.lookup("AttivitaLavorativeBean");
	bean=home.findByPrimaryKey( new AttivitaLavorativePK(lCOD_AZL, lCOD_MAN) );
	lCOD_AZL=bean.getCOD_AZL();
}
%>
<table cellpadding="0" cellspacing="0" border="0" width="700">
<tr><td align="center" colspan="2" class="title"><%=GET_WINDOW_TITLE(request.getParameter("ATTACH_SUBJECT"))%><br></td></tr>
<tr><td valign="top">
<!-- ##################################################################################### -->
	<table border=0>
  		<%@ include file="../_include/ToolBar.jsp" %>
		<%//ToolBar.bShowNew=false;%>
		<%ToolBar.bShowSave=false;%>
		<%ToolBar.bShowSearch=false;%>
		<%ToolBar.bShowDelete=false;%>
		<%ToolBar.bShowPrint=false;%>
		<%=ToolBar.build(3)%>
	</table>
<!-- ##################################################################################### -->
<%
String SUBJECT=request.getParameter("ATTACH_SUBJECT");
// #### RISC ####
if ( SUBJECT.equals("RISC") ){%>
	<form action="GEST_RSO_MAN_Set.jsp?SBM_MODE=RISC" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
	<table border='0' id="Header" class='dataTableHeader' cellpadding='0' cellspacing='0' width="100%">
		<tr><td>&nbsp;</td><td>&nbsp;</td><td><b><%=ApplicationConfigurator.LanguageManager.getString("Abilita")%></b></td></tr>
		<tr>
		<td align='center' width='230'><b><%=ApplicationConfigurator.LanguageManager.getString("Rischio")%></b></td>
		<td align='center' width='300'><b><%=ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio")%></b></td>
		<td align='center' width='30'><input name="CHK_ALL" id="CHK_ALL" type="checkbox" class='dataInput2'  onclick="CheckAll(this)"></td>
		</tr>
	</table>
        <div class="tabScrDiv">
	<table id="DataTable" class='dataTable' cellpadding='0' cellspacing='0' border="0">
  	<%
  	if(bean!=null){
  		java.util.Collection col = bean.getNotAssRischi_View(lCOD_AZL);;
		java.util.Iterator it = col.iterator();
  		while(it.hasNext()){
			AttLav_NotAssRischi_View obj=(AttLav_NotAssRischi_View)it.next();
			%>
		   	<tr>
				<td class='dataTd' align="left"><input readonly type="Text" value="<%=Formatter.format(obj.strNOM_RSO)%>" class='dataInput' style="width:285px"></td>
				<td class='dataTd' align="left" ><input readonly type="Text" value="<%=Formatter.format(obj.strNOM_FAT_RSO)%>" class='dataInput' style="width:370px"></td>
				<td align="center">&nbsp<input name="CHK_ITEM" id="CHK_ITEM" type="checkbox" class='dataInput2' value="<%=Formatter.format(obj.lCOD_RSO)%>" style="width:20px"></td>
			</tr>
			<%
		}
	}
  	%>
	</table>
	</div>
	<input type="Hidden" value="<%=Formatter.format(lCOD_MAN)%>" name="COD_MAN">
	</form>  
<%}
// #### CORSO ####
if ( SUBJECT.equals("CORSO") ){%>
	<form action="GEST_RSO_MAN_Set.jsp?SBM_MODE=CORSO" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
	<table border='0' id="Header" class='dataTableHeader' cellpadding='0' cellspacing='0' width="100%">
		<tr><td></td><td></td><td></td><td><b><%=ApplicationConfigurator.LanguageManager.getString("Abilita")%></b></td></tr>
		<tr>
		<td align='center' width='50'><b><%=ApplicationConfigurator.LanguageManager.getString("Durata")%></b></td>
		<td align='center' width='250'><b><%=ApplicationConfigurator.LanguageManager.getString("Nome.corso")%></b></td>
		<td align='center' width='270'><b><%=ApplicationConfigurator.LanguageManager.getString("Tipologia.corso")%></b></td>
		<td align='center' width='30'><input name="CHK_ALL" id="CHK_ALL" type="checkbox" class='dataInput2' onclick="CheckAll(this)"></td>
		</tr>
	</table>
	<div class="tabScrDiv">
	<table id="DataTable" class='dataTable' cellpadding='0' cellspacing='0' border="0">
  	<%
  	if(bean!=null){
  		java.util.Collection col = bean.getNotAssCorsi_View();
		java.util.Iterator it = col.iterator();
  		while(it.hasNext()){
			AttLav_NotAssCorsi_View obj=(AttLav_NotAssCorsi_View)it.next();
			%>
		   	<tr>
			<td class='dataTd' width="50"><input readonly type="Text" value="<%=Formatter.format(obj.lDUR_COR_GOR)%>" class='dataInput'></td>
			<td class='dataTd' width="250"><input readonly type="Text" value="<%=Formatter.format(obj.strNOM_COR)%>" class='dataInput'></td>
			<td class='dataTd' width="300"><input readonly type="Text" value="<%=Formatter.format(obj.strNOM_TPL_COR)%>" class='dataInput'></td>
			<td width="30">&nbsp;<input name="CHK_ITEM" id="CHK_ITEM" type="checkbox" class='dataInput2' value="<%=Formatter.format(obj.lCOD_COR)%>"></td>
			</tr>
			<%
		}
	}
  	%>
	</table>
	</div>
	<input type="Hidden" value="<%=Formatter.format(lCOD_MAN)%>" name="COD_MAN">
	</form>  
<%}
// #### PROTOCOLO ####
if ( SUBJECT.equals("PROTOCOLO") ){%>
<form action="GEST_RSO_MAN_Set.jsp?SBM_MODE=PROTOCOLO" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
	<table border='0' id="Header" class='dataTableHeader' cellpadding='0' cellspacing='0' width="100%">
		<tr><td></td><td><b><%=ApplicationConfigurator.LanguageManager.getString("Abilita")%></b></td></tr>
		<tr>
		<td align='center' width='580'><b><%=ApplicationConfigurator.LanguageManager.getString("Nome.protocollo")%></b></td>
		<td align='center' width='30'><input name="CHK_ALL" id="CHK_ALL" type="checkbox" class='dataInput2' onclick="CheckAll(this)"></td>
		</tr>
	</table>
	<div class="tabScrDiv">
	<table id="DataTable" class='dataTable' cellpadding='0' cellspacing='0' border="0">
  	<%
  	if(bean!=null){
  		java.util.Collection col = bean.getNotAssProtocoli_View(lCOD_AZL);
		java.util.Iterator it = col.iterator();
  		while(it.hasNext()){
			AttLav_NotAssProtocoli_View obj=(AttLav_NotAssProtocoli_View)it.next();
			%>
		   	<tr>
			<td class='dataTd' width="570"><input readonly type="Text" value="<%=Formatter.format(obj.strNOM_PRO_SAN)%>" class='dataInput'></td>
			<td width="30">&nbsp;<input name="CHK_ITEM" id="CHK_ITEM" type="checkbox" class='dataInput2' value="<%=Formatter.format(obj.lCOD_PRO_SAN)%>"></td>
			</tr>
			<%
		}
	}
  	%>
	</table>
	<input type="Hidden" value="<%=Formatter.format(lCOD_MAN)%>" name="COD_MAN">
	</div>
	</form>  
<%}
// #### DPI ####
if ( SUBJECT.equals("DPI") ){%>
<form action="GEST_RSO_MAN_Set.jsp?SBM_MODE=DPI" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
	<table border='0' id="Header" class='dataTableHeader' cellpadding='0' cellspacing='0' width="100%">
		<tr><td></td><td></td><td></td><td><b><%=ApplicationConfigurator.LanguageManager.getString("Abilita")%></b></td></tr>
		<tr>
		<td align='center' width='470'><b><%=ApplicationConfigurator.LanguageManager.getString("Tipologia.D.P.I.")%></b></td>
		<td align='center' width='50'><b><%=ApplicationConfigurator.LanguageManager.getString("Sostituzione")%></b></td>
		<td align='center' width='50'><b><%=ApplicationConfigurator.LanguageManager.getString("Manutenzione")%></b></td>
		<td align='center' width='30'><input name="CHK_ALL" id="CHK_ALL" type="checkbox" class='dataInput2' onclick="CheckAll(this)"></td>
		</tr>
	</table>
	<div class="tabScrDiv">
	<table id="DataTable" class='dataTable' cellpadding='0' cellspacing='0' border="0">
  	<%
  	if(bean!=null){
  		java.util.Collection col = bean.getNotAssDPI_View(lCOD_AZL);
		java.util.Iterator it = col.iterator();
  		while(it.hasNext()){
			AttLav_NotAssDPI_View obj=(AttLav_NotAssDPI_View)it.next();
			%>
		   	<tr>
			<td class='dataTd' width="470"><input readonly type="Text" value="<%=Formatter.format(obj.strNOM_TPL_DPI)%>" class='dataInput'></td>
			<td class='dataTd' width="50"><input readonly type="Text" value="<%=Formatter.format(obj.lPER_MES_SST)%>" class='dataInput'></td>
			<td class='dataTd' width="50"><input readonly type="Text" value="<%=Formatter.format(obj.lPER_MES_MNT)%>" class='dataInput'></td>
			<td width="30">&nbsp;<input name="CHK_ITEM" id="CHK_ITEM" type="checkbox" class='dataInput2' value="<%=Formatter.format(obj.lCOD_TPL_DPI)%>"></td>
			</tr>
			<%
		}
	}
  	%>
	</table>
	</div>
	<input type="Hidden" value="<%=Formatter.format(lCOD_MAN)%>" name="COD_MAN">
	</form>  
<%}
// #############
%>
</td></tr></table>
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
<script>
ToolBar.Return.setEnabled(true);
var OldReturn= ToolBar.Return.OnClick;
ToolBar.Return.OnClick=OnReturn;
// -- OnReturn --
function OnReturn(){
	document.forms(0).submit();
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// -- table correction --
adaptTable(document.all["Header"], document.all["DataTable"]);
function adaptTable(tableHeader, table){
	counter = new Object();
	counter.i=0;
	counter.y=0;
	counter.z=0;	
	for (counter.i=0; counter.i< table.rows.length; counter.i++){
		for (counter.y=0; counter.y<table.rows[counter.i].cells.length; counter.y++){
			iCol = table.rows[counter.i].cells[counter.y].getElementsByTagName("INPUT");
			for (counter.z=0; counter.z< iCol.length; counter.z++){
				if (iCol[counter.z].type=="text"){
					width = tableHeader.rows[0].cells[counter.y].offsetWidth;
					iCol[counter.z].width= width;
					table.rows[counter.i].cells[counter.y].style.width=width;
					break;
				}
			}
		}
	}
	counter=null;
}
// --- check all ---
function CheckAll(selector){
	//selector.checked=!selector.checked;
	if(selector.checked==true){
		for(i=1; i < document.forms(0).elements.length; i++ ){
			obj_type=document.forms(0).elements(i).type;
			obj		=document.forms(0).elements(i);
			if(obj_type=="checkbox"){
				obj.checked = true ;
			}	
		}
	}else{
		for(i=1; i < document.forms(0).elements.length; i++ ){
			obj_type=document.forms(0).elements(i).type;
			obj		=document.forms(0).elements(i);
			if(obj_type=="checkbox"){
				obj.checked = false ;
			}	
		}
	}
}
//------------------------------------------------------------
</script>
</body>
</html>
