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
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.RischioChimico.*" %>
<%@ page import="com.apconsulting.luna.ejb.Fornitore.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%@ include file="ANA_MAN_Util.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%
            // *require Fields*
            long lCOD_AZL = Security.getAzienda();
            String strCOD_MAN = "";   	//1
            String strCOD_AZL = "";   	//2
            String strNOM_MAN = "";		//3
            //   *Not require Fields*
            String strDES_MAN = "";		//4
            String strDES_RSP_COM = ""; //5
            String strCOD_MAN_RPO = ""; //6
            String strNOTE = ""; //6
            double IDX_RSO_CHI = 0;
            long RSO_VAL = 0;

            IAttivitaLavorative attivitaLavorative = null;
            if (request.getParameter("ID") != null) {
                strCOD_MAN = request.getParameter("ID");
                //getting of attivitaLavorative object
                IAttivitaLavorativeHome home = (IAttivitaLavorativeHome) PseudoContext.lookup("AttivitaLavorativeBean");
                Long man_id = new Long(strCOD_MAN);
                attivitaLavorative = home.findByPrimaryKey(new AttivitaLavorativePK(lCOD_AZL, man_id.longValue()));
                //**************************
                // Ricalcolo Rischio Chimico
                IRischioChimicoBean rso = (IRischioChimicoBean) PseudoContext.lookup("RischioChimicoBean");
                java.util.Collection col = attivitaLavorative.getRischioChimico_View();
                java.util.Iterator it = col.iterator();
                while (it.hasNext()) {
                    AttLav_RischioChimico_View rc = (AttLav_RischioChimico_View) it.next();

                    rso.findByPrimaryKey(attivitaLavorative.getCOD_MAN(), rc.COD_OPE_SVO, rc.COD_SOS_CHI);
                    rso.store(); // Ricalcolo e storing su db
                }
                rso.storeIdxMan(attivitaLavorative.getCOD_MAN());
                attivitaLavorative = home.findByPrimaryKey(new AttivitaLavorativePK(lCOD_AZL, man_id.longValue()));
                //********************
                //
                // getting of object variables
                strCOD_AZL = new Long(attivitaLavorative.getCOD_AZL()).toString();
                strNOM_MAN = Formatter.format(attivitaLavorative.getNOM_MAN());
                //---
                strDES_MAN = Formatter.format(attivitaLavorative.getDES_MAN());
                strDES_RSP_COM = Formatter.format(attivitaLavorative.getDES_RSP_COM());
                strNOTE = Formatter.format(attivitaLavorative.getNOTE());
                strCOD_MAN_RPO = new Long(attivitaLavorative.getCOD_MAN_RPO()).toString();
                IDX_RSO_CHI = attivitaLavorative.getIDX_RSO_CHI();
                RSO_VAL = attivitaLavorative.getRSO_VAL();
            } else {
                strCOD_AZL = new Long(Security.getAzienda()).toString();
            }
//
            boolean bExtended = false;
%>

<html>
    <head>
        <script type="text/javascript">
            document.write("<title>" + getCompleteMenuPath(SubMenuAttivitaLavorative,0) + "</title>");
        </script>
        <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script type="text/javascript" src="../_scripts/tabs.js"></script>
        <script type="text/javascript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <script language="JavaScript" src="../_scripts/textarea.js"></script>
    </head>
    <body style="margin:0 0 0 0;">
        <script type="text/javascript">
            window.dialogWidth="820px";
            window.dialogHeight="<%=ApplicationConfigurator.isModuleEnabled(MODULES.AGE_CHI)?"630":"580"%>px";

            function CaricaDbRischio(){
                window.showModalDialog("../Form_CRM_ANA_MAN/CRM_ANA_MAN_Form.jsp", 0, "status:no;help:no;scroll:no;");
            }
            function CaricaRpRischio()
            {
                nom=document.all['NOM_MAN'].value;
                azl=document.all['COD_AZL'].value;
                document.all['ifrmWork'].src="ANA_MAN_Repository.jsp?COD_AZL="+azl+"&NOM_MAN="+nom;
            }
        </script>

        <form action="ANA_MAN_Set.jsp?par=add" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr style='height:10px;'>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td class="title">
                        <script type="text/javascript">
                            document.write(getCompleteMenuPathFunction
                            (SubMenuAttivitaLavorative,0,<%=request.getParameter("ID")%>));
                        </script>
                    </td>
                </tr>
                <input name="SBM_MODE" type="Hidden" value="<%if (strCOD_MAN.equals("")) {
                                out.print("new");
                            } else {
                                out.print("edt");
                            }%>">
                <input name="COD_MAN" type="Hidden" value="<%=strCOD_MAN%>">
                <input type="hidden" name="COD_AZL" value="<%=strCOD_AZL%>">
                <input type="hidden" name="COD_MAN_RPO" value="<%=strCOD_MAN_RPO%>">
                <tr>
                    <td>
                        <table width="100%">
                            <%@ include file="../_include/ToolBar.jsp" %>
                            <%
                                        ToolBar.bCanPrint = (attivitaLavorative != null);
                                        ToolBar.bAlwaysShowPrint = true;
                                        ToolBar.bShowDetail = true;
                                        ToolBar.bCanDetail = (attivitaLavorative != null);
                            %>
                            <%=ToolBar.build(5)%>
                        </table>
                        <!-- ############################################################################################## -->
                        <%
                                    if (Security.isExtendedMode() && (attivitaLavorative == null || attivitaLavorative.isMultiple())) {
                                        bExtended = true;
                        %><script type="text/javascript">isExtendedForm=true;</script><%
                                    }
                        %>
                        <script type="text/javascript">
                            function PrintHandler(){
                                var str=showModalDialog("../Form_REP_MAN/REP_MAN_Form.jsp", null, "dialogHeight:23; dialogWidth:20;help:no;resizable:yes;status:no;scroll:no;");
                                if (str==null || str=="CANCEL") return;
                                ToolBar.openReport("SchedaAttivitaLavorativa.jsp?"+str);
                            }
                            ToolBar.Print.OnClick=PrintHandler;
                        </script>
                        <!-- ############################################################################################## -->

                        <table width="100%" border="0">
                            <tr>
                                <td>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.attività.lavorativa")%></legend><br>
                                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td align="right"> <b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%></b>&nbsp;</td>
                                                <td colspan="3"><input tabindex="1" type="text" name="NOM_MAN" style="width: 99%;" maxlength="100" value="<%=strNOM_MAN%>"></td>
                                            </tr>
                                            <tr>
                                                <td valign="top" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                                <td colspan="3"><s2s:textarea tabindex="2" rows="5" cols="90" maxlength="3500" style="width:99%"  name="DES_MAN"><%=strDES_MAN%></s2s:textarea></td>
                                            </tr>
                                            <tr>
                                                <td valign="top" align="right" width="150px;">
                                                    <%=ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_SDP)
                                                                ?ApplicationConfigurator.LanguageManager.getString("Gruppi.omogenei.di.rferimento")
                                                                :ApplicationConfigurator.LanguageManager.getString("Descrizione.responsabilità.e.competenze")%>&nbsp;
                                                </td>
                                                <td colspan="3"><textarea tabindex="3" rows="5" cols="90" style="width:99%" name="DES_RSP_COM"><%=strDES_RSP_COM%></textarea></td>
                                            </tr>

                                            <%
                                                        if (attivitaLavorative != null) {
                                            %>
                                            <tr>
                                                <td  align="right"><%=ApplicationConfigurator.LanguageManager.getString("Indice.rischio.chimico")%>&nbsp;</td>
                                                <td width="10%">
                                                    <%if(ApplicationConfigurator.isModuleEnabled(MODULES.AGE_CHI) == true){%>
                                                    <input size="40" type="hidden" tabindex="4"  readonly name="IDX_RSO_CHI" value="<%=IDX_RSO_CHI + " (" + attivitaLavorative.getDescRischio(IDX_RSO_CHI) + ")"%>">
                                                    <%}else{%>
                                                    <%}%>
                                                    <select name="RSO_VAL" tabindex="5">
                                                        <option value="0"></option>
                                                        <option value="1" <%=(RSO_VAL == 1 ? " selected " : "")%>><%=ApplicationConfigurator.LanguageManager.getString("Moderato")%></option>
                                                        <option value="2" <%=(RSO_VAL == 2 ? " selected " : "")%>><%=ApplicationConfigurator.LanguageManager.getString("Non.moderato")%></option>
                                                    </select>
                                                    <%if(ApplicationConfigurator.isModuleEnabled(MODULES.AGE_CHI) == true){%>
                                                <td  align="right" width="10%"><%=ApplicationConfigurator.LanguageManager.getString("Note")%>&nbsp;</td>
                                                <td colspan=""><textarea tabindex="3" rows="5" cols="90" style="width:99%" name="NOTE"><%=strNOTE%></textarea></td>
<%}else{%>
                  <td ><input size="40" type="text" tabindex="4"  readonly name="IDX_RSO_CHI" value="<%=IDX_RSO_CHI + " (" + attivitaLavorative.getDescRischio(IDX_RSO_CHI) + ")"%>"></td>
                                                <td colspan=""></td>

                                            <%}%>
                                            </tr>
                                            <%
                                                        } else {
                                                            out.println("<input type=hidden name='RSO_VAL' value='0'>");
                                                        }
                                            %>

                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="3"><div  id="dContainer" class="mainTabContainer" style="width:100%;"></div></td>
                </tr>
            </table>
        </form>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>

        <%
                    //-------Loading of Tabs--------------------
                    if (attivitaLavorative != null) {
                        out.print(BuildOperazioniSvolteTab(attivitaLavorative));
                        out.print(BuildRischiTab(attivitaLavorative, lCOD_AZL));
                        if (ApplicationConfigurator.isModuleEnabled(MODULES.AGE_CHI)){
                           out.print(BuildAgentiChimiciTab(attivitaLavorative));
                        }
                        out.print(BuildCorsiTab(attivitaLavorative));
                        out.print(BuildProtocoliSanitariTab(attivitaLavorative));
                        out.print(BuildDPITab(attivitaLavorative));
                        if (!ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_MSR)) {
                            out.print(BuildRischioChimicoTab(attivitaLavorative));
                        }
                        if (ApplicationConfigurator.isModuleEnabled(MODULES.ATT_LAV_MAC)) {
                            out.print(BuildMacchinaTab(attivitaLavorative));
                        }
                        if (ApplicationConfigurator.isModuleEnabled(MODULES.ATT_LAV_DOC)){
                            out.print(BuildDocumentiTab(attivitaLavorative));
                        }
                    // -----------------------------------------
        %>
        <script type="text/javascript">
            MOD_DVR_MSR = <%=ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_MSR)%>
            ATT_LAV_DOC = <%=ApplicationConfigurator.isModuleEnabled(MODULES.ATT_LAV_DOC)%>
            CORSI_4_ATT_LAV = <%=ApplicationConfigurator.isModuleEnabled(MODULES.CORSI_4_ATT_LAV)%>
            PRO_SAN_4_ATT_LAV = <%=ApplicationConfigurator.isModuleEnabled(MODULES.PRO_SAN_4_ATT_LAV)%>
            DPI_4_ATT_LAV = <%=ApplicationConfigurator.isModuleEnabled(MODULES.DPI_4_ATT_LAV)%>
            ATT_LAV_MAC = <%=ApplicationConfigurator.isModuleEnabled(MODULES.ATT_LAV_MAC)%>
            AGE_CHI = <%=ApplicationConfigurator.isModuleEnabled(MODULES.AGE_CHI)%>

            ToolBar.Detail.OnClick = showDetails;
            function showDetails()        {
                var str = window.showModalDialog("../Form_GEST_FAT_RSO_MAN/GEST_FAT_RSO_MAN_Form.jsp?ID_PARENT=<%= strCOD_MAN%>", null, "dialogHeight:200px; dialogWidth:45;help:no;resizable:no;status:no;scroll:no;");
            }
            //-------- Buttons description -----------------------
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
            btnParams[3] = {"id":"btnAssociate",
                "onclick":addRow,
                "action":"Associate"
            };
            //-------- Creating tabs --------------------------
            var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
            var btnBar = new ButtonPanel("batPanel1", btnParams);
            tabbar.addButtonBar(btnBar);
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Operazioni.svolte")%>", tabbar));
            tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Rischi")%>", tabbar));
            if (AGE_CHI){
                tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Agenti.chimici")%>", tabbar));
            }
            tabbar.addTab(new Tab("tab4", "<%=ApplicationConfigurator.LanguageManager.getString("Corsi")%>", tabbar));
            tabbar.addTab(new Tab("tab5", "<%=ApplicationConfigurator.LanguageManager.getString("Protocolli.sanitari")%>", tabbar));
            tabbar.addTab(new Tab("tab6", "<%=ApplicationConfigurator.LanguageManager.getString("D.P.I.")%>", tabbar));
            if (!MOD_DVR_MSR){
                tabbar.addTab(new Tab("tab7", "<%=ApplicationConfigurator.LanguageManager.getString("Rischi.chimici")%>", tabbar));
            }
            if (ATT_LAV_MAC){
                tabbar.addTab(new Tab("tab8", "<%=ApplicationConfigurator.LanguageManager.getString(
                                    ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                        ?"Macchine.attrezzature.impianti"
                                        :"Macchine/Attrezzature"
                                    )%>", tabbar));
            }
            if (ATT_LAV_DOC){
                tabbar.addTab(new Tab("tab9", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti")%>", tabbar));
            }
	
            //------adding tables to tabs-----------------------
            tabIndex = 1; var attachedTabs1 = new Array();
            tabbar.tabs[0].tabObj.addTable( document.all["OperazioniSvolteHeader"],document.all["OperazioniSvolte"], true);
            tabbar.tabs[1].tabObj.addTable( document.all["RischiHeader"],document.all["Rischi"], true);
            if (AGE_CHI){
                tabbar.tabs[++tabIndex].tabObj.addTable( document.all["AgentiChimiciHeader"], document.all["AgentiChimici"], true);
            }
            tabbar.tabs[++tabIndex].tabObj.addTable( document.all["CorsiHeader"],document.all["Corsi"], true);
            attachedTabs1[0] = tabbar.tabs[tabIndex].tabObj;
            tabbar.tabs[++tabIndex].tabObj.addTable( document.all["ProtocoliSanitariHeader"],document.all["ProtocoliSanitari"], true);
            attachedTabs1[1] = tabbar.tabs[tabIndex].tabObj;
            tabbar.tabs[++tabIndex].tabObj.addTable( document.all["DPIHeader"],document.all["DPI"], true);
            attachedTabs1[2] = tabbar.tabs[tabIndex].tabObj;
            if (!MOD_DVR_MSR){
                tabbar.tabs[++tabIndex].tabObj.addTable( document.all["RischioChimicoHeader"], document.all["RischioChimico"], true);
                attachedTabs1[3] = tabbar.tabs[tabIndex].tabObj; // Rischio Chimico
            }
            if (ATT_LAV_MAC){
                //tabbar.tabs[++tabIndex].tabObj.addTable( document.all["DocumentiHeader"], document.all["Documenti"], true);
                tabbar.tabs[++tabIndex].tabObj.addTable( document.all["MacchinaHeader1"], document.all["Macchina1"], true);
            }
            if (ATT_LAV_DOC){
                tabbar.tabs[++tabIndex].tabObj.addTable( document.all["DocumentiHeader"], document.all["Documenti"], true);
            }

            //-----activate first tab--------------------------
            //---------------------------------------------------------
            tabbar.idParentRecord = <%=Formatter.format(strCOD_MAN)%>;
            tabbar.refreshTabUrl="ANA_MAN_RefreshTabs.jsp";
            var attachedTabs = new Array();
            attachedTabs[0]=tabbar.tabs[1].tabObj;
            tabbar.tabs[0].tabObj.attachDependedTab(attachedTabs);
            //-------
            //var attachedTabs1 = new Array();
            //attachedTabs1[0] = tabbar.tabs[2].tabObj;
            //attachedTabs1[1] = tabbar.tabs[3].tabObj;
            //attachedTabs1[2] = tabbar.tabs[4].tabObj;
            //if (!MOD_DVR_MSR){
            //    attachedTabs1[3] = tabbar.tabs[5].tabObj; // Rischio Chimico
            //}

            tabbar.tabs[1].tabObj.attachDependedTab(attachedTabs1);
            //----add action parameters to tabs
            //tabbar.DEBUG_TABS_IFRM = true;

            // OPERAZIONI SVOLTE
            tabbar.tabs[0].tabObj.actionParams ={"Feachures":ANA_OPE_SVO_Feachures,
                "AddNew":	{"url":"../Form_ANA_OPE_SVO/ANA_OPE_SVO_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=OPERAZIONE<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                    "buttonIndex":0,
                    "disabled": false
                },
                "Edit":	{"url":"../Form_ANA_OPE_SVO/ANA_OPE_SVO_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=OPERAZIONE",
                    "buttonIndex":1,
                    "disabled":         false
                },
                "Delete":	{"url":"ANA_MAN_AttachDel.jsp?ATTACH_SUBJECT=OPERAZIONE<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                    "target_element":document.all["ifrmWork"],
                    "buttonIndex":2,
                    "disabled": false,
                    "ExtendedMode": <%=bExtended%>
                },
                "Associate":
                    {"url":"../Form_GEST_RSO_MAN/GEST_RSO_MAN_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=OPERAZIONE",
                    "buttonIndex":3,
                    "disabled": true
                }
            };

            // RISCHI
            tabbar.tabs[1].tabObj.actionParams ={"Feachures":{"dialogWidth":"810px",
                    "dialogHeight":"550px"
                },
                "AddNew":	{"url":"../Form_RSO_MAN/RSO_MAN_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=RISC",
                    "buttonIndex":0,
                    "disabled": true
                },
                "Edit":	{"url":"../Form_RSO_MAN/RSO_MAN_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=RISC",
                    "buttonIndex":1,
                    "disabled": false
                },
                "Delete":	{"url":"ANA_MAN_AttachDel.jsp?ATTACH_SUBJECT=RISC",
                    "target_element":document.all["ifrmWork"],
                    "buttonIndex":2,
                    "disabled": false
                },
                "Associate":
                    {"url":"../Form_GEST_RSO_MAN/GEST_RSO_MAN_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=RISC",
                    "whidth":"710px",
                    "height":"400px",
                    "buttonIndex":3,
                    "disabled": false
                }
            };

            tabIndex = 1;

            if (AGE_CHI){
                tabbar.tabs[++tabIndex].tabObj.actionParams ={
                    "Feachures":ANA_SOS_CHI_Feachures,
                    "AddNew":	{"url":"../Form_ANA_SOS_CHI/ANA_SOS_CHI_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=AGENTECHIMICO",
                        "buttonIndex":0,
                        "disabled": false
                    },
                    "Edit":	{"url":"../Form_ANA_SOS_CHI/ANA_SOS_CHI_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=AGENTECHIMICO",
                        "buttonIndex":1,
                        "disabled": false
                    },
                    "Delete":{
                        "url":"ANA_MAN_AttachDel.jsp?ATTACH_SUBJECT=AGENTECHIMICO",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false
                    },
                    "Associate":{"url":"", "buttonIndex":3, "disabled": true }
                };
            }

            // CORSI
            if (CORSI_4_ATT_LAV){
                tabbar.tabs[++tabIndex].tabObj.actionParams ={"Feachures":{"dialogWidth":"710px",
                        "dialogHeight":"400px"
                    },
                    "AddNew":	{"url":"../Form_ANA_COR/ANA_COR_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=CORSO_EXTENDED<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":0,
                        "disabled": false
                    },
                    "Edit":	{"url":"../Form_ANA_COR/ANA_COR_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=CORSO_EXTENDED",
                        "buttonIndex":1,
                        "disabled": false
                    },
                    "Delete":	{"url":"ANA_MAN_AttachDel.jsp?ATTACH_SUBJECT=CORSO_EXTENDED",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false,
                        "ExtendedMode": <%=bExtended%>
                    },
                    "Associate":
                        {"url":"../Form_GEST_RSO_MAN/GEST_RSO_MAN_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=CORSO",
                        "buttonIndex":3,
                        "disabled": true
                    }
                };
            } else {
                tabbar.tabs[++tabIndex].tabObj.actionParams ={"Feachures":{"dialogWidth":"710px",
                        "dialogHeight":"400px"
                    },
                    "AddNew":	{"url":"../Form_ANA_MAN_COR/ANA_MAN_COR_Form.jsp",
                        "buttonIndex":0,
                        "disabled": true
                    },
                    "Edit":	{"url":"../Form_ANA_MAN_COR/ANA_MAN_COR_Form.jsp",
                        "buttonIndex":1,
                        "disabled": true
                    },
                    "Delete":	{"url":"ANA_MAN_AttachDel.jsp?ATTACH_SUBJECT=CORSO",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false
                    },
                    "Associate":
                        {"url":"../Form_GEST_RSO_MAN/GEST_RSO_MAN_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=CORSO",
                        "buttonIndex":3,
                        "disabled": false
                    }
                };
            }
            
            // PROTOCOLLI SANITARI
            if (PRO_SAN_4_ATT_LAV){
                tabbar.tabs[++tabIndex].tabObj.actionParams ={"Feachures":{"dialogWidth":"710px",
                        "dialogHeight":"400px"
                    },
                    "AddNew":	{"url":"../Form_ANA_PRO_SAN/ANA_PRO_SAN_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=PROTOCOLLO_EXTENDED<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":0,
                        "disabled": false
                    },
                    "Edit":	{"url":"../Form_ANA_PRO_SAN/ANA_PRO_SAN_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=PROTOCOLLO_EXTENDED",
                        "buttonIndex":1,
                        "disabled": false
                    },
                    "Delete":	{"url":"ANA_MAN_AttachDel.jsp?ATTACH_SUBJECT=PROTOCOLLO_EXTENDED",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false,
                        "ExtendedMode": <%=bExtended%>
                    },
                    "Associate":
                        {"url":"../Form_GEST_RSO_MAN/GEST_RSO_MAN_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=PROTOCOLO",
                        "buttonIndex":3,
                        "disabled": true
                    }
                };
            } else {
                tabbar.tabs[++tabIndex].tabObj.actionParams ={"Feachures":{"dialogWidth":"710px",
                        "dialogHeight":"400px"
                    },
                    "AddNew":	{"url":"../Form_ANA_MAN_SAN/ANA_MAN_SAN_Form.jsp",
                        "buttonIndex":0,
                        "disabled": true
                    },
                    "Edit":	{"url":"../Form_ANA_MAN_SAN/ANA_MAN_SAN_Form.jsp",
                        "buttonIndex":1,
                        "disabled": true
                    },
                    "Delete":	{"url":"ANA_MAN_AttachDel.jsp?ATTACH_SUBJECT=PROTOCOLO",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false
                    },
                    "Associate":
                        {"url":"../Form_GEST_RSO_MAN/GEST_RSO_MAN_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=PROTOCOLO",
                        "buttonIndex":3,
                        "disabled": false
                    }
                };
            }

            // D.P.I.
            if (DPI_4_ATT_LAV){
                tabbar.tabs[++tabIndex].tabObj.actionParams ={"Feachures":{"dialogWidth":"710px",
                        "dialogHeight":"400px"
                    },
                    "AddNew":	{"url":"../Form_TPL_DPI/TPL_DPI_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=DPI_EXTENDED<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":0,
                        "disabled": false
                    },
                    "Edit":	{"url":"../Form_TPL_DPI/TPL_DPI_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=DPI_EXTENDED",
                        "buttonIndex":1,
                        "disabled": false
                    },
                    "Delete":	{"url":"ANA_MAN_AttachDel.jsp?ATTACH_SUBJECT=DPI_EXTENDED",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false,
                        "ExtendedMode": <%=bExtended%>
                    },
                    "Associate":{"url":"../Form_GEST_RSO_MAN/GEST_RSO_MAN_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=DPI",
                        "buttonIndex":3,
                        "disabled": true
                    }
                };
            } else {
                tabbar.tabs[++tabIndex].tabObj.actionParams ={"Feachures":{"dialogWidth":"710px",
                        "dialogHeight":"400px"
                    },
                    "AddNew":	{"url":"../Form_ANA_MAN_DPI/ANA_MAN_DPI_Form.jsp",
                        "buttonIndex":0,
                        "disabled": true
                    },
                    "Edit":	{"url":"../Form_ANA_MAN_SAN/ANA_MAN_DPI_Form.jsp",
                        "buttonIndex":1,
                        "disabled": true
                    },
                    "Delete":	{"url":"ANA_MAN_AttachDel.jsp?ATTACH_SUBJECT=DPI",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false
                    },
                    "Associate":{"url":"../Form_GEST_RSO_MAN/GEST_RSO_MAN_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=DPI",
                        "buttonIndex":3,
                        "disabled": false
                    }
                };
            }
            
            // RISCHIO CHIMICO
            if (!MOD_DVR_MSR){
                tabbar.tabs[++tabIndex].tabObj.actionParams ={"Feachures":{"dialogWidth":"500px", "dialogHeight":"220px"},
                    "AddNew":	{"url":"",
                        "width":"300px",
                        "height":"300px",
                        "buttonIndex":0,
                        "disabled": true
                    },
                    "Edit":	{"url":"../Form_OPE_SVO_SOS_CHI/OPE_SVO_SOS_CHI_Form.jsp",
                        "whidth":"450px",
                        "height":"300px",
                        "buttonIndex":1,
                        "disabled": false
                    },
                    "Delete":	{"url":"",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": true
                    },
                    "Associate":{"url":"", "buttonIndex":3, "disabled": true }
                };
            }

            // MACCHINE
            if (ATT_LAV_MAC){
                tabbar.tabs[++tabIndex].tabObj.actionParams ={
                    "Feachures":ANA_MAC_Feachures,
                    "AddNew":{"url":"../Form_ANA_MAC/ANA_MAC_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=MACCHINA",
                        "buttonIndex":0,                                         
                        "disabled": false
                    },
                    "Edit":	{"url":"../Form_ANA_MAC/ANA_MAC_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=MACCHINA",
                        "buttonIndex":1,
                        "disabled": false
                    },
                    "Delete":	{"url":"ANA_MAN_AttachDel.jsp?ATTACH_SUBJECT=MACCHINA",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false
                    }
                };
            }

            // DOCUMENTI
            if (ATT_LAV_DOC){
                tabbar.tabs[++tabIndex].tabObj.actionParams ={
                    "Feachures":ANA_DOC_Feachures,
                    "AddNew":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=DOCUMENTO",
                        "buttonIndex":0
                    },
                    "Edit":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_MAN/ANA_MAN_Attach.jsp&ATTACH_SUBJECT=DOCUMENTO",
                        "buttonIndex":1
                    },
                    "Delete":{
                        "url":"ANA_MAN_AttachDel.jsp?ATTACH_SUBJECT=DOCUMENTO",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2
                    },
                    "Associate":{"url":"", "buttonIndex":3, "disabled": true }
                };
            }
        </script>
        <%} else {%>
        <script type="text/javascript">
            window.dialogHeight="315px";
        </script>
        <%}%>
    </body>
</html>
