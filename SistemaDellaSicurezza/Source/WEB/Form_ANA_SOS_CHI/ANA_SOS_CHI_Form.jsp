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

<%    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AssociativaAgentoChimico.*" %>
<%@ page import="com.apconsulting.luna.ejb.Simbolo.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/ClassificazioneAgentiChimici/ClassificazioneAgentiChimiciBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/ClassificazioneAgentiChimici/ClassificazioneAgentiChimiciBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/StatoFisico/StatoFisicoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/StatoFisico/StatoFisicoBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="ANA_SOS_CHI_Util.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuAgentiChimici, 3) + "</title>");
        </script>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <script>
            window.dialogWidth = "900px";
            window.dialogHeight = "530px";
        </script>

    </head>
    <body>

        <%
            //
            boolean bExtended = false;
            //
            long lCOD_SOS_CHI = 0;
            String strDES_SOS = "";
            String strNOM_COM_SOS = "";
            String strFRS_R = "";
            String strFRS_S = "";
            String strSIM_RIS = "";
            long lCOD_SIM = 0;
            long lCOD_STA_FSC = 0;
            long lCOD_CLF_SOS = 0;
            long lCOD_PTA_FSC = 0;
            String sTIP_RSO = "N";
            //
            IAssociativaAgentoChimico AgentoChimico = null;
            IAssociativaAgentoChimicoHome home = (IAssociativaAgentoChimicoHome) PseudoContext.lookup("AssociativaAgentoChimicoBean");
            IClassificazioneAgentiChimiciHome cHome = (IClassificazioneAgentiChimiciHome) PseudoContext.lookup("ClassificazioneAgentiChimiciBean");
            IStatoFisicoHome sfHome = (IStatoFisicoHome) PseudoContext.lookup("StatoFisicoBean");
            ISimboloHome sHome = (ISimboloHome) PseudoContext.lookup("SimboloBean");
            //
            if (request.getParameter("ID") != null) {
                String strCOD_SOS_CHI = request.getParameter("ID");
                Long SOS_CHI_id = new Long(strCOD_SOS_CHI);
                AgentoChimico = home.findByPrimaryKey(SOS_CHI_id);
                lCOD_SOS_CHI = AgentoChimico.getCOD_SOS_CHI();
                strDES_SOS = AgentoChimico.getDES_SOS();
                strNOM_COM_SOS = AgentoChimico.getNOM_COM_SOS();
                strFRS_R = AgentoChimico.getFRS_R();
                strFRS_S = AgentoChimico.getFRS_S();
                strSIM_RIS = AgentoChimico.getSIM_RIS();
                lCOD_SIM = AgentoChimico.getCOD_SIM();
                lCOD_STA_FSC = AgentoChimico.getCOD_STA_FSC();
                lCOD_CLF_SOS = AgentoChimico.getCOD_CLF_SOS();
                lCOD_PTA_FSC = AgentoChimico.getCOD_PTA_FSC();
                sTIP_RSO = AgentoChimico.getTIP_RSO();
            }
        %>
        <!-- form for addind azienda -->
        <form action="ANA_SOS_CHI_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input type="hidden" name="SBM_MODE" value="<%=(lCOD_SOS_CHI == 0) ? "new" : "edt"%>">
            <input type="hidden" name="COD_SOS_CHI" value="<%=lCOD_SOS_CHI%>">
            <input type="hidden" name="ID_PARENT" value="<%//=request.getParameter("ID_PARENT")%>">
            <table border="0" width='100%'>
                <tr>
                    <td valign="top">
                        <table width='100%'>
                            <tr><td class="title">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                                (SubMenuAgentiChimici, 3,<%=request.getParameter("ID")%>));
                                    </script>
                                </td></tr>
                            <tr>
                                <td>
                                    <table border=0>
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%
                                            ToolBar.bCanDelete = (AgentoChimico != null);
                                            ToolBar.strPrintUrl = "SchedaSostanzaChimica.jsp?";
                                        %>
                                        <%=ToolBar.build(3)%>
                                        <%
                                            if (Security.isExtendedMode()) {
                                                bExtended = true;
                                            }
                                        %>
                                    </table>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.agente.chimico")%></legend>
                                        <table border="0" cellspacing="0" width='100%'>
                                            <tr>
                                                <td align="right" colspan="" valign="top" nowrap><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome.sostanza/preparato")%>&nbsp;</b></td>
                                                <td colspan="3"><input tabindex="1" type="text" size="180" maxlength="200"  name="NOM_COM_SOS" value="<%=Formatter.format(strNOM_COM_SOS)%>" style="width:200px">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" colspan="" valign="top" ><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</b></td>
                                                <td colspan="3"><textarea tabindex="2" rows="2" cols="100" size="200" maxlength="200" name="DES_SOS" style="width:620px"><%=Formatter.format(strDES_SOS)%></textarea>&nbsp;&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Stato.fisico")%>&nbsp;</b></td>
                                                <td ><select tabindex="3" name="COD_STA_FSC" style="width:200px">
                                                        <option value=""></option>
                                                        <%=BuildStatoFisicoComboBox(sfHome, lCOD_STA_FSC)%>
                                                    </select></td>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Classificazione")%>&nbsp;</b></td>
                                                <td ><select tabindex="4" name="COD_CLF_SOS" style="width:220px">
                                                        <option value=""></option>
                                                        <%=BuildClassificazioneComboBox(cHome, lCOD_CLF_SOS)%>
                                                    </select></td>
                                            </tr>
                                            <tr>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Proprietà.chimico-fisiche")%>&nbsp;</td>
                                                <td>
                                                    <select tabindex="5" name="COD_PTA_FSC" style="width:200px">
                                                        <%=BuildProprietaChiFisComboBox(home, lCOD_PTA_FSC)%>
                                                    </select>
                                                </td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Tipologia.rischio.chimico")%>&nbsp;</td>
                                                <td>
                                                    <select tabindex="6" name="TIP_RSO" style="width:220px">
                                                        <%=BuildTipoRischioComboBox(home, sTIP_RSO)%>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione.simbolo")%>&nbsp;</td>
                                                <td ><select tabindex="7" name="COD_SIM" style="width:200px">
                                                        <option></option>
                                                        <%=BuildSimboloComboBox(sHome, lCOD_SIM)%>
                                                    </select></td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Simbolo")%>&nbsp;</td><td width="15"><input tabindex="6" type="text" size="10" maxlength="10"  name="SIM_RIS" value="<%=Formatter.format(strSIM_RIS)%>" style="width:165px"></td>
                                            </tr> 
                                        </table>
                                    </fieldset></td></tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="100%"><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
                </tr> 
            </table>
        </form>
        <!-- /form for addind Dipendente -->

        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>

        <%
        //-------Loading of Tabs--------------------
            if (AgentoChimico != null) {
        %>
        <%//=BuildFrasiRTab(home, lCOD_SOS_CHI)%>
        <%//=BuildFrasiSTab(home, lCOD_SOS_CHI)%>
        <script language="JavaScript" src="../_scripts/index.js"></script>
        <script language="JavaScript">
                //--------BUTTONS description-----------------------
                btnParams = new Array();
                btnParams[0] = {"id": "btnNew",
                    "onclick": addRow,
                    "action": "AddNew"
                };
                btnParams[1] = {"id": "btnEdit",
                    "onclick": editRow,
                    "action": "Edit"
                };
                btnParams[2] = {"id": "btnCancel",
                    "onclick": delRow,
                    "action": "Delete"
                };

                //--------creating tabs--------------------------
                var tabbar = new TabBar("tbr1", document.all["dContainer"]);
                var btnBar = new ButtonPanel("batPanel1", btnParams);
        tabbar.addButtonBar(btnBar);        
        tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Rischi")%>", tabbar));        
        tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Luoghi.fisici")%>", tabbar));        
        tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Frasi.R")%>", tabbar));        
        tabbar.addTab(new Tab("tab4", "<%=ApplicationConfigurator.LanguageManager.getString("Frasi.S")%>", tabbar));        
        tabbar.addTab(new Tab("tab5", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti")%>", tabbar));        
                tabbar.addTab(new Tab("tab6", "<%=ApplicationConfigurator.LanguageManager.getString("Normative/Sentenze")%>", tabbar));

        //------adding tables to tabs-----------------------        
                tabbar.idParentRecord = <%= lCOD_SOS_CHI%>
                tabbar.refreshTabUrl = "ANA_SOS_CHI_Tabs.jsp";
                tabbar.RefreshAllTabs();
            
                tabbar.tabs[0].tabObj.actionParams = {
                    "Feachures": ANA_RSO_Feachures,
                    "AddNew": {"url": "../Form_ANA_RSO/ANA_RSO_Form.jsp?ATTACH_URL=Form_ANA_SOS_CHI/ANA_SOS_CHI_Attach.jsp&ATTACH_SUBJECT=RSO",
                        "buttonIndex": 0
                    },
                    "Delete": {"url": "../Form_ANA_SOS_CHI/ANA_SOS_CHI_Delete.jsp?LOCAL_MODE=RSO<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex": 2,
                "target_element": document.all[        "ifrmWork"],
                        "ExtendedMode": <%= bExtended%>
                    },
                    "Edit": {"url": "../Form_ANA_RSO/ANA_RSO_Form.jsp?ATTACH_URL=Form_ANA_SOS_CHI/ANA_SOS_CHI_Attach.jsp&ATTACH_SUBJECT=RSO",
                        "buttonIndex": 1
                    }
                };
                //-----------------------------------------------------------------------------------									  
                tabbar.tabs[1].tabObj.actionParams = {
                    "Feachures": SOS_CHI_LUO_FSC_Feachures,
                    "AddNew": {"url": "../Form_SOS_CHI_LUO_FSC/SOS_CHI_LUO_FSC_Form.jsp?ATTACH_URL=Form_ANA_SOS_CHI/ANA_SOS_CHI_Attach.jsp&ATTACH_SUBJECT=LUO_FSC",
                        "buttonIndex": 0
                    },
                    "Delete": {"url": "../Form_ANA_SOS_CHI/ANA_SOS_CHI_Delete.jsp?LOCAL_MODE=LUO_FSC",
                        "buttonIndex": 2,
                        "target_element": document.all["ifrmWork"]
                    },
                    "Edit": {"url": "../Form_SOS_CHI_LUO_FSC/SOS_CHI_LUO_FSC_Form.jsp?ATTACH_URL=Form_ANA_SOS_CHI/ANA_SOS_CHI_Attach.jsp&ATTACH_SUBJECT=LUO_FSC",
                        "buttonIndex": 1
                    }
                };
                //-----------------------------------------------------------------------------------									  
                tabbar.tabs[2].tabObj.actionParams =
                        {
                            "Feachures": ANA_FRS_R_Feachures,
                            "AddNew": {"url": "../Form_ANA_FRS_R/ANA_FRS_R_Form.jsp?ATTACH_URL=Form_ANA_SOS_CHI/ANA_SOS_CHI_Attach.jsp&ATTACH_SUBJECT=FRS_R",
                                "buttonIndex": 0
                            },
                            "Delete": {"url": "../Form_ANA_SOS_CHI/ANA_SOS_CHI_Delete.jsp?LOCAL_MODE=FRS_R",
                                "buttonIndex": 2,
                                "target_element": document.all["ifrmWork"]
                            },
                            "Edit": {"url": "../Form_ANA_FRS_R/ANA_FRS_R_Form.jsp?ATTACH_URL=Form_ANA_SOS_CHI/ANA_SOS_CHI_Attach.jsp&ATTACH_SUBJECT=FRS_R",
                                "whidth": "710px",
                                "height": "340px",
                                "buttonIndex": 1
                            }
                        };
                //-----------------------------------------------------------------------------------									  
                tabbar.tabs[3].tabObj.actionParams = {
                    "Feachures": ANA_FRS_S_Feachures,
                    "AddNew": {"url": "../Form_ANA_FRS_S/ANA_FRS_S_Form.jsp?ATTACH_URL=Form_ANA_SOS_CHI/ANA_SOS_CHI_Attach.jsp&ATTACH_SUBJECT=FRS_S",
                        "buttonIndex": 0
                    },
                    "Delete": {"url": "../Form_ANA_SOS_CHI/ANA_SOS_CHI_Delete.jsp?LOCAL_MODE=FRS_S",
                        "buttonIndex": 2,
                        "target_element": document.all["ifrmWork"]
                    },
                    "Edit": {"url": "../Form_ANA_FRS_S/ANA_FRS_S_Form.jsp?ATTACH_URL=Form_ANA_SOS_CHI/ANA_SOS_CHI_Attach.jsp&ATTACH_SUBJECT=FRS_S",
                        "buttonIndex": 1
                    }
                };
                //-----------------------------------------------------------------------------------									  
                tabbar.tabs[4].tabObj.actionParams = {
                    "Feachures": ANA_DOC_Feachures,
                    "AddNew": {"url": "../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_SOS_CHI/ANA_SOS_CHI_Attach.jsp&ATTACH_SUBJECT=DOC",
                        "buttonIndex": 0
                    },
                    "Delete": {"url": "../Form_ANA_SOS_CHI/ANA_SOS_CHI_Delete.jsp?LOCAL_MODE=DOC",
                        "buttonIndex": 2,
                        "target_element": document.all["ifrmWork"]
                    },
                    "Edit": {"url": "../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_SOS_CHI/ANA_SOS_CHI_Attach.jsp&ATTACH_SUBJECT=DOC",
                        "buttonIndex": 1
                    }
                };
                //-----------------------------------------------------------------------------------									  
                tabbar.tabs[5].tabObj.actionParams =
                        {
                            "Feachures": ANA_NOR_SEN_Feachures,
                            "AddNew": {"url": "../Form_ANA_NOR_SEN/ANA_NOR_SEN_Form.jsp?ATTACH_URL=Form_ANA_SOS_CHI/ANA_SOS_CHI_Attach.jsp&ATTACH_SUBJECT=NOR_SEN",
                                "buttonIndex": 0
                            },
                            "Delete": {"url": "../Form_ANA_SOS_CHI/ANA_SOS_CHI_Delete.jsp?LOCAL_MODE=NOR_SEN",
                                "buttonIndex": 2,
                                "target_element": document.all["ifrmWork"]
                            },
                            "Edit": {"url": "../Form_ANA_NOR_SEN/ANA_NOR_SEN_Form.jsp?ATTACH_URL=Form_ANA_SOS_CHI/ANA_SOS_CHI_Attach.jsp&ATTACH_SUBJECT=NOR_SEN",
                                "buttonIndex": 1
                            }
                        };
                //-----activate first tab-------------------------
                tabbar.tabs[0].center.click();
        </script>
        <%} else {%>
        <script>
            window.dialogWidth = "900px";
            window.dialogHeight = "300px";
        </script>
        <%}%>
