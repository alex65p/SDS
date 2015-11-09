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
            <version number="1.0" date="16/03/2004" author="Roman Chumachenko">
            <comments>
            <comment date="16/03/2004" author="Roman Chumachenko">
            <description>GEST_ATTIVITA_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.OperazioneSvolta.*" %>
<%@ page import="com.apconsulting.luna.ejb.Consulente.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/ToolBar.jsp" %>

<% String SUBJECT = request.getParameter("ATTACH_SUBJECT");%>

<html>
    <head>
        <title><%=ApplicationConfigurator.LanguageManager.getString("Attività.lavorative.per.operazioni.svolte")%></title>
    </head>
    <link rel="stylesheet" href="../_styles/style.css">
    <link rel="stylesheet" href="../_styles/tabs.css">
    <body style="margin:0 0 0 0;">
        <%
            long lCOD_OPE_SVO = 0;
            long lCOD_MAN = 0;
            long lCOD_RSO = 0;
            String DEL = "0";
            IOperazioneSvolta bean = null;
            IAttivitaLavorativeHome att_home = (IAttivitaLavorativeHome) PseudoContext.lookup("AttivitaLavorativeBean");
            //--------------------------
            if (request.getParameter("ID") != null) {
                lCOD_OPE_SVO = Long.parseLong(request.getParameter("ID"));
                if (request.getParameter("COD_MAN") != null) {
                    lCOD_MAN = Long.parseLong(request.getParameter("COD_MAN"));
                }
                lCOD_RSO = Long.parseLong(request.getParameter("COD_RSO"));
                if (request.getParameter("DEL") != null) {
                    DEL = "1";
                }
                //---------------------------------------------------------------
%>
        <table cellpadding="0" cellspacing="0" border="0" width="700">
            <tr>
                <td class="title">
                    <%=ApplicationConfigurator.LanguageManager.getString("Attività.lavorative.per.operazioni.svolte")%>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table>
                         <!-- ##################################################################################### -->
                         <%ToolBar.bShowNew = false;%>
                         <%ToolBar.bShowSave = false;%>
                         <%ToolBar.bShowSearch = false;%>
                         <%ToolBar.bShowDelete = false;%>
                         <%ToolBar.bShowPrint = false;%>
                         <%ToolBar.bShowReturn = true;%>
                         <%ToolBar.bShowExit = false;%>
                         <%ToolBar.bShowAziende = Security.isExtendedMode();%>
                         <%=ToolBar.build(3)%>
                    </table>
                    <form action="GEST_ATTIVITA_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
                        <input type="hidden" name="DEL" value="<%=DEL%>">
                        <table border='0' id="Header" class='dataTableHeader' cellpadding='0' cellspacing='0' width="100%">
                            <tr><td>&nbsp;</td><td><b><%=ApplicationConfigurator.LanguageManager.getString("Abilita")%></b></td></tr>
                            <tr>
                                <td width='670' align='center'><b><%=ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa")%></td>
                                <td align='center' width='30'>
                                    <input name="CHK_ALL" id="CHK_ALL" type="checkbox" class='dataInput2'  onclick="CheckAll(this)">
                                </td>
                            </tr>
                        </table>
                        <div class="tabScrDiv2">
                            <table id="DataTable" class='dataTable' cellpadding='0' cellspacing='0' border="0">
                                <%
            long lCOD_AZL = Security.getAzienda();
            java.util.Collection col = att_home.getAttLavListToOperSvolta_View(lCOD_OPE_SVO, lCOD_AZL);
            java.util.Iterator it = col.iterator();
            String str = "";
            while (it.hasNext()) {
                AttivitaLavorative_Name_View obj = (AttivitaLavorative_Name_View) it.next();
                                %>
                                <tr>
                                    <td class='dataTd' align="center">
                                        <input readonly type="Text" value="<%=Formatter.format(obj.NOM_MAN)%>" class='dataInput'>
                                    </td>
                                    <td align="center">&nbsp;
                                        <%
                                    str = "";
                                    if (Long.parseLong(Formatter.format(obj.COD_MAN)) == lCOD_MAN) {
                                        str = " checked ";
                                    }
                                        %>
                                        <input <%=str%> name="CHK_ITEM" id="CHK_ITEM" type="checkbox" class='dataInput2' value="<%=Formatter.format(obj.COD_MAN)%>">
                                    </td>
                                </tr>
                                <%
            }
                                %>
                            </table>
                        </div>
                        <input type="Hidden" value="<%=Formatter.format(lCOD_OPE_SVO)%>" name="COD_OPE_SVO">
                        <input type="Hidden" value="<%=Formatter.format(lCOD_RSO)%>" name="COD_RSO">
                        <input type="Hidden" value="<%=Formatter.format(lCOD_MAN)%>" name="COD_MAN">
                        
                        <%
            if (Security.isExtendedMode()) {
                        %>
                        <div id="cCont" style="display:none">
                            <%
                            String strCOD_COU = Security.getUserPrincipal().getName();
                            IConsultantHome cou_home = (IConsultantHome) PseudoContext.lookup("ConsultantBean");
                            IConsultant cou_bean = cou_home.findByPrimaryKey(strCOD_COU);
                            long COD_CUR_AZL = Security.getAzienda();
                            ;
                            Iterator it2 = cou_bean.getAziende().iterator();
                            while (it2.hasNext()) {
                                ConsultantAzienda_Id_Name_View obj = (ConsultantAzienda_Id_Name_View) it2.next();
                                if (Long.parseLong(Formatter.format(obj.COD_AZL)) == COD_CUR_AZL) {
                                    continue;
                                }
                            %>
                            <input  name="AZIENDA_ID" id="AZIENDA_ID" type="checkbox"  value="<%=Formatter.format(obj.COD_AZL)%>" checked>
                            <%}%>
                        </div>
                        <%}%>
                    </form>
                </td>
            </tr>
        </table>
        <%}// if ID%>
        
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" width="100%" height="500"></iframe>
        <script>
            //ToolBar.Exit.setEnabled(false);
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
                        if((obj_type=="checkbox") && (obj.id=="CHK_ITEM")){
                            obj.checked = true ;
                        }
                    }
                }else{
                for(i=1; i < document.forms(0).elements.length; i++ ){
                    obj_type=document.forms(0).elements(i).type;
                    obj		=document.forms(0).elements(i);
                    if(obj_type=="checkbox"){
                        if((obj.disabled!=true) && (obj.id=="CHK_ITEM"))
                            obj.checked = false;
                    }
                }
            }
        }
        //------------------------------------------------------------
        </script>
    </body>
</html>
