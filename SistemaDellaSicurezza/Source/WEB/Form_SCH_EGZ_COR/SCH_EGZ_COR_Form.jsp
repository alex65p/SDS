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
    <version number="1.0" date="27/01/2004" author="Kushkarov Yura">
	      <comments>
				 <comment date="27/01/2004" author="Kushkarov Yura">
				   <description>SCH_EGZ_COR_Form.jsp</description>
				 </comment>
				 <comment date="08/03/2004" author="Roman Chumachenko">
				   <description>Remake and Report</description>
				 </comment>
				 <comment date="13/05/2004" author="Treskina Maria">
				   <description>izmenenie tabov na novij stil</description>
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
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.ErogazioneCorsi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="SCH_EGZ_COR_Util.jsp"%>

<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>
<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuCorsi,2) + "</title>");
</script>
        <!-- autocompose data field -->
        <script type="text/javascript" src="../_scripts/calendar/utility.js"></script>
        <!-- import the calendar script -->
        <script type="text/javascript" src="../_scripts/calendar/calendar.js"></script>
        <!-- import the language module -->
        <script type="text/javascript" src="../_scripts/calendar/lang.js"></script>
        <!-- import calendar utility function -->
        <script type="text/javascript" src="../_scripts/calendar/showCalendar.js"></script>
        <!-- style sheet for calendar -->
        <link rel="stylesheet" type="text/css" media="all" href="../_styles/calendar/skins/aqua/theme.css" title="Aqua" />
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">
			<link rel="stylesheet" href="../_styles/tabs.css">
      <script language="JavaScript" src="../_scripts/tabs.js"></script>
<script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
</head>
<script>
    window.dialogWidth="800px";
    window.dialogHeight="570px";
</script>
<body>
<%
	long    SCH_EGZ_COR_ID=0;
	long	lCOD_AZL = Security.getAzienda();
	String  strCOD_SCH_EGZ_COR="";
  	long    lCOD_COR=0;
	String  strSTA_EGZ_COR="";
	String  strDAT_PIF_EGZ_COR="";
     String DISABL = "";
//--------------------------------
  	String  strDAT_EFT_EGZ_COR="";
    java.sql.Date dtDAT_PIF_EGZ_COR=null;
//--------------------------------
        String  PChecked="";    // Pianificato
  	String  IChecked="";    // In corso
        String  CChecked="";    // Concluso

IAzienda azienda;
IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");

IErogazioneCorsi ErogazioneCorsi = null;
if( request.getParameter("ID")!=null)
{
		strCOD_SCH_EGZ_COR = request.getParameter("ID");
		IErogazioneCorsiHome home=(IErogazioneCorsiHome)PseudoContext.lookup("ErogazioneCorsiBean"); 
		Long COD_SCH_EGZ_COR=new Long(strCOD_SCH_EGZ_COR);
       
		ErogazioneCorsi = home.findByPrimaryKey(COD_SCH_EGZ_COR);
		// getting of object variables
		lCOD_COR=ErogazioneCorsi.getCOD_COR();
                lCOD_AZL=ErogazioneCorsi.getCOD_AZL();
		strDAT_PIF_EGZ_COR=Formatter.format(ErogazioneCorsi.getDAT_PIF_EGZ_COR());
        dtDAT_PIF_EGZ_COR=ErogazioneCorsi.getDAT_PIF_EGZ_COR();
        
         
                // Stato Erogazione
                strSTA_EGZ_COR=ErogazioneCorsi.getSTA_EGZ_COR();
                PChecked = strSTA_EGZ_COR.equals("P")?"checked":"";
                IChecked = strSTA_EGZ_COR.equals("I")?"checked":"";
                CChecked = strSTA_EGZ_COR.equals("C")?"checked":"";
                
		//-----------------------------
		strDAT_EFT_EGZ_COR=Formatter.format(ErogazioneCorsi.getDAT_EFT_EGZ_COR());
}
	Long azl_id=new Long(lCOD_AZL);
	azienda = AziendaHome.findByPrimaryKey(azl_id);
	String	strRAG_SCL_AZL= azienda.getRAG_SCL_AZL();

     %>
<script type="text/javascript">
    function AssociaDipendenti(){
        window.showModalDialog('../Form_COR_DPD_ISC/COR_DPD_ISC_Form.jsp?ID=<%=lCOD_COR%>&DAT_PIF_EGZ_COR=<%=dtDAT_PIF_EGZ_COR%>&COD_SCH_EGZ_COR=<%=strCOD_SCH_EGZ_COR%>','','scroll:yes;status:no;help:no');
        tabbar.RefreshAllTabs();
    }
</script>

<!-- form for addind  -->
<form action="SCH_EGZ_COR_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
  <table width="100%" border="0">
    <tr>
    <td valign="top" class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuCorsi,2,<%=request.getParameter("ID")%>));
    </script>
    </td>
    </tr>
<input name="SBM_MODE" type="hidden" value="<%if(strCOD_SCH_EGZ_COR==""){out.print("new");}else{out.print("edt");}%>">
<input name="COD_SCH_EGZ_COR" type="hidden" value="<%=strCOD_SCH_EGZ_COR%>">
<input name="COD_AZL" type="Hidden" value="<%=azl_id%>">
</table>
<!-- ############################ -->
<table width="100%" border="0">
 	<%@ include file="../_include/ToolBar.jsp" %>
    <%ToolBar.bCanDelete=(ErogazioneCorsi!=null);
	  ToolBar.bAlwaysShowPrint=true;
	%>
	<%=ToolBar.build(3)%>
	</table>
 <!-- ########################### -->
 <br>
 <table width="100%" border="0">
     <tr> 
        <td> 
            <fieldset>
            <legend><%=ApplicationConfigurator.LanguageManager.getString("Erogazione.corso")%></legend>
            <table width="100%" border="0">
            <tr> 
                <td width="15%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
                <td colspan="5" width="85%"><input style="width:100%;" type="text" readonly name="RAG_SCL_AZL2" value="<%=strRAG_SCL_AZL%>"></td>
            </tr>
        <tr>
    <td colspan="6">  
  
        <fieldset>
  <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.corso")%></legend>
        <table width="100%" border="0">
          <tr> 
            <td width="15%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
    <td colspan="5"><select name="select" id="select" style="width:100%;" <%=DISABL%> onchange="LoadCorso(this.value)">
        <option value=""></option>
        <% IErogazioneCorsiHome ErogazioneCorsi_mt=(IErogazioneCorsiHome)PseudoContext.lookup("ErogazioneCorsiBean");
		out.print(BuildCORBox(ErogazioneCorsi_mt, lCOD_COR)); 	%></select></td>
  </tr>
  <tr> 
            <td width="14%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%>&nbsp;</b></td>
    <td colspan="3"><input  id="COR_TPL2" name="COR_TPL2" value="" style="width:100%;" readonly></td>
            <td width="13%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Durata(h)")%>&nbsp;</b></td>
            <td width="22%"> 
              <input id="COR_DUR3" name="COR_DUR3" value="" style="width:100%;" readonly>
              <input id="COD_COR" name="COD_COR" type="hidden" value="">
            </td>
  </tr>
  </table>
  </fieldset>
  
  </td>  
  </tr> 
    <tr>
    <td width="10%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione")%>&nbsp;</b></td>
    <td colspan="3"><s2s:Date name="DAT_PIF_EGZ_COR2" id="DAT_PIF_EGZ_COR2" value="<%=strDAT_PIF_EGZ_COR%>"/>
      <td width="9%" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.inizio.erogazione")%>&nbsp;</td>
      <td width="21%">
      <s2s:Date name="DAT_EFT_EGZ_COR" id="DAT_EFT_EGZ_COR" value="<%=strDAT_EFT_EGZ_COR%>"/></td>
  </tr>
  <tr> 
    <td width="13%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Stato.erogazione")%>&nbsp;</b></td>
      <td width="15%"> 
        <input class="checkbox" type="radio" name="STA_EGZ_COR" id="radio3" value="P" <%=PChecked%>> 
      &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Pianificato")%></td>
      <td width="15%"> 
        <input class="checkbox" type="radio" name="STA_EGZ_COR" id="radio2" value="I" <%=IChecked%>> 
      &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("In.corso")%></td>
      <td width="15%"> 
        <input class="checkbox" type="radio" name="STA_EGZ_COR" id="radio" value="C" <%=CChecked%>> 
      &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Concluso")%></td>
  <%if (!strCOD_SCH_EGZ_COR.equals("")){%>
    <td>
        <%=ApplicationConfigurator.LanguageManager.getString("Associazione.dipendenti/corsi")%>&nbsp;
    </td>    
    <td align="left">
        <input  name="button" 
                type="button" 
                onclick="javascript:AssociaDipendenti();"
                value="&nbsp;...&nbsp;">
	</td>
<%} else {%>
    <td colspan="2">&nbsp;</td>
<%}%>
  </tr>
</table>
</fieldset>

<table width="100%" border="0">
<tr>
  	<td colspan="100" valign="top"><div id="dContainer" class="mainTabContainer" style=""></div></td>
 </tr> 
</table>
</form>
<!-- /form  -->
<iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
	
<script type="text/javascript">
//---------------------------------------------------------------
	function LoadCorso(SEL_ID){
            if(SEL_ID!=0){
                url="SCH_EGZ_COR_Corso.jsp?ID="+SEL_ID;
                ifrmW = document.all["ifrmWork"];
                ifrmW.src=url;
            } 
            else {
		document.all["COR_TPL2"].value="";
		document.all["COR_DUR3"].value="";
		document.all["COD_COR"].value="";
            }
	}
	
</script>
	
<%
//-------Loading of Tabs--------------------
if(ErogazioneCorsi!=null)
{
%>
<script language="JavaScript" src="../_scripts/index.js"></script>
<script language="JavaScript">
if(window.name!="ifrmWork")
{

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
	btnParams[2] = {"id":"btnCancel", 
					"onmousedown":btnDown, 
					"onmouseup":btnOver,
					"onmouseover":btnOver,
					"onmouseout":btnOut,
					"onclick":delRow,
					"src":"../_images/DEL_DET.gif",
					"action":"Delete"
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
    //--------creating tabs--------------------------
	var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
	var btnBar = new ButtonPanel("batPanel1", btnParams);
	tabbar.addButtonBar(btnBar);
	tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Lavoratori.iscritti")%>", tabbar));
	
	
	//------adding tables to tabs-----------------------
	
	tabbar.idParentRecord = <%= new Long(strCOD_SCH_EGZ_COR) %>;
	tabbar.refreshTabUrl="SCH_EGZ_COR_Tabs.jsp";	
	tabbar.RefreshAllTabs();
	
	//-----activate first tab--------------------------
	tabbar.tabs[0].center.click();
	
	//----add action parameters to tabs
	tabbar.tabs[0].tabObj.actionParams ={
										"Feachures":SCH_EGZ_COR_DPD_Feachures
													,
											"AddNew":{"url":"../Form_SCH_EGZ_COR_DPD/SCH_EGZ_COR_DPD_Form.jsp?ATTACH_URL=Form_SCH_EGZ_COR/SCH_EGZ_COR_Attach.jsp", 
													"buttonIndex":0,
													"disabled": false
												  	},
										"Edit":	{"url":"../Form_SCH_EGZ_COR_DPD/SCH_EGZ_COR_DPD_Form.jsp?ATTACH_URL=Form_SCH_EGZ_COR/SCH_EGZ_COR_Attach.jsp",
													"buttonIndex":1,
													"disabled": true
										 			},
										 "Delete":	{"url":"SCH_EGZ_COR_Delete.jsp",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": false	
										 			}	
										}; 
	
	
	
	//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	// -- function for Repoprt ------------------------------------- 
	function OnPrint(){
	  	if( tabbar.tabs[0].tabObj.table.selectedRow != null){
	  		COD_DPD=tabbar.tabs[0].tabObj.table.selectedRow.id;
			ToolBar.openReport("InvitoCorso.jsp?COD_DPD="+COD_DPD);
		}else{
		 	alert(arraylng["MSG_0082"]);
		}
	}  
	btn=ToolBar.Print.getButton();	
	var OldPrint= btn.onclick;
	btn.onclick=OnPrint;
        LoadCorso(<%=lCOD_COR%>);
}
	//---------------------------------------------------------------
</script> 
<%}else{%>
<script>
window.dialogWidth="800px";
window.dialogHeight="320px";
</script>
<%}%>
</body>
</html>
