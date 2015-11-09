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
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.RapportiniSegnalazione.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<%@ include file="ANA_SGZ_Utils.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuVerificheSPP,2) + "</title>");
        </script>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <script src="../_scripts/Alert.js"></script>

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

        <script language="JavaScript" src="../_scripts/textarea.js"></script>
        <script type="text/javascript" src="../_scripts/ajax.js"></script>
        <script language="JavaScript" src="ANA_SGZ.js"></script>
    </head>
    <%
        boolean SEG_REG_MON =
                ApplicationConfigurator.isModuleEnabled(MODULES.SEG_REG_MON);
    %>
    <script>
        window.dialogWidth="810px";
        window.dialogHeight = "<%=SEG_REG_MON ? "660" : "635"%>px";
    </script>
    <body>
        <script type="text/javascript">
            <!--
            function getLavoratoriList(){
                var obj=new Object();
                var url="Form_ANA_DPD/ANA_DPD_View.jsp";
                if(showSearch(url, obj, "dialogHeight:30; dialogWidth:500;help:no;resizable:yes;status:yes;scroll:no;")=="OK"){
                    document.all["ifrmWork"].src="ANA_SGZ_Lavoratore.jsp?ID="+obj.ID;		
                }
            }
            // -->
        </script>
        <%
            long lCOD_SGZ = 0;
            String strDES_SGZ = "";
            String dtDAT_SGZ = "";
            long lNUM_SGZ = -1;
            long lVER_SGZ = -1;
            String strTIT_SGZ = "";
            String strSTA_SGZ = "";
            String strURG_SGZ = "S";
            String strDES_ATI_SGZ = "";
            String strSTA_FIE_SGZ = "";
            String dtDAT_FIE = "";
            String strNOM_RIL_SGZ = "";
            long lCOD_IMM = 0;
            long lCOD_LUO_FSC = 0;
            long lCOD_DPD = 0;
            String strNOM_DPD = " ";
            String strCOG_DPD = " ";
            String strMTR_DPD = " ";
            long lCOD_AZL = Security.getAzienda();
            String strCOD_AZL = "";

            IRapportiniSegnalazione bean = null;
            IDipendente dipendente;
            IDipendenteHome DipendenteHome = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
            IAzienda azienda = null;
            IAziendaHome AziendaHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");

            if (request.getParameter("ID") != null) {
                String strCOD_SGZ = request.getParameter("ID");
                // editing of bean
                IRapportiniSegnalazioneHome home = (IRapportiniSegnalazioneHome) PseudoContext.lookup("RapportiniSegnalazioneBean");
                try {
                    bean = home.findByPrimaryKey(new Long(strCOD_SGZ));
                } catch (Exception ex) {

                    return;
                }
                lCOD_SGZ = bean.getCOD_SGZ();
                strDES_SGZ = Formatter.format(bean.getDES_SGZ());
                dtDAT_SGZ = Formatter.format(bean.getDAT_SGZ());
                lNUM_SGZ = bean.getNUM_SGZ();
                lVER_SGZ = bean.getVER_SGZ();
                strTIT_SGZ = Formatter.format(bean.getTIT_SGZ());
                strSTA_SGZ = Formatter.format(bean.getSTA_SGZ());
                strURG_SGZ = Formatter.format(bean.getURG_SGZ());
                strDES_ATI_SGZ = Formatter.format(bean.getDES_ATI_SGZ());
                strSTA_FIE_SGZ = Formatter.format(bean.getSTA_FIE_SGZ());
                dtDAT_FIE = Formatter.format(bean.getDAT_FIE());
                strNOM_RIL_SGZ = Formatter.format(bean.getNOM_RIL_SGZ());
                lCOD_IMM = bean.getCOD_IMM();
                lCOD_LUO_FSC = bean.getCOD_LUO_FSC();
                lCOD_DPD = bean.getCOD_DPD();
                // Get Matricola from Dipendente
                dipendente = DipendenteHome.findByPrimaryKey(new Long(lCOD_DPD));
                strNOM_DPD = Formatter.format(dipendente.getNOM_DPD());
                strCOG_DPD = Formatter.format(dipendente.getCOG_DPD());
                strMTR_DPD = Formatter.format(dipendente.getMTR_DPD());
                lCOD_AZL = bean.getCOD_AZL();
                // Get Aziende/Ente
                azienda = AziendaHome.findByPrimaryKey(new Long(lCOD_AZL));
                strCOD_AZL = Formatter.format(azienda.getRAG_SCL_AZL());
            } else {
                // Get Aziende/Ente
                azienda = AziendaHome.findByPrimaryKey(new Long(lCOD_AZL));
                strCOD_AZL = Formatter.format(azienda.getRAG_SCL_AZL());
            }

        %>
        <!-- form for addind  Rapportini di Segnalazione-->
        <form action="ANA_SGZ_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value="<%=(lCOD_SGZ == 0) ? "new" : "edt"%>">
            <input type="hidden" name="COD_SGZ" value="<%=lCOD_SGZ%>">
            <table width="100%" border="0">
                <tr>
                    <td valign="top">
                        <table  width="100%" border="0">
                            <tr>
                                <td class="title">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                        (SubMenuVerificheSPP,2,<%=request.getParameter("ID")%>));
                                    </script>      
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <!-- Inizo modifica effettuata da Francesco Di Martino 01-10-2004 -->
                                    <table>
                                        <tr>
                                            <td>
                                                <%@ include file="../_include/ToolBar.jsp" %>
                                                <%ToolBar.bCanDelete = (bean != null);%>
                                                <%=ToolBar.build(2)%>
                                            </td>
                                        </tr>
                                    </table>
                                    <!-- Fine modifica effettuata da Francesco Di Martino 01-10-2004 -->	
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Gestione.segnalazione")%></legend>
                                        <table  width="100%" border="0">
                                            <tr>
                                                <td colspan="8">
                                                    <fieldset>
                                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Lavoratore")%></legend>
                                                        <table  width="100%" border="0">
                                                            <tr>
                                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
                                                                <td align="left" colspan="6">
                                                                    <input type="text" tabindex="1" name="strCOD_AZL" value="<%=strCOD_AZL%>" readonly style="width: 100%;">
                                                                    <input type="hidden" id="COD_AZL" name="COD_AZL" value="<%=lCOD_AZL%>"readonly />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
                                                                <td align="left">
                                                                    <input type="hidden" id="COD_DPD" name="COD_DPD" value="<%if (lCOD_DPD == 0) {
                                                                            out.print("");
                                                                        } else {
                                                                            out.print(lCOD_DPD);
                                                                        }%>" />
                                                                    <input type="text" name="strNOM_DPD" size="29" tabindex="2" value="<%=strNOM_DPD%>" readonly>
                                                                </td>
                                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Cognome")%>&nbsp;</b></td>
                                                                <td align="left"><input type="text" size="29" name="strCOG_DPD" tabindex="3" value="<%=strCOG_DPD%>" readonly></td>
                                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Matricola")%>&nbsp;</b></td>
                                                                <td align="left">
                                                                    <input type="text" size="29" tabindex="4" value="<%=strMTR_DPD%>" id="strMTR_DPD" name="strMTR_DPD" readonly/>
                                                                </td>
                                                                <td align="left">
                                                                    <button class="getlist" onclick="getLavoratoriList()" tabindex="5" id="btnLavoratore"><strong>&middot;&middot;&middot;</strong></button>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 93px;" align="right"><b>
                                                        <%=ApplicationConfigurator.LanguageManager.getString(
                                                                SEG_REG_MON ? "Segnalazione" : "Titolo")%>&nbsp;</b></td>
                                                <td align="left" colspan="5">
                                                    <input tabindex="6" style="width: 100%;" type="text" name="TIT_SGZ" maxlength="50" value="<%=strTIT_SGZ%>">
                                                </td>
                                                <td align="right">
                                                    <b><%=ApplicationConfigurator.LanguageManager.getString("Stato")%>&nbsp;</b>
                                                </td>
                                                <td align="left">
                                                    <select tabindex="7" name="STA_SGZ" style="width: 100%;">
                                                        <option value="C" <%=("C".equals(strSTA_SGZ)) ? "selected" : ""%>><%=ApplicationConfigurator.LanguageManager.getString("Creata")%></option>
                                                        <option value="I" <%=("I".equals(strSTA_SGZ)) ? "selected" : ""%>><%=ApplicationConfigurator.LanguageManager.getString("In.lavorazione")%></option>
                                                        <option value="L" <%=("L".equals(strSTA_SGZ)) ? "selected" : ""%>><%=ApplicationConfigurator.LanguageManager.getString("Conclusa")%></option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr style="display: <%=SEG_REG_MON ? "block;" : "none;"%>">
                                                <td align="right">
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Immobile")%>&nbsp;
                                                </td>
                                                <td align="left" colspan="3">
                                                    <select tabindex="8" name="COD_IMM" style="width: 100%;" id="COD_IMM_ID" value="<%=lCOD_IMM%>" 
                                                            onchange="reloadLuoghiFisici(this.value,0,<%=lCOD_AZL%>);">
                                                        <option option value="0"></option>
                                                        <%
                                                            IImmobili3lvHome immHome = (IImmobili3lvHome) PseudoContext.lookup("Immobili3lvBean");
                                                            out.println(BuildImmobiliComboBox(immHome,lCOD_IMM,lCOD_AZL));
                                                        %>
                                                    </select>
                                                </td>
                                                <td align="right">
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%>&nbsp;
                                                </td>
                                                <td align="left" colspan="3">
                                                    <div id="luoghiFisiciDIV">
                                                        <script type="text/javascript">
                                                            reloadLuoghiFisici(<%=lCOD_IMM%>, <%=lCOD_LUO_FSC%>, <%=lCOD_AZL%>);
                                                        </script>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Rilevatore")%>&nbsp;</b></td>
                                                <td align="left" colspan="3">
                                                    <input tabindex="10" type="text" size="55" name="NOM_RIL_SGZ" maxlength="100" value="<%=strNOM_RIL_SGZ%>">
                                                </td>
                                                <td align="right">
                                                    <b><%=ApplicationConfigurator.LanguageManager.getString("Numero.(default)")%>&nbsp;</b>
                                                </td>
                                                <td align="left">
                                                    <input tabindex="11" type="text" size="15" maxlength="5" name="NUM_SGZ" value="<%=(lNUM_SGZ == -1) ? "" : Formatter.format(lNUM_SGZ)%>">
                                                </td>
                                                <td align="right">
                                                    <b><%=ApplicationConfigurator.LanguageManager.getString("Versione")%>&nbsp</b>
                                                </td>
                                                <td align="left">
                                                    <input tabindex="12" type="text" size="15" name="VER_SGZ" maxlength="5" value="<%=(lVER_SGZ == -1) ? "" : Formatter.format(lVER_SGZ)%>">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Stato.finale")%>&nbsp;</td>
                                                <td align="left">
                                                    <select tabindex="13" name="STA_FIE_SGZ">
                                                        <option value="" ></option>
                                                        <option value="C" <%=("C".equals(strSTA_FIE_SGZ)) ? "selected" : ""%>><%=ApplicationConfigurator.LanguageManager.getString("Conclusa.efficacemente")%></option>
                                                        <option value="N" <%=("N".equals(strSTA_FIE_SGZ)) ? "selected" : ""%>><%=ApplicationConfigurator.LanguageManager.getString("Non.risolta")%></option>
                                                        <option value="S" <%=("S".equals(strSTA_FIE_SGZ)) ? "selected" : ""%>><%=ApplicationConfigurator.LanguageManager.getString("Sospesa")%></option>
                                                    </select>
                                                </td>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Urgente(default)")%>&nbsp;</b></td>
                                                <td align="left">
                                                    <input tabindex="14" type="checkbox" name="URG_SGZ" value="S" class="checkbox" <%=(strURG_SGZ.equals("S")) ? "checked" : ""%>>
                                                </td>
                                                <td align="right"><b>&nbsp;&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.(default)")%>&nbsp;</b></td>
                                                <td align="left">
                                                    <s2s:Date tabindex="15"  id="DAT_SGZ" name="DAT_SGZ" value="<%=dtDAT_SGZ%>"/>
                                                </td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.fine")%>&nbsp;</td>
                                                <td align="left">
                                                    <s2s:Date tabindex="16" id="DAT_FIE" name="DAT_FIE" value="<%=dtDAT_FIE%>"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="top" align="right" > <b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</b></td>
                                                <td align="left" colspan="7">
                                                    <s2s:textarea tabindex="17" rows="3" cols="79" name="DES_SGZ" maxlength="800"><%=strDES_SGZ%></s2s:textarea>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td valign="top" align="right" ><%=ApplicationConfigurator.LanguageManager.getString("Attività")%>&nbsp;</td>
                                                <td colspan="7" align="left">
                                                    <s2s:textarea tabindex="18" rows="3" cols="79" name="DES_ATI_SGZ" maxlength="800"><%=strDES_ATI_SGZ%></s2s:textarea>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
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
            <!-- /form for addind  Rapportini di Segnalazione-->
            <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <%
            //-------Loading of Tabs--------------------
            if (bean != null) {
        %>
        <script language="JavaScript" src="../_scripts/index.js"></script>
        <script language="JavaScript">
            function getLavoratoriList(){
                var obj=new Object();
                var url="Form_ANA_DPD/ANA_DPD_View.jsp";
                if(showSearch(url, obj, "dialogHeight:30; dialogWidth:50;help:no;resizable:yes;status:yes;scroll:no;")=="OK"){
                    document.all["ifrmWork"].src="ANA_SGZ_Lavoratore.jsp?ID="+obj.ID;		
                }
            }
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
            btnParams[1] = {"id":"btnEdit",
                "onmousedown":btnDown,
                "onmouseup":btnOver,
                "onmouseover":btnOver,
                "onmouseout":btnOut,
                "onclick":editRow,
                "src":"../_images/EDIT.gif",
                "action":"Edit"
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

            //--------creating tabs--------------------------
            var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
            var btnBar = new ButtonPanel("batPanel1", btnParams);
            tabbar.addButtonBar(btnBar);

            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Attività.segnalazioni")%>", tabbar));
            if (<%=SEG_REG_MON%>){
                tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Rischi")%>", tabbar));
            }
            tabbar.idParentRecord = <%=lCOD_SGZ%>;
            tabbar.refreshTabUrl="ANA_SGZ_Tabs.jsp";
            tabbar.RefreshAllTabs();
            tabbar.tabs[0].tabObj.actionParams ={
                "Feachures":{"dialogWidth":"780px",
                    "dialogHeight":"550px"
                },
                "AddNew":	{"url":"../Form_ANA_ATI_SGZ/ANA_ATI_SGZ_Form.jsp",
                    "buttonIndex":0
                },
                "Delete":	{"url":"../Form_ANA_ATI_SGZ/ANA_ATI_SGZ_Delete.jsp?LOCAL_MODE=A",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"]
                },
                "Edit":         {"url":"../Form_ANA_ATI_SGZ/ANA_ATI_SGZ_Form.jsp",
                    "buttonIndex":1
                }
            };
          
            if (<%=SEG_REG_MON%>){
                tabbar.tabs[1].tabObj.actionParams ={
                    "Feachures":{"dialogWidth":"780px",
                        "dialogHeight":"550px"
                    },
                    "AddNew":	{"url":"../Form_ANA_RSO/ANA_RSO_Form.jsp?ATTACH_URL=Form_ANA_SGZ/ANA_SGZ_Attach.jsp&ATTACH_SUBJECT=R",
                        "buttonIndex":0
                    },
                    "Delete":	{"url":"../Form_ANA_SGZ/ANA_SGZ_Delete.jsp?LOCAL_MODE=R",
                        "buttonIndex":2,
                        "target_element":document.all["ifrmWork"]
                    },
                    "Edit":         {"url":"../Form_ANA_RSO/ANA_RSO_Form.jsp?ATTACH_URL=Form_ANA_SGZ/ANA_SGZ_Attach.jsp&ATTACH_SUBJECT=R",
                        "buttonIndex":1
                    }
                };
            }
            tabbar.tabs[0].center.click();
        </script>
        <%} else {%>
        <script>
            window.dialogHeight = "<%=SEG_REG_MON ? "420" : "395"%>px";
        </script>
        <%}%> 
    </body>
</html>
