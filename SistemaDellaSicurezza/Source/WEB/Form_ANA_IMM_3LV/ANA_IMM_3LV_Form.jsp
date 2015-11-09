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
            response.setHeader("Pragma", "no-cache");        //HTTP 1.0
            response.setDateHeader("Expires", 0);          //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Immobili3lv.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.SediAziendali.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="ANA_IMM_3LV_Util.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../_include/ToolBar.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
    <head>
        <script type="text/javascript">
            document.write("<title>" + getCompleteMenuPath(SubMenuDistribuzioneTerritorialie,2) + "</title>");
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
            window.dialogHeight="575px";
        </script>
    </head>
    <body>
        <%
                    long COD_AZL = Security.getAzienda();
                    long COD_IMM = 0;
                    long COD_SIT_AZL = 0;
                    String strNOM_IMM = "";
                    //-----------------------------
                    String strDES_IMM = "";
                    String strIND_IMM = "";
                    String strNUM_CIV_IMM = "";
                    String strCIT_IMM = "";
                    String strPRO_IMM = "";
                    String strCAP_IMM = "";

                    IImmobili3lv bean = null;
                    IAzienda azienda;
                    IAziendaHome AziendaHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");
                    ISitaAziendeHome SitaAziendeHome = (ISitaAziendeHome) PseudoContext.lookup("SitaAziendeBean");

                    azienda = AziendaHome.findByPrimaryKey(COD_AZL);
                    
                    String strCOD_IMM = request.getParameter("ID");
                    String ID_PARENT = request.getParameter("ID_PARENT");
                    if (ID_PARENT != null){
                        COD_SIT_AZL = Long.parseLong(ID_PARENT);
                    }

                    if (strCOD_IMM != null) {
                        // editing of immobili
                        IImmobili3lvHome home = (IImmobili3lvHome) PseudoContext.lookup("Immobili3lvBean");
                        try {
                            bean = home.findByPrimaryKey(new Long(strCOD_IMM));
                        } catch (Exception ex) {
                            out.print("<script>Alert.Error.showNotFound(); window.self.close();</script>");
                            return;
                        }
                        // getting of object variables
                        COD_IMM = bean.getCOD_IMM();
                        COD_SIT_AZL = bean.getCOD_SIT_AZL();
                        strNOM_IMM = Formatter.format(bean.getNOM_IMM());
                        strDES_IMM = Formatter.format(bean.getDES_IMM());
                        strIND_IMM = Formatter.format(bean.getIND_IMM());
                        strNUM_CIV_IMM = Formatter.format(bean.getNUM_CIV_IMM());
                        strCIT_IMM = Formatter.format(bean.getCIT_IMM());
                        strPRO_IMM = Formatter.format(bean.getPRO_IMM());
                        strCAP_IMM = Formatter.format(bean.getCAP_IMM());
                    }
        %>
        <!-- form for addind  -->
        <form action="ANA_IMM_3LV_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input type="hidden" name="SBM_MODE" value="<%=(COD_IMM == 0) ? "new" : "edt"%>">
            <input type="hidden" name="COD_IMM" value="<%=COD_IMM%>">
            <table width="100%" border="0">
                <tr>
                    <td valign="top">
                        <table  width="100%">
                            <tr>
                                <td class="title">
                                    <script type="text/javascript" >
                                        document.write(getCompleteMenuPathFunction
                                        (SubMenuDistribuzioneTerritorialie,2,<%=strCOD_IMM%>));
                                    </script>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table border=0 width="100%">
                                        <tr>
                                            <td>
                                                <%
                                                    ToolBar.bShowReturn = false;
                                                    out.print(ToolBar.build(2));
                                                %>
                                            </td>
                                        </tr>
                                    </table>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.immobile")%></legend>
                                        <table  width="100%" border="0" cellpadding="2" cellspacing="2">
                                            <tr>
                                                <td align="right" nowrap><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
                                                <td align="left" colspan="5">
                                                    <input tabindex="1" style="width:50%;" type="text" value="<%=azienda.getRAG_SCL_AZL()%>" readonly>
                                                    <input type="hidden" id="COD_AZL" name="COD_AZL" value="<%=COD_AZL%>" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" nowrap><b><%=ApplicationConfigurator.LanguageManager.getString("Sito.aziendale")%>&nbsp;</b></td>
                                                <td align="left" colspan="5">
                                                    <select tabindex="2"name="COD_SIT_AZL" style="width: 720px;" <%=ID_PARENT != null?"disabled":""%>>
                                                        <option value=""></option>
                                                        <%=BuildSitoAzlComboBox(SitaAziendeHome, COD_SIT_AZL, COD_AZL)%>
                                                    </select>
                                                    <%
                                                        if (ID_PARENT!=null){
                                                            out.println("<input type=\"hidden\" name=\"COD_SIT_AZL\" value=\"" + COD_SIT_AZL + "\">");
                                                        }
                                                    %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <b><%=ApplicationConfigurator.LanguageManager.getString("Immobile")%>&nbsp;</b>
                                                </td>
                                                <td align="left" colspan="5">
                                                    <input tabindex="3" type="text" maxlength="100" style="width: 100%;" id="strNOM_IMM" name="strNOM_IMM" value="<%=strNOM_IMM%>">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="top" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                                <td align="left" colspan="5">
                                                    <s2s:textarea tabindex="4" name="strDES_IMM" maxlength="4000" rows="4" cols="100" style="width:100%;"><%=strDES_IMM%></s2s:textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Indirizzo")%>&nbsp;</td>
                                                <td align="left" colspan="3"><input tabindex="5" size="92" type="text" name="strIND_IMM" maxlength="50" value="<%=strIND_IMM%>"></td>
                                                <td align="right" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Numero.civico")%>&nbsp;</td>
                                                <td align="left"><input tabindex="6" size="15" type="text" name="strNUM_CIV_IMM" maxlength="10" value="<%=strNUM_CIV_IMM%>"></td>
                                            </tr>
                                            <tr>
                                                <td align="right" width="95px%"><%=ApplicationConfigurator.LanguageManager.getString("Città")%>&nbsp;</td>
                                                <td align="left"><input tabindex="7" size="50" type="text" name="strCIT_IMM" value="<%=strCIT_IMM%>" maxlength="25"></td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Provincia")%>&nbsp;</td>
                                                <td align="left"><input tabindex="8" size="15" type="text" maxlength="2" name="strPRO_IMM" value="<%=strPRO_IMM%>"></td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("C.a.p.")%>&nbsp;</td>
                                                <td align="left"><input tabindex="9" size="15" type="text" maxlength="5" name="strCAP_IMM" value="<%=strCAP_IMM%>"></td>
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
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>

        <%
                    if (bean != null) {
        %>
        <script type="text/javascript"  src="../_scripts/index.js"></script>
        <script type="text/javascript">
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
            tabbar.addTab(new Tab("tab_luoghi_fisici", "<%=ApplicationConfigurator.LanguageManager.getString("Luoghi.fisici")%>", tabbar));

            //------adding tables to tabs-----------------------
            tabbar.idParentRecord = <%=COD_IMM%>;
            tabbar.refreshTabUrl="ANA_IMM_3LV_Tabs.jsp";
            //----------------------------------------------------
            tabbar.RefreshAllTabs();
            //-----activate first tab--------------------------
            tabbar.tabs[0].center.click();
            //----add action parameters to tabs
            tabbar.tabs[0].tabObj.actionParams = {
                "Feachures":ANA_LUO_FSC_Feachures,
                "AddNew":	{"url":"../Form_ANA_LUO_FSC/ANA_LUO_FSC_Form.jsp?ATTACH_URL=Form_ANA_SIT_AZL/ANA_SIT_AZL_Attach.jsp&ATTACH_SUBJECT=LUO",
                    "buttonIndex":0
                },
                "Edit":	{"url":"../Form_ANA_LUO_FSC/ANA_LUO_FSC_Form.jsp?ATTACH_URL=Form_ANA_SIT_AZL/ANA_SIT_AZL_Attach.jsp&ATTACH_SUBJECT=LUO",
                    "buttonIndex":1
                },
                "Delete":	{"url":"../Form_ANA_LUO_FSC/ANA_LUO_FSC_Delete.jsp?LOCAL_MODE=LUO",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"]
                }
            };
            //------------------------------------------------
            tabbar.tabs[0].tabObj.OnActivate = function ()
            {
                tabbar.buttonBar.panel.style.display = '';
            };
        </script>
        <%} else {%>
        <script type="text/javascript">
            window.dialogHeight="330px";
        </script>
        <%}%>
    </body>
</html>
