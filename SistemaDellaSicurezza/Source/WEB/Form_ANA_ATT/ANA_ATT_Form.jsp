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
    Document   : ANA_ATT_Form
    Created on : 24-mar-2011, 17.34.29
    Author     : Alessandro
--%>
<%@page import="com.apconsulting.luna.ejb.AnagrDocumento.AnagDocumentoFileInfo"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="com.apconsulting.luna.ejb.AnagrAttivitaCantieri.IAnagrAttivitaCantieriHome"%>
<%@page import="com.apconsulting.luna.ejb.AnagrAttivitaCantieri.IAnagrAttivitaCantieri"%>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>
<%@page import="java.text.*"%>
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
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuAnagraficagenerale,3) + "</title>");
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
            window.dialogWidth="796px";
            window.dialogHeight="290px";
        </script>
    </head>
    <body>
        <%! long lCOD_DOC;
            String strDES_ATT;
            String strNOM_ATT;
            String strCOD;
            boolean bExtended = false;
        %>
        <%
            lCOD_DOC = 0;
            strDES_ATT = "";
            strCOD = "";
            strNOM_ATT = "";
            IAnagrAttivitaCantieri bean = null;
            IAnagrAttivitaCantieriHome home = null;
            AnagDocumentoFileInfo info = null;
            AnagDocumentoFileInfo infoLink = null;
            String strID = "";
            if (request.getParameter("ID") != null) {
                strID = (String) request.getParameter("ID");
                home = (IAnagrAttivitaCantieriHome) PseudoContext.lookup("AnagrAttivitaCantieriBean");
                Long att_id = new Long(strID);
                bean = home.findByPrimaryKey(att_id);

                lCOD_DOC = att_id.longValue();                          //1
                strDES_ATT = Formatter.format(bean.getstrDES_ATT());
                strCOD = Formatter.format(bean.getstrCOD());
                strNOM_ATT = Formatter.format(bean.getstrNOM_ATT());
                info = bean.getFileInfo();
                infoLink = bean.getFileInfoLink();                     	//2
            }
        %>
        <!-- form for addind  -->
        <form action="ANA_ATT_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;"ENCTYPE="multipart/form-data">
            <input name="SBM_MODE" id="SBM_MODE" type="Hidden" value="<%if (lCOD_DOC != 0) {
                    out.print("edt");
                } else {
                    out.print("new");
                }%>">
            <input type="hidden" name="COD_DOC" value="<%=lCOD_DOC%>">
            <input type="hidden" name="ID_PARENT" value="<%//=request.getParameter("ID_PARENT")%>">
            <table width="100%" border="0">
                <tr>
                    <td width="10" height="100%" valign="top">
                    </td>
                    <td valign="top">
                        <table  width="100%" border="0">
                            <tr><td class="title" colspan="2">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                        (SubMenuAnagraficagenerale,3,<%=request.getParameter("ID")%>));
                                    </script>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="100%">
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%=ToolBar.build(2)%>
                                    </table>
                                    <fieldset>
                                        <legend>Anagrafica Attività</legend>
                                        <table  width="100%" border="0">
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Codice")%>&nbsp;</b></td>
                                                <td colspan="1"><input tabindex="1" size="" type="text" maxlength="15" name="COD" id="COD" value="<%=strCOD%>"></td>
                                                <td align="right" width="16%"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
                                                <td colspan="1"><input tabindex="1" size="95" type="text" maxlength="55" name="NOM_ATT" id="NOM_ATT" value="<%=strNOM_ATT%>"></td>
                                            </tr>
                                            <tr>
                                                <td align="right" ><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                                <td colspan="3"><s2s:textarea tabindex="1" cols="1" rows="3" maxlength="250" name="DES_ATT" id="DES_ATT"><%=Formatter.format(strDES_ATT)%></s2s:textarea></td>
                                            </tr>
                                            <tr>
                                                <td align="right" ><b></td>
                                                <td colspan="3"></td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                            <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <%
                                            if (!ApplicationConfigurator.isModuleEnabled(MODULES.DOC_LINK)) {
                                                out.println("<td align=\"left\" width=\"50%\">");
                                            } else {
                                                out.println("<td align=\"left\" width=\"50%\">");
                                            }
                                        %>
                                        <fieldset>
                                            <legend><%=ApplicationConfigurator.LanguageManager.getString("File")%></legend>
                                            <div style="overflow:hidden;">
                                                <table width=100% border="0" cellspacing="5" cellpadding="0">
                                                    <%
                                                        if (info != null) {
                                                            NumberFormat nf = NumberFormat.getInstance();
                                                            nf.setMinimumFractionDigits(2);
                                                            nf.setMaximumFractionDigits(3);
                                                    %>
                                                    <tr>
                                                        <td align="center" width="15%"><input tabindex="5" type="checkbox" class="checkbox" name="ATTACHMENT_ACTION" value="delete"><%=ApplicationConfigurator.LanguageManager.getString("Delete")%></td>
                                                        <td align="center" width="40%"><a href="ANA_ATT_File.jsp?ID=<%=lCOD_DOC%>&TYPE=FILE"><%=info.strName%></a></td>
                                                        <td align="left" width="30%"><%=ApplicationConfigurator.LanguageManager.getString("Dimensione.(KB)")%>:&nbsp;&nbsp;<%=Formatter.format(nf.format((float) info.lSize / 1024))%></td>
                                                        <td align="left" width="15%"><%=ApplicationConfigurator.LanguageManager.getString("Ultima.modifica")%>:&nbsp;&nbsp;<%=Formatter.format(info.dtModified)%></td>
                                                    </tr>
                                                    <% } else {%>
                                                    <tr>
                                                        <td width="100%"><input tabindex="18" name="ATTACHMENT_FILE" type="file" style="width:100%"></td>
                                                    </tr>
                                                    <% }%>
                                                </table>
                                            </div>
                                        </fieldset>
                                        <%
                                            if (!ApplicationConfigurator.isModuleEnabled(MODULES.DOC_LINK)) {
                                                out.println("<td width=\"50%\">");
                                            } else {
                                                out.println("<td width=\"50%\" style=\"display:none\">");
                                            }
                                        %>
                                        <fieldset>
                                            <legend><%=ApplicationConfigurator.LanguageManager.getString("File.link")%></legend>
                                            <div style="overflow:hidden;">
                                                <table width="100%" border="0" cellspacing="5" cellpadding="0">
                                                    <%
                                                        if (infoLink != null) {
                                                            NumberFormat nf = NumberFormat.getInstance();
                                                            nf.setMinimumFractionDigits(2);
                                                            nf.setMaximumFractionDigits(3);
                                                    %>
                                                    <tr>
                                                        <td align="center" width="15%">
                                                            <input tabindex="6" type="checkbox" class="checkbox" name="ATTACHMENT_ACTION_LINK" value="delete"><%=ApplicationConfigurator.LanguageManager.getString("Delete")%>
                                                        </td>
                                                        <td align="center" width="40%">
                                                            <a href="file:///<%=infoLink.strLinkDocument%>" target="_blank"><%=infoLink.strName%></a>
                                                        </td>
                                                        <td align="left" width="30%">
                                                            <%=ApplicationConfigurator.LanguageManager.getString("Dimensione.(KB)")%>:&nbsp;&nbsp;<%=Formatter.format(nf.format((float) infoLink.lSize / 1024))%>
                                                        </td>
                                                        <td align="left" width="15%">
                                                            <%=ApplicationConfigurator.LanguageManager.getString("Ultima.modifica")%>:&nbsp;&nbsp;<%=Formatter.format(infoLink.dtModified)%>
                                                        </td>
                                                    </tr>
                                                    <% } else {%>
                                                    <tr>
                                                        <td width="100%"><input tabindex="18" name="ATTACHMENT_FILE_LINK" type="file" style="width:100%" ></td>
                                                    </tr>
                                                    <% }%>
                                                </table>
                                            </div>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                            <td colspan="100%"><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td-->
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <form action="ANA_ATT_File.jsp" name="frmFile">
            <input type="hidden" name="ID" value="<%=lCOD_DOC%>">
        </form>
        <iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
    </body>
</html>
