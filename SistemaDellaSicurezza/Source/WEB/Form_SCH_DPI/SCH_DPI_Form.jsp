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
    <version number="1.0" date="5/03/2004" author="Podmasteriev Alexandr">
	      <comments>
				  <comment date="5/03/2004" author="Podmasteriev Alexandr">
				   <description>Shablon formi SCH_DPI_Form.jsp</description>
				  </comment>
				  <comment date="13/03/2004" author="Roman Chumachenko">
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
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.TipologiaDPI.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="SCH_DPI_Util.jsp" %>

<%@ include file="../_include/ComboBox-Azienda.jsp" %>
<%@ include file="../_include/ComboBox-Dipendente.jsp" %>

<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%
	long lCOD_AZL=Security.getAzienda();	
	long lCOD_UNI_ORG=0;
	String strVISITA="M";
	String strSTATO="N";
	String strRAGGRUPPATI="N";
	
	
IAzienda azienda=null;
ITipologiaDPI  TipologiaDPI=null;
//IDocentiCorso  DocentiCorso=null;
IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");
if(request.getParameter("AZIENDA")!=null)
{
  lCOD_AZL=new Long(request.getParameter("AZIENDA")).longValue();
	//out.print(lCOD_AZL);
}
	
//----------------- opredelenie statusov dla radio knopok
	String strSVMedicina="", strSVIdoneita="";
	String strSSPianificata="", strSSEffettuata="", strSSNessuno="";
	String strSRLavoratore="", strSRAzienda="", strSRNessuno="";
/*
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
		*/
%>
<%
    String FromUrl = request.getParameter("FROM");
    int title = -1;
    if (FromUrl.equals("M"))
        title = 0;
    else
    if (FromUrl.equals("S"))
        title = 1;
%>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuDPI2, <%=title%>) + "</title>");
</script>
  <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
	<LINK REL=STYLESHEET HREF="../_styles/tabs.css" TYPE="text/css">
	<script language="JavaScript" src="SCH_DPI_Script.js"></script>
         
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
<body>

<form action="SCH_DPI_Tabs.jsp" name="frm1" id="frm1"  method="GET" target="ifrmWork" style="margin:0 0 0 0;">
<table border="0" width="100%">
<input id="TYPE" name="TYPE" type="hidden" value="">
<input id="COD_SCH_INR_DPI" type="hidden" >
<input type="hidden" id="kolTr" value="">
<input type="hidden" id="first" value="">
<input type="hidden" id="strFROM" name="strFROM" value="<%=FromUrl%>">


  <tr><td class="title" >
    <script>
      document.write(getCompleteMenuPath(SubMenuDPI2, <%=title%>));
    </script>
  </td></tr>
	<tr valign="top">
		<td >
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
<%=ToolBar.build(9)%> 
</table>		
<!-- ########################### -->
<br>	
        <fieldset>
            <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.scheda.d'intervento")%></legend>	
            <table width="100%" border="0"> 
                <tr> 
                    <td width="20%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
                    <!-- REPORT -->
                    <td colspan="6" align="left">
                        <input type="checkbox" style="display:none" value="12" checked name="REP_TYPE">
                        <select name="COD_AZL" style="width:96%" onchange="frameRefresh.document.location.replace('SCH_DPI_Form.jsp?AZIENDA='+document.all['COD_AZL'].value);">
                            <%=BuildAziendeComboBox(AziendaHome, lCOD_AZL)%>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        <fieldset>
                            <legend><%=ApplicationConfigurator.LanguageManager.getString("D.P.I.(Dispositivo.Protezione.Individuale)")%></legend>
                            <table  width="100%" border="0" align="left">
                                <tr>
                                    <td width="19%" align="right">
                                        <%=ApplicationConfigurator.LanguageManager.getString("Tipologia.D.P.I.")%>&nbsp;
                                    </td>
                                    <td>	
                                        <select name="NOM_RES" style="width:96%">
                                            <option ></option>
                                            <%
                                            ITipologiaDPIHome TipologiaDPIHome=(ITipologiaDPIHome)PseudoContext.lookup("TipologiaDPIBean");
                                            out.print(BuildNomeComboBox(TipologiaDPIHome));
                                            %>
                                        </select>
                                    </td>	
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Responsabile")%>&nbsp;</td>
                    <td colspan="6" align="left">	
                        <select name="NOM_COR" style="width:30%">
                            <option ></option>
                            <%
                            IDipendenteHome DipendenteHome=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
                            out.print(BuildDipendenteComboBox(DipendenteHome, null, lCOD_AZL));
                            %>
                        </select>
                    </td>	
                </tr>	
                <tr>
                    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione.dal")%>&nbsp;</td>
                    <td><s2s:Date id="DAT_PIF_EGZ_COR_DAL" name="DAT_PIF_EGZ_COR_DAL" /></td>
                    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("al")%>&nbsp;</td>
                    <td colspan="4"><s2s:Date id="DAT_PIF_EGZ_COR_AL" name="DAT_PIF_EGZ_COR_AL" /></td>
                </tr>
                <tr>
                    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.effettuazione.dal")%>&nbsp;</td>
                    <td><s2s:Date id="EFF_DAT_DAL" name="EFF_DAT_DAL" /></td>
                    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("al")%>&nbsp;</td>
                    <td colspan="4"><s2s:Date id="EFF_DAT_AL" name="EFF_DAT_AL" /></td>
                </tr>
                <tr> 
                    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Raggruppati.per")%>&nbsp;</td>
                    <td width="10%"> 
                        <input name="R_RAGGRUPPATI"   value="T"  class="checkbox" type="radio"> 
                        &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%>&nbsp;
                    </td>
                    <td width="10%">
                        <input name="R_RAGGRUPPATI" value="L" class="checkbox" type="radio"> 
                        &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Lotto")%>&nbsp;
                    </td>
                    <td width="15%">
                        <input name="R_RAGGRUPPATI" value="A" class="checkbox"  type="radio"> 
                        &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp; 
                    </td>
                    <td width="10%">
                        <input name="R_RAGGRUPPATI" value="N" class="checkbox" checked type="radio"> 
                        &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nessuno")%>
                    </td>
                    <td width="18%" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Stato.misura")%>&nbsp;</td>
                    <td> 
                        <select name="STA_INT" style="width:75%">
                            <option></option>
                            <option value="D"><%=ApplicationConfigurator.LanguageManager.getString("Da.attuare")%></option>
                            <option value="G"><%=ApplicationConfigurator.LanguageManager.getString("Già.completata")%></option>
                        </select>
                    </td>
                </tr>
            </table>
        </fieldset>
	<tr>
	  <td>
	  <table border='0' align="left" width="874"  cellpadding='0' cellspacing='0' id='ListTableHeader' class='dataTableHeader'>
          <tr>
            <td width='40'>&nbsp;</td>
			<td width='140' onclick="goTab('inr');" id="pifTd"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.pianificaz.")%></strong>&nbsp;<img src="../_images/ORDINE_DOWN.gif" id="pifDw" style="display:none;"><img src="../_images/ORDINE_UP.GIF" id="pifUp" style="display:none;"></td>
			<td width='140' onclick="goTab('eft');" id="eftTd"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.effettuaz.")%></strong>&nbsp;<img src="../_images/ORDINE_DOWN.gif" id="eftDw" style="display:none;"><img src="../_images/ORDINE_UP.GIF" id="eftUp" style="display:none;"></td>
			<td width='180'><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Identificativo")%></strong></td>
			<td width='178'><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%></strong></td>
			<td width='178'><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%></strong></td>
            <td width='18'>&nbsp;</td></tr>
	  </table>
	</td>
	</tr>
	<tr>
	  <td>
				<div id="div_s" style='height: 150; overflow-y:auto'></div>
		</td>
	</tr>
	<tr>
		<td align="center" ><br>
		<fieldset style="width:90%">
		<table width='100%'>
			<tr>
			  <td width="25%" align="center"><img src="../_images/PALLA-ROSSA.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Rossa")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.in.ritardo")%></td>
                          <td width="25%" align="center"><img src="../_images/PALLA-BLUE.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Blue")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.scadenza.odierna")%></td>
                          <td width="25%" align="center"><img src="../_images/PALLA-NERA.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Nera")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.chiuse")%></td>
			  <td width="25%" align="center"><img src="../_images/PALLA-VERDE.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Verde")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.lavorate")%></td></tr>
		</table>
		</fieldset>
		</td>
	</tr>
</table>
</form>
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
</body>
<script type="text/javascript">
<!--
btn = ToolBar.Detail.getButton();
btn.onclick = goEGZ_COR;
btn1 = ToolBar.Search.getButton();
btn1.onclick = goTab;
ToolBar.Detail.setEnabled(false);
// --- REPORT ---
// -- function for Repoprt 1------------------------------------------------------- 
	function OnPrint1(){
			frm= document.forms[0];
			w=window.open("../Reports/prepair.jsp", "REP");
			frm.target = "REP";
			frm.action = "../Reports/ScadenzarioDPIManutenzioe.jsp";
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
			ToolBar.submitReport("RPT_SCD_DPI");
		}
	}  
	btn=ToolBar.Print2.getButton();	
	var OldPrint= btn.onclick;
	btn.onclick=OnPrint;
//---------------------------------------------------------------------------------
function restoreFrmProps(){
	frm.target = "ifrmWork";
	frm.action = "SCH_DPI_Tab.jsp";
}
//----------------------------------
// -->
</script>
