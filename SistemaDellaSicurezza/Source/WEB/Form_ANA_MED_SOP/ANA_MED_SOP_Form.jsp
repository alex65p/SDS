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
<%-- 
    Document   : ANA_SOP_Form
    Created on : 22-mar-2011, 18.03.17
    Author     : Alessandro
--%>
<%@ page import="com.apconsulting.luna.ejb.Media.*"%>
<%@ page import="com.apconsulting.luna.ejb.Sopraluogo.*" %>
<%@ page import="com.apconsulting.luna.ejb.Procedimento.*" %>
<%@ page import="com.apconsulting.luna.ejb.Cantiere.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrOpere.*" %>
<%@ page import="s2s.utils.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<html>
    <head>
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

        <link rel=STYLESHEET href="../_styles/style.css" type="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <title>
            <%=ApplicationConfigurator.LanguageManager.getString("Foto")%>
        </title>
        <script>
            window.dialogWidth="816px";
            window.dialogHeight="290px";
        </script>
    </head>
    <body>
        <%
            String sCOD_MED_SOP = "";
            long lCOD_MED_SOP = 0;
            long lCOD_SOP = 0;
            long lCOD_PRO = 0;
            long lCOD_OPE = 0;
            long lCOD_CAN = 0;
            String sNUM_SOP = "";
            String sDAT_SOP = "";
            String sORA_SOP_INI = "";
            String sORA_SOP_FIN = "";
            String sCOD_SOP = "";
            String sORA_INI = "";
            String sMIN_INI = "";
            String sORA_FIN = "";
            String sMIN_FIN = "";

            String sNOM_MED = "";
            String sDES_MED = "";
            String sFILE = "";

            ISopraluogoHome home = null;
            ISopraluogo sopraluogo = null;
            IMediaHome home_med = null;
            IMedia media = null;

            if (request.getParameter("ID") != null) {
                sCOD_MED_SOP = (String) request.getParameter("ID");
                lCOD_MED_SOP = Long.parseLong(sCOD_MED_SOP);

                home_med = (IMediaHome) PseudoContext.lookup("MediaBean");
                media = home_med.findByPrimaryKey(lCOD_MED_SOP);

                sNOM_MED = media.getNOM_MED();
                sDES_MED = media.getDES_MED();
                sFILE = media.getFILE();
            }

            if (request.getParameter("ID_PARENT") != null) {
                sCOD_SOP = (String) request.getParameter("ID_PARENT");
                home = (ISopraluogoHome) PseudoContext.lookup("SopraluogoBean");
                lCOD_SOP = new Long(sCOD_SOP);
                sopraluogo = home.findByPrimaryKey(lCOD_SOP);

                lCOD_PRO = sopraluogo.getCOD_PRO();
                lCOD_OPE = sopraluogo.getCOD_OPE();
                lCOD_CAN = sopraluogo.getCOD_CAN();

                sNUM_SOP = sopraluogo.getNUM_SOP();
                sDAT_SOP = Formatter.format(sopraluogo.getDAT_SOP());

                int ini, fin;
                if (sopraluogo.getORA_INI() != null) {
                    sORA_SOP_INI = sopraluogo.getORA_INI().toString();

                    ini = sORA_SOP_INI.indexOf(':');
                    fin = sORA_SOP_INI.indexOf(':', (ini + 1));
                    sORA_INI = sORA_SOP_INI.substring(0, ini);
                    sMIN_INI = sORA_SOP_INI.substring((ini + 1), fin);
                }
                if (sopraluogo.getORA_FIN() != null) {
                    sORA_SOP_FIN = sopraluogo.getORA_FIN().toString();

                    ini = sORA_SOP_FIN.indexOf(':');
                    fin = sORA_SOP_FIN.indexOf(':', (ini + 1));
                    sORA_FIN = sORA_SOP_FIN.substring(0, ini);
                    sMIN_FIN = sORA_SOP_FIN.substring((ini + 1), fin);
                }
            }
        %>
        <!-- form for addind  -->
        <form ENCTYPE="multipart/form-data" action="ANA_MED_SOP_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <!--input type="hidden" name="SBM_MODE" value="<%=(lCOD_MED_SOP == 0) ? "new" : "edt"%>"-->
            <input type="hidden" name="COD_MED_SOP" value="<%=lCOD_MED_SOP%>">
            <input type="hidden" name="ID_PARENT" value="<%=lCOD_SOP%>">
            <table width="100%" border="0">
                <tr>
                    <% if (media != null) {%>
                <input name="SBM_MODE" type="Hidden" value="edt">
                <% } else {%>
                <input name="SBM_MODE" type="Hidden" value="new">
                <% }%>
                <td width="10" height="100%" valign="top">
                </td>
                <td valign="top">
                    <table  width="100%" border="0">
                        <tr>
                            <td class="title" colspan="2">
                                <%=ApplicationConfigurator.LanguageManager.getString("Foto")%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%">
                                    <%@ include file="../_include/ToolBar.jsp" %>
                                    <%
                                        ToolBar.bShowReturn = false;
                                        ToolBar.bShowSearch = false;
                                    %>
                                    <%=ToolBar.build(2)%>
                                </table>
                                <fieldset>
                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Sopralluogo")%></legend>
                                    <table width="100%" border="0">
                                        <tr>
                                            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Procedimento")%>:&nbsp;</b></td>
                                            <td> <%
                                                IProcedimentoHome pro_home = (IProcedimentoHome) PseudoContext.lookup("ProcedimentoBean");
                                                IProcedimento procedimento = pro_home.findByPrimaryKey(lCOD_PRO);
                                                String sDES_PRO = procedimento.getDES_PRO();
                                                %>
                                                <div style="width: 250px; background-color:transparent; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"><%=Formatter.format(sDES_PRO)%></div>
                                            </td>
                                            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Cantiere")%>:&nbsp;</b></td>
                                            <td> <%
                                                ICantiereHome can_home = (ICantiereHome) PseudoContext.lookup("CantiereBean");
                                                ICantiere cantiere = can_home.findByPrimaryKey(lCOD_CAN);
                                                String sNOM_CAN = cantiere.getNOM_CAN();
                                                %>
                                                <div style="width: 100px; background-color:transparent; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"><%=Formatter.format(sNOM_CAN)%></div>
                                            </td>
                                            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Opera")%>:&nbsp;</b></td>
                                            <td colspan="3">
                                                <div style="width: 170px; background-color:transparent; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
                                                <%
                                                if (lCOD_OPE != 0) {
                                                    IAnagrOpereHome ope_home = (IAnagrOpereHome) PseudoContext.lookup("AnagrOpereBean");
                                                    IAnagrOpere opera = ope_home.findByPrimaryKey(lCOD_OPE);
                                                    String sNOM_OPE = opera.getstrNOM_OPE();
                                                    out.print(Formatter.format(sNOM_OPE));
                                                } else {
                                                    out.print("&nbsp;");
                                                }
                                                %>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Numero.sopralluogo")%>:&nbsp;</b></td>
                                            <td><%=sNUM_SOP%></td>
                                            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Data")%>:&nbsp;</b></td>
                                            <td ><%=sDAT_SOP%></td>
                                            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Ora.inizio")%>:&nbsp;</b></td>
                                            <td align="left">
                                                <%=sORA_INI%>
                                                &nbsp;:&nbsp;
                                                <%=sMIN_INI%></td>
                                            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Ora.fine")%>:&nbsp;</b></td>
                                            <td align="left">
                                                <%=sORA_FIN%>
                                                &nbsp;:&nbsp;
                                                <%=sMIN_FIN%>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                    </table>
                    <fieldset>
                        <legend><%=media==null?"<b>":""%><%=ApplicationConfigurator.LanguageManager.getString("File")%><%=media==null?"</b>":""%></legend>
                        <table width="100%" border="0">
                            <tr>
                                <td>
                                    <div style="overflow:hidden;">
                                        <table width=100% border="0" cellspacing="5" cellpadding="0">
                                            <%if (sFILE != "") {%>
                                            <tr>
                                                <td colspan="4">
                                                    <a href="SHOW_Media.jsp?COD_MED=<%=sCOD_MED_SOP%>"><%=sFILE%></a>
                                                </td>
                                            </tr>
                                            <%}%>
                                            <tr>		
                                                <td width="100%" colspan="4"> 
                                                    <input tabindex = "18" name = "ATTACHMENT_FILE" type = "file" value = "" style="width:100%">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 5%;"><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</td>
                                                <td style="width: 40%;">
                                                    <input type="text" size="50" maxlength="50"  name="NOM_MED_SOP" value="<%=sNOM_MED%>">
                                                </td>
                                                <td align="right" style="width: 10%;"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                                <td style="width: 45%;">
                                                    <textarea cols="50" rows="3" maxlength="150" name="DES_MED_SOP"><%=sDES_MED%></textarea>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="100%"><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
                            </tr>                                        
                        </table>
                    </fieldset>
                </td>
                </tr>
            </table>
        </form>
        <iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <%
                    if (media != null) {
        %>
        <script>
            window.dialogHeight="310px";
        </script>
        <%}%>     
    </body>
</html>
