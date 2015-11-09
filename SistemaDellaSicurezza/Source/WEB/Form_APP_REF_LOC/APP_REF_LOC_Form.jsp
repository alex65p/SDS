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
    Document   : APP_REF_LOC_Form
    Created on : 28-mag-2008, 08.48.04
    Author     : Giancarlo Servadei
--%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/AppReferentiLoco/AppReferentiLocoBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/AppReferentiLoco/AppReferentiLocoBean.jsp"%>

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
        
        <title><%=ApplicationConfigurator.LanguageManager.getString("Referente.in.loco")%></title>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
    </head>
    <script>
        //window.dialogWidth="340px";
        //window.dialogHeight="215px";
        window.dialogWidth="430px";
        window.dialogHeight="215px";
    </script>
    <body>
        <%
            String strCOD_SRV = request.getParameter("ID_PARENT");
            String strCOD_REF_LOC = request.getParameter("ID");
            String strNOM = "";
            String strQUA = "";
            String strTEL = "";

            IAppReferentiLocoHome home = (IAppReferentiLocoHome) PseudoContext.lookup("AppReferentiLocoBean");
            IAppReferentiLoco bean = null;

            if (strCOD_REF_LOC != null) {
                bean = home.findByPrimaryKey(new AppReferentiLocoPK(Long.parseLong(strCOD_SRV), Long.parseLong(strCOD_REF_LOC)));

                // getting of object variables
                strNOM = Formatter.format(bean.getNOM());
                strQUA = Formatter.format(bean.getQUA());
                strTEL = Formatter.format(bean.getTEL());
            } else {
                strCOD_REF_LOC = "";
            }
        %>
        
        <form action="APP_REF_LOC_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value="<%=(strCOD_REF_LOC == null || strCOD_REF_LOC.equals("")) ? "new" : "edt"%>">
            <input type="hidden" name="COD_REF_LOC" value="<%=strCOD_REF_LOC%>">
            <input type="hidden" name="COD_SRV" value="<%=strCOD_SRV%>">
            <table width="100%" border="0">
                <tr>
                    <td valign="top">
                        <table  width="100%">
                            <tr>
                                <td>
                                    <table width="100%" border="0">
                                        <tr> 
                                            <td class="title" width="100%"><%=ApplicationConfigurator.LanguageManager.getString("Referenti.in.loco")%></td> 
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
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Referente.in.loco")%></legend>
                                        <table width="100%" border="0">
                                            <br>
                                            <tr>
                                                <td width="30%" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nominativo")%>&nbsp;</b></td>
                                                <td width="70%" align="left"><input type="text" tabindex="1" size="56" maxlength="50" name="NOM" value="<%=strNOM%>"></td>
                                            </tr>
                                            
                                            <tr>
                                                <td width="30%" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Qualifica")%>&nbsp;</td>
                                                <td width="70%" align="left"><input type="text" tabindex="2" size="38" maxlength="50" name="QUA" value="<%=strQUA%>"></td>
                                            </tr>
                                            
                                            <tr>
                                                <td width="30%" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Telefono")%>&nbsp;</td>
                                                <td width="70%" align="left"><input type="text" tabindex="2" size="20" maxlength="15" name="TEL" value="<%=strTEL%>"></td>
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
