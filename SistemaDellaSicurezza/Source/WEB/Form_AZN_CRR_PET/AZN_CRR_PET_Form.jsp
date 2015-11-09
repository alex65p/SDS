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
    <version number="1.0" date="01/02/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="01/02/2004" author="Khomenko Juliya">
				    <description>Create form AZN_CRR_PET_Form.jsp</description>
				 </comment>		
				  <comment date="01/02/2004" author="Alexey Kolesnik">
				    <description> added beans </description>
				 </comment>
				 <comment date="02/03/2004" author="Roman Chumachenko">
				   <description>Remake to new requirements</description>
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
<%@ page import="com.apconsulting.luna.ejb.InterventoAudut.*" %>
<%@ page import="com.apconsulting.luna.ejb.AzioniCorrectivePreventive.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="AZN_CRR_PET_Util.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuVerificheSPP,3) + "</title>");
</script>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">
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

<link rel="stylesheet" href="../_styles/tabs.css">
<script language="JavaScript" src="../_scripts/tabs.js"></script>
<script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>

</head>
<script>
	window.dialogWidth="56em";
	window.dialogHeight="44em";
//alert(window.dialogWidth +" "+window.dialogHeight);
</script>

<body>

<%
	IAzienda azienda;
	IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");
	IAzioniCorrectivePreventive AzioniCorrPrev = null;
	IAzioniCorrectivePreventiveHome  home=(IAzioniCorrectivePreventiveHome)PseudoContext.lookup("AzioniCorrectivePreventiveBean");
	IInterventoAudutHome iaHome=(IInterventoAudutHome)PseudoContext.lookup("InterventoAudutBean");
	//------------------------------------
	long lCOD_AZN_CRR_PET = 0;
	String strCOD_AZN_CRR_PET;
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
	String	strInterventiAuditDesc="";
	long lCOD_AZL = Security.getAzienda();
	//------------------------------------
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
		strDES_AZN_CRR_PET = Formatter.format(AzioniCorrPrev.getDES_AZN_CRR_PET());
		strTPL_AZN = Formatter.format(AzioniCorrPrev.getTPL_AZN());
		strDAT_AZN = Formatter.format(AzioniCorrPrev.getDAT_AZN());
		//----
		strInterventiAuditDesc=AzioniCorrPrev.getInterventiAuditDesc();
	}	
	// Get Aziende/Ente
	azienda = AziendaHome.findByPrimaryKey(new Long(lCOD_AZL));
	String	strRAG_SCL_AZL 	= azienda.getRAG_SCL_AZL();
	String	strNOM_RSP_AZL 	= azienda.getNOM_RSP_AZL();
	String	strCIT_AZL 		= azienda.getCIT_AZL();
%>

<!-- form for addind  Azioni Correttive/Preventive-->
<form action="AZN_CRR_PET_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="Hidden" value="<%=(lCOD_AZN_CRR_PET==0)?"new":"edt"%>">
<input type="hidden" name="COD_AZN_CRR_PET" value="<%=lCOD_AZN_CRR_PET%>">
<input type="hidden" name="COD_AZL" value="<%=lCOD_AZL%>">
<table width="100%" border="0">
<tr>
 <td valign="top">
  <table  width="100%">
  <tr><td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuVerificheSPP,3,<%=request.getParameter("ID")%>));
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
			<%ToolBar.strPrintUrl="RichiestaAzione.jsp?";%>
			<%=ToolBar.build(3)%>
		</td>
	</tr>
</table>
<!-- Fine modifica effettuata da Francesco Di Martino 01-10-2004 --> 	
	
	
   <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.richiesta")%></legend>
	 <table  width="100%" border="0">
 		<tr>
			<td align="right" width="13%"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
	    	<td colspan="100%"><input size="80" type="text" readonly value="<%=strRAG_SCL_AZL%>"></td>
		</tr>
		<tr>
                    <td align="right" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione.intervento.d'audit")%>&nbsp;<input  tabindex="1" type="hidden" value="<%=lCOD_INR_ADT%>" name="COD_INR_ADT" id="COD_INR_ADT"></td>
	    	<td colspan="100%">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
                                <td width="90%"><textarea name="DES_INR_ADT" id="DES_INR_ADT" cols="10" rows="15" ><%=strInterventiAuditDesc%></textarea></td>
                                <td width="10%" valign="top">
                                    <button tabindex="2"class="getlist" onclick="getInterventiList()" id="btnLavoratore">
                                    <strong>&middot;&middot;&middot;</strong>
                                    </button>							
				</td>	
			</tr>
			</table>
		</tr>
		<tr>
			<td align="right" valign="top"><b><%=ApplicationConfigurator.LanguageManager.getString("Azione.richiesta")%>&nbsp;</b></td>
	    	<td><textarea tabindex="3" rows="2" cols="70" name="DES_AZN_RCH"><%=strDES_AZN_RCH%></textarea></td>
			<td rowspan="2" valign="top" width="25%" >
			<fieldset>
        <b><%=ApplicationConfigurator.LanguageManager.getString("Richiesta.di")%>&nbsp;</b><br>
			  <input tabindex="4" type="radio" class="checkbox" name="RCH_AZN_CRR_PET" value="C" <%=(strRCH_AZN_CRR_PET.equals("P"))?"":"checked"%>>
                           <b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azione.correttiva")%></b><br>
			  <input tabindex="5" type="radio" class="checkbox" name="RCH_AZN_CRR_PET" value="P" <%=(strRCH_AZN_CRR_PET.equals("P"))?"checked":""%>>
                           <b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azione.preventiva")%></b>
			</fieldset>
			</td>
			</tr>
		<tr>
			<td align="right" width=""><b><%=ApplicationConfigurator.LanguageManager.getString("Data.richiesta")%>&nbsp;</b></td> 
		    <td colspan="100%"><s2s:Date tabindex="6" id="DAT_RCH" name="DAT_RCH" value="<%=strDAT_RCH%>"/></td>
		</tr>
   </table>
	 </fieldset>
	</td></tr>
  </table>
 </td>
</tr>
<tr>
	<td colspan="100%"><div id="dContainer" class="mainTabContainer"></div></td>
</tr>
</table>
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
<%
//-------Loading of Tabs--------------------
if(AzioniCorrPrev!=null)
{
 	IAzioniCorrectivePreventiveHome acp_home=(IAzioniCorrectivePreventiveHome)PseudoContext.lookup("AzioniCorrectivePreventiveBean");
	out.print( BuildDocumentoTab(acp_home, Formatter.format(lCOD_AZN_CRR_PET)) );
// -----------------------------------------
%>

<!-- Attivazione RACP  class='dataTableHeader'-->
<table border='0' id='AttivazioneRACPHeader' cellpadding='0' cellspacing='0' width='100%'>
    <tr>
        <td>
            <table border="1" width="100%">
		<tr>
                    <td align="right" width="20%"><%=ApplicationConfigurator.LanguageManager.getString("Richiesta")%>&nbsp;</td>
                    <td colspan="3" width="80%"><input size="60" type="text" name="TPL_ATT" value="<%=GetRichiesta(strTPL_ATT)%>"readonly></td>
		</tr>
		<tr>
                    <td nowrap valign="top" align="right" width="20%"><%=ApplicationConfigurator.LanguageManager.getString("Azione.correttiva/preventiva")%>&nbsp;</td>
                    <td colspan="3" width="80%"><textarea rows="4" cols="80" name="DES_AZN_CRR_PET" readonly ><%=strDES_AZN_CRR_PET%></textarea></td>
		</tr>
		<tr>
                    <td align="right" width="20%"><%=ApplicationConfigurator.LanguageManager.getString("Azione")%>&nbsp;</td>
                    <td width="20%"><input size="60" type="text" name="TPL_AZN" value="<%=GetAzione(strTPL_AZN)%>"  readonly></td>
                    <td align="right" width="25%"><%=ApplicationConfigurator.LanguageManager.getString("Data.azione")%>&nbsp;</td>
                    <td align="left" width="35%"><s2s:Date readonly="true" id="DAT_AZN" name="DAT_AZN" value="<%=strDAT_AZN%>"/></td>
		</tr>
	</table>
	</td></tr>
</table>
	
<table border='0' id='AttivazioneRACP' class='dataTable' cellpadding='0' cellspacing='0'>
<tr><td>&nbsp;</td></tr>
</table>	</form>
<!-- /form for addind  AzioniCorrettivePreventive-->

<script language="JavaScript" src="../_scripts/index.js"></script>
<script language="JavaScript">
	//--------BUTTONS description----------- class="ifrmWork" src="../empty.txt"------------
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
    //------ creating tabs --------------------------
	var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
	var btnBar1 = new ButtonPanel("batPanel1", btnParams);
	tabbar.addButtonBar(btnBar1);
	
	tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti")%>", tabbar));
	tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Attivazione.RACP")%>", tabbar));
	//------ adding tables to tabs -----------------------
	tabbar.tabs[0].tabObj.addTable( document.all["DocumentoHeader"],document.all["Documento"], true);
	tabbar.tabs[1].tabObj.addTable( document.all["AttivazioneRACPHeader"],document.all["AttivazioneRACP"], true);
	//----add action parameters to tabs
	tabbar.idParentRecord = <%=Formatter.format(lCOD_AZN_CRR_PET)%>;
	tabbar.refreshTabUrl="AZN_CRR_PET_RefreshTabs.jsp";	
	//tabbar.DEBUG_TABS_IFRM = true;
	//---------------------------------------------------------------------------------------------------------									
	tabbar.tabs[0].tabObj.actionParams ={"Feachures":ANA_DOC_Feachures,
										 "AddNew":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_AZN_CRR_PET/AZN_CRR_PET_Attach.jsp&ATTACH_SUBJECT=DOCUMENT", 
													"buttonIndex":0,
													"disabled": false
												  	},
										 "Edit":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_AZN_CRR_PET/AZN_CRR_PET_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
													"buttonIndex":1,
													"disabled": false
										 			},		
										 "Delete":	{"url":"AZN_CRR_PET_AttachDel.jsp?ATTACH_SUBJECT=DOCUMENT",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": false
										 			}
										};
//---------------------------------------------------------------------------------------------------------									
tabbar.tabs[0].tabObj.OnActivate = function ()
{
	tabbar.buttonBar.panel.style.display = '';
};	
tabbar.tabs[1].tabObj.OnActivate = function ()
{
	obj = tabbar.tabs[1].tabContainer;
	obj.style.display = 'none';
	tabbar.buttonBar.panel.style.display = 'none';
};	
//-----activate first tab--------------------------
tabbar.tabs[0].center.click();
//-------------------------------------------------
</script>
<%}else{%>
<script>
	window.dialogWidth="56em";
	window.dialogHeight="29em";
</script>
<%}%>
<script>
//-------------------------------------------------
ifrmW = document.all["ifrmWork"];
function getInterventiList(){
	var obj=new Object();
	DES_INR_ADT = document.all["DES_INR_ADT"].value;
	var url="Form_ANA_INR_ADT/ANA_INR_ADT_View.jsp?DES_INR_ADT="+DES_INR_ADT;
	if(showSearch(url, obj)=="OK"){
		ifrmW.src="AZN_CRR_PET_Interventi.jsp?ID="+obj.ID;		
	}
}
</script>
</body>
</html>
