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
            <version number="1.0" date="01/04/2004" author="Roman Chumachenko">
            <comments>
            <comment date="01/04/2004" author="Roman Chumachenko">
            <description>GEST_AZIENDA_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.Consulente.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/ToolBar.jsp" %>

<html>
    <head>
        <title><%=ApplicationConfigurator.LanguageManager.getString("Elenco.delle.aziende")%></title>
    </head>
    <link rel="stylesheet" href="../_styles/style.css">
    <link rel="stylesheet" href="../_styles/tabs.css">
    <body style="margin:0 0 0 0;">
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
            <tr>
                <td align="center" colspan="2" class="title"><%=ApplicationConfigurator.LanguageManager.getString("Elenco.delle.aziende")%>
                    <br>
                </td>
            </tr>
        </table>
        <%
            Checker c = new Checker();
            String strCOD_COU = Security.getUserPrincipal().getName();
            long lCOD_COU = 0;
            IConsultantHome home = (IConsultantHome) PseudoContext.lookup("ConsultantBean");
            IConsultant bean = home.findByPrimaryKey(strCOD_COU);
            long COD_CUR_AZL = Security.getAzienda();
            
            boolean fromANA_RSO = 
                    request.getParameter("fromANA_RSO") != null && 
                    Boolean.parseBoolean(request.getParameter("fromANA_RSO")) == true;
            String ParValue = request.getParameter("isExtendedFormParName");
        %>
        <!-- ##################################################################################### -->
        <%ToolBar.bShowNew = false;%>
        <%ToolBar.bShowSave = false;%>
        <%ToolBar.bShowSearch = false;%>
        <%ToolBar.bShowDelete = false;%>
        <%ToolBar.bShowPrint = false;%>
        <%ToolBar.bShowReturn = true;%>
        <%
            if (fromANA_RSO){
                ToolBar.setMessage(
                        ApplicationConfigurator.LanguageManager.getString
                            ("Operazione.multiazienda.per.il.rischio") +
                        ": <b>" + ParValue + "</b>");
            }
        %>
        
        <%=ToolBar.build(3)%>
        <!-- ##################################################################################### -->
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
            <tr>
                <td valign="top">
                    <form action="GEST_AZIENDA_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
                        <table border='1' id="Header" class='dataTableHeader' cellpadding='0' cellspacing='0' width="100%">
                            <tr>
                                <td align='center' style="width:90%;">
                                    <b><%=ApplicationConfigurator.LanguageManager.getString("Azienda")%></b>&nbsp;
                                </td>
                                <td  align='center'>
                                    <b><%=ApplicationConfigurator.LanguageManager.getString("Abilita")%></b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <INPUT style="width:100%" type="text" value="Tutte" readonly>
                                </td>
                                <td align='center'>
                                    <input name="CHK_ALL" id="CHK_ALL" type="checkbox" class='dataInput2'  onclick="CheckAll(this)" checked>
                                </td>
                            </tr>
                        </table>
                        <div class="tabScrDiv2">
                            <table id="DataTable" class='dataTable' cellpadding='0' cellspacing='0' border="1" width="98%">
                                <%
                                    Iterator it = null;
                                    if (fromANA_RSO) {
                                        // PROVENGO DA UNA MASCHERA DI ASSOCIAZIONE DEL RISCHIO.
                                        short sMOD_CLC_RSO = Security.getAziendaModalitaCalcoloRischio();
                                        it = bean.getAziendeMOD_CLC_RSO(sMOD_CLC_RSO).iterator();
                                    } else {
                                        it = bean.getAziende().iterator();
                                    }
                                    ArrayList col = Security.getAziende();
                                    
                                    boolean curAzl = false;
                                    String rowStyle = "";
                                    IRischioHome rischioHome=(IRischioHome)PseudoContext.lookup("RischioBean");
                                    Collection ris = null;
                                    
                                    while (it.hasNext()) {
                                        // Estraggo l'azienda corrente
                                        ConsultantAzienda_Id_Name_View obj = (ConsultantAzienda_Id_Name_View) it.next();
                                        // Verifico che si tratti dell'azienda a cui sono loggato
                                        curAzl = Long.parseLong(Formatter.format(obj.COD_AZL)) == COD_CUR_AZL;
                                        
                                        if (/*fromANA_RSO*/ 1==2) {
                                            // PROVENGO DA UNA MASCHERA DI ASSOCIAZIONE DEL RISCHIO.
                                            
                                            // Estraggo il rischio, per nome, per l'azienda corrente
                                            rowStyle = "";
                                            if (rischioHome.checkRischio_ByName(ParValue, obj.COD_AZL)){
                                                rowStyle = "PresenzaRischioInAzienda-YES";
                                            } else if (curAzl) {
                                                rowStyle = "PresenzaRischioInAzienda-CUR";
                                            }
                                        }
                                %>
                                <tr>
                                    <td style="width:90%;">
                                        <INPUT class="<%=rowStyle%>" style="width:100%" readonly type="text" value="<%=Formatter.format(obj.RAG_SCL_AZL)%>">
                                    </td>
                                    <td align="center">
                                        <input <%=curAzl==true?"current=true disabled":""%> name="CHK_ITEM" id="CHK_ITEM" type="checkbox" class='dataInput2'  value="<%=Formatter.format(obj.COD_AZL)%>" checked>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </table>
                        </div>
                    </form>
                </td>
            </tr>
            <%if (/*fromANA_RSO*/ 1==2) {%>
            <tr>
                <td>
                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                        <tr>
                            <td>
                                <b>Legenda</b>:
                            </td>
                            <td style="background-color: white;width:15px;">
                                &nbsp;
                            </td>
                            <td align="left">
                                Rischio inseribile in azienda.
                            </td>
                            <td style="background-color: #ff6633;width:15px;">
                                &nbsp;
                            </td>
                            <td>
                                Rischio già presente in azienda con questo nome.
                            </td>
                            <td style="background-color: #66ff33;width:15px;">
                                &nbsp;
                            </td>
                            <td>
                                Azienda Corrente.
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <%}%>
        </table>
        <script>
            ToolBar.Exit.setEnabled(true);
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
            //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            // --- check all ---
            function CheckAll(selector){
                //selector.checked=!selector.checked;
                if(selector.checked==true){
                    for(i=1; i < document.forms(0).elements.length; i++ ){
                        obj_type=document.forms(0).elements(i).type;
                        obj		=document.forms(0).elements(i);
                        if((obj_type=="checkbox") && (obj.id=="CHK_ITEM") && !obj.disabled){
                            obj.checked = true ;
                        }
                    }
                }else{
                for(i=1; i < document.forms(0).elements.length; i++ ){
                    obj_type=document.forms(0).elements(i).type;
                    obj		=document.forms(0).elements(i);
                    if(obj_type=="checkbox"){
                        if((obj.current!=true)&& (obj.id=="CHK_ITEM") && !obj.disabled)
                            obj.checked = false;
                    }
                }
            }
        }
        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        //btnOk = document.all["btnOk"];
        btnOk = ToolBar.Return.getButton();
        btnOk.onclick=OnOk;
        function OnOk(){
            var strCkeckBox="";
            window.returnValue="CANCEL";
            if (dialogArguments){
                checks = document.getElementsByName("CHK_ITEM");
                doc=dialogArguments;
                frm=doc.forms[0];
                if (doc.all["cCont"]) doc.all["cCont"].removeNode(true);
                dObj=document.createElement("DIV");
                dObj.id="cCont";
                dObj.style.display="none";
                frm.insertAdjacentHTML("BeforeEnd",dObj.outerHTML);
                dObj=doc.all["cCont"];
                for (i=0; i< checks.length; i++){
                    if (checks[i].type=="checkbox"){
                        if (checks[i].checked && !checks[i].disabled ){
                            //if (checks[i].checked){
                            strCkeckBox+="<input type='checkbox' name='AZIENDA_ID' value='"+checks[i].value+"' checked>"
                        }
                    }
                    if (strCkeckBox!="")
                        window.returnValue="OK";
                }
                dObj.innerHTML=strCkeckBox;
            }
            window.close();
        }
        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        </script>
    </body>
</html>
