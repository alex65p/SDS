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
    <version number="1.0" date="29/02/2004" author="Malyuk Sergey">
	      <comments>
				  <comment date="29/02/2004" author="Malyuk Sergey">
				   <description>Shablon formi SCH_RIV_RSO_Form.jsp</description>
				  </comment>
				  <comment date="12/03/2004" author="Alexandr Kyba">
				   <description>Report</description>
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
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="SCH_RIV_RSO_Util.jsp" %>

<%//@ include file="../src/com/apconsulting/luna/ejb/ScadenzarioMisure/ScadenzarioMisure_Interfaces.jsp" %>
<%//@ include file="../src/com/apconsulting/luna/ejb/ScadenzarioMisure/ScadenzarioMisureBean.jsp" %>

<%@ include file="../_include/ComboBox-Azienda.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<%
IRischio rischio=null;
IRischioHome RischioHome=(IRischioHome)PseudoContext.lookup("RischioBean");
%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script language="JavaScript" src="SCH_RIV_RSO_Script.js"></script>
<%
	Checker c = new Checker();
long lCOD_AZL=Security.getAzienda();
long lCOD_FAT_RSO = 0;
/*	String strNB_APL_A = request.getParameter("NB_APL_A");
	if (strNB_APL_A == null || strNB_APL_A.equals("")) { strNB_APL_A = "M"; }
	String strNB_GROUP = request.getParameter("NB_GROUP");
	if (strNB_GROUP == null || strNB_GROUP.equals("")) { strNB_GROUP = "N"; }
	long lNB_NOM_MIS_PET = c.checkLong("Misura di Prevenzione",request.getParameter("NB_NOM_MIS_PET"),false);
*/
	IAzienda azienda=null;
	IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");
if(request.getParameter("AZIENDA")!=null)
{
  lCOD_AZL=new Long(request.getParameter("AZIENDA")).longValue();
	//out.print(lCOD_AZL);
}
%>

<html>
<head>
<script>
    window.dialogWidth="820px";
    window.dialogHeight="480px";
</script>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuAnalisiControllo,6) + "</title>");
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

<script language="JavaScript" src="SCH_RIV_RSO_Script.js"></script>
  <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
	<link rel="stylesheet" href="../_styles/tabs.css" TYPE="text/css">
</head>
<body >

<form name="frm1" action="SCH_RIV_RSO_Tabs.jsp"  method="GET" target="ifrmWork" style="margin:0 0 0 0;">
<input id="TYPE" name="TYPE" type="hidden" value="PIFup">
<input type="hidden" id="kolTr" value="">
<input type="hidden" id="PARENT_ID">
<input type="hidden" id="_ID">
<input type="hidden" id="first"/>
<table width="100%" border="0">
<!-- width="100%"-->



<tr><td class="title" colspan="100%">
    <script>
        document.write(getCompleteMenuPath(SubMenuAnalisiControllo,6));
    </script>      
</td></tr>
	<tr valign="top">
		<td>
<!-- ############################ -->
<table width="100%" border="0">
<%@ include file="../_include/ToolBar.jsp" %>
	<%
	ToolBar.bShowDetail=true;
	ToolBar.bShowSave=false;
	ToolBar.bShowDelete=false;
	ToolBar.bAlwaysShowPrint=true;
	ToolBar.bCanPrint=true;
	if (Security.isConsultant()){
            ToolBar.bCanPrint2=true;
            ToolBar.bShowPrint2=true;
        }
	%>
<%=ToolBar.build(5)%>
</table>
<!-- ########################### -->
		<fieldset>
 	 		<legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.scheda.d'intervento")%></legend>
                        <table width="100%" border="0">
                            <tr>
                                <td align="right">
                                    <b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b>
                                </td>
                                <td width="100%" colspan="3"> 
                                    <!-- REPORT -->
                                    <input type="checkbox" style="display:none" value="7" checked name="REP_TYPE"> 
                                    <select style="width:100%;" id="COD_AZL" name="COD_AZL" onchange="frameRefresh.document.location.replace('SCH_RIV_RSO_Form.jsp?AZIENDA='+document.all['COD_AZL'].value);">
                                        <%=BuildAziendeComboBox(AziendaHome, lCOD_AZL)%> 
                                    </select> 
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.rischio")%></legend>
                                        <table border="0"  width="100%">
                                            <tr>
                                                <td align="right" width="15%">
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Nome.rischio")%>&nbsp;
                                                </td>
                                                <input type="hidden" name="COD_RSO">
                                                <td>
                                                    <input type="text" name="NOM_RSO" id="NOM_RSO" style="width:260px" value="">
                                                </td>
                                                <td align="right" width="12%">
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Classificazione")%>&nbsp;
                                                </td>
                                                <td>
                                                    <input type="text" name="CLF_RSO" id="CLF_RSO" style="width:260px" value="">
                                                </td>
                                                <td align="left"> 
                                                    <button onclick="getLOV_RSO()" class="getlist"><strong>&middot;&middot;&middot;</strong></button>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" nowrap>
                                    <%=ApplicationConfigurator.LanguageManager.getString("Tipologia.di.rischio")%>&nbsp;
                                </td>
                                <td align="left" width="45%"> 
                                    <input class="checkbox" type="radio" name="RG_TIP_RSO" value="M" checked>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa")%></input>&nbsp;
                                    <input class="checkbox" type="radio" name="RG_TIP_RSO" value="L">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%></input>&nbsp;
                                    <input class="checkbox" type="radio" name="RG_TIP_RSO" value="E">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Entrambi")%></input>
                                </td>
                                <td width="10%">
                                    &nbsp;
                                </td>
                                <td align="left">
                                    <select name="STA_RSO">
                                        <option></option>
                                        <option value="V"><%=ApplicationConfigurator.LanguageManager.getString("Valutato")%></option>
                                        <option value="R"><%=ApplicationConfigurator.LanguageManager.getString("Rivalutato")%></option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" nowrap>
                                    <%=ApplicationConfigurator.LanguageManager.getString("Data.rivalutazione.dal")%>&nbsp;
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td align="center"> 
                                                <s2s:Date id="DAT_RFC_VLU_RSO_DAL" name="DAT_RFC_VLU_RSO_DAL" />
                                            </td>
                                            <td>
                                                <%=ApplicationConfigurator.LanguageManager.getString("al")%>&nbsp;
                                            </td>
                                            <td>                
                                                <s2s:Date id ="DAT_RFC_VLU_RSO_AL" name="DAT_RFC_VLU_RSO_AL" /> 
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td align="right">
                                    <%=ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio")%>&nbsp;
                                </td>
                                <td align="left"> 
                                    <select name="COD_FAT_RSO" style="width:100%;">
                                        <option value="0"></option>
                                        <%out.print(BuildFattoreRischioComboBox(RischioHome, lCOD_FAT_RSO, lCOD_AZL));%>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <%=ApplicationConfigurator.LanguageManager.getString("Raggruppati.per")%>&nbsp;
                                </td>
                                <td align="left" colspan="3">
                                    <input class="checkbox" type="radio" name="RG_GROUP" id="radio3" value="F">
                                    &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio")%>&nbsp; 
                                    <input class="checkbox" type="radio" name="RG_GROUP" id="radio2" value="A">
                                    &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;
                                    <input class="checkbox" type="radio" name="RG_GROUP" id="radio" value="N" checked>
                                    <%=ApplicationConfigurator.LanguageManager.getString("Nessuno")%>
                                </td>
                            </tr>
                        </table>
		
	<tr>
			<td>
					<table border='0' width="805" id='ListTableHeader' class='dataTableHeader' cellpadding='0' cellspacing='0' "width=100%">
						<tr>
                            <td width='40'>&nbsp;</td>
							<td width='140' id="pifTd" onclick="goTab('inr');"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.rivalutaz.")%></strong>&nbsp;<img id='pifDw' src='../_images/ORDINE_DOWN.gif' alt='down' style='display:none'><img src="../_images/ORDINE_UP.GIF" id="pifUp" style="display:none;"></td>
							<td width='203'><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Rischio")%></strong></td>
							<td width='202'><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio")%></strong></td>
							<td width='202'><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%></strong></td>
                            <td width='18'>&nbsp;</td>
						</tr>
					</table>
			</td>
	</tr>
	<tr>
			<td align="center"><div id="div_s" style='overflow-y : auto;height : 150px'></div></td>
	</tr>
	<tr>
		<td align="center" colspan="100%">
		<fieldset style="width:90%">
		<table border="0" width='100%'>
			<tr>
			  <td width="33%" align="center"><img src="../_images/PALLA-ROSSA.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Rossa")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.in.ritardo")%></td>
                          <td width="33%" align="center"><img src="../_images/PALLA-BLUE.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Blue")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.scadenza.odierna")%></td>
                          <td width="33%" align="center"><img src="../_images/PALLA-NERA.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Nera")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.chiuse")%></td>
			</tr>
		</table>
    </fieldset>
		</td>
	</tr>
</table>
</form>
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>

<script>
btn1 = ToolBar.Detail.getButton();
btn1.onclick = showDetailSCH_VST;
btn = ToolBar.Search.getButton();
btn.onclick = goTab;
ToolBar.Detail.setEnabled(false);
// --- REPORT ---
// -- function for Repoprt 1------------------------------------------------------- 
	function OnPrint1(){
			frm= document.forms[0];
			w=window.open("../Reports/prepair.jsp", "REP");
			frm.target = "REP";
			frm.action = "../Reports/ScadenzarioRivalutazioneRischi.jsp";
			frm.submit();
			restoreFrmProps();
	}  
	btn1=ToolBar.Print.getButton();	
	btn1.onclick=OnPrint1;
//---------------------------------------------------------------------------------
// -- function for Repoprt 2------------------------------------------------------- 
	function OnPrint(){
		var str = window.showModalDialog("../Form_MULTIAZIENDA/MULTIAZIENDA_Form.jsp?SCAD_REPORT=S", document, "dialogHeight:19; dialogWidth:45;help:no;resizable:no;status:no;scroll:no;");
		if (str=="OK"){
			ToolBar.submitReport("RPT_REP_SCD_RIV_RSO");
		}
	}  
	btn=ToolBar.Print2.getButton();	
	var OldPrint= btn.onclick;
	btn.onclick=OnPrint;
//---------------------------------------------------------------------------------
function restoreFrmProps(){
	frm.target = "ifrmWork";
	frm.action = "SCH_RIV_RSO_Tabs.jsp";
}
//----------------------------------
</script>
</body>
</html>
