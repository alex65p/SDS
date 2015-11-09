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
<%@ page import="com.apconsulting.luna.ejb.AssRischioAttivita.*" %>
<%@ page import="com.apconsulting.luna.ejb.LuogoFisicoRischio.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/ToolBar.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%
            String SUBJECT = request.getParameter("ATTACH_SUBJECT");
            String Title = "";
            if (SUBJECT.equals("MESURE")) {
                Title = ApplicationConfigurator.LanguageManager.getString("Gestione.rischi.per.attività.lavorative");
            } else if (SUBJECT.equals("LUOGO")) {
                Title = ApplicationConfigurator.LanguageManager.getString("Gestione.rischi.per.luoghi.fisici");
            }
%>

<html>
    <head>
        <title><%=Title%></title>
        <script>
            window.dialogHeight="250px";
        </script>
    </head>
    <link rel="stylesheet" href="../_styles/style.css">
    <link rel="stylesheet" href="../_styles/tabs.css">
    <body style="margin:0 0 0 0;">
        <%
            // @@@@@@@@@@@@@@@@@@@ MESURE @@@@@@@@@@@@@@@@@@@@@@@@
            if (SUBJECT.equals("MESURE")) {
                long lCOD_RSO_MAN = 0;     		//1
                long lCOD_RSO = 0;     			//3
                long lCOD_MAN = 0;     			//3
                IAssRischioAttivita bean = null;	//
                if (request.getParameter("ID_PARENT") != null) {
                    lCOD_RSO_MAN = Long.parseLong(request.getParameter("ID_PARENT"));
                    IAssRischioAttivitaHome home = (IAssRischioAttivitaHome) PseudoContext.lookup("AssRischioAttivitaBean");
                    bean = home.findByPrimaryKey(new Long(lCOD_RSO_MAN));
                    lCOD_RSO = bean.getCOD_RSO();
                    lCOD_MAN = bean.getCOD_MAN();
                }
        %>
        <table cellpadding="0" cellspacing="0" border="0" width="700">
            <tr>
                <td class="title">
                    <%=Title%>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <!-- ##################################################################################### -->
                    <table border=0>
                        <%//ToolBar.bShowNew=false;%>
                        <%ToolBar.bShowSave = false;%>
                        <%ToolBar.bShowSearch = false;%>
                        <%ToolBar.bShowDelete = false;%>
                        <%ToolBar.bShowPrint = false;%>
                        <%=ToolBar.build(3)%>
                    </table>
                    <!-- ##################################################################################### -->
                    <form action="GEST_MIS_PET_Set.jsp?SBM_MODE=MESURE" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
                        <table border='0' id="Header" class='dataTableHeader' cellpadding='0' cellspacing='0' width="100%">
                            <tr><td>&nbsp;</td><td>&nbsp;</td><td><b><%=ApplicationConfigurator.LanguageManager.getString("Abilita")%></td></tr>
                            <tr>
                                <td width='470'><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione")%></strong></td>
                                <td width='100'><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Versione")%></strong></td>
                                <td align='center' width='30'><input name="CHK_ALL" id="CHK_ALL" type="checkbox" class='dataInput2'  onclick="CheckAll(this)"></td>
                            </tr>
                        </table>
                        <div class="tabScrDiv">
                            <table id="DataTable" class='dataTable' cellpadding='0' cellspacing='0' border="0">
                                <%
            if (bean != null) {
                java.util.Collection col = bean.getNotAssMesure_View(lCOD_RSO, lCOD_MAN);
                java.util.Iterator it = col.iterator();
                while (it.hasNext()) {
                    AssRA_NotAssMesure_View obj = (AssRA_NotAssMesure_View) it.next();
                                %>
                                <tr>
                                    <td class='dataTd' align="center"><input readonly type="Text" value="<%=Formatter.format(obj.NOM_MIS_PET)%>" class='dataInput'></td>
                                    <td class='dataTd' align="center" ><input readonly type="Text" value="<%=Formatter.format(obj.VER_MIS_PET)%>" class='dataInput'></td>
                                    <td align="center">&nbsp;<input name="CHK_ITEM" id="CHK_ITEM" type="checkbox" class='dataInput2' value="<%=Formatter.format(obj.COD_MIS_PET)%>"></td>
                                </tr>
                                <%
                }
            }
                                %>
                            </table>
                        </div>
                        <input type="Hidden" value="<%=Formatter.format(lCOD_RSO_MAN)%>" name="COD_RSO_MAN">
                    </form>  
                </td>
            </tr>
        </table>
        <%}
            //-----------------------------------------------------------------------------------------
            // @@@@@@@@@@@@@@@@@@@ LUOGO @@@@@@@@@@@@@@@@@@@@@@@@
            if (SUBJECT.equals("LUOGO")) {
                long lCOD_RSO_LUO_FSC = 0;   		//1
                long lCOD_RSO = 0;     			//3
                long lCOD_LUO_FSC = 0;     		//3
                ILuogoFisicoRischio bean = null;	//
                if (request.getParameter("ID_PARENT") != null) {
                    lCOD_RSO_LUO_FSC = Long.parseLong(request.getParameter("ID_PARENT"));
                    ILuogoFisicoRischioHome home = (ILuogoFisicoRischioHome) PseudoContext.lookup("LuogoFisicoRischioBean");
                    bean = home.findByPrimaryKey(new Long(lCOD_RSO_LUO_FSC));
                    lCOD_RSO = bean.getCOD_RSO();
                    lCOD_LUO_FSC = bean.getCOD_LUO_FSC();
                }
        %>
        <table cellpadding="0" cellspacing="0" border="0" width="700">
            <tr>
                <td class="title">
                    <%=Title%>
                </td>
            </tr>
            <tr><td valign="top">
                    <!-- ##################################################################################### -->
                    <table border=0>
                        <%//ToolBar.bShowNew=false;%>
                        <%ToolBar.bShowSave = false;%>
                        <%ToolBar.bShowSearch = false;%>
                        <%ToolBar.bShowDelete = false;%>
                        <%ToolBar.bShowPrint = false;%>
                        <%=ToolBar.build(3)%>
                    </table>
                    <!-- ##################################################################################### -->
                    <form action="GEST_MIS_PET_Set.jsp?SBM_MODE=LUOGO" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
                        <table border='0' id="Header" class='dataTableHeader' cellpadding='0' cellspacing='0' width="100%">
                            <tr><td>&nbsp;</td><td>&nbsp;</td><td><b><%=ApplicationConfigurator.LanguageManager.getString("Abilita")%></td></tr>
                            <tr>
                                <td width='470'><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione")%></strong></td>
                                <td width='100'><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Versione")%></strong></td>
                                <td align='center' width='30'><input name="CHK_ALL" id="CHK_ALL" type="checkbox" class='dataInput2'  onclick="CheckAll(this)"></td>
                            </tr>
                        </table>
                        <div class="tabScrDiv">
                            <table id="DataTable" class='dataTable' cellpadding='0' cellspacing='0' border="0">
                                <%
            if (bean != null) {
                java.util.Collection col = bean.getNotAssMesure_View(lCOD_RSO, lCOD_LUO_FSC);
                java.util.Iterator it = col.iterator();
                while (it.hasNext()) {
                    AssLU_NotAssMesure_View obj = (AssLU_NotAssMesure_View) it.next();
                                %>
                                <tr>
                                    <td class='dataTd' align="center"><input readonly type="Text" value="<%=Formatter.format(obj.NOM_MIS_PET)%>" class='dataInput'></td>
                                    <td class='dataTd' align="center" ><input readonly type="Text" value="<%=Formatter.format(obj.VER_MIS_PET)%>" class='dataInput'></td>
                                    <td align="center">&nbsp;<input name="CHK_ITEM" id="CHK_ITEM" type="checkbox" class='dataInput2' value="<%=Formatter.format(obj.COD_MIS_PET)%>"></td>
                                </tr>
                                <%
                }
            }
                                %>
                            </table>
                        </div>
                        <input type="Hidden" value="<%=Formatter.format(lCOD_RSO_LUO_FSC)%>" name="COD_RSO_LUO_FSC">
                    </form>  
        </td></tr></table>
        <%}%>
        
        
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <script>
            ToolBar.Return.setEnabled(true);
            var OldReturn= ToolBar.Return.OnClick;
            ToolBar.Return.OnClick=OnReturn;
            // -- OnReturn --
            function OnReturn(){
                document.forms(0).submit();
            }
            //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            // -- table correction --
            adaptTable(document.all["Header"], document.all["DataTable"]);
            function adaptTable(tableHeader, table){
                counter = new Object();
                counter.i=0;
                counter.y=0;
                counter.z=0;	
                for (counter.i=0; counter.i< table.rows.length; counter.i++){
                    for (counter.y=0; counter.y<table.rows[counter.i].cells.length; counter.y++){
                        iCol = table.rows[counter.i].cells[counter.y].getElementsByTagName("INPUT");
                        for (counter.z=0; counter.z< iCol.length; counter.z++){
                            if (iCol[counter.z].type=="text"){
                                width = tableHeader.rows[0].cells[counter.y].offsetWidth;
                                iCol[counter.z].width= width;
                                table.rows[counter.i].cells[counter.y].style.width=width;
                                break;
                            }
                        }
                    }
                }
                counter=null;
            }
            // --- check all ---
            function CheckAll(selector){
                //selector.checked=!selector.checked;
                if(selector.checked==true){
                    for(i=1; i < document.forms(0).elements.length; i++ ){
                        obj_type=document.forms(0).elements(i).type;
                        obj		=document.forms(0).elements(i);
                        if(obj_type=="checkbox"){
                            obj.checked = true ;
                        }	
                    }
                }else{
                for(i=1; i < document.forms(0).elements.length; i++ ){
                    obj_type=document.forms(0).elements(i).type;
                    obj		=document.forms(0).elements(i);
                    if(obj_type=="checkbox"){
                        obj.checked = false ;
                    }	
                }
            }
        }
        //------------------------------------------------------------
        </script>
    </body>
</html>
