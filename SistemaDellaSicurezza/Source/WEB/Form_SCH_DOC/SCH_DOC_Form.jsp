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
            <version number="1.0" date="01/03/2004" author="Khomenko Juliya">
            <comments>
            <comment date="01/03/2004" author="Khomenko Juliya">
            <description>Create SCH_DOC_Form.jsp</description>
            </comment>
            <comment date="13/03/2004" author="Roman Chumachenko">
            <description>Report</description>
            </comment>
            </comments> 
            </version>
            </versions>
            </file> 
             */
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_include/Checker.jsp" %>

<!-- Dlya Selectov -->
<%@ include file="../src/com/apconsulting/luna/ejb/TipologiaDocumenti/TipologiaDocumentiBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TipologiaDocumenti/TipologiaDocumentiBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/CategoriaDocumento/CategoriaDocumentoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/CategoriaDocumento/CategoriaDocumentoBean.jsp" %>

<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<%@ include file="SCH_DOC_Util.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
    <head>
        <script>
            window.dialogWidth="900px";
            window.dialogHeight="490px";
        </script>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuAnalisiControllo,5) + "</title>");
        </script>
        <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script language="JavaScript" src="SCH_DOC_Script.js"></script>
        
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
    
    <body>
        
        <%
            long lCOD_DOC = 0;
            long lCOD_TPL_DOC = 0;
            long lCOD_CAG_DOC = 0;
            String strSORT_DAT_REV = "";
            String strSORT_TPL_DOC = "";
            IAzienda azienda = null;
            IAziendaHome AziendaHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");
        %>
        
        <!-- form for addind  piano-->
        <table width="100%" border="0">
            <tr>
                <td valign="top">
                    <form action="SCH_DOC_Tabs.jsp" name="frm1" id="frm1"  method="GET" target="ifrmWork" style="margin:0 0 0 0;">
                        <input id="SORT_DAT_REV" name="SORT_DAT_REV" type="hidden" value="<%=strSORT_DAT_REV %>">
                        <input id="SORT_TPL_DOC" name="SORT_TPL_DOC" type="hidden" value="<%=strSORT_TPL_DOC %>">
                        <input type="hidden" id="COD_DOC" value="">
                        <table  width="100%" border="0">
                            <tr><td class="title">
                                    <script>
                                        document.write(getCompleteMenuPath(SubMenuAnalisiControllo,5));
                                    </script>      
                            </td></tr>
                            <tr>
                                <td>
                                    <!-- ############################ --> 
                                    <table width="100%" border="0">
                                        <tr>
                                            <td>
                                                <%@ include file="../_include/ToolBar.jsp" %>
                                                <%
            ToolBar.bShowSave = false;
            ToolBar.bShowDelete = false;
            ToolBar.bShowReturn = false;
            ToolBar.bShowDetail = true;
            ToolBar.bCanDetail = true;
            ToolBar.bAlwaysShowPrint = true;
            ToolBar.bCanPrint = true;
            if (Security.isConsultant()) {
                ToolBar.bCanPrint2 = true;
                ToolBar.bShowPrint2 = true;
            }
                                                %>	
                                                <%=ToolBar.build(2)%> 
                                            </td>
                                        </tr>
                                    </table>
                                    <!-- ########################### --> 
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.documento/revisione")%></legend>
                                        <table  width="100%" border="0">
                                        <tr> 
                                            <td align="right">
                                                <b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b>
                                            </td>
                                            <td colspan="3">
                                                <!-- REPORT -->
                                                <input type="checkbox" style="display:none" value="6" checked name="REP_TYPE"> 
                                                <select name="COD_AZL" style="width:100%;">
                                                    <%=BuildAziendeComboBox(AziendaHome, 0)%>
                                                </select>
                                            </td>
                                        <tr> 
                                            <td colspan="2" width="50%"> 
                                                <fieldset>
                                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.tipologia")%></legend>
                                                    <table width="100%"  border="0">
                                                        <tr>
                                                            <td align="right" width="21%">
                                                            <%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%>&nbsp;</td><td>
                                                                <select style="width:360px" name="TPL_DOC">
                                                                    <option></option>
                                                                    <%
    ITipologiaDocumentiHome tpl_doc_home = (ITipologiaDocumentiHome) PseudoContext.lookup("TipologiaDocumentiBean");
    out.print(BuildTPLComboBox(tpl_doc_home, lCOD_TPL_DOC));
                                                                    %>
                                                                </select>			
                                                            </td>
                                                        </tr>
                                                    </table>                         
                                                </fieldset>
                                            </td>
                                            <td colspan="2" width="50%"> 
                                                <fieldset>
                                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.categoria")%></legend>
                                                    <table width="100%">
                                                        <tr>
                                                            <td align="right">
                                                            <%=ApplicationConfigurator.LanguageManager.getString("Categoria")%>&nbsp;</td><td>
                                                                <select style="width:340px" name="CAG_DOC">
                                                                    <option></option><% ICategoriaDocumentoHome cag_doc_home = (ICategoriaDocumentoHome) PseudoContext.lookup("CategoriaDocumentoBean");
    out.print(BuildCAGComboBox(cag_doc_home, lCOD_CAG_DOC));%>
                                                                </select>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </fieldset>
                                            </td>
                                        </tr>
                                        <tr> 
                                            <td align="right" valign="top"> 
                                                <%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>&nbsp;
                                            </td>
                                            <td colspan="3">
                                                <input type="text" name="TIT_DOC"  size="68" value="<%%>"> 
                                            </td>
                                        </tr>
                                        <tr> 
                                            <td align="right" >
                                                <%=ApplicationConfigurator.LanguageManager.getString("Responsabile")%>&nbsp;
                                            </td>
                                            <td>
                                                <input type="text" name="RSP_DOC" value="" size="68">
                                            </td>
                                            <td align="right">
                                                <%=ApplicationConfigurator.LanguageManager.getString("Revisione")%>&nbsp;
                                            </td>
                                            <td>
                                                <input name="REV_DOC" type="text"  size="57" value="">
                                            </td>
                                        </tr>				
                                        <tr>
                                            <td align="right" nowrap>
                                                <%=ApplicationConfigurator.LanguageManager.getString("Data.revisione.dal")%>&nbsp;
                                            </td>
                                            <td>
                                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                    <td>
                                                        <s2s:Date id="DAT_REV_D" name="DAT_REV_D" />
                                                    </td>
                                                    <td>
                                                        <%=ApplicationConfigurator.LanguageManager.getString("al")%>&nbsp;
                                                    </td>
                                                    <td>
                                                        <s2s:Date id="DAT_REV_A" name="DAT_REV_A" />
                                                    </td>
                                                </table>
                                            </td>
                                            <td align="right" nowrap>
                                                <%=ApplicationConfigurator.LanguageManager.getString("Raggruppati.per")%>&nbsp;
                                            </td>
                                            <td align="left" nowrap>
                                                <input class="checkbox" type="radio" name="NB_ORDER" value="A">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;
                                                <input class="checkbox" type="radio" name="NB_ORDER" value="C">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Categoria")%>&nbsp;
                                                <input class="checkbox" type="radio" name="NB_ORDER" checked value="N"><%=ApplicationConfigurator.LanguageManager.getString("Nessuno")%>
                                            </td>
                                        </tr>		
                                        
                                    </td>
                                </tr>
                        </table></fieldset>
                    </form>
                    <table border='0' cellpadding='0' cellspacing='0'>
                        <tr valign="center"><td height="22">
                                <table border='0' width="891" id='ListTableHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>
                                    <tr>
                                        <td width='40'>&nbsp;</td>
                                        <td width='140' id="TDsortDR" onclick="sort_SCH_DOC('dr');"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.revisione")%></strong>&nbsp;<img id='imgDR' src='../_images/ORDINE_DOWN.gif' alt='down' style='display:none'></td>
                                        <td width='231' id="TDsortTD" onclick="sort_SCH_DOC('td');"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Tipologia.documento")%></strong>&nbsp;<img id='imgTD' src='../_images/ORDINE_DOWN.gif' alt='down' style='display:none'></td>
                                        <td width='231'><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Categoria")%></strong></td>
                                        <td width='231'><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%></strong></td>
                                        <td width='18'></td>
                                    </tr>
                                </table>
                        </td></tr>
                        <tr><td>
                                <!-- 		<div id="div_s" style='height: 150;width: 100%; overflow: auto'></div> -->

                                <!-- a questo DIV gli ho diminuito l'altezza, matteo -->
                                <div id="div_s" style='height: 150;width: 100%; overflow: auto'></div>
                                
                        </td></tr>
                        <tr><td align="center"><br>
                                <fieldset style="width:90%">
                                    <table width="100%">
                                        <tr>
                                            <td width="33%" align="center"><img src="../_images/PALLA-ROSSA.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Rossa")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.in.ritardo")%></td>
                                            <td width="33%" align="center"><img src="../_images/PALLA-BLUE.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Blue")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.scadenza.odierna")%></td>
                                            <td width="33%" align="center"><img src="../_images/PALLA-NERA.gif" alt="<%=ApplicationConfigurator.LanguageManager.getString("Nera")%>">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Schede.chiuse")%></td>
                                        </tr>
                                    </table>
                                </fieldset>
                        </td></tr>
                    </table>
                    
            </td></tr>  
        </table>
        <!-- /form for addind  piano-->
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <script>
            btn = ToolBar.Search.getButton();
            btn.onclick = goTab;
            btn1 = ToolBar.Detail.getButton();
            btn1.onclick = goDOC;
            ToolBar.Detail.setEnabled(false);
            // --- REPORT ---
            // -- function for Repoprt 1------------------------------------------------------- 
            function OnPrint1(){
                frm= document.forms[0];
                w=window.open("../Reports/prepair.jsp", "REP");
                frm.target = "REP";
                frm.action = "../Reports/ScadenzarioDocumenti.jsp";
                frm.submit();
                restoreFrmProps();
            }  
            btn1=ToolBar.Print.getButton();	
            btn1.onclick=OnPrint1;
            //---------------------------------------------------------------------------------
            // -- function for Repoprt 2------------------------------------------------------- 
            function OnPrint(){
                var str = window.showModalDialog("../Form_MULTIAZIENDA/MULTIAZIENDA_Form.jsp?SCAD_REPORT=S", document, "dialogHeight:19; dialogWidth:45;help:no;resizable:no;status:no;scroll:no;");
                if (str=="OK"){
                    ToolBar.submitReport("RPT_SCD_DOC");
                }
            }  
            btn=ToolBar.Print2.getButton();	
            var OldPrint= btn.onclick;
            btn.onclick=OnPrint;
            //---------------------------------------------------------------------------------
            function restoreFrmProps(){
                frm.target = "ifrmWork";
                frm.action = "SCH_DOC_Tabs.jsp";
            }
            //----------------------------------
        </script>
    </body>
</html> 
