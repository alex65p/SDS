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
<%@ page import="com.apconsulting.luna.ejb.AssMisuraAttivita.*" %>
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.MisurePreventive.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.MisurePreventProtettiveAz.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../Form_SCH_MIS_PET_AZL/SCH_MIS_PET_AZL_Util.jsp" %>
<%
	long lCOD_UNI_ORG=0;
	String strVISITA="M";
	String strSTATO="N";
	String strRAGGRUPPATI="N";
	IAzienda azienda=null;
	IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");
	IMisurePreventiveHome TplMisureHome=(IMisurePreventiveHome)PseudoContext.lookup("MisurePreventiveBean");
%>
<html>
<head>
  <title><%=ApplicationConfigurator.LanguageManager.getString("Scadenzario.misure.di.prevenzione.aziendale")%></title>
  <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
	<link rel="stylesheet" href="../_styles/tabs.css">
		<script language="JavaScript" src="SCH_MIS_PET_AZL_Script.js"></script>
</head>
<body>
<table border="0">

<tr><td>
<form action="SCH_MIS_PET_AZL_Tabs.jsp" name="frm1" id="frm1"  method="POST1" target="ifrmWork" style="margin:0 0 0 0;">
<input type="hidden" name="VAR_PAR_ADT" id="VAR_PAR_ADT" value="X">
<input type="hidden" name="COD_MIS_PET_AZL" id="COD_MIS_PET_AZL" value="0">
<table border="0">
<tr><td class="title" colspan="100%"><%=ApplicationConfigurator.LanguageManager.getString("Scadenzario.misure.di.prevenzione.aziendale")%></td></tr>
	<tr valign="top">
		<td>

<!-- Inizo modifica effettuata da Francesco Di Martino 01-10-2004 -->
<table>
	<tr>
		<td>
			<%@ include file="../_include/ToolBar.jsp" %>
			<%
			ToolBar.bShowDetail=true;
			ToolBar.bShowSave=false;
			ToolBar.bShowDelete=false;
			ToolBar.bAlwaysShowPrint=true;
			ToolBar.bCanPrint=true;
			ToolBar.bCanPrint2=true;
			ToolBar.bShowPrint2=true;
			%>
<%=ToolBar.build(2)%>>
			<%=ToolBar.build(2)%>
		</td>
	</tr>
</table>
<!-- Fine modifica effettuata da Francesco Di Martino 01-10-2004 -->			
		
		<fieldset>
			<legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.visita.medica/d'idoneità")%></legend>
			<table border="0">
				<tr>
					<td align="left" style="width:135px;"><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</td>
					<td colspan=3 style="width:540px;">
					<!-- REPORT -->
					<input type="checkbox" style="display:none" value="3" checked name="REP_TYPE">
					<select tabindex="1"name="COD_AZL" id="COD_AZL" style="width:540px;"><%=BuildAziendeComboBox(AziendaHome, 0)%></select></td>
				</tr>
				<tr>
					<td colspan=4>
					<fieldset>
						<legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.misura.di.prevenzione/protezione")%></legend>
						<table  width="100%">
							<tr><td align="left" width="130"><%=ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione/protezione")%>&nbsp;</td>
								<td>
									<input tabindex="2" name="NB_COD_MIS_PET" id="NB_COD_MIS_PET" type="hidden" value="0">
									<input tabindex="2" name="NB_NOM_MIS_PET" id="NB_NOM_MIS_PET" type="text" style="width:510px;">&nbsp;<button tabindex="3"onclick="getLOV_MIS_PET()" class="getlist">
                                                                             <strong>&middot;&middot;&middot;</strong></button></td></tr>
                                                                             <tr><td align="left" width="130"><%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%>&nbsp;</td>
                                                         <td><select tabindex="4" name="NB_DES_TPL_MIS_PET" id="NB_DES_TPL_MIS_PET" style="width:540px;"><option></option><%=BuildTplMisureComboBox(TplMisureHome, 0)%></select></td></tr>
						</table>
					</fieldset>
					</td>
				</tr>
				<tr>
					<td colspan=4>
					<fieldset>
						<legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.misura.di.prevenzione/protezione.applicata.a")%></legend>
						<table summary="" width="100%">
							<tr><td align="left"><%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%>&nbsp;
                                                         <input tabindex="5" type="radio" value="L" class="checkbox" name="NB_APL_A" id="NB_APL_A" onclick="onMIS_PET_MAN_LUO_FSC();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                         
									<%=ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa")%>&nbsp;
                                                                         <input tabindex="6" type="radio" value="M" class="checkbox" name="NB_APL_A" id="NB_APL_A" onclick="onMIS_PET_MAN_LUO_FSC();" checked>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                         <input tabindex="7" name="NB_COD_MIS_PET_LUO_MAN" id="NB_COD_MIS_PET_LUO_MAN" type="hidden" value="0">
									
                                                                         <%=ApplicationConfigurator.LanguageManager.getString("Misura")%>&nbsp;
                                                                         <input tabindex="8" name="NB_NOM_MIS_PET_LUO_MAN" id="NB_NOM_MIS_PET_LUO_MAN" type="text" style="width:330px;">&nbsp;<button tabindex="9"  onclick="getLOV_MIS_PET_MAN_LUO_FSC()" class="getlist"><strong>&middot;&middot;&middot;</strong></button>&nbsp;</td></tr>
						</table>
					</fieldset>
					</td>
				</tr>
				<tr>
					<td colspan=4>
					<fieldset>
						<legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.rischio")%></legend>
						<table>
							<tr><td align="left" width="130"><%=ApplicationConfigurator.LanguageManager.getString("Rischio")%>&nbsp;</td><td>
								<input tabindex="10" name="NB_COD_RSO" id="NB_COD_RSO" type="hidden" value="0">
								<input tabindex="11" name="NB_NOM_RSO" id="NB_NOM_RSO" type="text" style="width:510px;">&nbsp;<button onclick="getLOV_NOM_RSO()" class="getlist"><strong>&middot;&middot;&middot;</strong></button></td></td></tr>
						</table>
					</fieldset>
					</td>
				</tr>
				<tr>
					<td colspan=4><%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione.dal")%>&nbsp;<input tabindex="12" type="text" name="NB_DAT_PNZ_MIS_PET_DAL" maxlength="10" size="10" value="">&nbsp;
									&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("al")%>&nbsp;<input tabindex="13" type="text" name="NB_DAT_PNZ_MIS_PET_AL" maxlength="10" size="10" value="">&nbsp;
									&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Raggruppati.per")%>&nbsp;
									&nbsp;<input tabindex="14" type="radio" class="checkbox" name="NB_GROUP" value="T"><%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%>&nbsp;
									&nbsp;<input tabindex="15" type="radio" class="checkbox" name="NB_GROUP" value="A"><%=ApplicationConfigurator.LanguageManager.getString("Azienda")%>&nbsp;
									&nbsp;<input tabindex="16" type="radio" class="checkbox" name="NB_GROUP" value="N" checked><%=ApplicationConfigurator.LanguageManager.getString("Nessuno")%>
	 </td></tr>
   </table>
	 </fieldset></td></tr>
  </table>
</form>

<table border=0 width="100%">
<tr><td>
	<table border='0'  id='ListTableHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>
		<tr><td align='center' width='30'>&nbsp;</td>
			<td width='90' id='sort_SCH_MIS_PET_AZL' onclick="sort_SCH_MIS_PET_AZL('dr');"><strong><%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione")%></strong><img id='imgDR' src='../_images/ORDINE_DOWN.gif' alt='down' style='display:none'></td>
				<td width='250'><strong><%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%></strong></td>
				<td width='200'><strong><%=ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione/protezione")%></strong></td>
				<td width='170'><strong><%=ApplicationConfigurator.LanguageManager.getString("Azienda")%></strong></td>
		</tr>
		</table>
</td></tr>
<tr><td>
		<div id="div_s" style='height: 150;width: 100%; overflow: auto'></div>
</td></tr>
<tr><td align="center">
		<fieldset style="width:90%">
		<table width='100%'>
			<tr>
			  <td width="33%" align="center"><img src="../_images/PALLA-ROSSA.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Rossa")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.in.ritardo")%></td>
				<td width="33%" align="center"><img src="../_images/PALLA-VERDE.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Verde")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.chiuse")%></td>
				<td width="34%" align="center"><img src="../_images/PALLA-BLUE.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Blue")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.scadenza.odierna")%></td>
			</tr>
		</table>
		</fieldset>
</td></tr>
</table>

</td></tr>
</table>

<iframe name="ifrmWork" id="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>

<script type="text/javascript">
<!--
btn1 = ToolBar.Detail.getButton();
btn1.onclick = goMIS_PET_AZL;

btn = ToolBar.Search.getButton();
btn.onclick = goTab;
ToolBar.Detail.setEnabled(false);

// --- REPORT ---
// -- function for Repoprt 1------------------------------------------------------- 
	function OnPrint1(){
			frm= document.forms[0];
			w=window.open("../Reports/prepair.jsp", "REP");
			frm.target = "REP";
			frm.action = "../Reports/ScadenzarioMisurePreventiveAz.jsp";
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
			ToolBar.submitReport("RPT_SCD_MIS_PET_AZL");
		}
	}  
	btn=ToolBar.Print2.getButton();	
	var OldPrint= btn.onclick;
	btn.onclick=OnPrint;
//---------------------------------------------------------------------------------
function restoreFrmProps(){
	frm.target = "ifrmWork";
	frm.action = "SCH_MIS_PET_AZL_Tabs.jsp";
}
//----------------------------------
// -->
</script>
</body>
</html>
