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

<%    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="_include/Checker.jsp" %>
<%@ include file="_include/Global.jsp" %>
<%@ include file="src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%
    Security.setSecurityContextIdFromUserTocken();
    boolean selectAzienda = Security.isConsultant() && (Security.getAziende() == null || Security.getAziende().size() == 0);
    boolean _Refresh = StringManager.isNotEmpty(request.getParameter("_Refresh"));

    if (!selectAzienda) {
        if (Security.isUser()) {
            Security.setAziendaIdFromUserTocken();
            IAzienda bean = ((IAziendaHome) PseudoContext.lookup("AziendaBean")).findByPrimaryKey(Security.getAziendaId());
            Security.setAziendaModalitaCalcoloRischio(bean.getMOD_CLC_RSO());
        }
        if (Security.isUser() || !Security.isMultimodeConsultant()) {
            IAzienda bean = ((IAziendaHome) PseudoContext.lookup("AziendaBean")).findByPrimaryKey(Security.getAziendaId());
            Security.setAziendaName(bean.getRAG_SCL_AZL());
        }
    }
%>   


<%
    String percorso = ApplicationConfigurator.getApplicationURI() + "_security/logoCliente";
    String immagine = ApplicationConfigurator.getProfile().getName();
    String logo = percorso + "/" + immagine + ".png";
    String logoDesc = ApplicationConfigurator.getProfile().getDesc();

%>

<html>
    <head>
        <!-- compatibilita versioni precedenti IE-->
        <meta http-equiv="X-UA-Compatible" content="IE=5" />
        <title>
            <%=APP_WINDOW_TITLE + (!selectAzienda ? " - " + Formatter.format(Security.getAziendaNameEx()) : "")%>
        </title>
        <link rel="stylesheet" href="_styles/index.css" type="text/css">
        <link rel="stylesheet" href="_styles/tabs.css" type="text/css">
        <link rel="stylesheet" href="_menu/msmenu.css" type="text/css">

        <script src="_scripts/ajax.js" type="text/javascript"></script>
        <script src="_scripts/sindex.js" type="text/javascript"></script>
        <script src="_scripts/help.js" type="text/javascript"></script>
        <script src="_scripts/report.js" type="text/javascript"></script>
        <script src="_scripts/RowEventHandlers.js" type="text/javascript"></script>
        <script src='_scripts/feachures.js' type="text/javascript"></script>
        <script src="_menu/msmenu.js" type="text/javascript"></script>


        <script src="_scripts/jquery-1.11.0.js" type="text/javascript"></script>

        <%
            boolean enhancedGrid = ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID);
            if (enhancedGrid) { %>

        <!-- Stili di formattazione per le tabelle elenco -- INIZIO -->
        <style type="text/css" media="screen">
            @import "_styles/dataTable/TableTools.css";
            @import "_styles/dataTable/jquery.dataTables.css";
        </style>        
        <!-- Stili di formattazione per le tabelle elenco -- FINE -->

        <!-- Script per le tabelle elenco -- INIZIO-->
        <script src="_scripts/dataTable/jquery.dataTables.js" type="text/javascript"></script>

        <script src="_scripts/dataTable/TableTools.js" type="text/javascript"></script>
        <script src="_scripts/dataTable/ZeroClipboard.js" type="text/javascript"></script>
        <script src="_scripts/dataTable/scrollTable.js" type="text/javascript"></script>

        <script src="_scripts/dataTable/date-euro.js" type="text/javascript"></script>

        <!-- Script per le tabelle elenco -- FINE -->
        <% } else { %>
        <script src="_scripts/scrollTable.js" type="text/javascript"></script>
        <% } %>
    </head>
    <body style="border:0px;" onClick="DocOnClick(event);">
        <% if (selectAzienda) {%>
        <script type="text/javascript">
            window.moveTo(0, 0);
            window.resizeTo(screen.availWidth, screen.availHeight);

            function selectAzienda() {
                var str = window.showModalDialog(
                        "Form_MULTIAZIENDA/MULTIAZIENDA_Form.jsp",
                        "Lista Aziende",
                        MULTIAZIENDA_Feachures);
                if (str === "OK") {
                    window.location.reload(true);
                } else {
                    window.close();
                }
            }
            selectAzienda();
        </script>
        <% return;
            }%>

        <div id="workAjaxArea" style="display: none;"></div>
        <script type="text/javascript">
            window.moveTo(0, 0);
            window.resizeTo(screen.availWidth, screen.availHeight);
        </script>

        <!-- DO NOT MOVE! The following AllWebMenus code must always be placed right AFTER the BODY tag-->
        <!-- ******** BEGIN ALLWEBMENUS CODE FOR menu ********
        -->
        <span id='xawmMenuPathImg-menu' style='position:absolute;top:-50px;'>
            <img name='awmMenuPathImg-menu' id='awmMenuPathImg-menu' src='_menu/menu/awmmenupath.gif' alt=''>
        </span>
        <script type='text/javascript'>
            var MenuLinkedBy = 'AllWebMenus [2]', awmBN = '526';
            awmAltUrl = '';
        </script>
        <!--script src='_menu/menu/menu.js' language='JavaScript1.2' type='text/javascript'></script-->
        <!-- ******** DECOMMENTARE QUESTA RIGA PER ABILITARE IL MENU VERTICALE ******** -->
        <!--<script type='text/javascript'>awmBuildMenu();</script>-->
        <!-- ******** END ALLWEBMENUS CODE FOR menu ******** -->

        <table cellspacing="0" cellpadding="0" border="0" style="width: 100%; max-width:2000px; height: 100%;">
            <tr style="height:28px;">
                <td>
                    <%@ include file="_menu/luna_Menu.jsp" %>
                </td>
            </tr>

            <tr>
                <td>
                    <!-- Tabelle visualizzata quando non ci sono le view delle varie funzionalità -->
                    <table id="tblIntro" border="0"   style=" width: 100%; height: 100%;  display:<%=_Refresh ? "none;" : "block;"%>;  ">
                        <tr >  
                                        <!-- questo TD è quello che contiene il logo -->
                                        <%@ include file="_menu/menu_secondario.jsp" %>                     
                                    </tr>
                                </table>
                            </td>
                            <!--</table>-->
                        </td>
                            <!-- fine Tabelle visualizzata quando non ci sono le view delle varie funzionalità -->

                    </table>
                </td> <!---->
            </tr><!---->


            <tr>
                <td>            

                    <!-- Tabelle visualizzata quando si apre una qualsiasi funzionalità dal menù -->
                    <table id="tblAll" border="0" style="width: 100%; height: 100%; display:<%=_Refresh ? "block;" : "none;"%>; ">

                        <tr >
                                        <%@ include file="_menu/menu_secondario.jsp" %>
                                    </tr>
                                </table >
                            </td>
                    </tr > 
                           

                        <tr> 
                            <td align="top"   width="100%">
                                <table width="100%" style="height: 100%;" border="0" cellPadding="2" cellSpacing="2">
                                    <tr>
                                        <td valign="top" width="100%">
                                            <div id="lbCaption" class="h2"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="top">
                                            <table cellpadding='0' cellspacing='2' border="0"><!--pulsantiera-->
                                                <tr align="center" valign="middle" style="border-color: #000;">
                                                    <!-- NUOVO -->
                                                    <td width="35">
                                                        <img id='btnNew' onclick='g_OnNew(this)'
                                                             title='<%=ApplicationConfigurator.LanguageManager.getString("Nuovo")%>'
                                                             alt="<%=ApplicationConfigurator.LanguageManager.getString("Nuovo")%>"
                                                             src='_images/new/NEW.GIF' width="30px" border="0"><!--'_images/new/NEW.GIF'-->
                                                    </td>
                                                    <!-- APRI -->
                                                    <td width="35">
                                                        <img id='btnSave' onclick='g_OnOpen(this)'
                                                             title='<%=ApplicationConfigurator.LanguageManager.getString("Apri")%>'
                                                             alt='<%=ApplicationConfigurator.LanguageManager.getString("Apri")%>'
                                                             src='_images/new/OPEN.GIF' width="30px" border="0"><!--src='_images/new/OPEN.GIF'-->
                                                    </td>
                                                    <!-- ELIMINA -->
                                                    <td width="35">
                                                        <img id='btnDelete' onclick='g_OnDelete(this, <%=ApplicationConfigurator.isModuleEnabled(MODULES.DEL_MSG_EXT)%>)'
                                                             title='<%=ApplicationConfigurator.LanguageManager.getString("Elimina.record")%>'
                                                             alt='<%=ApplicationConfigurator.LanguageManager.getString("Elimina.record")%>'
                                                             src='_images/new/DELETE.GIF' width="30px" border="0"><!--src='_images/new/DELETE.GIF'-->
                                                    </td>
                                                    <!-- AGGIORNA -->
                                                    <td width="35">
                                                        <img id='btnDelete' onclick='g_OnRefresh(this)'
                                                             title='<%=ApplicationConfigurator.LanguageManager.getString("Refresh")%>'
                                                             alt='<%=ApplicationConfigurator.LanguageManager.getString("Refresh")%>'
                                                             src='_images/new/REFRESH.GIF' width="30px" border="0"'><!--_images/new/REFRESH.GIF-->
                                                    </td>
                                                    <!--td width="35"><img id='btnPrint' onclick='g_OnPrint(this)' title='Stampa' disabled src='_images/new/PRINT.GIF'></td-->
                                                    <!--td width="35"><img id='btnHelp' onclick='g_OnHelp(this)' title='Help' src='_images/new/HELP.GIF'></td-->
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr style="height:100%; border:0px;">
                                        <td valign=top align=left style="height:100%" >
                                            <div id="headerContainer" style="border:0px solid blue; position: absolute; z-index:2; overflow:auto"></div><!-- DIV CHE CONTINE LA TABELLA-->
                                            <div id="divTable"        style="padding-right: 5em; border:0px; overflow: <%=enhancedGrid ? "auto" : "auto"%>; height:37em; width:99%"></div>
                                            <div id="dataContainer"   style="border:0px; width:95%; height:100%; overflow: auto; z-index:1;"></div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        
                        <tr <%if (RELEASE) {
                                out.print("style='display:none'");
                            }%> >
                            <td  colspan=2>
                                <iframe id="frameView" src="empty.txt" style="width:100%"></iframe>
                                <br>
                                <iframe id="frameDelete" src="empty.txt" style="width:100%"></iframe>
                            </td>
                        </tr>
<!--aaaaaaaaaaaaaaaaa-->             
                        
                    </table>
                </td>
            </tr>
        </table>

        <script type="text/javascript">
            var g_Handler = null;

            var g_objCurrentRow = null;
            var g_lastUrl = "";

            var ToolBar = new Object();
            ToolBar.OnDelete = g_OnRefresh;

            function g_preParseUrl(url) {
                url = url.replace("/luna", "<%=APP_VIRTUAL_PATH%>");
                return url;
            }

            function g_showModalDialog(url, param, obj) {
                url = g_preParseUrl(url);
                var strFeatures = g_getFeachures(obj);
                //document.body.style.cursor="wait";
            <%if (DEBUG) {%>
                return window.open(url);
            <%} else {%>
                return window.showModalDialog(url, null, strFeatures);
            <%}%>
            }

            g_Clear();
        </script>

    </body>
</html>
