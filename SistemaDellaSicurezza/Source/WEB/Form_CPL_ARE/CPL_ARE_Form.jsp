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
	<version number="1.0" date="05/02/2004" author="Khomenko Juliya">
		  <comments>
				  <comment date="05/02/2004" author="Khomenko Juliya">
				   <description>Shablon formi CPL_ARE_Form.jsp</description>
				  </comment>
				  <comment date="05/02/2004" author="Mike Kondratyuk">
				   <description>Forma CPL_ARE_Form.jsp</description>
				  </comment>
		</comments>
	</version>
  </versions>
</file>
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.GestioniSezioni.*" %>
<%@ page import="com.apconsulting.luna.ejb.Capitoli.*" %>
<%@ page import="com.apconsulting.luna.ejb.Paragrafo.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="CPL_ARE_Util.jsp"%>
<%@ include file="../_include/ToolBar.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
<head>
<title><%=ApplicationConfigurator.LanguageManager.getString("Associativa.capitoli/sezioni")%></title>
<LINK REL=STYLESHEET
	  HREF="../_styles/style.css"
	  TYPE="text/css">
<link rel="stylesheet" href="../_styles/tabs.css">
<script language="JavaScript" src="../_scripts/tabs.js"></script>
<script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>

<script>
	window.dialogWidth="720px";
	window.dialogHeight="530px";
</script>
</head>
<body>
<%
	IAzienda azienda;
	IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");

	IGestioniSezioni GestioniSezioni = null;
	IGestioniSezioniHome home=(IGestioniSezioniHome)PseudoContext.lookup("GestioniSezioniBean");

	ICapitoliHome capitoliHome = (ICapitoliHome)PseudoContext.lookup("CapitoliBean");
	IParagrafoHome paragrHome = (IParagrafoHome)PseudoContext.lookup("ParagrafoBean");

	long	lCOD_ARE = 0;
	long	lCOD_AZL = 0;
	long 	lCOD_CPL = 0;
	String	strDES_CPL_ARE = "";

	String	strNOM_ARE = "";
	String	strNOM_AZL = "";

	long 	lPRIORITY = 0;

	lCOD_AZL = Security.getAzienda();
	if(request.getParameter("ID_PARENT")!=null)
	{
		lCOD_ARE = (new Long(request.getParameter("ID_PARENT"))).longValue();

		Long are_id=new Long(lCOD_ARE);
		GestioniSezioni = home.findByPrimaryKey(are_id);
		strNOM_ARE = GestioniSezioni.getNOM_ARE();
		lCOD_AZL   = GestioniSezioni.getCOD_AZL();

		if(request.getParameter("ID")!=null)
		{
			lCOD_CPL = (new Long(request.getParameter("ID"))).longValue();

			java.util.Collection col = home.getGestioniSezioni_CplAre_View(lCOD_ARE, lCOD_AZL, lCOD_CPL);
			java.util.Iterator it = col.iterator();
			while(it.hasNext()){
				GestioniSezioni_CplAre_View obj=(GestioniSezioni_CplAre_View)it.next();
				strDES_CPL_ARE = Formatter.format(obj.DES_CPL_ARE);
				lPRIORITY = obj.PRIORITY;
			}
		}
	}

	// Get Aziende/Ente
	Long azl_id=new Long(lCOD_AZL);
	azienda = AziendaHome.findByPrimaryKey(azl_id);
	strNOM_AZL= azienda.getRAG_SCL_AZL();
	
	if(Security.getCurrentDvrUniOrgName()!=null){
		strNOM_AZL+=", "+Security.getCurrentDvrUniOrgName();
	}
%>

<!-- form for addind  piano-->
<form action="CPL_ARE_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="hidden" value="<%=(lCOD_CPL==0)?"new":"edt"%>">
<input type="hidden" name="ID_PARENT" value="<%=lCOD_ARE%>">
<input type="hidden" name="COD_AZL" value="<%=lCOD_AZL%>">
<table width="100%" border="0">
<tr>
 <td valign="top">
  <table  width="100%">
  <tr><td class="title"><%=ApplicationConfigurator.LanguageManager.getString("Associativa.capitoli/sezioni")%></td></tr>
  <tr>
	<td>
	<table width="100">
	<!-- ############################ -->
<%ToolBar.bCanDelete=(GestioniSezioni!=null);
if(request.getParameter("ID_PARENT")!=null)
{
	ToolBar.strSearchUrl=ToolBar.strSearchUrl.replace('&', '|');
}
//ToolBar.bShowPrint=false;
//ToolBar.bShowReturn=false;
%>
<%=ToolBar.build(3)%>
<!-- ########################### -->

	</table>
  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Capitolo/Sezione")%></legend>
   <table  width="100%" border="0">
   <tr>
   <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
	 <td ><input size="113" maxlength="50" type="text" readonly value="<%=strNOM_AZL%>">
   </td></tr>
   <tr>
   <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Sezione")%>&nbsp;</b></td>
	 <td ><input size="113" maxlength="50" type="text" readonly value="<%=strNOM_ARE%>">
   </td></tr>
   <tr>
   <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Capitolo")%>&nbsp;</b></td>
	 <td>
<%
if (lCOD_CPL != 0){
%>
	 <select style="width:590" disabled>
	   <%=BuildCapitoliComboBox(capitoliHome, lCOD_CPL)%>
	</select>
	<input type="hidden" name="ID" value="<%=lCOD_CPL%>">
<%}else{%>
	 <select name="ID" style="width:590">
		<option value=""></option>
	   <%=BuildCapitoliComboBox(capitoliHome, lCOD_CPL)%>
	</select>
<%}%>
   </td></tr>
	 <tr>
       <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
		<td><textarea rows="2" cols="100" name="DES_CPL_ARE"><%=strDES_CPL_ARE%></textarea>
<!--		<td><input name="DES_CPL_ARE" value="<%=strDES_CPL_ARE%>" maxlength="10" style="width:544"></input>-->
	 </td></tr>
	 <tr>
	   <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Priorità")%>&nbsp;</td>
		<td><input name="PRIORITY" value="<%=lPRIORITY%>" maxlength="10" style="width:590"></input>
	 </td></tr>
   </table>
	 </fieldset></td></tr>
  </table>
 </td>
</tr>
<tr>
	<td colspan="100%"><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
</tr>
</table>
</form>
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
<%
if (lCOD_CPL != 0 && lCOD_ARE != 0 && lCOD_AZL != 0)
{
%>
<script language="JavaScript" src="../_scripts/index.js"></script>
<script language="JavaScript">
/*	function ParagrafiParams(){
		obj = new DialogParameters();
		obj.nome = "";
		obj.codDocAre = "";
		obj.toRow = function (row){
			row.id = this.ID;
			row.INDEX = this.codDocAre;
			colInput=row.getElementsByTagName("INPUT");
			colInput[0].value=this.nome;
			return row;
		}
		return obj;
	}*/
	//--------BUTTONS description-----------------------
	btnParams = new Array();
	btnParams[0] = {"id":"btnNew",
					"onmousedown":btnDown,
					"onmouseup":btnOver,
					"onmouseover":btnOver,
					"onmouseout":btnOut,
					"onclick":addRow,
					"src":"../_images/NUOVO.gif",
					"action":"AddNew"
					};
	btnParams[1] = {"id":"btnEdit",
					"onmousedown":btnDown,
					"onmouseup":btnOver,
					"onmouseover":btnOver,
					"onmouseout":btnOut,
					"onclick":editRow,
					"src":"../_images/EDIT.gif",
					"action":"Edit"
					};
	btnParams[2] = {"id":"btnCancel",
					"onmousedown":btnDown,
					"onmouseup":btnOver,
					"onmouseover":btnOver,
					"onmouseout":btnOut,
					"onclick":delRow,
					"src":"../_images/DEL_DET.gif",
					"action":"Delete"
					};

	//--------creating tabs--------------------------
	var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
	var btnBar = new ButtonPanel("batPanel1", btnParams);
	tabbar.addButtonBar(btnBar);
	tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.paragrafi")%>", tabbar));

	//------adding dinamic tables to tab-----------------------
	tabbar.idParentRecord = <%=lCOD_CPL%>;
	tabbar.refreshTabUrl="CPL_ARE_Tabs.jsp?COD_ARE=<%=lCOD_ARE%>&COD_AZL=<%=lCOD_AZL%>";
	tabbar.RefreshAllTabs();

	//----add action parameters to tabs
	tabbar.tabs[0].tabObj.actionParams ={"AddNew":	{"url":"../Form_ANA_PRG/ANA_PRG_Form.jsp?ATTACH_URL=Form_CPL_ARE/CPL_ARE_Attach.jsp&ATTACH_SUBJECT=PAR&COD_CPL=<%=lCOD_CPL%>",
													"buttonIndex":0
												  	},
										 "Delete":	{"url":"../Form_ANA_PRG/ANA_PRG_Delete.jsp?deleteFromAreaTab=true",
													"buttonIndex":2,
//													"alert": "Under Construction",
													"target_element":document.all["ifrmWork"]
										 			},
										 "Edit":	{"url":"../Form_ANA_PRG/ANA_PRG_Form.jsp?ATTACH_URL=Form_CPL_ARE/CPL_ARE_Attach.jsp&ATTACH_SUBJECT=PAR&COD_CPL=<%=lCOD_CPL%>",
													"buttonIndex":1
										 			},
										"Feachures":ANA_PRG_Feachures
										};
	//-----activate first tab--------------------------
	tabbar.tabs[0].center.click();
</script>
<%
} else {
    out.println("<script>window.dialogHeight=\"300px\";</script>");
}
%>
</body>
</html>
