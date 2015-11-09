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
    <version number="1.0" date="27/01/2004" author="Alex Kyba">
	      <comments>
				  <comment date="27/01/2004" author="Alex Kyba">
					   <description>Shablon formi ANA_MIS_PET_AZL_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.TipologiaMisurePreventive.*" %>
<%@ page import="com.apconsulting.luna.ejb.MisurePreventProtettiveAz.*" %>

<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="ANA_MIS_PET_AZL_Util.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuStrumenti,1) + "</title>");
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
</head>
<link rel="stylesheet" href="../_styles/style.css">
<link rel="stylesheet" href="../_styles/tabs.css">
<script src="../_scripts/tabs.js"></script>
<script src="../_scripts/tabbarButtonFunctions.js"></script>
<!-- <style>
	.getList{
		width:20px;
		height:20px;
		vertical-align:middle;
	}
</style> -->

<script>
if("<%=request.getParameter("ID")%>" == "null")
{
	window.dialogWidth="850px";
	window.dialogHeight="500px";
}
else
{
	window.dialogLeft="100px";
	window.dialogTop="20px";
	window.dialogWidth="850px";
	window.dialogHeight="710px";
}
</script>

<body >
<%
	String strCOD_MIS_PET_AZL="";
	
//-------------------------------------------------
	long lCOD_AZL=Security.getAzienda();			
	String strRAG_SCL_AZL = new String();
	//------------------
	long lCOD_MIS_PET_AZL=0;
	String strNOM_MIS_PET="";
  	java.sql.Date dtDAT_CMP=null;
  	long lVER_MIS_PET=0;
  	String strPER_MIS_PET="";
  	long lPNZ_MIS_PET_MES=0;
  	java.sql.Date dtDAT_PNZ_MIS_PET=null;
  	String strDES_MIS_PET="";
  	String strTPL_DSI_MIS_PET="";
  	String strSTA_MIS_PET="D";
	String strDES_TPL_MIS_PET="";
  	long lCOD_TPL_MIS_PET=0;
	long lCOD_RSO_MAN=0;
	long lCOD_MAN=0;
  	long lCOD_RSO_LUO_FSC=0;
	long lCOD_LUO_FSC=0;
	boolean desButtons=false;
	//---------------------------
	String disableLuogo="", disableAttivita="";
	String StrRischi = "";
	java.util.Collection  col;
	java.util.Iterator it;
//-----------------------------------------------------------------
//----------------Interfaces & Beans--------------------------------
	//-----Azienda--------
	IAziendaHome azHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");
	IAzienda azienda=null;
	//-----MisurePrevenzione-------------
	IMisurePreventProtettiveAz bean=null;
	IMisurePreventProtettiveAzHome home=(IMisurePreventProtettiveAzHome)PseudoContext.lookup("MisurePreventProtettiveAzBean");
	//-----LuoghiFisici-----------------
	IAnagrLuoghiFisici luoghi = null;
	IAnagrLuoghiFisiciHome luoghiHome=(IAnagrLuoghiFisiciHome)PseudoContext.lookup("AnagrLuoghiFisiciBean");
	//-----AttivitaLavorativa------------------------
	IAttivitaLavorative attivitaLavorative=null;
	IAttivitaLavorativeHome attLavHome=(IAttivitaLavorativeHome)PseudoContext.lookup("AttivitaLavorativeBean"); 
	//-----Rischi -----------------------------------
	IRischio rischio = null;
	IRischioHome rischioHome=(IRischioHome)PseudoContext.lookup("RischioBean");
	//----------get current azienda -----------------
	azienda = azHome.findByPrimaryKey(new Long(lCOD_AZL));
	strRAG_SCL_AZL = azienda.getRAG_SCL_AZL();
	//-------Tipologia Misure--------------
	//ITipologiaMisurePreventive tpl = null;
	ITipologiaMisurePreventiveHome tplHome=(ITipologiaMisurePreventiveHome)PseudoContext.lookup("TipologiaMisurePreventiveBean"); 
	try{
		// col  = tplHome.getTipologiaByDescription_View("DA PARTE DELL'AZIENDA");
                TipologiaMisurePreventiveBean appo = (TipologiaMisurePreventiveBean)(tplHome.findByPrimaryKey(1l));
                if (appo != null){
                    lCOD_TPL_MIS_PET = appo.getCOD_TPL_MIS_PET();
                    strDES_TPL_MIS_PET = appo.getDES_TPL_MIS_PET();
                }/*NOTA SULL'OGGETTO "appo": inizialmente la tipologia della misura di prevenzione
                veniva ricercata, nella tabella tpl_mis_pet_tab, per descrizione;
                adesso la ricerca avviene per codice (1 è il codice di "DA PARTE DELL'AZIENDA").*/                        
		
                /*
                it = col.iterator();
		while(it.hasNext()){
			TipologiaView view =(TipologiaView)it.next();
			lCOD_TPL_MIS_PET=view.lCOD_TPL_MIS_PET;
			strDES_TPL_MIS_PET=view.strDES_TPL_MIS_PET;
		}*/	
	}
	catch(Exception ex){
		out.print("<script>alert(arraylng[\"MSG_0044\"]);</script>>");
		desButtons=true;
	}	
	
//---------
// stub for debuging
//strCOD_AZL="1042315978732";
//if (true) return;
if(request.getParameter("ID")!=null)
{
 	// getting parameters of azienda
	try{
		Long ID = new Long(request.getParameter("ID"));
		bean=home.findByPrimaryKey(ID);
		lCOD_MIS_PET_AZL=bean.getCOD_MIS_PET_AZL();
		strNOM_MIS_PET=bean.getNOM_MIS_PET();
  		dtDAT_CMP=bean.getDAT_CMP();
  		lVER_MIS_PET=bean.getVER_MIS_PET();
  		strPER_MIS_PET=bean.getPER_MIS_PET();
  		lPNZ_MIS_PET_MES=bean.getPNZ_MIS_PET_MES();
  		dtDAT_PNZ_MIS_PET=bean.getDAT_PNZ_MIS_PET();
  		strDES_MIS_PET=bean.getDES_MIS_PET();
  		strTPL_DSI_MIS_PET=bean.getTPL_DSI_MIS_PET();
  		strSTA_MIS_PET=bean.getSTA_MIS_PET();
  		lCOD_AZL=bean.getCOD_AZL();
  		lCOD_TPL_MIS_PET=bean.getCOD_TPL_MIS_PET();
		lCOD_RSO_MAN=bean.getCOD_RSO_MAN();
		lCOD_MAN=bean.getCOD_MAN();
  		lCOD_RSO_LUO_FSC=bean.getCOD_RSO_LUO_FSC();
		lCOD_LUO_FSC=bean.getCOD_LUO_FSC();
		if (lCOD_LUO_FSC!=0) {
			disableAttivita="disabled"; 
			luoghi=luoghiHome.findByPrimaryKey(new Long(lCOD_LUO_FSC));
			col = luoghi.getRischiByLuoghiFisiciView(lCOD_AZL);
			StrRischi = BuildRischiByLuoghiFisici(col, lCOD_RSO_LUO_FSC);
		}
		else if (lCOD_MAN!=0) {
			disableLuogo = "disabled";
			attivitaLavorative = attLavHome.findByPrimaryKey(new AttivitaLavorativePK(lCOD_AZL, lCOD_MAN));
			col = attivitaLavorative.getRischiByAttivataLavorativaView(lCOD_AZL);
			StrRischi = BuildRischiByAttivtaLavorativa(col, lCOD_RSO_MAN);
		}
		
	//	out.print(lCOD_LUO_FSC)
	// getting of azienda object
	}
	catch(Exception ex){
		out.print("<strong>"+ex.getMessage()+"</strong>");
		return;
	}
}// if request*/
%>
<table cellpadding="0" cellspacing="12" width="100%">
 	<tr><td>
	<form action="ANA_MIS_PET_AZL_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
  	
	<tr style='height:10'><td colspan=2></td></tr>
	<tr><td align="center" colspan="2" class="title">
            <script>
                document.write(getCompleteMenuPathFunction
                    (SubMenuStrumenti,1,<%=request.getParameter("ID")%>));
            </script>
        <br></td></tr>
  	<tr>
	<td>
<table width="100%">
<tr>
<td>
		<!-- ########################################################################################################## -->
  		<%@ include file="../_include/ToolBar.jsp" %>
		<% 
		if (request.getParameter("ID")==null)
			{
				if (!desButtons){
					ToolBar.bCanDelete=ToolBar.bCanEdit;
				}
				else{
					ToolBar.bCanDelete=false;
					ToolBar.bCanEdit=false;
				}	
				ToolBar.bCanPrint=false;
				//ToolBar.strSearchUrl = "";
			}
			else{
				ToolBar.bCanPrint2=true;
				ToolBar.bShowPrint2=true;
			}
			ToolBar.strPrintUrl="ListaInterventiAziendaliAttivita.jsp?";
			ToolBar.strPrintUrl2="ListaInterventiAziendaliAttivita2.jsp?";
		 %>
		<%=ToolBar.build(5)%>
<!-- ########################################################################################################## -->
</td>
</tr>
</table>

<fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione")%></legend>
   <table border="0" cellpadding="1" cellspacing="1" width="100%"> 
   <tr><td><input name="SBM_MODE" type="Hidden" value="<%if(lCOD_MIS_PET_AZL!=0){out.print("edt");}else{out.print("new");}%>"></td></tr>
   <tr><td><input name="COD_MIS_PET_AZL" type="Hidden" value="<%=Formatter.format(lCOD_MIS_PET_AZL)%>"></td></tr>
    <tr>
	 <td align="right" width="20%"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</td>
	 <td  width="80%" colspan="4">
	 	<input type="hidden" name="COD_AZL"  id="COD_AZL" value="<%= Formatter.format(lCOD_AZL)%>">
		<input style="width:100%" type="text" readonly name="RAG_SCL_AZL"  value="<%= Formatter.format(strRAG_SCL_AZL)%>">
	</td>
   </tr>
	<tr>
		<td align="right" ><b><%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%>&nbsp;</b></td>
		<td   colspan="4">
			 <select tabindex="1" style="width:100%"  name="COD_LUO_FSC" id="COD_LUO_FSC" <%= disableLuogo %> onchange="disableAnaMan(this)">
			<option value='0'></option>
			<%
			String luoFis_cmb=BuildLuoghiFisiciComboBox(luoghiHome, lCOD_LUO_FSC);
			out.print(luoFis_cmb);
			%>
			</select>	
		</td>
	</tr>
	<tr>
		<td align="right" ><b><%=ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa")%>&nbsp;</b></td>
		<td colspan="4">
			<select tabindex="2" style="width:100%" name="COD_MAN" id="COD_MAN" <%= disableAttivita %> onchange="disableLuoFsc(this)">
			<option value='0'></option>
	 		<%
			String attLav_cmb=BuildAttivitaLavorativaComboBox(attLavHome, lCOD_MAN);
			out.print(attLav_cmb);
			%>
			</select>
		</td>
	</tr>
	<tr>
		<td align="right" colspan="5">
			<fieldset style="width:100%">
	 			<legend><%=ApplicationConfigurator.LanguageManager.getString("Rischio")%></legend>
				<table width="100%" style="margin: 5 0 9 0">
					<tr>
						<td align="right" style="width:21%"><b><%=ApplicationConfigurator.LanguageManager.getString("Rischio")%>&nbsp;</b></td>
						<td  style="width:79%" id="RSO_CONT">
							<input tabindex="3" type="hidden" value="" name="COD_RSO_MAN" value="<%= lCOD_RSO_MAN %>">
							<input type="hidden" value="" name="COD_RSO_LUO_FSC" value="<%= lCOD_RSO_LUO_FSC %>">
							<select tabindex="4" style="width:100%" name="RSO" id="RSO"  onchange="enableMisura()">
								<%= StrRischi %>
							</select>	
						</td>
						<td style="width:2%">
							<button tabindex="5" class="getlist" onclick="getRischiList()" id="btnGetRischi">
								<strong>&middot;&middot;&middot;</strong>
							</button>							
						</td>
					</tr>
				</table>
			</fieldset>  	
	 
		</td>
	</tr>
	<tr>
		<td align="right"><strong><%=ApplicationConfigurator.LanguageManager.getString("Versione")%>&nbsp;</strong></td>
		<td align="left"><input tabindex="6" style="" type="text" name="VER_MIS_PET" id="VER_MIS_PET" maxlength="3" size="4" value="<%= Formatter.format(lVER_MIS_PET) %>"></td>
		<td align="right" style="width:16%"><strong><%=ApplicationConfigurator.LanguageManager.getString("Destinatario.tutela")%>&nbsp;</strong></td>
                <td colspan="2" align="left"> 
			<select  tabindex="7" name="TPL_DSI_MIS_PET" style="width:120px" id="TPL_DSI_MIS_PET">
				<option value=""></option>
				<option value="O" <% if (strTPL_DSI_MIS_PET.equals("O")) out.print("selected"); %>><%=ApplicationConfigurator.LanguageManager.getString("PER.OPERATORE")%></option>
				<option value="T" <% if (strTPL_DSI_MIS_PET.equals("T")) out.print("selected"); %>><%=ApplicationConfigurator.LanguageManager.getString("PER.TUTTI")%></option>
				<option value="A" <% if (strTPL_DSI_MIS_PET.equals("A")) out.print("selected"); %>><%=ApplicationConfigurator.LanguageManager.getString("PER.AZIENDA")%></option>
			</select>
		</td>
	</tr>
	<tr>
		<td align="right"><strong><%=ApplicationConfigurator.LanguageManager.getString("Misura")%>&nbsp;</strong></td>
		<td colspan="4" style="white-space:nowrap;">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
			 <tr>
			  <td style="white-space:nowrap;width:96%;">
				<input tabindex="8" style="width:100%" type="text"   name="NOM_MIS_PET" id="NOM_MIS_PET" maxlength="100" value="<%= strNOM_MIS_PET %>">
			  </td>
				</tr> 
			</table>
		</td>
	</tr>
	
	<tr>
		<td align="right"><strong><%=ApplicationConfigurator.LanguageManager.getString("Adottata/Da.adottare")%>&nbsp;</strong></td>
                <td>
                    <input tabindex="9" type="hidden" value="<%= lCOD_TPL_MIS_PET %>" name="COD_TPL_MIS_PET" id="COD_TPL_MIS_PET">
                    <input tabindex="9" style="width:100%" type="text" readonly name="DES_TPL_MIS_PET" id="DES_TPL_MIS_PET" maxlength="20" value="<%= strDES_TPL_MIS_PET %>">
                </td>                    
                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Data.compilazione")%>&nbsp;</b></td>
                <td colspan="2" align="right">
                    <div align="left"><s2s:Date tabindex="10"  name="DAT_CMP"  id="DAT_CMP" value="<%= Formatter.format(dtDAT_CMP) %>"/></div>
                </td>
	</tr>
	<tr>
		<td colspan="5" align="right">
			<fieldset style="width:100%">
	 			<legend><%=ApplicationConfigurator.LanguageManager.getString("Periodicità.misura.di.prevenzione")%></legend>
				<table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin: 5 3 9 0">
					<tr>
						<td style="white-space:nowrap;width:10%" align="right">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Periodicità.(S/N)")%>&nbsp;</td>
						<td>
							<input tabindex="11" type="checkbox" class="checkbox" name="PER_MIS_PET" id="PER_MIS_PET" <% if (strPER_MIS_PET.equals("S")) out.print("checked"); %> value="S">
						</td>
						<td style="white-space:nowrap;" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Pianificazione.mis.di.prev.")%>&nbsp;</td>
						<td><input tabindex="12" type="text" size="8" name="PNZ_MIS_PET_MES" id="PNZ_MIS_PET_MES" value="<%= lPNZ_MIS_PET_MES %>"></td>
                                                <td style="white-space:nowrap;" align="right"><strong><%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione")%>&nbsp;</strong></td>
                                                <td style="width:10%">
                                                 <s2s:Date tabindex="13" value="<%= Formatter.format(dtDAT_PNZ_MIS_PET) %>"   name="DAT_PNZ_MIS_PET"  id="DAT_PNZ_MIS_PET"/>
                                                </td>
					</tr>
				</table>
			</fieldset>		
		</td>
	</tr>
	<tr>
		<td align="right" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
		<td colspan="4">
				<textarea tabindex="14" name="DES_MIS_PET" id="DES_MIS_PET" style="width:100%; height:40px;"><%= strDES_MIS_PET %></textarea>
		</td>
	</tr>
	</table>
  </td>
</tr>
<tr>
	<td><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
</tr> 
</table>
</form>
  </td></tr>
</table> 
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" id="ifrmWork"></iframe>

<%
//-------Loading of Tabs--------------------
String s= "";
String str="";
if(bean!=null)
{
	
	s="false";
	//
	str=BuildAnagraficaDocumentiTab(bean);
	out.print(str);
	str=BuildNormativeSentenzeView(bean);
	out.print(str);
// -----------------------------------------
/*}
else{
	s="true";
	str=BuildEmptyAnagraficaDocumentiTab();
	out.print(str);
	str=BuildEmptyNormativeSentenzeView();
	out.print(str);*/
%>
<script>
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
	tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti")%>", tabbar));
	tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Normative/Sentenze")%>", tabbar));
	
	//------adding tables to tabs-----------------------
	tabbar.idParentRecord = <%=Formatter.format(lCOD_MIS_PET_AZL)%>;
 	tabbar.refreshTabUrl="ANA_MIS_PET_AZL_RefreshTabs.jsp";	
	tabbar.tabs[0].tabObj.addTable( document.all["AnagraficaDocumentiHeader"],document.all["AnagraficaDocumenti"], true);
	tabbar.tabs[1].tabObj.addTable( document.all["NormativeSentenzeHeader"],document.all["NormativeSentenze"], true);
	//tabbar.DEBUG_TABS_IFRM = true;
	//----add action parameters to tabs
	tabbar.tabs[0].tabObj.actionParams ={
	                   "Feachures":ANA_DOC_Feachures,
										 "AddNew":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_MIS_PET_AZL/ANA_MIS_PET_AZL_Attach.jsp&ATTACH_SUBJECT=DOCUMENT", 
													"buttonIndex":0
												  	},		
										 "Edit":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_MIS_PET_AZL/ANA_MIS_PET_AZL_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
													"buttonIndex":1
										 			},
										 "Delete":	{"url":"../Form_ANA_MIS_PET_AZL/ANA_MIS_PET_AZL_Delete.jsp?LOCAL_MODE=doc",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2
										 			}			  	
										}; 
		//--------------------------------------------------------------
	tabbar.tabs[1].tabObj.actionParams ={
	                   "Feachures":ANA_NOR_SEN_Feachures,
										 "AddNew":	{"url":"../Form_ANA_NOR_SEN/ANA_NOR_SEN_Form.jsp?ATTACH_URL=Form_ANA_MIS_PET_AZL/ANA_MIS_PET_AZL_Attach.jsp&ATTACH_SUBJECT=NOR_SEN", 
													"buttonIndex":0
												  	},		
										 "Edit":	{"url":"../Form_ANA_NOR_SEN/ANA_NOR_SEN_Form.jsp?ATTACH_URL=Form_ANA_MIS_PET_AZL/ANA_MIS_PET_AZL_Attach.jsp&ATTACH_SUBJECT=NOR_SEN",
													"buttonIndex":1
										 			},
										 "Delete":	{"url":"../Form_ANA_MIS_PET_AZL/ANA_MIS_PET_AZL_Delete.jsp?LOCAL_MODE=nor",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2
										 			}			  	
										}; 									
	//-----activate first tab--------------------------
	//tabbar.tabs[0].center.click();			
</script>
<% } %>
<script>
	//----------------------------
	function disableAnaMan(obj){
		if (obj.selectedIndex!=0){
			document.all["COD_MAN"].disabled=true;
		}	
		else{
			document.all["COD_MAN"].disabled=false;			
		}	
		document.all["RSO"].options.length=0;
		document.all["COD_RSO_MAN"].value="";
		document.all["COD_RSO_LUO_FSC"].value="";
		document.all["RSO"].disabled=true;
	}
	//--------------------------------		
	function disableLuoFsc(obj){
		if (obj.selectedIndex!=0){
			document.all["COD_LUO_FSC"].disabled=true;
		}	
		else{	
			document.all["COD_LUO_FSC"].disabled=false;
		}	
		document.all["RSO"].options.length=0;
		document.all["RSO"].disabled=true;
		document.all["COD_RSO_MAN"].value="";
		document.all["COD_RSO_LUO_FSC"].value="";
	}		
	//---------------------------------
	function getRischiList(){
		COD_LUO_FSC = document.all["COD_LUO_FSC"].options[document.all["COD_LUO_FSC"].selectedIndex].value;
		COD_MAN =  document.all["COD_MAN"].options[document.all["COD_MAN"].selectedIndex].value;
	document.all["ifrmWork"].src="ANA_MIS_PET_AZL_RISCHI_View.jsp?type=r&LUO_FSC="+COD_LUO_FSC+"&ANA_MAN="+COD_MAN+"&COD_AZL=<%= lCOD_AZL %>&objID=RSO";
	}	
	//--------------------------------
	function showRischi(str){
		rso_obj=document.all["RSO"];
		rso_cont=document.all["RSO_CONT"];
		rso_obj.removeNode(true);
		rso_cont.insertAdjacentHTML("BeforeEnd",str);
		
		if (document.all["RSO"].options.length==1){
			document.all["RSO"].disabled=true;
			alert(arraylng["MSG_0045"]);
		}	
	}
	//--------------------------------
	function enableMisura(){
		COD_LUO_FSC = document.all["COD_LUO_FSC"].options[document.all["COD_LUO_FSC"].selectedIndex].value;
		COD_MAN =  document.all["COD_MAN"].options[document.all["COD_MAN"].selectedIndex].value;
		OptionSelected=document.all["RSO"].options[document.all["RSO"].selectedIndex];
		
		NOM_RSO = OptionSelected.text;
		if (COD_LUO_FSC!=0){
			document.all["COD_RSO_LUO_FSC"].value = OptionSelected.value;
		}	
		else if (COD_MAN!=0){
			document.all["COD_RSO_MAN"].value = OptionSelected.value;
		}
		tb_url_Search="Form_ANA_MIS_PET_AZL/ANA_MIS_PET_AZL_View.jsp?LUO_FSC="+COD_LUO_FSC+
						"|ANA_MAN="+COD_MAN+"|COD_AZL=<%= lCOD_AZL %>|objID=RSO|NOM_RSO="+NOM_RSO+
						"|STA=<%=strSTA_MIS_PET%>";	
	}
<% 
	if (request.getParameter("ID")!=null){
		out.println("enableMisura()");
	}
%>

</script>

</body>
</html>
