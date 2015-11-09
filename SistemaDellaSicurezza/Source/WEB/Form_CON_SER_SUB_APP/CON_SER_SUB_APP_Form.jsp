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

<%-- 
    Document   : CON_SER_SUB_APP_Form
    Created on : 13-mag-2008, 9.39.25
    Author     : Giancarlo Servadei
--%>

<%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>
<%@ page import="com.apconsulting.luna.ejb.DittaEsterna.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServSubApp.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_include/ToolBar.jsp"%>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<%@ include file="CON_SER_SUB_APP_Util.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp"%>

<%@ include file="../_menu/menu/menuStructure.jsp"%>

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
        
        <script type="text/javascript" src="../_scripts/tabs.js"></script>
        <script type="text/javascript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <link rel="stylesheet" href="../_styles/style.css" />
        <link rel="stylesheet" href="../_styles/tabs.css" />
        
        <script type="text/javascript">
            document.write("<title>" + getCompleteMenuPath(SubMenuContrattiServizi,3) + "</title>");
            
            window.dialogWidth="800px";
            window.dialogHeight="740px";
            
            function populateDES(objDES) {
                if (objDES.value > 0 ) {
                    document.all["DES_CON"].value = objDES.options(objDES.selectedIndex).valueDES;
                } else {
                    document.all["DES_CON"].value = "";
                }
            }
        
            function populateIDZ(objIDZ) {
                if (objIDZ.value > 0 ) {
                    document.all["IDZ_DTE"].value = objIDZ.options(objIDZ.selectedIndex).valueIDZ;
                } else {
                    document.all["IDZ_DTE"].value = "";
                }
            }
    
            function gestConsegna(value){
                if (value != 4){
                    document.forms[0].CON_DES.value = "";
                    document.forms[0].CON_DES.disabled = true;
                } else {
                    document.forms[0].CON_DES.disabled = false;
                }
            }
        </script>
    </head>
    <body>
        <%
            long lCOD_AZL = Security.getAzienda();
            long lCOD_SUB_APP = 0;
            long lCOD_SRV = 0;

            String strPRO_CON = "";
            String strDES_CON = "";
            long lCOD_DTE = 0;

            String strTEL = "";
            String strFAX = "";
            String strEMAIL = "";

            String strRES_LOC_NOM = "";
            String strRES_LOC_QUA = "";
            String strRES_LOC_TEL = "";

            String strINT_ASS_DES = "";
            String strORA_LAV = "";
            String dtDAT_INI_LAV = "";
            String dtDAT_FIN_LAV = "";
            String strLAV_NOT = "";
            int iCOD_CON = 0;
            String strCON_DES = "";

            String strRAG_SCL_DTE = "";
            String strIDZ_DTE = "";

            IContServSubAppHome home = (IContServSubAppHome) PseudoContext.lookup("ContServSubAppBean");
            IContServSubApp ContServSubApp = null;
            
            String strID_PARENT = request.getParameter("ID_PARENT");

            if (request.getParameter("ID") != null) {

                lCOD_SUB_APP = Long.parseLong(request.getParameter("ID"));

                ContServSubApp = home.findByPrimaryKey(new Long(lCOD_SUB_APP));

                lCOD_SRV = ContServSubApp.getCOD_SRV();
                strPRO_CON = Formatter.format(ContServSubApp.getPRO_CON());
                strDES_CON = Formatter.format(ContServSubApp.getDES_CON());
                lCOD_DTE = ContServSubApp.getCOD_DTE();
                strRAG_SCL_DTE = Formatter.format(ContServSubApp.getRAG_SCL_DTE());
                strIDZ_DTE = Formatter.format(ContServSubApp.getIDZ_DTE());

                strTEL = Formatter.format(ContServSubApp.getTEL());
                strFAX = Formatter.format(ContServSubApp.getFAX());
                strEMAIL = Formatter.format(ContServSubApp.getEMAIL());

                strRES_LOC_NOM = Formatter.format(ContServSubApp.getRES_LOC_NOM());
                strRES_LOC_QUA = Formatter.format(ContServSubApp.getRES_LOC_QUA());
                strRES_LOC_TEL = Formatter.format(ContServSubApp.getRES_LOC_TEL());

                strINT_ASS_DES = Formatter.format(ContServSubApp.getINT_ASS_DES());
                strORA_LAV = Formatter.format(ContServSubApp.getORA_LAV());
                dtDAT_INI_LAV = Formatter.format(ContServSubApp.getDAT_INI_LAV());
                dtDAT_FIN_LAV = Formatter.format(ContServSubApp.getDAT_FIN_LAV());
                strLAV_NOT = Formatter.format(ContServSubApp.getLAV_NOT());
                iCOD_CON = ContServSubApp.getCOD_CON();
                strCON_DES = Formatter.format(ContServSubApp.getCON_DES());

            } else
            if (strID_PARENT != null){
                lCOD_SRV = Long.parseLong(strID_PARENT);
                
                IAnaContServHome homeAnaConSer = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");
                IAnaContServ beanAnaConSer = homeAnaConSer.findByPrimaryKey(new Long(lCOD_SRV));
                
                strPRO_CON = Formatter.format(beanAnaConSer.getPRO_CON());
                strDES_CON = Formatter.format(beanAnaConSer.getDES_CON());
            }
        %>
        
        <!-- Form per l'aggiunta di Contratti/Servizi -->
        <form action="CON_SER_SUB_APP_Set.jsp"  method="POST" target="ifrmWork">
            <input name="SBM_MODE" type="hidden" value="<%=(lCOD_SUB_APP == 0) ? "new" : "edt"%>">
            <input name="COD_SUB_APP" type="hidden" value="<%=lCOD_SUB_APP%>">
            <!-- --------------------------TITOLO DEL FORM------------------------------ -->        
            <table width="100%" border="0">
                <tr>
                <td style="width:100%;height:100%;" valign="top" align="left"></td>
                <td valign="top"></td>
                <tr>
                    <td class="title">
                        <script>
                            document.write(getCompleteMenuPathFunction(SubMenuContrattiServizi,3,<%=request.getParameter("ID")%>));
                        </script>
                    </td>
                </tr>
            </table>
            <!-- ---------------------FINE-TITOLO DEL FORM------------------------------ -->    

    
            <!-- --------------------------TOOLBAR-------------------------------------- -->    
            <table width="100%">
                <tr>
                    <td><!-- QUI VIENE INSERITA LA TOOLBAR-->
                <%
                    ToolBar.bCanDelete = (ContServSubApp != null);
                    if (strID_PARENT != null){
                        ToolBar.bCanSearch = false;
                        ToolBar.bShowSearch = false;
                        ToolBar.bShowReturn = false;
                        ToolBar.bCanReturn = false;
                    }
                    out.print(ToolBar.build(3));
                %>
                    </td>
                </tr>
            </table>
            <!-- ---------------------FINE--TOOLBAR-------------------------------------- -->
            
            <table border="0" style="width:100%;text-align:center;" cellspacing="3">
                <tr>
                    <td>
                        <fieldset>
                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.subappaltatrice")%></legend>
                            <table border="0" style="width:100%;text-align:center;" cellspacing="3">
                                <tr>
                                    <td style="width:15%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Progressivo.contratto/servizio")%></b></td>
                                    <td style="width:35%;" align="left">
                                            <% if (lCOD_SRV == 0) {%>
                                            <select id="selectCOD_SRV" name="lCOD_SRV" onchange="populateDES(this);">
                                                <option selected></option>
                                                <%
                                                IAnaContServHome con_ser_home=(IAnaContServHome)PseudoContext.lookup("AnaContServBean");
                                                out.print(BuildProgrContr_DescrizioneText(con_ser_home, lCOD_SRV, lCOD_AZL));
                                                %>
                                            </select>
                                            <% } else { %>
                                            <input type="hidden" size="15" name="lCOD_SRV" value="<%=lCOD_SRV%>" />
                                            <input type="text" size="15" name="SRV_DES" readonly value="<%=strPRO_CON%>" />
                                            <% } %></td>
                                    <td style="width:15%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%></td>
                                    <td style="width:35%;" align="left"><textarea size="50" cols="38" rows="2" type="text" name="DES_CON" readonly><%=Formatter.format(strDES_CON)%></textarea></td>
                                </tr>
                                
                                <tr>
                                    <td style="width:15%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Ragione.sociale")%></b></td>
                                    <td style="width:35%;" align="left">
                                            <% if (lCOD_DTE == 0) {%>
                                            <select style="width:100%;" id="selectCOD_DTE" name="lCOD_DTE" onchange="populateIDZ(this);">
                                                <option selected></option>
                                                <%
                                                IDittaEsternaHome dt_home=(IDittaEsternaHome)PseudoContext.lookup("DittaEsternaBean");
                                                out.print(BuildRagioneSociale_IndirizzoText(dt_home, lCOD_DTE, lCOD_AZL));
                                                %>
                                            </select>
                                            <% } else { %>
                                            <input type="hidden" size="45" name="lCOD_DTE" value="<%=lCOD_DTE%>" />
                                            <input type="text" size="45" name="DTE_DES" readonly value="<%=strRAG_SCL_DTE%>" />
                                            <% } %></td>
                                    <td style="width:15%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Indirizzo")%></b></td>
                                    <td style="width:35%;" align="left"><input size="50" type="text" name="IDZ_DTE" value="<%=Formatter.format(strIDZ_DTE)%>" readonly /></td>
                                </tr>
                                
                                <tr>
                                    <td style="width:15%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Telefono")%></td>
                                    <td style="width:35%;" align="left"><input tabindex="1" type="text" maxlength="15" name="TEL" value="<%=Formatter.format(strTEL)%>" /></td>
                                    <td style="width:15%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Fax")%></td>
                                    <td style="width:35%;" align="left"><input tabindex="2" type="text" maxlength="15" name="FAX" value="<%=Formatter.format(strFAX)%>" /></td>
                                </tr>
                                
                                <tr>
                                    <td style="width:15%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("E-mail")%></td>
                                    <td style="width:35%;" align="left" colspan="3"><input tabindex="3" type="text" size="45" maxlength="50" name="EMAIL" value="<%=Formatter.format(strEMAIL)%>" /></td>
                                </tr>
                            </table>
                        </fieldset>
                        
                        <br>
                        
                        <fieldset>
                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Responsabile.in.loco")%></legend>
                            <table border="0" style="width:100%;text-align:center;" cellspacing="3">
                                <tr>
                                    <td style="width:15%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Nominativo")%></td>
                                    <td style="width:35%;" align="left" colspan="3"><input tabindex="4" size="45" maxlength="50" type="text" name="RES_LOC_NOM" value="<%=Formatter.format(strRES_LOC_NOM)%>" /></td>
                                </tr>
                                
                                <tr>
                                    <td style="width:15%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Qualifica")%></td>
                                    <td style="width:35%;" align="left"><input tabindex="5" size="45" maxlength="50" type="text" name="RES_LOC_QUA" value="<%=strRES_LOC_QUA%>" /></td>
                                    <td style="width:13%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Telefono")%></td>
                                    <td style="width:37%;" align="left"><input tabindex="6" type="text" maxlength="15" name="RES_LOC_TEL" value="<%=Formatter.format(strRES_LOC_TEL)%>" /></td>
                                </tr>
                            </table>
                        </fieldset>
                        
                        <br>
                        
                        <fieldset>
                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Intervento.assegnato")%></legend>
                            <table border="0" style="width:100%;text-align:center;" cellspacing="3">
                                <tr>
                                    <td style="width:15%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%></td>
                                    <td align="left" colspan="3"><input tabindex="7" type="text" size="64" maxlength="50" name="INT_ASS_DES" value="<%=strINT_ASS_DES%>" /></td>
                                    <td style="width:10%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Orario.di.lavoro")%></td>
                                    <td style="width:21%;" align="left"><input tabindex="8" type="text" maxlength="15" size="17" name="ORA_LAV" value="<%=Formatter.format(strORA_LAV)%>" /></td>
                                </tr>
                                
                                <tr>
                                    <td style="width:15%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.inizio.lavori")%></td>
                                    <td style="width:16%;" align="left"><s2s:Date tabindex="9" id="DAT_INI_LAV" name="DAT_INI_LAV" value="<%=dtDAT_INI_LAV%>"/></td>
                                    <td style="width:16%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.fine.lavori")%></td>
                                    <td style="width:19%;" align="left"><s2s:Date tabindex="10" id="DAT_FIN_LAV" name="DAT_FIN_LAV" value="<%=dtDAT_FIN_LAV%>"/></td>
                                    <td valign="middle" align="right" colsapn="2"><%=ApplicationConfigurator.LanguageManager.getString("Lavoro.notturno")%></td>
                                    <td style="width:21%;" align="left"><input type="radio" name="LAV_NOT" value="S" class="checkbox" <%=(strLAV_NOT.equals("S")) ? "checked" : ""%> />
                                                                     <%=ApplicationConfigurator.LanguageManager.getString("Si")%>
                                                                 <input type="radio" name="LAV_NOT" value="N" class="checkbox" <%=(strLAV_NOT.equals("N")) ? "checked" : ""%> />
                                                                     <%=ApplicationConfigurator.LanguageManager.getString("No")%></td>
                                </tr>
                                
                                <tr>
                                    <td style="width:15%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Consegna")%></td>
                                    <td style="width:16%;" align="center"><input type="radio" name="COD_CON" <%=iCOD_CON == 1 ? "checked" : ""%> onclick="gestConsegna(this.value);" value="1">ELETTRICA</td>
                                    <td style="width:16%;" align="center"><input type="radio" name="COD_CON" <%=iCOD_CON == 2 ? "checked" : ""%> onclick="gestConsegna(this.value);" value="2">MECCANICA</td>
                                    <td style="width:19%;" align="right"><input type="radio" name="COD_CON" <%=iCOD_CON == 3 ? "checked" : ""%> onclick="gestConsegna(this.value);" value="3">FIAMMA LIBERA</td>
                                    <td style="width:13%;" align="right"><input type="radio" name="COD_CON" <%=iCOD_CON == 4 ? "checked" : ""%> onclick="gestConsegna(this.value);" value="4">ALTRO</td>
                                    <td align="left" colspan="2"><input type="text" name="CON_DES" size="26" maxlength="50" value="<%=strCON_DES%>" /></td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="dContainer" class="mainTabContainer" style="width:100%"></div>
                    </td>
                </tr> 
            </table>
        </form>
        
        <% if (lCOD_DTE == 0) { %>
        <script>populateIDZ(document.getElementById("selectCOD_DTE"));</script>
        <% } %>
        
        
        <% if (lCOD_SRV == 0) { %>
        <script>populateDES(document.getElementById("selectCOD_SRV"));</script>
        <% } %>
        
        <script>gestConsegna(<%=iCOD_CON%>);</script>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
        
        <%
            if (ContServSubApp != null) {
        %>
        <script type="text/javascript" src="../_scripts/index.js"></script>
        <script type="text/javascript">
            
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
            var tabbar = new TabBar("tbr1",document.all["dContainer"]);
            var btnBar = new ButtonPanel("batPanel1", btnParams);
            tabbar.addButtonBar(btnBar);
            
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Personale.coinvolto.tab")%>", tabbar));
            tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Prodotti/Sostanze")%>", tabbar));
            tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Analisi.dei.rischi.tab")%>", tabbar));
                                           
            tabbar.idParentRecord = <%=lCOD_SUB_APP%>;
            tabbar.refreshTabUrl="CON_SER_SUB_APP_Tabs.jsp";
            tabbar.RefreshAllTabs();
                                            
            //----add action parameters to tabs
            tabbar.tabs[0].tabObj.actionParams ={
                "Feachures":SUB_APP_PER_COI_Feachures,
                "AddNew":	{"url":"../Form_SUB_APP_PER_COI/SUB_APP_PER_COI_Form.jsp",
                    "buttonIndex":0,
                    "disabled": false
                },
                "Edit":	{"url":"../Form_SUB_APP_PER_COI/SUB_APP_PER_COI_Form.jsp",
                    "buttonIndex":1,
                    "disabled": false
                },
                "Delete":	{"url":"../Form_SUB_APP_PER_COI/SUB_APP_PER_COI_Delete.jsp?DELETE_FROM=tab",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"],
                    "disabled": false
                }	
            };
            
            
            tabbar.tabs[1].tabObj.actionParams ={
                "Feachures":SUB_APP_PRO_SOS_Feachures,
                "AddNew":	{"url":"../Form_SUB_APP_PRO_SOS/SUB_APP_PRO_SOS_Form.jsp",
                    "buttonIndex":0,
                    "disabled": false
                },
                "Edit":	{"url":"../Form_SUB_APP_PRO_SOS/SUB_APP_PRO_SOS_Form.jsp",
                    "buttonIndex":1,
                    "disabled": false
                },
                "Delete":	{"url":"../Form_SUB_APP_PRO_SOS/SUB_APP_PRO_SOS_Delete.jsp?DELETE_FROM=tab",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"],
                    "disabled": false
                }	
            };
            
            tabbar.tabs[2].tabObj.actionParams ={
                "Feachures":SUB_APP_ANA_RIS_Feachures,
                "AddNew":	{"url":"../Form_SUB_APP_ANA_RIS/SUB_APP_ANA_RIS_Form.jsp",
                    "buttonIndex":0,
                    "disabled": false
                },
                "Edit":	{"url":"../Form_SUB_APP_ANA_RIS/SUB_APP_ANA_RIS_Form.jsp",
                    "buttonIndex":1,
                    "disabled": false
                },
                "Delete":	{"url":"../Form_SUB_APP_ANA_RIS/SUB_APP_ANA_RIS_Delete.jsp?DELETE_FROM=tab",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"],
                    "disabled": false
                }	
            };
            
            //-----activate first tab--------------------------
            tabbar.tabs[0].center.click();
        </script>
        <%} else {%>
        <script>
            window.dialogHeight="510px";
        </script>
        <%}%>
        
    </body>
</html>
