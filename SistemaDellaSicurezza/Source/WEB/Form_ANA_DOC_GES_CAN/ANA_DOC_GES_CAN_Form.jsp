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


<%@page import="com.apconsulting.luna.ejb.Cantiere.ICantiereHome"%>
<%@page import="com.apconsulting.luna.ejb.AnagrOpere.IAnagrOpereHome"%>
<%@page import="com.apconsulting.luna.ejb.Procedimento.IProcedimentoHome"%>
<%@page import="com.apconsulting.luna.ejb.AnagrDocumento.IAnagrDocumento"%>
<%@page import="com.apconsulting.luna.ejb.AnagrDocumento.IAnagrDocumentoHome"%>
<%@page import="com.apconsulting.luna.ejb.AnagrDocumento.AnagDocumentoFileInfo"%>
<%@page import="s2s.luna.conf.ModuleManager.MODULES"%>
<%@page import="java.text.*"%>
<%@page import="com.apconsulting.luna.ejb.AnagrDocumentiGestioneCantieri.*" %>
<%@page import="com.apconsulting.luna.ejb.TipologiaDocumentiCantiere.*" %>
<%@page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>
<%
    response.setHeader("Cache-Control", "no-cache");     //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 		//prevents caching at the proxy server
%>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../_include/ComboBuilder.jsp" %>
<%@ include file="../_include/ToolBar.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
    <head>
        <script type="text/javascript">
            document.write("<title>" + getCompleteMenuPath(SubMenuDocumentiAreaSicurezza,1) + "</title>");
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
        <link rel="stylesheet" href="../_styles/style.css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script type="text/javascript" src="../_scripts/tabs.js"></script>
        <script type="text/javascript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <script type="text/javascript" src="../_scripts/Alert.js"></script>
        <script language="JavaScript" src="../Form_PRO_CAN_OPE_Combo/PRO_CAN_OPE_Combo.js"></script>

        <script type="text/javascript">
            window.dialogWidth="1000px";
            window.dialogHeight="560px"; // Dimensioni del form sull'Edit
        </script>
    </head>
    <body style="margin:0 0 0 0;" onload="">
        <%
            long lCOD_DOC = 0;
            long lCOD_PRO = 0;
            long lCOD_SOP = 0;
            long lCOD_OPE = 0;
            long lCOD_CAN = 0;
            String strTIT_DOC = "";
            java.sql.Date dtDAT_DOC = null;
            String strDES = "";
            String strNUM_DOC = "";
            long lCOD_TPL_DOC = 0;
            
            AnagDocumentoFileInfo info = null;
            AnagDocumentoFileInfo infoLink = null;
            IAnagrDocumentiGestioneCantieriHome home1 = null;
            IAnagrDocumentiGestioneCantieri bean = null;
            Long lCOD_AZL = Security.getAzienda();
            String strID = "";
            if (request.getParameter("ID") != null) {
                // getting parameters of azienda
                strID = (String) request.getParameter("ID");
                try {
                    home1 = (IAnagrDocumentiGestioneCantieriHome) PseudoContext.lookup("AnagrDocumentiGestioneCantieriBean");
                    Long id = new Long(strID);
                    bean = home1.findByPrimaryKey(id);
                    lCOD_DOC = bean.getCOD_DOC();
                    strTIT_DOC = bean.getTIT_DOC();
                    strNUM_DOC = bean.getNUM_DOC();
                    dtDAT_DOC = bean.getDAT_DOC();
                    strDES = bean.getDES();
                    lCOD_TPL_DOC = bean.getCOD_TPL_DOC();
                    lCOD_PRO = bean.getCOD_PRO();
                    lCOD_SOP = bean.getCOD_SOP();
                    lCOD_OPE = bean.getCOD_OPE();
                    lCOD_CAN = bean.getCOD_CAN();
                    lCOD_PRO = bean.getCOD_PRO();
                    info = bean.getFileInfo();
                    infoLink = bean.getFileInfoLink();
                } catch (Exception ex) {
        %>
        <script type="text/javascript">Alert.Error.showNotFound()</script>
        <%                }
            }// if request
%>
        <script type="text/javascript">
            function preparePRO_CAN_OPE_Combo(changedElement){
                if (document.getElementById("procedimento_id") == null){
                    getPRO_CAN_OPE_Combo(
                        document.getElementById("PRO_CAN_OPE_Combo"),
                        <%=lCOD_PRO%>,
                        <%=lCOD_CAN%>,
                        <%=lCOD_OPE%>,
                        <%=lCOD_AZL%>,
                        changedElement
                    );
                } else {
                    getPRO_CAN_OPE_Combo(
                        document.getElementById("PRO_CAN_OPE_Combo"),
                        document.getElementById("procedimento_id").value,
                        document.getElementById("cantiere_id").value,
                        document.getElementById("opera_id").value,
                        <%=lCOD_AZL%>,
                        changedElement
                    );
                }
            }
        </script>
        <form action="ANA_DOC_GES_CAN_Set.jsp" method="POST"  target="ifrmWork" style="margin:0 0 0 0;" ENCTYPE="multipart/form-data">
            <table width="100%" border="0" cellpadding="0" cellspacing="5">
                <tr>
                    <td>
                        <table width="100%" border="0" cellpadding="0" cellspacing="5">
                            <tr>
                                <td class="title">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                        (SubMenuDocumentiAreaSicurezza,1,<%=request.getParameter("ID")%>));
                                    </script>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <!-- ########################################################################################################## -->
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td>
                                                <%ToolBar.bCanDelete = (bean != null);
                                                    ToolBar.bShowReturn = true;%>
                                                <%//ToolBar.strPrintUrl = "SchedaDocumento.jsp?";%>
                                                <%=ToolBar.build(2)%>
                                            </td>
                                        </tr>
                                    </table>
                                    <!-- ########################################################################################################## -->
                                </td>
                            </tr>
                        </table>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.documento")%></legend>
                                        <table width="100%" border="0" cellpadding="1" cellspacing="2">
                                            <% if (bean != null) {%>
                                            <input name="SBM_MODE" type="Hidden" value="edt">
                                            <% } else {%>
                                            <input name="SBM_MODE" type="Hidden" value="new">
                                            <% }%>
                                            <input name="ID" tabindex="1" type="hidden" value="<%=Formatter.format(lCOD_DOC)%>">
                                            <tr>
                                                <td align="right" style="width: 12%;">
                                                    <b><%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%></b>
                                                </td>
                                                <td align="left" style="width: 38%;">
                                                    <%
                                                        class ComboParser1 implements IComboParser {

                                                            public void parse(Object obj, ComboItem item) {
                                                                TipologiaDocumenti_ComboView w = (TipologiaDocumenti_ComboView) obj;
                                                                item.lIndex = w.lCOD_TPL_DOC;
                                                                item.strValue = w.strNOM_TPL_DOC;
                                                            }
                                                        }
                                                        ITipologiaDocumentiCantiereHome h1 = (ITipologiaDocumentiCantiereHome) PseudoContext.lookup("TipologiaDocumentiCantiereBean");
                                                        ComboBuilder b1 = new ComboBuilder(lCOD_TPL_DOC, new ComboParser1(), h1.getComboView());
                                                        b1.strName = "COD_TPL_DOC";
                                                        b1.tabIndex = 1;
                                                    %>
                                                    <%=b1.build()%>
                                                </td>
                                                <td align="right" style="width: 12%;">
                                                    <b><%=ApplicationConfigurator.LanguageManager.getString("Titolo")%></b>
                                                </td>
                                                <td colspan="3" align="left" nowrap style="width: 38%;">
                                                    <input tabindex="2" style="width: 100%;" maxlength="50"  name="TIT_DOC" value="<%=Formatter.format(strTIT_DOC)%>">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Data")%></b></td>
                                                <td align="left"><s2s:Date tabindex="3" id="DAT_DOC" name="DAT_DOC" value='<%=Formatter.format(dtDAT_DOC)%>'/>
                                                <td align="right" nowrap><b><%=ApplicationConfigurator.LanguageManager.getString("N.Documento")%></b></td>
                                                <td align="left"><input tabindex="3" style="width: 100%;" maxlength="100" name="NUM_DOC" value="<%=Formatter.format(strNUM_DOC)%>"></td>
                                                <td colspan="2">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%></td>
                                                <td align="left" colspan="5">
                                                    <textarea tabindex="4" cols="70" rows="2" maxlenght="250"  name="DES"><%=Formatter.format(strDES)%></textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="100%">
                                                    <div id="PRO_CAN_OPE_Combo">
                                                        <script type="text/javascript">
                                                            preparePRO_CAN_OPE_Combo();
                                                        </script>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                        </table>
                        <br/>
                        <table border="0" width="100%" cellspacing="5" cellpadding="0">
                            <tr>
                                <td>
                                    <%
                                        if (ApplicationConfigurator.isModuleEnabled(MODULES.DOC_LINK)) {
                                            out.println("<td align=\"left\" width=\"50%\">");
                                        } else {
                                            out.println("<td align=\"left\" width=\"50%\">");
                                        }
                                    %>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("File")%></legend>
                                        <div style="overflow:hidden;">
                                            <table width=100% border="0" cellspacing="5" cellpadding="0">
                                                <%
                                                    if (info != null) {
                                                        NumberFormat nf = NumberFormat.getInstance();
                                                        nf.setMinimumFractionDigits(2);
                                                        nf.setMaximumFractionDigits(3);
                                                %>
                                                <tr>
                                                    <td align="center" width="15%"><input tabindex="5" type="checkbox" class="checkbox" name="ATTACHMENT_ACTION" value="delete"><%=ApplicationConfigurator.LanguageManager.getString("Delete")%></td>
                                                    <td align="center" width="40%"><a href="ANA_DOC_GES_CAN_File.jsp?ID=<%=lCOD_DOC%>&TYPE=FILE"><%=info.strName%></a></td>
                                                    <td align="left" width="30%"><%=ApplicationConfigurator.LanguageManager.getString("Dimensione.(KB)")%>:&nbsp;&nbsp;<%=Formatter.format(nf.format((float) info.lSize / 1024))%></td>
                                                    <td align="left" width="15%"><%=ApplicationConfigurator.LanguageManager.getString("Ultima.modifica")%>:&nbsp;&nbsp;<%=Formatter.format(info.dtModified)%></td>
                                                </tr>
                                                <% } else {%>
                                                <tr>
                                                    <td width="100%"><input tabindex="18" name="ATTACHMENT_FILE" type="file" style="width:100%"></td>
                                                </tr>
                                                <% }%>
                                            </table>
                                        </div>
                                    </fieldset>
                                    <%
                                        if (ApplicationConfigurator.isModuleEnabled(MODULES.DOC_LINK)) {
                                            out.println("<td width=\"50%\">");
                                        } else {
                                            out.println("<td width=\"50%\" style=\"display:none\">");
                                        }
                                    %>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("File.link")%></legend>
                                        <div style="overflow:hidden;">
                                            <table width="100%" border="0" cellspacing="5" cellpadding="0">
                                                <%
                                                    if (infoLink != null) {
                                                        NumberFormat nf = NumberFormat.getInstance();
                                                        nf.setMinimumFractionDigits(2);
                                                        nf.setMaximumFractionDigits(3);
                                                %>
                                                <tr>
                                                    <td align="center" width="15%">
                                                        <input tabindex="6" type="checkbox" class="checkbox" name="ATTACHMENT_ACTION_LINK" value="delete"><%=ApplicationConfigurator.LanguageManager.getString("Delete")%>
                                                    </td>
                                                    <td align="center" width="40%">
                                                        <a href="file:///<%=infoLink.strLinkDocument%>" target="_blank"><%=infoLink.strName%></a>
                                                    </td>
                                                    <td align="left" width="30%">
                                                        <%=ApplicationConfigurator.LanguageManager.getString("Dimensione.(KB)")%>:&nbsp;&nbsp;<%=Formatter.format(nf.format((float) infoLink.lSize / 1024))%>
                                                    </td>
                                                    <td align="left" width="15%">
                                                        <%=ApplicationConfigurator.LanguageManager.getString("Ultima.modifica")%>:&nbsp;&nbsp;<%=Formatter.format(infoLink.dtModified)%>
                                                    </td>
                                                </tr>
                                                <% } else {%>
                                                <tr>
                                                    <td width="100%"><input tabindex="18" name="ATTACHMENT_FILE_LINK" type="file" style="width:100%" ></td>
                                                </tr>
                                                <% }%>
                                            </table>
                                        </div>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
                            </tr>
                        </table>
                        </form>
                        <form action="ANA_DOC_GES_CAN_File.jsp" name="frmFile">
                            <input type="hidden" name="ID" value="<%=lCOD_DOC%>">
                        </form>
                        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
                            <%
                                if (bean != null) {
                            %>
                            <script type="text/javascript" src="../_scripts/index.js"></script>
                            <script type="text/javascript">
                                //--------BUTTONS description-----------------------
                                btnParams = new Array();
                                btnParams[0] = {"id":"btnNew",
                                    "onclick":addRow,
                                    "action":"AddNew"
                                };
                                btnParams[1] = {"id":"btnEdit",
                                    "onclick":editRow,
                                    "action":"Edit"
                                };
                                btnParams[2] = {"id":"btnCancel",
                                    "onclick":delRow,
                                    "action":"Delete"
                                };

                                //--------creating tabs--------------------------
                                var tabbar = new TabBar("tbr1",document.all["dContainer"]);
                                var btnBar = new ButtonPanel("batPanel1", btnParams);
                                tabbar.addButtonBar(btnBar);

                                tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("RS.Collegati")%>", tabbar));

                                tabbar.idParentRecord = <%=lCOD_DOC%>;
                                tabbar.refreshTabUrl="ANA_DOC_GES_CAN_Tabs.jsp";
                                tabbar.RefreshAllTabs();
                                
                                //----add action parameters to tabs
                                tabbar.tabs[0].tabObj.actionParams ={"Feachures":ANA_FOR_Feachures,
                                    "AddNew":	{"url":"",
                                        "buttonIndex":0,
                                        "disabled": true
                                    },
                                    "Edit":	{"url":"",
                                        "buttonIndex":1,
                                        "disabled": true
                                    },
                                    "Delete":	{"url":"",
                                        "buttonIndex":2,
                                        "disabled": true,
                                        "target_element":document.all["ifrmWork"]
                                    }
                                };

                                //-----activate first tab--------------------------
                                tabbar.tabs[0].center.click();
                            </script>
                            <%} else {%>
                            <script type="text/javascript">
                                window.dialogHeight="315px";
                            </script>
                            <%}%>
                        </body>
                        </html>
