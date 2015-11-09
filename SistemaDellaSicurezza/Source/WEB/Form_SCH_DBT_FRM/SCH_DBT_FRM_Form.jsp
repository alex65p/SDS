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
    <version number="1.0" date="26/02/2004" author="Yuriy Kushkarov">
    <comments>
    <comment date="26/02/2004" author="Yuriy Kushkarov">
    <description>Create formi SCH_DBT_FRM_Form.jsp</description>
    </comment>
    <comment date="15/03/2004" author="Roman Chumachenko">
    <description>Report</description>
    </comment>
    </comments> 
    </version>
    </versions>
    </file> 
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuFormazione,3) + "</title>");
        </script>
        <LINK rel="stylesheet" href="../_styles/style.css" type="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <link rel="stylesheet" href="../_styles/index.css" type="text/css">
        <script src="../_scripts/tabs.js"></script>
        <script src="../_scripts/tabbarButtonFunctions.js"></script>
        <script src="SCH_DBT_FRM_Script.js"></script>
    </head>
    <script>
        window.dialogWidth="800px";
        window.dialogHeight="450px";
    </script>
    <body>
        <%
            long lCOD_AZL = Security.getAzienda();
            long lCOD_UNI_ORG = 0;
            IAzienda azienda;
            IAziendaHome AziendaHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");
            Long azl_id = new Long(lCOD_AZL);
            azienda = AziendaHome.findByPrimaryKey(azl_id);
            String strRAG_SCL_AZL = azienda.getRAG_SCL_AZL();
        %>
        <!-- form for addind  piano-->
        <form action="SCH_DBT_FRM_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input id="COD_DPD" type="hidden" value="">
            <input type="hidden" id="COD_COR" value="">
            <input type="hidden" id="DAT_COR" value="">
            <table width="100%" border="0">
                <tr>
                    <td valign="top">
                        <table width="100%" border="0">
                            <tr>
                                <td class="title" colspan="2">
                                    <script>
                                        document.write(getCompleteMenuPath(SubMenuFormazione,3));
                                    </script>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="100%" border="0">
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%
                                            ToolBar.bShowReturn = false;
                                            ToolBar.bShowDelete = false;
                                            ToolBar.bShowNew = true;
                                            ToolBar.bShowSave = false;
                                            ToolBar.bShowDetail = true;
                                            ToolBar.bCanDetail = true;
                                            ToolBar.bAlwaysShowPrint = true;
                                            ToolBar.bCanPrint = true;
                                        %>
                                        <%=ToolBar.build(3)%>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="left"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%></b>
                                    <input readonly name="RAG_AZL" style="width:600px" value="<%=strRAG_SCL_AZL%>">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <br>	
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Unità.organizzativa")%></legend>
                                        <table  width="100%" border="0">
                                            <tr>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Nominativo")%>&nbsp;</td>
                                                <td>
                                                    <select tabindex="1" name="ORGANIZZATIVA" id="ORGANIZZATIVA" style="width:600px" onchange="ChangeSelect(0)">
                                                        <option value="0"></option>
                                                        <%
                                                            IUnitaOrganizzativa uoBean = null;
                                                            IUnitaOrganizzativaHome uoHome = (IUnitaOrganizzativaHome) PseudoContext.lookup("UnitaOrganizzativaBean");
                                                            String nodes = uoHome.buildTreeNodes(uoBean, uoHome, 0, lCOD_UNI_ORG, lCOD_AZL, false);
                                                            out.println(nodes);
                                                        %>
                                                    </select>
                                                </td>
                                            </tr>
                                        </table>	 
                                    </fieldset>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa")%></legend>
                                        <table  width="100%" border="0">
                                            <tr>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Nominativo")%>&nbsp;</td>
                                                <td>
                                                    <div id="selDiv">
                                                        <select tabindex="2" name="ATTIVITA" id="ATTIVITA" style="width:600px">
                                                            <option value="0"></option>
                                                        </select>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>	 
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="width:100%">
                        <table width="100%" border="0">
                            <tr class="VIEW_HEADER_TR">
                                <td style="width:39%" style="cursor:pointer;" onclick="sortList();">&nbsp;<b><%=ApplicationConfigurator.LanguageManager.getString("Lavoratore")%></b></td>
                                <td style="width:39%"><b><%=ApplicationConfigurator.LanguageManager.getString("Corso")%></b></td>
                                <td style="width:22%"><b><%=ApplicationConfigurator.LanguageManager.getString("Data.corso")%></b></td>
                            </tr>
                            <tr>
                                <td style="width:90%" colspan="3">
                                    <div id="divFile" style="height:190px;width:100%;overflow:auto"></div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <!-- /form for addind  piano-->
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <iframe name="ifrmFile" id="ifrmFile" class="ifrmWork" src="../empty.txt"></iframe>
        <script>
            btnDetail = ToolBar.Detail.getButton();
            btnDetail.onclick = openCORDPD;
            
            btnSearch = ToolBar.Search.getButton();
            btnSearch.onclick = search;
            
            btnPrint = ToolBar.Print.getButton();	
            btnPrint.onclick = OnPrint;
            
            ToolBar.Detail.setEnabled(false);
        </script>
    </body>
</html> 
