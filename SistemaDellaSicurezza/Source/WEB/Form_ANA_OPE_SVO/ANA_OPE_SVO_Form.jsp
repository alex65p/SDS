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
<%@ page import="com.apconsulting.luna.ejb.OperazioneSvolta.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp"%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="ANA_OPE_SVO_Util.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<%
    long lCOD_AZL = Security.getAzienda();
// *require Fields
    String strCOD_OPE_SVO = "";   	//1
    String strNOM_OPE_SVO = "";   	//2

// *Not require Fields
    String strDES_OPE_SVO = "";		//3

    String strCOD_MAN = "0";
    if (request.getParameter("ID_PARENT") != null) {
        strCOD_MAN = request.getParameter("ID_PARENT");
    }
    
    IOperazioneSvolta OperazioneSvolta = null;
    if (request.getParameter("ID") != null) {
        strCOD_OPE_SVO = "0";
        strCOD_OPE_SVO = request.getParameter("ID");
        //getting of OperazioneSvolta object
        IOperazioneSvoltaHome home = (IOperazioneSvoltaHome) PseudoContext.lookup("OperazioneSvoltaBean");
        Long ope_svo_id = new Long(strCOD_OPE_SVO);
        OperazioneSvolta = home.findByPrimaryKey(ope_svo_id);
        // getting of object variables
        strNOM_OPE_SVO = Formatter.format(OperazioneSvolta.getNOM_OPE_SVO());
        strDES_OPE_SVO = Formatter.format(OperazioneSvolta.getDES_OPE_SVO());
    }
    
    boolean bExtended = false;
%>

<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuAttivitaLavorative,1) + "</title>");
        </script>
    </head>
    <link rel="stylesheet" href="../_styles/style.css">
    <link rel="stylesheet" href="../_styles/tabs.css">
    <script src="../_scripts/tabs.js"></script>
    <script src="../_scripts/tabbarButtonFunctions.js"></script>
    <script>
        window.dialogWidth="700px";
        window.dialogHeight="490px";
    </script>
    
    <body style="margin:0 0 0 0;">
        <form action="ANA_OPE_SVO_Set.jsp?par=add" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <table cellpadding="0" cellspacing="2" border="0">
                <tr style='height:10;'>
                    <td></td>
                </tr>
                <tr>
                    <td valign="top">
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="center" class="title">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                            (SubMenuAttivitaLavorative,1,<%=request.getParameter("ID")%>));
                                    </script>
                                </td>
                            </tr>
                            <tr>
                        <td>
                            <table border="0">
                             <%@ include file="../_include/ToolBar.jsp" %>
                             <%ToolBar.bShowPrint = false;%>
                             <%=ToolBar.build(3)%>
                             <%
                                if (Security.isExtendedMode()) {
                                    bExtended = true;
                                }
                             %>
                            </table>
                            <fieldset>
                                <legend><%=ApplicationConfigurator.LanguageManager.getString("Operazione.svolta")%></legend>
                                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <input name="SBM_MODE" type="Hidden" value="<%
                                            if (!strCOD_OPE_SVO.equals("")) {
                                                out.print("edt");
                                            } else {
                                                out.print("new");
                                            }%>">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input name="COD_OPE_SVO" type="Hidden" value="<%
                                            if (!strCOD_OPE_SVO.equals("")) {
                                                out.print(strCOD_OPE_SVO);
                                            }%>">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" style="width:70px;"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%></b>&nbsp;</td>
                                        <td><input tabindex="1" style="width:600px;" type="text" name="NOM_OPE_SVO" maxlength="200" value="<%=strNOM_OPE_SVO%>">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td align="right" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                        <td><textarea tabindex="2" name="DES_OPE_SVO" cols="100" style="width:  600px;" rows="5"><%=strDES_OPE_SVO%></textarea></td>
                                    </tr>
                                    <tr><td>&nbsp;</td></tr>
                                </table>
                            </fieldset>
                            <br>
                            <tr>
                                <td><div id="dContainer" class="mainTabContainer" style=""></div></td>
                            </tr> 
                        </td>
                    </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
        <%
            //-------Loading of Tabs---------------------------------
            if (OperazioneSvolta != null) {
                out.print(BuildRischiTab(OperazioneSvolta, lCOD_AZL));
                out.print(BuildDocumentiTab(OperazioneSvolta, lCOD_AZL));
                out.print(BuildMacchineTab(OperazioneSvolta, lCOD_AZL));
                out.print(BuildAgentiChimiciTab(OperazioneSvolta));
                // ------------------------------------------------------
%>
        <script>
            
            
            //--------------------------------------------------
            
            function MacchineDialogParams(){
                obj = new DialogParameters();
                obj.IDE_MAC = null;
                obj.DES_MAC = null;
                obj.toRow = function (row){
                    if(this.IDE_MAC==null) return;
                    row.id = this.ID;
                    row.INDEX = this.COD_OPE_SVO;
                    colInput=row.getElementsByTagName("INPUT");
                    colInput[0].value=this.IDE_MAC;
                    colInput[1].value=this.DES_MAC;
                    return row;
                }
                return obj;
            }
            //--------------------------------------------------
            function AgentiChimiciDialogParams(){
                obj = new DialogParameters();
                obj.NOM_COM_SOS = null;
                obj.DES_CLF_SOS = null;
                obj.toRow = function (row){
                    if(this.NOM_COM_SOS==null) return;
                    row.id = this.ID;
                    row.INDEX = this.COD_OPE_SVO;
                    colInput=row.getElementsByTagName("INPUT");
                    colInput[0].value=this.NOM_COM_SOS;
                    colInput[1].value=this.DES_CLF_SOS;
                    return row;
                }
                return obj;
            }
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
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Rischi")%>", tabbar));
                tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti")%>", tabbar));
                    tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString(
                                                        ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                                            ?"Macchine.attrezzature.impianti"
                                                            :"Macchine/Attrezzature"
                                                )%>", tabbar));
                        tabbar.addTab(new Tab("tab4", "<%=ApplicationConfigurator.LanguageManager.getString("Agenti.chimici")%>", tabbar));
                            //------adding tables to tabs-----------------------
                            tabbar.tabs[0].tabObj.addTable( document.all["RischiHeader"],document.all["Rischi"], true);
                            tabbar.tabs[1].tabObj.addTable( document.all["DocumentiHeader"],document.all["Documenti"], true);
                            tabbar.tabs[2].tabObj.addTable( document.all["MacchineHeader"],document.all["Macchine"], true);
                            tabbar.tabs[3].tabObj.addTable( document.all["AgentiChimiciHeader"],document.all["AgentiChimici"], true);
                            
                            //---------------------------------------------------------
                            tabbar.idParentRecord = <%=Formatter.format(strCOD_OPE_SVO)%>;
                            tabbar.refreshTabUrl="ANA_OPE_SVO_RefreshTabs.jsp";	
                            var attachedTabs = new Array();
                            attachedTabs[0]=tabbar.tabs[0].tabObj;
                            tabbar.tabs[2].tabObj.attachDependedTab(attachedTabs);
                            tabbar.tabs[3].tabObj.attachDependedTab(attachedTabs);
                            
                            //----add action parameters to tabs
                          
                            tabbar.tabs[0].tabObj.actionParams ={"Feachures":ANA_RSO_Feachures,
                                "AddNew":	{"url":"../Form_ANA_RSO/ANA_RSO_Form.jsp?ATTACH_URL=Form_ANA_OPE_SVO/ANA_OPE_SVO_Attach.jsp&ATTACH_SUBJECT=RISC&COD_MAN=<%=strCOD_MAN%>", 
                                    "buttonIndex":0,
                                    "disabled": false
                                },
                                "Edit":	{"url":"../Form_ANA_RSO/ANA_RSO_Form.jsp?ATTACH_URL=Form_ANA_OPE_SVO/ANA_OPE_SVO_Attach.jsp&ATTACH_SUBJECT=RISC&COD_MAN=<%=strCOD_MAN%>",
                                    "buttonIndex":1,
                                    "disabled": false
                                },		
                                "Delete":	{"url":"ANA_OPE_SVO_AttachDel.jsp?ATTACH_SUBJECT=RISC&COD_MAN=<%=strCOD_MAN%>&DEL=1<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                                    "target_element":document.all["ifrmWork"],
                                    "buttonIndex":2,
                                    "disabled": false,
                                    "ExtendedMode": <%= bExtended %>
                                }
                            }; 
                            //----------------------------------------------------------------------
                            tabbar.tabs[1].tabObj.actionParams ={"Feachures":ANA_DOC_Feachures,
                                "AddNew":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_OPE_SVO/ANA_OPE_SVO_Attach.jsp&ATTACH_SUBJECT=DOCUMENT", 
                                    "buttonIndex":0,
                                    "disabled": false
                                },
                                "Edit":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_OPE_SVO/ANA_OPE_SVO_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
                                    "buttonIndex":1,
                                    "disabled": false
                                },		
                                "Delete":	{"url":"ANA_OPE_SVO_AttachDel.jsp?ATTACH_SUBJECT=DOCUMENT",
                                    "target_element":document.all["ifrmWork"],
                                    "buttonIndex":2,
                                    "disabled": false
                                }
                            }; 
                            //----------------------------------------------------------------------------------------------
                            tabbar.tabs[2].tabObj.actionParams ={
                                "Feachures":MAC_OPE_SVO_Feachures,
                                "AddNew":	{"url":"../Form_MAC_OPE_SVO/MAC_OPE_SVO_Form.jsp?COD_MAN=<%=strCOD_MAN%>&ATTACH_URL=Form_ANA_OPE_SVO/ANA_OPE_SVO_Attach.jsp&ATTACH_SUBJECT=MACCHINA", 
                                    "buttonIndex":0,
                                    "disabled": false
                                },
                                "Edit":	{"url":"../Form_MAC_OPE_SVO/MAC_OPE_SVO_Form.jsp?COD_MAN=<%=strCOD_MAN%>&ATTACH_URL=Form_ANA_OPE_SVO/ANA_OPE_SVO_Attach.jsp&ATTACH_SUBJECT=MACCHINA", 
                                    "buttonIndex":1,
                                    "disabled": false
                                },			  	
                                "Delete":	{"url":"../Form_ANA_OPE_SVO/ANA_OPE_SVO_AttachDel.jsp?ATTACH_SUBJECT=MACCHINA&COD_MAN=<%=strCOD_MAN%><%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                                    "target_element":document.all["ifrmWork"],
                                    "buttonIndex":2,
                                    "disabled": false,
                                    "ExtendedMode":  <%= bExtended %>	
                                }		
                            };
                            //----------------------------------------------------------------------------------------------
                            tabbar.tabs[3].tabObj.actionParams ={
                                "Feachures":SOS_CHI_OPE_SVO_Feachures,
                                "AddNew":	{"url":"../Form_SOS_CHI_OPE_SVO/SOS_CHI_OPE_SVO_Form.jsp?COD_MAN=<%=strCOD_MAN%>&ATTACH_URL=Form_ANA_OPE_SVO/ANA_OPE_SVO_Attach.jsp&ATTACH_SUBJECT=AGENTI", 
                                    "buttonIndex":0,
                                    "disabled": false
                                },
                                "Edit":	{"url":"../Form_SOS_CHI_OPE_SVO/SOS_CHI_OPE_SVO_Form.jsp?COD_MAN=<%=strCOD_MAN%>&ATTACH_URL=Form_ANA_OPE_SVO/ANA_OPE_SVO_Attach.jsp&ATTACH_SUBJECT=AGENTI",
                                    "whidth":"750px",
                                    "height":"580px",
                                    "buttonIndex":1,
                                    "disabled": false
                                },			  	
                                "Delete":	{"url":"../Form_ANA_OPE_SVO/ANA_OPE_SVO_AttachDel.jsp?ATTACH_SUBJECT=AGENTI&COD_MAN=<%=strCOD_MAN%><%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                                    "target_element":document.all["ifrmWork"],
                                    "buttonIndex":2,
                                    "disabled": false,
                                    "ExtendedMode":  <%= bExtended %>	
                                }		
                            };
                            //------------------------------------------------------------------------------------------------
                            
        </script>
        <%} else {%>
        <script>
            window.dialogHeight="240px";
        </script>
        <%}%>
    </body>
</html>
