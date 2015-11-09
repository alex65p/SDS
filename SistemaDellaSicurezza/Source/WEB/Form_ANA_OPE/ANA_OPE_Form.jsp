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


<%@page import="com.apconsulting.luna.ejb.AnagrOpere.IAnagrOpere"%>
<%@page import="com.apconsulting.luna.ejb.AnagrOpere.IAnagrOpereHome"%>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<script>
</script>
<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuAnagraficagenerale,2) + "</title>");
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
    <script>
        window.dialogWidth="700px";
        window.dialogHeight="225px";
    </script>
    </head>
    <body>
        <%!            long lCOD_OPE;
            String strDES_OPE;
            String strNOM_OPE;
            boolean bExtended=false;
        %>
        <%
            lCOD_OPE = 0;
            strDES_OPE = "";
            strNOM_OPE = "";

            IAnagrOpere bean = null;
            IAnagrOpereHome home = (IAnagrOpereHome) PseudoContext.lookup("AnagrOpereBean");

            if (request.getParameter("ID") != null) {
                String strCOD_OPE = request.getParameter("ID");

                Long ope_id = new Long(strCOD_OPE);
                bean = home.findByPrimaryKey(ope_id);

                lCOD_OPE = ope_id.longValue();                          //1
                strDES_OPE = Formatter.format(bean.getstrDES_OPE());  
                strNOM_OPE = Formatter.format(bean.getstrNOM_OPE());                     	//2
            }
        %>
        <!-- form for addind azienda -->
        <form action="ANA_OPE_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0; ">
            <input name="SBM_MODE" type="Hidden" value="<%=(lCOD_OPE == 0) ? "new" : "edt"%>">
            <input type="hidden" name="OPE_ID" value="<%=lCOD_OPE%>">
            <input type="hidden" name="ID_PARENT" value="<%//=request.getParameter("ID_PARENT")%>">
            <table width="100%" border="0">
                <tr>
                    <td valign="top">
                        <table  width="100%" border="0">
                            <tr>
                                <td class="title">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                        (SubMenuAnagraficagenerale,2,<%=request.getParameter("ID")%>));
                                    </script>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <!-- 	********************************** -->
                                    
                                   
                                    
                                    <table width="100%" border="0">
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%=ToolBar.build(3)%>
                                        
                                                                                    <%
                                                    if (Security.isExtendedMode()){
                                                            bExtended=true;
                                                    }
                                            %>
                                    </table>
                                    <!-- 	********************************** -->
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <fieldset>  
                                        <legend>Descrizione Opera</legend>
                                        <table  width="100%" border="0" cellspacing='5' cellpadding='0'>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Codice")%>&nbsp;</b></td>
                                                <td align="left" colspan="3">
                                                 <td align="left" width="89.5%" colspan="9">
                                                    <input tabindex="2" size="110" type="text" maxlength="100" name="NOM_OPE" id="NOM" value="<%=strNOM_OPE%>"></td>
                                            </tr>
                                            <tr>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                                <td align="left" colspan="3">
                                                <td align="left" width="89.5%" colspan="9"><TEXTAREA tabindex="16" cols="70" rows="2" maxlength="4000" name="DES_OPE"><%=Formatter.format(strDES_OPE)%></TEXTAREA></td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <script>
                    window.dialogWidth="700px";
                    window.dialogHeight="225px";
                </script>
            </table>
            <tr>
                <td colspan="100%"><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
            </tr>
        </form>
        <!-- /form for addind Dipendente -->
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" >none</iframe>




    </body>
</html>
