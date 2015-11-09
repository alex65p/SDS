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
    <version number="1.0" date="27/02/2004" author="Podmasteriev Alexandr">
    <comments>
    <comment date="28/01/2004" author="Khomenko Juliya">
    <description>Create Formi ANA_ATI_SGZ_Form.jsp</description>
    </comment>
    </comments>
    </version>
    </versions>
    </file>
     */
%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.AttivitaSegnalazione.*" %>
<%@ page import="com.apconsulting.luna.ejb.RapportiniSegnalazione.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES"%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_include/ComboBox-Dipendente.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<html>
    <head>
        <title><%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.attività.segnalazione")%></title>
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
    </head>
    <%        
        boolean SEG_REG_MON =
                ApplicationConfigurator.isModuleEnabled(MODULES.SEG_REG_MON);
    %>
    <script>
        window.dialogWidth = "780px";
        window.dialogHeight = "<%=SEG_REG_MON ? "585" : "555"%>px";
    </script>
    <body>
        <%            
            long lCOD_ATI_SGZ = 0;
            String strDES_ATI_SGZ = "";
            String dtDAT_SCA = "";
            String dtDAT_VER = "";
            String fRIS = "";
            String dtDAT_ATT = "";
            String strVER_DA = "";
            long lCOD_DPD = 0;
            long lCOD_AZL = 0;
            String strCOD_AZL = "";
            String dtDAT_SGZ = "";
            String strTIT_SGZ = "";
            
            IAttivitaSegnalazione bean = null;
            IRapportiniSegnalazione bean_r = null;
            
            IAzienda azienda = null;
            IAziendaHome AziendaHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");
            IRapportiniSegnalazioneHome home_r = (IRapportiniSegnalazioneHome) PseudoContext.lookup("RapportiniSegnalazioneBean");
            IAttivitaSegnalazioneHome home = (IAttivitaSegnalazioneHome) PseudoContext.lookup("AttivitaSegnalazioneBean");
            
            String strCOD_SGZ = request.getParameter("ID_PARENT");
            bean_r = home_r.findByPrimaryKey(new Long(strCOD_SGZ));
            dtDAT_SGZ = Formatter.format(bean_r.getDAT_SGZ());
            strTIT_SGZ = Formatter.format(bean_r.getTIT_SGZ());
            if (request.getParameter("ID") != null) {
                String strCOD_ATI_SGZ = request.getParameter("ID");
// editing of bean
                try {
                    bean = home.findByPrimaryKey(new Long(strCOD_ATI_SGZ));
                } catch (Exception ex) {
                    out.print("<script>Alert.Error.showDublicate(); window.self.close();</script>");
                    return;
                }
                lCOD_ATI_SGZ = bean.getCOD_ATI_SGZ();
                strDES_ATI_SGZ = Formatter.format(bean.getDES_ATI_SGZ());
                dtDAT_SCA = Formatter.format(bean.getDAT_SCA());
                dtDAT_VER = Formatter.format(bean.getDAT_VER());
                fRIS = Formatter.format(bean.getRIS());
                dtDAT_ATT = Formatter.format(bean.getDAT_ATT());
                strVER_DA = Formatter.format(bean.getVER_DA());
                lCOD_DPD = bean.getCOD_DPD();
                lCOD_AZL = bean.getCOD_AZL();
// Get Aziende/Ente
                azienda = AziendaHome.findByPrimaryKey(new Long(lCOD_AZL));
                strCOD_AZL = Formatter.format(azienda.getRAG_SCL_AZL());
            } else {
                // Get Aziende/Ente
                lCOD_AZL = Security.getAzienda();
                azienda = AziendaHome.findByPrimaryKey(new Long(lCOD_AZL));
                strCOD_AZL = Formatter.format(azienda.getRAG_SCL_AZL());
            }
        %>
        <form action="ANA_ATI_SGZ_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value="<%=(lCOD_ATI_SGZ == 0) ? "new" : "edt"%>">
            <input type="hidden" name="COD_ATI_SGZ" value="<%=lCOD_ATI_SGZ%>">
            <input type="hidden" name="COD_AZL" value="<%=lCOD_AZL%>">
            <input type="hidden" name="COD_SGZ" value="<%=strCOD_SGZ%>">
            <table  border="0" width="100%">
                <tr>
                    <td valign="top">
                        <table  width="100%" border="0">
                            <tr>
                                <td class="title"><%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.attività.segnalazione")%></td>
                            </tr>
                            <tr>
                                <td>
                                    <table  width="100%" border="0">
                                        <tr>
                                            <td>
                                                <table border="0">
                                                    <%@ include file="../_include/ToolBar.jsp" %>
                                                    <%ToolBar.bCanDelete = (bean != null);%>
                                                    <%ToolBar.bShowReturn = false;
                                                        ToolBar.bShowSearch = false;%>
                                                    <%=ToolBar.build(2)%>
                                                </table>
                                                <fieldset>
                                                    <table width="100%" border="0">
                                                        <tr>
                                                            <td align="right" style="width: 122px;"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
                                                            <td align="left"><input type="text"  readonly value="<%=strCOD_AZL%>" tabindex="1" style="width: 100%;">
                                                                <input type="hidden" id="COD_AZL"  value="<%=lCOD_AZL%>" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </fieldset>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <fieldset>
                                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Segnalazione")%></legend>
                                                    <table  width="100%" border="0">
                                                        <tr>
                                                            <td align="right" nowrap style="width: 122px;"><b><%=ApplicationConfigurator.LanguageManager.getString("Titolo.segnalazione")%>&nbsp;</b></td>
                                                            <td align="left"><input readonly  type="text" tabindex="2" value="<%=strTIT_SGZ%>" size="70"></td>
                                                            <td align="right" nowrap><b><%=ApplicationConfigurator.LanguageManager.getString("Data.segnalazione")%>&nbsp;</b></td>
                                                            <td align="left"><s2s:Date id="DAT_SGZ" name ="dtDAT_SGZ" tabindex="3" readonly="true" value="<%=dtDAT_SGZ%>"/></td>
                                                        </tr>
                                                    </table>
                                                </fieldset>
                                            </td></tr>
                                        <tr>
                                            <td>
                                                <fieldset>
                                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.attività.segnalazione")%></legend>
                                                    <table  width="100%" border="0">
                                                        <tr>
                                                            <td align="right" style="width: 122px;"><b><%=ApplicationConfigurator.LanguageManager.getString("Lavoratore")%>&nbsp;</b></td>
                                                            <td colspan="5" align="left">
                                                                <select name="COD_DPD" style="width:100%;" tabindex="4">
                                                                    <%                                                                        
                                                                        IDipendenteHome d_home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
                                                                        out.print(BuildDipendenteComboBox(d_home, lCOD_DPD, lCOD_AZL));
                                                                    %>
                                                                </select>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" valign="top" nowrap><b>
                                                                    <%=ApplicationConfigurator.LanguageManager.getString(
                                                                            SEG_REG_MON ? "Azione.pianificata" : "Descrizione.attività")%>&nbsp;</b></td>
                                                            <td  colspan="5" align="left">
                                                                <s2s:textarea name="DES_ATI_SGZ" rows="3" cols="85" maxlength="400" tabindex="5"><%=strDES_ATI_SGZ%></s2s:textarea>
                                                            </td>
                                                        </tr>
                                                        <tr style="display: <%=SEG_REG_MON ? "block;" : "none;"%>">
                                                            <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Risorse")%>&nbsp;</td>
                                                            <td align="left"><input type="text" name="RIS" value="<%=fRIS%>" size="15" tabindex="6" maxlength="10"></td>
                                                            <td align="right" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Data.attuazione")%>&nbsp;</td>
                                                            <td align="left"><s2s:Date id="DAT_ATT" name="DAT_ATT" tabindex="7" value="<%=dtDAT_ATT%>"/></td>
                                                            <td align="right" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Verificato.da")%>&nbsp;</td>
                                                            <td align="left"><input type="text" name="VER_DA" value="<%=strVER_DA%>" size="40" tabindex="8" maxlength="10"></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" nowrap><b><%=ApplicationConfigurator.LanguageManager.getString("Data.scadenza")%>&nbsp;</b></td>
                                                            <td align="left"><s2s:Date id="DAT_SCA" name="DAT_SCA" tabindex="9" value="<%=dtDAT_SCA%>"/></td>
                                                            <td align="right" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Data.verifica")%>&nbsp;</td>
                                                            <td align="left" colspan="3"><s2s:Date id="DAT_VER" name="DAT_VER" tabindex="10" value="<%=dtDAT_VER%>"/></td>
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
                        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"  ></iframe>
                        <%
                            //-------Loading of Tabs--------------------
                            if (bean == null) {
                        %>
                        <script>
                            window.dialogHeight = "<%=SEG_REG_MON ? "345" : "315"%>px";
                        </script>
                        <%                                
                                return;
                            }
                        %>
                        <script language="JavaScript" src="../_scripts/index.js"></script>
                        <script language="JavaScript">
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
            
                            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.documenti")%>", tabbar));
                            if (<%=SEG_REG_MON%>){
                                tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Misure.di.prevenzione.e.protezione")%>", tabbar));
                            }
                            tabbar.idParentRecord = <%=lCOD_ATI_SGZ%>;
                            tabbar.refreshTabUrl="ANA_ATI_SGZ_Tabs.jsp";
                            tabbar.RefreshAllTabs();
                            tabbar.tabs[0].tabObj.actionParams ={
                                "Feachures":ANA_DOC_Feachures,
                                "AddNew":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_ATI_SGZ/ANA_ATI_SGZ_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
                                    "buttonIndex":0
                                },
                                "Delete":	{"url":"../Form_ANA_ATI_SGZ/ANA_ATI_SGZ_Delete.jsp?LOCAL_MODE=B",
                                    "buttonIndex":2,
                                    "target_element":document.all["ifrmWork"]
                                },
                                "Edit":         {"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_ATI_SGZ/ANA_ATI_SGZ_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
                                    "buttonIndex":1
                                }
                            };
                            if (<%=SEG_REG_MON%>){
                                tabbar.tabs[1].tabObj.actionParams ={
                                    "Feachures":ANA_DOC_Feachures,
                                    "AddNew":	{"url":"../Form_ANA_MIS_PET/ANA_MIS_PET_Form.jsp?ATTACH_URL=Form_ANA_ATI_SGZ/ANA_ATI_SGZ_Attach.jsp&ATTACH_SUBJECT=MISURA",
                                        "buttonIndex":0
                                    },
                                    "Delete":	{"url":"../Form_ANA_ATI_SGZ/ANA_ATI_SGZ_Delete.jsp?LOCAL_MODE=MISURA",
                                        "buttonIndex":2,
                                        "target_element":document.all["ifrmWork"]
                                    },
                                    "Edit":         {"url":"../Form_ANA_MIS_PET/ANA_MIS_PET_Form.jsp?ATTACH_URL=Form_ANA_ATI_SGZ/ANA_ATI_SGZ_Attach.jsp&ATTACH_SUBJECT=MISURA",
                                        "buttonIndex":1
                                    }
                                };
                            }
                            tabbar.tabs[0].center.click();
                        </script>
                        </body>
                        </html>
