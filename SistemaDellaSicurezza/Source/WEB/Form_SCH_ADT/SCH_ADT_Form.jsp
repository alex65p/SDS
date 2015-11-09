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
    <version number="1.0" date="26/02/2004" author="Pogrebnoy Yura">
    <comment date="26/02/2004" author="Pogrebnoy Yura">
    <description>Shablon formi SCH_ADT_Form.jsp</description>
    </comment>			
    <comment date="12/03/2004" author="Alexandr Kyba">
    <description>Report</description>
    </comment>
    </version>
    </versions>
    </file>
     */

    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.RapportiniSegnalazione.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../_include/ComboBox-Azienda.jsp" %>
<%@ include file="../_include/ComboBox-Dipendente.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuAnalisiControllo,7) + "</title>");
        </script>
        <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>

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

    <body style="margin:0 0 0 0;">
        <%
            long lCOD_AZL = 0;
            IAziendaHome ahome = (IAziendaHome) PseudoContext.lookup("AziendaBean");
            IDipendenteHome dhome = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");

            if (request.getParameter("AZIENDA") != null) {
                lCOD_AZL = new Long(request.getParameter("AZIENDA")).longValue();
            } else {
                lCOD_AZL = Security.getAzienda();
            }
        %>

        <!-- form for addind  -->
        <form name="frm1" action="SCH_ADT_Tabs.jsp"  method="GET" target="ifrmWork" style="margin:0 0 0 0;">
            <input id="SORT_DAT_SCA" name="SORT_DAT_SCA" type="hidden" value="X">
            <input id="SORT_DAT_SGZ" name="SORT_DAT_SGZ" type="hidden" value=" asc ">
            <table width="100%" border="0">
                <tr>
                    <td width="10" height="100%" valign="top">
                    </td>
                    <td valign="top">
                        <table width="100%" border="0">
                            <tr>
                                <td class="title">
                                    <script>
                                        document.write(getCompleteMenuPath(SubMenuAnalisiControllo,7));
                                    </script>      
                                </td>
                            </tr>
                            <tr align="center">
                                <td align="center">
                                    <!-- **************************************** -->
                                    <table width="100%" border="0">
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%
                                            ToolBar.bShowDetail = true;
                                            ToolBar.bCanDetail = true;
                                            ToolBar.bShowSave = false;
                                            ToolBar.bShowDelete = false;
                                            ToolBar.bAlwaysShowPrint = true;
                                            ToolBar.bCanPrint = true;
                                            ToolBar.bCanPrint2 = false;
                                            ToolBar.bShowPrint2 = false;
                                        %>
                                        <%=ToolBar.build(4)%>
                                    </table>
                                    <!-- **************************************** -->		
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.scheda.audit")%></legend>
                                        <table width="100%" border="0">
                                            <tr>
                                                <td colspan="100%">
                                                    <fieldset>
                                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Rapporti.segnalazione")%></legend>
                                                        <table width="100%" border="0">
                                                            <tr>
                                                                <td align="right" width="18%"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
                                                                <td colspan="3">
                                                                    <!-- REPORT -->
                                                                    <input type="checkbox" style="display:none" value="9" checked name="REP_TYPE">
                                                                    <select style="width:550px" name="COD_AZL" value=""><%=BuildAziendeComboBox(ahome, lCOD_AZL)%></select>				
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>&nbsp;</td>
                                                                <td><input type="text" name="TIT_SGZ" style="width:300px;"></td>
                                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Rilevatore")%>&nbsp;</td>
                                                                &nbsp;&nbsp;&nbsp;
                                                                <td><input type="text" name="NOM_RIL_SGZ" style="width:255px;"></td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="100%">
                                                    <fieldset>
                                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.attività.segnalazione")%></legend>
                                                        <table width="100%" border="0">
                                                            <tr>
                                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Lavoratore")%>&nbsp;</td>
                                                                <td colspan="7"><select style="width:545px;" name="COD_DPD">
                                                                        <option value=''></option>
                                                                        <%=BuildDipendenteComboBox(dhome, 0, lCOD_AZL)%>
                                                                    </select></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.segnalazione.dal")%>&nbsp;</td>
                                                                <td><s2s:Date id="DAT_SGZ_DAL" name="DAT_SGZ_DAL" /></td>
                                                                <td><%=ApplicationConfigurator.LanguageManager.getString("al")%>&nbsp;</td>
                                                                <td><s2s:Date id="DAT_SGZ_AL" name="DAT_SGZ_AL" /></td>
                                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.scadenza.dal")%>&nbsp;</td>
                                                                <td><s2s:Date name="DAT_SCA_DAL" id="DAT_SCA_DAL" /></td>
                                                                <td><%=ApplicationConfigurator.LanguageManager.getString("al")%>&nbsp;</td>
                                                                <td><s2s:Date name="DAT_SCA_AL" id="DAT_SCA_AL" /></td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="19%" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Raggruppati.per")%>&nbsp;</td>
                                                <td width="10%"><input type="radio" class="checkbox" name="RG_GROUP" value="L"/>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Lavoratore")%>&nbsp;</td>
                                                <td width="10%" align="right"><input type="radio" class="checkbox" name="RG_GROUP" value="A"/>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</td>
                                                <td width="10%"><input type="radio" class="checkbox" name="RG_GROUP" value="N" checked/>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nessuno")%></td>
                                                <td width="17%" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Stato.misura")%>&nbsp;</td>
                                                <td colspan="7"><select style="width:150px;" name="STA_INT" id="STA_INT" onclick="setDAT_SCA()">
                                                        <option value='' ></option>
                                                        <option value='N'><%=ApplicationConfigurator.LanguageManager.getString("Da.attuare")%></option>
                                                        <option value='G'><%=ApplicationConfigurator.LanguageManager.getString("Già.completata")%></option>
                                                    </select></td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="div_s" style='overflow-y : auto; height: 150px; width: 100%;'></div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <fieldset>
                                        <table width="100%" border="0">
                                            <tr align="center">
                                                <td><img src="../_images/PALLA-ROSSA.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Rossa")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.in.ritardo")%></td>
                                                <td><img src="../_images/PALLA-BLUE.gif"  alt="<%=ApplicationConfigurator.LanguageManager.getString("Blue")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.scadenza.odierna")%></td>
                                                <td width="25%" align="center"><img src="../_images/PALLA-NERA.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Nera")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.chiuse")%></td>
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
        <!-- /form for addind  -->
        <iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <iframe name="ifrmFile" id="ifrmFile" class="ifrmWork" src="../empty.txt"></iframe>
    </body>
</html>
<script language="JavaScript" src="SCH_ADT_Script.js"></script>
<script>
    btn1 = ToolBar.Search.getButton();
    btn1.onclick = goTab;
    btn2 = ToolBar.Detail.getButton();
    btn2.onclick = showDetailSCH_ADT;
    // --- REPORT ---
    // -- function for Repoprt 1------------------------------------------------------- 
    function OnPrint1(){
        frm= document.forms[0];
        w=window.open("../Reports/prepair.jsp", "REP");
        frm.target = "REP";
        frm.action = "../Reports/ScadenzarioAttivitaSegnalazione.jsp";
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
            ToolBar.submitReport("RPT_REP_SCD_ADT");
        }
    }  
    btn=ToolBar.Print2.getButton();	
    var OldPrint= btn.onclick;
    btn.onclick=OnPrint;
    //---------------------------------------------------------------------------------
    function restoreFrmProps(){
        frm.target = "ifrmWork";
        frm.action = "SCH_ADT_Tabs.jsp";
    }
    //----------------------------------
</script>
