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

<%-- 
    Document   : ANA_PSC_Form
    Created on : 21-mar-2011, 16.14.45
    Author     : Alessandro
--%>

<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>

<%@ page import="java.text.*"%>
<%@ page import="java.sql.Date"%>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>
<%@ page import="com.apconsulting.luna.ejb.PSC.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrProcedimento.*" %>
<%@ page import="s2s.utils.text.StringManager" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Localization.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%@ include file="ANA_PSC_Util.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuGestionecantieri,3) + "</title>");
        </script>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script type="text/javascript" src="../_scripts/tabs.js"></script>
        <script type="text/javascript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <script type="text/javascript" src="../_scripts/utility-date.js"></script>
        <script type="text/javascript" src="../_scripts/textarea.js"></script>
        <script type="text/javascript" src="../_scripts/ajax.js"></script>
        <script type="text/javascript" src="ANA_PSC_JS.js"></script>
        <script>
            window.dialogWidth="816px";
            window.dialogHeight="485px";
        </script>
    </head>
    <body>
        <%!            
            long lCOD_AZL;
            long lCOD_PSC;
            long lCOD_PRO;
            String strTIT;
            String strOGG;
            String strCOD;
            String dtDAT_PRM_REG;
            String strCOD_ELA;
        %>
        <%
            lCOD_AZL = Security.getAzienda();
            lCOD_PSC = 0;
            lCOD_PRO = 0;
            strTIT = strOGG = strCOD = strCOD_ELA = "";
            dtDAT_PRM_REG = "";

            IAnagrProcedimentoHome d_home = (IAnagrProcedimentoHome) PseudoContext.lookup("AnagrProcedimentoBean");
            IPSC bean = null;
            IPSCHome home = (IPSCHome) PseudoContext.lookup("PSCBean");
            
            String strCOD_PSC = request.getParameter("ID");
            if (strCOD_PSC != null) {
                bean = home.findByPrimaryKey(Long.parseLong(strCOD_PSC));
                lCOD_PSC = bean.getlCOD_PSC();                          //1
                strTIT = Formatter.format(bean.getstrTIT());        	//2
                strOGG = Formatter.format(bean.getstrOGG());        	//3
                strCOD = Formatter.format(bean.getstrCOD());        	//4
                lCOD_PRO = bean.getlCOD_PRO();                          //6
                lCOD_AZL = bean.getlCOD_AZL();                          //7
                dtDAT_PRM_REG = Formatter.format(bean.getdtDAT_PRM_REG());
                strCOD_ELA = Formatter.format(bean.getCOD_ELA());
            }
        %>

        <!-- form for addind  -->
        <form action="ANA_PSC_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value="<%=(lCOD_PSC == 0) ? "new" : "edt"%>">
            <input type="hidden" name="PSC_ID" value="<%=lCOD_PSC%>">
            <input type="hidden" name="COD_AZL" value="<%=lCOD_AZL%>">
            <table width="100%" border="0">
                <tr>
                    <td width="10" height="100%" valign="top">
                    </td>
                    <td valign="top">
                        <table  width="100%" border="0">
                            <tr>
                                <td class="title" colspan="2">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                        (SubMenuGestionecantieri,3,<%=request.getParameter("ID")%>));
                                    </script>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="100%">
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%
                                            ToolBar.strPrintUrl = "SchedaPSC.jsp?";
                                            ToolBar.strPrintUrl3 = "STAMPA_PSC_SINT.jsp?";
                                            ToolBar.bCanPrint3 = bean != null;
                                            ToolBar.bShowPrint3 = bean != null;
                                            ToolBar.setBtnPrint_title(ApplicationConfigurator.LanguageManager.getString("Stampa.completa"));
                                            ToolBar.setBtnPrint3_title(ApplicationConfigurator.LanguageManager.getString("Stampa.sintetica"));
                                        %>
                                        <%=ToolBar.build(2)%>
                                    </table>
                                    <fieldset>
                                        <legend></legend>
                                        <table width="100%" border="0">
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Procedimento")%>&nbsp;</b></td>
                                                <td align="left">                                                                 
                                                    <select tabindex="1" style="width: 270px;" name="COD_PRO" onchange="CodiceProcedimento(this)">
                                                        <option value=''></option>
                                                        <%
                                                            out.print(BuildProcedimentoComboBox(d_home, lCOD_PRO, Security.getAzienda()));
                                                        %>
                                                    </select>
                                                </td>
                                                <td align="right" style="white-space: nowrap;"><%=ApplicationConfigurator.LanguageManager.getString("Titolo.PSC")%>&nbsp;</td>
                                                <td align="left"><input tabindex="2" maxlength="50" style="width: 350px;" name="TIT" value="<%=strTIT%>"></td>
                                            </tr>
                                            <tr>
                                                <td align="right" colore="COD"><b><%=ApplicationConfigurator.LanguageManager.getString("Codice.PSC")%>&nbsp;</b></td>
                                                <%
                                                    if (bean != null) {
                                                        IAnagrProcedimento bean_vr = d_home.findByPrimaryKey(new Long(lCOD_PRO));%>
                                                    <td align="left"><input tabindex="3" style="width: 100%;" readonly maxlength="50" id="COD_PSC" name="COD_PSC" value="PSC-<%=bean_vr.getstrCOD()%>"></td>
                                                    <%} else {%>
                                                <td align="left"><input tabindex="3" style="width: 100%;" readonly id="COD_PSC" maxlength="50" name="COD_PSC" value="<%=strCOD%>"></td>
                                                    <%}%>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Oggetto")%>&nbsp;</td>
                                                <td align="left"><s2s:textarea tabindex="4" cols="64" rows="3" maxlength="250"id="OGG" name="OGG"><%=strOGG%></s2s:textarea></td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Data.prima.registrazione")%>&nbsp;</b></td>
                                                <td align="left">
                                                    <%if (request.getParameter("ID") == null) {%>
                                                    <input tabindex="5" id="DAT_PRM_REG_ID" style="width: 35%;" name="DAT_PRM_REG_ID" value="getCurrentDate(<%=Formatter.format(dtDAT_PRM_REG)%>)" readonly>
                                                    <script type="text/javascript">document.getElementById("DAT_PRM_REG_ID").value = getCurrentDate(<%=dtDAT_PRM_REG%>);</script>
                                                    <%} else {%>
                                                    <input tabindex="5" id="DAT_PRM_REG_ID" style="width: 35%;" name="DAT_PRM_REG_ID" value="<%=dtDAT_PRM_REG%>" readonly>
                                                    <%}%>
                                                </td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Codifica.elaborato")%></td>
                                                <td align="left">
                                                    <input tabindex="6" <%=""/*StringManager.isNotEmpty(strCOD_ELA) && bean.areAssociations()?"readonly":""*/%> maxlength="17" style="width: 60%;" name="COD_ELA" value="<%=strCOD_ELA%>">
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="100%"><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <textarea id="ajaxReturn" style="display: none;"></textarea>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <%
            //-------Loading of Tabs--------------------
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
            var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
            var btnBar = new ButtonPanel("batPanel1", btnParams);
            tabbar.addButtonBar(btnBar);
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Sezione.generale")%>", tabbar));
            tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Schede.di.sicurezza")%>", tabbar));
            tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Sezione.particolare")%>", tabbar));
            tabbar.addTab(new Tab("tab4", "<%=ApplicationConfigurator.LanguageManager.getString("Fascicolo.dell.opera")%>", tabbar));

            tabbar.idParentRecord = <%=lCOD_PSC%>;
            tabbar.refreshTabUrl="ANA_PSC_Tabs.jsp";
            tabbar.RefreshAllTabs();
            tabbar.tabs[0].center.click();
            
            //--------------------------------------------------------------------
            tabbar.tabs[0].tabObj.actionParams ={"Feachures":SEZ_GEN_Feachures,
                "AddNew":	{"url":"../Form_SEZ_GEN/SEZ_GEN_Form.jsp",
                    "buttonIndex":0,
                    "useSelectedRowParamsList": true,
                    "checkBeforeInsert": true
                },
                "Edit":	{"url":"../Form_SEZ_GEN/SEZ_GEN_Form.jsp",
                    "buttonIndex":1
                },
                "Delete":	{"url":"../Form_SEZ_GEN/SEZ_GEN_Delete.jsp?LOCAL_MODE=c",
                    "target_element":document.all["ifrmWork"],
                    "buttonIndex":2
                }
            };
            
            tabbar.tabs[1].tabObj.actionParams ={"Feachures":SCH_SIC_Feachures,
                "AddNew":	{"url":"../Form_SCH_SIC/SCH_SIC_Form.jsp",
                    "disabled": false,
                    "buttonIndex":0,
                    "useSelectedRowParamsList": true,
                    "checkBeforeInsert": true
                },
                "Edit":	{"url":"../Form_SCH_SIC/SCH_SIC_Form.jsp",
                    "buttonIndex":1
                },
                "Delete":	{"url":"../Form_SCH_SIC/SCH_SIC_Delete.jsp?LOCAL_MODE=c",
                    "target_element":document.all["ifrmWork"],
                    "buttonIndex":2
                }
            };
            
            tabbar.tabs[2].tabObj.actionParams ={"Feachures":ANA_SEZ_PRT_Feachures,
                "AddNew":	{"url":"../Form_ANA_SEZ_PRT/ANA_SEZ_PRT_Form.jsp",
                    "disabled": false,
                    "buttonIndex":0,
                    "useSelectedRowParamsList": true,
                    "checkBeforeInsert": true
                }
                ,
                "Edit":	{"url":"../Form_ANA_SEZ_PRT/ANA_SEZ_PRT_Form.jsp",
                    "buttonIndex":1
                },
                "Delete":	{"url":"../Form_ANA_SEZ_PRT/ANA_SEZ_PRT_Delete.jsp?LOCAL_MODE=c",
                    "target_element":document.all["ifrmWork"],
                    "buttonIndex":2
                }
            };
            tabbar.tabs[3].tabObj.actionParams ={"Feachures":FAS_Feachures,
                "AddNew":	{"url":"../Form_FAS/FAS_Form.jsp",
                    "disabled": false,
                    "buttonIndex":0,
                    "useSelectedRowParamsList": true,
                    "checkBeforeInsert": true
                },
                "Edit":	{"url":"../Form_FAS/FAS_Form.jsp",
                    "buttonIndex":1
                },
                "Delete":	{"url":"../Form_FAS/FAS_Delete.jsp?LOCAL_MODE=c",
                    "target_element":document.all["ifrmWork"],
                    "buttonIndex":2
                }
            };
        </script>
        <%} else {%>
        <script>
            window.dialogHeight="240px";
        </script>
        <%}%>
    </body>
</html>
