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
            <version number="1.0" date="25/01/2004" author="Roman Chumachenko">
            <comments>
            <comment date="25/01/2004" author="Roman Chumachenko">
            <description>Shablon formi ANA_DTE_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.DittaEsterna.*" %>
<%@ page import="com.apconsulting.luna.ejb.Nazionalita.*" %>

<%@taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Localization.jsp"%>
<%@ include file="ANA_DTE_Util.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<html>
    <head>

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
        
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuAzienda,2) + "</title>");
            
        </script>
        <script>
            window.dialogWidth="870px";
            window.dialogHeight="640px";
        </script>
        
        <link rel="stylesheet" href="../_styles/style.css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
    </head>
    
    <body style="margin:0 0 0 0;">
        <%
            IAziendaHome home = null;
            IAzienda azienda = null;
            IDittaEsternaHome ditta_home = null;
            IDittaEsterna ditta_esterna = null;
            String strCOD_AZL = "";
            //======checking current azienda====================
            long WHE_AZL = Security.getAzienda();
            strCOD_AZL = new String(Long.toString(WHE_AZL));// ID of current Azienda
            //<comment date="24/02/2004" author="Roman Chumachenko">
            //<description>ID_PARENT option</description>
            if (request.getParameter("ID_PARENT") != null) {
                strCOD_AZL = request.getParameter("ID_PARENT");
            }
            //</comment>
            home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
            Long azl_id = new Long(strCOD_AZL);
            azienda = home.findByPrimaryKey(azl_id);
            // azienda data----------
            String strRAG_SCL_AZL = azienda.getRAG_SCL_AZL();
            String strNOM_RSP_AZL = azienda.getNOM_RSP_AZL();
            String strCIT_AZL = azienda.getCIT_AZL();
            //ditta esterna data-----------------------------------

            String strCOD_DTE = "";		 // ID of Ditta
            String strCOD_AZL_DTE = "";

            String strRAG_SCL_DTE = "";
            String strCAG_DTE = "";
            String strIDZ_DTE = "";
            String strCIT_DTE = "";
            String strQLF_RSP_DTE = "";
            String strNOM_RSP_DTE = "";
            String strNOM_RSP_SPP_DTE = "";
            String strDAT_CAT_DTE = "";
            String strCOD_STA = "";
            //--------------------------
            String strNUM_CIC_DTE = "";		//12
            String strPRV_DTE = "";			//13
            String strCAP_DTE = "";			//14
            String strIDZ_PSA_ELT_DTE = "";	//15
            String strDAT_INZ_LAV = "";		//16
            String strDAT_FIE_LAV = "";		//17
            //=====================================================

// stub for debuging
//strCOD_DTE="1042708604171";
            if (request.getParameter("ID") != null) {
                // getting parameters of azienda
                strCOD_DTE = (String) request.getParameter("ID");
                //getting of azienda object
                ditta_home = (IDittaEsternaHome) PseudoContext.lookup("DittaEsternaBean");
                Long dte_id = new Long(strCOD_DTE);
                ditta_esterna = ditta_home.findByPrimaryKey(dte_id);
                // getting of object variables
                strRAG_SCL_DTE = Formatter.format(ditta_esterna.getRAG_SCL_DTE());
                strCAG_DTE = Formatter.format(ditta_esterna.getCAG_DTE());
                strIDZ_DTE = Formatter.format(ditta_esterna.getIDZ_DTE());
                strCIT_DTE = Formatter.format(ditta_esterna.getCIT_DTE());
                strQLF_RSP_DTE = Formatter.format(ditta_esterna.getQLF_RSP_DTE());
                strNOM_RSP_DTE = Formatter.format(ditta_esterna.getNOM_RSP_DTE());
                strNOM_RSP_SPP_DTE = Formatter.format(ditta_esterna.getNOM_RSP_SPP_DTE());
                strDAT_CAT_DTE = Formatter.format(ditta_esterna.getDAT_CAT_DTE());
                strCOD_STA = Formatter.format(ditta_esterna.getCOD_STA());
                //----------------------------------------------------------------------
                strNUM_CIC_DTE = Formatter.format(ditta_esterna.getNUM_CIC_DTE());
                strPRV_DTE = Formatter.format(ditta_esterna.getPRV_DTE());
                strCAP_DTE = Formatter.format(ditta_esterna.getCAP_DTE());
                strIDZ_PSA_ELT_DTE = Formatter.format(ditta_esterna.getIDZ_PSA_ELT_RSP());
                strDAT_INZ_LAV = Formatter.format(ditta_esterna.getDAT_INZ_LAV());
                strDAT_FIE_LAV = Formatter.format(ditta_esterna.getDAT_FIE_LAV());
            }// if request
%>
        
        <form action="ANA_DTE_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <table cellpadding="0" cellspacing="4" border="0" width="850px">
            <tr><td>
            <br>
            <table border="0" cellpadding="0" cellspacing="2"  width='100%'>
                <tr>
                    <td align="center" class="title">
                        <script>
                            document.write(getCompleteMenuPathFunction
                                (SubMenuAzienda,2,<%=request.getParameter("ID")%>));
                        </script>
                    </td>
                </tr>
                <!-- Submit Mode and ID Code -->
                <tr><td><input name="SBM_MODE" type="Hidden" value="<%if (!strCOD_DTE.equals("")) {
                out.print("edt");
            } else {
                out.print("new");
            }%>"></td></tr>
                <tr><td><input name="COD_AZL" type="Hidden" value="<%=strCOD_AZL%>"></td></tr>
                <tr><td><input name="COD_DTE" type="Hidden" value="<%if (!strCOD_DTE.equals("")) {
                out.print(strCOD_DTE);
            }%>"></td></tr>
                <!-- /Submit Mode and ID Code -->
                
                <table border="0">
                    <!-- ############################################################################################## -->
                 <%@ include file="../_include/ToolBar.jsp" %>
                 <%=ToolBar.build(2)%>
                    <!-- ############################################################################################## -->
                </table>
                <tr>
                    <td align="center">
                        <fieldset>
                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.fornitore.personale/servizi")%></legend>
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td colspan="5">
                                        <fieldset>
                                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.azienda/ente")%></legend>
                                            <!-- Data of Current Azienda  -->
                                            <table border="0" cellpadding="0" cellspacing="3">
                                                <tr>
                                                    <td align="right"><b>&nbsp;&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</td><td><input readonly="true" size="127" type="text" name="RAG_SCL_AZL" maxlength="50" value="<%out.print(strRAG_SCL_AZL);%>"></td>
                                                </tr>
                                                <tr><td height="2"></td></tr>
                                                <tr>
                                                    <td align="right"><b>&nbsp;&nbsp;&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro")%>&nbsp;</td><td><input readonly="true" size="64" type="text" name="NOM_RSP_AZL" maxlength="100" value="<%out.print(Formatter.format(strNOM_RSP_AZL));%>">
                                                                                  &nbsp;<b><%=ApplicationConfigurator.LanguageManager.getString("Città")%>&nbsp;<input readonly="true" size="51" type="text" name="CIT_AZL" maxlength="30" value="<%out.print(Formatter.format(strCIT_AZL));%>"></td>
                                                </tr>
                                                
                                            </table>
                                        </fieldset>
                                        
                                        <!-- /Data of Current Azienda  -->
                                    </td>
                                </tr>
                                
                                <tr><td height="7"></td></tr>
                                <!-- Categoria - Citta  -->
                                <tr>
                                    <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Categoria")%>&nbsp;</td><td><input tabindex="1" size="42" type="text" name="CAG_DTE" maxlength="50" value="<%out.print(strCAG_DTE);%>"></td>
                                    <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Ragione.sociale")%>&nbsp;</td><td><input tabindex="2" size="45" type="text" name="RAG_SCL_DTE" maxlength="50" value="<%out.print(strRAG_SCL_DTE);%>"></td>
                                </tr>
                                
                                <tr><td height="2"></td></tr>
                                <tr>
                                    <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Stato")%>&nbsp;</td><td>
                                        <select tabindex="3" style="width:235;" name="COD_STA">
                                            <option value=''></option>
                                            <%
            INazionalitaHome nz_home = (INazionalitaHome) PseudoContext.lookup("NazionalitaBean");
            if (strCOD_STA.equals("")) {
                strCOD_STA = "0";
            }
            long COD_LNG = Localization.getCurrentLanguageCode();
            String nz_cb = BuildNazionalitaComboBox(nz_home, new Long(strCOD_STA).longValue(), COD_LNG);
            out.print(nz_cb);
                                            %>
                                        </select>
                                    </td>
                                    <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Città")%>&nbsp;</td><td><input tabindex="4" size="25" type="text" name="CIT_DTE" maxlength="30" value="<%out.print(strCIT_DTE);%>">
                                    &nbsp;&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Provincia")%>&nbsp;<input tabindex="5" size="2" type="text" name="PRV_DTE" maxlength="2" value="<%out.print(strPRV_DTE);%>"></td>
                                </tr>
                                <!-- /Categoria - Citta  -->

         
         
         <!-- /Indirizzo - C.a.p.  -->
                                
                                <tr>
                                    <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Indirizzo")%>&nbsp;</td>
                                    <td><input tabindex="6" size="45" type="text" name="IDZ_DTE" maxlength="50" value="<%out.print(strIDZ_DTE);%>">
                                    </td>
                                    
                                    <td align="rignt"><div align="right"><%=ApplicationConfigurator.LanguageManager.getString("Numero.civico")%>&nbsp;</div></td>
                                    <td><input tabindex="7" size="12" type="text" name="NUM_CIC_DTE" maxlength="30" value="<%out.print(strNUM_CIC_DTE);%>">
                                        
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("C.a.p.")%>&nbsp;<input tabindex="8" size="16" type="text" name="CAP_DTE" maxlength="15" value="<%out.print(strCAP_DTE);%>">
                                    </td>
                                    
                                </tr>
                                <!-- /Indirizzo - C.a.p.  -->
                                <tr><td height="2"></td></tr>	
                                
                                <!-- Datore di lavoro   Responsable SPP -->
                                <tr>
                                    <td align="right"><b>&nbsp;&nbsp;&nbsp;&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro")%>&nbsp;</td>
                                    <td>
                                        <input tabindex="9" name="NOM_RSP_DTE"size="45" value="<%out.print(strNOM_RSP_DTE);%>" maxlength="100">
                                    </td>
                                    
                                    <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Responsabile.S.P.P.")%>&nbsp;</td>
                                    <td>
                                        <input tabindex="10" name="NOM_RSP_SPP_DTE" tabindex="13" size="45" value="<%out.print(strNOM_RSP_SPP_DTE);%>" maxlength="100">
                                    </td>
                                </tr>  
                                <!-- /Datore di lavoro   Responsable SPP -->
         
                                <!-- Qualifica responsabile S.P.P --> 	
                                <tr>
                                    <td height="2" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Qualifica.resp.S.P.P.")%>&nbsp;</td>			   
                                    
                                    <td colspan="5">
                                        <input tabindex="11" name="QLF_RSP_DTE" type="text" maxlength="50" size="68" value="<%out.print(strQLF_RSP_DTE);%>">
                                    </td>
                                </tr>
                                <!-- /Qualifica responsabile S.P.P --> 	
                                <!-- Dates --> 	
                                <tr>
                                    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.inizio.lavori")%>&nbsp;</td>
                                    <td>
                                        <s2s:Date tabindex="12" id="DAT_INZ_LAV" name="DAT_INZ_LAV" value="<%=Formatter.format(strDAT_INZ_LAV)%>"/>
                                    </td>
                                    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.fine.lavori")%>&nbsp;</td>
                                    <td>
                                        <s2s:Date tabindex="13" id="DAT_FIE_LAV" name="DAT_FIE_LAV" value="<%=Formatter.format(strDAT_FIE_LAV)%>"/>
                                    </td>
                                    
                                </tr>
                                <!-- /Dates --> 	
                            </table>	 
                </fieldset></td></tr>
                <tr>
                    <td align="left"><div  id="dContainer" class="mainTabContainer" style="width:100%;"></div></td>
                </tr> 
            </table> 
        </form>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <%
            //-------Loading of Tabs--------------------
            if (ditta_esterna != null) {
                out.print(BuildDocAssociatiTab(ditta_esterna));
                out.print(BuildLuoghiFisiciTab(ditta_esterna));
                out.print(BuildDTETelefoniTab(ditta_esterna));
                // -----------------------------------------
%>
        <script language="JavaScript">
            // DocAssociatiTab
            function DocAssociatiDialogParams(){
                obj = new DialogParameters();
                obj.TIT_DOC = null;
                obj.RSP_DOC = null;
                obj.DOC_CSG_RCR = null;
                obj.DAT_REV_DOC = null;
                obj.COD_DTE = null;
                obj.toRow = function (row){
                    // stub for non changes
                    if (this.TIT_DOC==null) return;
                    row.id = this.ID;
                    row.INDEX = this.COD_DTE;
                    colInput=row.getElementsByTagName("INPUT");
                    colInput[0].value=this.TIT_DOC;
                    colInput[1].value=this.RSP_DOC;
                    colInput[2].value=this.DOC_CSG_RCR;
                    colInput[3].value=this.DAT_REV_DOC;
                    return row;
                }
                return obj;
            }
            // DTETelefoniTab
            function DTETelefoniDialogParams(){
                obj = new DialogParameters();
                obj.TPL_NUM_TEL = null;
                obj.NUM_TEL = null;
                obj.COD_DTE= null;
                obj.toRow = function (row){
                    // stub for non changes
                    if (this.TPL_NUM_TEL==null) return;
                    row.id = this.ID;
                    row.INDEX = this.COD_DTE;
                    colInput=row.getElementsByTagName("INPUT");
                    colInput[0].value=this.TPL_NUM_TEL;
                    colInput[1].value=this.NUM_TEL;
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
            /*   btnParams[3] = {"id":"btnHelp", 
            "onmousedown":btnDown, 	
            "onmouseup":btnOver,
            "onmouseover":btnOver,
            "onmouseout":btnOut,
            "onclick":windowHelp,
            "src":"../_images/HELP.GIF",
            "action":"Help"
            };	*/
            //--------creating tabs--------------------------
            var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
            var btnBar = new ButtonPanel("batPanel1", btnParams);
            tabbar.addButtonBar(btnBar);
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti.associati")%>", tabbar));
            tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Luoghi.fisici")%>", tabbar));
            tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Numeri.telefonici")%>", tabbar));
            
            //------adding tables to tabs-----------------------
            tabbar.tabs[0].tabObj.addTable( document.all["DocAssociatiHeader"],document.all["DocAssociati"], true);
            tabbar.tabs[1].tabObj.addTable( document.all["LuoghiFisiciHeader"],document.all["LuoghiFisici"], true);
            tabbar.tabs[2].tabObj.addTable( document.all["DTETelefoniHeader"],document.all["DTETelefoni"], true);
            //----add action parameters to tabs
            tabbar.idParentRecord = <%=Formatter.format(strCOD_DTE)%>;
            tabbar.refreshTabUrl="ANA_DTE_RefreshTabs.jsp";	
            //--------------------------------------------------------------------						
            tabbar.tabs[0].tabObj.actionParams ={
                "Feachures":DOC_CSG_DTE_Feachures,	
                "AddNew":	{"url":"../Form_DOC_CSG_DTE/DOC_CSG_DTE_Form.jsp", 
                    "addDialogParameters":new DocAssociatiDialogParams(),
                    "buttonIndex":0,
                    "disabled": false
                },
                "Edit":	{"url":"../Form_DOC_CSG_DTE/DOC_CSG_DTE_Form.jsp",
                    "editDialogParameters":new DocAssociatiDialogParams(),
                    "buttonIndex":1,
                    "disabled": false
                },			  	
                "Delete":	{"url":"../Form_DOC_CSG_DTE/DOC_CSG_DTE_Delete.jsp",
                    "target_element":document.all["ifrmWork"],	
                    "buttonIndex":2,
                    "disabled": false
                },
                "Help":	{"url":"../Form_DOC_CSG_DTE/DOC_CSG_DTE_Help.jsp",
                    "buttonIndex":3,
                    "disabled": false	
                }	
            }; 
            //--------------------------------------------------------------------		
            tabbar.tabs[1].tabObj.actionParams ={"Feachures":ANA_LUO_FSC_Feachures,
                "AddNew":	{"url":"../Form_ANA_LUO_FSC/ANA_LUO_FSC_Form.jsp?ATTACH_URL=Form_ANA_DTE/ANA_DTE_Attach.jsp&ATTACH_SUBJECT=LFISICO", 
                    "buttonIndex":0,
                    "disabled": false
                },
                "Edit":	{"url":"../Form_ANA_LUO_FSC/ANA_LUO_FSC_Form.jsp?ATTACH_URL=Form_ANA_DTE/ANA_DTE_Attach.jsp&ATTACH_SUBJECT=LFISICO",
                    "buttonIndex":1,
                    "disabled": false
                },		
                "Delete":	{"url":"ANA_DTE_AttachDel.jsp?ATTACH_SUBJECT=LFISICO",
                    "target_element":document.all["ifrmWork"],
                    "buttonIndex":2,
                    "disabled": false
                },
                "Help":	{"url":"../Form_ANA_LUO_FSC/ANA_LUO_FSC_Help.jsp",
                    "buttonIndex":3,
                    "disabled": false	
                }
            }; 
            //--------------------------------------------------------------------						
            tabbar.tabs[2].tabObj.actionParams ={"Feachures":NUM_TEL_FOR_Feachures,
                "AddNew":	{"url":"../Form_NUM_TEL_DTE/NUM_TEL_DTE_Form.jsp", 
                    "buttonIndex":0,
                    "disabled": false
                },
                "Edit":	{"url":"../Form_NUM_TEL_DTE/NUM_TEL_DTE_Form.jsp",
                    "buttonIndex":1,
                    "disabled": false
                },		
                "Delete":	{"url":"../Form_NUM_TEL_DTE/NUM_TEL_DTE_Delete.jsp",
                    "target_element":document.all["ifrmWork"],
                    "buttonIndex":2,
                    "disabled": false
                },
                "Help":	{"url":"../Form_NUM_TEL/NUM_TEL_Help.jsp",
                    "buttonIndex":3,
                    "disabled": false	
                }                      
            }; 	
            //--------------------------------------------------------------------	
            
            
        </script>
        <%} else {%>
        <script>
            window.dialogWidth="870px";
            window.dialogHeight="400px";
        </script>
        <%}%>
    </body>
</html>
