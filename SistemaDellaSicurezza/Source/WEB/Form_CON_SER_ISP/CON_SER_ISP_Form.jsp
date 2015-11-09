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
    Document   : CON_SER_ISP_Form
    Created on : 19-mag-2008, 12.32.09
    Author     : Giancarlo Servadei
--%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/ContServIspezioni/ContServIspezioniBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ContServIspezioni/ContServIspezioniBean.jsp"%>

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
        
        <title><%=ApplicationConfigurator.LanguageManager.getString("Ispezioni")%></title>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
    </head>
    <script>
        window.dialogWidth="700px";
        window.dialogHeight="240px";
    </script>
    <body>
        <%
            String strCOD_SRV = request.getParameter("ID_PARENT");
            String strCOD_ISP = request.getParameter("ID");
            String strFILE_NAME = "";
            String strPRO_CON = "";
            String strDES_CON = "";

            IContServIspezioniHome home = (IContServIspezioniHome) PseudoContext.lookup("ContServIspezioniBean");
            IContServIspezioni bean = null;
            
            IAnaContServHome con_ser_home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");
            IAnaContServ con_ser_bean = con_ser_home.findByPrimaryKey(Long.parseLong(strCOD_SRV));

            strPRO_CON = Formatter.format(con_ser_bean.getPRO_CON());
            strDES_CON = Formatter.format(con_ser_bean.getDES_CON());

            if (strCOD_ISP != null) {
                bean = home.findByPrimaryKey
                        (new ContServIspezioniPK(Long.parseLong(strCOD_SRV), Long.parseLong(strCOD_ISP)));

                // getting of object variables
                strFILE_NAME = Formatter.format(bean.getFILE_NAME());
            } else {
                strCOD_ISP = "";
            }
        %>
        
        <form action="CON_SER_ISP_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;" ENCTYPE="multipart/form-data">
            <input name="SBM_MODE" type="Hidden" value="<%=(strCOD_ISP == null || strCOD_ISP.equals("")) ? "new" : "edt"%>">
            <input type="hidden" name="COD_ISP" value="<%=strCOD_ISP%>">
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
                                                <%=ApplicationConfigurator.LanguageManager.getString("Ispezioni")%>
                                            </td> 
                                            <td>   
                                                <%
                                                ToolBar.bCanDelete = (bean != null);
                                                ToolBar.bCanSave = (bean == null);
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
                                                <td style="width:25%;" align="left"><input type="text" size="15%" name="PRO_CON" readonly value="<%=strPRO_CON%>"/></td>
                                                <td style="width:15%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</b></td>
                                                <td style="width:40%;" align="left"><textarea cols="38" rows="2" name="DES_CON" readonly><%=strDES_CON%></textarea></td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                    <br>
                                    <fieldset>
                                        <legend>
                                            <%=ApplicationConfigurator.LanguageManager.getString("Ispezione")%>
                                        </legend>
                                        <br>
                                        <table  width="100%" border="0" cellspacing="5">
                                          
                                            <tr>
                                                <td style="width:18%;" valign="middle" align="right">
                                                    <b><%=ApplicationConfigurator.LanguageManager.getString("Documento")%>&nbsp;</b>
                                                </td>
                                                <td align="left">
                                                    <% if (bean == null){
                                                        out.println("<input type=\"file\" size=\"92\" name=\"FILE_NAME\" value=\"" + strFILE_NAME + "\">");
                                                    } else {
                                                        out.println("<a href=\"../_include/SHOW_File.jsp?ID=" + strCOD_ISP + "&NOM_TAB=CON_SER_ISP&TYPE=FILE_ISP\" target=\"" + strCOD_ISP + "\">" + strFILE_NAME + "</a>");
                                                    }
                                                    %>
                                                </td>
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
