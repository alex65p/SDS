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
    <version number="1.0" date="15/01/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="15/01/2004" author="Khomenko Juliya">
				   <description>Shablon formi ANA_PSD_ACD_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="com.apconsulting.luna.ejb.Presidi.*" %>
<%@ page import="com.apconsulting.luna.ejb.SchedeInterventoPSD.*" %>
<%@ page import="com.apconsulting.luna.ejb.CategoriePreside.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="ANA_PSD_ACD_Util.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuPresidi,1) + "</title>");
</script>
  <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
	<link rel="stylesheet" href="../_styles/tabs.css">
	<script language="JavaScript" src="../_scripts/tabs.js"></script>
	<script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
        
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

</head>
<script>
window.dialogWidth="690px";
window.dialogHeight="500px";
</script>
<body>

<%
  	long 	lCOD_AZL=Security.getAzienda();
	long	lCOD_PSD_ACD = 0;			//1
	long	lCOD_CAG_PSD_ACD = 0; 		//2
	String	strIDE_PSD_ACD = ""; 		//3
	String	datDAT_ULT_CTL = ""; 		//4 - Nullable
	String	strESI_ULT_CTL = ""; 		//5 - Nullable
	long	lCOD_LUO_FSC = 0;			//6
	String	strSTA_PSD_ACD = "";		//7
	
	IPresidi Presidi=null;
	if(request.getParameter("ID")!=null)
	{
		String strCOD_PSD_ACD = request.getParameter("ID");
		IPresidiHome home=(IPresidiHome)PseudoContext.lookup("PresidiBean");
		Long psd_id=new Long(strCOD_PSD_ACD);
		Presidi = home.findByPrimaryKey(psd_id);
   		lCOD_PSD_ACD = psd_id.longValue(); 									//1
		lCOD_CAG_PSD_ACD = Presidi.getCOD_CAG_PSD_ACD();		//2
		strIDE_PSD_ACD = Presidi.getIDE_PSD_ACD();					//3
		datDAT_ULT_CTL = Formatter.format(Presidi.getDAT_ULT_CTL());	//4
		strESI_ULT_CTL = Presidi.getESI_ULT_CTL();					//5
		lCOD_LUO_FSC = Presidi.getCOD_LUO_FSC();						//6
		strSTA_PSD_ACD = Presidi.getSTA_PSD_ACD();					//7
	}	
%>
<!-- form for addind  Presidi-->
<form action="ANA_PSD_ACD_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="Hidden" value="<%=(lCOD_PSD_ACD==0)?"new":"edt"%>">
<input type="hidden" name="PSD_ACD_ID" value="<%=lCOD_PSD_ACD%>">
<table width="100%" border="0">
<tr>
 <td valign="top">
  <table  width="100%">
  <tr><td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuPresidi,1,<%=request.getParameter("ID")%>));
    </script>      
  </td></tr>
  <tr>
	<td>
<table width="100%">
<!-- ############################ -->  		
<%@ include file="../_include/ToolBar.jsp" %>      
<%ToolBar.bCanDelete=(Presidi!=null);
  ToolBar.strPrintUrl="SchedaVerifica.jsp?";
%>		
<%=ToolBar.build(2)%> 
<!-- ########################### -->

</table>	
  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.presidio")%></legend>
   <table  width="100%" border="0">
    <tr>
        <td align="right" width="10%">
            <div align="lright"><b><%=ApplicationConfigurator.LanguageManager.getString("Identificatore")%>&nbsp;</b></div>
        </td>
        <td colspan="3">
            <input tabindex="1" size="20" maxlength="10" type="text" name="IDENTIFICATORE" value="<%=strIDE_PSD_ACD%>">
        </td>
    </tr>
    <tr>
        <td align="right"><div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Categoria")%>&nbsp;</b></div></td>
	<td>
            <select tabindex="2" name="CATEGORIA" style="width:230">
                <option value=""></option>
<%
	   ICategoriePresideHome cat_pre_home=(ICategoriePresideHome)PseudoContext.lookup("CategoriePresideBean");
	   String cat_pre_cb=BuildCategoriePresideComboBox(cat_pre_home, lCOD_CAG_PSD_ACD);
	   out.print(cat_pre_cb);
%> 
            </select>
	 </td>
	 <td align="right" nowrap><b><%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%>&nbsp;</b></td>
	 <td>
              <select tabindex="3" name="LUOGO" style="width:230">
                <option value=""></option>
<%
	   IAnagrLuoghiFisiciHome ana_luo_home=(IAnagrLuoghiFisiciHome)PseudoContext.lookup("AnagrLuoghiFisiciBean");
	   String ana_luo_cb=BuildAnagrLuoghiFisiciComboBox(ana_luo_home, lCOD_LUO_FSC, lCOD_AZL);
	   out.print(ana_luo_cb);
%> 	 
            </select>
	 </td>
    </tr>
    <tr>
        <td align="left" nowrap><div align="right"><%=ApplicationConfigurator.LanguageManager.getString("Esito.ultimo.controllo")%>&nbsp;</div></td>
	<td colspan="3"><input tabindex="4" size="104" type="text" maxlength="70" name="ESITO" value="<%=strESI_ULT_CTL%>"></td>
   </tr>
   <tr>
        <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.ultimo.controllo")%>&nbsp;</td>
        <td><div align="left"><s2s:Date tabindex="5" id="DATA" name="DATA" value="<%=datDAT_ULT_CTL%>"/></div></td>
        <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Stato")%>&nbsp;</b></td>
	<td>
            <select tabindex="6" name="STATO" style="width:100">
                <option value=""></option>
                <option  value="A" <%=(strSTA_PSD_ACD.equals("A"))?"selected":""%>><%=ApplicationConfigurator.LanguageManager.getString("ATTIVO")%></option>
                <option value="D" <%=(strSTA_PSD_ACD.equals("D"))?"selected":""%>><%=ApplicationConfigurator.LanguageManager.getString("DISATTIVO")%></option>
            </select>
        </td>
    </tr>	 
   </table>
	 </fieldset>
	 </td>
	 </tr>
	 <tr>
	   <td><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
   </tr>
  </table>
 </td>
</tr>  
</table>
</form>
<!-- /form for addind  Presidi-->
   <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
<%
//-------Loading of Tabs--------------------
if(Presidi!=null)
{
%>
<script language="JavaScript" src="../_scripts/index.js"></script>
<script language="JavaScript">
btnParams = new Array();
	btnParams[0] = {"id":"btnNew", 
					"onclick":addRow,
					"action":"AddNew"
					};
	btnParams[2] = {"id":"btnCancel", 
					"onclick":delRow,
					"action":"Delete"
					};
	btnParams[1] = {"id":"btnEdit", 
					"onclick":editRow,
					"action":"Edit"
					};				
    //--------creating tabs--------------------------
	var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
	var btnBar = new ButtonPanel("batPanel1", btnParams);
	tabbar.addButtonBar(btnBar);
	tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti.associati")%>", tabbar));
	tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Schede.d'intervento.associate")%>", tabbar));
	
	//------adding tables to tabs-----------------------
	tabbar.idParentRecord = <%= new Long(lCOD_PSD_ACD) %>;
	tabbar.refreshTabUrl="ANA_PSD_ACD_Tabs.jsp";	
	tabbar.RefreshAllTabs();
	//-----activate first tab--------------------------
	tabbar.tabs[0].center.click();
	//----add action parameters to tabs

//------------------------------------------------------------------
  tabbar.tabs[0].tabObj.actionParams ={
										"Feachures":ANA_DOC_Feachures,
"AddNew":{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_PSD_ACD/ANA_PSD_ACD_Attach.jsp&ATTACH_SUBJECT=DOCUMENT", 
													"buttonIndex":0,
													"disabled": false
												  	},
										"Edit":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_PSD_ACD/ANA_PSD_ACD_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
													"buttonIndex":1,
													"disabled": false
										 			},
										 "Delete":	{"url":"../Form_ANA_PSD_ACD/ANA_PSD_ACD_Delete.jsp?LOCAL_MODE=d",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": false	
										 			}	
										}; 
//------------------------------------------------------------------
  tabbar.tabs[1].tabObj.actionParams ={
										"Feachures":SCH_INR_PSD_Feachures,
											"AddNew":{"url":"../Form_SCH_INR_PSD/SCH_INR_PSD_Form.jsp?ATTACH_URL=Form_ANA_PSD_ACD/ANA_PSD_ACD_Attach.jsp&ATTACH_SUBJECT=SCHEDE", 
													"buttonIndex":0,
													"disabled": false
												  	},
										"Edit":	{"url":"../Form_SCH_INR_PSD/SCH_INR_PSD_Form.jsp?ATTACH_URL=Form_ANA_PSD_ACD/ANA_PSD_ACD_Attach.jsp&ATTACH_SUBJECT=SCHEDE",
													"buttonIndex":1,
													"disabled": false
										 			},
										 "Delete":	{"url":"../Form_ANA_PSD_ACD/ANA_PSD_ACD_Delete.jsp?LOCAL_MODE=s",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": false	
										 			}	
										}; 
//------------------------------------------------------------------
</script>
<%}else{%>
<script>
window.dialogWidth="690px";
window.dialogHeight="270px";
</script>
<%}%>
</body>
</html>
