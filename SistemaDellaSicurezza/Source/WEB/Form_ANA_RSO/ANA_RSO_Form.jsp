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
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>
<%@ page import="com.apconsulting.luna.ejb.AssociativaAgentoChimico.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.RischioFattore.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/ComboBuilder.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuRischi,2) + "</title>");
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
        <link rel="stylesheet" href="../_styles/style.css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script src="../_scripts/tabs.js"></script>
        <script src="../_scripts/tabbarButtonFunctions.js"></script>
        <script src="../_scripts/js_ANA_AZL.js"></script>
        <script src="../_scripts/Alert.js"></script>
    </head>

    <body style="margin:0 0 0 0;">
        <script>
            window.dialogWidth="855px";
        </script>
        <%
            boolean bCalledFromMachina = (request.getParameter("ID_PARENT") != null && "RISCHIO".equals(request.getParameter("ATTACH_SUBJECT")));
            boolean bCalledFromSostanza = (request.getParameter("ID_PARENT") != null && "RSO".equals(request.getParameter("ATTACH_SUBJECT")));
            short sMOD_CLC_RSO = Security.getAziendaModalitaCalcoloRischio();
            out.println("<script>");
            out.print("window.dialogHeight=\"");
            if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_BASE) {
                if (bCalledFromMachina || bCalledFromSostanza) {
                    out.print("605");
                } else {
                    out.print("580");
                }
            } else if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {
                if (bCalledFromMachina || bCalledFromSostanza) {
                    out.print("640");
                } else {
                    out.print("615");
                }
            }
            out.print("px\"");
            out.println("</script>");
        %>
        <%!            long lCOD_AZL;
            long lCOD_RSO;
            String strNOM_RSO;
            String strDES_RSO;
            java.sql.Date dtDAT_RIL;
            String strNOM_RIL_RSO;
            String strCLF_RSO;
            long lPRB_EVE_LES;
            long lENT_DAN;
            long lFRQ_RIP_ATT_DAN;
            long lNUM_INC_INF;
            float lSTM_NUM_RSO;
            long lRFC_VLU_RSO_MES;
            long lCOD_FAT_RSO;
            long lCOD_RSO_RPO;
        %>
        <%
            lCOD_AZL = 0;
            lCOD_RSO = 0;
            strNOM_RSO = strDES_RSO = strNOM_RIL_RSO = strCLF_RSO = "";
            dtDAT_RIL = null;
            lPRB_EVE_LES = 0;
            lENT_DAN = 0;
            lFRQ_RIP_ATT_DAN = 0;
            lNUM_INC_INF = 0;
            lSTM_NUM_RSO = 0;
            lRFC_VLU_RSO_MES = 0;
            lCOD_FAT_RSO = 0;
            lCOD_RSO_RPO = 0;

            IRischioHome home = null;
            IRischio bean = null;

            boolean bExtended = false;           

            String strID = "";
            if (request.getParameter("ID") != null) {
                // getting parameters of azienda
                strID = (String) request.getParameter("ID");
                try {
                    home = (IRischioHome) PseudoContext.lookup("RischioBean");
                    RischioPK id = new RischioPK(Security.getAzienda(), Long.parseLong(strID)); // PK

                    bean = home.findByPrimaryKey(id);
                    lCOD_AZL = bean.getCOD_AZL();
                    lCOD_RSO = bean.getCOD_RSO();
                    strNOM_RSO = bean.getNOM_RSO();
                    strDES_RSO = bean.getDES_RSO();
                    dtDAT_RIL = bean.getDAT_RIL();
                    strNOM_RIL_RSO = bean.getNOM_RIL_RSO();
                    strCLF_RSO = bean.getCLF_RSO();
                    lPRB_EVE_LES = bean.getPRB_EVE_LES();
                    lENT_DAN = bean.getENT_DAN();
                    lFRQ_RIP_ATT_DAN = bean.getFRQ_RIP_ATT_DAN();
                    lNUM_INC_INF = bean.getNUM_INC_INF();
                    lSTM_NUM_RSO = bean.getSTM_NUM_RSO();
                    lRFC_VLU_RSO_MES = bean.getRFC_VLU_RSO_MES();
                    lCOD_FAT_RSO = bean.getCOD_FAT_RSO();
                    lCOD_RSO_RPO = bean.getCOD_RSO_RPO();
                } catch (Exception ex) {
        %>
        <div id="errDiv" style="display:none">
            <%=Formatter.format(ex.getMessage())%>
        </div>
        <script>Alert.Error.showNotFound()</script>
        <%
                }
            }
        %>
        <form action="ANA_RSO_Set.jsp" method="POST"  target="ifrmWork" style="margin:0 0 0 0;">
            <table border="0" width="100%">
                <tr>
                    <td>
                        <table border="0" cellpadding="0" cellspacing="0"  width="100%">
                            <tr>
                                <td align="center" class="title">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                        (SubMenuRischi,2,<%=request.getParameter("ID")%>));
                                    </script>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <!-- ########################################################################################################## -->
                                    <table border="0">
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%
                                            ToolBar.bCanDelete = (bean != null);
                                            if (bCalledFromMachina) {
                                                ToolBar.bCanReturn = (bean != null);
                                            }
                                        %>
                                        <%=ToolBar.build(2)%>
                                        <%
                                            if (Security.isExtendedMode() && (bean == null || bean.isMultiple())) {
                                                bExtended = true;
                                        %>
                                        <script>
                                            isExtendedForm=true;
                                            isExtendedFormParName="NOM_RSO";
                                        </script>
                                        <%
                                            }
                                        %>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <%
                                        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
                                        String strTPL_CLF_RSO = "";
                                        if (!ifMsr) {
                                    %>             
                                    <%@include file="include_RSO_Form.jsp" %>
                                    <%} else {%>                 
                                    <%@include file="include_RSO_MSR_Form.jsp"%>
                                    <%}%>
                                </td>
                            </tr>
                            <tr>
                                <td><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <iframe name="ifrmWork" id="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <script>
            function OnPerChange(obj){
                TPL_CLF_RSO="&TPL_CLF_RSO="+obj.options[obj.selectedIndex].value;
            }
            
            function OnReturn(){
                tb_url_Attach=tb_url_Attach+TPL_CLF_RSO;
                OldReturn();
            }
            
            var TPL_CLF_RSO="&TPL_CLF_RSO=<%=strTPL_CLF_RSO%>";
            var OldReturn= ToolBar.Return.OnClick;
            ToolBar.Return.OnClick=OnReturn;
        </script>
        <script>
            function CaricaDbRischio(){
            <%if (DEBUG) {%>
                    window.open("../Form_CRM_RSO/CRM_RSO_Form.jsp");
            <%} else {%>
                
                    window.showModalDialog("../Form_CRM_RSO/CRM_RSO_Form.jsp", 0, "dialogWidth:830px;dialogHeight:280px;status:no;help:no;scroll:no;");
            <%}%>
                }
            
                function CaricaRpRischio(){
                    document.all['ifrmWork'].src = "../Form_CRM_RSO/CRM_RSO_Set.jsp?LOCAL_MODE=caricaRpRischi&NOM_RSO="+document.all['NOM_RSO'].value;
                }
        </script>

        <%if (bean != null) {%>
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
            /*   btnParams[3] = {"id":"btnHelp", 
            "onmousedown":btnDown, 	
            "onmouseup":btnOver,
            "onmouseover":btnOver,
            "onmouseout":btnOut,
            "onclick":windowHelp,
            "src":"../_images/HELP.GIF",
            "action":"Help"
            };  */
            //--------creating tabs--------------------------
            MOD_DVR_MSR = <%=ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_MSR)%>
            CORSI_4_ATT_LAV = <%=ApplicationConfigurator.isModuleEnabled(MODULES.CORSI_4_ATT_LAV)%>
            DPI_4_ATT_LAV = <%=ApplicationConfigurator.isModuleEnabled(MODULES.DPI_4_ATT_LAV)%>
            PRO_SAN_4_ATT_LAV = <%=ApplicationConfigurator.isModuleEnabled(MODULES.PRO_SAN_4_ATT_LAV)%>
            TIT_4 = <%=ApplicationConfigurator.isModuleEnabled(MODULES.TIT_4)%>
            var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
            tabbar.DEBUG_TABS_IFRM =false;
            
            var btnBar = new ButtonPanel("batPanel1", btnParams);
            tabbar.addButtonBar(btnBar);

            if (!CORSI_4_ATT_LAV){
                tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Corsi")%>", tabbar));}
            if (!MOD_DVR_MSR){
                tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Normative/Sentenze")%>", tabbar));}
            if (!DPI_4_ATT_LAV){
                tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("D.P.I.")%>", tabbar));}
            if (!PRO_SAN_4_ATT_LAV){
                tabbar.addTab(new Tab("tab4", "<%=ApplicationConfigurator.LanguageManager.getString("Protocolli.sanitari")%>", tabbar));}
            if (!MOD_DVR_MSR){
                tabbar.addTab(new Tab("tab5", "<%=ApplicationConfigurator.LanguageManager.getString("Misure.di.prevenzione.e.protezione")%>", tabbar));
                tabbar.addTab(new Tab("tab6", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti")%>", tabbar));
            }
            if ((MOD_DVR_MSR)&&(CORSI_4_ATT_LAV)&&(DPI_4_ATT_LAV)&&(PRO_SAN_4_ATT_LAV)){
                tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Misure.di.prevenzione.e.protezione")%>", tabbar));
            }
            /* if (TIT_4) {
                tabbar.addTab(new Tab("tab7", "<%=ApplicationConfigurator.LanguageManager.getString("Art.Legge.Ex81/08IV")%>", tabbar));
            }*/
            //------adding tables to tabs-----------------------
            tabbar.idParentRecord = <%= lCOD_RSO%>;
            tabbar.refreshTabUrl="ANA_RSO_Tabs.jsp";
            tabbar.RefreshAllTabs();
                                    
            //----add action parameters to tabs
            if (!CORSI_4_ATT_LAV){
                tabbar.tabs[0].tabObj.actionParams ={
                    "Feachures":ANA_COR_Feachures,
                    "AddNew":{"url":"../Form_ANA_COR/ANA_COR_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=CORSO<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":0,
                        "disabled": false
                    },
                    "Edit":	{"url":"../Form_ANA_COR/ANA_COR_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=CORSO<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":1,
                        "disabled": false
                    },
                    "Delete":	{"url":"../Form_ANA_RSO/ANA_RSO_Delete.jsp?LOCAL_MODE=c",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false,
                        "ExtendedMode": <%=bExtended%>
                    },
                    "Help":	{"url":"../Form_ANA_COR/ANA_COR_Help.jsp",
                        "buttonIndex":3,
                        "disabled": false
                    }
                };}
            //-------------------------------------------------
            if (!MOD_DVR_MSR){
                tabbar.tabs[1].tabObj.actionParams ={
                    "Feachures":ANA_NOR_SEN_Feachures,
                    "AddNew":	{"url":"../Form_ANA_NOR_SEN/ANA_NOR_SEN_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=NORMATIVA",
                        "buttonIndex":0,
                        "disabled": false
                    },
                    "Edit":	{"url":"../Form_ANA_NOR_SEN/ANA_NOR_SEN_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=NORMATIVA",
                        "buttonIndex":2,
                        "disabled": false
                    },
                    "Delete":	{"url":"../Form_ANA_RSO/ANA_RSO_Delete.jsp?LOCAL_MODE=n",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false
                    },
                    "Help":	{"url":"../Form_ANA_NOR_SEN/ANA_NOR_SEN_Help.jsp",
                        "buttonIndex":3,
                        "disabled": false
                    }
                                        
                };}
            //-------------------------------------------------
            if (!DPI_4_ATT_LAV){
                tabbar.tabs[2].tabObj.actionParams ={
                    "Feachures":{"dialogWidth":"55","dialogHeight":"710px"},
                    "AddNew":	{"url":"../Form_TPL_DPI/TPL_DPI_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=DPI<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":0,
                        "disabled": false
                    },
                    "Edit":	{"url":"../Form_TPL_DPI/TPL_DPI_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=DPI<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":1,
                        "disabled": false
                    },
                    "Delete":	{"url":"../Form_ANA_RSO/ANA_RSO_Delete.jsp?LOCAL_MODE=d",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false,
                        "ExtendedMode": <%=bExtended%>
                    },
                    "Help":	{"url":"../Form_TPL_DPI/TPL_DPI_Help.jsp",
                        "buttonIndex":3,
                        "disabled": false
                    }
                                        
                };}
            //-------------------------------------------------
            if (!PRO_SAN_4_ATT_LAV){
                tabbar.tabs[3].tabObj.actionParams ={
                    "Feachures": ANA_PRO_SAN_Feachures,
                    "AddNew":	{"url":"../Form_ANA_PRO_SAN/ANA_PRO_SAN_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=PROSAN<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":0,
                        "disabled": false

                    },
                    "Edit":	{"url":"../Form_ANA_PRO_SAN/ANA_PRO_SAN_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=PROSAN<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":1,
                        "disabled": false
                    },
                    "Delete":	{"url":"../Form_ANA_RSO/ANA_RSO_Delete.jsp?LOCAL_MODE=p",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false,
                        "ExtendedMode": <%=bExtended%>
                    },
                    "Help":	{"url":"../Form_ANA_PRO_SAN/ANA_PRO_SAN_Help.jsp",
                        "buttonIndex":3,
                        "disabled": false
                    }
                                        
                };}
            //-------------------------------------------------
            if (!MOD_DVR_MSR){
                tabbar.tabs[4].tabObj.actionParams ={
                    "Feachures":{"dialogWidth":"850px","dialogHeight":"550px"
                    },
                    "AddNew":	{"url":"../Form_ANA_MIS_PET/ANA_MIS_PET_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=MISPET<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":0,
                        "disabled": false
                    },
                    "Edit":	{"url":"../Form_ANA_MIS_PET/ANA_MIS_PET_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=MISPET<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":1,
                        "disabled": false
                    },
                    "Delete":	{"url":"../Form_ANA_RSO/ANA_RSO_Delete.jsp?LOCAL_MODE=m",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false,
                        "ExtendedMode": <%=bExtended%>
                    },
                    "Help":	{"url":"../Form_ANA_MIS_PET/ANA_MIS_PET_Help.jsp",
                        "buttonIndex":3,
                        "disabled": false
                    }
                };
                //-------------------------------------------------
                tabbar.tabs[5].tabObj.actionParams ={
                    "Feachures":ANA_DOC_Feachures,
                    "AddNew":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
                        "buttonIndex":0,
                        "disabled": false
                    },
                    "Edit":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
                        "buttonIndex":1,
                        "disabled": false
                    },
                    "Delete":	{"url":"../Form_ANA_RSO/ANA_RSO_Delete.jsp?LOCAL_MODE=doc",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false
                    },
                    "Help":	{"url":"../Form_ANA_DOC/ANA_DOC_Help.jsp",
                        "buttonIndex":3,
                        "disabled": false
                    }
                }; }
            else if ((MOD_DVR_MSR)&&(CORSI_4_ATT_LAV)&&(DPI_4_ATT_LAV)&&(PRO_SAN_4_ATT_LAV)){
                tabbar.tabs[0].tabObj.actionParams ={
                    "Feachures":{"dialogWidth":"850px","dialogHeight":"550px"
                    },
                    "AddNew":	{"url":"../Form_ANA_MIS_PET/ANA_MIS_PET_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=MISPET<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":0,
                        "disabled": false
                    },
                    "Edit":	{"url":"../Form_ANA_MIS_PET/ANA_MIS_PET_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=MISPET<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":1,
                        "disabled": false
                    },
                    "Delete":	{"url":"../Form_ANA_RSO/ANA_RSO_Delete.jsp?LOCAL_MODE=m",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false,
                        "ExtendedMode": <%=bExtended%>
                    },
                    "Help":	{"url":"../Form_ANA_MIS_PET/ANA_MIS_PET_Help.jsp",
                        "buttonIndex":3,
                        "disabled": false
                    }
                };
            }
            /*
            if (TIT_4){

            tabbar.tabs[6].tabObj.actionParams ={
                   "Feachures":{"dialogWidth":"850px","dialogHeight":"550px"
                    },
                    "AddNew":	{"url":"../Form_ART_LEG_RSO/ART_LEG_RSO_Form.jsp",
                        "buttonIndex":0,
                        "disabled": false
                    },
                    "Edit":	{"url":"../Form_ART_LEG_RSO/ART_LEG_RSO_Form.jsp",
                        "buttonIndex":1,
                        "disabled": true
                    },
                    "Delete":	{"url":"../Form_ART_LEG_RSO/ANA_LEG_RSO_Delete.jsp",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false
                    }
            };}*/

            //-------------------------------------------------
        </script>
        <%} else {
            if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_BASE) {%>
        <script>
            window.dialogHeight="335px";
        </script>
        <%  } else if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {%>
        <script>
            window.dialogHeight="370px";
        </script>
        <%  }
            }%>
    </body>
</html>
