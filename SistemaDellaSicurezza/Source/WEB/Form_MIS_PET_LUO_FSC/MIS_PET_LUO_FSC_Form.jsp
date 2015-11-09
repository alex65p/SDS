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
<%@ page import="com.apconsulting.luna.ejb.MisurePreventive.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<html>
    <head>
        <title><%=ApplicationConfigurator.LanguageManager.getString("Associazione.misure.preventive.luoghi.fisici")%></title>
        <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script type="text/javascript" src="MIS_PET_LUO_FSC_Script.js"></script>
        <script src="../_scripts/tabs.js"></script>
        <script src="../_scripts/tabbarButtonFunctions.js"></script>
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
    <script>
        window.dialogWidth = "800px";
        window.dialogHeight = "700px";
    </script>
    <body>
        <%
            long lCOD_AZL = Security.getAzienda();
            
            long lCOD_LUO_FSC = 0;
            String strCOD_LUO_FSC = "";
            String strNOM_LUO_FSC = "";
            String strNOM_RSO = "";
            String strCOD_RSO_LUO_FSC = "";
            long lCOD_RSO_LUO_FSC = 0;
            long lCOD_MIS_PET = 0;
            long lCOD_TPL_MIS_PET = 0;
            String strCOD_MIS_RSO_LUO = "";
            long lCOD_MIS_RSO_LUO = 0;
            String strTPL_DSI_MIS_PET = "";
            String strSTA_MIS_PET = "";
            long lVER_MIS_PET = 0;
            String strDAT_PAR_ADT = "";
            long lPNZ_MIS_PET_MES = 0;
            String strDAT_PNZ_MIS_PET = "";
            IAzienda azienda;
            IAziendaHome AziendaHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");

            IAnagrLuoghiFisici AnagrLuoghiFisici;

            IMisurePreventive MisurePreventive = null;
            IMisurePreventiveHome home = (IMisurePreventiveHome) PseudoContext.lookup("MisurePreventiveBean");

            if (request.getParameter("ID_PARENT") != null) {
                strCOD_RSO_LUO_FSC = request.getParameter("ID_PARENT");
                lCOD_RSO_LUO_FSC = new Long(strCOD_RSO_LUO_FSC).longValue();
                strNOM_RSO = home.getMisurePreventive_ForRSO_View(lCOD_RSO_LUO_FSC);

                if (request.getParameter("COD_LUO_FSC") != null) {
                    strCOD_LUO_FSC = request.getParameter("COD_LUO_FSC");
                    lCOD_LUO_FSC = new Long(strCOD_LUO_FSC).longValue();
                    Long COD_LUO_FSC = new Long(strCOD_LUO_FSC);
                    IAnagrLuoghiFisiciHome Ahome = (IAnagrLuoghiFisiciHome) PseudoContext.lookup("AnagrLuoghiFisiciBean");
                    AnagrLuoghiFisici = Ahome.findByPrimaryKey(COD_LUO_FSC);
                    strNOM_LUO_FSC = AnagrLuoghiFisici.getNOM_LUO_FSC();
                }
                if (request.getParameter("ID") != null) {
                    strCOD_MIS_RSO_LUO = request.getParameter("ID");
                    Long COD_MIS_RSO_LUO = new Long(strCOD_MIS_RSO_LUO);
                    lCOD_MIS_RSO_LUO = new Long(strCOD_MIS_RSO_LUO).longValue();
                    MisurePreventive = home.findByPrimaryKey(COD_MIS_RSO_LUO);
                    strTPL_DSI_MIS_PET = MisurePreventive.getTPL_DSI_MIS_PET();
                    strSTA_MIS_PET = MisurePreventive.getSTA_MIS_PET();
                    lVER_MIS_PET = MisurePreventive.getVER_MIS_PET();
                    strDAT_PAR_ADT = Formatter.format(MisurePreventive.getDAT_PAR_ADT());
                    lPNZ_MIS_PET_MES = MisurePreventive.getPNZ_MIS_PET_MES();
                    strDAT_PNZ_MIS_PET = Formatter.format(MisurePreventive.getDAT_PNZ_MIS_PET());
                    lCOD_MIS_PET = MisurePreventive.getCOD_MIS_PET();
                    lCOD_TPL_MIS_PET = MisurePreventive.getCOD_TPL_MIS_PET();
                }
                Long azl_id = new Long(lCOD_AZL);
                azienda = AziendaHome.findByPrimaryKey(azl_id);
                String strRAG_SCL_AZL = azienda.getRAG_SCL_AZL();
        %>
        <!-- form for addind  -->
        <form action="MIS_PET_LUO_FSC_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <table width="100%" border="0">
                <tr>
                    <td valign="top">
                        <table  width="100%" border="0">
                            <tr>
                                <td class="title"><%=ApplicationConfigurator.LanguageManager.getString("Associazione.misure.preventive.luoghi.fisici")%></td>
                            </tr>
                                   <input name="SBM_MODE" type="Hidden" value="<%if (strCOD_MIS_RSO_LUO == "") {
                        out.print("new");
                    } else {
                        out.print("edt");
                    }%>">
                            <input name="COD_RSO_LUO_FSC" type="Hidden" value="<%=strCOD_RSO_LUO_FSC%>">
                            <input name="COD_LUO_FSC" type="Hidden" value="<%=lCOD_LUO_FSC%>">
                            <input name="COD_MIS_RSO_LUO" type="Hidden" value="<%=lCOD_MIS_RSO_LUO%>">
                            <tr>
                                <td>
                                    <!-- ############################ -->
                                    <table border="0">
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%ToolBar.bCanDelete = (MisurePreventive != null);%>
                                        <%ToolBar.bShowSearch = false;%>
                                        <%ToolBar.bShowPrint = (lCOD_LUO_FSC == 0);%>
                                        <%=ToolBar.build(3)%>
                                    </table>
                                    <!-- ########################### -->
                                    <fieldset>
                                        <table  width="100%" border="0">
                                            <tr>
                                                <td align="right" style="width:110px;"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
                                                <td><input readonly style="width:100%;" name="RAG_AZL" type="text" value="<%=strRAG_SCL_AZL%>" ></td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%>&nbsp;</b></td>
                                                <td><input readonly style="width:100%;" name="NOM_LUO_FSC" type="text" value="<%=strNOM_LUO_FSC%>" ></td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Rischio")%>&nbsp;</b></td>
                                                <td><input readonly style="width:100%;" name="NOM_RSO" type="text" value="<%=strNOM_RSO%>" ></td>
                                            </tr>
                                        </table>	 
                                    </fieldset>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione/protezione")%></legend>
                                        <table width="100%" border="0">
                                            <tr>
                                                <td align="right" style="width:110px;"><b><%=ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione/protezione")%>&nbsp;</b></td>
                                                <td align="left">
                                                    <select name="COD_MIS_PET" id="COD_MIS_PET" onchange="changeFields();" style="width: 400px;">
                                                        <option value=""></option>
                                                        <%
                                                            String str = "";
                                                            String strSEL = "";
                                                            java.util.Collection col = home.getMisurePreventive_ForMIS_PET_View(lCOD_AZL);
                                                            java.util.Iterator it = col.iterator();
                                                            while (it.hasNext()) {
                                                                MisurePreventive_ForMIS_PET_View dt = (MisurePreventive_ForMIS_PET_View) it.next();
                                                                long var1 = dt.COD_MIS_PET;
                                                                strSEL = "";
                                                                if (lCOD_MIS_PET != 0) {
                                                                    if (lCOD_MIS_PET == var1) {
                                                                        strSEL = "selected";
                                                                    }
                                                                }
                                                                str = str + "<option " + strSEL + " value='" + var1 + "'>" + dt.NOM_MIS_PET + "</option>";
                                                            }
                                                            out.print(str);
                                                        %>
                                                    </select>
                                                </td>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Data.compilazione")%>&nbsp;</b></td>
                                                <td align="left"><s2s:Date readonly="" id="DAT_CMP" name="DAT_CMP" value=""/></td>
                                            </tr>
                                            <tr>
                                                <td valign="top" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</b></td>
                                                <td colspan="3"> 
                                                    <textarea readonly cols="100" rows="4" id="DES_MIS_PET" name="DES_MIS_PET"></textarea>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="100%" border="0">
                                        <tr>
                                            <td  align="right" style="width:110px;"><b><%=ApplicationConfigurator.LanguageManager.getString("Adottata/Da.adottare")%>&nbsp;</b></td>
                                            <td align="left">
                                                <select name="COD_TPL_MIS_PET">
                                                    <option></option>
                                                    <%
                                                        str = "";
                                                        strSEL = "";
                                                        java.util.Collection coll = home.getMisurePreventive_ForTPL_PET_View();
                                                        java.util.Iterator itl = coll.iterator();
                                                        while (itl.hasNext()) {
                                                            MisurePreventive_ForTPL_PET_View dtl = (MisurePreventive_ForTPL_PET_View) itl.next();
                                                            long var1 = dtl.COD_TPL_MIS_PET;
                                                            strSEL = "";
                                                            if (lCOD_TPL_MIS_PET != 0) {
                                                                if (lCOD_TPL_MIS_PET == var1) {
                                                                    strSEL = "selected";
                                                                }
                                                            }
                                                            str = str + "<option " + strSEL + " value='" + var1 + "'>" + dtl.DES_TPL_MIS_PET + "</option>";
                                                        }
                                                        out.print(str);
                                                    %>
                                                </select>
                                            </td>
                                            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Destinatario.tutela")%>&nbsp;</b></td>
                                            <td align="left">
                                                <select name="TPL_DSI_MIS_PET">
                                                    <option></option>
                                                        <option <%if (strTPL_DSI_MIS_PET.equals("A")) {
                                                out.print("selected");
                                            }%> value="A">
                                                        <%=ApplicationConfigurator.LanguageManager.getString("AZIENDA")%>
                                                    </option>
                                                        <option <%if (strTPL_DSI_MIS_PET.equals("T")) {
                                                out.print("selected");
                                            }%> value="T">
                                                        <%=ApplicationConfigurator.LanguageManager.getString("TUTTI")%>
                                                    </option>
                                                        <option <%if (strTPL_DSI_MIS_PET.equals("M")) {
                                                out.print("selected");
                                            }%> value="M">
                                                        <%=ApplicationConfigurator.LanguageManager.getString("OPERATORE")%>
                                                    </option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td  align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Stato")%>&nbsp;</b></td>
                                            <td align="left">
                                                <select name="STA_MIS_PET">
                                                    <option value="0"></option>
                                                            <option value="D" <%if (strSTA_MIS_PET.equals("D")) {
                                                out.print("selected");
                                            }%>>
                                                        <%=ApplicationConfigurator.LanguageManager.getString("Da.applicare")%>
                                                    </option>
                                                            <option value="A" <%if (strSTA_MIS_PET.equals("A")) {
                                                out.print("selected");
                                            }%>>
                                                        <%=ApplicationConfigurator.LanguageManager.getString("Applicato")%>
                                                    </option>
                                                </select>
                                            </td>
                                            <td  align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Versione.misura")%>&nbsp;</b></td>
                                            <td align="left"><input type="text" value="<%=lVER_MIS_PET%>" name="VER_MIS_PET"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <fieldset>
                                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Audit")%></legend>
                                                    <table>
                                                        <tr>
                                                            <td  align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Applicare")%>&nbsp;</b></td>
                                                            <td><input type="checkbox" class="checkbox" name="ADT_MIS_PET" value="N" checked></td>
                                                            <td valign="top" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.partenza")%>&nbsp;</td>
                                                            <td><s2s:Date id="DAT_PAR_ADT" name="DAT_PAR_ADT" value="<%=strDAT_PAR_ADT%>"/></td>
                                                        </tr>
                                                    </table>
                                                </fieldset>
                                            </td>
                                            <td style="width:100%"> 	 
                                                <fieldset>
                                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Periodicità.misura.preventiva")%></legend>
                                                    <table border="0" width="100%">
                                                        <tr>
                                                            <td  align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Periodicità.(S/N)")%>&nbsp;</b></td>
                                                            <td><input type="checkbox" class="checkbox" name="PER_MIS_PET" value="N" checked></td>
                                                            <td  align="right">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Periodicità.mensile")%>&nbsp;</td>
                                                            <td><input type="text" size="4" name="PNZ_MIS_PET_MES" value="<%=lPNZ_MIS_PET_MES%>"></td>
                                                            <td  align="right"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione")%>&nbsp;</b></td>
                                                            <td><s2s:Date id="DAT_PNZ_MIS_PET" name="DAT_PNZ_MIS_PET" value="<%=strDAT_PNZ_MIS_PET%>"/><td>
                                                        </tr>
                                                    </table>
                                                </fieldset>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="100" style="width:100%">
                        <table width="100%">
                            <tr>
                                <td><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <%}%>
        <!-- /form for addind  -->
        <iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <%if (lCOD_MIS_PET != 0) {
        %><script>changeFields();</script><%
    }%>
        <%
        //-------Loading of Tabs--------------------
            if (MisurePreventive != null) {
        // -----------------------------------------
        %>
        <script src="../_scripts/index.js"></script>
        <script>
            btnParams = new Array();
            btnParams[0] = {"id": "btnNew",
                "onmousedown": btnDown,
                "onmouseup": btnOver,
                "onmouseover": btnOver,
                "onmouseout": btnOut,
                "onclick": addRow,
                "src": "../_images/NUOVO.gif",
                "action": "AddNew"
            };
            btnParams[2] = {"id": "btnCancel",
                "onmousedown": btnDown,
                "onmouseup": btnOver,
                "onmouseover": btnOver,
                "onmouseout": btnOut,
                "onclick": delRow,
                "src": "../_images/DEL_DET.gif",
                "action": "Delete"
            };
            btnParams[1] = {"id": "btnEdit",
                "onmousedown": btnDown,
                "onmouseup": btnOver,
                "onmouseover": btnOver,
                "onmouseout": btnOut,
                "onclick": editRow,
                "src": "../_images/EDIT.gif",
                "action": "Edit"
            };
            btnParams[3] = {"id": "btnHelp",
                "onmousedown": btnDown,
                "onmouseup": btnOver,
                "onmouseover": btnOver,
                "onmouseout": btnOut,
                "onclick": windowHelp,
                "src": "../_images/HELP.GIF",
                "action": "Help"
            };

            //--------creating tabs--------------------------
            var tabbar = new TabBar("tbr1", document.all["dContainer"]);
            var btnBar = new ButtonPanel("batPanel1", btnParams);
            tabbar.addButtonBar(btnBar);
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Interventi.di.audit")%>", tabbar));
            tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti")%>", tabbar));
            tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Normative/Sentenze")%>", tabbar));
            tabbar.addTab(new Tab("tab4", "<%=ApplicationConfigurator.LanguageManager.getString("Attività.segnalazione")%>", tabbar));

            //------adding tables to tabs-----------------------
            tabbar.idParentRecord = <%= new Long(lCOD_MIS_RSO_LUO)%>;
            tabbar.refreshTabUrl = "MIS_PET_LUO_FSC_Tabs.jsp";
            tabbar.RefreshAllTabs();
            //-----activate first tab--------------------------
            tabbar.tabs[0].center.click();
            //----add action parameters to tabs
            tabbar.tabs[0].tabObj.actionParams = {
                "Feachures": ANA_INR_ADT_Feachures,
                "AddNew": {"url": "../Form_ANA_INR_ADT/ANA_INR_ADT_Form.jsp?ATTACH_URL=Form_MIS_PET_LUO_FSC/MIS_PET_LUO_FSC_Attach.jsp&ATTACH_SUBJECT=AUDIT",
                    "buttonIndex": 0,
                    "disabled": false
                },
                "Edit": {"url": "../Form_ANA_INR_ADT/ANA_INR_ADT_Form.jsp?ATTACH_URL=Form_MIS_PET_LUO_FSC/MIS_PET_LUO_FSC_Attach.jsp&ATTACH_SUBJECT=AUDIT",
                    "buttonIndex": 1,
                    "disabled": false
                },
                "Delete": {"url": "../Form_ANA_INR_ADT/ANA_INR_ADT_Delete.jsp?LOCAL_MODE=inter_audit",
                    "target_element": document.all["ifrmWork"],
                    "buttonIndex": 2,
                    "disabled": false
                },
                "Help":	{"url":"../Form_ANA_INR_ADT/ANA_INR_ADT_Help.jsp",
                    "buttonIndex":3,
                    "disabled": false	
                }	
            };
            tabbar.tabs[1].tabObj.actionParams = {
                "Feachures": ANA_DOC_Feachures,
                "AddNew": {"url": "../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_MIS_PET_LUO_FSC/MIS_PET_LUO_FSC_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
                    "buttonIndex": 0,
                    "disabled": false
                },
                "Edit": {"url": "../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_MIS_PET_LUO_FSC/MIS_PET_LUO_FSC_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
                    "buttonIndex": 1,
                    "disabled": false
                },
                "Delete": {"url": "",
                    "target_element": document.all["ifrmWork"],
                    "buttonIndex": 2,
                    "disabled": true
                },
                "Help":	{"url":"../Form_ANA_INR_ADT/ANA_INR_ADT_Help.jsp",
                    "buttonIndex":3,
                    "disabled": true	
                }
            };
            tabbar.tabs[2].tabObj.actionParams = {
                "Feachures": ANA_NOR_SEN_Feachures,
                "AddNew": {"url": "../Form_ANA_NOR_SEN/ANA_NOR_SEN_Form.jsp?ATTACH_URL=Form_MIS_PET_LUO_FSC/MIS_PET_LUO_FSC_Attach.jsp&ATTACH_SUBJECT=NORSEN",
                    "buttonIndex": 0,
                    "disabled": false
                },
                "Edit": {"url": "../Form_ANA_NOR_SEN/ANA_NOR_SEN_Form.jsp?ATTACH_URL=Form_MIS_PET_LUO_FSC/MIS_PET_LUO_FSC_Attach.jsp&ATTACH_SUBJECT=NORSEN",
                    "buttonIndex": 1,
                    "disabled": false
                },
                "Delete": {"url": "",
                    "target_element": document.all["ifrmWork"],
                    "buttonIndex": 2,
                    "disabled": true
                },
                "Help":	{"url":"../Form_ANA_INR_ADT/ANA_INR_ADT_Help.jsp",
                    "buttonIndex":3,
                    "disabled": true	
                }
            };
            tabbar.tabs[3].tabObj.actionParams = {
                "Feachures": ANA_NOR_SEN_Feachures,
                "AddNew": {"url": "../Form_ANA_NOR_SEN/ANA_NOR_SEN_Form.jsp?ATTACH_URL=Form_MIS_PET_LUO_FSC/MIS_PET_LUO_FSC_Attach.jsp&ATTACH_SUBJECT=NORSEN",
                    "buttonIndex": 0,
                    "disabled": false
                },
                "Edit": {"url": "",
                    "buttonIndex": 1,
                    "disabled": false
                },
                "Delete": {"url": "",
                    "target_element": document.all["ifrmWork"],
                    "buttonIndex": 2,
                    "disabled": true
                },
                "Help":	{"url":"../Form_ANA_INR_ADT/ANA_INR_ADT_Help.jsp",
                    "buttonIndex":3,
                    "disabled": true	
                }
            };
            tabbar.tabs[0].tabObj.OnActivate = function()
            {
                tabbar.buttonBar.panel.style.display = '';
            };
            tabbar.tabs[1].tabObj.OnActivate = function()
            {
                tabbar.buttonBar.panel.style.display = '';
            };
            tabbar.tabs[2].tabObj.OnActivate = function()
            {
                tabbar.buttonBar.panel.style.display = '';
            };
            tabbar.tabs[3].tabObj.OnActivate = function()
            {
                tabbar.buttonBar.panel.style.display = 'none';
            };
        </script>
        <%} else {%>
        <script>
            window.dialogHeight = "450px";
        </script>
        <%}%>
    </body>
</html>
