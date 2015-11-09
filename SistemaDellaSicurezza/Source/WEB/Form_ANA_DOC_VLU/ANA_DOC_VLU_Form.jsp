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
    <version number="1.0" date="25/01/2004" author="Khomenko Juliya">
    <comments>
    <comment date="25/01/2004" author="Khomenko Juliya">
    <description>Shablon formi ANA_DOC_VLU_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.ValutazioneRischi.*" %>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="ANA_DOC_VLU_Util.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuDVR,3) + "</title>");
        </script>
        <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <script language="JavaScript" src="../_scripts/ajax.js"></script>

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
        
        <script type="text/javascript">
            window.dialogWidth="670px";
            window.dialogHeight="495px";
        </script>
    </head>

    <body>
        <%
            long lCOD_DOC_VLU = 0;		//1
            String strDAT_DOC_VLU = "";   	//2
            String strNOM_RSP_DOC = "";         //3
            String strVER_DOC = "";		//4
            long lCOD_UNI_ORG = -1;		//5
            long lCOD_AZL = Security.getAzienda();	//6

            IValutazioneRischi ValutazioneRischi = null;

            if (request.getParameter("ID") != null) {
                String strCOD_DOC_VLU = request.getParameter("ID");
                IValutazioneRischiHome home = (IValutazioneRischiHome) PseudoContext.lookup("ValutazioneRischiBean");
                Long doc_vlu_id = new Long(strCOD_DOC_VLU);
                ValutazioneRischi = home.findByPrimaryKey(doc_vlu_id);

                lCOD_DOC_VLU = doc_vlu_id.longValue(); 						//1
                strDAT_DOC_VLU = Formatter.format(ValutazioneRischi.getDAT_DOC_VLU());  //2
                strNOM_RSP_DOC = Formatter.format(ValutazioneRischi.getNOM_RSP_DOC());	//2
                strVER_DOC = ValutazioneRischi.getVER_DOC();					//3
                lCOD_AZL = ValutazioneRischi.getCOD_AZL();
                lCOD_UNI_ORG = ValutazioneRischi.getCOD_UNI_ORG();

                Security.setCurrentDvrUniOrg(new Long(lCOD_UNI_ORG));
                Security.setCurrentDvrUniOrgName(null);
            }

            IAzienda azienda = null;
            IAziendaHome AziendaHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");

            Long azl_id = new Long(lCOD_AZL);
            azienda = AziendaHome.findByPrimaryKey(azl_id);
            String strRAG_SCL_AZL = azienda.getRAG_SCL_AZL();
        %>
        <script type="text/javascript">
            function beforeInsert(){
                eseguiChiamataAjax(
                    'ANA_DOC_VLU_Generate.jsp?ID=<%=lCOD_DOC_VLU%>&SID=<%=lCOD_AZL%>', 
                    document.getElementById("ajaxWorkArea"), 
                    false);
                alert("<%=ApplicationConfigurator.LanguageManager.getString("DVR.generate.msg.1")%>");
                RefreshTab();
            }
        </script>
        <!-- form for addind  ValutazioneRischi-->
        <form action="ANA_DOC_VLU_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value="<%=(lCOD_DOC_VLU == 0) ? "new" : "edt"%>">
            <input type="hidden" name="COD_DOC_VLU_ID" value="<%=lCOD_DOC_VLU%>">
            <input type="hidden" name="COD_AZL" value="<%=lCOD_AZL%>">
            <table width="100%" border="0">
                <!-- posizione precedente della toolbar -->
                <tr>
                    <td valign="top">
                        <table  width="100%">
                            <tr>
                                <td class="title">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                        (SubMenuDVR,3,<%=request.getParameter("ID")%>));
                                    </script>      
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="100%" border="0">
                                        <tr> 
                                            <!-- toolbar --> 
                                            <!-- ############################ -->  		
                                            <%@ include file="../_include/ToolBar.jsp" %>      
                                            <%ToolBar.bCanDelete = (ValutazioneRischi != null);
                                                ToolBar.strPrintUrl = "DocumentoValutazioneRischi.jsp?";
                                            %>		
                                            <%=ToolBar.build(2)%> 
                                            <!-- ########################### -->
                                        </tr> 
                                    </table>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Documento.di.valutazione.dei.rischi")%></legend>
                                        <table  width="100%" border="0">
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
                                                <td colspan="3"><input size="92%" readonly type="text" value="<%=strRAG_SCL_AZL%>"> </td>
                                            </tr> 
                                            <tr>
                                                <td align="right" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Unità.organizzativa")%>&nbsp;</td>
                                                <td colspan="3">
                                                    <select name="COD_UNI_ORG" style="width:94%">
                                                        <option> </option>
                                                        <%
                                                            IUnitaOrganizzativa uoBean = null;
                                                            IUnitaOrganizzativaHome uoHome = (IUnitaOrganizzativaHome) PseudoContext.lookup("UnitaOrganizzativaBean");
                                                            String nodes = uoHome.buildTreeNodes(uoBean, uoHome, 0, lCOD_UNI_ORG, lCOD_AZL, true);
                                                            out.println(nodes);%>
                                                    </select>
                                                </td>
                                            </tr> 
                                            <tr>
                                                <td align="right" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro")%>&nbsp;</td>
                                                <td colspan="3"><input tabindex="1" size="92%" type="text" maxlength="100" name="NOM_RSP_DOC" value="<%=strNOM_RSP_DOC%>"></td>
                                            </tr> 
                                            <tr>
                                                <td align="right" width="20%" nowrap><b><%=ApplicationConfigurator.LanguageManager.getString("Data.redazione")%>&nbsp;</b></td>
                                                <td align="left" width="20%">
                                                    <s2s:Date tabindex="2" id="DAT_DOC_VLU" name="DAT_DOC_VLU" value="<%=strDAT_DOC_VLU%>"/>
                                                </td>
                                                <td align="right" width="10%"><b><%=ApplicationConfigurator.LanguageManager.getString("Versione")%>&nbsp;</b></td>
                                                <td>
                                                    <input tabindex="3" size="56%" maxlength="80" type="text" name="VER_DOC" value="<%=strVER_DOC%>">
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset> 
                                </td>
                            </tr>
                            <tr>
                                <td><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
                            </tr> 
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <!-- /form for addind  ValutazioneRischi-->
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <div id="ajaxWorkArea" style="display: none;"></div>
        <%
            //-------Loading of Tabs--------------------
            if (ValutazioneRischi != null) {
        %>
        <script language="JavaScript" src="../_scripts/index.js"></script>
        <script language="JavaScript">

            //--------BUTTONS description-----------------------
            btnParams = new Array();
            btnParams[0] = {"id":"btnNew", 
                "onmousedown":btnDown, 	
                "onmouseup":btnOver,
                "onmouseover":btnOver,
                "onmouseout":btnOut,
                "onclick":addRow,
                "src":"../_images/NUOVO.gif", 
                "action":"AddNew"
            };
            btnParams[1] = {"id":"btnEdit", 
                "onmousedown":btnDown, 	
                "onmouseup":btnOver,
                "onmouseover":btnOver,
                "onmouseout":btnOut,
                "onclick":editRow,
                "src":"../_images/EDIT.gif", 
                "action":"Edit"
            };				
            btnParams[2] = {"id":"btnCancel", 
                "onmousedown":btnDown, 
                "onmouseup":btnOver,
                "onmouseover":btnOver,
                "onmouseout":btnOut,
                "onclick":delRow,
                "src":"../_images/DEL_DET.gif",
                "action":"Delete"
            };
            //--------creating tabs--------------------------
            DVR_ALLEGATI = <%=ApplicationConfigurator.isModuleEnabled(MODULES.DVR_ALLEGATI)%>
            DVR_ARCHIVIO = <%=ApplicationConfigurator.isModuleEnabled(MODULES.DVR_ARCHIVIO)%>
            var tabbar = new TabBar("tbr1",document.all["dContainer"]);
            var btnBar = new ButtonPanel("batPanel1", btnParams);
            tabbar.addButtonBar(btnBar);
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Sezioni")%>", tabbar));
            if (DVR_ALLEGATI){
                tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Allegati")%>", tabbar));
            }
            if (DVR_ARCHIVIO){
                tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Archivio.dvr")%>", tabbar));
            }
            //------adding dinamic tables to tabs-----------------------
            tabbar.idParentRecord = <%= lCOD_DOC_VLU%>;
            tabbar.refreshTabUrl="ANA_DOC_VLU_Tabs.jsp";	
            tabbar.RefreshAllTabs();

            //-----activate first tab--------------------------
            tabbar.tabs[0].center.click();
            //----add action parameters to tabs
            tabbar.tabs[0].tabObj.actionParams ={
                "Feachures":ANA_ARE_Feachures,
                "AddNew":	{"url":"../Form_ANA_ARE/ANA_ARE_Form.jsp?ATTACH_URL=Form_ANA_DOC_VLU/ANA_DOC_VLU_Attach.jsp&ATTACH_SUBJECT=DOC_VLU", 
                    "buttonIndex":0					 						
                },
                "Edit":	{"url":"../Form_ANA_ARE/ANA_ARE_Form.jsp?ATTACH_URL=Form_ANA_DOC_VLU/ANA_DOC_VLU_Attach.jsp&ATTACH_SUBJECT=DOC_VLU",
                    "buttonIndex":1
                },
                "Delete":	{"url":"../Form_ANA_DOC_VLU/ANA_DOC_VLU_Delete.jsp?LOCAL_MODE=DOC_VLU",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"]
                }
            }
            var i = 1;
            if (DVR_ALLEGATI){
                tabbar.tabs[i++].tabObj.actionParams ={
                    "Feachures":ANA_DOC_Feachures,
                    "AddNew":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_DOC_VLU/ANA_DOC_VLU_Attach.jsp&ATTACH_SUBJECT=DOC",
                        "buttonIndex":0
                    },
                    "Edit":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_DOC_VLU/ANA_DOC_VLU_Attach..jsp&ATTACH_SUBJECT=DOC_VLU",
                        "buttonIndex":1
                    },
                    "Delete":	{"url":"../Form_ANA_DOC_VLU/ANA_DOC_VLU_Delete.jsp?LOCAL_MODE=DOC",
                        "buttonIndex":2,
                        "target_element":document.all["ifrmWork"]
                    }
                }
            }
            if (DVR_ARCHIVIO){
                tabbar.tabs[i++].tabObj.actionParams ={
                "Feachures":INVISIBLE_Feachures,
                    "AddNew":	{"url":"",
                        "buttonIndex":0,
                        "checkBeforeInsert":true
                    },
                    "Edit":	{"url":"../_include/SHOW_File.jsp?NOM_TAB=ARC_DOC_VLU_TAB&TYPE=FILE_DVR",
                        "buttonIndex":1,
                        "modalWindow":false
                    },
                    "Delete":	{"url":"../Form_ANA_DOC_VLU/ANA_DOC_VLU_Delete.jsp?LOCAL_MODE=ARC",
                        "buttonIndex":2,
                        "target_element":document.all["ifrmWork"]
                    }
                }
            }
        </script> 
        <%} else {%>
        <script>
            window.dialogWidth="670px";
            window.dialogHeight="290px";
        </script>
        <%}%>
    </body>
</html> 
