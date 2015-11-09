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

<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="com.apconsulting.luna.ejb.LuogoFisicoRischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="./RSO_LUO_FSC_Util.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<html>
<head>
<title><%=ApplicationConfigurator.LanguageManager.getString("Associazione.luoghi.fisici.rischi")%></title>
  <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
	<link rel="stylesheet" href="../_styles/tabs.css">
	<script src="../_scripts/tabs.js"></script>
	<script src="../_scripts/tabbarButtonFunctions.js"></script>
    <script src="../_scripts/Alert.js"></script>
    
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
    short sMOD_CLC_RSO = Security.getAziendaModalitaCalcoloRischio();
    // sMOD_CLC_RSO = Azienda_MOD_CLC_RSO.MOD_BASE;
%>

<script>
window.dialogWidth="860px";
<% if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {%>
    window.dialogHeight="630px";
<%} else {%>
    window.dialogHeight="600px";
<%}%>
</script>

<%
 boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
            
        long lCOD_RSO_LUO_FSC = 0;
	long lCOD_LUO_FSC = 0;
	String strLuogoFisico = "";
	long lCOD_RSO = 0;
  	long lCOD_AZL = Security.getAzienda();
  	String strAziendaEntre = "";			 // by COD_AZL (RAG_SCL_AZL field)
	String strPRS_RSO = "";
	String dtDAT_INZ = "";
	String dtDAT_FIE = "";
	String strNOM_RIL_RSO = "";
	String strCLF_RSO = "";
	long lPRB_EVE_LES = 0;
	long lENT_DAN = 0;
	long lFRQ_RIP_ATT_DAN = 0;
        long lNUM_INC_INF = 0;
	float lSTM_NUM_RSO = 0;
	String dtDAT_RFC_VLU_RSO = "";
	String strSTA_RSO = "";

	long lCOD_FAT_RSO = 0;
	ILuogoFisicoRischio rischi = null;
	IAzienda azienda;
	IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");
	IAnagrLuoghiFisici luoghi = null;
	IAnagrLuoghiFisiciHome  LuoghiFisiciHome=(IAnagrLuoghiFisiciHome)PseudoContext.lookup("AnagrLuoghiFisiciBean");
	IRischio rischio=null;
	IRischioHome RischioHome=(IRischioHome)PseudoContext.lookup("RischioBean");

if(request.getParameter("ID_PARENT")!=null)
{
		String strCOD_LUO_FSC = request.getParameter("ID_PARENT");
		lCOD_LUO_FSC = new Long(strCOD_LUO_FSC).longValue();
		try{
				luoghi = LuoghiFisiciHome.findByPrimaryKey(new Long(strCOD_LUO_FSC));
		}catch(Exception ex){
			out.print("<script>Alert.Error.showNotFound(); window.self.close();</script>");
			return;
		}
		strLuogoFisico=luoghi.getNOM_LUO_FSC();
}
		// Get Aziende/Ente
		azienda = AziendaHome.findByPrimaryKey(new Long(lCOD_AZL));
		strAziendaEntre = azienda.getRAG_SCL_AZL();

if(request.getParameter("ID")!=null)
{
		String strCOD_RSO_LUO_FSC = request.getParameter("ID");
		ILuogoFisicoRischioHome LuogoFisicoRischio=(ILuogoFisicoRischioHome)PseudoContext.lookup("LuogoFisicoRischioBean");

		try{
				rischi = LuogoFisicoRischio.findByPrimaryKey(new Long(strCOD_RSO_LUO_FSC));
		}catch(Exception ex){
			out.print("<script>Alert.Error.showNotFound(); window.self.close();</script>");
			return;
		}

		lCOD_RSO_LUO_FSC = rischi.getCOD_RSO_LUO_FSC();
		lCOD_LUO_FSC = rischi.getCOD_LUO_FSC();
		lCOD_RSO = rischi.getCOD_RSO();
		rischio = RischioHome.findByPrimaryKey(new RischioPK(lCOD_AZL, lCOD_RSO));//new Long(lCOD_RSO));
		lCOD_FAT_RSO=rischio.getCOD_FAT_RSO();
		lCOD_AZL=rischi.getCOD_AZL();
		// Get Aziende/Ente
		azienda = AziendaHome.findByPrimaryKey(new Long(lCOD_AZL));
		strAziendaEntre = azienda.getRAG_SCL_AZL();
		strPRS_RSO=rischi.getPRS_RSO();
		dtDAT_INZ=Formatter.format(rischi.getDAT_INZ());
		dtDAT_FIE=Formatter.format(rischi.getDAT_FIE());
		strNOM_RIL_RSO=rischi.getNOM_RIL_RSO();
		strCLF_RSO=rischi.getCLF_RSO();
		lPRB_EVE_LES=rischi.getPRB_EVE_LES();
		lENT_DAN=rischi.getENT_DAN();
                lFRQ_RIP_ATT_DAN=rischi.getFRQ_RIP_ATT_DAN();
                lNUM_INC_INF=rischi.getNUM_INC_INF();
		lSTM_NUM_RSO=rischi.getSTM_NUM_RSO();
		dtDAT_RFC_VLU_RSO=Formatter.format(rischi.getDAT_RFC_VLU_RSO());
		strSTA_RSO=rischi.getSTA_RSO();
}
%>

<script>
<!--
function clearField(){
    document.all["COD_RSO"].value = "";
    document.all["NOM_RSO"].value = "";
    document.all["NOM_RIL_RSO"].value = "";
    document.all["CLF_RSO"].value = "PER TUTTI";
    document.all["DAT_RFC_VLU_RSO"].value = "";
    document.all["ENT_DAN"].value = "";
    document.all["PRB_EVE_LES"].value = "";
    document.all["STM_NUM_RSO"].value = "";
    <% if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {%>
        document.all["FRQ_RIP_ATT_DAN"].value = "";
        document.all["NUM_INC_INF"].value = "";
    <%}%>
}

function populate(obj) {
	if (document.all["COD_FAT_RSO"]) { document.all["COD_FAT_RSO"].value = obj.options(obj.selectedIndex).value1; }
	if (obj.selectedIndex != 0 ) {
            document.all["COD_RSO"].value = obj.options(obj.selectedIndex).value;
            document.all["NOM_RSO"].value = obj.options(obj.selectedIndex).text;
            document.all["NOM_RIL_RSO"].value = obj.options(obj.selectedIndex).value2;
            document.all["CLF_RSO"].value = obj.options(obj.selectedIndex).value3;
            document.all["DAT_RFC_VLU_RSO"].value = obj.options(obj.selectedIndex).value4;
            document.all["ENT_DAN"].value = obj.options(obj.selectedIndex).value5;
            document.all["PRB_EVE_LES"].value = obj.options(obj.selectedIndex).value6;
            document.all["STM_NUM_RSO"].value = obj.options(obj.selectedIndex).value7;
            <% if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {%>
                document.all["FRQ_RIP_ATT_DAN"].value = obj.options(obj.selectedIndex).value8;
                document.all["NUM_INC_INF"].value = obj.options(obj.selectedIndex).value9;
            <%}%>
	} else {
            clearField();
        }
}
function populateFactor(obj) {
        clearField();
        if (document.all["COD_RSO_SEL"] && obj.selectedIndex > 0) {
             objRso = document.all["COD_RSO_SEL"];
             document.all["NOM_RSO"].value = "";
             objRso.style.display = 'none';
             document.all["NOM_RSO"].style.display = '';
             document.all["btngetRSO"].style.display = '';
	}
}
function getRSO(){
	var ifrmWork = document.all["ifrmWork"];
	var lcod_azl = document.all["COD_AZL"].value;
	var lcod_fat_rso = document.all["COD_FAT_RSO"].value;
	var obj=new Object();
	var url="Form_RSO_LUO_FSC/RSO_LUO_FSC_Lovs.jsp?LOCAL_MODE=LOV_RSO|COD_FAT_RSO=" + lcod_fat_rso + "|COD_AZL=" + lcod_azl;
	if(showSearch(url, obj)=="OK"){
		ifrmWork.src="RSO_LUO_FSC_LovSet.jsp?ID="+obj.ID+"&LOCAL_MODE=LOV_RSO";
	}
}
//-->
</script>

<!-- form for addind  LuogoFisicoRischio-->
<form action="RSO_LUO_FSC_Set.jsp" name="frmWork"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
    <input name="SBM_MODE" type="Hidden" value="<%=(lCOD_RSO_LUO_FSC==0)?"new":"edt"%>">
    <input type="hidden" name="COD_RSO_LUO_FSC" value="<%=lCOD_RSO_LUO_FSC%>">
    <input type="hidden" name="COD_LUO_FSC" value="<%=lCOD_LUO_FSC%>">
    <table  width="100%" border="0">
        <tr>
            <td class="title"  colspan="2"><%=ApplicationConfigurator.LanguageManager.getString("Associazione.luoghi.fisici.rischi")%></td>
        </tr>
        <tr>
            <td  colspan="2">
                <!-- ############################ -->
                <table border=0>
                <%@ include file="../_include/ToolBar.jsp" %>
                <%
                        ToolBar.bCanDelete=(rischi!=null);
                        ToolBar.bShowSearch=false;
                        ToolBar.bShowPrint=false;
                        ToolBar.bShowDelete=false;
                        ToolBar.bShowReturn=false;
                %>
                <%=ToolBar.build(2)%>
                </table>
                <!-- ########################### -->
                <fieldset>
                    <table  width="100%" border="0">
                        <tr>
                            <td align="right" style="width:15%;"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
                            <td colspan="3">
                                <input style="width:100%;" value="<%=strAziendaEntre%>" readonly>
                                <input type="hidden" id="COD_AZL" name="COD_AZL" value="<%=lCOD_AZL%>" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right"> <b><%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%>&nbsp;</b></td>
                            <td colspan="3">
                                <input style="width:100%;" name="RUOLO" value="<%=strLuogoFisico%>" readonly>
                                <input type="hidden" id="COD_LUO_FSC" name="COD_LUO_FSC" value="<%=lCOD_LUO_FSC%>" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <fieldset>
                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Rischio")%></legend>
                                        <table  width="100%" border="0">
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome.rischio")%>&nbsp;</b></td>
                                                <td>
                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                        <tr>
                                                            <td>
                                                                <select tabindex="2" name="COD_RSO_SEL" style="width:700px;" onchange="populate(this);">
                                                                    <option value=""></option>
                                                                    <%=BuildRischioComboBox(RischioHome, lCOD_RSO, lCOD_AZL)%>
                                                                </select>
                                                                <input name="NOM_RSO" value="" style="width:680px; display: none;" readonly />
                                                            </td>
                                                            <td>
                                                                <button class="getlist" onclick="getRSO()" id="btngetRSO" style="display: none;">
                                                                <strong>&middot;&middot;&middot;</strong>
                                                                </button>
                                                                <input type="hidden" name="COD_RSO" value="<%=lCOD_RSO%>" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width:15%;"><b><%=ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio")%>&nbsp;</b></td>
                                                <td>
                                                    <select tabindex="1" name="COD_FAT_RSO" style="width:700px;" onchange="populateFactor(this);">
                                                        <option value=""></option>
                                                        <%=BuildFattoreRischioComboBox(RischioHome, lCOD_FAT_RSO, lCOD_AZL)%>
                                                    </select>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                            <%if (!ifMsr) {%>
                            <tr>   
                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nominativo.rilevatore")%>&nbsp;</b></td>
                                <td colspan="3">

                                    <input tabindex="3" style="width:100%;" maxlength="100" name="NOM_RIL_RSO" value="<%=strNOM_RIL_RSO%>">
                                </td>
                            </tr>
                            <%}%>
                            <tr>
                                <td     <%=ifMsr? "colspan=\"3\"":""%> align="right">
                                    <b><%=ApplicationConfigurator.LanguageManager.getString("Classificazione.rischio")%>&nbsp;</b>
                                </td>
                                <td>
                                    <input tabindex="4" size="25" maxlength="30" type="text" name="CLF_RSO" value="<%=strCLF_RSO.equals("")?"PER TUTTI":strCLF_RSO%>">
                                </td>
                                <%if (!ifMsr) {%>
                                <td align="right">
                                    <b><%=ApplicationConfigurator.LanguageManager.getString("Pianificazione.rivalutazione.del.rischio")%>&nbsp;</b>
                                </td>
                                <td>
                                    <s2s:Date tabindex="5" id="DAT_RFC_VLU_RSO" name="DAT_RFC_VLU_RSO" value="<%=dtDAT_RFC_VLU_RSO%>"/>
                                </td>
                                <%}%>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <fieldset class="stimaRischio">
                                        <legend class="stimaRischio"><%=ApplicationConfigurator.LanguageManager.getString("Stima.numerica.del.rischio")%></legend>
                                            <table border="0" width="100%" cellspacing="5">
                                                <tr>
                                                    <td align="right" style="width:15%;"><b><%=ApplicationConfigurator.LanguageManager.getString("Probabilità.dell'evento.lesivo")%></b>&nbsp;</td>
                                                    <td>
                                                        <input  tabindex="6" size="10" type="text"  maxlength="2" name="PRB_EVE_LES" id="PRB_EVE_LES"
                                                                value="<%=(rischi==null)?"":Formatter.format(lPRB_EVE_LES)%>" 
                                                                onchange="<%=sMOD_CLC_RSO==Azienda_MOD_CLC_RSO.MOD_EXTENDED?"RecalculateExtended()":"Recalculate()"%>">
                                                    </td>
                                                    <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Entità.del.danno")%></b>&nbsp;</td>
                                                    <td>
                                                        <input  tabindex="7" size="10" maxlength="2" type="text" name="ENT_DAN" id="ENT_DAN"
                                                                value="<%=(rischi==null)?"":Formatter.format(lENT_DAN)%>"
                                                                onchange="<%=sMOD_CLC_RSO==Azienda_MOD_CLC_RSO.MOD_EXTENDED?"RecalculateExtended()":"Recalculate()"%>">
                                                    </td>
                                            <!------------------------------------------------------------------>
                                                    <% if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED){ %>
                                                        <td align="right" style="width:15%;"><b><%=ApplicationConfigurator.LanguageManager.getString("Frequenza.dell'attività.a.rischio")%></b>&nbsp;</td>
                                                        <td>
                                                            <input tabindex="8" type="text" size="10"  maxlength="2"  name="FRQ_RIP_ATT_DAN" value="<%=(rischi==null)?"":Formatter.format(lFRQ_RIP_ATT_DAN)%>" onchange="RecalculateExtended()">
                                                        </td>
                                                        <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Numero.di.incidenti/infortuni.(negli.ultimi.3.anni)")%></b></td>
                                                        <td>
                                                            <input tabindex="9" type="text" size="10"  maxlength="2"  name="NUM_INC_INF" value="<%=(rischi==null)?"":Formatter.format(lNUM_INC_INF)%>" onchange="RecalculateExtended()">
                                                        </td>
                                                    <% } %>
                                            <!------------------------------------------------------------------>
                                                    <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Stima.numerica.del.rischio")%></b></td>
                                                    <td>
                                                        <input class="stimaRischio" tabindex="10" readonly size="10" type="text" name="STM_NUM_RSO" id="STM_NUM_RSO" maxlength="8" value="<%=(rischi==null)?"":Formatter.format(lSTM_NUM_RSO)%>">&nbsp;&nbsp;
                                                    </td>
                                                </tr>
                                            <!------------------------------------------------------------------>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                <script>
                function RecalculateExtended(){
                        var FattoreMoltiplicativo = 1 + (document.forms[0].NUM_INC_INF.value - 1) * 0.5;
                        var StimaRischio =  document.forms[0].ENT_DAN.value * 
                                            document.forms[0].FRQ_RIP_ATT_DAN.value * 
                                            document.forms[0].PRB_EVE_LES.value * 
                                            FattoreMoltiplicativo;
                        SetStimaRischio(StimaRischio);
                }

                function Recalculate(){
                        var StimaRischio=(document.forms[0].ENT_DAN.value)*(document.forms[0].PRB_EVE_LES.value);
                        SetStimaRischio(StimaRischio);
                }

                function SetStimaRischio(sr){
                        if(sr==null || sr=="NaN") x=0;
                        document.forms[0].STM_NUM_RSO.value=sr;
                }

                </script>
                                <tr>
                                    <td colspan="4">
                                        <div id="dContainer" class="mainTabContainer" style="width:100%"></div>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
            </table> 
        </form>
<!-- /form for addind  LuogoFisicoRischio  width: 801px; height: 401px;"-->
   <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>

 
<%
//-------Loading of Tabs--------------------
if(rischi!=null)
{
// -----------------------------------------
%>

<script src="../_scripts/index.js"></script>
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
	btnParams[3] = {"id":"btnAssociate",
					"onclick":addRow,
					"action":"Associate"
					};
    //--------creating tabs--------------------------
	var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
	var btnBar = new ButtonPanel("batPanel1", btnParams);
	tabbar.addButtonBar(btnBar);
	tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Misure.preventive")%>", tabbar));
	tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti")%>", tabbar));
	tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Normative/Sentenze")%>", tabbar));
	//------adding tables to tabs-----------------------
	tabbar.idParentRecord = <%= lCOD_RSO_LUO_FSC %>;
	tabbar.refreshTabUrl="RSO_LUO_FSC_Tabs.jsp?COD_LUO_FSC=<%=lCOD_LUO_FSC%>";
	tabbar.RefreshAllTabs();
	//tabbar.DEBUG_TABS_IFRM = true;
	//----add action parameters to tabs

//--------------------------------------------------------------------------------------------
	tabbar.tabs[0].tabObj.actionParams ={
										"Feachures":{
													"dialogWidth":"900px",
													"dialogHeight":"700px"
													},
										"AddNew":	{"url":"../Form_MIS_PET_LUO_FSC/MIS_PET_LUO_FSC_Form.jsp?COD_LUO_FSC=<%=lCOD_LUO_FSC%>",
													"buttonIndex":0,
													"disabled": false
												  	},
										 "Edit":	{"url":"../Form_MIS_PET_LUO_FSC/MIS_PET_LUO_FSC_Form.jsp?COD_LUO_FSC=<%=lCOD_LUO_FSC%>",
													"buttonIndex":1,
													"disabled": false
										 			},
										 "Delete":	{"url":"../Form_RSO_LUO_FSC/RSO_LUO_FSC_Delete.jsp?LOCAL_MODE=mis",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": false
										 			},
										"Associate":
{"url":"../Form_GEST_MIS_PET/GEST_MIS_PET_Form.jsp?ATTACH_URL=Form_RSO_MAN/RSO_MAN_Attach.jsp&ATTACH_SUBJECT=LUOGO",
													"whidth":"710px",
													"height":"400px",
													"buttonIndex":3,
													"disabled": false
										 			}
										};
//--------------------------------------------------------------------------------------------
	tabbar.tabs[1].tabObj.actionParams ={
										"Feachures":ANA_DOC_Feachures,
										"AddNew":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_LUO_FSC/ANA_LUO_FSC_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
													"buttonIndex":0,
													"disabled": true
												  	},
										 "Edit":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_LUO_FSC/ANA_LUO_FSC_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
													"buttonIndex":1,
													"alert": null,
													"disabled": true
										 			},
									    "Delete":	{"url":"../Form_ANA_LUO_FSC/ANA_LUO_FSC_Delete.jsp?LOCAL_MODE=doc",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": true
										 			},
										"Associate":
													{"url":"",
													"buttonIndex":3,
													"disabled": true
										 			}
										};
//--------------------------------------------------------------------------------------------
	tabbar.tabs[2].tabObj.actionParams ={
		"Feachures":{
					"dialogWidth":"800px",
					"dialogHeight":"515px"
					},
		"AddNew":	{"url":"../Form_MAC_OPE_SVO/MAC_OPE_SVO_Form.jsp?ATTACH_URL=Form_ANA_LUO_FSC/ANA_LUO_FSC_Attach.jsp&ATTACH_SUBJECT=MACCHINE",
					"buttonIndex":0,
					"disabled": false
				  	},
		 "Edit":	{"url":"../Form_MAC_OPE_SVO/MAC_OPE_SVO_Form.jsp?ATTACH_URL=Form_ANA_LUO_FSC/ANA_LUO_FSC_Attach.jsp&ATTACH_SUBJECT=MACCHINE",
					"buttonIndex":1,
					"disabled": false
		 			},
		 "Delete":	{"url":"../Form_MAC_OPE_SVO/MAC_OPE_SVO_Delete.jsp?LOCAL_MODE=mac",
					"target_element":document.all["ifrmWork"],
					"buttonIndex":2,
					"disabled": false
		 			},
		"Associate":
					{"url":"",
					"buttonIndex":3,
					"disabled": true
		 			}
		};
//--------------------------------------------------------------------------------------------
	tabbar.tabs[0].tabObj.OnActivate = function ()
		{
			tabbar.buttonBar.panel.style.display = '';
		};
	tabbar.tabs[1].tabObj.OnActivate = function ()
		{
			tabbar.buttonBar.panel.style.display = 'none';
		};
	tabbar.tabs[2].tabObj.OnActivate = function ()
		{
			tabbar.buttonBar.panel.style.display = 'none';
		};
</script>
<%}else{%>
    <script>
    <% if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {%>
        window.dialogHeight="405px";
    <%} else {%>
        window.dialogHeight="375px";
    <%}%>
    </script>
<%}%>
<script>
/*
function chBoxClick(id){
	document.all("dt"+id).value = ShowDateTime();
}
function ShowDateTime()
{
   	var today = new Date();
   	var dStr = "";
		var strDate = today.getDate();
		var strMonth = today.getMonth()+1;
		if (strDate < 10) strDate = "0" + strDate;
		if (strMonth < 10) strMonth = "0" + strMonth;
		dStr = strDate+"/";
			dStr+= strMonth+"/";
		dStr+= today.getYear();
   	return (dStr);
}
*/
//--------------------------------------------------
function setDAT_FIE(check_box){
	str_id=check_box.id.substr(16);
	//----------------------------------
	date_obj= new Date();
	d=new String( date_obj.getDate() );
	if(d.length==1) d="0"+d;
	m=new String( date_obj.getMonth() );
	if(m.length==1) m="0"+m;
	y=date_obj.getYear();
	//----------------------------------
	str_date=d+"/"+m+"/"+y;
	if(check_box.checked){
		str_date="";
		document.all["CHK_PRS_MIS_HID_"+str_id].checked=false;
	}else{
		document.all["CHK_PRS_MIS_HID_"+str_id].checked=true;
	}
	document.all["DAT_FIE_"+str_id].value=str_date;
}
//--------------------------------------------------
function CalcStima(){
	PRB_EVE_LES=document.all["PRB_EVE_LES"].value;
	ENT_DAN	   =document.all["ENT_DAN"].value;	
	//--------------------------------------------
	if(PRB_EVE_LES=="") {
		document.all["STM_NUM_RSO"].value="";
		return;
	}		
	if(ENT_DAN=="") {
		document.all["STM_NUM_RSO"].value="";	
		return;
	}		
	if( parseFloat(PRB_EVE_LES)==NaN ){
		alert(arraylng["MSG_0074"]);
		document.all["PRB_EVE_LES"].focus();
		return;
	}
	if( parseFloat(ENT_DAN)==NaN ){
		alert(arraylng["MSG_0075"]);
		document.all["ENT_DAN"].focus();
		return;
	}
	res=parseFloat(PRB_EVE_LES)*parseFloat(ENT_DAN);
	document.all["STM_NUM_RSO"].value=res;
}
</script>
</body>
</html>
