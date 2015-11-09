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
    Document   : CON_SER_SER_SAN_Form
    Created on : 21-mag-2008, 16.38.33
    Author     : Giancarlo Servadei
--%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServServiziSanitari.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../_include/ToolBar.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
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
        
        <script type="text/javascript" src="../_scripts/tabs.js"></script>
        <script type="text/javascript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <link rel="stylesheet" href="../_styles/style.css" />
        <link rel="stylesheet" href="../_styles/tabs.css" />
        
        <title><%=ApplicationConfigurator.LanguageManager.getString("Servizi.sanitari")%></title>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
    </head>
    <script type="text/javascript">
        window.dialogWidth="700px";
        window.dialogHeight="390px";
    </script>
    <body>
        <%
            String strCOD_SRV = request.getParameter("ID_PARENT");
            String strCOD_SRV_SAN = request.getParameter("ID");
            String strPRO_CON = "";
            String strDES_CON = "";
            String strDES_SRV_VIT = "";
            String strORA_IMP = "";
            String strDAT_INI_IMP = "";
            String strDAT_FIN_IMP = "";
            String strSER_SAN_DES_1 = "";
            String strSER_SAN_DES_2 = "";
            String strSER_SAN_DES_3 = "";

            IContServServiziSanitariHome home = (IContServServiziSanitariHome) PseudoContext.lookup("ContServServiziSanitariBean");
            IContServServiziSanitari bean = null;

            IAnaContServHome con_ser_home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");
            IAnaContServ con_ser_bean = con_ser_home.findByPrimaryKey(Long.parseLong(strCOD_SRV));

            strPRO_CON = Formatter.format(con_ser_bean.getPRO_CON());
            strDES_CON = Formatter.format(con_ser_bean.getDES_CON());
            strSER_SAN_DES_1 = Formatter.format(con_ser_bean.getSER_SAN_DES_1());
            strSER_SAN_DES_2 = Formatter.format(con_ser_bean.getSER_SAN_DES_2());
            strSER_SAN_DES_3 = Formatter.format(con_ser_bean.getSER_SAN_DES_3());

            if (strCOD_SRV_SAN != null) {
                bean = home.findByPrimaryKey(new ContServServiziSanitariPK(Long.parseLong(strCOD_SRV), Long.parseLong(strCOD_SRV_SAN)));

                // getting of object variables
                strDES_SRV_VIT = Formatter.format(bean.getDES_SRV_VIT());
                strDAT_INI_IMP = Formatter.format(bean.getDAT_INI_IMP());
                strDAT_FIN_IMP = Formatter.format(bean.getDAT_FIN_IMP());
                strORA_IMP = Formatter.format(bean.getORA_IMP());
            } else {
                strCOD_SRV_SAN = "";
            }
        %>
        
        <form action="CON_SER_SER_SAN_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value="<%=(strCOD_SRV_SAN == null || strCOD_SRV_SAN.equals("")) ? "new" : "edt"%>">
            <input type="hidden" name="COD_SRV_SAN" value="<%=strCOD_SRV_SAN%>">
            <input type="hidden" name="COD_SRV" value="<%=strCOD_SRV%>">
            <table width="100%" border="0">
                <tr>
                    <td valign="top">
                        <table  width="100%">
                            <tr>
                                <td>
                                    <table width="100%" border="0">
                                        <tr> 
                                            <td class="title" style="width:100%;">
                                                <%=ApplicationConfigurator.LanguageManager.getString("Servizi.sanitari")%>
                                            </td> 
                                            <td>   
                                                <%
                                                ToolBar.bCanDelete = (bean != null);
                                                ToolBar.bShowPrint = false;
                                                ToolBar.bShowReturn = false;
                                                ToolBar.bShowSearch = false;
                                                %>	
                                                <%=ToolBar.build(2)%> 
                                            </td>
                                        </tr>
                                    </table>
                                    
                                    
                                    <fieldset>
                                        <legend>
                                            <%=ApplicationConfigurator.LanguageManager.getString("Servizio.commissionato")%>
                                        </legend>
                                        <table width="100%" border="0" cellspacing="5">
                                            <tr>
                                                <td style="width:20%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Progressivo.contratto/servizio")%>&nbsp;</b></td>
                                                <td style="width:25%;" align="left"><input type="text" name="PRO_CON" readonly value="<%=strPRO_CON%>" /></td>
                                                <td style="width:15%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</b></td>
                                                <td style="width:40%;" align="left"><textarea cols="38" rows="2" name="DES_CON" readonly><%=strDES_CON%></textarea></td>
                                            </tr>
                                            
                                        </table>
                                    </fieldset>
                                    <br>
                                    <fieldset>
                                        <legend>
                                            <%=ApplicationConfigurator.LanguageManager.getString("Servizio.sanitario")%>
                                        </legend>
                                        <table width="100%" border="0" cellspacing="5">
                                            <tr>
                                                <td style="width:20%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Designazione.dei.servizi.vita")%></b>&nbsp;</td>
                                                <td style="width:43%;" align="left"><input type="text" tabindex="1" size="49" maxlength="50" name="DES_SRV_VIT" value="<%=strDES_SRV_VIT%>" /></td>
                                                <td style="width:20%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Orario.d'impiego")%>&nbsp;</td>
                                                <td style="width:17%;" align="left"><input type="text" size="18" tabindex="2" maxlength="15" name="ORA_IMP" value="<%=Formatter.format(strORA_IMP)%>" /></td>
                                            </tr>
                                            
                                            <tr>
                                                <td style="width:20%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.inizio.impiego")%>&nbsp;</td>
                                                <td style="width:43%;" align="left"><s2s:Date tabindex="3" id="DAT_INI_IMP" name="DAT_INI_IMP" value="<%=strDAT_INI_IMP%>"/></td>
                                                <td style="width:20%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.fine.impiego")%>&nbsp;</td>
                                                <td style="width:17%;" align="left"><s2s:Date tabindex="4" id="DAT_FIN_IMP" name="DAT_FIN_IMP" value="<%=strDAT_FIN_IMP%>"/></td>
                                            </tr>
                                        </table>	 
                                    </fieldset>
                                    <br>
                                    <fieldset>
                                        <legend>
                                            <%=ApplicationConfigurator.LanguageManager.getString("Dichiarazioni/Annotazioni.servizi.sanitari")%>
                                        </legend>
                                        <table width="100%" border="0" cellspacing="5">
                                            <tr>
                                                <td style="width:20%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Dichiarazione.di.responsabilità")%>&nbsp;</td>
                                                <td style="width:80%;" align="left"><textarea tabindex="5" name="SER_SAN_DES_1"><%=strSER_SAN_DES_1%></textarea></td>
                                            </tr>
                                            
                                            <tr>
                                                <td style="width:20%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Annotazioni")%>&nbsp;</td>
                                                <td style="width:80%;" align="left"><textarea tabindex="6" name="SER_SAN_DES_2"><%=strSER_SAN_DES_2%></textarea></td>
                                            </tr>
                                            <!--
                                            <tr>
                                                <td style="width:20%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Annotazioni.aggiuntive")%>&nbsp;</td>
                                                <td style="width:80%;" align="left"><textarea tabindex="7" name="SER_SAN_DES_3"><%=strSER_SAN_DES_3%></textarea></td>
                                            </tr>
                                            -->
                                        </table>	 
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>  
            </table>
        </form>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
    </body>
</html>
