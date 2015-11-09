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
            response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.ArtLegge.*" %>
<%@ page import="com.apconsulting.luna.ejb.RischioCantiere.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>
<%@page import="s2s.utils.Checker"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="ART_LEG_RSO_Utils.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>



<html>
    <head>
        <script src='../_scripts/RowEventHandlers.js' language='JavaScript1.2' type='text/javascript'></script>
        <script>
            document.write("<title>" + "<%=ApplicationConfigurator.LanguageManager.getString("Art.Legge.Ex81/08IV")%>"+ "</title>");
        </script>
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

    </head>
    <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
    <LINK REL=STYLESHEET HREF="../_styles/index.css" TYPE="text/css">
    <LINK REL=STYLESHEET HREF="../_styles/tabs.css" TYPE="text/css">
    <script language="JavaScript" src="../_scripts/tabs.js"></script>
    <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
    <script language="JavaScript" src="../_scripts/textarea.js"></script>

    <script>
        window.dialogWidth="820px";
        window.dialogHeight="560px";

        function setGlobalValue(radio){
            alert("d");
        }
    </script>
    <%
                IArtLegge bean = null;
                IArtLeggeHome home = (IArtLeggeHome) PseudoContext.lookup("ArtLeggeBean");
                IRischioCantiere bean_rso=null;
                IRischioCantiereHome home_rso = (IRischioCantiereHome) PseudoContext.lookup("RischioCantiereBean");
    %>
    <body style="margin: 0 0 0 0">

        <%
                    long COD_AZL = 0;			//1
                    long COD_RSO = 0;			//1
                    String strCOD_ARL = null;     		//2
                    IArtLegge art = null;
                    if (request.getParameter("ID") != null) {
                        strCOD_ARL = request.getParameter("ID");
                        Long COD_ARL = new Long(strCOD_ARL);
                        art = home.findByPrimaryKey(COD_ARL);
                    }
                    String strID_PARENT = "";
            strID_PARENT = request.getParameter("ID_PARENT");

        %>
        <form action="ART_LEG_RSO_Set.jsp" name="ART_LEG_RSO_Set" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input type="hidden" id="id_COD_ART" name="COD_ART">
            <input name="COD_RSO" id="COD_RSO" type="hidden" value="<%=COD_RSO%>">
            <input name="ID_PARENT" id="ID_PARENT" type="hidden" value="<%=strID_PARENT%>">
            <input name="SBM_MODE" type="Hidden" value="<%if (strCOD_ARL == "") {
                            out.print("new");
                        } else {
                            out.print("edt");
                        }%>">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%" >
                <tr><td align="center"  class="title">
                        <script>
                            document.write("<%=ApplicationConfigurator.LanguageManager.getString("Art.Legge.Ex81/08IV")%>");
                        </script>
                        <br></td></tr>
                <tr>
                    <td>
                        <!-- ######################################## -->
                        <table border=0>
                            <%@ include file="../_include/ToolBar.jsp" %>
                             <%ToolBar.bShowSearch = false;%>
                                        <%ToolBar.bShowDelete = false;%>
                                        <%ToolBar.bShowPrint = false;%>
                                        <%ToolBar.bShowReturn = false;%>
                                        <%ToolBar.bShowNew = false;%>
                            <%=ToolBar.build(4)%>
                                       

                        </table>
                        <!-- #################################### -->
                        <fieldset >
                            <legend>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Art.Legge81/08-TitoloIV")%></legend>
                           
                                <table width="100%" border="" class="VIEW_TABLE">
                                    <tr class="VIEW_HEADER_TR">
                                        <td nowrap width="3%">&nbsp;</td>&nbsp;
                                        <td nowrap width="10%"><%=ApplicationConfigurator.LanguageManager.getString("Art")%></td>
                                        <td nowrap width="87%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <div style="overflow:auto; height:430px;">
                                                <%=BuildArtLegge(home)%>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            

                        </fieldset>
                    </td>
                </tr>
            </table>
        </form>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" id="ifrmWork"></iframe>      
    </body>
</html>
<script>

    btnDelete = ToolBar.Delete.getButton();
    btnDelete.onclick = goDelete;

    var g_objCurrentRow=null;
    function BeforeRowClick_S2S(){
        if (g_objCurrentRow != null){
            document.getElementById('id_COD_ARL' + g_objCurrentRow.rowIndex).name='';
            document.getElementById('id_radio' + g_objCurrentRow.rowIndex).checked=false;
        }
    }
    function AfterRowClick_S2S(){
        if (g_objCurrentRow != null){
            document.getElementById('id_radio' + g_objCurrentRow.rowIndex).checked=true;
            var currARL = document.getElementById('id_COD_ARL' + g_objCurrentRow.rowIndex);
            currARL.name="s2S_rowSelected_COD_MAN";
            document.getElementById('id_COD_ART').value = currARL.value;
        }
    }

    function goDelete(){
        if (CheckBeforeDeleteOperation()==true){
            ChiudiLatoSAP();
            if(confirm(arraylng["MSG_0179"])){
                document.form_ass_man_sap_s2s.action = "ASS_MAN_SAP_S2S_Set.jsp?Operation=Delete";
                document.form_ass_man_sap_s2s.submit();
            }
            else{
                alert(arraylng["MSG_0180"]);
            }
        }
    }

    function goSave(){
        alert("dff");
        alert("goSave");
        document.ART_LEG_RSO_Set.action = "ART_LEG_RSO_Set.jsp?Operation=Save";
        document.getElementById("id_COD_ARL");
        document.ART_LEG_RSO_Set.submit();
        
    }


</script>
