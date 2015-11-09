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
    <version number="1.0" date="27/02/2004" author="Treskina Maria">
	      <comments>
				  <comment date="27/02/2004" author="Treskina Maria">
				   <description>SCH_VST_Form.jsp</description>
				  </comment>
				  <comment date="12/03/2004" author="Roman Chumachenko">
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
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../_include/ComboBox-Azienda.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<%
	long lCOD_AZL=Security.getAzienda();	
	long lCOD_UNI_ORG_ASC=0;
	String strVISITA="M";
	String strSTATO="N";
	java.sql.Date dDAT_PIF_VST_D=null;
	java.sql.Date dDAT_PIF_VST_A=null;
	java.sql.Date dDAT_EFT_VST_D=null;
	java.sql.Date dDAT_EFT_VST_A=null;
	String strTPL_ACR_VLU_RSO="";
	String strRAGGRUPPATI="N";
	String strSTA_INT="";

	String strSORT_DAT_PIF = ", 'a'.'dat_pif_vst_med' asc ";
    String strSORT_DAT_EFT = "X";
    String strSORT_TPL_ACC = "X";

/*IAzienda azienda=null;
IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");

	Long azl_id=new Long(lCOD_AZL);
	azienda = AziendaHome.findByPrimaryKey(azl_id);
	String	strRAG_SCL_AZL = azienda.getRAG_SCL_AZL();
*/

IAzienda azienda;
IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");
java.util.ArrayList azl_ids=Security.getAziende();
if(request.getParameter("AZIENDA")!=null)
{
  lCOD_AZL=new Long(request.getParameter("AZIENDA")).longValue();
  out.print(lCOD_AZL);
}
	
	
//----------------- opredelenie statusov dla radio knopok
	String strSVMedicina="", strSVIdoneita="";
	String strSSPianificata="", strSSEffettuata="", strSSNessuno="";
	String strSRLavoratore="", strSRAzienda="", strSRNessuno="";

//--- radio Visita
	if (strVISITA.equals("I")) strSVIdoneita="checked";
	  else strSVMedicina="checked";
		
//--- radio Stato
	if (strSTATO.equals("P")) strSSPianificata="checked";
		else if (strSTATO.equals("E")) strSSEffettuata="checked";
	  else strSSNessuno="checked";
		
//--- radio Raggruppati
	if (strRAGGRUPPATI.equals("D")) strSRLavoratore="checked";
		else if (strRAGGRUPPATI.equals("A")) strSRAzienda="checked";
	  else strSRNessuno="checked";
%>

<html>
<head>

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

<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuAnalisiControllo,0) + "</title>");
</script>
  <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
	<link rel="stylesheet" href="../_styles/tabs.css">
	<script language="JavaScript" src="SCH_VST_Script.js"></script>
</head>
<script>
window.dialogWidth="820px";
window.dialogHeight="500px";
</script>
<body>
<form name="frm1" action="SCH_VST_Tabs.jsp"  method="GET" target="ifrmWork" style="margin:0 0 0 0;">
<table border="0" width="100%">
<input id="SORT_DAT_PIF" name="SORT_DAT_PIF" type="hidden" value="<%=strSORT_DAT_PIF %>">
<input id="SORT_DAT_EFT" name="SORT_DAT_EFT" type="hidden" value="<%=strSORT_DAT_EFT %>">
<input id="SORT_TPL_ACC" name="SORT_TPL_ACC" type="hidden" value="<%=strSORT_TPL_ACC %>">
  <tr><td class="title" >
    <script>
        document.write(getCompleteMenuPath(SubMenuAnalisiControllo,0));
    </script>      
  </td></tr>
	<tr valign="top">
		<td>

<!-- Inizo modifica effettuata da Francesco Di Martino 01-10-2004 -->
<table width="100%" border="0">
	<tr>
		<td width="100%">
			<%@ include file="../_include/ToolBar.jsp" %>      
			<%
				ToolBar.bShowSave=false;
				ToolBar.bShowDelete=false;
				ToolBar.bShowDetail=true;
				ToolBar.bCanDetail=true;
				ToolBar.bAlwaysShowPrint=true;
				ToolBar.bCanPrint=true;
                                if (Security.isConsultant()){
                                    ToolBar.bCanPrint2=true;
                                    ToolBar.bShowPrint2=true;
                                }
			%>		
			<%=ToolBar.build(5)%> 
		</td>
	</tr>
</table>
<!-- Fine modifica effettuata da Francesco Di Martino 01-10-2004 --> 		
		
		
		<fieldset style="width:100%;">
 	 		<legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.visita.medica/d'idoneità")%></legend>
			<table border="0"  width="100%">
				
				<tr>
					<td colspan="9">
					<fieldset>
						<legend><%=ApplicationConfigurator.LanguageManager.getString("Dati")%></legend>
                                                <table width="100%" border="0">
                                                    <tr>
                                                        <td align="right" width="145px;"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
                                                        <td>
                                                            <!-- REPORT -->
                                                            <input type="checkbox" style="display:none" value="1" checked name="REP_TYPE">
                                                            <select tabindex="1" style="width:300px;" name="COD_AZIENDA" onchange="frameRefresh.document.location.replace('SCH_VST_Form.jsp?AZIENDA='+document.all['COD_AZIENDA'].value);">
                                                                <%=BuildAziendeComboBox(AziendaHome, lCOD_AZL)%>
                                                            </select>
                                                        </td>
                                                        <td align="right" width="90px;">
                                                            <%=ApplicationConfigurator.LanguageManager.getString("Unità.org.")%>&nbsp;
                                                        </td>
                                                        <td align="left">
                                                            <select tabindex="2" style="width:250px;" name="COD_UNI_ORG">
                                                                <option></option>
                                                                 <%
                                                                    IUnitaOrganizzativa uoBean=null;
                                                                    IUnitaOrganizzativaHome uoHome=(IUnitaOrganizzativaHome)PseudoContext.lookup("UnitaOrganizzativaBean");
                                                                    String nodes = uoHome.buildTreeNodes(uoBean, uoHome, 0, lCOD_UNI_ORG_ASC,lCOD_AZL,false);
                                                                    out.println(nodes);
                                                                 %>
                                                         </select>
                                                        </td>
                                                    </tr>
                                                </table>
					</fieldset>
                                    </td>
				</tr>
				<tr>
                                    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Visita")%>&nbsp</td>
                                    <td>
                                        <input tabindex="3" id="R_VISTA_V" name="R_VISITA" type="radio" class='checkbox' onclick="cambiParamSort()" value="M" <%=strSVMedicina%>>
                                        &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Medica")%>
                                    </td>
                                    <td colspan="2">
                                        <input tabindex="4" id="R_VISTA_M" name="R_VISITA" type="radio" class='checkbox'  onclick="cambiParamSort()" value="I" <%=strSVIdoneita%>>
                                        &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("D'idoneità")%>
                                    </td>
                                    <!--td align="right"><%=""/*ApplicationConfigurator.LanguageManager.getString("Status")*/%>&nbsp;</td>
                                    <td nowrap>
                                        <input name="R_STATO" type="radio" class='checkbox' value="P" <%=""/*strSSPianificata*/%>>
                                        &nbsp;<%=""/*ApplicationConfigurator.LanguageManager.getString("Pianificata")*/%>
                                    </td>
                                    <td colspan="2" nowrap>
                                        <input name="R_STATO" type="radio" class='checkbox' value="E" <%=""/*strSSEffettuata*/%>>
                                        &nbsp;<%=""/*ApplicationConfigurator.LanguageManager.getString("Effettuata")*/%>
                                    </td>
                                    <td colspan="1" nowrap>
                                        <input name="R_STATO" type="radio" class='checkbox' value="N" <%=""/*strSSNessuno*/%>>
                                        &nbsp;<%=""/*ApplicationConfigurator.LanguageManager.getString("Nessuna")*/%>
                                    </td-->
                                    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Stato.misura")%>&nbsp;</td>
                                    <td colspan="4" align="left">
                                        <select tabindex="5" name="STA_INT" style="width:100%">
                                                <option></option>
                                                <option value="D"><%=ApplicationConfigurator.LanguageManager.getString("Da.attuare")%></option>
                                                <option value="G"><%=ApplicationConfigurator.LanguageManager.getString("Già.completata")%></option>
                                        </select>
                                    </td>
				</tr>
				<tr>
					<td align="right" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Tipologia.accertamento")%>&nbsp;</td>
					<td colspan="8"><input tabindex="6" type="text" name="TPL_ACR_VLU_RSO" style='width:100%'></td>
				</tr>
				<tr>
					<td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione.dal")%>&nbsp;</td>
					<td align="left">
                                             <s2s:Date tabindex="7" id="DAT_PIF_VST_D" name="DAT_PIF_VST_D" />
                                        </td>
                                        <td align="right">&nbsp;&nbsp;&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("al")%>&nbsp;</td>
                                        <td>
                                            <s2s:Date tabindex="8" id="DAT_PIF_VST_A" name="DAT_PIF_VST_A" />
                                        </td>
                                        <td align="right" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Data.effettuazione.dal")%>&nbsp;</td> 
					<td align="left">
                                             <s2s:Date tabindex="9" id="DAT_EFT_VST_D" name="DAT_EFT_VST_D" />
                                        </td>
                                        <td align="right">&nbsp;&nbsp;&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("al")%>&nbsp;</td>
                                        <td colspan="2">
                                            <s2s:Date tabindex="10" id="DAT_EFT_VST_A" name="DAT_EFT_VST_A" />
                                        </td>
                                </tr>
				<tr>
                                    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Raggruppati.per")%>&nbsp;</td>
                                    <td nowrap>
                                        <input tabindex="11" name="R_RAGGRUPPATI" type="radio" class="checkbox" value="D" <%=strSRLavoratore %>>
                                        &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Lavoratore")%>
                                    </td>
                                    <td colspan="2" nowrap>
                                        <input tabindex="12" name="R_RAGGRUPPATI" type="radio" class="checkbox" value="A" <%=strSRAzienda %>>
                                        &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda")%>
                                    </td>
                                    <td nowrap colspan="5">
                                        <input tabindex="13" name="R_RAGGRUPPATI" type="radio" class="checkbox" value="N" <%=strSRNessuno %>>
                                        &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nessuno")%>
                                    </td>
                                    <!--td align="right"><%=""/*ApplicationConfigurator.LanguageManager.getString("Stato.misura")*/%>&nbsp;</td>
                                    <td colspan="3" align="left">
                                        <select name="STA_INT" style="width:100%">
                                                <option></option>
                                                <option value="D"><%=""/*ApplicationConfigurator.LanguageManager.getString("Da.attuare")*/%></option>
                                                <option value="G"><%=""/*ApplicationConfigurator.LanguageManager.getString("Già.completata")*/%></option>
                                        </select>    
                                    </td-->
                                <!--
                                    <td align="left" width="25%">Raggruppati per </td>
                                    <td width="25%"><input name="R_RAGGRUPPATI" type="radio" class="checkbox" value="D" <%=strSRLavoratore %>> Lavoratore&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="R_RAGGRUPPATI" type="radio" class="checkbox" value="A" <%=strSRAzienda %>> Azienda&nbsp;&nbsp;</td>
                                    <td width="20%"><input name="R_RAGGRUPPATI" type="radio" class="checkbox" value="N" <%=strSRNessuno %>> Nessuno&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Stato misura </td>
                                    <td width="40%">
                                    <select name="STA_INT">
                                            <option></option>
                                            <option value="G">GI&Aacute; COMPLETATI</option>
                                            <option value="D">DA ATTUARE</option>
                                    </select>-->
				</tr>
			</table>
		</fieldset>
	  </td>
	</tr>

	<tr>
		<td>
		<table border="0" width="100%" cellpadding='0' cellspacing='0'>
			<tr>
				<td height="18" valign="top">
					<table border='0' align="left" width="814" id='ListTableHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>
						<tr>
							<td width='40'>&nbsp;</td>
                            <td width='110' style='cursor:hand;'  onclick="sort_SCH_VST('dp');" ><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.pianificaz.")%></strong><img id='imgDP' src='../_images/ORDINE_DOWN.gif' alt='down' style='display:none'></td>
							<td width='110' onclick="sort_SCH_VST('de');" style='cursor:hand;'><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.effettuaz.")%></strong><img id='imgDE' src='../_images/ORDINE_DOWN.gif' alt='down' style='display:none'></td>
							<td width='186' style='cursor:hand;' onclick="sort_SCH_VST('t');"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Tipologia.accertamento")%></strong><img id='imgT' src='../_images/ORDINE_DOWN.gif' alt='down' style='display:none'></td>
							<td width='175'><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Lavoratore")%></strong></td>
							<td width='175'><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%></strong></td>
                            <td width='18'>&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
				<div id="div_s" style='height: 150;width: 100%;overflow:auto' ></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td align="center">
		<fieldset style="width:90%">
		<table width='100%' border="0">
                    <tr align="left">
			  <td width="25%" align="center"><img src="../_images/PALLA-ROSSA.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Rossa")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.in.ritardo")%></td>
                          <td width="25%" align="center"><img src="../_images/PALLA-BLUE.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Blue")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.scadenza.odierna")%></td>
                          <td width="25%" align="center"><img src="../_images/PALLA-NERA.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Nera")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.chiuse")%></td>
			  <td width="25%" align="center"><img src="../_images/PALLA-VERDE.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Verde")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.lavorate")%></td>

			</tr>
		</table>
		</fieldset>
		</td>
	</tr>
</table>
</form>
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
<script>
btn = ToolBar.Search.getButton();
btn.onclick = goTab;
ToolBar.Detail.OnClick = showDetailSCH_VST;
ToolBar.Detail.setEnabled(false);
// --- REPORT ---
// -- function for Repoprt 1------------------------------------------------------- 
	function OnPrint1(){
			frm= document.forms[0];
			w=window.open("../Reports/prepair.jsp", "REP");
			frm.target = "REP";
			frm.action = "../Reports/ScadenzarioVisitaIdoneita.jsp";
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
			ToolBar.submitReport("RPT_SCD_VST_IDO");
		}
	}  
	btn=ToolBar.Print2.getButton();	
	var OldPrint= btn.onclick;
	btn.onclick=OnPrint;
//---------------------------------------------------------------------------------
function restoreFrmProps(){
	frm.target = "ifrmWork";
	frm.action = "SCH_VST_Tabs.jsp";
}
//----------------------------------
</script>

</body>
