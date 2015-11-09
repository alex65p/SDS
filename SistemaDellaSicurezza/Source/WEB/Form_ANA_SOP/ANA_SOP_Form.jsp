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
<%-- 
    Document   : ANA_SOP_Form
    Created on : 22-mar-2011, 18.03.17
    Author     : Alessandro
--%>
<%@ page import="com.apconsulting.luna.ejb.Sopraluogo.*" %>
<%@ page import="com.apconsulting.luna.ejb.Procedimento.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrOpere.*" %>
<%@ page import="com.apconsulting.luna.ejb.Cantiere.*" %>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="s2s.utils.text.StringManager" %>
<%@ page import="s2s.utils.*" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%@ include file="ANA_SOP_Util.jsp"%>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

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
        <link rel=STYLESHEET href="../_styles/style.css" type="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <script language="JavaScript" src="../Form_PRO_CAN_OPE_Combo/PRO_CAN_OPE_Combo.js"></script>
        <script type="text/javascript">
            document.write("<title>" + getCompleteMenuPath(SubMenuSopralluoghi,3) + "</title>");
            window.dialogWidth="900px";
            window.dialogHeight="450px";
        </script>
    </head>
    <body>
        <%
                    long lCOD_SOP = 0;
                    long lCOD_PRO = 0;
                    long lCOD_OPE = 0;
                    long lCOD_CAN = 0;
                    String sNUM_SOP = "";
                    String sDAT_SOP = "";
                    String sORA_SOP_INI = "";
                    String sORA_SOP_FIN = "";
                    String sCOD_SOP = "";
                    String sORA_INI = "";
                    String sMIN_INI = "";
                    String sORA_FIN = "";
                    String sMIN_FIN = "";

                    ISopraluogoHome home = null;
                    ISopraluogo sopraluogo = null;

                    if (request.getParameter("ID") != null) {
                        sCOD_SOP = (String) request.getParameter("ID");
                        home = (ISopraluogoHome) PseudoContext.lookup("SopraluogoBean");
                        lCOD_SOP = new Long(sCOD_SOP);
                        sopraluogo = home.findByPrimaryKey(lCOD_SOP);

                        lCOD_PRO = sopraluogo.getCOD_PRO();
                        lCOD_OPE = sopraluogo.getCOD_OPE();
                        lCOD_CAN = sopraluogo.getCOD_CAN();

                        sNUM_SOP = sopraluogo.getNUM_SOP();
                        sDAT_SOP = Formatter.format(sopraluogo.getDAT_SOP());

                        int ini, fin;
                        if (sopraluogo.getORA_INI() != null) {
                            sORA_SOP_INI = sopraluogo.getORA_INI().toString();

                            ini = sORA_SOP_INI.indexOf(':');
                            fin = sORA_SOP_INI.indexOf(':', (ini + 1));
                            sORA_INI = sORA_SOP_INI.substring(0, ini);
                            sMIN_INI = sORA_SOP_INI.substring((ini + 1), fin);
                        }
                        if (sopraluogo.getORA_FIN() != null) {
                            sORA_SOP_FIN = sopraluogo.getORA_FIN().toString();

                            ini = sORA_SOP_FIN.indexOf(':');
                            fin = sORA_SOP_FIN.indexOf(':', (ini + 1));
                            sORA_FIN = sORA_SOP_FIN.substring(0, ini);
                            sMIN_FIN = sORA_SOP_FIN.substring((ini + 1), fin);
                        }
                    }
                    Long lCOD_AZL = Security.getAzienda();
        %>
        <script type="text/javascript">
            function preparePRO_CAN_OPE_Combo(changedElement){
                if (document.getElementById("procedimento_id") == null){
                    getPRO_CAN_OPE_Combo(
                            document.getElementById("PRO_CAN_OPE_Combo"),
                            <%=lCOD_PRO%>,
                            <%=lCOD_CAN%>,
                            <%=lCOD_OPE%>,
                            <%=lCOD_AZL%>,
                            changedElement);
                } else {
                    getPRO_CAN_OPE_Combo(
                            document.getElementById("PRO_CAN_OPE_Combo"),
                            document.getElementById("procedimento_id").value,
                            document.getElementById("cantiere_id").value,
                            document.getElementById("opera_id").value,
                            <%=lCOD_AZL%>,
                            changedElement);
                }
            }
        </script>
        <!-- form for addind  -->
        <form action="ANA_SOP_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input type="hidden" name="SBM_MODE" value="<%=(lCOD_SOP == 0) ? "new" : "edt"%>">
            <input type="hidden" name="COD_SOP" value="<%=lCOD_SOP%>">
            <input type="hidden" name="ID_PARENT" value="<%=lCOD_SOP%>">
            <input type="hidden" name="OLD_NUMSOP" value="<%=sNUM_SOP%>">
            <table width="100%" border="0">
                <tr>
                    <td width="10" height="100%" valign="top">
                    </td>
                    <td valign="top">
                        <table  width="100%" border="0">
                            <tr>
                                <td class="title" colspan="2">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                        (SubMenuSopralluoghi
                                        ,3,<%=request.getParameter("ID")%>));
                                    </script>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="100%">
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%ToolBar.strPrintUrl = "SchedaSOP.jsp?";%>
                                        <%=ToolBar.build(2)%>
                                    </table>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Sopralluogo")%></legend>
                                        <table width="100%" border="0" cellpadding="2" cellspacing="2" style="margin: 0em 0em 1em 0em;">
                                            <tr>
                                                <td colspan="100%">
                                                    <div id="PRO_CAN_OPE_Combo">
                                                        <script type="text/javascript">
                                                            preparePRO_CAN_OPE_Combo();
                                                        </script>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 12%;" nowrap><b><%=ApplicationConfigurator.LanguageManager.getString("Numero.sopralluogo")%>&nbsp;</b></td>
                                                <td><input tabindex="4" size="10" type="text" maxlength="50" name="NUM_SOP" value="<%=sNUM_SOP%>"></td>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Data")%>&nbsp;</b></td>
                                                <td><s2s:Date tabindex="5" id="calendar" name="DAT_SOP" value="<%=sDAT_SOP%>"/></td>

                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Ora.inizio")%>&nbsp;
                                                </td>
                                                <td align="left">
                                                    <input tabindex="6" type="text" maxlength="2" name="ORA_INI" value="<%=sORA_INI%>" style="width:25px;">
                                                    &nbsp;:&nbsp;
                                                    <input tabindex="7" type="text" maxlength="2"  name="MIN_INI" value="<%=sMIN_INI%>" style="width:25px;">
                                                </td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Ora.fine")%>&nbsp;
                                                </td>
                                                <td align="left">
                                                    <input tabindex="8" type="text" maxlength="2" name="ORA_FIN" value="<%=sORA_FIN%>" style="width:25px;">
                                                    &nbsp;:&nbsp;
                                                    <input tabindex="9" type="text" maxlength="2"  name="MIN_FIN" value="<%=sMIN_FIN%>" style="width:25px;">
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset></td>
                            </tr>
                            <tr>
                                <td colspan="100%"><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td-->
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <%
                    //-------Loading of Tabs--------------------
                    if (sopraluogo != null) {
        %>
        <script type="text/javascript">
            function OnNewSOP()
            {
                if(tabbar.activeTab.id=="tab4")
                {
                    document.all['ifrmWork'].src=
                        "../Form_ANA_SOP/ANA_SOP_View.jsp?ATTACH_URL=Form_ANA_SOP/ANA_SOP_Attach.jsp&ATTACH_SUBJECT=DPD_INT";
                }
                else
                {
                    addRow(this.action);
                }
            }
	    
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
            
            var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
            var btnBar = new ButtonPanel("batPanel1", btnParams);
            tabbar.addButtonBar(btnBar);
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Personale.RM")%>", tabbar));
            tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Personale.imprese")%>", tabbar));
            tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Con.Dis")%>", tabbar));
            tabbar.addTab(new Tab("tab4", "<%=ApplicationConfigurator.LanguageManager.getString("CollegamentiRS")%>", tabbar));
            tabbar.addTab(new Tab("tab5", "<%=ApplicationConfigurator.LanguageManager.getString("Foto")%>", tabbar));
            tabbar.addTab(new Tab("tab6", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti.associati")%>", tabbar));
            //------adding tables to tabs-----------------------
            tabbar.idParentRecord = <%=lCOD_SOP%>;
            tabbar.refreshTabUrl="ANA_SOP_Tabs.jsp";
            tabbar.RefreshAllTabs();
            
            tabbar.tabs[0].tabObj.actionParams ={
                "Feachures": ANA_DPD_Feachures,
                "AddNew": {"url":"../Form_ANA_DPD/ANA_DPD_Form.jsp?ATTACH_URL=Form_ANA_SOP/ANA_SOP_Attach.jsp&ATTACH_SUBJECT=DPD_INT", 
                    "buttonIndex":0	
                },
                "Delete": {"url":"../Form_ANA_SOP/ANA_SOP_Delete.jsp?LOCAL_MODE=DPD_INT",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"]
                },		
                "Edit":	{"url":"../Form_ANA_DPD/ANA_DPD_Form.jsp?ATTACH_URL=Form_ANA_SOP/ANA_SOP_Attach.jsp&ATTACH_SUBJECT=DPD_INT",
                    "buttonIndex":1	
                }			  	
            }; 
            tabbar.tabs[1].tabObj.actionParams ={
                "Feachures": ANA_DPD_Feachures,
                "AddNew": {"url":"../Form_ANA_DPD/ANA_DPD_Form.jsp?ATTACH_URL=Form_ANA_SOP/ANA_SOP_Attach.jsp&ATTACH_SUBJECT=DPD_EST", 
                    "buttonIndex":0	
                },
                "Delete": {"url":"../Form_ANA_SOP/ANA_SOP_Delete.jsp?LOCAL_MODE=DPD_EST",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"]	
                },		
                "Edit":	{"url":"../Form_ANA_DPD/ANA_DPD_Form.jsp?ATTACH_URL=Form_ANA_COR/ANA_COR_Attach.jsp&ATTACH_SUBJECT=TES_VRF",
                    "buttonIndex":1	
                }			  	
            };
            tabbar.tabs[2].tabObj.actionParams = {
                "Feachures": ANA_DPD_Feachures,
                "AddNew": {"url":"../Form_ANA_CON-DIS_SOP/ANA_CON-DIS_SOP_Form.jsp?ID_PARENT=<%=lCOD_SOP%>&ATTACH_URL=Form_ANA_SOP/ANA_SOP_Attach.jsp&ATTACH_SUBJECT=DOC_SOP",
                    "buttonIndex":0
                },
                "Delete": {"url":"../Form_ANA_SOP/ANA_SOP_Delete.jsp?LOCAL_MODE=CONDIS",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"]
                },
                "Edit":	{"url":"../Form_ANA_CON-DIS_SOP/ANA_CON-DIS_SOP_Form.jsp?ATTACH_URL=Form_ANA_COR/ANA_COR_Attach.jsp&ATTACH_SUBJECT=DOC_SOP",
                    "buttonIndex":1
                }
            };
            tabbar.tabs[3].tabObj.actionParams = {
                "Feachures": ANA_DPD_Feachures,
                "AddNew": {"url":"../Form_ANA_SOP/ANA_SOP_SelSOP.jsp?COD_SOP=<%=lCOD_SOP%>", //?_Refresh=1/ANA_SOP_Attach.jsp&ATTACH_SUBJECT=DPD_EST
                    "buttonIndex":0,
                    "target_element":document.all["ifrmWork"]
                },
                "Delete": {"url":"../Form_ANA_SOP/ANA_SOP_Delete.jsp?LOCAL_MODE=COL",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"]
                },
                "Edit":	{"url":"../Form_ANA_SOP/ANA_SOP_SelSOP.jsp?COD_SOP=<%=lCOD_SOP%>",
                    "buttonIndex":1,
                    "disabled":true
                }
            };
            tabbar.tabs[4].tabObj.actionParams = {
                "Feachures": ANA_DPD_Feachures,
                "AddNew": {"url":"../Form_ANA_MED_SOP/ANA_MED_SOP_Form.jsp?COD_SOP=<%=lCOD_SOP%>", //?_Refresh=1/ANA_SOP_Attach.jsp&ATTACH_SUBJECT=DPD_EST
                    "buttonIndex":0,
                    "target_element":document.all["ifrmWork"]
                },
                "Delete": {"url":"../Form_ANA_SOP/ANA_SOP_Delete.jsp?LOCAL_MODE=MEDIA",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"]
                },
                "Edit":	{"url":"../Form_ANA_MED_SOP/ANA_MED_SOP_Form.jsp",
                    "buttonIndex":1
                }
            };
            tabbar.tabs[5].tabObj.actionParams = {
                "Feachures": ANA_DPD_Feachures,
                "AddNew": {"url":"../Form_ANA_DOC_GES_CAN/ANA_DOC_GES_CAN_Form.jsp?ID_PARENT=<%=lCOD_SOP%>&ATTACH_URL=Form_ANA_SOP/ANA_SOP_Attach.jsp&ATTACH_SUBJECT=DOC_SOP",
                    "buttonIndex":0
                },
                "Delete": {"url":"../Form_ANA_SOP/ANA_SOP_Delete.jsp?LOCAL_MODE=DOC_SOP",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"]
                },
                "Edit":	{"url":"../Form_ANA_DOC_GES_CAN/ANA_DOC_GES_CAN_Form.jsp?ATTACH_URL=Form_ANA_COR/ANA_COR_Attach.jsp&ATTACH_SUBJECT=DOC_SOP",
                    "buttonIndex":1
                }
            };
        </script>
        <%} else {%>
        <script>
            window.dialogHeight="230px";
        </script>
        <%}%>     
    </body>
</html>
