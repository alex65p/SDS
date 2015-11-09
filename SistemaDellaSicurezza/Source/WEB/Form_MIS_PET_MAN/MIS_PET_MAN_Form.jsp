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
     <version number="1.0" date="27/02/2004" author="Roman Chumachenko">
     <comments>
     <comment date="27/02/2004" author="Roman Chumachenko">
     <description>MIS_PET_MAN_Form.jsp</description>
     </comment>
     </comments> 
     </version>
     </versions>
     </file> 
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AssRischioAttivita.*" %>
<%@ page import="com.apconsulting.luna.ejb.AssMisuraAttivita.*" %>
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.MisuraPreventiva.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.TipologiaMisurePreventive.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="MIS_PET_MAN_Util.jsp"%>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<%    
    long lCOD_AZL = Security.getAzienda();
    String COD_MIS_PET_MAN = "";
    long lCOD_MAN = 0;
    long lCOD_RSO_MAN = 0;
    long lCOD_RSO = 0;
    long lCOD_MIS_PET = 0;
    
    String VER_MIS_PET = "";
    String PNZ_MIS_PET_MES = "";
    String PER_MIS_PET = "";
    String DAT_PAR_ADT = "";
    String ADT_MIS_PET = "";
    String COD_TPL_MIS_PET = "";
    String TPL_DSI_MIS_PET = "";
    String DAT_PNZ_MIS_PET = "";

    String AziendaName = "";
    String AttLavorativeName = "";
    String RischioName = "";
    String MisuraName = "";
    String MisuraDate = "";
    String MisuraDescription = "";

    IAssMisuraAttivita bean = null;
    if (request.getParameter("ID") != null) {
        COD_MIS_PET_MAN = (String) request.getParameter("ID");
        //getting of object
        try {
            IAssMisuraAttivitaHome home = (IAssMisuraAttivitaHome) PseudoContext.lookup("AssMisuraAttivitaBean");
            Long id = new Long(COD_MIS_PET_MAN);
            bean = home.findByPrimaryKey(id);
        } catch (Exception ex) {
            ex.printStackTrace();
            out.print("Error:" + ex.toString());
            return;
        }
        // getting of object variables
        lCOD_MAN = bean.getCOD_MAN();
        lCOD_MIS_PET = bean.getCOD_MIS_PET();
        TPL_DSI_MIS_PET = Formatter.format(bean.getTPL_DSI_MIS_PET());
        VER_MIS_PET = Formatter.format(bean.getVER_MIS_PET());
        PNZ_MIS_PET_MES = Formatter.format(bean.getPNZ_MIS_PET_MES());
        PER_MIS_PET = Formatter.format(bean.getPER_MIS_PET());
        DAT_PAR_ADT = Formatter.format(bean.getDAT_PAR_ADT());
        ADT_MIS_PET = Formatter.format(bean.getADT_MIS_PET());
        COD_TPL_MIS_PET = Formatter.format(bean.getCOD_TPL_MIS_PET());
        DAT_PNZ_MIS_PET = Formatter.format(bean.getDAT_PNZ_MIS_PET());
    }
    
    if (request.getParameter("ID_PARENT") != null) {
        lCOD_RSO_MAN = Long.parseLong((String) request.getParameter("ID_PARENT"));
        IAssRischioAttivitaHome ra_home = (IAssRischioAttivitaHome) PseudoContext.lookup("AssRischioAttivitaBean");
        IAssRischioAttivita ra_bean = ra_home.findByPrimaryKey(new Long(lCOD_RSO_MAN));
        lCOD_RSO = ra_bean.getCOD_RSO();
        lCOD_AZL = ra_bean.getCOD_AZL();
        
        //------ Azienda name ------------------------------------------------
        IAziendaHome azienda_home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
        IAzienda azienda = azienda_home.findByPrimaryKey(new Long(lCOD_AZL));
        AziendaName = Formatter.format(azienda.getRAG_SCL_AZL());
        //------ Attivita Lavorative name ------------------------------------
        IAttivitaLavorativeHome attivita_home = (IAttivitaLavorativeHome) PseudoContext.lookup("AttivitaLavorativeBean");
        IAttivitaLavorative attivita = attivita_home.findByPrimaryKey(new AttivitaLavorativePK(lCOD_AZL, lCOD_MAN));
        AttLavorativeName = Formatter.format(attivita.getNOM_MAN());
        //-------Rischio name-------------------------------------------------
        IRischioHome rischio_home = (IRischioHome) PseudoContext.lookup("RischioBean");
        IRischio rischio = rischio_home.findByPrimaryKey(new RischioPK(lCOD_AZL, lCOD_RSO));//new Long(lCOD_RSO));
        RischioName = Formatter.format(rischio.getNOM_RSO());
        //-------Misura Preventive--------------------------------------------
        IMisuraPreventivaHome misura_home = (IMisuraPreventivaHome) PseudoContext.lookup("MisuraPreventivaBean");
        IMisuraPreventiva misura = misura_home.findByPrimaryKey(new MisuraPreventivaPK(lCOD_AZL, new Long(lCOD_MIS_PET).longValue()));
        MisuraName = Formatter.format(misura.getNOM_MIS_PET());
        MisuraDate = Formatter.format(misura.getDAT_CMP());
        MisuraDescription = Formatter.format(misura.getDES_MIS_PET());
    }
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
        <title><%=ApplicationConfigurator.LanguageManager.getString("Associazione.misure.preventive.attivita.lavorative")%></title>
    </head>
    <link rel="stylesheet" href="../_styles/style.css">
    <link rel="stylesheet" href="../_styles/tabs.css">
    <script src="../_scripts/tabs.js"></script>
    <script src="../_scripts/tabbarButtonFunctions.js"></script>
    <script>
        window.dialogWidth = "780px";
        window.dialogHeight = "630px";
    </script>
    <body style="margin:0 0 0 0;">
        <form action="MIS_PET_MAN_Set.jsp?par=add" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <table cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td valign="top">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td align="center" class="title"><%=ApplicationConfigurator.LanguageManager.getString("Associazione.misure.preventive.attivita.lavorative")%></td>
                            </tr>
                            <tr>
                                <td>
                                    <input name="SBM_MODE" type="Hidden" value="<%
                                        if (!COD_MIS_PET_MAN.equals("")) {
                                            out.print("edt");
                                        } else {
                                            out.print("new");
                                        }%>">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input name="COD_MIS_PET_MAN" type="Hidden" value="<%
                                        if (!COD_MIS_PET_MAN.equals("")) {
                                            out.print(COD_MIS_PET_MAN);
                                        }%>">
                                    <input name="COD_RSO_MAN" type="Hidden" value="<%
                                        if (lCOD_RSO_MAN != 0) {
                                            out.print(lCOD_RSO_MAN);
                                        }%>">
                                    <input name="COD_MAN" type="Hidden" value="<%
                                        if (lCOD_MAN != 0) {
                                            out.print(lCOD_MAN);
                                        }%>">
                                    <input name="COD_AZL" type="Hidden" value="<%
                                        if (lCOD_AZL != 0) {
                                            out.print(lCOD_AZL);
                                        }%>">
                                    <input name="COD_RSO" type="Hidden" value="<%
                                        if (lCOD_RSO != 0) {
                                            out.print(lCOD_RSO);
                                        }%>">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table border="0">
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%ToolBar.bShowPrint = false;%>
                                        <%=ToolBar.build(2)%>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%" border="0" cellpadding="2" cellspacing="2">
                            <tr>
                                <td colspan="4">
                                    <fieldset>
                                        <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                            <tr>
                                                <td align="right" style="width:15%;"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%></b>&nbsp;</td>
                                                <td colspan="3"><input readonly style="width:100%" type="text" name="RAG_SCL_AZL" value="<%=AziendaName%>"></td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa")%>&nbsp;</b></td>
                                                <td><input readonly size="50" name="NOM_MAN" value="<%=AttLavorativeName%>"></td>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Rischio")%>&nbsp;</b></td>
                                                <td><input readonly size="51" name="NOM_RSO" value="<%=RischioName%>"></td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <!-- Misura di Prevenzione/Protezione -->
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione/protezione")%></legend>
                                        <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                            <tr>
                                                <td align="right" style="width:15%;"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
                                                <td><input readonly size="63" type="text" name="NOM_MIS_PET" value="<%=MisuraName%>"></td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.compilazione")%>&nbsp;</td>
                                                <td><s2s:Date readonly="true" id="DAT_CMP" name="DAT_CMP" value="<%=MisuraDate%>"/></td>
                                            </tr>
                                            <tr>
                                                <td align="right" valign="top">&nbsp;<b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</b></td>
                                                <td colspan="3"><textarea readonly rows="2" cols="10" style="width:99%" name="DES_MIS_PET"><%=MisuraDescription%></textarea></td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                            <!-- Adottata/Da adottare combobox -->
                            <tr>
                                <td align="right" style="width:16%;"><%=ApplicationConfigurator.LanguageManager.getString("Adottata/Da.adottare")%>&nbsp;</td>
                                <td colspan="3">
                                    <select style="width:235;" name="COD_TPL_MIS_PET">
                                        <option value=''></option>
                                        <%
                                            ITipologiaMisurePreventiveHome tpl_home = (ITipologiaMisurePreventiveHome) PseudoContext.lookup("TipologiaMisurePreventiveBean");
                                            if (COD_TPL_MIS_PET.equals("")) {
                                                COD_TPL_MIS_PET = "0";
                                            }
                                            out.print(BuildAdotattaComboBox(tpl_home, new Long(COD_TPL_MIS_PET).longValue()));
                                        %>
                                    </select>
                                </td>
                            </tr>	
                            <!-- Destinario Tutella   Versione Misura-->
                            <tr>
                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Destinatario.tutela")%>&nbsp;</b></td>
                                <td>
                                    <SELECT name="TPL_DSI_MIS_PET" style="width:100px">
                                        <option value=""></option>
                                                <option value="A" <%if (TPL_DSI_MIS_PET.equals("A")) {
                                                out.print("selected");
                                            }%>>
                                            <%=ApplicationConfigurator.LanguageManager.getString("AZIENDA")%></option>
                                                <option value="T" <%if (TPL_DSI_MIS_PET.equals("T")) {
                                                out.print("selected");
                                            }%>>
                                            <%=ApplicationConfigurator.LanguageManager.getString("TUTTI")%></option>
                                                <option value="O" <%if (TPL_DSI_MIS_PET.equals("O")) {
                                                out.print("selected");
                                            }%>>
                                            <%=ApplicationConfigurator.LanguageManager.getString("OPERATORE")%></option>
                                    </SELECT>
                                </td>
                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Versione.misura")%>&nbsp;</b></td>
                                <td><input size="10" type="text" name="VER_MIS_PET" value="<%=VER_MIS_PET%>"></td>
                            </tr>
                            <!-- Audit   Periodica Misura -->
                            <tr>
                                <td colspan="4">
                                    <table border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td>
                                                <!-- Audit -->
                                                <fieldset>
                                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Audit")%></legend>
                                                    <table border="0" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td align="right"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Applicare")%>&nbsp;</b></td>
                                                            <td>
                                                                   <input type="Checkbox" name="ADT_MIS_PET" <%if (ADT_MIS_PET.equals("S")) {
                                                                        out.print("checked");
                                                                    }%>>
                                                            </td>
                                                            <td align="right">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.partenza")%>&nbsp;</td>
                                                            <td align="right">
                                                                <s2s:Date id="DAT_PAR_ADT" name="DAT_PAR_ADT" value="<%=DAT_PAR_ADT%>"/>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </fieldset>
                                            </td>
                                            <td>
                                                <table border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td>
                                                            <!-- Periodica Mesura -->
                                                            <fieldset>
                                                                <legend><%=ApplicationConfigurator.LanguageManager.getString("Periodicità.misura.di.prevenzione/protezione")%></legend>
                                                                <table border="0" cellpadding="0" cellspacing="0">
                                                                    <tr>
                                                                        <td align="right">&nbsp;<b><%=ApplicationConfigurator.LanguageManager.getString("Periodicità.(S/N)")%>&nbsp;</b></td>
                                                                        <td>
                                                                               <input type="Checkbox" name="PER_MIS_PET" <%if (PER_MIS_PET.equals("S")) {
                                                                                    out.print("checked");
                                                                                }%>>
                                                                        </td>
                                                                        <td align="right">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Pianificazione.mis.di.prev.")%>&nbsp;</td>
                                                                        <td><input size="5" type="text" name="PNZ_MIS_PET_MES" value="<%=PNZ_MIS_PET_MES%>"></td>
                                                                        <td align="right">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione")%>&nbsp;</td>
                                                                        <td>
                                                                            <s2s:Date id="DAT_PNZ_MIS_PET" name="DAT_PNZ_MIS_PET" value="<%=DAT_PNZ_MIS_PET%>"/>
                                                                        </td>
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
                                <td colspan="4"><div id="dContainer" class="mainTabContainer" style=""></div></td>
                            </tr> 	
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
        <%
            //-------Loading of Tabs--------------------
            if (bean != null) {
                out.print(BuildAuditTab(bean));
                out.print(BuildDocumentiTab(bean));
                out.print(BuildNormativeSentenzeTab(bean));
                out.print(BuildAttivitaSegnalazioneTab(bean));
        %>
        <script>
            //--------BUTTONS description-----------------------
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
            //--------creating tabs------------------------------
            var tabbar = new TabBar("tbr1", document.all["dContainer"]);
            var btnBar = new ButtonPanel("batPanel1", btnParams);
            tabbar.addButtonBar(btnBar);
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Audit")%>", tabbar));
            tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti")%>", tabbar));
            tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Normative/Sentenze")%>", tabbar));
            tabbar.addTab(new Tab("tab4", "<%=ApplicationConfigurator.LanguageManager.getString("Attività.segnalazione")%>", tabbar));

            //------adding tables to tabs------------------------
            tabbar.tabs[0].tabObj.addTable(document.all["AuditHeader"], document.all["Audit"], true);
            tabbar.tabs[1].tabObj.addTable(document.all["DocumentiHeader"], document.all["Documenti"], true);
            tabbar.tabs[2].tabObj.addTable(document.all["NormativeHeader"], document.all["Normative"], true);
            tabbar.tabs[3].tabObj.addTable(document.all["AttSegnHeader"], document.all["AttSegn"], true);
            //----add action parameters to tabs
            tabbar.idParentRecord = <%=Formatter.format(COD_MIS_PET_MAN)%>;
            tabbar.refreshTabUrl = "MIS_PET_MAN_RefreshTabs.jsp";

            tabbar.tabs[0].tabObj.actionParams = {"Feachures": {"dialogWidth": "860px",
                    "dialogHeight": "560px"
                },
                "AddNew": {"url": "../Form_ANA_INR_ADT/ANA_INR_ADT_Form.jsp??ATTACH_URL=Form_MIS_PET_MAN/MIS_PET_MAN_Attach.jsp&ATTACH_SUBJECT=AUDIT_MAN",
                    "buttonIndex": 0,
                    "disabled": false
                },
                "Edit": {"url": "../Form_ANA_INR_ADT/ANA_INR_ADT_Form.jsp??ATTACH_URL=Form_MIS_PET_MAN/MIS_PET_MAN_Attach.jsp&ATTACH_SUBJECT=AUDIT_MAN",
                    "buttonIndex": 1,
                    "disabled": false
                },
                "Delete": {"url": "../Form_MIS_PET_MAN/MIS_PET_MAN_AttachDel.jsp?",
                    "target_element": document.all["ifrmWork"],
                    "buttonIndex": 2,
                    "disabled": false
                },
                "Help":	{"url":"../Form_ANA_INR_ADT/ANA_INR_ADT_Help.jsp",
                    "buttonIndex":3,
                    "disabled": false	
                }
            };

            tabbar.tabs[1].tabObj.actionParams = {"Feachures": {"dialogWidth": "860px",
                    "dialogHeight": "560px"
                },
                "AddNew": {"url": "",
                    "buttonIndex": 0,
                    "disabled": true
                },
                "Edit": {"url": "",
                    "buttonIndex": 1,
                    "disabled": true
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

            tabbar.tabs[2].tabObj.actionParams = {"Feachures": {"dialogWidth": "860px",
                    "dialogHeight": "560px"
                },
                "AddNew": {"url": "",
                    "buttonIndex": 0,
                    "disabled": true
                },
                "Edit": {"url": "",
                    "buttonIndex": 1,
                    "disabled": true
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

            tabbar.tabs[3].tabObj.actionParams = {"Feachures": {"dialogWidth": "860px",
                    "dialogHeight": "560px"
                },
                "AddNew": {"url": "",
                    "buttonIndex": 0,
                    "disabled": true
                },
                "Edit": {"url": "",
                    "buttonIndex": 1,
                    "disabled": true
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
        </script>
        <%}%>
    </body>
</html>
