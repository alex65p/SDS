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
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.InterventoAudut.*" %>
<%@ page import="com.apconsulting.luna.ejb.AzioniCorrectivePreventive.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="GEST_AZN_CRR_PET_Util.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuVerificheSPP,4) + "</title>");
</script>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">
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
//alert(window.dialogWidth + " " + window.dialogHeight);
window.dialogWidth="800px";
window.dialogHeight="660px";
</script>

<body>
<%
	IAzienda azienda;
	IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");

	IAzioniCorrectivePreventive AzioniCorrPrev = null;
	IAzioniCorrectivePreventiveHome home=(IAzioniCorrectivePreventiveHome)PseudoContext.lookup("AzioniCorrectivePreventiveBean");

	IInterventoAudutHome iaHome=(IInterventoAudutHome)PseudoContext.lookup("InterventoAudutBean");

	long lCOD_AZN_CRR_PET = 0;
	String strCOD_AZN_CRR_PET="";
	long lCOD_INR_ADT = 0;
	String strDES_AZN_RCH = "";
	String strRCH_AZN_CRR_PET = "";
	String strDAT_RCH = "";
	String strTPL_ATT = "";
	String strMTZ_ATT = "";
	String strDES_AZN_CRR_PET = "";
	String strTPL_AZN = "";
	String strMTZ_AZN = "";
	String strDAT_AZN = "";
	long lCOD_AZL = Security.getAzienda();

	if(request.getParameter("ID")!=null)
	{
		strCOD_AZN_CRR_PET = request.getParameter("ID");

		Long AZN_CRR_PET_id=new Long(strCOD_AZN_CRR_PET);
		AzioniCorrPrev = home.findByPrimaryKey(AZN_CRR_PET_id);

		lCOD_AZN_CRR_PET = AZN_CRR_PET_id.longValue();
		lCOD_AZL = AzioniCorrPrev.getCOD_AZL();
		lCOD_INR_ADT = AzioniCorrPrev.getCOD_INR_ADT();
		strDES_AZN_RCH = Formatter.format(AzioniCorrPrev.getDES_AZN_RCH());
		strRCH_AZN_CRR_PET = Formatter.format(AzioniCorrPrev.getRCH_AZN_CRR_PET());
		strDAT_RCH = Formatter.format(AzioniCorrPrev.getDAT_RCH());
		strTPL_ATT = Formatter.format(AzioniCorrPrev.getTPL_ATT());
		strMTZ_ATT = Formatter.format(AzioniCorrPrev.getMTZ_ATT());
		strDES_AZN_CRR_PET = Formatter.format(AzioniCorrPrev.getDES_AZN_CRR_PET());
		strTPL_AZN = Formatter.format(AzioniCorrPrev.getTPL_AZN());
		strMTZ_AZN = Formatter.format(AzioniCorrPrev.getMTZ_AZN());
		strDAT_AZN = Formatter.format(AzioniCorrPrev.getDAT_AZN());
	}	
	
	// Get Aziende/Ente
	Long azl_id=new Long(lCOD_AZL);
	azienda = AziendaHome.findByPrimaryKey(azl_id);
	String	strRAG_SCL_AZL= azienda.getRAG_SCL_AZL();
	String	strNOM_RSP_AZL= azienda.getNOM_RSP_AZL();
	String	strCIT_AZL= azienda.getCIT_AZL();	
%>

<!-- form for addind  Azioni Correttive/Preventive-->
<form action="GEST_AZN_CRR_PET_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="Hidden" value="<%=(lCOD_AZN_CRR_PET==0)?"new":"edt"%>">
<input type="hidden" name="AZN_CRR_PET_ID" value="<%=lCOD_AZN_CRR_PET%>">
<input type="hidden" name="COD_AZL" value="<%=lCOD_AZL%>">
<table width="100%" border="0">
 
<tr>
 <td valign="top">
  <table  width="100%">
  <tr><td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuVerificheSPP,4,<%=request.getParameter("ID")%>));
    </script>      
  </td></tr>
  <tr>
	<td>

<!-- Inizo modifica effettuata da Francesco Di Martino 01-10-2004 -->
<table>
	<tr>
		<td>
			<%@ include file="../_include/ToolBar.jsp" %>
 			<%ToolBar.bCanDelete=(AzioniCorrPrev!=null);%>
 			<%ToolBar.bShowPrint=false;%>
 			<%=ToolBar.build(3)%>
		</td>
	</tr>
</table>
<!-- Fine modifica effettuata da Francesco Di Martino 01-10-2004 --> 
	
	
	
  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.richiesta.di.azione.correttiva/preventiva")%></legend>
   <table  width="100%" border="0">
	 <tr><td colspan="100%">
   <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Richiesta")%></legend>
	 <table  width="100%" border="0">
 		<tr>
			<td align="right" width="20%"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
	    	<td colspan="100%"><input size="80" type="text" readonly value="<%=strRAG_SCL_AZL%>"></td>
		</tr>
		<tr>
			<td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione.intervento.d'audit")%>&nbsp;</td>
	    	<td colspan="100%">
				<select tabindex="1" name="COD_INR_ADT" style="width:513px">
					<option value="0"></option>
					<%=BuildInterventoAudutComboBox(iaHome, lCOD_INR_ADT)%>					
				</select>
			</td>
		</tr>
		<tr>
			<td align="right" valign="top"><b><%=ApplicationConfigurator.LanguageManager.getString("Azione.richiesta")%>&nbsp;</b></td>
	    	<td><textarea tabindex="2" rows="2" cols="82" name="DES_AZN_RCH"><%=strDES_AZN_RCH%></textarea></td>
			<td rowspan="2" valign="top" width="25%">
			<fieldset>
        <b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Richiesta.di")%>&nbsp;</b><br>
			  <input tabindex="3" type="radio" class="checkbox" name="RCH_AZN_CRR_PET" value="C" <%=(strRCH_AZN_CRR_PET.equals("P"))?"":"checked"%>>
                           <b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azione.correttiva")%></b><br>
			  <input tabindex="4" type="radio" class="checkbox" name="RCH_AZN_CRR_PET" value="P" <%=(strRCH_AZN_CRR_PET.equals("P"))?"checked":""%>>
                           <b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azione.preventiva")%></b>
			</fieldset>
			</td>
			</tr>
		<tr>
			<td align="right" width=""><b><%=ApplicationConfigurator.LanguageManager.getString("Data.richiesta")%>&nbsp;</b></td>
                         <td colspan="100%"><s2s:Date tabindex="5" id="DAT_RCH" name="DAT_RCH" value="<%=strDAT_RCH%>"/></td>
		</tr>
   </table>
	 </fieldset>
	 </td></tr>
	 <tr><td colspan="100%">
   <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Attivazione")%></legend>
	 <table  width="100%" border="0">
            <tr>
                <td align="left"  colspan="3">
                    <fieldset>
                            &nbsp;&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Richiesta")%>&nbsp;&nbsp;&nbsp;&nbsp;
                            <input tabindex="6" type="radio" class="checkbox" name="TPL_ATT" value="U" <%=(strTPL_ATT.equals("R")&&strTPL_ATT.equals("E")&&strTPL_ATT.equals("N"))?"":"checked"%>>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Attivata.con.urgenza")%>&nbsp;&nbsp;&nbsp;
                            <input tabindex="7" type="radio" class="checkbox" name="TPL_ATT" value="R" <%=(strTPL_ATT.equals("R"))?"checked":""%>>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Rimandata")%>&nbsp;&nbsp;&nbsp;
                            <input tabindex="8" type="radio" class="checkbox" name="TPL_ATT" value="E" <%=(strTPL_ATT.equals("E"))?"checked":""%>>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Respinta")%>&nbsp;&nbsp;&nbsp;
                            <input tabindex="9" type="radio" class="checkbox" name="TPL_ATT" value="N" <%=(strTPL_ATT.equals("N"))?"checked":""%>>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Non.attivata")%>
                    </fieldset>
                </td>
            </tr>   
            <tr>
                <td colspan="3" align="right" valign="top">
                    <table width="100%" border="0">
                        <tr>
                            <td valign="top" align="right" width="22%">
                               <%=ApplicationConfigurator.LanguageManager.getString("Azione.correttiva/preventiva")%>&nbsp;
                            </td>
                            <td>
                                <textarea tabindex="10" rows="2" cols="115" name="DES_AZN_CRR_PET"><%=strDES_AZN_CRR_PET%></textarea>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" valign="middle">
                    <fieldset>
			&nbsp;&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azione")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input tabindex="11" type="radio" class="checkbox" name="TPL_AZN" value="C" <%=(strTPL_AZN.equals("R")&&strTPL_AZN.equals("S")&&strTPL_AZN.equals("N"))?"":"checked"%>>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Conclusa.efficacemente")%>&nbsp;&nbsp;&nbsp;
			<input tabindex="12" type="radio" class="checkbox" name="TPL_AZN" value="R" <%=(strTPL_AZN.equals("R"))?"checked":""%>>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Non.risolta")%>&nbsp;&nbsp;&nbsp;
			<input tabindex="13" type="radio" class="checkbox" name="TPL_AZN" value="S" <%=(strTPL_AZN.equals("S"))?"checked":""%>>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Sospesa")%>&nbsp;&nbsp;&nbsp;
			<input tabindex="14" type="radio" class="checkbox" name="TPL_AZN" value="N" <%=(strTPL_AZN.equals("N"))?"checked":""%>>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nessuna")%>
                    </fieldset>
                </td>
                <td align="right" width="15%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.azione")%>&nbsp;</td>
                <td align="left"><s2s:Date tabindex="15" id="DAT_AZN"  name="DAT_AZN" value="<%=strDAT_AZN%>"/></td>
            </tr>
   </table>
	 </fieldset>
	 </td></tr>

   </table>	 
	 </fieldset></td></tr>
  </table>
 </td>
</tr>
<tr>
	<td colspan="100%"><div id="dContainer" class="mainTabContainer"></div></td>
</tr>
</table>
</form>
<!-- /form for addind  AzioniCorrettivePreventive-->
   <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>


  <table border='0' id='MotivazioneAttivazioneHeader' cellpadding='0' cellspacing='0'>
  <tr>
  <td><textarea style='width:750px;height:130px;' name='MTZ_ATT'><%=strMTZ_ATT%></textarea></td></tr>
  </table>
  <table border='0' id='MotivazioneAttivazione' class='dataTable' cellpadding='0' cellspacing='0'>
  <tr><td>&nbsp;</td></tr>
  </table>

  <table border='0' id='MotivazioneVerEffFinHeader' cellpadding='0' cellspacing='0'>
  <tr>
  <td><textarea style='width:750px;height:130px;' name='MTZ_AZN'><%=strMTZ_AZN%></textarea></td></tr>
  </table>
  <table border='0' id='MotivazioneVerEffFin' class='dataTable' cellpadding='0' cellspacing='0'>
  <tr><td>&nbsp;</td></tr>
  </table>
<script language="JavaScript" src="../_scripts/index.js"></script>
<script language="JavaScript">
	//--------BUTTONS description-----------------------
	btnParams = new Array();
	btnParams[0] = {"id":"btnNew", 
					"onclick":addRow,
					"action":"AddNew"
					};
	btnParams[1] = {"id":"btnEdit", 
					"onclick":editRow,
					"action":"Edit"
					};				
	btnParams[2] = {"id":"btnCancel", 
					"onclick":delRow,
					"action":"Delete"
					};
  //--------creating tabs--------------------------
	var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
	var btnBar = new ButtonPanel("batPanel1", btnParams);
	tabbar.addButtonBar(btnBar);

	tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Motivazioni.attivazione")%>", tabbar));
	tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Motivazioni.verifica.efficacia.finale")%>", tabbar));
	tabbar.tabs[0].tabObj.addTable( document.all["MotivazioneAttivazioneHeader"],document.all["MotivazioneAttivazione"], true);
	tabbar.tabs[1].tabObj.addTable( document.all["MotivazioneVerEffFinHeader"],document.all["MotivazioneVerEffFin"], true);

	tabbar.tabs[0].tabObj.OnActivate = function(){
			obj = tabbar.tabs[0].tabContainer;
			obj.style.display = 'none';
			tabbar.buttonBar.panel.style.display = 'none';
	};
	tabbar.tabs[1].tabObj.OnActivate = function(){
			obj = tabbar.tabs[1].tabContainer;
			obj.style.display = 'none';
			tabbar.buttonBar.panel.style.display = 'none';
	};
</script>
<% if (AzioniCorrPrev!=null){%>
<script language="JavaScript">
	tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti")%>", tabbar));
  tabbar.tabs[2].tabObj.OnActivate = function(){
			tabbar.buttonBar.panel.style.display = '';
	};
	//------adding tables to tabs-----------------------
	tabbar.idParentRecord = <%=strCOD_AZN_CRR_PET%>;
  tabbar.tabs[2].tabObj.refreshTabUrl="GEST_AZN_CRR_PET_Tabs.jsp";	
	tabbar.tabs[2].tabObj.Refresh();
	//----add action parameters to tabs
	tabbar.tabs[2].tabObj.actionParams ={
	                   "AddNew":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_GEST_AZN_CRR_PET/GEST_AZN_CRR_PET_Attach.jsp&ATTACH_SUBJECT=DOC",
	                        "buttonIndex":0,
													"disabled": false
												  	},
										 "Delete":	{"url":"../Form_GEST_AZN_CRR_PET/GEST_AZN_CRR_PET_Delete.jsp?LOCAL_MODE=doc",
	                        "buttonIndex":2,
													"target_element":document.all["ifrmWork"],
													"disabled": false
										 			},
										 "Edit":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp",
	                        "buttonIndex":1, 
													"disabled": false
										 			},
										 "Feachures":ANA_DOC_Feachures
										};
	//-----activate first tab--------------------------
	tabbar.tabs[0].center.click();
</script>

<%}%>
</body>
</html>
