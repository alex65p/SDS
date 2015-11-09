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
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 	//prevents caching at the proxy server
%>
<%@page import="com.lowagie.rups.view.renderer.ToolBar"%>
<%@page import="com.apconsulting.luna.ejb.Sopraluogo.*"%>
<%@page import="s2s.utils.Checker"%>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%@ include file="ANA_SOP_Util.jsp" %>

<html>
    <head>
        <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
        <LINK REL=STYLESHEET HREF="../_styles/index.css" TYPE="text/css">
        <LINK REL=STYLESHEET HREF="../_styles/tabs.css" TYPE="text/css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <script language="JavaScript" src="../_scripts/textarea.js"></script>

        <script type="text/javascript" src="../_scripts/ajax.js"></script>
        <script type="text/javascript" src="../Form_ANA_SOP/ANA_SOP_JS.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <title>
            <%=ApplicationConfigurator.LanguageManager.getString("CollegamentiRS")%>
        </title>
        <script>
            window.dialogWidth="850px";
            window.dialogHeight="400px";

            var td1 = null;
            var td2 = null;
            var td3 = null;
            var td4 = null;
            var td5 = null;
            var td6 = null;
            var td7 = null;
            var valSelect = null;

            function OnClickReturn()
            {
                if(valSelect==null)
                {
                    return;
                }

                // Controlla che non ci sia già lo stesso documento collegato
                var cod_sop = document.getElementById("COD_SOP");
                var cod_oggetto = document.getElementById("COD_OGGETTO");
                chkCOD_DOC(cod_oggetto.value,cod_sop.value);

                if(cod_oggetto!=null)
                {
                    cod_oggetto.value=valSelect;
                }
                document.forms[0].submit();
                window.close();
            }

            function OnRowClick(obj)
            {
                if(obj==null)
                    return;
            
                var cod_oggetto = document.getElementById("COD_OGGETTO");
                valSelect=obj.INDEX;
	    
                cod_oggetto.value=valSelect;
	    
                if (td1 || td2 || td3 || td4 || td5 || td6 || td7) {
                    td1.className = null;
                    td2.className = null;
                    td3.className = null;
                    td4.className = null;
                    td5.className = null;
                    td6.className = null;
                    td7.className = null;
                }

                obj.cells[0].className = "VIEW_TR_SELECTED";
                obj.cells[1].className = "VIEW_TR_SELECTED";
                obj.cells[2].className = "VIEW_TR_SELECTED";
                obj.cells[3].className = "VIEW_TR_SELECTED";
                obj.cells[4].className = "VIEW_TR_SELECTED";
                obj.cells[5].className = "VIEW_TR_SELECTED";
                obj.cells[6].className = "VIEW_TR_SELECTED";
	
                td1 = obj.cells[0];
                td2 = obj.cells[1];
                td3 = obj.cells[2];
                td4 = obj.cells[3];
                td5 = obj.cells[4];
                td6 = obj.cells[5];
                td7 = obj.cells[6];
            }
	
            function OnRowDblClick(obj)
            {
            }
        </script>
    </head>
    <body>

        <%
            Long lID_PARENT = Long.parseLong(request.getParameter("COD_SOP"));

            ISopraluogoHome aHome = (ISopraluogoHome) PseudoContext.lookup("SopraluogoBean");
            Long lCOD_AZL = Security.getAzienda();
        %>
        <form action="elab_cond.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input type="hidden" name="COD_SOP" value="<%=lID_PARENT%>">
            <input type="hidden" name="COD_OGGETTO" value="0">
            <table border="0" style="width: 100%;">
                <tr>
                    <td td class="title">
                        <%=ApplicationConfigurator.LanguageManager.getString("CollegamentiRS")%>
                    </td>
                </tr>
                <tr>
                    <td>
                        <%@ include file="../_include/ToolBar.jsp" %>
                        <img src="../_images/new/RETURN.GIF" onclick="OnClickReturn();"/>
                        <img src="../_images/new/EXIT.GIF" onclick="window.close();"/>

                    </td>
                </tr>
            </table>
            <table width="800px" class="VIEW_TABLE" border=0>
                <tr class="VIEW_HEADER_TR">
                    <td width="16%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%>&nbsp;</td>
                    <td width="11%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data")%>&nbsp;</td>
                    <td width="14%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("N.Documento")%>&nbsp;</td>
                    <td width="15%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>&nbsp;</td>
                    <td width="14%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Procedimento")%>&nbsp;</td>
                    <td width="16%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Cantiere")%>&nbsp;</td>
                    <td width="14%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Opera")%>&nbsp;</td>
                </tr>
                <!-- SELEZIONE DOC --------------------------------- -->
                <tr>
                    <td colspan="4"></td>
                </tr>
                <tr>
                    <td colspan="7">
                        <div style="overflow:auto; height:280px;">
                            <%=BuildCollegamentiForm(aHome, lCOD_AZL)%>
                        </div>
                    </td>
                </tr>
            </table>
            <textarea id="ajaxReturn" style="display: none;"></textarea>
        </form>
        <script>
            window.dialogWidth="850px";
            window.dialogHeight="400px";
        </script>
        <iframe  style="display:none;" id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
    </body>
</html>
