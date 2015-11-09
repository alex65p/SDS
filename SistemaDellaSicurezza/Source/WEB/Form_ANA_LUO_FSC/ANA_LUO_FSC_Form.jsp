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
            response.setHeader("Cache-Control", "no-cache");    //HTTP 1.1
            response.setHeader("Pragma", "no-cache");           //HTTP 1.0
            response.setDateHeader("Expires", 0);               //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Ala.*" %>
<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="com.apconsulting.luna.ejb.LuogoFisicoRischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.SediAziendali.*" %>
<%@ page import="com.apconsulting.luna.ejb.Immobili.*" %>
<%@ page import="com.apconsulting.luna.ejb.Immobili3lv.*" %>
<%@ page import="com.apconsulting.luna.ejb.Piano.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="ANA_LUO_FSC_Util.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../_include/ToolBar.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
    <head>
        <script type="text/javascript">
            document.write("<title>" + getCompleteMenuPath(SubMenuDistribuzioneTerritorialie,1) + "</title>");
        </script>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script type="text/javascript" src="../_scripts/tabs.js"></script>
        <script type="text/javascript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <script type="text/javascript" src="../_scripts/Alert.js"></script>
        <script type="text/javascript" src="../_scripts/textarea.js"></script>
        <script type="text/javascript" >
            window.dialogWidth="850px";
            window.dialogHeight="600px";
        </script>
    </head>
    <body>
        <%
                    long COD_LUO_FSC = 0;                  	//UID Luoghi Fisici
                    long COD_SIT_AZL = 0;                    	//FK to ana_sit_azl_tab
                    String strNOM_LUO_FSC = "";                 //UNIC Nome Luoghi Fisici
                    long COD_AZL = Security.getAzienda();    	//FK to ana_sit_azl_tab and after FK to ana_azl_tab
                    String strAziendaEntre = "";            	// by COD_AZL (RAG_SCL_AZL field)
                    //-----------------------------
                    long COD_ALA = 0;                       	//UNIC FK to ana_ala_tab
                    long COD_IMO = 0;                        	//UNIC FK to ana_imo_tab
                    long COD_IMM_3LV = 0;
                    long COD_PNO = 0;                        	//UNIC FK to ana_pno_tab
                    String strDES_LUO_FSC = "";                 // Descrisione
                    String strQLF_RSP_LUO_FSC = "";             // Qualifica
                    String strNOM_RSP_LUO_FSC = "";             // Preposto
                    String strIDZ_PSA_ELT_RSP_LUO_FSC = "";    	// E-mail
                    String strFLG_IMP = "";                     // Impianto

                    String SIT_IMM_AZL_readonly = "";
                    String ATTACH_SIT_IMM_AZL = "";
                    
                    boolean LUOGHI_FISICI_3_LIVELLI = 
                            ApplicationConfigurator.isModuleEnabled(MODULES.LUOGHI_FISICI_3_LIVELLI);

                    String ID_PARENT = request.getParameter("ID_PARENT");
                    if (ID_PARENT != null) {
                        if (LUOGHI_FISICI_3_LIVELLI){
                            COD_IMM_3LV = (new Long(ID_PARENT)).longValue();
                        } else {
                            COD_SIT_AZL = (new Long(ID_PARENT)).longValue();
                        }
                        SIT_IMM_AZL_readonly = "disabled";
                        ATTACH_SIT_IMM_AZL = request.getParameter("ATTACH_SUBJECT");
                        // Apro la maschera da quella delle "Sedi" oppure, nel caso
                        // della gestione a 3 livelli dei luoghi fisici, da quella
                        // degli "Immobili"
                        if (ATTACH_SIT_IMM_AZL != null && ATTACH_SIT_IMM_AZL.equals("LUO")) {
                            ToolBar.strSearchUrl = ToolBar.strSearchUrl.replace('&', '|');
                        }
                        // Apro la maschera da quella dei "Fornitori.personale/servizi"
                        if (ATTACH_SIT_IMM_AZL != null && ATTACH_SIT_IMM_AZL.equals("LFISICO")) {
                            SIT_IMM_AZL_readonly = "";
                        }
                        // Apro la maschera da quella delle "Unità Organizzative"
                        if (ATTACH_SIT_IMM_AZL != null && ATTACH_SIT_IMM_AZL.equals("LUO_FSC_UNI")) {
                            SIT_IMM_AZL_readonly = "";
                            COD_SIT_AZL = 0;
                            COD_IMM_3LV = 0;
                        }
                    }

                    IAnagrLuoghiFisici luoghi = null;
                    IAzienda azienda;
                    IAziendaHome AziendaHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");
                    ISitaAziendeHome SitaAziendeHome = (ISitaAziendeHome) PseudoContext.lookup("SitaAziendeBean");
                    IImmobiliHome ImmobiliHome = (IImmobiliHome) PseudoContext.lookup("ImmobiliBean");
                    IImmobili3lvHome Immobili3lvHome = (IImmobili3lvHome) PseudoContext.lookup("Immobili3lvBean");
                    IPianoHome PianoHome = (IPianoHome) PseudoContext.lookup("PianoBean");
                    IAlaHome AlaHome = (IAlaHome) PseudoContext.lookup("AlaBean");
                    if (request.getParameter("ID") != null) {
                        String strCOD_LUO_FSC = request.getParameter("ID");
                        // editing of luoghi
                        IAnagrLuoghiFisiciHome home = (IAnagrLuoghiFisiciHome) PseudoContext.lookup("AnagrLuoghiFisiciBean");
                        try {
                            luoghi = home.findByPrimaryKey(new Long(strCOD_LUO_FSC));
                        } catch (Exception ex) {
                            out.print("<script>Alert.Error.showNotFound(); window.self.close();</script>");
                            return;
                        }
                        // getting of object variables
                        strNOM_LUO_FSC = Formatter.format(luoghi.getNOM_LUO_FSC());
                        COD_LUO_FSC = luoghi.getCOD_LUO_FSC();
                        COD_AZL = luoghi.getCOD_AZL();
                        // Get Aziende/Ente
                        Long azl_id = new Long(COD_AZL);
                        azienda = AziendaHome.findByPrimaryKey(azl_id);
                        strAziendaEntre = azienda.getRAG_SCL_AZL();

                        COD_SIT_AZL = luoghi.getCOD_SIT_AZL();
                        COD_ALA = luoghi.getCOD_ALA();
                        COD_IMO = luoghi.getCOD_IMO();
                        COD_IMM_3LV = luoghi.getCOD_IMM_3LV();
                        COD_PNO = luoghi.getCOD_PNO();

                        strDES_LUO_FSC = luoghi.getDES_LUO_FSC();
                        strQLF_RSP_LUO_FSC = luoghi.getQLF_RSP_LUO_FSC();
                        strNOM_RSP_LUO_FSC = luoghi.getNOM_RSP_LUO_FSC();
                        strIDZ_PSA_ELT_RSP_LUO_FSC = luoghi.getIDZ_PSA_ELT_RSP_LUO_FSC();
                        strFLG_IMP = luoghi.getFLG_IMP();


                    } else {
                        // Get Aziende/Ente
                        Long azl_id = new Long(COD_AZL);
                        azienda = AziendaHome.findByPrimaryKey(azl_id);
                        strAziendaEntre = azienda.getRAG_SCL_AZL();
                    }
        %>

        <!-- form for addind  -->
        <form action="ANA_LUO_FSC_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input type="hidden" name="SBM_MODE" value="<%=(COD_LUO_FSC == 0) ? "new" : "edt"%>">
            <input type="hidden" name="COD_LUO_FSC" value="<%=COD_LUO_FSC%>">
            <table width="100%" border="0">
                <tr>
                    <td valign="top">
                        <table  width="100%">
                            <tr><td class="title">
                                    <script type="text/javascript" >
                                        document.write(getCompleteMenuPathFunction
                                        (SubMenuDistribuzioneTerritorialie,1,<%=request.getParameter("ID")%>));
                                    </script>
                                </td></tr>
                            <tr>
                                <td>
                                    <table border=0 width="100%">
                                        <tr>
                                            <td>
                                                <%
                                                            ToolBar.bCanDelete = (luoghi != null);
                                                            ToolBar.strPrintUrl = "SchedaLuogoFisico.jsp?";
                                                            out.print(ToolBar.build(2));
                                                            if (ApplicationConfigurator.isModuleEnabled(MODULES.PROP_LUO_FIS)
                                                                    && Security.isExtendedMode()
                                                                    && (luoghi == null || luoghi.isMultiple())) {
                                                %>
                                                <script type="text/javascript">
                                                    isExtendedForm=true;
                                                </script>
                                                <%                                                    }
                                                %>
                                            </td>
                                        </tr>
                                    </table>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.luogo.fisico")%></legend>
                                        <table  width="100%" border="0" cellpadding="2" cellspacing="2">
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
                                                <td colspan="5">
                                                    <input tabindex="1" style="width:500px" type="text" value="<%=strAziendaEntre%>" readonly>
                                                    <input type="hidden" id="COD_AZL" name="COD_AZL" value="<%=COD_AZL%>" />
                                                </td>
                                            </tr>
                                            <tr style="display:<%=LUOGHI_FISICI_3_LIVELLI?"block":"none"%>;">
                                                <td  align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Immobile")%>&nbsp;</b></td>
                                                <td colspan="5">
                                                    <%
                                                        if (ID_PARENT != null && ATTACH_SIT_IMM_AZL.equals("LUO")) {
                                                            out.println("<input type=\"hidden\" name=\"COD_IMM_3LV\" value=\"" + COD_IMM_3LV + "\">");
                                                        }
                                                    %>
                                                    <select tabindex="2" name="COD_IMM_3LV" style="width: 100%;" <%=SIT_IMM_AZL_readonly%>>
                                                        <option value=""></option>
                                                        <%=BuildImmobili3lvComboBox(Immobili3lvHome, COD_AZL, COD_IMM_3LV)%>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr style="display:<%=LUOGHI_FISICI_3_LIVELLI?"none":"block"%>;">
                                                <td  align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Sito.aziendale")%>&nbsp;</b></td>
                                                <td colspan="5">
                                                    <%
                                                        if (ID_PARENT != null && ATTACH_SIT_IMM_AZL.equals("LUO")) {
                                                            out.print("<input type=\"hidden\" name=\"COD_SIT_AZL\" value=\"" + COD_SIT_AZL + "\">");
                                                        }
                                                    %>
                                                    <select tabindex="2"name="COD_SIT_AZL" style="width: 720px;" <%=SIT_IMM_AZL_readonly%>>
                                                        <option value=""></option>
                                                        <%=BuildSitoAzlComboBox(SitaAziendeHome, COD_SIT_AZL, COD_AZL)%>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <b><%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%>&nbsp;</b>
                                                </td>
                                                <td colspan="5">
                                                    <input tabindex="3" size="139" type="text" maxlength="100" id="strNOM_LUO_FSC" name="strNOM_LUO_FSC" value="<%=strNOM_LUO_FSC%>">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="display:<%=LUOGHI_FISICI_3_LIVELLI?"none":"block"%>;"><%=ApplicationConfigurator.LanguageManager.getString("Immobile")%>&nbsp;</td>
                                                <td style="display:<%=LUOGHI_FISICI_3_LIVELLI?"none":"block"%>;">
                                                    <select tabindex="4" name="COD_IMO" style="width: 248px;">
                                                        <option value=""></option>
                                                        <%=BuildImmobiliComboBox(ImmobiliHome, COD_IMO)%>
                                                    </select>
                                                </td>
                                                <td align="right">
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Piano")%>&nbsp;
                                                </td>
                                                <td align="left">
                                                    <select tabindex="5"name="COD_PNO" style="width: 180px;">
                                                        <option value=""></option>
                                                        <%=BuildPianoComboBox(PianoHome, COD_PNO)%>
                                                    </select>
                                                </td>
                                                <td  align="right">
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Ala")%>
                                                </td>
                                                <td align="left">
                                                    <select tabindex="6"name="COD_ALA" style="width: 180px;">
                                                        <option value=""></option>
                                                        <%=BuildAlaComboBox(AlaHome, COD_ALA)%>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="top" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                                <td colspan="5">
                                                    <s2s:textarea tabindex="7" name="strDES_LUO_FSC" maxlength="3500" rows="4" cols="100" style="width:720px;"><%=Formatter.format(strDES_LUO_FSC)%></s2s:textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  align="right"><%=ApplicationConfigurator.LanguageManager.getString("Preposto")%>&nbsp;</td>
                                                <td>
                                                    <input tabindex="8"size="48" type="text" maxlength="100" id="strNOM_RSP_LUO_FSC" name="strNOM_RSP_LUO_FSC" value="<%=Formatter.format(strNOM_RSP_LUO_FSC)%>">
                                                    <!--<button type="button">...</button> -->
                                                </td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Qualifica")%>&nbsp;</td>
                                                <td colspan="3">
                                                    <input tabindex="9"size="40" type="text" maxlength="30" id="strQLF_RSP_LUO_FSC" name="strQLF_RSP_LUO_FSC" value="<%=Formatter.format(strQLF_RSP_LUO_FSC)%>">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  align="right" ><%=ApplicationConfigurator.LanguageManager.getString("E-mail")%>&nbsp;</td>
                                                <td><input tabindex="10"size="48" type="text" maxlength="50" id="strIDZ_PSA_ELT_RSP_LUO_FSC" name="strIDZ_PSA_ELT_RSP_LUO_FSC" value="<%=strIDZ_PSA_ELT_RSP_LUO_FSC%>"></td>
                                                <!--
                                                <td  align="right" ><%=ApplicationConfigurator.LanguageManager.getString("Impianto")%>&nbsp;</td>
                                                <td ><input tabindex="11" type="checkbox" class="checkbox" name="FLG_IMP" <%=(strFLG_IMP.equals("S")) ? "checked" : ""%>></td>
                                                -->
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td></tr>
                            <tr>
                                <td><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <%
                    //-------Loading of Tabs--------------------
                    if (luoghi != null) {
        %>
        <script type="text/javascript"  src="../_scripts/index.js"></script>
        <script type="text/javascript" >
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
            var    tabbar = new TabBar("tbr1",document.all["dContainer"]);
            var btnBar = new ButtonPanel("batPanel1", btnParams);
            tabbar.addButtonBar(btnBar);
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Rischi")%>", tabbar));
            tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Infortuni/Incidenti")%>", tabbar));
            tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("D.P.I.")%>", tabbar));
            tabbar.addTab(new Tab("tab4", "<%=ApplicationConfigurator.LanguageManager.getString("Corsi")%>", tabbar));
            tabbar.addTab(new Tab("tab5", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti")%>", tabbar));
            tabbar.addTab(new Tab("tab6", "<%=ApplicationConfigurator.LanguageManager.getString(
                    ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                        ?"Macchine.attrezzature.impianti"
                        :"Macchine/Attrezzature"
                    )%>", tabbar));

            //------adding tables to tabs-----------------------
            tabbar.idParentRecord = <%=COD_LUO_FSC%>;
            tabbar.refreshTabUrl="ANA_LUO_FSC_Tabs.jsp";

            var attachedTabs = new Array();
            attachedTabs[0]=tabbar.tabs[2].tabObj;
            attachedTabs[1]=tabbar.tabs[3].tabObj;
            tabbar.tabs[0].tabObj.attachDependedTab(attachedTabs);
            var attachedTabs2 = new Array();
            attachedTabs2[0]=tabbar.tabs[0].tabObj;
            tabbar.tabs[5].tabObj.attachDependedTab(attachedTabs2);

            tabbar.RefreshAllTabs();
            
            //-----activate first tab--------------------------
            tabbar.tabs[0].center.click();

            //----add action parameters to tabs
            tabbar.tabs[0].tabObj.actionParams ={
                "Feachures":RSO_LUO_FSC_Feachures,
                "AddNew":    {"url":"../Form_RSO_LUO_FSC/RSO_LUO_FSC_Form.jsp",
                    "buttonIndex":0,
                    "disabled": false
                },
                "Edit":    {"url":"../Form_RSO_LUO_FSC/RSO_LUO_FSC_Form.jsp",
                    "buttonIndex":1,
                    "disabled": false
                },
                "Delete":
                    {"url":"../Form_RSO_LUO_FSC/RSO_LUO_FSC_Delete.jsp?LOCAL_MODE=ris",
                    "target_element":document.all["ifrmWork"],
                    "buttonIndex":2,
                    "disabled": false
                },
                "Help":	{"url":"../Form_ANA_RSO/ANA_RSO_Help.jsp",
                    "buttonIndex":3,
                    "disabled": false
                }
            };
            //-------------------------------------------------
            tabbar.tabs[1].tabObj.actionParams ={
                "Feachures":RSO_LUO_FSC_Feachures,
                "AddNew":    {"url":"../Form_RSO_LUO_FSC/RSO_LUO_FSC_Form.jsp",
                    "alert": "",
                    "buttonIndex":0,
                    "disabled": true
                },
                "Edit":    {"url":"../Form_RSO_LUO_FSC/RSO_LUO_FSC_Form.jsp",
                    "alert": "You can delete this record!",
                    "buttonIndex":1,
                    "disabled": true
                },
                "Delete":    {"url":"../Form_RSO_LUO_FSC/RSO_LUO_FSC_Delete.jsp",
                    "target_element":document.all["ifrmWork"],
                    "alert": "Form in construzione!",
                    "buttonIndex":2,
                    "disabled": true
                },
                "Help":	{"url":"../Form_ANA_INO/ANA_INO_Help.jsp",
                    "buttonIndex":3,
                    "disabled": false
                }
            };
            //-------------------------------------------------
            tabbar.tabs[2].tabObj.actionParams ={
                "Feachures":RSO_LUO_FSC_Feachures,
                "AddNew":    {"url":"../Form_RSO_LUO_FSC/RSO_LUO_FSC_Form.jsp",
                    "alert": null,
                    "buttonIndex":0,
                    "disabled": true
                },
                "Edit":    {"url":"../Form_RSO_LUO_FSC/RSO_LUO_FSC_Form.jsp",
                    "alert": null,
                    "buttonIndex":1,
                    "disabled": true
                },
                "Delete":    {"url":"../Form_RSO_LUO_FSC/RSO_LUO_FSC_Delete.jsp",
                    "target_element":document.all["ifrmWork"],
                    "buttonIndex":2,
                    "disabled": true
                },
                "Help":	{"url":"../Form_ANA_MIS_PET/ANA_MIS_PET_Help.jsp",
                    "buttonIndex":3,
                    "disabled": false
                }
            };
            //-------------------------------------------------
            tabbar.tabs[3].tabObj.actionParams ={
                "Feachures":RSO_LUO_FSC_Feachures,
                "AddNew":    {"url":"../Form_RSO_LUO_FSC/RSO_LUO_FSC_Form.jsp",
                    "alert": "",
                    "buttonIndex":0,
                    "disabled": true
                },
                "Edit":    {"url":"../Form_RSO_LUO_FSC/RSO_LUO_FSC_Form.jsp",
                    "alert": null,
                    "buttonIndex":1,
                    "disabled": true
                },
                "Delete":    {"url":"../Form_RSO_LUO_FSC/RSO_LUO_FSC_Delete.jsp",
                    "target_element":document.all["ifrmWork"],
                    "buttonIndex":2,
                    "disabled": true
                },
                "Help":	{"url":"../Form_ANA_PRO_SAN/ANA_PRO_SAN_Help.jsp",
                    "buttonIndex":3,
                    "disabled": false
                }
            };
            //-------------------------------------------------
            tabbar.tabs[4].tabObj.actionParams ={
                "Feachures":ANA_DOC_Feachures,
                "AddNew":    {"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_LUO_FSC/ANA_LUO_FSC_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
                    "buttonIndex":0,
                    "disabled": false
                },
                "Edit":    {"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_LUO_FSC/ANA_LUO_FSC_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
                    "buttonIndex":1,
                    "disabled": false
                },
                "Delete":    {"url":"../Form_ANA_LUO_FSC/ANA_LUO_FSC_Delete.jsp?LOCAL_MODE=doc",
                    "target_element":document.all["ifrmWork"],
                    "buttonIndex":2,
                    "disabled": false
                },
                "Help":	{"url":"../Form_ANA_PRO_SAN/ANA_PRO_SAN_Help.jsp",
                    "buttonIndex":3,
                    "disabled": false
                }
            };
            //-------------------------------------------------
            tabbar.tabs[5].tabObj.actionParams ={
                "Feachures":MAC_OPE_SVO_Feachures,
                "AddNew":    {"url":"../Form_MAC_OPE_SVO/MAC_OPE_SVO_Form.jsp?ATTACH_URL=Form_ANA_LUO_FSC/ANA_LUO_FSC_Attach.jsp&ATTACH_SUBJECT=MACCHINE",
                    "buttonIndex":0,
                    "disabled": false
                },
                "Edit":    {"url":"../Form_MAC_OPE_SVO/MAC_OPE_SVO_Form.jsp?ATTACH_URL=Form_ANA_LUO_FSC/ANA_LUO_FSC_Attach.jsp&ATTACH_SUBJECT=MACCHINE",
                    "buttonIndex":1,
                    "disabled": false
                },
                "Delete":    {"url":"../Form_ANA_LUO_FSC/ANA_LUO_FSC_Delete.jsp?LOCAL_MODE=mac",
                    "target_element":document.all["ifrmWork"],
                    "buttonIndex":2,
                    "disabled": false
                },
                "Help":	{"url":"../Form_ANA_PRO_SAN/ANA_PRO_SAN_Help.jsp",
                    "buttonIndex":3,
                    "disabled": false
                }
            };
            //------------------------------------------------
            tabbar.tabs[0].tabObj.OnActivate = function ()
            {
                tabbar.buttonBar.panel.style.display = '';
            };
            tabbar.tabs[1].tabObj.OnActivate = function ()
            {
                tabbar.buttonBar.panel.style.display = '';
            };
            tabbar.tabs[2].tabObj.OnActivate = function ()
            {
                tabbar.buttonBar.panel.style.display = '';
            };
            tabbar.tabs[3].tabObj.OnActivate = function ()
            {
                tabbar.buttonBar.panel.style.display = '';
            };
            tabbar.tabs[4].tabObj.OnActivate = function ()
            {
                tabbar.buttonBar.panel.style.display = '';
            };
            tabbar.tabs[5].tabObj.OnActivate = function ()
            {
                tabbar.buttonBar.panel.style.display = '';
            };

        </script>
        <%} else {%>
        <script type="text/javascript">
            window.dialogWidth="850px";
            window.dialogHeight="360px";
        </script>
        <%}%>
    </body>
</html>
