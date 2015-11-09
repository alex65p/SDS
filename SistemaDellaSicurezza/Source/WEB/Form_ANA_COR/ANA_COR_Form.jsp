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
<%@ page import="com.apconsulting.luna.ejb.Corsi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/DocentiCorso/DocentiCorsoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DocentiCorso/DocentiCorsoBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/TipologiaCorsi/TipologiaCorsiBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TipologiaCorsi/TipologiaCorsiBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="ANA_COR_Util.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuCorsi,1) + "</title>");
</script>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">
<link rel="stylesheet" href="../_styles/style.css">
<link rel="stylesheet" href="../_styles/tabs.css">
<script language="JavaScript" src="../_scripts/tabs.js"></script>
<script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
</head>

<script>
window.dialogWidth="800px";
window.dialogHeight="540px";
</script>

<%
	long lCOD_COR = 0;
	String strCOD_COR = "";
	String strDUR_COR_GOR = "";
	String strNOM_COR = "";
	String strDES_COR = "";
	String strUSO_ATE_FRE_COR = "";
	String strUSO_PTG_COR = "";
	long lCOD_TPL_COR = 0;

ICorsi corsi=null;

if( request.getParameter("ID")!=null)
{
	strCOD_COR = request.getParameter("ID");
	// editing of corsi
	//getting of corsi object
	ICorsiHome home=(ICorsiHome)PseudoContext.lookup("CorsiBean"); 
	Long COD_COR=new Long(strCOD_COR);
	corsi = home.findByPrimaryKey(COD_COR);

	// getting of object variables
	lCOD_COR = corsi.getCOD_COR();
	strDUR_COR_GOR = Formatter.format(corsi.getDUR_COR_GOR());
	strNOM_COR = Formatter.format(corsi.getNOM_COR());
	strDES_COR = Formatter.format(corsi.getDES_COR());
	strUSO_ATE_FRE_COR = Formatter.format(corsi.getUSO_ATE_FRE_COR());
	strUSO_PTG_COR = Formatter.format(corsi.getUSO_PTG_COR());
	lCOD_TPL_COR = corsi.getCOD_TPL_COR();
}
%>
<body  style="margin:0 0 0 0;">
<form action="ANA_COR_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input type="hidden" name="SBM_MODE" value="<%=(lCOD_COR==0)?"new":"edt"%>">
<input type="hidden" name="COD_COR" value="<%=lCOD_COR%>">
<input type="hidden" name="ID_PARENT" value="<%=request.getParameter("ID_PARENT")%>">
<table summary="" border="0" width="100%">
<tr><td>
</td></tr>
<tr><td class="title" colspan="100%">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuCorsi,1,<%=request.getParameter("ID")%>));
    </script>
</td></tr>
</td></tr>
</td><td valign="top">

<table border="0">
<!-- ############################ -->  		
	<%@ include file="../_include/ToolBar.jsp" %>      
	<%ToolBar.bCanDelete=(corsi!=null);%>
	<%ToolBar.strPrintUrl="SchedaCorso.jsp?";%>		
	<%=ToolBar.build(5)%> 
<!-- ########################### --> 
</table>

<fieldset> 
<legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.corso")%></legend>
<table summary="" border="0" width="100%">
<tr>
	<td width="15%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Durata.corso.(h)")%>&nbsp;</b></td>
	<td width="29%" valign="bottom"><input tabindex="1" type="text" name="DUR_COR_GOR" value="<%=strDUR_COR_GOR%>"></td>
	<td width="40%" align="left" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Punteggio.corso")%>&nbsp;
	<input tabindex="2" type="checkbox" class="checkbox" name="USO_PTG_COR" value="S" <%=(strUSO_PTG_COR.equals("S"))?"checked":""%>></td>
</tr>
<tr>
	<td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome.corso")%>&nbsp;</b></td>
	<td><input tabindex="3" type="text" maxlength="50" size="42" name="NOM_COR" value="<%=strNOM_COR%>"></td>
	<td align="right" width="14.5%"><b><%=ApplicationConfigurator.LanguageManager.getString("Tipologia.corso")%>&nbsp;</b></td>
	<td align="left" width="36%"><select tabindex="4" name="COD_TPL_COR" style="width:200px">
		<option value=""></option>
<%
	ITipologiaCorsiHome tlp_cor_home=(ITipologiaCorsiHome)PseudoContext.lookup("TipologiaCorsiBean");
	String tlp_cor_cb=BuildTplCorsiComboBox(tlp_cor_home, lCOD_TPL_COR);
	out.print(tlp_cor_cb);
%>
	</select></td>
</tr>
<tr>
	<td align="right" ><%=ApplicationConfigurator.LanguageManager.getString("Attestato.di.frequenza")%>&nbsp;</td>
	<td><input tabindex="5" type="checkbox" class="checkbox" name="USO_ATE_FRE_COR" value="S" <%=(strUSO_ATE_FRE_COR.equals("S"))?"checked":""%>></td>
</tr>
<tr>
	<td valign="top" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione.corso")%>&nbsp;</td>
	<td colspan="3"><textarea tabindex="6" rows="4" cols="70" name="DES_COR"><%=strDES_COR%></textarea></td>
</tr>
</table>
</fieldset>
<table width="100%">
<tr>
	<td><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
</tr>
</table>	 
</td></tr>
</table>
</form>
<!-- /form for addind Dipendente -->
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
<%
if(corsi!=null) {
	/*
	String s;
	//
	ICorsiHome lfHome=(ICorsiHome)PseudoContext.lookup("CorsiBean");
	s=BuildTestVerificaTab(lfHome, lCOD_COR);
	out.print(s);
	s=BuildMaterialeCorsoTab(lfHome, lCOD_COR);
	out.print(s);
	IDocentiCorsoHome dcHome=(IDocentiCorsoHome)PseudoContext.lookup("DocentiCorsoBean");
	s=BuildDocentiCorsoTab(dcHome, lCOD_COR);
	out.print(s);
	*/
// -----------------------------------------
%>
<script language="JavaScript" src="../_scripts/index.js"></script>
<script language="JavaScript">
/*	function TestVerificaDialogParams(){
		obj = new DialogParameters();
		obj.nome = "";
		obj.codTesVrf="";
		obj.toRow = function (row){
			row.id = this.ID;
			row.INDEX = this.codAre;
			colInput=row.getElementsByTagName("INPUT");
			colInput[0].value=this.nome;
			return row;
		}
		return obj;
	}
	function MaterialeCorsoDialogParams(){
		obj = new DialogParameters();
		obj.nome = "";
		obj.codTesVrf="";
		obj.toRow = function (row){
			row.id = this.ID;
			row.INDEX = this.codAre;
			colInput=row.getElementsByTagName("INPUT");
			colInput[0].value=this.nome;
			return row;
		}
		return obj;
	}
	*/
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
   
   	
         tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Test.di.verifica")%>", tabbar));
	tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Materiale.corso")%>", tabbar));
	tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Docenti.corso")%>", tabbar));
	tabbar.idParentRecord = <%=lCOD_COR%>;
	tabbar.DEBUG_TABS_IFRM = false;
	tabbar.refreshTabUrl="ANA_COR_Tabs.jsp";	
	tabbar.RefreshAllTabs();
				

tabbar.tabs[0].tabObj.actionParams ={
		 "Feachures": ANA_TES_VRF_Feachures,
		 "AddNew":	{"url":"../Form_ANA_TES_VRF/ANA_TES_VRF_Form.jsp?ATTACH_URL=Form_ANA_COR/ANA_COR_Attach.jsp&ATTACH_SUBJECT=TES_VRF", 
			"buttonIndex":0	
			},
		 "Delete":	{"url":"../Form_ANA_COR/ANA_COR_Delete.jsp?LOCAL_MODE=TES_VRF",
					"buttonIndex":2,
					"target_element":document.all["ifrmWork"]	
		 			},		
		 "Edit":	{"url":"../Form_ANA_TES_VRF/ANA_TES_VRF_Form.jsp?ATTACH_URL=Form_ANA_COR/ANA_COR_Attach.jsp&ATTACH_SUBJECT=TES_VRF",
					"buttonIndex":1	
		 			}			  	
		}; 
	tabbar.tabs[1].tabObj.actionParams ={
				"Feachures": ANA_DOC_Feachures,
				"AddNew":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_COR/ANA_COR_Attach.jsp&ATTACH_SUBJECT=DOC", 
				"whidth":"750px",
				"height":"700px",
				"buttonIndex":0	
		  	},
			 "Delete":	{"url":"../Form_ANA_COR/ANA_COR_Delete.jsp?LOCAL_MODE=DOC",
						"buttonIndex":2,
						"target_element":document.all["ifrmWork"]	
			 			},		
			 "Edit":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_COR/ANA_COR_Attach.jsp&ATTACH_SUBJECT=DOC",
				"whidth":"750px",
				"height":"700px",
						"buttonIndex":1	
			 			}			  	
			}; 
	tabbar.tabs[2].tabObj.actionParams ={
   									 "Feachures": DCT_COR_Feachures,
										 "AddNew":	{"url":"../Form_DCT_COR/DCT_COR_Form.jsp", 
													"buttonIndex":0
												  	},
										 "Delete":	{"url":"../Form_DCT_COR/DCT_COR_Delete.jsp",
													"buttonIndex":2,
													"target_element":document.all["ifrmWork"]	
										 			},		
										 "Edit":	{"url":"../Form_DCT_COR/DCT_COR_Form.jsp",
													"buttonIndex":1
										 			}			  	
										}; 									

</script>
<script type="text/javascript">
/*if (document.all("ID_PARENT").value!= "") {
   ToolBar.Return.setEnabled(false);
}*/
</script>
 <%} else {%>
 <script>
    window.dialogHeight="310px";
 </script>
 <%}%>

</body>
</html>
