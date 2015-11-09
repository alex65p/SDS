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
    Document   : APP_PER_COI_Form
    Created on : 23-mag-2008, 22.34.01
    Author     : Giancarlo Servadei
--%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/AppPersonaleCoinvolto/AppPersonaleCoinvoltoBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/AppPersonaleCoinvolto/AppPersonaleCoinvoltoBean.jsp"%>

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
        
        <title><%=ApplicationConfigurator.LanguageManager.getString("Personale.coinvolto")%></title>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
    </head>
    <script>
        window.dialogWidth="314px";
        window.dialogHeight="184px";
    </script>
    <body>
        <%
            String strCOD_SRV = request.getParameter("ID_PARENT");
            String strCOD_PER_COI = request.getParameter("ID");
            String strNOM = "";
            String strQUA = "";

            IAppPersonaleCoinvoltoHome home = (IAppPersonaleCoinvoltoHome) PseudoContext.lookup("AppPersonaleCoinvoltoBean");
            IAppPersonaleCoinvolto bean = null;

            if (strCOD_PER_COI != null) {
                bean = home.findByPrimaryKey(new AppPersonaleCoinvoltoPK(Long.parseLong(strCOD_SRV), Long.parseLong(strCOD_PER_COI)));

                // getting of object variables
                strNOM = Formatter.format(bean.getNOM());
                strQUA = Formatter.format(bean.getQUA());
            } else {
                strCOD_PER_COI = "";
            }
        %>
        
        <form action="APP_PER_COI_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value="<%=(strCOD_PER_COI == null || strCOD_PER_COI.equals("")) ? "new" : "edt"%>">
            <input type="hidden" name="COD_PER_COI" value="<%=strCOD_PER_COI%>">
            <input type="hidden" name="COD_SRV" value="<%=strCOD_SRV%>">
            <table width="100%" border="0">
                <tr>
                    <td valign="top">
                        <table  width="100%">
                            <tr>
                                <td>
                                    <table width="100%" border="0">
                                        <tr> 
                                            <td class="title" width="100%"><%=ApplicationConfigurator.LanguageManager.getString("Personale.coinvolto")%></td> 
                                            <td><%
                                                ToolBar.bShowDelete = true;
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
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Personale.coinvolto")%></legend>
                                        <table width="100%" border="0" cellspacing="10" cellpadding="0">
                                            <tr>
                                                <td width="25%" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%></b></td>
                                                <td width="75%" align="left"><input type="text" tabindex="1" size="40" maxlength="50" name="NOM" value="<%=strNOM%>"></td>
                                            </tr>
                                            
                                            <tr>
                                                <td width="25%" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Qualifica")%></td>
                                                <td width="75%" align="left"><input type="text" tabindex="2" size="40" maxlength="50" name="QUA" value="<%=strQUA%>"></td>
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
