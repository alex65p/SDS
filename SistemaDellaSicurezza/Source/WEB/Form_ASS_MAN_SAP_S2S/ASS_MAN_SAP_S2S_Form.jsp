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
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server
%>

<%@ page import="com.apconsulting.luna.ejb.AssociazioneMansioniSAP_S2S.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>


<%@ include file="ASS_MAN_SAP_S2S_Utils.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<script src='../_scripts/RowEventHandlers.js' language='JavaScript1.2' type='text/javascript'></script>
<head>
<script>
    window.name="_ass_man_sap_s2s";
    document.write("<title>" + getCompleteMenuPath(SubMenuAttivitaLavorative,2) + "</title>");
</script>
<LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
<LINK REL=STYLESHEET HREF="../_styles/index.css" TYPE="text/css">
<LINK REL=STYLESHEET HREF="../_styles/tabs.css" TYPE="text/css">
</head>
<body style="margin:0 0 0 0;">
<script language="JavaScript">
window.dialogWidth="924px";
window.dialogHeight="700px";
</script>
<%
    AssociazioneMansioniSAP_S2SHome home =(AssociazioneMansioniSAP_S2SHome)PseudoContext.lookup("AssociazioneMansioniSAP_S2SBean");
%>
<form name="form_ass_man_sap_s2s" action="ASS_MAN_SAP_S2S_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
        <tr style='height:5px;'>
            <td>  </td>
        </tr>
        <tr>
            <td class="title">
                <script>
                    document.write(getCompleteMenuPathFunction
                        (SubMenuAttivitaLavorative,2,<%=request.getParameter("ID")%>));
                </script>
            </td>
        </tr>
        <tr>
            <td>
                <table width="100%" border="0">
                    <%@ include file="../_include/ToolBar.jsp" %>
                    <%
                    ToolBar.bCanPrint=false;
                    ToolBar.bAlwaysShowPrint=false;
                    ToolBar.bShowDetail=false;
                    ToolBar.bCanDetail=false;
                    ToolBar.bShowNew=false;
                    ToolBar.bShowSearch=false;

                    ToolBar.bShowHelp=true;
                    ToolBar.bShowDelete=true;
                    ToolBar.bCanDelete=true;

                    ToolBar.setBtnSave_title(ApplicationConfigurator.LanguageManager.getString("Salva.Associazione"));
                    ToolBar.setBtnDelete_title(ApplicationConfigurator.LanguageManager.getString("Elimina.dipendenti.SAP"));
                    %>
                    <%=ToolBar.build(5)%>
                </table>
                <table width="100%" border="0">
                    <tr>
                        <td>
                            <fieldset>
                                <table width="100%" border="0">
                                    <tr>
                                        <td align="left" style="width:35px">
                                            <img src='../_images/new/comprimi.gif' alt="<%=ApplicationConfigurator.LanguageManager.getString("Riduci.vista.tabella")%>" onclick="ChiudiLatoSAP();">
                                        </td>
                                        <td align="center">
                                            <%=ApplicationConfigurator.LanguageManager.getString("Lavoratori/Mansioni.SAP")%>
                                        </td>
                                        <td align="right" style="width:35px">
                                            <img src='../_images/new/espandi.gif' alt="<%=ApplicationConfigurator.LanguageManager.getString("Espandi.vista.tabella")%>" onclick="ApriLatoSAP();">
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                        <td align="right">
                            <fieldset style="height:45px;">
                                <table width="100%" height="100%" border="0">
                                    <tr>
                                        <td align="center">
                                            <%=ApplicationConfigurator.LanguageManager.getString("Unità.organizzative/Attività.lavorative.S2S")%>
                                        </td>
                                    </tr>
                                </table> 
                            </fieldset>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td width="50%">
                            <fieldset>
                                <div style="overflow:auto; height:530px; width:450px">
                                    <table width="100%" border="0" class="VIEW_TABLE">
                                        <tr class="VIEW_HEADER_TR">
                                            <td nowrap colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Cognome")%>&nbsp;</td>
                                            <td nowrap>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</td>
                                            <td nowrap>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Unità.organizzativa")%>&nbsp;</td>
                                            <td nowrap>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.inizio")%>&nbsp;</td>
                                            <td nowrap>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.fine")%>&nbsp;</td>
                                            <td nowrap>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Mansione")%>&nbsp;</td>
                                            <td nowrap>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.inizio")%>&nbsp;</td>
                                            <td nowrap>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.fine")%>&nbsp;</td>                                                
                                            <td nowrap>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Posizione")%>&nbsp;</td>
                                            <td nowrap>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.inizio")%>&nbsp;</td>
                                            <td nowrap>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.fine")%>&nbsp;</td>
                                            <td nowrap>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%>&nbsp;</td>
                                        </tr>                                            
                                        <%=BuildListaSAP(home, Security.getAzienda())%>
                                    </table>
                                </div>
                            </fieldset>
                        </td>
                            <td width="50%">
                                <fieldset>
                                    <div style="overflow:auto; height:530px; width:450px">
                                        <table width="100%" border="0" class="VIEW_TABLE">
                                            <tr class="VIEW_HEADER_TR">
                                                <td nowrap colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Unità.organizzativa")%></td>
                                                <td nowrap>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa")%></td>
                                            </tr>                                            
                                            <%=BuildListaS2S(home, Security.getAzienda())%>
                                        </table>
                                    </div>
                                </fieldset>
                            </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="3"><div  id="dContainer" class="mainTabContainer" style="width:100%;"></div></td>
        </tr> 
    </table>
</form>
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
</body>
</html>
<script>
    // PARTE DI GESTIONE DELLA LISTA S2S
    btnSave = ToolBar.Save.getButton();
    btnSave.onclick = goSave;
    
    btnDelete = ToolBar.Delete.getButton();
    btnDelete.onclick = goDelete;

    var g_objCurrentRow=null;
    function BeforeRowClick_S2S(){
        if (g_objCurrentRow != null){
            document.getElementById('id_COD_MAN' + g_objCurrentRow.rowIndex).name='';
            document.getElementById('id_COD_UNI_ORG' + g_objCurrentRow.rowIndex).name='';
            document.getElementById('id_radio' + g_objCurrentRow.rowIndex).checked=false;
        }
    }
    function AfterRowClick_S2S(){
        if (g_objCurrentRow != null){
            document.getElementById('id_radio' + g_objCurrentRow.rowIndex).checked=true;
            document.getElementById('id_COD_UNI_ORG' + g_objCurrentRow.rowIndex).name="s2S_rowSelected_COD_UNI_ORG";
            document.getElementById('id_COD_MAN' + g_objCurrentRow.rowIndex).name="s2S_rowSelected_COD_MAN";
        }
    }
    
    
    // PARTE DI GESTIONE DELLA LISTA SAP
    var selectedSAP = 0;
    function g_OnRowClick_SAP(tr){
                if (tr != null) {
                    if (tr.className=="dataTrSelected") {
                        tr.className=tr.classNameOld;
                        document.getElementById('id_DES_LUO_FSC_S2S' + tr.rowIndex).name='';
                        document.getElementById('id_COD_MAN_SAP_DAT_FIN' + tr.rowIndex).name='';
                        document.getElementById('id_COD_MAN_SAP_DAT_INI' + tr.rowIndex).name='';
                        document.getElementById('id_COD_DPD_S2S' + tr.rowIndex).name='';
                        document.getElementById('id_sap' + tr.rowIndex).name='';
                        document.getElementById('id_checkbox' + tr.rowIndex).checked=false;
                        selectedSAP--;
                    } else {
                        tr.classNameOld=tr.className;
                        tr.className="dataTrSelected";
                        tr.style.cursor="hand";
                        document.getElementById('id_checkbox' + tr.rowIndex).checked=true;
                        document.getElementById('id_sap' + tr.rowIndex).name="sap_rowsSelected_ID";
                        document.getElementById('id_COD_DPD_S2S' + tr.rowIndex).name="sap_rowsSelected_COD_DPD_S2S";
                        document.getElementById('id_COD_MAN_SAP_DAT_INI' + tr.rowIndex).name="sap_rowsSelected_COD_MAN_SAP_DAT_INI";
                        document.getElementById('id_COD_MAN_SAP_DAT_FIN' + tr.rowIndex).name="sap_rowsSelected_COD_MAN_SAP_DAT_FIN";
                        document.getElementById('id_DES_LUO_FSC_S2S' + tr.rowIndex).name="sap_rowsSelected_DES_LUO_FSC_S2S";
                        selectedSAP++;
                    }
                }
        }
    
    function CheckBeforeSaveOperation(){
        var error_message = "";
        if (selectedSAP==0){
            error_message += arraylng["MSG_0064"];
        }
        if (g_objCurrentRow==null){
            error_message += arraylng["MSG_0065"];
        } 
        if (error_message != ""){
            error_message = arraylng["MSG_0066"] + error_message;
            alert(error_message);
            return false;
        } else {
            return true;
        }
    }
    
    function CheckBeforeDeleteOperation(){
        if (selectedSAP==0){
            alert(arraylng["MSG_0066"] + arraylng["MSG_0064"]);
            return false;
        } else {
            return true;
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
        if (CheckBeforeSaveOperation()==true){
            ChiudiLatoSAP();
            if(confirm(arraylng["MSG_0033"])){
                document.form_ass_man_sap_s2s.action = "ASS_MAN_SAP_S2S_Set.jsp?Operation=Save";
                document.form_ass_man_sap_s2s.submit();
            }
            else{
                alert(arraylng["MSG_0063"]);
            }
        }
    }
    
    function ApriLatoSAP(){
        fieldSet_List = document.getElementsByTagName("fieldset");
        
        fieldSet_List[1].style.display="none";
        fieldSet_List[3].style.display="none";
        document.getElementsByTagName("div")[0].style.width="900px";
    }

    function ChiudiLatoSAP(){
        fieldSet_List = document.getElementsByTagName("fieldset");
        
        document.getElementsByTagName("div")[0].style.width="450px";
        fieldSet_List[1].style.display="block";
        fieldSet_List[3].style.display="block";
        
    }    
</script>
