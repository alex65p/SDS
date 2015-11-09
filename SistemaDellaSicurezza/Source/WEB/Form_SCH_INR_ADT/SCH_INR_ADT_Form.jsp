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
            <version number="1.0" date="28/02/2004" author="Yuriy Kushkarov">
            <comments>
            <comment date="28/02/2004" author="Yuriy Kushkarov">
            <description>Create formi SCH_DBT_FRM_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.InterventoAudut.*" %>

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

<html>
<head>
    <script>
        document.write("<title>" + getCompleteMenuPath(SubMenuAnalisiControllo,3) + "</title>");
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
    <link rel="stylesheet" href="../_styles/tabs.css">
    <script language="JavaScript" src="../_scripts/tabs.js"></script>
    <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
    <script language="JavaScript" src="SCH_INR_ADT_Script.js"></script>
    
</head>
<script>
    window.dialogWidth = "900px";
    window.dialogHeight= "580px";
    </script>
<body>

<%
            long lCOD_AZL = Security.getAzienda();	//2 
            long lCOD_MAN = 0;
            long lCOD_MIS_PET = 0;
            long lCOD_LUO_FSC = 0;
            long lCOD_DPD = 0;

            IAzienda azienda;
            IAziendaHome AziendaHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");
            java.util.ArrayList azl_ids = Security.getAziende();
            String strRAG_SCL_AZL = "";
//Long azl_id=new Long(lCOD_AZL);
//long COD_AZL=new Long(lCOD_AZL).longValue();/
//	azienda = AziendaHome.findByPrimaryKey(azl_id);
//	String	strRAG_SCL_AZL= azienda.getRAG_SCL_AZL();
    if (request.getParameter("AZIENDA") != null) {
                lCOD_AZL = new Long(request.getParameter("AZIENDA")).longValue();
//out.print(lCOD_AZL);
            }
%>
<!-- form for addind  piano-->
<form action="SCH_INR_ADT_Tab.jsp"  method="GET" target="ifrmFile" id="FormParams" style="margin:0 0 0 0;">
<input id="TYPE" name="TYPE" type="hidden" value="INRup">
<input type="hidden" id="COD_ADT" value="">
<input type="hidden" id="kolTr" value="">
<input type="hidden" id="first" />
<table width="100%" border="0">
<tr>
<td valign="top">
    <table  width="100%" border="0">
        <tr><td class="title" >
                <script>
                    document.write(getCompleteMenuPath(SubMenuAnalisiControllo,3));
                </script>      
        </td></tr>
        <tr>
            <td >
            
            <!-- Inizo modifica effettuata da Francesco Di Martino 01-10-2004 -->
            <table width="100%">
                <tr>
                    <td>
                        <%@ include file="../_include/ToolBar.jsp" %>
                        <%
            ToolBar.bShowReturn = false;
            ToolBar.bShowDelete = false;
            ToolBar.bShowNew = true;
            ToolBar.bShowSave = false;
            ToolBar.bShowDetail = true;
            ToolBar.bCanDetail = true;
            ToolBar.bAlwaysShowPrint = true;
            ToolBar.bCanPrint = true;
            if (Security.isConsultant()){
                ToolBar.bCanPrint2=true;
                ToolBar.bShowPrint2=true;
            }
                        %>		
                        <%=ToolBar.build(3)%>
                        
                    </td>
                </tr>
            </table>
            <!-- Fine modifica effettuata da Francesco Di Martino 01-10-2004 --> 
                 
         
            
            <fieldset>
            <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.scheda.d'intervento")%></legend>
            <table  width="100%" border="0">
            <tr>
                <tr>
                    <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b>
                    </td>
                    <td align="left" colspan="3">
                            <!-- REPORT -->
                            <input type="checkbox" style="display:none" value="4" checked name="REP_TYPE">
                            <select style="width:660px" name="COD_AZL" onchange="frameRefresh.document.location.replace('SCH_INR_ADT_Form.jsp?AZIENDA='+document.all['COD_AZL'].value);">
                                <%=BuildAziendeComboBox(AziendaHome, lCOD_AZL)%>
                            </select>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <%=ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione/protezione")%>&nbsp;
                    </td>
                    <td>
                        <select name="COD_MIS_PET" id="COD_MIS_PET" style="width:95%" onchange="">
                            <option value="0"></option>
                            <%
                IMisuraPreventivaHome MisuraPreventivaHome = (IMisuraPreventivaHome) PseudoContext.lookup("MisuraPreventivaBean");
                String str = "";
                String strSEL = "";
                java.util.Collection col = MisuraPreventivaHome.getMisure_Preventive_ByAzienda_View(lCOD_AZL);
                java.util.Iterator it = col.iterator();
                while (it.hasNext()) {
                    Misure_Preventive_ByAzienda_View dt1 = (Misure_Preventive_ByAzienda_View) it.next();
                    strSEL = "";
                    if (lCOD_MIS_PET != 0) {
                        if (lCOD_MIS_PET == dt1.lCOD_MIS_PET) {
                            strSEL = "selected";
                        }
                    }
                    str = str + "<option " + strSEL + " value=\"" + dt1.lCOD_MIS_PET + "\">" + dt1.strNOM_MIS_PET + "</option>";
                }
                out.print(str);
                            %>
                        </select>
                    </td>
                    <td  nowrap align="right">
                        <%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%>&nbsp;
                    </td>
                    <td>
                        <select name="COD_LUO_FSC" id="COD_LUO_FSC" style="width:188px" onchange="">
                            <option value="0"></option>
                            <%
                IAnagrLuoghiFisiciHome AnagrLuoghiFisiciHome = (IAnagrLuoghiFisiciHome) PseudoContext.lookup("AnagrLuoghiFisiciBean");
                str = "";
                strSEL = "";
                col = AnagrLuoghiFisiciHome.getAnagrLuoghiFisici_List_View(lCOD_AZL);
                it = col.iterator();
                while (it.hasNext()) {
                    AnagrLuoghiFisici_List_View dt1 = (AnagrLuoghiFisici_List_View) it.next();
                    strSEL = "";
                    if (lCOD_LUO_FSC != 0) {
                        if (lCOD_LUO_FSC == dt1.COD_LUO_FSC) {
                            strSEL = "selected";
                        }
                    }
                    str = str + "<option " + strSEL + " value=\"" + dt1.COD_LUO_FSC + "\">" + dt1.NOM_LUO_FSC + "</option>";
                }
                out.print(str);
                            %>
                        </select>
                    </td>
            </tr>
            <tr>
                <td colspan="4">
                    <fieldset>
                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Intervento.di.audit")%></legend>
                        <table width="100%">
                            <tr>
                                <td align="right" nowrap width="22%">
                                    <%=ApplicationConfigurator.LanguageManager.getString("Descrizione.intervento")%>&nbsp;
                                </td>
                                <td>
                                    <input type="text" size="121" name="DES_INTER" id="DES_INTER">
                                </td>
                            </tr>
                        </table>	 
                    </fieldset>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <%=ApplicationConfigurator.LanguageManager.getString("Responsabile")%>&nbsp;
                </td>
                <td colspan="3">
                    <select style="width:630px" name="COD_DPD" id="COD_DPD">
                        <option value="0"></option>
                        <%
            IDipendenteHome DipendenteHome = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
            out.print(BuildDipendenteComboBox(DipendenteHome, lCOD_DPD, lCOD_AZL));
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <td nowrap align="right">
                    <%=ApplicationConfigurator.LanguageManager.getString("Intervento.aziendale")%>&nbsp;<input type="checkbox" class="checkbox" name="INR_ADT_AZL" id="INR_ADT_AZL" value="N" checked>
                </td>
                <td colspan="3">
                    <fieldset>
                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.misura.di.prevenzione/protezione.applicata.a")%></legend>
                        <table width="100%" border="0">
                            <tr>
                                <td>
                                    <%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%>&nbsp;
                                    <input type="radio" class="checkbox" value="L" name="R_APL_A" id="R_APL_A" onclick="changeMIS_PET_LUO(this.value);">
                                </td>
                                <td><%=ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa")%>&nbsp;
                                    
                                    <input type="radio" class="checkbox" name="R_APL_A" checked  id="R_APL_A" value="M" onclick="changeMIS_PET_LUO(this.value);">
                                </td>
                                <td align="right">
                                    <%=ApplicationConfigurator.LanguageManager.getString("Misura")%>&nbsp;
                                </td>
                                <td>
                                    <div id="MIS_PET_LUO">
                                        <select style="width:340px" name="COD_MIS_PET_LUO_MAN" id="COD_MIS_PET_LUO_MAN">
                                            <option value="0"></option>
                                            <%
            MisuraPreventivaHome = (IMisuraPreventivaHome) PseudoContext.lookup("MisuraPreventivaBean");
            str = "";
            strSEL = "";
            col = MisuraPreventivaHome.getMisure_Preventive_MAN_ByAzienda_View(lCOD_AZL);
            it = col.iterator();
            while (it.hasNext()) {
                Misure_Preventive_MAN_ByAzienda_View dt1 = (Misure_Preventive_MAN_ByAzienda_View) it.next();
                strSEL = "";
                if (lCOD_MIS_PET != 0) {
                    if (lCOD_MIS_PET == dt1.lCOD_MIS_PET) {
                        strSEL = "selected";
                    }
                }
                str = str + "<option " + strSEL + " value=\"" + dt1.lCOD_MIS_PET + "\">" + dt1.strNOM_MIS_PET + "</option>";
            }
            out.print(str);
                                            %>
                                    </select>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
            <tr>
                <td nowrap align="right">
                    <%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione.dal")%>&nbsp;
                </td>
                <td colspan="3">
                    <table width="100%" border="0">
                        <tr>
                            <td nowrap>
                                <s2s:Date id="DAT_PIF_DAL" name="DAT_PIF_DAL"/>
                            </td>
                            <td align="right">
                                <%=ApplicationConfigurator.LanguageManager.getString("al")%>&nbsp;
                            </td>
                            <td>
                                <s2s:Date name="DAT_PIF_AL" id="DAT_PIF_AL" />
                            </td>
                            <td nowrap align="right">
                                <%=ApplicationConfigurator.LanguageManager.getString("Data.effettuazione.dal")%>&nbsp;
                            </td>
                            <td>
                                <s2s:Date name="DAT_EFT_DAL" id="DAT_EFT_DAL" />
                            </td>
                            <td align="right">
                                <%=ApplicationConfigurator.LanguageManager.getString("al")%>&nbsp;
                            </td>
                            <td>
                                <s2s:Date name="DAT_EFT_AL" id="DAT_EFT_AL" />
                            </td>
                        </tr>
                    </table>
                </td>
        </tr>
        <tr>
            <td align="right">
                <%=ApplicationConfigurator.LanguageManager.getString("Raggruppati.per")%>&nbsp;
            </td>
            <td nowrap>
                <input type="radio" class="checkbox" name="R_T" id="R_T" value="A">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;
                <input type="radio" class="checkbox" name="R_T" id="R_T" value="L">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%>&nbsp;
                <input type="radio" class="checkbox" name="R_T" id="R_T" value="R">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Responsabile")%>&nbsp;
                <input type="radio" class="checkbox" checked   name="R_T" id="R_T" value="N">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nessuno")%>
            </td>
            <td colspan="2">
                <%=ApplicationConfigurator.LanguageManager.getString("Stato.intervento")%>&nbsp;
                <select name="STA_INT" style="width:160px">
                    <option value="0"></option>
                    <option value="D"><%=ApplicationConfigurator.LanguageManager.getString("Da.attuare")%></option>
                    <option value="G"><%=ApplicationConfigurator.LanguageManager.getString("Già.completato")%></option>
                </select>
            </td>
        </tr>
    </table>	 
</fieldset></td></tr>
</table>
</td>
</tr>
<tr>
    <td colspan="3" width="100%">

      <table border="0"><tr><td>

        <table width="880" border="0" align="left" id='ListTableHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>
            <tr>
                <td width="40">&nbsp;</td>
                <td width="140" id="pifTd" onclick="goTab('inr');"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.pianificaz.")%></strong>&nbsp;<img src="../_images/ORDINE_DOWN.gif" id="pifDw" style="display:none;"><img src="../_images/ORDINE_UP.GIF" id="pifUp" style="display:none;"></td>
                
                <td width="140" id="adtTd" onclick="goTab('adt');"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.interv.")%></strong>&nbsp;<img src="../_images/ORDINE_DOWN.gif" id="adtDw" style="display:none;"><img src="../_images/ORDINE_UP.GIF" id="adtUp" style="display:none;"></td>
                <td width="182"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Lavoratore")%></strong></td>
                <td width="180"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda")%></strong></td>
                <td width="180"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%></strong></td>
                <td width="18">&nbsp;</td>
            </tr>

        </table></td></tr>
        
            <tr>
                <td width="100%" colspan="5">
                    <div id="divFile" style="height:145px;overflow-y:auto"></div>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="5"><br>
                    <fieldset style="width:90%">
                        <table width='100%'>
                            <tr>
                                <td width="33%" align="center"><img src="../_images/PALLA-ROSSA.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Rossa")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.in.ritardo")%></td>
                                <td width="33%" align="center"><img src="../_images/PALLA-VERDE.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Verde")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.chiuse")%></td>
                                <td width="34%" align="center"><img src="../_images/PALLA-BLUE.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Blue")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.scadenza.odierna")%></td>
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
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
<iframe name="ifrmFile" id="ifrmFile" class="ifrmWork" src="../empty.txt" ></iframe>
<script>
    btn = ToolBar.Detail.getButton();
    btn.onclick = goINR_ADT;
    btn1 = ToolBar.Search.getButton();
    btn1.onclick = goTab;
    ToolBar.Detail.setEnabled(false);
    // --- REPORT ---
    // -- function for Repoprt 1------------------------------------------------------- 
    function OnPrint1(){
        frm= document.forms[0];
        w=window.open("../Reports/prepair.jsp", "REP");
        frm.target = "REP";
        frm.action = "../Reports/ScadenzarioInterventiAudit.jsp";
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
            ToolBar.submitReport("RPT_SCD_INR_ADT");
        }
    }  
    btn=ToolBar.Print2.getButton();	
    var OldPrint= btn.onclick;
    btn.onclick=OnPrint;
    //---------------------------------------------------------------------------------
    function restoreFrmProps(){
        frm.target = "ifrmWork";
        frm.action = "SCH_INR_ADT_Tab.jsp";
    }
    //----------------------------------
    </script>
</body>
</html> 
