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
<%@page import="com.apconsulting.luna.ejb.FattoriRischioCantiere.IFattoriRischioCantiereHome"%>
<%@page import="com.apconsulting.luna.ejb.AnagrConstatazioni.IAnagrConstatazioniHome"%>
<%@page import="com.apconsulting.luna.ejb.AnagrConstatazioni.IAnagrConstatazioni"%> 
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<%@ include file="ANA_CST_Util.jsp" %>
<%@ include file="../Form_ANA_RSO_CAN/ANA_RSO_CAN_Util.jsp" %>
<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuSopralluoghi,0) + "</title>");
        </script>
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
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <script language="JavaScript" src="../_scripts/textarea.js"></script>
        <script>
            window.dialogWidth="700px";
            window.dialogHeight="490px";
        </script>
    </head>
    <body>
        <%!            
            long lCOD_CST;
            String strDES;
            String strNOM;
            long lCOD_FAT_RSO;
            boolean bExtended = false;
        %>
        <%
            lCOD_CST = 0;
            lCOD_FAT_RSO = 0;
            strDES = "";
            strNOM = "";

            IAnagrConstatazioni bean = null;
            IAnagrConstatazioniHome home = (IAnagrConstatazioniHome) PseudoContext.lookup("AnagrConstatazioniBean");

            if (request.getParameter("ID") != null) {
                String strCOD_CST = request.getParameter("ID");

                Long cst_id = new Long(strCOD_CST);
                bean = home.findByPrimaryKey(cst_id);

                lCOD_CST = cst_id.longValue();                          //1
                strDES = Formatter.format(bean.getstrDES());
                strNOM = Formatter.format(bean.getstrNOM());                     	//2
                lCOD_FAT_RSO = bean.getCOD_FAT_RSO();
            }
        %>
        <form action="ANA_CST_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0; ">
            <input name="SBM_MODE" type="Hidden" value="<%=(lCOD_CST == 0) ? "new" : "edt"%>">
            <input type="hidden" name="CST_ID" value="<%=lCOD_CST%>">
            <input type="hidden" name="ID_PARENT" value="<%//=request.getParameter("ID_PARENT")%>">
            <table width="100%" border="0">
                <tr>
                    <td valign="top">
                        <table  width="100%" border="0">
                            <tr>
                                <td class="title">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                        (SubMenuSopralluoghi,0,<%=request.getParameter("ID")%>));
                                    </script>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="100%" border="0">
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%=ToolBar.build(3)%>
                                        <%
                                            if (Security.isExtendedMode()) {
                                                bExtended = true;
                                            }
                                        %>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <fieldset>  
                                        <legend>Descrizione Constatazione</legend>
                                        <table  width="100%" border="0" cellspacing='5' cellpadding='0'>
                                            <tr>
                                                <td align="right" width="120px;"><b><%=ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio")%></b>&nbsp;</td>
                                                <td align="left">
                                                    <select tabindex="1" name="COD_FAT_RSO" style="width:70%;">
                                                        <option value=''></option>
                                                        <%
                                                            IFattoriRischioCantiereHome home_rso = (IFattoriRischioCantiereHome) PseudoContext.lookup("FattoriRischioCantiereBean");
                                                            out.print(BuildFattoreRischioCantiereComboBox(home_rso, lCOD_FAT_RSO));
                                                        %>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
                                                <td align="left">
                                                    <input tabindex="2" style="width: 100%;" type="text" maxlength="100" name="NOM" id="NOM" value="<%=strNOM%>">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</b></td>
                                                <td align="left">
                                                    <s2s:textarea tabindex="3" cols="70" rows="2" maxlength="900" name="DES"><%=Formatter.format(strDES)%></s2s:textarea>
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
            <tr>
                <td colspan="100%"><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
            </tr>
        </form>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" >none</iframe>
        <script language="JavaScript" src="../_scripts/index.js"></script>
        <script language="JavaScript">
            <%if (bean != null) {
            %>
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

                //--------creating tabs--------------------------
                var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
                var btnBar = new ButtonPanel("batPanel1", btnParams);
                tabbar.addButtonBar(btnBar);
                tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Rischi")%>", tabbar));
	
                //------adding tables to tabs-----------------------
                tabbar.idParentRecord = <%= lCOD_CST%>
                tabbar.refreshTabUrl = "ANA_CST_Tabs.jsp";
                tabbar.RefreshAllTabs();

                tabbar.tabs[0].tabObj.actionParams ={
                    "Feachures": ANA_RSO_Feachures,
                    "AddNew":	{"url":"../Form_ANA_RSO_CAN/ANA_RSO_CAN_Form.jsp?ATTACH_URL=Form_ANA_CST/ANA_CST_Attach.jsp&ATTACH_SUBJECT=CSTRSO&lCOD_FAT_RSO=<%=lCOD_FAT_RSO%>",
                        "buttonIndex":0
                    },
                    "Delete":	{"url":"../Form_ANA_CST/ANA_CST_Delete.jsp?LOCAL_MODE=RSO",
                        "buttonIndex":2,
                        "target_element":document.all["ifrmWork"]
                    },		
                    "Edit":	{"url":"../Form_ANA_RSO_CAN/ANA_RSO_CAN_Form.jsp?ATTACH_URL=Form_ANA_CST/ANA_CST_Attach.jsp&ATTACH_SUBJECT=CSTRSO&lCOD_FAT_RSO=<%=lCOD_FAT_RSO%>",
                        "buttonIndex":1
                    }			  	
                };
                tabbar.tabs[0].center.click();
            <%} else {%>
                window.dialogHeight="255px";
            <%}%>
        </script>
    </body>
</html>
