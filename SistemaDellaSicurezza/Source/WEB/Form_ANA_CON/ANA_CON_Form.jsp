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

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%@ include file="ANA_CON_Util.jsp"%>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<html>
    <head>
        <script>
            // document.write("<title>" + getCompleteMenuPath(SubMenuSopralluoghi,0) + "</title>");
            document.write("<title>" +"Constatazioni"+ "</title>");
        </script>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
    </head>
    <script>
        window.dialogWidth="816px";
        window.dialogHeight="460px";
    </script>
    <script language="JavaScript" src="../_scripts/textarea.js"></script>
    <body>
        <%
          %>

        <!-- form for addind  -->
        <form action="TPL_DOC_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <table width="100%" border="0">
                <tr>
                    <td width="10" height="100%" valign="top">
                    </td>
                    <td valign="top">
                        <table  width="100%" border="0">
                            <tr><td class="title" colspan="2">
                                    <%=ApplicationConfigurator.LanguageManager.getString("Constatazioni")%>
                                </td></tr>


                            <tr>
                                <td>
                                    <table width="100%">
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%=ToolBar.build(2)%>
                                    </table>
                                    <fieldset>
                                        <legend></legend>
                                        <table  width="100%" border="0">
                                            <tr>
                                                <td align="right" width="15%"><b><%=ApplicationConfigurator.LanguageManager.getString("Procedimento")%>&nbsp;</b></td>
                                                <td >Linea B1
                                                </td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Opera")%>&nbsp;</td>
                                                <td >
                                                </td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Cantiere")%>&nbsp;</td>
                                                <td >Pi30
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Numero.sopralluogo")%>&nbsp;</b></td>
                                                <td >116/10</td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data")%>&nbsp;</td>
                                                <td >03/09/2010</td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Ora.(hh.mm)")%>&nbsp;</td>
                                                <td align="left">06:01</td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Progressivo")%>&nbsp;</b></td>
                                                <td ><input tabindex="4" size="10" type="text" maxlength="10" name="" value=""></td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                                <td colspan="3" width="60%"><s2s:textarea tabindex="1" cols="1" rows="3" maxlength="200"><%=0%></s2s:textarea></td>
                                            </tr>
                                        </table>
                                    </fieldset></td>
                            </tr>
                            <tr>
                                <td colspan="100%"><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td-->
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr><td colspan="100%"><iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe></td></tr>
            </table>
        </form>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <%
                    //-------Loading of Tabs--------------------
                    out.print(BuildRischiRilevatiTab());
                    // -----------------------------------------
%>
        <script language="JavaScript">
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
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Rischi.rilevati")%>", tabbar));


            //------adding tables to tabs-----------------------
            tabbar.tabs[0].tabObj.addTable( document.all["RischiRilevatiHeader"],document.all["RischiRilevati"], true);

            tabbar.refreshTabUrl="ANA_CON_Tabs.jsp";

            //--------------------------------------------------------------------
            tabbar.tabs[0].tabObj.actionParams ={"Feachures":ANA_RIS_RIL_Feachures,
                "AddNew":	{"url":"../Form_ANA_RIS_RIL/ANA_RIS_RIL_Form.jsp",
                    "disabled": false,
                    "buttonIndex":0
                }
            };
        </script>
    </body>
</html>



