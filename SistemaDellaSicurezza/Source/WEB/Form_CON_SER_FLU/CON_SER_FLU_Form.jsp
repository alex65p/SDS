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
        <version number="1.0" date="19/05/2008" author="Giancarlo Servadei">
            <comments>
                <comment date="19/05/2008" author="Giancarlo Servadei">
                    <description>Create CON_SER_FLU_Form.jsp</description>
                </comment>		
            </comments> 
        </version>
    </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServFluidi.*" %>

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
        
        <title><%=ApplicationConfigurator.LanguageManager.getString("Fluidi")%></title>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
    </head>
    <script type="text/javascript">
        window.dialogWidth="700px";
        window.dialogHeight="395px";
    </script>
    <body>
        <%
            String strCOD_SRV = request.getParameter("ID_PARENT");
            String strCOD_FLU = request.getParameter("ID");
            String strPRO_CON = "";
            String strDES_CON = "";
            String strTIP_FLU_DIS = "";
            String strLUO_COL = "";
            String strDAT_INI_CON = "";
            String strDAT_FIN_CON = "";
            String strFLU_DES_1 = "";
            String strFLU_DES_2 = "";

            IContServFluidiHome home = (IContServFluidiHome) PseudoContext.lookup("ContServFluidiBean");
            IContServFluidi bean = null;

            IAnaContServHome con_ser_home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");
            IAnaContServ con_ser_bean = con_ser_home.findByPrimaryKey(Long.parseLong(strCOD_SRV));

            strPRO_CON = Formatter.format(con_ser_bean.getPRO_CON());
            strDES_CON = Formatter.format(con_ser_bean.getDES_CON());
            strFLU_DES_1 = Formatter.format(con_ser_bean.getFLU_DES_1());
            strFLU_DES_2 = Formatter.format(con_ser_bean.getFLU_DES_2());

            if (strCOD_FLU != null) {
                bean = home.findByPrimaryKey(new ContServFluidiPK(Long.parseLong(strCOD_SRV), Long.parseLong(strCOD_FLU)));

                // getting of object variables
                strTIP_FLU_DIS = Formatter.format(bean.getTIP_FLU_DIS());
                strLUO_COL = Formatter.format(bean.getLUO_COL());
                strDAT_INI_CON = Formatter.format(bean.getDAT_INI_CON());
                strDAT_FIN_CON = Formatter.format(bean.getDAT_FIN_CON());
            } else {
                strCOD_FLU = "";
            }
        %>
        
        <form action="CON_SER_FLU_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value="<%=(strCOD_FLU == null || strCOD_FLU.equals("")) ? "new" : "edt"%>">
            <input type="hidden" name="COD_FLU" value="<%=strCOD_FLU%>">
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
                                                <%=ApplicationConfigurator.LanguageManager.getString("Fluidi")%>
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
                                        <table  width="100%" border="0" cellpadding="3">
                                            <tr>
                                                <td style="width:20%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Progressivo.contratto/servizio")%>&nbsp;</b></td>
                                                <td style="width:25%;" align="left"><input type="text" name="PRO_CON" readonly value="<%=strPRO_CON%>"/></td>
                                                <td style="width:15%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</b></td>
                                                <td style="width:40%;" align="left"><textarea cols="38" rows="2" name="DES_CON" readonly><%=strDES_CON%></textarea></td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                    <br>
                                    <fieldset>
                                        <legend>
                                            <%=ApplicationConfigurator.LanguageManager.getString("Fluido")%>
                                        </legend>
                                        <table width="100%" border="0" cellpadding="3">
                                            <tr>
                                                <td style="width:20%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Tipo.di.fluido")%>&nbsp;</b></td>
                                                <td style="width:27%;" align="left"><input type="text" tabindex="1" size="26" maxlength="50" name="TIP_FLU_DIS" value="<%=strTIP_FLU_DIS%>"></td>
                                                <td style="width:17%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Luogo.di.collegamento")%></td>
                                                <td style="width:36%;" align="left"><input type="text" tabindex="2" size="43" maxlength="50" name="LUO_COL" value="<%=strLUO_COL%>"/></td>
                                            </tr>
                                            
                                            <tr>
                                                <td style="width:20%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.inizio.consegna")%>&nbsp;</td>
                                                <td style="width:27%;" align="left"><s2s:Date tabindex="3" id="DAT_INI_CON" name="DAT_INI_CON" value="<%=strDAT_INI_CON%>"/></td>
                                                <td style="width:17%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.fine.consegna")%>&nbsp;</td>
                                                <td style="width:36%;" align="left"><s2s:Date tabindex="4" id="DAT_FIN_CON" name="DAT_FIN_CON" value="<%=strDAT_FIN_CON%>"/></td>
                                            </tr>
                                        </table>	 
                                    </fieldset>
                                    <br>
                                    <fieldset>
                                        <legend>
                                            <%=ApplicationConfigurator.LanguageManager.getString("Dichiarazioni/Osservazioni.fluidi")%>
                                        </legend>
                                        <table width="100%" border="0" cellpadding="3">
                                            <tr>
                                                <td style="width:20%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Dichiarazione.di.responsabilità")%>&nbsp;</td>
                                                <td style="width:80%;" align="left"><textarea tabindex="5" name="FLU_DES_1"><%=strFLU_DES_1%></textarea></td>
                                            </tr>
                                            
                                            <tr>
                                                <td style="width:20%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Osservazioni.all'atto.della.restituzione")%>&nbsp;</td>
                                                <td style="width:80%;" align="left"><textarea tabindex="6" name="FLU_DES_2"><%=strFLU_DES_2%></textarea></td>
                                            </tr>
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
