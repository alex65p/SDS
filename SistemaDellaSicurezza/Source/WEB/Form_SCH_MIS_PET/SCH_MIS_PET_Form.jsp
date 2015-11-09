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
            <version number="1.0" date="29/02/2004" author="Alexey Kolesnik">
            <comments>
            <comment date="29/02/2004" author="Alexey Kolesnik">
            <description>Shablon formi SCH_MIS_PET_Form.jsp</description>
            </comment>
            <comment date="12/03/2004" author="Roman Chumachenko">
            <description>Report</description>
            </comment>
            </comments> 
            </version>
            </versions>
            </file> 
             */
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.MisuraPreventiva.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="SCH_MIS_PET_Util.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../_include/ComboBox-Azienda.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script language="JavaScript" src="SCH_MIS_PET_Script.js"></script>
<%
            Checker c = new Checker();

            long lCOD_AZL = 0;
//	long lCOD_AZL=Security.getAzienda();
            String strNB_APL_A = request.getParameter("NB_APL_A");
            if (strNB_APL_A == null || strNB_APL_A.equals("")) {
                strNB_APL_A = "M";
            }
            String strNB_GROUP = request.getParameter("NB_GROUP");
            if (strNB_GROUP == null || strNB_GROUP.equals("")) {
                strNB_GROUP = "N";
            }
            long lNB_NOM_MIS_PET = c.checkLong("Misura di Prevenzione", request.getParameter("NB_NOM_MIS_PET"), false);
            String strSORT_DAT_PAR_ADT = "X";

            IAzienda azienda = null;
            IAziendaHome AziendaHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");

//	azienda = AziendaHome.findByPrimaryKey(new Long(lCOD_AZL));
//	String	strRAG_SCL_AZL = azienda.getRAG_SCL_AZL();

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
        document.write("<title>" + getCompleteMenuPath(SubMenuAnalisiControllo,1) + "</title>");
    </script>
    <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
    <link rel="stylesheet" href="../_styles/tabs.css">
</head>
<script>
    window.dialogWidth = "840px";
    window.dialogHeight= "610px";
    </script>

<body>
<form name="frmWork" action="SCH_MIS_PET_Tabs.jsp"  method="GET" target="ifrmWork" style="margin:0 0 0 0;">
<input id="SORT_DAT_PAR_ADT" name="SORT_DAT_PAR_ADT" type="hidden" value="<%=strSORT_DAT_PAR_ADT %>">
<input id="SEARCH" name="SEARCH" type="hidden" value="search">

<table border="0">
<tr><td class="title" colspan="">
        <script>
            document.write(getCompleteMenuPath(SubMenuAnalisiControllo,1));
        </script>      
</td></tr>
<tr valign="top">
    <td>
        <!-- Inizo modifica effettuata da Francesco Di Martino 01-10-2004 -->
        <table>
            <tr>
                <td>
                    <%@ include file="../_include/ToolBar.jsp" %>      
                    <%
            ToolBar.bShowDetail = true;
            ToolBar.bShowSave = false;
            ToolBar.bShowDelete = false;
            ToolBar.bAlwaysShowPrint = true;
            ToolBar.bCanPrint = true;
            if (Security.isConsultant()) {
                ToolBar.bCanPrint2 = true;
                ToolBar.bShowPrint2 = true;
            }
                    %>		
                    <%=ToolBar.build(5)%> 			
                </td>
            </tr>
        </table>
        <!-- Fine modifica effettuata da Francesco Di Martino 01-10-2004 --> 
        <fieldset>
            <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.visita.medica/d'idoneità")%></legend>
            <table border="0" width="100%">
                <tr>
                    <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
                    <td colspan="5" align="left">
                        <!-- REPORT -->
                        <input type="checkbox" style="display:none" value="2" checked name="REP_TYPE">
                        <select style="width:500px" name="COD_AZL">
                            <%=BuildAziendeComboBox(AziendaHome, lCOD_AZL)%>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <fieldset>
                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.misura.di.prevenzione/protezione")%></legend>
                        <table width="100%" border="0">
                            <tr>
                                <td width="20%" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Misura.di.prev./prot.")%>&nbsp;</td>
                                <td width="60%">
                                    <input type="text" name="NOM_MIS_PET" value="" style="width:475px;">
                                </td>
                                <td align="left">
                                    <div align="left"><button class="getlist" onclick="getLOV_MIS_PET()" id="btngetLOV_MIS_PET">
                                            <strong>&middot;&middot;&middot;</strong>
                                    </button></div>
                                    <input type="hidden" name="COD_MIS_PET" value="" />
                                    <input type="hidden" name="COD_TPL_MIS_PET" value="" />
                                </td>
                            </tr>
                            <tr>
                                <td nowrap align="right"><%=ApplicationConfigurator.LanguageManager.getString("Adottata/Da.adottare")%>&nbsp;</td>
                                <td colspan="2">
                                    <select name="NB_DES_TPL_MIS_PET" style="width:490px;">
                                        <option></option>
                                        <option value="DA PARTE DELL'OPERATORE"><%=ApplicationConfigurator.LanguageManager.getString("DA.PARTE.DELL'OPERATORE")%></option>
                                        <option value="DA PARTE DELL'OPERATORE"><%=ApplicationConfigurator.LanguageManager.getString("DA.PARTE.DELL'OPERATORE")%></option>
                                        <option value="DA PARTE DELL'AZIENDA"><%=ApplicationConfigurator.LanguageManager.getString("DA.PARTE.DELL'AZIENDA")%></option>

                                    </select>
                                </td>
                            </tr>
                        </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                <td colspan="6">
                    <fieldset>
                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.misura.di.prevenzione/protezione.applicata.a")%></legend>
                    <table summary="" width="100%" border="0">
                        <tr>
                            <td align="right" width="29%"><%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%>&nbsp;</td>
                            <td colspan="2">
                                <input type="radio" class="checkbox" name="NB_APL_A" value="L" <%=("L".equals(strNB_APL_A)) ? "checked" : ""%> onclick="onMIS_PET_MAN_LUO_FSC();">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <%=ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa")%>&nbsp;
                                <input type="radio" class="checkbox" name="NB_APL_A" value="M" <%=("M".equals(strNB_APL_A)) ? "checked" : ""%> onclick="onMIS_PET_MAN_LUO_FSC();">
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Misura")%>&nbsp;</td>
                            <td width="42%">
                                <input type="text" name="NOM_MIS_PET_LUO_MAN" value="" style="width:470px;" />
                            </td>
                            <td align="left">
                                <button class="getlist" onclick="getMIS_PET_LUO_MAN()" id="btngetMIS_PET_LUO_MAN">
                                    <strong>&middot;&middot;&middot;</strong>
                                </button>
                                <input type="hidden" name="COD_MIS_PET_LUO_MAN" value="" />
                            </td>
                        </tr>
                    </table>
                    </fieldset>
                </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <fieldset>
                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.rischio")%></legend>
                            <table border="0">
                                <tr>
                                    <td align="right" width="24%"><%=ApplicationConfigurator.LanguageManager.getString("Rischio")%>&nbsp;</td>
                                    <td>
                                        <input type="text" name="NOM_RSO" value="" style="width:470px;" /> <td align="left">
                                        <button class="getlist" onclick="getLOV_RSO()" id="btngetLOV_RSO">
                                            <strong>&middot;&middot;&middot;</strong>
                                        </button>
                                        <input type="hidden" name="COD_RSO" value="" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td align="right" nowrap width="20%"><%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione.dal")%>&nbsp;</td>
                    <td>
                        <s2s:Date name="NB_DAT_PNZ_MIS_PET_DAL" id="NB_DAT_PNZ_MIS_PET_DAL" value=""/>
                    </td>        
                    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("al")%>&nbsp;</td>
                    <td>
                        <s2s:Date id="NB_DAT_PNZ_MIS_PET_AL" name="NB_DAT_PNZ_MIS_PET_AL" value=""/>
                    </td>        
                    <td><%=ApplicationConfigurator.LanguageManager.getString("Raggruppati.per")%>&nbsp;</td>
                    <td>
                        <input type="radio" class="checkbox" name="NB_GROUP" value="T" <%=("T".equals(strNB_GROUP)) ? "checked" : ""%>>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%>&nbsp;
                        <input type="radio" class="checkbox" name="NB_GROUP" value="A" <%=("A".equals(strNB_GROUP)) ? "checked" : ""%>>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda")%>&nbsp;
                        <input type="radio" class="checkbox" name="NB_GROUP" value="N" <%=("N".equals(strNB_GROUP)) ? "checked" : ""%>>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nessuno")%>
                    </td>    
                </tr>
</table>
</fieldset>
</td>
</tr>
<tr>
    <td colspan="2">
        
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="16" valign="top">
                        <table border='0' align="left" width="814" id='ListTableHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>
                            <tr>
                                <td width="40">&nbsp;</td>
                                <td width="140" style='cursor:hand;'  onclick="sort_SCH_MIS_PET('dp');" nowrap>
                                    <strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.pianificaz.")%></strong>
                                        <img id='imgDP' src='../_images/ORDINE_DOWN.gif' alt='down' style='display:none'>
                                </td>
                                <!-- <td align='center' width='190' style="display:none;"><strong>Nome Luogo Fisico</strong></td> //-->
                                <td width="180" id="tabNome"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome.mansione")%></strong></td>
                                <td width="246"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione/protezione")%></strong></td>
                                <td width="190"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda")%></strong></td>
                                <td width="18">&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="div_s" style='height: 150px; overflow: auto'></div>
                    </td>
                </tr>
            </table>
        
    </td>
</tr>
<tr>
    <td align="center"><br>
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
</form>
<br />

<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>

<script type="text/javascript">
    <!--
    var ifrmWork = document.all["ifrmWork"];
    
    function getLOV_MIS_PET(){
        var obj=new Object();
        var url="Form_SCH_MIS_PET/SCH_MIS_PET_Lovs.jsp?LOCAL_MODE=LOV_MIS_PET";
        if(showSearch(url, obj)=="OK"){
            ifrmWork.src="SCH_MIS_PET_LovSet.jsp?ID="+obj.ID+"&LOCAL_MODE=LOV_MIS_PET";		
        }
    }
    
    function getMIS_PET_LUO_MAN(){
        var objRadio = document.all["NB_APL_A"];
        var lcod_azl = document.all["COD_AZL"].value;
        var strRadio = "M";
        if (objRadio[0].checked)
            {
                strRadio = "L";
            }
            var obj=new Object();
            
            var url="Form_SCH_MIS_PET/SCH_MIS_PET_Lovs.jsp?LOCAL_MODE=LOV_MIS_PET_LUO_MAN|TYPE=" + strRadio + "|COD_AZL=" + lcod_azl;
            if(showSearch(url, obj)=="OK"){
                ifrmWork.src="SCH_MIS_PET_LovSet.jsp?ID="+obj.ID+"&LOCAL_MODE=LOV_MIS_PET_LUO_MAN&TYPE=" + strRadio;		
            }
            
        }
        
        function getLOV_RSO(){
            var objRadio = document.all["NB_APL_A"];
            var lcod_azl = document.all["COD_AZL"].value;
            var strRadio = "M";
            if (objRadio[0].checked)
                {
                    strRadio = "L";
                }
                var obj=new Object();
                
                var url="Form_SCH_MIS_PET/SCH_MIS_PET_Lovs.jsp?LOCAL_MODE=LOV_RSO|TYPE=" + strRadio + "|COD_AZL=" + lcod_azl;
                if(showSearch(url, obj)=="OK"){
                    ifrmWork.src="SCH_MIS_PET_LovSet.jsp?ID="+obj.ID+"&LOCAL_MODE=LOV_RSO";		
                }
                
            }
            //-->
            </script>
<script>
    btn = ToolBar.Search.getButton();
    btn.onclick = goTab;
    ToolBar.Detail.OnClick = showDetailSCH_MIS_PET;
    ToolBar.Detail.setEnabled(false);
    // --- REPORT ---
    // -- function for Repoprt 1------------------------------------------------------- 
    function OnPrint1(){
        frm= document.forms[0];
        w=window.open("../Reports/prepair.jsp", "REP");
        frm.target = "REP";
        frm.action = "../Reports/ScadenzarioMisurePreventive.jsp";
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
            ToolBar.submitReport("RPT_SCD_MIS_PET");
        }
    }  
    btn=ToolBar.Print2.getButton();	
    var OldPrint= btn.onclick;
    btn.onclick=OnPrint;
    //---------------------------------------------------------------------------------
    function restoreFrmProps(){
        frm.target = "ifrmWork";
        frm.action = "SCH_MIS_PET_Tabs.jsp";
    }
    //----------------------------------
    </script>
</body>
</html>
