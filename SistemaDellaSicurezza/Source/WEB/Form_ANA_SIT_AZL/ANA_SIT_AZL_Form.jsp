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
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.SediAziendali.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="ANA_SIT_AZL_Util.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<html>
    <head>
        <script type="text/javascript">
            document.write("<title>" + getCompleteMenuPath(SubMenuDistribuzioneTerritorialie,0) + "</title>");
        </script>
        <script type="text/javascript">
            window.dialogWidth="950px";
            window.dialogHeight="530px";
        </script>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script type="text/javascript" src="../_scripts/tabs.js"></script>
        <script type="text/javascript" src="../_scripts/tabbarButtonFunctions.js"></script>
    </head>
    <body>
        <%
                    IAzienda azienda;
                    IAziendaHome AziendaHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");

                    ISitaAziende SitaAziende = null;
                    ISitaAziendeHome home = (ISitaAziendeHome) PseudoContext.lookup("SitaAziendeBean");

                    long lCOD_SIT_AZL = 0;				//1
                    long lCOD_AZL = Security.getAzienda();              //2
                    if (request.getParameter("ID_PARENT") != null) {
                        lCOD_AZL = Long.parseLong(request.getParameter("ID_PARENT"));
                    }
                    String strNOM_SIT_AZL = "";				//3
                    String strIDZ_SIT_AZL = "";				//4
                    String strNUM_CIC_SIT_AZL = "";			//5
                    String strCIT_SIT_AZL = "";				//6
                    String strPRV_SIT_AZL = "";				//7
                    String strCAP_SIT_AZL = "";				//8
                    String strCOD_SIT_AZL = "";				//9

                    if (request.getParameter("ID") != null) {
                        strCOD_SIT_AZL = request.getParameter("ID");

                        Long SIT_AZL_id = new Long(strCOD_SIT_AZL);
                        SitaAziende = home.findByPrimaryKey(SIT_AZL_id);

                        lCOD_SIT_AZL = SIT_AZL_id.longValue(); 				//1
                        lCOD_AZL = SitaAziende.getCOD_AZL();				//2
                        strNOM_SIT_AZL = SitaAziende.getNOM_SIT_AZL();			//3
                        strIDZ_SIT_AZL = SitaAziende.getIDZ_SIT_AZL();			//4 - Nullable
                        strNUM_CIC_SIT_AZL = SitaAziende.getNUM_CIC_SIT_AZL();		//5
                        strCIT_SIT_AZL = SitaAziende.getCIT_SIT_AZL();			//6
                        strPRV_SIT_AZL = SitaAziende.getPRV_SIT_AZL();			//7
                        strCAP_SIT_AZL = SitaAziende.getCAP_SIT_AZL();			//8
                    }
                    // Get Aziende/Ente
                    Long azl_id = new Long(lCOD_AZL);
                    azienda = AziendaHome.findByPrimaryKey(azl_id);
                    String strRAG_SCL_AZL = azienda.getRAG_SCL_AZL();
                    String strNOM_RSP_AZL = azienda.getNOM_RSP_AZL();
                    String strCIT_AZL = azienda.getCIT_AZL();
        %>
        <!-- form for addind azienda -->
        <form action="ANA_SIT_AZL_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input type="hidden" name="SBM_MODE" value="<%=(lCOD_SIT_AZL == 0) ? "new" : "edt"%>">
            <input type="hidden" name="COD_SIT_AZL" value="<%=lCOD_SIT_AZL%>">
            <input type="hidden" name="COD_AZL" value="<%=lCOD_AZL%>">
            <!-- posizione precedente della toolbar -->
            <table width="100%" border="0">
                <tr>
                    <td class="title">
                        <script type="text/javascript">
                            document.write(getCompleteMenuPathFunction
                            (SubMenuDistribuzioneTerritorialie,0,<%=request.getParameter("ID")%>));
                        </script>
                    </td>
                </tr>
            </table>
            <table width="100%" border="0">
                <tr>  
                    <%@ include file="../_include/ToolBar.jsp" %>
                    <%ToolBar.bCanDelete = (SitaAziende != null);%>
                    <%=ToolBar.build(3)%>
                </tr> 
            </table>
            <table width="100%" border="0" cellspacing="2">
                <tr>
                    <td>
                        <fieldset>
                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Sito.aziendale")%></legend>
                            <table  width="100%" border="0">
                                <tr> 
                                    <td>
                                        <fieldset>
                                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%></legend>
                                            <table width="100%" border="0">
                                                <tr>
                                                    <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
                                                    <td colspan="3"><input style="width:100%;" name="text" type="text" tabindex="1" value="<%=strRAG_SCL_AZL%>" readonly></td>
                                                </tr>
                                                <tr>
                                                    <td align="right" style="width:125px;"><%=ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro")%>&nbsp;</td>
                                                    <td><input name="text2" type="text" tabindex="2" value="<%=strNOM_RSP_AZL%>" size="50" readonly></td>
                                                    <td align="right" style="width:100px;"><%=ApplicationConfigurator.LanguageManager.getString("Città")%>&nbsp;</td>
                                                    <td><input name="text3" type="text" tabindex="3" value="<%=strCIT_AZL%>" size="74" readonly></td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                        <br>
                                        <table width="100%" border="0">
                                            <tr>
                                                <td align="right" style="white-space:nowrap;width:125px;"><b><%=ApplicationConfigurator.LanguageManager.getString("Identificativo.sito")%>&nbsp;</b></td>
                                                <td colspan="5"><input tabindex="4" style="width:100%;" type="text" name="NOM_SIT_AZL" maxlength="100" value="<%=strNOM_SIT_AZL%>"></td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Indirizzo")%>&nbsp;</b></td>
                                                <td align="left"><input tabindex="5" size="90" type="text" name="IDZ_SIT_AZL" maxlength="50" value="<%=strIDZ_SIT_AZL%>"></td>
                                                <td align="right">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero.civico")%>&nbsp;</td>
                                                <td align="left" colspan="3"><input tabindex="6" size="39" type="text" name="NUM_CIC_SIT_AZL" maxlength="30" value="<%=strNUM_CIC_SIT_AZL%>"></td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Città")%>&nbsp;</b></td>
                                                <td align="left"><input tabindex="7" size="50" type="text" name="CIT_SIT_AZL" value="<%=strCIT_SIT_AZL%>" maxlength="30"></td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Provincia")%>&nbsp;</td>
                                                <td align="left"><input tabindex="8" size="10" type="text" maxlength="2" name="PRV_SIT_AZL" value="<%=strPRV_SIT_AZL%>"></td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("C.a.p.")%>&nbsp;</td>
                                                <td align="left"><input tabindex="9" size="15" type="text" maxlength="15" name="CAP_SIT_AZL" value="<%=strCAP_SIT_AZL%>"></td>
                                            </tr>
                                        </table>
                            </table>
                        </fieldset>   
                    </td>
                </tr>
            </table>
            <tr>
                <td colspan="100%"><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
            </tr> 
        </form>

        <!-- /form for addind Dipendente -->
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <%
                    //-------Loading of Tabs--------------------
                    if (SitaAziende != null) {
                        // -----------------------------------------
        %>
        <script type="text/javascript" src="../_scripts/index.js"></script>
        <script type="text/javascript">
            var LUOGHI_FISICI_3_LIVELLI = <%=ApplicationConfigurator.isModuleEnabled(MODULES.LUOGHI_FISICI_3_LIVELLI)%>;
            //--------BUTTONS description-----------------------
            btnParams = new Array();
            btnParams[0] = {"id":"btnNew",
                "onmousedown":btnDown,
                "onmouseup":btnOver,
                "onmouseover":btnOver,
                "onmouseout":btnOut,
                "onclick":addRow,
                "src":"../_images/NUOVO.gif",
                "action":"AddNew"
            };
            btnParams[2] = {"id":"btnCancel",
                "onmousedown":btnDown,
                "onmouseup":btnOver,
                "onmouseover":btnOver,
                "onmouseout":btnOut,
                "onclick":delRow,
                "src":"../_images/DEL_DET.gif",
                "action":"Delete"
            };
            btnParams[1] = {"id":"btnEdit",
                "onmousedown":btnDown,
                "onmouseup":btnOver,
                "onmouseover":btnOver,
                "onmouseout":btnOut,
                "onclick":editRow,
                "src":"../_images/EDIT.gif",
                "action":"Edit"
            };
            /*btnParams[3] = {"id":"btnHelp", 
            "onmousedown":btnDown, 	
            "onmouseup":btnOver,
            "onmouseover":btnOver,
            "onmouseout":btnOut,
            "onclick":windowHelp,
            "src":"../_images/HELP.GIF",
            "action":"Help"
            }; */
            //--------creating tabs--------------------------
            var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
            var btnBar = new ButtonPanel("batPanel1", btnParams);

            tabbar.addButtonBar(btnBar);
            if (LUOGHI_FISICI_3_LIVELLI){
                tabbar.addTab(new Tab("tab_immobili", "<%=ApplicationConfigurator.LanguageManager.getString("Immobili")%>", tabbar));
            } else {
                tabbar.addTab(new Tab("tab_luoghi_fisici", "<%=ApplicationConfigurator.LanguageManager.getString("Luoghi.fisici")%>", tabbar));
            }
                
            //------adding dinamic tables to tabs-----------------------
            tabbar.idParentRecord = <%= lCOD_SIT_AZL%>;
            tabbar.refreshTabUrl="ANA_SIT_AZL_Tabs.jsp";
            tabbar.RefreshAllTabs();
                
            //----add action parameters to tabs
            if (LUOGHI_FISICI_3_LIVELLI){
                tabbar.tabs[0].tabObj.actionParams = {
                    "Feachures":ANA_IMM_3LV_Feachures,
                    "AddNew":	{"url":"../Form_ANA_IMM_3LV/ANA_IMM_3LV_Form.jsp?ATTACH_URL=Form_ANA_SIT_AZL/ANA_SIT_AZL_Attach.jsp&ATTACH_SUBJECT=IMM",
                        "buttonIndex":0
                    },
                    "Edit":	{"url":"../Form_ANA_IMM_3LV/ANA_IMM_3LV_Form.jsp?ATTACH_URL=Form_ANA_SIT_AZL/ANA_SIT_AZL_Attach.jsp&ATTACH_SUBJECT=IMM",
                        "buttonIndex":1
                    },
                    "Delete":	{"url":"../Form_ANA_IMM_3LV/ANA_IMM_3LV_Delete.jsp?LOCAL_MODE=IMM",
                        "buttonIndex":2,
                        "target_element":document.all["ifrmWork"]
                    },
                    "Help":	{"url":"../Form_ANA_IMM_3LV/ANA_IMM_3LV_Help.jsp",
                        "buttonIndex":3
                    }
                };
            } else {
                tabbar.tabs[0].tabObj.actionParams = {
                    "Feachures":ANA_LUO_FSC_Feachures,
                    "AddNew":	{"url":"../Form_ANA_LUO_FSC/ANA_LUO_FSC_Form.jsp?ATTACH_URL=Form_ANA_SIT_AZL/ANA_SIT_AZL_Attach.jsp&ATTACH_SUBJECT=LUO",
                        "buttonIndex":0
                    },
                    "Edit":	{"url":"../Form_ANA_LUO_FSC/ANA_LUO_FSC_Form.jsp?ATTACH_URL=Form_ANA_SIT_AZL/ANA_SIT_AZL_Attach.jsp&ATTACH_SUBJECT=LUO",
                        "buttonIndex":1
                    },
                    "Delete":	{"url":"../Form_ANA_LUO_FSC/ANA_LUO_FSC_Delete.jsp?LOCAL_MODE=LUO",
                        "buttonIndex":2,
                        "target_element":document.all["ifrmWork"],
                        "disabled":true
                    },
                    "Help":	{"url":"../Form_ANA_LUO_FSC/ANA_LUO_FSC_Help.jsp",
                        "buttonIndex":3
                    }
                };
            }
            //-----activate first tab--------------------------
            tabbar.tabs[0].center.click();
        </script>
        <%} else {%>
        <script type="text/javascript">
            window.dialogHeight="290px";
        </script>
        <%}%>
    </body>
</html>
