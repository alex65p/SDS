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
    Document   : CON_SER_CEN_EME_Form
    Created on : 21-mag-2008, 11.45.55
    Author     : Giancarlo Servadei
--%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServCentriEmergenza.*" %>

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
        <script type="text/javascript" src="../_scripts/tabs.js"></script>
        <script type="text/javascript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <link rel="stylesheet" href="../_styles/style.css" />
        <link rel="stylesheet" href="../_styles/tabs.css" />
        
        <title><%=ApplicationConfigurator.LanguageManager.getString("Centri.emergenza")%></title>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
    </head>
    <script type="text/javascript">
        window.dialogWidth="700px";
        window.dialogHeight="310px";
    </script>
    <body>
        <%
            String strCOD_SRV = request.getParameter("ID_PARENT");
            String strCOD_CEN_EME = request.getParameter("ID");
            String strPRO_CON = "";
            String strDES_CON = "";
            String strDES = "";
            String strRIF = "";
            String strCEN_EME_DES = "";

            IContServCentriEmergenzaHome home = (IContServCentriEmergenzaHome) PseudoContext.lookup("ContServCentriEmergenzaBean");
            IContServCentriEmergenza bean = null;

            IAnaContServHome con_ser_home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");
            IAnaContServ con_ser_bean = con_ser_home.findByPrimaryKey(Long.parseLong(strCOD_SRV));

            strPRO_CON = Formatter.format(con_ser_bean.getPRO_CON());
            strDES_CON = Formatter.format(con_ser_bean.getDES_CON());
            strCEN_EME_DES = Formatter.format(con_ser_bean.getCEN_EME_DES());

            if (strCOD_CEN_EME != null) {
                bean = home.findByPrimaryKey(new ContServCentriEmergenzaPK(Long.parseLong(strCOD_SRV), Long.parseLong(strCOD_CEN_EME)));

                // getting of object variables
                strDES = Formatter.format(bean.getDES());
                strRIF = Formatter.format(bean.getRIF());
            } else {
                strCOD_CEN_EME = "";
            }
        %>
        
        <form action="CON_SER_CEN_EME_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value="<%=(strCOD_CEN_EME == null || strCOD_CEN_EME.equals("")) ? "new" : "edt"%>">
            <input type="hidden" name="COD_CEN_EME" value="<%=strCOD_CEN_EME%>">
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
                                                <%=ApplicationConfigurator.LanguageManager.getString("Centri.emergenza")%>
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
                                        <table  width="100%" border="0" cellspacing="5">
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
                                            <%=ApplicationConfigurator.LanguageManager.getString("Centro.di.emergenza")%>
                                        </legend>
                                        <table width="100%" border="0" cellspacing="5">
                                            <tr>
                                                <td style="width:20%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                                <td style="width:40%;" align="left"><input tabindex="1" type="text" size="45" maxlength="50" name="DES" value="<%=strDES%>" /></td>
                                                <td style="width:20%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Riferimento")%></b></td>
                                                <td style="width:20%;" align="left"><input tabindex="2" type="text" size="22" maxlength="50" name="RIF" value="<%=strRIF%>" /></td>
                                            </tr>
                                        </table>	 
                                    </fieldset>
                                    <br>
                                    <fieldset>
                                        <legend>
                                            <%=ApplicationConfigurator.LanguageManager.getString("Annotazioni.centri.emergenza")%>
                                        </legend>
                                        <table width="100%" border="0" cellspacing="5">
                                            <tr>
                                                <td style="width:20%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Annotazioni")%>&nbsp;</td>
                                                <td style="width:80%;" align="left"><textarea tabindex="3" name="CEN_EME_DES"><%=strCEN_EME_DES%></textarea></td>
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
