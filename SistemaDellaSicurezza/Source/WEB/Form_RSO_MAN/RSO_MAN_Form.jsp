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
<%@ page import="com.apconsulting.luna.ejb.AssRischioAttivita.*" %>
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="RSO_MAN_Util.jsp"%>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%
    // *require Fields
    String COD_RSO_MAN = "";            //1
    long lCOD_AZL = 0;			//2
    long lCOD_MAN = 0;			//3
    long lCOD_RSO = 0;			//4

    //----------------
    String DAT_INZ = "";		//5
    String DAT_FIE = "";		//6
    String PRS_RSO = "";		//7
    String NOM_RIL_RSO = "";            //8
    String CLF_RSO = "";		//9
    String PRB_EVE_LES = "";            //10
    String ENT_DAN = "";		//11
    String STM_NUM_RSO = "";            //12
    String DAT_RFC_VLU_RSO = "";        //13
    String STA_RSO = "";		//14
    long lFRQ_RIP_ATT_DAN = 0;          //15
    long lNUM_INC_INF = 0;              //16

    String AziendaName = "";
    String AttLavorativeName = "";
    String RischioName = "";
    String RischioFattoreName = "";

    short sMOD_CLC_RSO = Security.getAziendaModalitaCalcoloRischio();
    IAssRischioAttivita bean = null;
    if (request.getParameter("ID") != null) {
        COD_RSO_MAN = (String) request.getParameter("ID");
        //getting of object
        try {
            IAssRischioAttivitaHome home = (IAssRischioAttivitaHome) PseudoContext.lookup("AssRischioAttivitaBean");
            Long id = new Long(COD_RSO_MAN);
            bean = home.findByPrimaryKey(id);
        } catch (Exception ex) {
            out.print("Error:" + ex.toString());
            return;
        }
        // getting of object variables
        lCOD_RSO = bean.getCOD_RSO();
        lCOD_AZL = bean.getCOD_AZL();
        DAT_INZ = Formatter.format(bean.getDAT_INZ());
        DAT_FIE = Formatter.format(bean.getDAT_FIE());
        PRS_RSO = Formatter.format(bean.getPRS_RSO());
        NOM_RIL_RSO = Formatter.format(bean.getNOM_RIL_RSO());
        CLF_RSO = Formatter.format(bean.getCLF_RSO());
        PRB_EVE_LES = Formatter.format(bean.getPRB_EVE_LES());
        ENT_DAN = Formatter.format(bean.getENT_DAN());
        STM_NUM_RSO = Formatter.format(bean.getSTM_NUM_RSO());
        DAT_RFC_VLU_RSO = Formatter.format(bean.getDAT_RFC_VLU_RSO());
        STA_RSO = Formatter.format(bean.getSTA_RSO());
        lFRQ_RIP_ATT_DAN = bean.getFRQ_RIP_ATT_DAN();
        lNUM_INC_INF = bean.getNUM_INC_INF();
        
        //------ Rischio name --------------------------------------
        IRischioHome rischio_home = (IRischioHome) PseudoContext.lookup("RischioBean");
        IRischio rischio = rischio_home.findByPrimaryKey(new RischioPK(lCOD_AZL, lCOD_RSO));//new Long(lCOD_RSO));
        RischioName = Formatter.format(rischio.getNOM_RSO());
        RischioFattoreName = Formatter.format(rischio.getFattoreRischio());


    }// if request ID
    else {
        lCOD_AZL = Security.getAzienda();
    }
// --- COD_MAN ---
    if (request.getParameter("ID_PARENT") != null) {
        lCOD_MAN = Long.parseLong((String) request.getParameter("ID_PARENT"));
    }
//------ Azienda name ------------------------------------------------
    IAziendaHome azienda_home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
    IAzienda azienda = azienda_home.findByPrimaryKey(new Long(lCOD_AZL));
    AziendaName = Formatter.format(azienda.getRAG_SCL_AZL());
//------ Attivita Lavorative name ------------------------------------
    IAttivitaLavorativeHome attivita_home = (IAttivitaLavorativeHome) PseudoContext.lookup("AttivitaLavorativeBean");
    IAttivitaLavorative attivita = attivita_home.findByPrimaryKey(new AttivitaLavorativePK(lCOD_AZL, lCOD_MAN));
    AttLavorativeName = Formatter.format(attivita.getNOM_MAN());
//--------------------------------------------------------------------
    
      boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);

%>

<html>
    <head><title><%=ApplicationConfigurator.LanguageManager.getString("Associazione.rischi.attivita.lavorative")%></title>
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
    <link rel="stylesheet" href="../_styles/style.css">
    <link rel="stylesheet" href="../_styles/tabs.css">
    <script src="../_scripts/tabs.js"></script>
    <script src="../_scripts/tabbarButtonFunctions.js"></script>
    <script>
        window.dialogWidth="820px";
        <%
            if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_BASE) {
                out.println("window.dialogHeight=\"610px\";");
            } else if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {
                out.println("window.dialogHeight=\"640px\";");                
            }
        %>
    </script>
    <body style="margin:0 0 0 0;">
        <form action="RSO_MAN_Set.jsp?par=add" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <table cellpadding="2" cellspacing="0" border="0" width="100%">
                <tr>
                    <td>
                        <table border="0" cellpadding="2" cellspacing="2" width="100%">
                            <tr>
                                <td align="center" class="title"><%=ApplicationConfigurator.LanguageManager.getString("Associazione.rischi.attivita.lavorative")%></td>
                            </tr>
                            <tr>
                                <td>
                                    <input name="SBM_MODE" type="Hidden" value="<%
                                    if (!COD_RSO_MAN.equals("")) {
                                        out.print("edt");
                                    } else {
                                        out.print("new");
                                    }%>">
                                    <input name="COD_RSO_MAN" type="Hidden" value="<%
                                    if (!COD_RSO_MAN.equals("")) {
                                        out.print(COD_RSO_MAN);
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
                                <tr>
                                    <td>
                                        <table border="0">
                                            <%@ include file="../_include/ToolBar.jsp" %>
                                            <%
                                                ToolBar.bShowPrint = false;
                                            %>
                                            <%=ToolBar.build(2)%>
                                        </table>
                                        <!-- Azienda/AttivitaLavorative -->
                                        <fieldset>
                                            <table border="0" cellpadding="0" cellspacing="1" width="100%">
                                                <tr>
                                                    <td align="right" style="width:130px"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%></b>&nbsp;</td>
                                                    <td><input style="width:99%" readonly type="text" name="RAG_SCL_AZL" value="<%=AziendaName%>">&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa")%></b>&nbsp;</td>
                                                    <td><input style="width:99%" readonly name="NOM_MAN" value="<%=AttLavorativeName%>">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </fieldset>  
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <!-- Rischio -->
                                        <fieldset>
                                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.rischio")%></legend>
                                            <table border="0" cellpadding="0" cellspacing="1" width="100%">
                                                <tr>
                                                    <td align="right" style="width:130px"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome.rischio")%></b>&nbsp;</td>
                                                    <td><input style="width:99%" readonly type="text" name="NOM_RSO" value="<%=RischioName%>">&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio")%></b>&nbsp;</td>
                                                    <td><input style="width:99%" readonly type="text" name="NOM_FAT_RSO" value="<%=RischioFattoreName%>">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%if(!ifMsr){%>
                                        <table border="0" cellpadding="0" cellspacing="1" width="100%">
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Classificazione.rischio")%></b>&nbsp;</td>
                                                <td><input size="30" type="text" name="CLF_RSO" value="<%=CLF_RSO%>" maxlength="20"></td>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Pianificazione.rivalutazione.del.rischio")%>&nbsp;</b></td>
                                                <td align="left" colspan="3"><s2s:Date id="DAT_RFC_VLU_RSO" name="DAT_RFC_VLU_RSO" value="<%=DAT_RFC_VLU_RSO%>" /></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width:130px"><b><%=ApplicationConfigurator.LanguageManager.getString("Nominativo.rilevatore")%></b>&nbsp;</td>
                                                <td colspan="5"><input style="width:99%" type="text" name="NOM_RIL_RSO" maxlength="100" value="<%=NOM_RIL_RSO%>">&nbsp;</td>
                                            </tr>
                                        </table>
                                         <%}%>
                                         <%if (ifMsr) {%>
                                         <table border="0" cellpadding="0" cellspacing="1" width="100%">
                                             <tr>
                                                 <td width="20%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Classificazione.rischio")%></b>&nbsp;</td>
                                                 <td width="40%"colspan="1"><input size="30" type="text" name="CLF_RSO" value="<%=CLF_RSO%>" maxlength="20"></td>
                                                 <td width="40%"colspan="2"/>
                                             </tr>
                                         </table>
                                         <%}%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <fieldset class="stimaRischio">
                                            <legend class="stimaRischio">
                                                <%=ApplicationConfigurator.LanguageManager.getString("Stima.numerica.del.rischio")%>
                                            </legend>
                                            <table border="0" width="100%">                                        
                                                <tr>
                                                    <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Probabilità.evento.lesivo")%></b>&nbsp;</td>
                                                    <td>
                                                        <input tabindex="8" type="text" size="10" maxlength="2"  name="PRB_EVE_LES" 
                                                                value="<%=bean == null ? "" : PRB_EVE_LES%>" 
                                                                onchange="<%=sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED ? "RecalculateExtended()" : "Recalculate()"%>">
                                                    </td>
                                                    <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Entità.danno")%></b>&nbsp;</td>
                                                    <td>
                                                        <input  tabindex="9" type="text" size="10"  maxlength="2"  name="ENT_DAN" 
                                                                value="<%=bean == null ? "" : ENT_DAN%>"
                                                                onchange="<%=sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED ? "RecalculateExtended()" : "Recalculate()"%>">
                                                    </td>
                                                    <% if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {%>
                                                        <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Frequenza.dell'attività.a.rischio")%></b>&nbsp;</td>
                                                        <td>
                                                            <input tabindex="10" type="text" size="10"  maxlength="2"  name="FRQ_RIP_ATT_DAN" value="<%=bean == null ? "" : Formatter.format(lFRQ_RIP_ATT_DAN)%>" onchange="RecalculateExtended()">
                                                        </td>
                                                        <td align="right">
                                                            <b><%=ApplicationConfigurator.LanguageManager.getString("Numero.di.incidenti/infortuni.(negli.ultimi.3.anni)")%></b>&nbsp;
                                                        </td>
                                                        <td>
                                                            <input tabindex="11" type="text" size="10"  maxlength="2"  name="NUM_INC_INF" value="<%=bean == null ? "" : Formatter.format(lNUM_INC_INF)%>" onchange="RecalculateExtended()">
                                                        </td>
                                                    <% }%>
                                                    <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Stima.numerica.del.rischio")%></b>&nbsp;</td>
                                                    <td>
                                                        <input class="stimaRischio" tabindex="12" readonly type="text" size="10" name="STM_NUM_RSO" value="<%=bean == null ? "" : STM_NUM_RSO%>">&nbsp;&nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div id="dContainer" class="mainTabContainer">
                                        </div>
                                    </td>
                                </tr> 
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <%
            //-------Loading of Tabs---------------------------------
            if (bean != null) {
                out.print(BuildMisurePreventiveTab(bean));
                out.print(BuildDocumentiTab(bean));
                out.print(BuildNormativeSentenzeTab(bean));
                // ------------------------------------------------------
        %>
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
            btnParams[3] = {"id":"btnAssociate", 
                "onclick":addRow,
                "action":"Associate"
            };						
            //--------creating tabs--------------------------
            var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
            var btnBar = new ButtonPanel("batPanel1", btnParams);
            tabbar.addButtonBar(btnBar);
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Misure.preventive")%>", tabbar));
                tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti")%>", tabbar));
                    tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Normative/Sentenze")%>", tabbar));
                        
                        //------adding tables to tabs-----------------------
                        tabbar.tabs[0].tabObj.addTable( document.all["MisurePreventiveHeader"],document.all["MisurePreventive"], true);
                        tabbar.tabs[1].tabObj.addTable( document.all["DocumentiHeader"],document.all["Documenti"], true);
                        tabbar.tabs[2].tabObj.addTable( document.all["NormativeSentenzeHeader"],document.all["NormativeSentenze"], true);
                        
                        //---------------------------------------------------------
                        tabbar.idParentRecord = <%=Formatter.format(COD_RSO_MAN)%>;
                        tabbar.refreshTabUrl="RSO_MAN_RefreshTabs.jsp";	
                        //tabbar.DEBUG_TABS_IFRM = true;
                        //----add action parameters to tabs
                        
                        tabbar.tabs[0].tabObj.actionParams ={"Feachures":{"dialogWidth":"810px", 
                            "dialogHeight":"650px"
                        },
                        "AddNew":	{"url":"../Form_MIS_PET_MAN/MIS_PET_MAN_Form.jsp?ATTACH_URL=Form_RSO_MAN/RSO_MAN_Attach.jsp&ATTACH_SUBJECT=MESURE", 
                            "buttonIndex":0,
                            "disabled": true												  								
                        },
                        "Edit":	{"url":"../Form_MIS_PET_MAN/MIS_PET_MAN_Form.jsp?ATTACH_URL=Form_RSO_MAN/RSO_MAN_Attach.jsp&ATTACH_SUBJECT=MESURE",
                            "buttonIndex":1,
                            "disabled": false
                        },
                        "Delete":	{"url":"RSO_MAN_AttachDel.jsp?ATTACH_SUBJECT=MESURE",
                            "target_element":document.all["ifrmWork"],
                            "buttonIndex":2,
                            "disabled": false
                        },
                        "Associate":
                        {"url":"../Form_GEST_MIS_PET/GEST_MIS_PET_Form.jsp?ATTACH_URL=Form_RSO_MAN/RSO_MAN_Attach.jsp&ATTACH_SUBJECT=MESURE",
                            "whidth":"710px",
                            "height":"400px",
                            "buttonIndex":3,
                            "disabled": false
                        }
                    }; 
                    //----------------------------------------------------------------------
                    tabbar.tabs[1].tabObj.actionParams ={"Feachures":{"dialogWidth":"720px", 
                        "dialogHeight":"695px"
                    },
                    "AddNew":	{"url":"", 
                        "buttonIndex":0,
                        "disabled": true
                    },
                    "Edit":	{"url":"",
                        "buttonIndex":1,
                        "disabled": true
                    },		
                    "Delete":	{"url":"",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": true
                    },
                    "Associate":
                    {"url":"",
                        "buttonIndex":3,
                        "disabled": true
                    }
                }; 
                //----------------------------------------------------------------------------------------------
                tabbar.tabs[2].tabObj.actionParams ={"Feachures":{"dialogWidth":"780px", 
                    "dialogHeight":"500px"
                },
                "AddNew":	{"url":"", 
                    "buttonIndex":0,
                    "disabled": true
                },
                "Edit":	{"url":"", 
                    "buttonIndex":1,
                    "disabled": true
                },			  	
                "Delete":	{"url":"",
                    "target_element":document.all["ifrmWork"],
                    "buttonIndex":2,
                    "disabled": true	
                },
                "Associate":
                {"url":"",
                    "buttonIndex":3,
                    "disabled": true
                }		
            };
            //----------------------------------------------------------------------------------------------
        </script>
        <%
            } else {
                if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_BASE) {
                    out.println("<script>window.dialogHeight=\"360px\";</script>");
                } else if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {
                    out.println("<script>window.dialogHeight=\"390px\";</script>");                
                }
            }
            if (request.getParameter("ID") == null) {
                out.println("<script>ToolBar.Save.setEnabled(false);</script>");
            }
        %>
        <script>
            function RecalculateExtended(){
                var FattoreMoltiplicativo = 1 + (document.forms[0].NUM_INC_INF.value - 1) * 0.5;
                var StimaRischio =  document.forms[0].ENT_DAN.value * 
                document.forms[0].FRQ_RIP_ATT_DAN.value * 
                document.forms[0].PRB_EVE_LES.value * 
                FattoreMoltiplicativo;
                SetStimaRischio(StimaRischio);
            }

            function Recalculate(){
                var StimaRischio=(document.forms[0].ENT_DAN.value)*(document.forms[0].PRB_EVE_LES.value);
                SetStimaRischio(StimaRischio);
            }

            function SetStimaRischio(sr){
                if(sr==null || sr=="NaN") x=0;
                document.forms[0].STM_NUM_RSO.value=sr;
            }
            
            function setDAT_FIE(check_box){
                str_id=check_box.id.substr(16);
                //----------------------------------
                date_obj= new Date();
                d=new String( date_obj.getDate() );
                if(d.length==1) d="0"+d;
                m=new String( date_obj.getMonth() );
                if(m.length==1) m="0"+m;
                y=date_obj.getYear();
                //----------------------------------
                str_date=d+"/"+m+"/"+y;
                if(check_box.checked){
                    str_date="";
                    document.all["CHK_PRS_MIS_HID_"+str_id].checked=false;
                }else{
                document.all["CHK_PRS_MIS_HID_"+str_id].checked=true;
            }
            document.all["DAT_FIE_"+str_id].value=str_date;
        }
        //--------------------------------------------------
        </script>
    </body>
</html>
