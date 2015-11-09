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
    Document   : CON_SER_PRE_MAT_Form
    Created on : 22-mag-2008, 15.06.16
    Author     : Giancarlo Servadei
--%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/ContServPrestitoMateriali/ContServPrestitoMaterialiBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ContServPrestitoMateriali/ContServPrestitoMaterialiBean.jsp"%>

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
        
        <title><%=ApplicationConfigurator.LanguageManager.getString("Prestiti.materiali")%></title>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
    </head>
    <script type="text/javascript">
        window.dialogWidth="700px";
        window.dialogHeight="430px";
    </script>
    <body>
        <%
            String strCOD_SRV = request.getParameter("ID_PARENT");
            String strCOD_PRE_MAT = request.getParameter("ID");
            String strPRO_CON = "";
            String strDES_CON = "";
            String strTIP_MAT = "";
            String strLUO_MES_DIS = "";
            String strDAT_INI_PRE = "";
            String strDAT_FIN_PRE = "";
            String strPRE_MAT_DES_1 = "";
            String strPRE_MAT_DES_2 = "";
            String strPRE_MAT_ASS_APP_RAD = "";
            String strPRE_MAT_ASS_TEL_CEL = "";

            IContServPrestitoMaterialiHome home = (IContServPrestitoMaterialiHome) PseudoContext.lookup("ContServPrestitoMaterialiBean");
            IContServPrestitoMateriali bean = null;

            IAnaContServHome con_ser_home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");
            IAnaContServ con_ser_bean = con_ser_home.findByPrimaryKey(Long.parseLong(strCOD_SRV));

            strPRO_CON = Formatter.format(con_ser_bean.getPRO_CON());
            strDES_CON = Formatter.format(con_ser_bean.getDES_CON());
            strPRE_MAT_DES_1 = Formatter.format(con_ser_bean.getPRE_MAT_DES_1());
            strPRE_MAT_DES_2 = Formatter.format(con_ser_bean.getPRE_MAT_DES_2());
            strPRE_MAT_ASS_APP_RAD = Formatter.format(con_ser_bean.getPRE_MAT_ASS_APP_RAD());
            strPRE_MAT_ASS_TEL_CEL = Formatter.format(con_ser_bean.getPRE_MAT_ASS_TEL_CEL());

            if (strCOD_PRE_MAT != null) {
                bean = home.findByPrimaryKey(new ContServPrestitoMaterialiPK(Long.parseLong(strCOD_SRV), Long.parseLong(strCOD_PRE_MAT)));

                // getting of object variables
                strTIP_MAT = Formatter.format(bean.getTIP_MAT());
                strLUO_MES_DIS = Formatter.format(bean.getLUO_MES_DIS());
                strDAT_INI_PRE = Formatter.format(bean.getDAT_INI_PRE());
                strDAT_FIN_PRE = Formatter.format(bean.getDAT_FIN_PRE());
                
            } else {
                strCOD_PRE_MAT = "";
            }
        %>
        
        <form action="CON_SER_PRE_MAT_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value="<%=(strCOD_PRE_MAT == null || strCOD_PRE_MAT.equals("")) ? "new" : "edt"%>">
            <input type="hidden" name="COD_PRE_MAT" value="<%=strCOD_PRE_MAT%>">
            <input type="hidden" name="COD_SRV" value="<%=strCOD_SRV%>">
            <table width="100%" border="0">
                <tr>
                    <td valign="top">
                        <table  width="100%">
                            <tr>
                                <td>
                                    <table width="100%" border="0">
                                        <tr> 
                                            <td class="title" style="width:100%">
                                                <%=ApplicationConfigurator.LanguageManager.getString("Prestito.materiali")%>
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
                                            <%=ApplicationConfigurator.LanguageManager.getString("Prestito.materiali")%>
                                        </legend>
                                        <table width="100%" border="0" cellspacing="5">
                                            <tr>
                                                <td style="width:20%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Tipo.di.materiale")%></b>&nbsp;</td>
                                                <td style="width:27%;" align="left"><input type="text" size="26" tabindex="1" maxlength="50" name="TIP_MAT" value="<%=strTIP_MAT%>" /></td>
                                                <td style="width:17%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Luogo.di.messa.a.disposizione")%>&nbsp;</td>
                                                <td style="width:36%;" align="left"><input type="text" size="43" tabindex="2" maxlength="50" name="LUO_MES_DIS" value="<%=strLUO_MES_DIS%>" /></td>
                                            </tr>
                                            
                                            <tr>
                                                <td style="width:20%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.inizio.prestito")%>&nbsp;</td>
                                                <td style="width:27%;" align="left"><s2s:Date tabindex="3" id="DAT_INI_PRE" name="DAT_INI_PRE" value="<%=strDAT_INI_PRE%>"/></td>
                                                <td style="width:17%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.fine.prestito")%>&nbsp;</td>
                                                <td style="width:36%;" align="left"><s2s:Date tabindex="4" id="DAT_FIN_PRE" name="DAT_FIN_PRE" value="<%=strDAT_FIN_PRE%>"/></td>
                                            </tr>
                                        </table>	 
                                    </fieldset>
                                    
                                    <br>
                                        
                                    <fieldset>
                                        <legend>
                                            <%=ApplicationConfigurator.LanguageManager.getString("Dichiarazioni/Osservazioni.prestiti.materiali")%>
                                        </legend>
                                        <table width="100%" border="0" cellspacing="5">
                                            <tr>
                                                <td style="width:20%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Dichiarazione.di.responsabilità")%>&nbsp;</td>
                                                <td style="width:80%;" align="left" colspan="6"><textarea tabindex="5" name="PRE_MAT_DES_1"><%=Formatter.format(strPRE_MAT_DES_1)%></textarea></td>
                                            </tr>
                                            
                                            <tr>
                                                <td style="width:20%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Osservazioni.all'atto.della.restituzione")%>&nbsp;</td>
                                                <td style="width:80%;" align="left" colspan="6"><textarea tabindex="6" name="PRE_MAT_DES_2"><%=strPRE_MAT_DES_2%></textarea></td>
                                            </tr>
                                            
                                            <!--tr><td width="100%" colspan="6"><br /></td></tr-->
                                            
                                            <tr>
                                                <td style="width:22%;" colspan="2"><br /></td>
                                                <td style="width:15%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Assegnazione.apparato.radio")%></td>
                                                <td style="width:20%;" align="left"><input type="radio" name="PRE_MAT_ASS_APP_RAD" value="S" class="checkbox" <%=(strPRE_MAT_ASS_APP_RAD.equals("S")) ? "checked" : ""%> />
                                                                                    <%=ApplicationConfigurator.LanguageManager.getString("Si")%>
                                                                                  <input type="radio" name="PRE_MAT_ASS_APP_RAD" value="N" class="checkbox" <%=(strPRE_MAT_ASS_APP_RAD.equals("N")) ? "checked" : ""%> />
                                                                                    <%=ApplicationConfigurator.LanguageManager.getString("No")%></td>
                                                <td style="width:8%;"><br /></td>              
                                                <td style="width:15%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Assegnazione.telefono.cellulare")%></td>
                                                <td style="width:20%;" align="left"><input type="radio" name="PRE_MAT_ASS_TEL_CEL" value="S" class="checkbox" <%=(strPRE_MAT_ASS_TEL_CEL.equals("S")) ? "checked" : ""%> />
                                                                                    <%=ApplicationConfigurator.LanguageManager.getString("Si")%>
                                                                                  <input type="radio" name="PRE_MAT_ASS_TEL_CEL" value="N" class="checkbox" <%=(strPRE_MAT_ASS_TEL_CEL.equals("N")) ? "checked" : ""%> />
                                                                                    <%=ApplicationConfigurator.LanguageManager.getString("No")%></td>
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
