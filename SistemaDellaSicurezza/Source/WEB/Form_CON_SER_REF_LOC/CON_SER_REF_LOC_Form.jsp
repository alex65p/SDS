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
    Document   : CON_SER_REF_LOC_Form
    Created on : 27-mag-2008, 10.35.56
    Author     : Giancarlo Servadei
--%>
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/ContServReferentiLoco/ContServReferentiLocoBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ContServReferentiLoco/ContServReferentiLocoBean.jsp"%>

<%@ include file="../_include/ToolBar.jsp"%>
<%@ include file="../_include/ComboBox-Dipendente.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp"%>

<%@ include file="../_menu/menu/menuStructure.jsp"%>

<html>
    <head>
        <script type="text/javascript" src="../_scripts/tabs.js"></script>
        <script type="text/javascript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <link rel="stylesheet" href="../_styles/style.css" type="text/css" />

        <script type="text/javascript">
            window.dialogWidth="486px";
            window.dialogHeight="215px";
            
            function populate(obj) {
                if (obj.value > 0 ) {
                    document.all["NOM_FUZ_AZL"].value = obj.options(obj.selectedIndex).valueNOM;
                    document.all["COD_DPD"].value = obj.options(obj.selectedIndex).value;
                } else {
                    document.all["NOM_FUZ_AZL"].value = "";
                    document.all["COD_DPD"].value = "";
                }
            }
        </script>
        <title><%=ApplicationConfigurator.LanguageManager.getString("Referenti.in.loco")%></title>
    </head>
    
    <body>
        <%
            long lCOD_DPD = 0;
            String strTEL = "";

            long lCOD_AZL = Security.getAzienda();
            String strCOD_SRV = request.getParameter("ID_PARENT");
            String strCOD_DPD = request.getParameter("ID");
            
            IContServReferentiLocoHome home = (IContServReferentiLocoHome) PseudoContext.lookup("ContServReferentiLocoBean");
            IContServReferentiLoco bean = null;

            if (strCOD_DPD != null) {
                lCOD_DPD = Long.parseLong(request.getParameter("ID"));
                bean = home.findByPrimaryKey(new ContServReferentiLocoPK(lCOD_AZL, Long.parseLong(strCOD_SRV), Long.parseLong(strCOD_DPD)));
                strTEL = Formatter.format(bean.getTEL());
            } else {
                strCOD_DPD = "";
            }
        %>
        
        <!-- Form per l'aggiunta di Contratti/Servizi -->
        <form action="CON_SER_REF_LOC_Set.jsp"  method="POST" target="ifrmWork">
            <input name="SBM_MODE" type="Hidden" value="<%=(strCOD_DPD == null || strCOD_DPD.equals("")) ? "new" : "edt"%>">
            <input type="hidden" name="COD_DPD" value="<%=strCOD_DPD%>">
            <input type="hidden" name="COD_SRV" value="<%=strCOD_SRV%>">
            <table width="100%" border="0">
            <tr>
            <td valign="top">
            <table  width="100%">
                <tr>
                    <td>
                        <table width="100%" border="0">
                            <tr> 
                                <td class="title" width="100%">
                                    <%=ApplicationConfigurator.LanguageManager.getString("Referenti.in.loco")%>
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
                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Responsabile")%></legend>
                            <table width="100%" border="0" cellspacing="10" cellpadding="0" align="center"> 
                                
                                <tr>
                                <td width="28%" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nominativo")%></b></td>
                                    
                                    <td width="72%" align="left">
                                        <select tabindex="1" id="selectCOD_DPD" name="lCOD_DPD" onchange="populate(this);" <%=(bean == null)?"":"disabled"%>>
                                            <option value=""></option>
                                                                    <%
                                            IDipendenteHome d_home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
                                            out.print(BuildDipendenteComboBox_DET_CMT(d_home, lCOD_DPD, lCOD_AZL));
                                                                    %>
                                         </select>
                                     </td>
                                </tr>
                                
                                <tr>
                                    <td width="28%" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Qualifica")%></td>
                                    <td width="72%" valign="middle" align="left"><input tabindex="2" type="text" size="40" name="NOM_FUZ_AZL" readonly /></td>
                                    
                                </tr>
                                
                                <tr>
                                    
                                    <td width="28%" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Telefono")%></td>
                                    <td width="72%" align="left"><input tabindex="3" type="text" maxlength="15" size="20" name="TEL" value="<%=Formatter.format(strTEL)%>" /></td>
                                    
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
        <script>
            populate(document.getElementById("selectCOD_DPD"));
        </script>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
        
    </body>
</html>            
