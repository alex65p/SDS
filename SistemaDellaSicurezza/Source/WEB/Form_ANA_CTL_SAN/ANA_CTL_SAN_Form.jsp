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
            <version number="1.0" date="25/01/2004" author="Khomenko Juliya">
            <comments>
            <comment date="25/01/2004" author="Khomenko Juliya">
            <description>Shablon formi ANA_CTL_SAN_Form.jsp</description>
            </comment>
            <comment date="25/01/2004" author="Mike Kondratyuk">
            <description>Forma ANA_CTL_SAN_Form.jsp</description>
            </comment>
            <comment date="26/02/2004" author="Malyuk Sergey">
            <description>Dinamicheskie tabi i ih reaalizaciia</description>
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
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.CartelleSanitarie.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_include/ComboBox-Dipendente.jsp"%>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuVerificheSanitarie,2) + "</title>");
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
    </head>
    
    <script>
        window.dialogWidth="48em";
        window.dialogHeight="29em";
        //alert(window.dialogWidth +" "+window.dialogHeight);
    </script>
    <body>
        <%
            IAzienda azienda;
            IAziendaHome AziendaHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");

            ICartelleSanitarie CartelleSanitarie = null;
            ICartelleSanitarieHome home = (ICartelleSanitarieHome) PseudoContext.lookup("CartelleSanitarieBean");

            long lCOD_CTL_SAN = 0;            		//1
            String strDAT_CRE_CTL_SAN = "";     	//2
            String strNOM_MED_RSP_CTL_SAN = ""; 	//3
            long lCOD_DPD = 0;
            long lCOD_AZL = Security.getAzienda();

            if (request.getParameter("ID") != null) {
                String strCOD_CTL_SAN = request.getParameter("ID");

                Long ctl_san_id = new Long(strCOD_CTL_SAN);
                CartelleSanitarie = home.findByPrimaryKey(ctl_san_id);

                lCOD_CTL_SAN = ctl_san_id.longValue();
                strDAT_CRE_CTL_SAN = Formatter.format(CartelleSanitarie.getDAT_CRE_CTL_SAN());        	//2
                strNOM_MED_RSP_CTL_SAN = Formatter.format(CartelleSanitarie.getNOM_MED_RSP_CTL_SAN());    	//3
                lCOD_DPD = CartelleSanitarie.getCOD_DPD();
                lCOD_AZL = CartelleSanitarie.getCOD_AZL();
            }

            // Get Aziende/Ente
            Long azl_id = new Long(lCOD_AZL);
            azienda = AziendaHome.findByPrimaryKey(azl_id);
            String strRAG_SCL_AZL = azienda.getRAG_SCL_AZL();
        %>
        <!-- form for addind  CartelleSanitarie-->
        <form action="ANA_CTL_SAN_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value="<%=(lCOD_CTL_SAN == 0) ? "new" : "edt"%>">
            <input type="hidden" name="CTL_SAN_ID" value="<%=lCOD_CTL_SAN%>">
            <input type="hidden" name="COD_AZL" value="<%=lCOD_AZL%>">
            <table width="100%" border="0">
                <tr>
                    <td valign="top">
                        <table  width="100%">
                            <tr><td class="title">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                            (SubMenuVerificheSanitarie,2,<%=request.getParameter("ID")%>));
                                    </script>
                            </td></tr>
                            <tr><td>
                                    <table border=0>
                                        <!-- ############################ -->
 <%@ include file="../_include/ToolBar.jsp" %>
 <%ToolBar.bCanDelete = (CartelleSanitarie != null);
            ToolBar.strPrintUrl = "CartellaSanitaria.jsp?";
 %>
 <%=ToolBar.build(4)%>
                                        <!-- ########################### -->
                                    </table>  
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Cartella.sanitaria")%></legend>
                                        <table  width="100%" border="0">
                                            <tr><td colspan="4">
                                                    <fieldset>
                                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dipendente")%></legend>
                                                        <table  width="100%" border="0">
                                                            <tr>
                                                                <td width="20%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
                                                                <td>
                                                                    <input size="90%" type="text" readonly name="" value="<%=strRAG_SCL_AZL%>">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Dipendente")%>&nbsp;</b></td>
                                                                <td>
                                                                    <select tabindex="1" name="COD_DPD" style="width:82%;">
                                                                        <option value=''></option>
                                                                        <%
            IDipendenteHome d_home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
            out.print(BuildDipendenteComboBox(d_home, lCOD_DPD, lCOD_AZL));
                                                                        %>
                                                                    </select>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" width="20%"><b><%=ApplicationConfigurator.LanguageManager.getString("Medico.competente")%>&nbsp;</b></td>
                                                <td width="45%">
                                                    <input tabindex="2" size="60%" type="text" maxlength="100" name="NOM_MED_RSP_CTL_SAN" value="<%=strNOM_MED_RSP_CTL_SAN%>">
                                                </td>
                                                <td align="right" width="5%"><b><%=ApplicationConfigurator.LanguageManager.getString("Data")%></b></td>
                                                <td width="29%">
                                                    <s2s:Date tabindex="3" id="DAT_CRE_CTL_SAN" name="DAT_CRE_CTL_SAN"  value="<%=strDAT_CRE_CTL_SAN%>"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="4"><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
                </tr>
            </table>
        </form>
        <!-- /form for addind  CartelleSanitarie-->
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        
        
        <%
            //-------Loading of Tabs--------------------
            if (CartelleSanitarie != null) {
        %>
        <script language="JavaScript" src="../_scripts/index.js"></script>
        <script language="JavaScript">
            //--------BUTTONS description-----------------------
            btnParams = new Array();
            btnParams[0] = {"id":"btnNew",
                "onclick":addRow,
                "action":"AddNew"
            };
            btnParams[2] = {"id":"btnCancel",
                "onclick":delRow,
                "action":"Delete"
            };
            btnParams[1] = {"id":"btnEdit",
                "onclick":editRow,
                "action":"Edit"
            };
            //------adding tables to tabs-----------------------
            
            //----add action parameters to tabs
            //--------creating tabs--------------------------
            var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
            var btnBar = new ButtonPanel("batPanel1", btnParams);
            tabbar.addButtonBar(btnBar);
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti/Cartelle")%>", tabbar));
            tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Protocolli.sanitari")%>", tabbar));
            tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Visite.di.idoneita")%>", tabbar));
            tabbar.addTab(new Tab("tab4", "<%=ApplicationConfigurator.LanguageManager.getString("Visite.mediche")%>", tabbar));
            tabbar.idParentRecord = <%=lCOD_CTL_SAN%>;
            tabbar.refreshTabUrl="ANA_CTL_SAN_Tabs.jsp";
            tabbar.RefreshAllTabs();
            
            tabbar.tabs[0].tabObj.actionParams ={
                "Feachures":ANA_DOC_Feachures,
                "AddNew":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_CTL_SAN/ANA_CTL_SAN_Attach.jsp&ATTACH_SUBJECT=Document",
                    "whidth":"750px",
                    "height":"700px",
                    "buttonIndex":0
                },
                "Delete":	{"url":"../Form_ANA_CTL_SAN/ANA_CTL_SAN_Delete.jsp?LOCAL_MODE=DOC",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"]
                },
                "Edit":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_CTL_SAN/ANA_CTL_SAN_Attach.jsp&ATTACH_SUBJECT=Document",
                    "buttonIndex":1
                }
            };
            tabbar.tabs[1].tabObj.actionParams ={
                "Feachures":ANA_PRO_SAN_Feachures,
                "AddNew":	{"url":"../Form_ANA_PRO_SAN/ANA_PRO_SAN_Form.jsp?ATTACH_URL=Form_ANA_CTL_SAN/ANA_CTL_SAN_Attach.jsp&ATTACH_SUBJECT=Protocolle",
                    "buttonIndex":0
                },
                "Delete":	{"url":"../Form_ANA_CTL_SAN/ANA_CTL_SAN_Delete.jsp?LOCAL_MODE=PRO_SAN",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"]
                },
                "Edit":	{"url":"../Form_ANA_PRO_SAN/ANA_PRO_SAN_Form.jsp?ATTACH_URL=Form_ANA_CTL_SAN/ANA_CTL_SAN_Attach.jsp&ATTACH_SUBJECT=Protocolle",
                    "buttonIndex":1
                }
            };
            tabbar.tabs[2].tabObj.actionParams ={
                "Feachures":VST_IDO_CTL_SAN_Feachures,
                "AddNew":		{"url":"../Form_VST_IDO_CTL_SAN/VST_IDO_CTL_SAN_Form.jsp?ATTACH_URL=Form_ANA_CTL_SAN/ANA_CTL_SAN_Attach.jsp&ATTACH_SUBJECT=Idoneita",
                    "buttonIndex":0
                },
                "Delete":		{"url":"../Form_VST_IDO_CTL_SAN/VST_IDO_CTL_SAN_Delete.jsp?LOCAL_MODE=IDO",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"]
                },
                "Edit":			{"url":"../Form_VST_IDO_CTL_SAN/VST_IDO_CTL_SAN_Form.jsp?ATTACH_URL=Form_ANA_CTL_SAN/ANA_CTL_SAN_Attach.jsp&ATTACH_SUBJECT=Idoneita",
                    "buttonIndex":1
                }
            };
            tabbar.tabs[3].tabObj.actionParams ={
                "Feachures":VST_MED_CTL_SAN_Feachures,
                "AddNew":	{"url":"../Form_VST_MED_CTL_SAN/VST_MED_CTL_SAN_Form.jsp?ATTACH_URL=Form_ANA_CTL_SAN/ANA_CTL_SAN_Attach.jsp&ATTACH_SUBJECT=Mediche",
                    "buttonIndex":0
                },
                "Delete":	{"url":"../Form_VST_MED_CTL_SAN/VST_MED_CTL_SAN_Delete.jsp?LOCAL_MODE=MED",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"]
                },
                "Edit":	{"url":"../Form_VST_MED_CTL_SAN/VST_MED_CTL_SAN_Form.jsp?ATTACH_URL=Form_ANA_CTL_SAN/ANA_CTL_SAN_Attach.jsp&ATTACH_SUBJECT=Mediche",
                    "buttonIndex":1
                }
            };
            //-----activate first tab--------------------------
            tabbar.tabs[0].center.click();
        </script>
        <%} else {%>
        <script>
            window.dialogWidth="48em";
            window.dialogHeight="14em";
        </script>
        <%}%>
        
    </body>
</html>
