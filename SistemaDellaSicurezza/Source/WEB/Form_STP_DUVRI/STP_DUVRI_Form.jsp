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
    Document   : STP_DUVRI_Form
    Created on : 15-mag-2008, 17.33.46
    Author     : Giancarlo Servadei
--%>

<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>
<%@ page import="com.apconsulting.luna.ejb.DittaEsterna.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_include/Checker.jsp"%>

<%@ include file="../_include/ToolBar.jsp"%>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<%@ include file="../Form_ANA_CON_SER/ANA_CON_SER_Util.jsp"%>

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
            document.write("<title>" + getCompleteMenuPath(SubMenuDUVRI,1) + "</title>");
        </script>
        
        <script>
            window.dialogWidth="800px";
            window.dialogHeight="565px";
        </script>
        
    </head>
    
    <body>
        <%
            long lCOD_AZL = Security.getAzienda();

            long lCOD_SRV = 0;
            String strPRO_CON = "";
            String strDES_CON = "";
            String strRIF_CON = "";

            long lCOD_UNI_ORG = 0;
            String strDAT_INI_LAV = "";
            String strDAT_FIN_LAV = "";
            String strORA_LAV = "";
            String strLAV_NOT = "";
            String strNUM_LAV_PRE = "";
            long lAPP_COD_DTE = 0;

            IAnaContServHome home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");
            IAnaContServ AnaContServ = null;

            if (request.getParameter("ID") != null) {

                lCOD_SRV = Long.parseLong(request.getParameter("ID"));

                AnaContServ = home.findByPrimaryKey(new Long(lCOD_SRV));

                strPRO_CON = Formatter.format(AnaContServ.getPRO_CON());
                strDES_CON = Formatter.format(AnaContServ.getDES_CON());
                strRIF_CON = Formatter.format(AnaContServ.getRIF_CON());
                lCOD_UNI_ORG = AnaContServ.getCOD_UNI_ORG();
                strDAT_INI_LAV = Formatter.format(AnaContServ.getDAT_INI_LAV());
                strDAT_FIN_LAV = Formatter.format(AnaContServ.getDAT_FIN_LAV());
                strORA_LAV = Formatter.format(AnaContServ.getORA_LAV());
                strLAV_NOT = Formatter.format(AnaContServ.getLAV_NOT());
                strNUM_LAV_PRE = String.valueOf(AnaContServ.getNUM_LAV_PRE());
                lAPP_COD_DTE = AnaContServ.getAPP_COD_DTE();
            }
        %>
        
        <!-- Form per l'aggiunta di Contratti/Servizi -->
        <form action="STP_DUVRI_Set.jsp"  method="POST" target="ifrmWork">
            <input name="SBM_MODE" type="hidden" value="<%=(lCOD_SRV == 0) ? "new" : "edt"%>">
            <input name="COD_SRV" type="hidden" value="<%=lCOD_SRV%>">
            
            
            <!-- --------------------------TITOLO DEL FORM------------------------------ -->        
            <table width="100%" border="0">
                <tr>
                <td style="width:100%;height:100%" valign="top" align="left"></td>
                <td valign="top"></td>
                <tr>
                    <td class="title">
                        <script>
                            document.write(getCompleteMenuPathFunction(SubMenuDUVRI,1,<%=request.getParameter("ID")%>));
                        </script>
                    </td>
                </tr>
            </table>
            <!-- ---------------------FINE-TITOLO DEL FORM------------------------------ -->    

    
<!-- --------------------------TOOLBAR-------------------------------------- -->    
            <table width="100%">
                <tr>
                    <td><!-- QUI VIENE INSERITA LA TOOLBAR-->
                <%ToolBar.bShowHelp = true;%>
                <%ToolBar.bShowNew = false;%>
                <%ToolBar.bShowSave = false;%>
                <%ToolBar.bShowDelete = false;%>
                <%ToolBar.bShowSearch = false;%>
                <%ToolBar.bCanDelete = (AnaContServ != null);%>
                <%=ToolBar.build(3)%>
                    </td>
                </tr>
            </table>
            <!-- ---------------------FINE--TOOLBAR-------------------------------------- -->   
    
            
            <table border="0" style="width:100%;text-align:center;" cellpadding="3">
                <tr>
                    <td>
                        <fieldset>
                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Servizio.commissionato")%></legend>
                            <table border="0" style="width:100%;text-align:center;" cellpadding="5"> 
                                <tr></tr>
                                
                                <tr>
                                    <td style="width:20%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Progressivo.contratto/servizio")%></b></td>
                                    <td style="width:25%;" align="left"><input type="text" maxlength="10" size="15" name="PRO_CON" readonly value="<%=Formatter.format(strPRO_CON)%>" /></td>
                                    
                                    <td style="width:17%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%></td>
                                    <td style="width:38%;" align="left"><textarea cols="38" rows="2" name="DES_CON" readonly><%=Formatter.format(strDES_CON)%></textarea></td>
                                </tr>
                                
                                <tr>
                                    <td style="width:20%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Riferimento.contratto")%></td>
                                    <td style="width:25%;" align="left"><input type="text" maxlength="15" size="20" name="RIF_CON" readonly value="<%=Formatter.format(strRIF_CON)%>"></td>
                                    
                                    <td style="width:17%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Servizio.responsabile")%></td>
                                    <td style="width:38%;" align="left"><select name="COD_UNI_ORG" disabled>
                                                <option selected></option>
                                                <%
                                                IUnitaOrganizzativaHome uni_org_home = (IUnitaOrganizzativaHome) PseudoContext.lookup("UnitaOrganizzativaBean");
                                                out.print(BuildServizioResponsabileCombo(uni_org_home, lCOD_UNI_ORG, lCOD_AZL));
                                                %>
                                        </select></td>
                                </tr>
                                
                                <tr>
                                    <td style="width:20%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.inizio.lavori")%></td>
                                    <td style="width:25%;" align="left"><s2s:Date id="DAT_INI_LAV" name="DAT_INI_LAV" readonly="true" value="<%=strDAT_INI_LAV%>"/></td>
                                    <td style="width:17%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Orario.di.lavoro")%></td>
                                    <td style="width:38%;" align="left"><input type="text" maxlength="15" size="15" name="ORA_LAV" readonly value="<%=strORA_LAV%>" /></td>
                                </tr>
                                
                                
                                <tr>
                                    <td style="width:20%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.fine.lavori")%></td>
                                    <td style="width:25%;" align="left"><s2s:Date id="DAT_FIN_LAV" name="DAT_FIN_LAV" readonly="true" value="<%=strDAT_FIN_LAV%>"/></td>
                                    
                                    <td style="width:17%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Lavoro.notturno")%></td>
                                    <td style="width:38%;" align="left"><input type="radio" size="20%" name="LAV_NOT" value="S" disabled class="checkbox" <%=(strLAV_NOT.equals("S")) ? "checked" : ""%> />
                                               <%=ApplicationConfigurator.LanguageManager.getString("Si")%>
                                               <input type="radio" size="20%" name="LAV_NOT" disabled value="N" class="checkbox" <%=(strLAV_NOT.equals("N")) ? "checked" : ""%> />
                                               <%=ApplicationConfigurator.LanguageManager.getString("No")%></td>
                                </tr>
                                
                                <tr>
                                    <td style="width:20%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("N.ro.lavoratori.in.cantiere")%></td>
                                    <td style="width:25%;" align="left"><input type="text" size="3" name="NUM_LAV_PRE" readonly value="<%=Formatter.format(strNUM_LAV_PRE)%>" /></td>
                                    
                                    <td style="width:17%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Ditta.appaltatrice")%></b></td>
                                    <td style="width:38%;" align="left"><select name="APP_COD_DTE" disabled>
                                                <option selected></option>
                                                <%
                                                   IDittaEsternaHome dte_home = (IDittaEsternaHome) PseudoContext.lookup("DittaEsternaBean");
                                                   out.print(BuildDittaAppaltatriceCombo(dte_home, lAPP_COD_DTE, lCOD_AZL));
                                                %>
                                        </select></td>
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
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>

        <%
            if (AnaContServ != null) {
        %>
        
        <script type="text/javascript" src="../_scripts/index.js"></script>
        <script type="text/javascript">
            
            //--------BUTTONS description-----------------------
            btnParams = new Array();
            btnParams[0] = {"id":"btnNew",
                "onclick":executeOperation,
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
            
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("DUVRI")%>", tabbar));
                                            
            tabbar.idParentRecord = <%=lCOD_SRV%>;
            tabbar.refreshTabUrl="STP_DUVRI_Tabs.jsp";
            tabbar.RefreshAllTabs();
                                            
            //----add action parameters to tabs
            tabbar.tabs[0].tabObj.actionParams ={
                "Feachures":CON_SER_DUV_Feachures,
                "AddNew":	{"url":"../Form_CON_SER_DUV/CON_SER_DUV_Generate.jsp?ID_PARENT=<%=lCOD_SRV%>",
                    "buttonIndex":0,
                    "target_element":document.all["ifrmWork"],
                    "disabled": false
                },
                "Edit":	{"url":"../_include/SHOW_File.jsp?NOM_TAB=CON_SER_ISP&TYPE=FILE_DUVRI",
                    "modalWindow":false,
                    "buttonIndex":1,
                    "disabled": false
                },
                "Delete":	{"url":"../Form_CON_SER_DUV/CON_SER_DUV_Delete.jsp?DELETE_FROM=tab",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"],
                    "disabled": false
                }	
            };

            //-----activate first tab--------------------------
            tabbar.tabs[0].center.click();
        </script>
        <%} else {%>
        <script type="text/javascript">
            window.dialogHeight="320px";
        </script>
        <%}%>
    </body>
</html>
