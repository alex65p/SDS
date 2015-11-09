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
    <version number="1.0" date="9/03/2004" author="Yuriy Kushkarov">
	      <comments>
				  <comment date="9/03/2004" author="Yuriy Kushkarov">
				   <description>Create formi SCH_MAC_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.MisuraPreventiva.*" %>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.InterventoAudut.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_include/ComboBox-Azienda.jsp" %>
<%@ include file="../_include/ComboBox-Dipendente.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<%
String FromUrl = request.getParameter("FROM");
int title = -1;
if (FromUrl.equals("MAN"))
    title = 0;
else
if (FromUrl.equals("SOS"))
    title = 1;
%>
<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuMacchinari2, <%=title%>) + "</title>");
</script>
  <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
	<LINK REL=STYLESHEET HREF="../_style/index.css" TYPE="text/css">
	<link rel="stylesheet" href="../_styles/tabs.css">
	<script language="JavaScript" src="../_scripts/tabs.js"></script>
	<script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
  <script language="JavaScript" src="SCH_MAC_Script.js"></script>
  
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

<%
long lCOD_AZL = Security.getAzienda();	//2 
//long lCOD_MAN=0;
//long lCOD_MIS_PET=0;
//long lCOD_LUO_FSC=0;
long lCOD_DPD=0;
IAzienda azienda;
IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");
java.util.ArrayList azl_ids=Security.getAziende();
//String	strRAG_SCL_AZL="";
//Long azl_id=new Long(lCOD_AZL);
//long COD_AZL=new Long(lCOD_AZL).longValue();/
//	azienda = AziendaHome.findByPrimaryKey(azl_id);
//	String	strRAG_SCL_AZL= azienda.getRAG_SCL_AZL();
if(request.getParameter("AZIENDA")!=null)
{
  lCOD_AZL=new Long(request.getParameter("AZIENDA")).longValue();
	//out.print(lCOD_AZL);
}
String strFROM="";
if(request.getParameter("FROM")!=null)
{
  strFROM=request.getParameter("FROM");
}
%>
<!-- form for addind  piano-->
<form action="SCH_MAC_Tab.jsp"  method="GET" target="ifrmFile" id="FormParams" style="margin:0 0 0 0;">
<input id="TYPE" name="TYPE" type="hidden" value="">
<input type="hidden" id="COD_SCH_ATI_MNT" value="">
<input type="hidden" id="kolTr" value="">
<input type="hidden" id="first" value="">
<table border="0" cellpadding='0' cellspacing='0'>
<tr>
 <!-- <td width="10" height="100%" valign="top">
  <button type="button" class="menu" >&nbsp;1&nbsp;</button><br>
 <button type="button" class="menu">&nbsp;2&nbsp;</button>
 <button type="button" class="menu">&nbsp;3&nbsp;</button><br>
 <button type="button" class="menu">&nbsp;4&nbsp;</button>
 <button type="button" class="menu">&nbsp;5&nbsp;</button><br>
 

 </td> -->
 <td valign="top">
  <table width="100%" border="0">
  <tr><td class="title" colspan="2">
    <script>
      document.write(getCompleteMenuPath(SubMenuMacchinari2, <%=title%>));
    </script>
	<%if("MAN".equals(strFROM))
	{%>
            <!--SCADENZARIO MANUTENZIONE MACCHINE/ATTREZZATURE-->
            <input type="hidden" name="SCH_MAC" value="M">
	<%}
	else if("SOS".equals(strFROM))
	{%>
            <!--SCADENZARIO SOSTITUZIONE MACCHINE/ATTREZZATURE-->
            <input name="SCH_MAC" type="hidden" value="S">
        <%}%>
  </td></tr>
	<tr>
	<td colspan="2">
<table border=0>
<%@ include file="../_include/ToolBar.jsp" %>
<%
	ToolBar.bShowReturn=false;
	ToolBar.bShowDelete=false;
	ToolBar.bShowNew=true;
	ToolBar.bShowSave=false;
	ToolBar.bShowDetail=true;
	ToolBar.bCanDetail=true;
	ToolBar.bAlwaysShowPrint=true;
	ToolBar.bCanPrint=true;
	if (Security.isConsultant()){
            ToolBar.bCanPrint2=true;
            ToolBar.bShowPrint2=true;
        }
%>		
<%=ToolBar.build(3)%>
</table>
  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.scheda.d'intervento")%></legend>
     <table  width="100%" border="0">
   	   <tr>
	       <td align="right" width="14%"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
	       <td align="left" colspan="6">
	   	   <!-- REPORT -->
                    <input type="checkbox" style="display:none" value="11" checked name="REP_TYPE">
                    <select style="width:670px" name="COD_AZL" onchange="frameRefresh.document.location.replace('SCH_MAC_Form.jsp?AZIENDA='+document.all['COD_AZL'].value);">
		       <%=BuildAziendeComboBox(AziendaHome, lCOD_AZL)%>
                    </select>
	       </td>
	   </tr>
	   <tr>
	       <td colspan="7">
                    <fieldset>
                        <legend><%=ApplicationConfigurator.LanguageManager.getString(
                            ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                ?"Dati.macchina.attrezzatura.impianto"
                                :"Dati.macchina/attrezzatura"
                       )%></legend>
                            <table  width="100%" border="0">
                                <tr>
                                    <td width="14%" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Identificativo")%>&nbsp;</td>
                                    <td width="30%">
                                        <input type="hidden" name="COD_MAC" value="0">
				  	<input type="text" name="NOM_MAC" id="NOM_MAC" style="width:250px;" value="">
                                    </td>
                                    <td width="14%" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                    <td width="30%"><input type="text" name="DES_MAC" id="DES_MAC" style="width:250px;" value=""></td>
                                    <td><button onclick="getLOV_MAC()" class="getlist"><strong>&middot;&middot;&middot;</strong></button></td>  
                                </tr>
                            </table>
                    </fieldset>
              </td>
        </tr>
        <tr>
            <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Responsabile")%>&nbsp;</td>
            <td colspan="6">
                <select style="width:400px" name="COD_DPD" id="COD_DPD">
                    <option value="0"></option>
                    <%
                        IDipendenteHome DipendenteHome=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
                        out.print(BuildDipendenteComboBox(DipendenteHome, lCOD_DPD, lCOD_AZL));
                    %>
		 </select>
             </td>
	 </tr>
	 <tr>
            <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Attività.svolta")%>&nbsp;</td>
            <td colspan="6">
               <textarea rows="3" style="width:400px" name="ATI_SVO"></textarea>
            </td>
	 </tr>
         <tr>
            <td align="right" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione.dal")%>&nbsp;</td>
            <td><s2s:Date name="DAT_PIF_DAL" id="DAT_PIF_DAL" /></td>
            <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("al")%>&nbsp;</td>
            <td colspan="4"><s2s:Date name="DAT_PIF_AL" id="DAT_PIF_AL" /></td>
        </tr>
        <tr>
            <td align="right" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Data.intervento.dal")%>&nbsp;</td>
            <td><s2s:Date  name="DAT_EFT_DAL" id="DAT_EFT_DAL" /></td>
            <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("al")%>&nbsp;</td>
            <td colspan="4"><s2s:Date name="DAT_EFT_AL" id="DAT_EFT_AL" /></td>
        </tr>
        <tr>
            <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Raggruppati.per")%>&nbsp;</td>
            <td width="10%"><input type="radio" class="checkbox" name="R_T" id="R_T" value="D">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Responsabile")%>&nbsp;</td>
            <td width="10%"><input type="radio" class="checkbox" name="R_T" id="R_T" value="A">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</td>
            <td><input type="radio" class="checkbox" name="R_T" id="R_T" value="M">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString(
                    ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                        ?"Macchina.attrezzatura.impianto"
                        :"Macchina/Attrezzatura"
            )%>&nbsp;</td>
            <td><input type="radio" class="checkbox" checked   name="R_T" id="R_T" value="N">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nessuno")%>&nbsp;&nbsp;&nbsp;</td>
            <td nowrap align="right"><%=ApplicationConfigurator.LanguageManager.getString("Stato.intervento")%>&nbsp;</td>
            <td>
                <select name="STA_INT">
                    <option value="0"></option>
                    <option value="D"><%=ApplicationConfigurator.LanguageManager.getString("Da.attuare")%></option>
                    <option value="G"><%=ApplicationConfigurator.LanguageManager.getString("Già.completato")%></option>
		 </select>
             </td>
	 </tr>
   </table>	 
	 </fieldset></td></tr>
  <tr>
	</tr>
  </table>
 </td>
</tr>
<tr>
 <td colspan="7" width="100%">
        
     <table border="0" align="center" cellpadding='0' cellspacing='0'><tr><td>

        <table width="879" id='ListTableHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>
            <tr>
                <td width="40">&nbsp;</td>
                <td width="120" id="pifTd" onclick="goTab('inr');"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.pianificaz.")%></strong>&nbsp;<img src="../_images/ORDINE_DOWN.gif" id="pifDw" style="display:none;"><img src="../_images/ORDINE_UP.GIF" id="pifUp" style="display:none;"></td>
                <td width="120" id="adtTd" onclick="goTab('adt');"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.interv.")%></strong>&nbsp;<img src="../_images/ORDINE_DOWN.gif" id="adtDw" style="display:none;"><img src="../_images/ORDINE_UP.GIF" id="adtUp" style="display:none;"></td>
                <td width="191"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Responsabile")%></strong></td>
                <td width="190"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString(
                    ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                        ?"Macchina.attrezzatura.impianto"
                        :"Macchina/Attrezzatura"
                )%></strong></td>
                <td width="200"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%></strong></td>
                <td width="18">&nbsp;</td>
            </tr>
        </table></td></tr>
        
	<tr>
    <td width="100%" colspan="5">
	    <div id="divFile" style="height:150px;overflow-y:auto"></div>
	  </td>
	</tr>
	<tr>
	  <td align="center" colspan="5"><br>
		<fieldset style="width:90%">
		<table width='100%'>
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
 </td>
</tr>
</table>
</form>
<!-- /form for addind  piano-->
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
<iframe name="ifrmFile" id="ifrmFile" class="ifrmWork" src="../empty.txt"></iframe>
<script>
btn = ToolBar.Detail.getButton();
btn.onclick = goSCH_MNT;
btn1 = ToolBar.Search.getButton();
btn1.onclick = goTab;
ToolBar.Detail.setEnabled(false);
// --- REPORT ---
// -- function for Repoprt 1------------------------------------------------------- 
	function OnPrint1(){
			frm= document.forms[0];
			w=window.open("../Reports/prepair.jsp", "REP");
			frm.target = "REP";
			frm.action = "../Reports/ScadenzarioMacchineAttrezzature.jsp";
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
			ToolBar.submitReport("RPT_SCD_MAC");
		}
	}  
	btn=ToolBar.Print2.getButton();	
	var OldPrint= btn.onclick;
	btn.onclick=OnPrint;
//---------------------------------------------------------------------------------
function restoreFrmProps(){
	frm.target = "ifrmWork";
	frm.action = "SCH_MAC_Tab.jsp";
}
//----------------------------------
</script>
</body>
</html> 
