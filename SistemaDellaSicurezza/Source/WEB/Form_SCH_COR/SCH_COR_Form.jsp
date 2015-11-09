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
    <version number="1.0" date="1/03/2004" author="Podmasteriev Alexandr">
	      <comments>
				  <comment date="1/03/2004" author="Podmasteriev Alexandr">
				   <description>Shablon formi SCH_COR_Form.jsp</description>
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
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.Corsi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="SCH_COR_Util.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/DocentiCorso/DocentiCorsoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DocentiCorso/DocentiCorsoBean.jsp" %>
<%@ include file="../_include/ComboBox-Azienda.jsp" %>
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
	ICorsi  corsi=null;
	IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");

if(request.getParameter("AZIENDA")!=null)
{
  lCOD_AZL=new Long(request.getParameter("AZIENDA")).longValue();
}
//----------------- opredelenie statusov dla radio knopok
	String strSVMedicina="", strSVIdoneita="";
	String strSSPianificata="", strSSEffettuata="", strSSNessuno="";
	String strSRLavoratore="", strSRAzienda="", strSRNessuno="";
%>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuAnalisiControllo,4) + "</title>");
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
    
    <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
	<LINK REL=STYLESHEET HREF="../_styles/tabs.css" TYPE="text/css">
	<script language="JavaScript" src="SCH_COR_Script.js"></script>
</head>
<script>
window.dialogWidth = "860px";
window.dialogHeight= "475px";
</script>
<body>

<form action="SCH_COR_Tabs.jsp" name="frm1" id="frm1"  method="GET" target="ifrmWork" style="margin:0 0 0 0;">
<input id="TYPE" name="TYPE" type="hidden" value="INRup">
<input id="COD_SCH_EGZ_COR" type="hidden" >
<input type="hidden" id="kolTr" value="">
<input type="hidden" id="first" value="">
<input type="hidden" id="COD_AZL" name="COD_AZL" value="<%=lCOD_AZL%>">
<table border="0" width="100%">
  <tr>
  <td class="title">
    <script>
        document.write(getCompleteMenuPath(SubMenuAnalisiControllo,4));
    </script>      
  </td>
  </tr>
</table>
<!-- Fine modifica effettuata da Francesco Di Martino 01-10-2004 --> 
	<!-- ********************************************* -->
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
<!-- ********************************************* -->		
<table width="100%" border="0"><tr><td>
            <fieldset>
                <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.scheda.d'intervento")%></legend>
                <table width="100%" border="0">
                    <tr> 
                        <td align="right">
                            <b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b>
                        </td>
                        <!-- REPORT -->
                        <td colspan="7">
                            <input type="checkbox" style="display:none" value="5" checked name="REP_TYPE">
                            <!-- REPORT Non si vede, matteo-->
                            <select name="select" style="width:97%" onChange="frameRefresh.document.location.replace('SCH_COR_Form.jsp?AZIENDA='+document.all['COD_AZL'].value);">
                                <%=BuildAziendeComboBox(AziendaHome, lCOD_AZL)%>
                            </select>
                        </td>
                    </tr>
                    <tr> 
                        <td colspan="8">
                            <fieldset>
                                <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.corso")%></legend>
                                <table width="100%" border="0">
                                    <tr>
                                        <td align="right" width="16%">
                                            <%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;
                                        </td>
                                        <td> 
                                            <select name="NOM_COR" id="NOM_COR" style="width:280px">
                                                <option></option>
                                                <%ICorsiHome CorsiHome=(ICorsiHome)PseudoContext.lookup("CorsiBean");
                                                 out.print(BuildNomeComboBox(CorsiHome,lCOD_AZL));

                                                %>
                                            </select>
                                        </td>
                                        <td align="right">
                                            <%=ApplicationConfigurator.LanguageManager.getString("Docente")%>&nbsp;
                                        </td>
                                        <td>
                                            <select name="NOM_DCT" id="NOM_DCT" style="width:310px">
                                                <option></option>
                                                <% IDocentiCorsoHome DocentiHome=(IDocentiCorsoHome)PseudoContext.lookup("DocentiCorsoBean");
                                                   out.print(BuildDocenteComboBox(DocentiHome,lCOD_AZL)); %>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>	  
                        </td>
                    </tr>
                    <tr> 
                        <td align="right">
                            <%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione.dal")%>&nbsp;
                        </td>
                        <td  align="left">
                            <s2s:Date id="DAT_PIF_EGZ_COR_DAL2" name="DAT_PIF_EGZ_COR_DAL2"/>
                        </td>
                        <td align="right">
                            <%=ApplicationConfigurator.LanguageManager.getString("al")%>&nbsp;
                        </td>
                        <td align="left">
                            <s2s:Date id="DAT_PIF_EGZ_COR_AL2" name="DAT_PIF_EGZ_COR_AL2" /> 
                        </td>
                        <td align="right">
                            <%=ApplicationConfigurator.LanguageManager.getString("Data.effettuazione.dal")%>&nbsp;
                        </td>
                        <td align="left">
                            <s2s:Date  id ="EFF_DAT_DAL2" name="EFF_DAT_DAL2" />
                        </td>
                        <td align="right">
                            <%=ApplicationConfigurator.LanguageManager.getString("al")%>&nbsp;
                        </td>
                        <td align="left">
                            <s2s:Date id="EFF_DAT_AL2" name="EFF_DAT_AL2"  /> 
                        </td>
                    </tr>
                    <tr> 
                        <td align="right">
                            <%=ApplicationConfigurator.LanguageManager.getString("Raggruppati.per")%>&nbsp;
                        </td>
                        <td align="left" colspan="4"> 
                            <input name="R_RAGGRUPPATI" value="C"  class="checkbox" type="radio">
                            &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Corso")%>&nbsp;
                            <input name="R_RAGGRUPPATI" value="D" class="checkbox" type="radio">
                            &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Docente")%>&nbsp;
                            <input name="R_RAGGRUPPATI" value="A" class="checkbox"  type="radio">
                            &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;
                            <input name="R_RAGGRUPPATI" value="N" class="checkbox" checked type="radio">
                            &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nessuno")%>
                        </td>
                        <td align="right">
                            <%=ApplicationConfigurator.LanguageManager.getString("Stato.misura")%>&nbsp;
                        </td>
                        <td colspan="2">
                            <select name="STA_INT" id="STA_INT" style="width:115px">
                                <option></option>
                                <option value="D"><%=ApplicationConfigurator.LanguageManager.getString("Da.attuare")%></option>
                                <option value="G"><%=ApplicationConfigurator.LanguageManager.getString("Già.completata")%></option>
                            </select>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </td>
    </tr>
</table>
<!-- *********************inizio parte inferiore************************** -->
<table border="0"><tr><td>
<table align="left" width="834" id='ListTableHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>
<tr>
			<td width='40'>&nbsp;</td>
            <td width='140' onclick="goTab('inr');" id="pifTd"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.pianificaz.")%></strong>&nbsp;<img src="../_images/ORDINE_DOWN.gif" id="pifDw" style="display:none;"><img src="../_images/ORDINE_UP.GIF" id="pifUp" style="display:none;"></td>
			<td width='140' onclick="goTab('eft');" id="eftTd"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.effettuaz.")%></strong>&nbsp;<img src="../_images/ORDINE_DOWN.gif" id="eftDw" style="display:none;"><img src="../_images/ORDINE_UP.GIF" id="eftUp" style="display:none;"></td>
			<td width='166'><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Docente")%></strong></td>
			<td width='165'><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome.del.corso")%></strong></td>
			<td width='165'><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%></strong></td>
            <td width='18'>&nbsp;</td>
</tr>
</table></td></tr>


<tr>
	  <!-- <td><div id="div_s" style='height: 110;overflow-y:auto; width:780px'></div></td> -->
	  <td><div id="div_s" style='height: 150;overflow-y:auto; width:100%'></div></td>
</tr>
<tr>
<td align="center" colspan="5" ><br>
<fieldset style="width:100%">
   <table width='100%' border="0">
   <tr>
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
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt">
</iframe>
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
			frm.action = "../Reports/ScadenzarioCorsi.jsp";
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
			ToolBar.submitReport("RPT_SCD_COR");
		}
	}  
	btn=ToolBar.Print2.getButton();	
	var OldPrint= btn.onclick;
	btn.onclick=OnPrint;
//---------------------------------------------------------------------------------
function restoreFrmProps(){
	frm.target = "ifrmWork";
	frm.action = "SCH_COR_Tabs.jsp";
}
//----------------------------------
// -->
</script>
