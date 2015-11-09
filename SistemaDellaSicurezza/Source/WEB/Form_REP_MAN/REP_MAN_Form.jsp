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
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
    <head><title><%=ApplicationConfigurator.LanguageManager.getString("Opzioni.di.stampa")%></title></head>
    <link rel="stylesheet" href="../_styles/style.css">
    <link rel="stylesheet" href="../_styles/tabs.css">
    <script type="text/javascript" src="../_scripts/tabs.js"></script>
    <script type="text/javascript" src="../_scripts/tabbarButtonFunctions.js"></script>
    <script type="text/javascript" src="../_scripts/js_ANA_AZL.js"></script>
    <script type="text/javascript">
        window.dialogWidth="320px";
        window.dialogHeight="430px";
    </script>

    <body style="margin:0 0 0 0;">
        <form action="ANA_RSO_Set.jsp" method="POST"  target="helo" style="margin:0 0 0 0;">
            <table align="center" cellpadding="0" cellspacing="0" border=0 width="100%">
                <tr>
                    <td valign=top>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td align="center" class="title">
                                    <%=ApplicationConfigurator.LanguageManager.getString("Opzioni.di.stampa")%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="100%">
                                        <!-- ########################################################################################################## -->
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%
                                                    ToolBar.bShowDelete = false;
                                                    ToolBar.bShowSave = false;
                                                    ToolBar.bShowSearch = false;
                                                    ToolBar.bCanPrint = true;
                                                    ToolBar.bAlwaysShowPrint = true;
                                        %>
                                        <%=ToolBar.build(2)%>
                                        <script type="text/javascript">
                                            function isCheked(strName){
                                                var element = document.getElementById(strName);
                                                if (element != null) {
                                                    return strName+"="+(element.checked?"1":"0");
                                                } else {
                                                    return "";
                                                }
                                            }

                                            function PrintHandler(){
                                                var str="";
                                                str+=isCheked("as")+"&";
                                                str+=isCheked("ldl")+"&";
                                                str+=isCheked("r")+"&";
                                                str+=isCheked("rch")+"&";
                                                str+=isCheked("ief")+"&";
                                                str+=isCheked("d")+"&";
                                                 <%if (ApplicationConfigurator.isModuleEnabled(MODULES.ATT_LAV_MAC)){%>
                                                str+=isCheked("mam")+"&";<%}%>
                                                str+=isCheked("dpi")+"&";
                                                str+=isCheked("ss")+"&";
                                                window.returnValue=str;
                                                window.close();
                                            }
                                            ToolBar.Print.OnClick=PrintHandler;
                                        </script>
                                    </table>
                                    <!-- ########################################################################################################## -->
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Opzioni.di.stampa")%></legend>
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <br>
                                                <td>
                                                    <input type="checkbox" name="ldl" checked>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Luoghi.di.lavoro")%><br><br>
                                                    <input type="checkbox" name="as"  checked>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Operazioni.svolte")%><br><br>
                                                    <input type="checkbox" name="r" checked>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Rischi")%><br><br>
                                                     <%if(ApplicationConfigurator.isModuleEnabled(MODULES.IDX_RSO_CHI) == true){%>
                                                    <input type="checkbox" name="rch" checked>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Valutazione.rischio.chimico")%><br><br>
                                                    <%}%>
                                                    <input type="checkbox" name="ma" checked>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString(
                                                            ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                                            ? "Macchine.attrezzature.impianti.associate"
                                                            : "Macchine/Attrezzature.associate"
                                                            )%><br><br>
                                                    <%if (ApplicationConfigurator.isModuleEnabled(MODULES.ATT_LAV_MAC)){%>
                                                    <input type="checkbox" name="mam" checked>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString(
                                                            ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                                            ? "Macchine.attrezzature.impianti.associate.mansioni"
                                                            : "Macchine/Attrezzature.associate.mansioni"
                                                            )%><br><br><%}%>
                                                    <input type="checkbox" name="ief" checked>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Informazione.e.formazione")%><br><br>
                                                    <input type="checkbox" name="dpi" checked>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("D.P.I.")%><br><br>
                                                    <input type="checkbox" name="ss" checked>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Sorveglianza.sanitaria")%><br><br>
                                                    <input type="checkbox" name="d" checked>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Documentazione")%><br>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="dContainer" class="mainTabContainer" style="width:100%"></div>
                                </td>
                            </tr>
                        </table>
                    </td>
            </table>
        </form>
    </body>
</html>
