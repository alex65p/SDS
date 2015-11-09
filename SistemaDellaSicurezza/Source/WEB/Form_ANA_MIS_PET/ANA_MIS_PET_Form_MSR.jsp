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
<%@ page import="com.apconsulting.luna.ejb.MisuraPreventiva.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.TipologiaMisurePreventive.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="ANA_MIS_PET_Util.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
    <head>   
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuStrumenti,0) + "</title>");
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
    <link rel="stylesheet" href="../_styles/style.css">
    <link rel="stylesheet" href="../_styles/tabs.css">
    <script language="JavaScript" src="../_scripts/tabs.js"></script>
    <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
    <script language="JavaScript" src="../_scripts/textarea.js"></script>
    <style>
        .getList{
            width:20px;
            height:20px;
            vertical-align:middle;
        }
    </style>
    <script>
        window.dialogWidth="800px";
        window.dialogHeight="660px";
    </script>
    
    <body style="margin: 0 0 0 0">
        <%
            String strCOD_MIS_PET_AZL = "";
//-------------------------------------------------
            long lCOD_AZL = Security.getAzienda();
            String strRAG_SCL_AZL = new String();
            //------------------
            long lCOD_MIS_PET = 0;
            String strNOM_MIS_PET = "";
            java.sql.Date dtDAT_CMP = null;
            String lVER_MIS_PET = "";
            String strIST_OPE_COR = "";
            String strADT_MIS_PET = "";
            java.sql.Date dtDAT_PAR_ADT = null;
            String strPER_MIS_PET = "";
            String lPNZ_MIS_PET_MES = "";
            java.sql.Date dtDAT_PNZ_MIS_PET = null;
            String strDES_MIS_PET = "";
            String strTPL_DSI_MIS_PET = "";
            String strDSI_AZL_MIS_PET = "N";
            long lCOD_TPL_MIS_PET = 0;
            long lCOD_MIS_PET_RPO = 0;
            boolean desButtons = false;
            boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
            //---------------------------
            java.util.Collection col;
            java.util.Iterator it;
//-------------Interfaces & Beans------------------------
            //-----Azienda--------
            IAziendaHome azHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");
            IAzienda azienda = null;
            //----------get current azienda -----------------
            azienda = azHome.findByPrimaryKey(new Long(lCOD_AZL));
            strRAG_SCL_AZL = azienda.getRAG_SCL_AZL();
            //-------Tipologia Misure--------------
            ITipologiaMisurePreventive tpl = null;
            ITipologiaMisurePreventiveHome tplHome = (ITipologiaMisurePreventiveHome) PseudoContext.lookup("TipologiaMisurePreventiveBean");
            //----MisuraPreventiva-----------
            IMisuraPreventiva bean = null;
            IMisuraPreventivaHome home = (IMisuraPreventivaHome) PseudoContext.lookup("MisuraPreventivaBean");
//---------
// stub for debuging
            if (request.getParameter("ID") != null) {
                // getting parameters of azienda
                try {
                    Long ID = new Long(request.getParameter("ID"));
                    bean = home.findByPrimaryKey(new MisuraPreventivaPK(lCOD_AZL, ID.longValue()));
                    lCOD_MIS_PET = bean.getCOD_MIS_PET();
                    strNOM_MIS_PET = bean.getNOM_MIS_PET();
                    dtDAT_CMP = bean.getDAT_CMP();
                    lVER_MIS_PET = Formatter.format(bean.getVER_MIS_PET());
                    strIST_OPE_COR =bean.getIST_OPE_COR() ;
                    strADT_MIS_PET = bean.getADT_MIS_PET();
                    dtDAT_PAR_ADT = bean.getDAT_PAR_ADT();
                    strPER_MIS_PET = bean.getPER_MIS_PET();
                    lPNZ_MIS_PET_MES = Formatter.format(bean.getPNZ_MIS_PET_MES());
                    dtDAT_PNZ_MIS_PET = bean.getDAT_PNZ_MIS_PET();
                    strDES_MIS_PET = bean.getDES_MIS_PET();
                    strTPL_DSI_MIS_PET = bean.getTPL_DSI_MIS_PET();
                    strDSI_AZL_MIS_PET = bean.getDSI_AZL_MIS_PET();
                    lCOD_TPL_MIS_PET = bean.getCOD_TPL_MIS_PET();
                    lCOD_MIS_PET_RPO = bean.getCOD_MIS_PET_RPO();
                    lCOD_AZL = bean.getCOD_AZL();

                } catch (Exception ex) {
                    out.print("<strong>" + ex.getMessage() + "</strong>");
                    return;
                }
            }// if request*/
%>
        <table cellpadding="10" border="0" cellspacing="" width="100%" >
            <tr><td valign="top">
                    <form action="ANA_MIS_PET_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%" >
                            <tr><td align="center" colspan="2" class="title">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                            (SubMenuStrumenti,0,<%=request.getParameter("ID")%>));
                                    </script>
                            <br></td></tr>
                            <tr>
                                <td>
                                    <!-- ######################################## -->
                                    <table border=0>
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%
            if (request.getParameter("ID") == null) {
                if (!desButtons) {
                    ToolBar.bCanDelete = ToolBar.bCanEdit;
                } else {
                    ToolBar.bCanDelete = false;
                    ToolBar.bCanEdit = false;
                }
                ToolBar.bCanPrint = false;
                ToolBar.bShowPrint = false;
            }
                                        %>
                                        <%=ToolBar.build(4)%>
                                        
                                        <%
            if (Security.isExtendedMode() && (bean == null || bean.isMultiple())) {
                                        %><script>isExtendedForm=true;</script><%
            }
                                        %>
                                    </table>
                                    <!-- #################################### -->
                                    <fieldset >
                                    <legend>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione")%></legend>
                                    <table border="0" cellpadding="1" cellspacing="1" width="100%"> 
                                        <tr>
                                            <td colspan="6">
                                                <input name="SBM_MODE" type="Hidden" value="<%if (lCOD_MIS_PET != 0) {
                out.print("edt");
            } else {
                out.print("new");
            }%>">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6">
                                                <input type="hidden" size="20" maxlength="20" name="COD_MIS_PET" value="<%=Formatter.format(lCOD_MIS_PET)%>">
                                                <input type="hidden" size="1" maxlength="1" name="DSI_AZL_MIS_PET" value="<%=Formatter.format(strDSI_AZL_MIS_PET)%>">
                                                <input type="hidden" size="20" maxlength="20" name="COD_MIS_PET_RPO" value="<%=Formatter.format(lCOD_MIS_PET_RPO)%>">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" width="20%"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</td>
                                            <td  width="80%" colspan="5">
                                                <input type="hidden" name="COD_AZL"  id="COD_AZL" value="<%= Formatter.format(lCOD_AZL)%>">
                                                <input style="width:100%" type="text" readonly name="RAG_SCL_AZL"  value="<%= Formatter.format(strRAG_SCL_AZL)%>">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right"><strong><%=ApplicationConfigurator.LanguageManager.getString("Misura")%>&nbsp;</strong></td>
                                            <td colspan="5" nowrap>
                                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td width="96%" nowrap >
                                                            <input tabindex="1" type="text" style="width:100%" maxlength="100"  name="NOM_MIS_PET" value="<%=Formatter.format(strNOM_MIS_PET)%>">
                                                        </td>
                                                    </tr> 
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" nowrap><strong><%=ApplicationConfigurator.LanguageManager.getString("Adottata/Da.adottare")%>&nbsp;</strong></td>
                                            <td colspan="5">
                                                <table width="100%" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td width="20%">
                                                            <select tabindex="2" id="COD_TPL_MIS_PET" name="COD_TPL_MIS_PET">
                                                                <option value=""></option>
                                                                <%
            col = tplHome.getTipologia_View();
            String str = BuildTipologiaMisureCombobox(col, lCOD_TPL_MIS_PET);
            out.println(str);
                                                                %>
                                                            </select>
                                                        </td>
                                                        <td nowrap align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione")%>&nbsp;</td>
                                                        <td width="10%" align="right"><s2s:Date tabindex="3"  id="DAT_PNZ_MIS_PET" name="DAT_PNZ_MIS_PET" value="<%=Formatter.format(dtDAT_PNZ_MIS_PET)%>"/></td>
                                                        <!--<td width="10%" align="right"><input tabindex="3" type="text" size="19" maxlength="10"  name="DAT_PNZ_MIS_PET" value="<%=Formatter.format(dtDAT_PNZ_MIS_PET)%>"></td>-->
                                                        
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <%  if (!ifMsr) {%>
                                            <td align="right"><strong><%=ApplicationConfigurator.LanguageManager.getString("Versione")%>&nbsp;</strong></td>                                        
                                            <td align="left"><input tabindex="4" type="text" size="3" maxlength="4"  name="VER_MIS_PET" value="<%=lVER_MIS_PET%>"></td>                                          
                                            <td width="40%" align="right" nowrap><strong><%=ApplicationConfigurator.LanguageManager.getString("Data.compilazione")%>&nbsp;</strong></td>                     
                                            <td width="30%">
                                                <s2s:Date tabindex="5" id="DAT_CMP" name="DAT_CMP" value="<%=Formatter.format(dtDAT_CMP)%>"/>
                                                <!--<input tabindex="5" type="text" size="14" maxlength="14"  name="DAT_CMP" value="<%=Formatter.format(dtDAT_CMP)%>">-->
                                            </td>
                                            <% }%>
                                            <td nowrap align="right"><strong><%=ApplicationConfigurator.LanguageManager.getString("Destinatario.tutela")%>&nbsp;</strong></td>
                                            <td align="left">
                                                <select tabindex="6" name="TPL_DSI_MIS_PET" style="width:120px" id="TPL_DSI_MIS_PET">
                                                    <option value=""></option>
                                                    <option value="O" <% if (("O").equals(strTPL_DSI_MIS_PET)) {
                out.print("selected");
            }%>><%=ApplicationConfigurator.LanguageManager.getString("PER.OPERATORE")%></option>
                                                    <option value="T" <% if (("T").equals(strTPL_DSI_MIS_PET)) {
                out.print("selected");
            }%>><%=ApplicationConfigurator.LanguageManager.getString("PER.TUTTI")%></option>
                                                    <option value="A" <% if (("A").equals(strTPL_DSI_MIS_PET)) {
                out.print("selected");
            }%>><%=ApplicationConfigurator.LanguageManager.getString("PER.AZIENDA")%></option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                            <td colspan="5">
                                                <s2s:textarea tabindex="7" cols="100" rows="4" name="DES_MIS_PET" maxlength="3500"><%=Formatter.format(strDES_MIS_PET)%></s2s:textarea>
                                            </td>
                                        </tr>
                                        <%if (ApplicationConfigurator.isModuleEnabled(MODULES.MIS_PET_ISTR_OPE) == true){%>
                                        <tr>
                                            <td align="right" valign="top"><b><%=ApplicationConfigurator.LanguageManager.getString("Istruzioni.Operative.correlate")%>&nbsp;</td>
                                            <td colspan="5">
                                                <input tabindex="7" type="text" style="width:100%" name="IST_OPE_COR" maxlength="200" value="<%=Formatter.format(strIST_OPE_COR)%>">
                                            </td>
                                        </tr><%}%>
                                        <tr>
                                            <td colspan="6" >
                                                <table width="100%">
                                                    <tr>
                                                        <td width="40%">	
                                                            <fieldset style="width:98%">
                                                                <legend><%=ApplicationConfigurator.LanguageManager.getString("Audit")%></legend>
                                                                <table width="100%" cellpadding="0" cellspacing="0" style="margin: 5 3 9 0">
                                                                    <tr>
                                                                        <td nowrap align="right" width="10%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Applicare")%>&nbsp;</td>
                                                                        <td  width="">
                                                                        <input tabindex="8" type="checkbox"  class="checkbox"  name="ADT_MIS_PET" value="S" <% if (("S").equals(Formatter.format(strADT_MIS_PET))) {
                out.print("checked");
            }%>>
                                                                               </td>
                                                                        <td nowrap align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.partenza")%>&nbsp;</td>
                                                                        <td><s2s:Date tabindex="9" id="DAT_PAR_ADT" name="DAT_PAR_ADT" value="<%=Formatter.format(dtDAT_PAR_ADT)%>"/></td>
                                                                    </tr>
                                                                </table>
                                                            </fieldset>	
                                                        </td>
                                                        
                                                        <td width="60%">
                                                            <fieldset style="width:98%">
                                                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Periodicità.misura.di.prevenzione")%></legend>
                                                            <table width="100%"  cellpadding="0" border="0" cellspacing="0" style="margin: 5 3 9 0">
                                                                <tr>
                                                                    <td nowrap align="right" width="10%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Periodicità.(S/N)")%></td>
                                                                    <td >
                                                                    <input type="hidden" name="FORM_PER_MIS_PET" value="1">
                                                                    <input tabindex="10" type="checkbox"  class="checkbox" size="1" maxlength="1"  name="PER_MIS_PET" value="S" <% if (("S").equals(Formatter.format(strPER_MIS_PET))) {
                out.print("checked");
            }%>>
                                                                           </td>
                                                                    <td nowrap align="right"><%=ApplicationConfigurator.LanguageManager.getString("Periodicità.mensile")%>&nbsp;</td>
                                                                    <td><input tabindex="11" type="text" size="8" maxlength="20"  name="PNZ_MIS_PET_MES" value="<%=lPNZ_MIS_PET_MES%>"></td>
                                                                </tr>
                                                            </table>	
                                                        </td>
                                                    </tr>
                                                </table>	
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
                            </tr> 
                        </table>
                    </form>
            </td></tr>
        </table> 
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" id="ifrmWork"></iframe>
        <%
            //-------Loading of Tabs--------------------
            String s = "";
            if (bean != null) {
                s = "false";
                // -----------------------------------------
%>
        <script language="JavaScript">
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
            var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
            var btnBar = new ButtonPanel("batPanel1", btnParams);
            tabbar.addButtonBar(btnBar);
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti")%>", tabbar));
            tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Normative/Sentenze")%>", tabbar));
            //------adding tables to tabs-----------------------
            tabbar.idParentRecord = <%=Formatter.format(lCOD_MIS_PET)%>;
            tabbar.refreshTabUrl="ANA_MIS_PET_RefreshTabs.jsp";	
            tabbar.RefreshAllTabs();
            //tabbar.DEBUG_TABS_IFRM = true;
            //----add action parameters to tabs
            tabbar.tabs[0].tabObj.actionParams ={
                "Feachures":ANA_DOC_Feachures,
                "AddNew":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_MIS_PET/ANA_MIS_PET_Attach.jsp&ATTACH_SUBJECT=DOCUMENT", 
                    "buttonIndex":0													
                },
                "Edit":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_MIS_PET/ANA_MIS_PET_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
                    "buttonIndex":1
                },		
                "Delete":{
                    "url":"../Form_ANA_MIS_PET/ANA_MIS_PET_Delete.jsp?LOCAL_MODE=doc",
                    "target_element":document.all["ifrmWork"],
                    "buttonIndex":2
                }
            }; 
            //--------------------------------------------------
            tabbar.tabs[1].tabObj.actionParams ={
                "Feachures":ANA_NOR_SEN_Feachures,
                "AddNew":	{"url":"../Form_ANA_NOR_SEN/ANA_NOR_SEN_Form.jsp?ATTACH_URL=Form_ANA_MIS_PET/ANA_MIS_PET_Attach.jsp&ATTACH_SUBJECT=NOR_SEN", 
                    "buttonIndex":0
                },		
                "Edit":	{"url":"../Form_ANA_NOR_SEN/ANA_NOR_SEN_Form.jsp?ATTACH_URL=Form_ANA_MIS_PET/ANA_MIS_PET_Attach.jsp&ATTACH_SUBJECT=NOR_SEN",
                    "buttonIndex":1
                },
                "Delete":	{"url":"../Form_ANA_MIS_PET/ANA_MIS_PET_Delete.jsp?LOCAL_MODE=nor",
                    "target_element":document.all["ifrmWork"],
                    "buttonIndex":2
                }			  	
            }; 									
            //--------------------------------------------------
            
        </script>
        <%} else {%>
        <script>
            window.dialogWidth="800px";
            window.dialogHeight="430px";
        </script>
        <%}%>
    </body>
</html>
