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
    Document   : APP_PRO_SOS_Form
    Created on : 25-mag-2008, 9.16.46
    Author     : Giancarlo Servadei
--%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>
<%@ page import="com.apconsulting.luna.ejb.AppProdottiSostanze.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../_include/ToolBar.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<html>
<head>
    <script type="text/javascript" src="../_scripts/tabs.js"></script>
    <script type="text/javascript" src="../_scripts/tabbarButtonFunctions.js"></script>
    <link rel="stylesheet" href="../_styles/style.css" />
    <link rel="stylesheet" href="../_styles/tabs.css" />
    
    <title><%=ApplicationConfigurator.LanguageManager.getString("Prodotti/Sostanze")%></title>
    <LINK REL=STYLESHEET
          HREF="../_styles/style.css"
          TYPE="text/css">
</head>
<script type="text/javascript">
    window.dialogWidth="440px";
    window.dialogHeight="253px";
</script>
<body>
        <%
            String strCOD_SRV = request.getParameter("ID_PARENT");
            String strCOD_PRO_SOS = request.getParameter("ID");
            
            String strDES = "";
            String strPRO_SOS_DES = "";

            IAppProdottiSostanzeHome home = (IAppProdottiSostanzeHome) PseudoContext.lookup("AppProdottiSostanzeBean");
            IAppProdottiSostanze bean = null;
            
            IAnaContServHome con_ser_home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");
            IAnaContServ con_ser_bean = con_ser_home.findByPrimaryKey(Long.parseLong(strCOD_SRV));

            strPRO_SOS_DES = Formatter.format(con_ser_bean.getPRO_SOS_DES());

            if (strCOD_PRO_SOS != null) {
                bean = home.findByPrimaryKey(new AppProdottiSostanzePK(Long.parseLong(strCOD_SRV), Long.parseLong(strCOD_PRO_SOS)));

                // getting of object variables
                strDES = Formatter.format(bean.getDES());
            } else {
                strCOD_PRO_SOS = "";
            }
        %>
        
        <form action="APP_PRO_SOS_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value="<%=(strCOD_PRO_SOS == null || strCOD_PRO_SOS.equals("")) ? "new" : "edt"%>">
            <input type="hidden" name="COD_PRO_SOS" value="<%=strCOD_PRO_SOS%>">
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
                                                <%=ApplicationConfigurator.LanguageManager.getString("Prodotti/Sostanze")%>
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
                                            <%=ApplicationConfigurator.LanguageManager.getString("Prodotto/Sostanza")%>
                                        </legend>
                                        <table border="0" cellspacing="10" cellpadding="0" style="width:100%;text-align:center;">
                                            <tr>
                                                <td style="width:20%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%></b></td>
                                                <td style="width:80%" align="left"><input type="text" tabindex="1" size="57" maxlength="50" name="DES" value="<%=strDES%>"></td>
                                            </tr>
                                        </table>	 
                                    </fieldset>
                                    <br>
                                    <fieldset>
                                        <legend>
                                            <%=ApplicationConfigurator.LanguageManager.getString("Annotazioni.prodotti/sostanze")%>
                                        </legend>
                                        <table border="0" cellspacing="10" cellpadding="0" style="width:100%;text-align:center;">
                                            <tr>
                                                <td style="width:18%" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Annotazioni")%></td>
                                                <td style="width:82%" align="left"><textarea tabindex="2" rows="3" name="PRO_SOS_DES"><%=strPRO_SOS_DES%></textarea></td>
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
