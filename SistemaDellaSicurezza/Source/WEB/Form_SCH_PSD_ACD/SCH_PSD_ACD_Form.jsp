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
    <version number="1.0" date="05/03/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="05/03/2004" author="Khomenko Juliya">
				   <description>Create SCH_PSD_ACD_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.Presidi.*" %>
<%@ page import="com.apconsulting.luna.ejb.SchedeInterventoPSD.*" %>
<%@ page import="com.apconsulting.luna.ejb.CategoriePreside.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="SCH_PSD_ACD_Util.jsp" %>

<!-- Dlya Selectov -->

<%@ include file="../src/com/apconsulting/luna/ejb/CategoriaDocumento/CategoriaDocumentoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/CategoriaDocumento/CategoriaDocumentoBean.jsp" %>

<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<% 
Checker c = new Checker();
String SCH_PSD_ACD=c.checkString("SCH_PSD_ACD",request.getParameter("SCH_PSD_ACD"),true);

if (c.isError){
	String err = c.printErrors();
	out.print("<script>err=true;alert(\""+err+"\");</script>");
	return;
}
int title = -1;
if (SCH_PSD_ACD.equals("M"))
    title = 0;
else
if (SCH_PSD_ACD.equals("S"))
    title = 1;
%>
<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuPresidiAntincendio, <%=title%>) + "</title>");
</script>
  <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
	<link rel="stylesheet" href="../_styles/tabs.css">
	    <script language="JavaScript" src="SCH_PSD_ACD_Script.js"></script>
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
//	long lCOD_AZL=Security.getAzienda();	

  long lCOD_CAG_DOC = 0;	
  long lCOD_IDE_PSD_ACD = 0;	

	
	String strSORT_PIF="asc";
	String strSORT_INT="";
	String strSORT_RSP="";
	
IAzienda azienda=null;
IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");

/*	Long azl_id=new Long(lCOD_AZL);
	azienda = AziendaHome.findByPrimaryKey(azl_id);
	String	strRAG_SCL_AZL = azienda.getRAG_SCL_AZL();
*/

%>

<!-- form for addind  piano-->
<table border="0">

<tr>
 <td valign="top">
<form action="SCH_PSD_ACD_Tabs.jsp" name="frm1" id="frm1"  method="GET" target="ifrmWork" style="margin:0 0 0 0;">
<input id="SORT_PIF" name="SORT_PIF" type="hidden" value="<%=strSORT_PIF %>">
<input id="SORT_INT" name="SORT_INT" type="hidden" value="<%=strSORT_INT %>">
<input id="SORT_RSP" name="SORT_RSP" type="hidden" value="<%=strSORT_RSP %>">
<input type="hidden" id="COD_PSD_ACD" name="COD_PSD_ACD" value="0">
<input type="hidden" id="COD_CAG_PSD_ACD" name="COD_CAG_PSD_ACD" value="0">
<input id="SCH_PSD_ACD" name="SCH_PSD_ACD" type="hidden" value="<%=SCH_PSD_ACD %>">  
<table  width="100%" border="0">
  <tr><td class="title"</td>
    <script>
      document.write(getCompleteMenuPath(SubMenuPresidiAntincendio, <%=title%>));
    </script>
  </tr>
  <tr>
	<td>
<!-- ############################ -->  		
<table>
<tr>
<td>
<%@ include file="../_include/ToolBar.jsp" %>      
	<%
	ToolBar.bShowSave=false;
	ToolBar.bShowDelete=false;
	ToolBar.bShowReturn=false;
	ToolBar.bShowDetail=true;
	ToolBar.bCanDetail=true;
	ToolBar.bAlwaysShowPrint=true;
	ToolBar.bCanPrint=true;
	if (Security.isConsultant()){
            ToolBar.bCanPrint2=true;
            ToolBar.bShowPrint2=true;
        }
	%>	
<%=ToolBar.build(4)%> 
</td>
</tr>
</table>
<!-- ########################### --> 	
  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.scheda.d'intervento")%></legend>
   <table  width="100%" border="0">
        <tr>
             <td align="right">
                 <b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b>
             </td>
             <td colspan="5">
             <!-- REPORT -->
                 <input type="checkbox" style="display:none" value="10" checked name="REP_TYPE">
                 <select name="COD_AZL" style="width:542px;">
                        <%=BuildAziendeComboBox(AziendaHome, 0)%>
                 </select>
             </td>
         </tr>
         <tr>
              <td colspan="6">
                 <table  width="100%" border="0" cellpadding="5" cellspacing="10">
                 <tr><td width="50%">
                   <fieldset>
                       <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.presidio.antincendio")%></legend>
                         <table width=100% border="0">
                            <tr> 
                                <td width="16%" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Categoria")%>&nbsp;</td>
                                <td width="23%"><input type="text" style="width:200" name="NOM_CAG_PSD_ACD" id="NB_NOM_CAG_PSD_ACD"/></td>
                                <td width="4%"><button onclick="getLOV_CAG()" class="getlist"><strong>&middot;&middot;&middot;</strong></button></td>
                                <td width="16%" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Identificativo")%>&nbsp;</td>
                                <td width="23%"><input type="text" style="width:200" name="IDE_PSD_ACD" id="NB_IDE_PSD_ACD" /></td>
                                <td><button onclick="getLOV_PSD()" class="getlist"><strong>&middot;&middot;&middot;</strong></button></td>
                            </tr>
                         </table>
                   </fieldset>
                 </table>
            </td>
         </tr>
	 <tr>
            <td valign="top" align="right"> 
                <div align="right"><%=ApplicationConfigurator.LanguageManager.getString("Responsabile")%>&nbsp;</div>
            </td>
            <td colspan="5">
                <input type="text" id="NB_NOM_RSP_INR" name="NOM_RSP_INR"  size=103 value="">
                <button onclick="getLOV_DPD()" class="getlist"><strong>&middot;&middot;&middot;</strong></button>
            </td>
	 </tr>
	 <tr>
            <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione.dal")%>&nbsp;</td>
            <td><s2s:Date id="DAT_PIF_INR_DAL" name="DAT_PIF_INR_DAL" /></td>
            <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("al")%>&nbsp;</td>
            <td colspan="3"><s2s:Date id="DAT_PIF_INR_AL"  name="DAT_PIF_INR_AL" /></td>
         </tr>
	 <tr>
              <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.intervento.dal")%>&nbsp;</td>
              <td><s2s:Date id ="DAT_INR_DAL" name="DAT_INR_DAL" /></td>
              <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("al")%>&nbsp;</td>
              <td colspan="3"><s2s:Date id="DAT_INR_AL"  name="DAT_INR_AL" /></td>
         </tr>
          
	 <tr>
              <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Raggruppati.per")%>&nbsp;</td>
              <td width="10%">
                    <input class="checkbox" type="radio" name="RAGGRUPPATI" value="A">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;
              </td>      
              <td width="10%">
                  <input class="checkbox" type="radio" name="RAGGRUPPATI" value="C">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Categoria")%>&nbsp;
              </td>
              <td width="10%">
                    <input class="checkbox" type="radio" name="RAGGRUPPATI" checked value="N">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nessuno")%>
              </td>
              <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Stato.misura")%>&nbsp;</td>
              <td>
                    <select style="width:150" name="STA_INT">
                        <option></option>
                        <option value="D" ><%=ApplicationConfigurator.LanguageManager.getString("Da.attuare")%></option>
                        <option value="G" ><%=ApplicationConfigurator.LanguageManager.getString("Già.completata")%></option>
                    </select>
              </td>
         </tr> 
   </table>	 
	 </fieldset>
	 </td></tr>
  </table>
<!--</td></tr>-->
<tr><td>
<table border=0>
<tr><td>
    <table border='0' align="left" width="771" id='ListTableHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>
		<tr>
		    <td width="40">&nbsp;</td>
            <td width='110' id="TDsortPIF" onclick="sort_SCH_PSD_ACD('pif');"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.pianificaz.")%></strong><img id='imgPIF' src='../_images/ORDINE_DOWN.gif' alt='down' style='display:none'></td>
		    <td width='110' id="TDsortINT" onclick="sort_SCH_PSD_ACD('int');"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.interv.")%></strong><img id='imgINT' src='../_images/ORDINE_DOWN.gif' alt='down' style='display:none'></td>
		    <td width='165' id="TDsortRSP" onclick="sort_SCH_PSD_ACD('rsp');"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Responsabile")%></strong><img id='imgRSP' src='../_images/ORDINE_DOWN.gif' alt='down' style='display:none'></td>
		    <td width='164'><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Categoria")%></strong></td>
		    <td width='164'><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%></strong></td>
            <td width="18">&nbsp;</td>
		</tr>
		</table>
</td></tr>
<tr><td>
		<div id="div_s" style='height: 150;width: 100%; overflow: auto'></div>
</td></tr>
<tr><td align="center"><br>
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
</td></tr>
</table>
</td></tr>  
</table>
</td></tr>
</table> 
</form>
<!-- /form for addind  piano-->
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
<script>
btn = ToolBar.Search.getButton();
btn.onclick = goTab;
btn1 = ToolBar.Detail.getButton();
btn1.onclick = goDOC;
ToolBar.Detail.setEnabled(false);
// --- REPORT ---
// -- function for Repoprt 1------------------------------------------------------- 
	function OnPrint1(){
			frm= document.forms[0];
			w=window.open("../Reports/prepair.jsp", "REP");
			frm.target = "REP";
			frm.action = "../Reports/ScadenzarioPresidiAntincendio.jsp";
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
			ToolBar.submitReport("RPT_REP_SCD_PSD_ACD");
		}
	}  
	btn=ToolBar.Print2.getButton();	
	var OldPrint= btn.onclick;
	btn.onclick=OnPrint;
//---------------------------------------------------------------------------------
function restoreFrmProps(){
	frm.target = "ifrmWork";
	frm.action = "SCH_PSD_ACD_Tabs.jsp";
}
//----------------------------------
</script>
</body>
</html> 

