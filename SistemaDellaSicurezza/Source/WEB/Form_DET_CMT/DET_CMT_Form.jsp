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

<%-- 
    Document   : DET_CMT_Form
    Created on : 6-mag-2008, 23.15.57
    Author     : Giancarlo Servadei
--%>

<%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_include/ToolBar.jsp"%>
<%@ include file="../_include/ComboBox-Dipendente.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp"%>

<%@ include file="../_menu/menu/menuStructure.jsp"%>

<html>
    <head>
        
        <script type="text/javascript" src="../_scripts/tabs.js"></script>
        <script type="text/javascript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <link rel="stylesheet" href="../_styles/style.css" />
        <link rel="stylesheet" href="../_styles/tabs.css" />
        
        <script type="text/javascript">
            document.write("<title>" + getCompleteMenuPath(SubMenuContrattiServizi,1) + "</title>");

            window.dialogWidth="730px";
            window.dialogHeight="530px";
        
            function populate(obj) {
                if (obj.value > 0 ) {
                    document.all["NOM_FUZ_AZL_COMBO"].value = obj.options(obj.selectedIndex).valueNOM;
                } else {
                    document.all["NOM_FUZ_AZL_COMBO"].value = "";
                }
            }
        </script>
        
    </head>
    
    <body>
        <%
            long lCOD_AZL = Security.getAzienda();

            long lCOD_SRV = 0;
            String strPRO_CON = "";
            String strDES_CON = "";

            long lCOM_COD_DPD = 0;
            String strCOM_RES_TEL = "";

            IAnaContServHome home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");
            IAnaContServ AnaContServ = null;

            if (request.getParameter("ID") != null) {

                lCOD_SRV = Long.parseLong(request.getParameter("ID"));

                AnaContServ = home.findByPrimaryKey(new Long(lCOD_SRV));

                strPRO_CON = Formatter.format(AnaContServ.getPRO_CON());
                strDES_CON = Formatter.format(AnaContServ.getDES_CON());
                lCOM_COD_DPD = AnaContServ.getCOM_COD_DPD();
                strCOM_RES_TEL = Formatter.format(AnaContServ.getCOM_RES_TEL());
            }
        %>
        
        <!-- Form per l'aggiunta di Contratti/Servizi -->
        <form action="DET_CMT_Set.jsp"  method="POST" target="ifrmWork">
            <input name="SBM_MODE" type="hidden" value="<%=(lCOD_SRV == 0) ? "noOperation" : "edt"%>">
            <input name="COD_SRV" type="hidden" value="<%=lCOD_SRV%>">
            
            
            
            <!-- --------------------------TITOLO DEL FORM------------------------------ -->        
            <table width="100%" border="0">
                <tr>
                <td style="width:100%;height:100%;" valign="top" align="left"></td>
                <td valign="top"></td>
                <tr>
                    <td class="title">
                        <script>
                            document.write(getCompleteMenuPathFunction(SubMenuContrattiServizi,1,<%=request.getParameter("ID")%>));
                        </script>
                    </td>
                </tr>
            </table>
            <!-- ---------------------FINE-TITOLO DEL FORM------------------------------ -->    

    
<!-- --------------------------TOOLBAR-------------------------------------- -->    
            <table width="100%">
                <tr>
                    <td><!-- QUI VIENE INSERITA LA TOOLBAR-->
                        <%ToolBar.bShowNew = false;%>
                        <%ToolBar.bShowDelete = false;%>
                        <%ToolBar.bShowSearch = false;%>
                        <%ToolBar.bCanDelete = (AnaContServ != null);%>
                        <%=ToolBar.build(3)%>
                    </td>
                </tr>
            </table>
            <!-- ---------------------FINE--TOOLBAR-------------------------------------- -->   

            
            <table border="0" cellspacing="5"  style="width:100%;text-align:center;">
                <tr>
                    <td>
                        <fieldset>
                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Servizio.commissionato")%></legend>
                            <table border="0" style="width:100%;text-align:center;" cellspacing="5">
                                <tr>
                                    <td style="width:20%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Progressivo.contratto/servizio")%></b></td>
                                    <td style="width:25%;" align="left"><input type="text" name="PRO_CON" readonly value="<%=Formatter.format(strPRO_CON)%>" /></td>
                                    <td style="width:15%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%></td>
                                    <td style="width:40%;" align="left"><textarea rows="2" cols="38" name="DES_CON" readonly><%=Formatter.format(strDES_CON)%></textarea></td>
                                </tr>
                            </table>
                        </fieldset>
                        
                        <br>
                        
                        <fieldset>
                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Responsabile")%></legend>
                            <table border="0" style="width:100%;text-align:center;" cellspacing="5"> 
                                
                                <tr>
                                    <td style="width:23%;" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Nominativo")%></td>
                                    <td style="width:26%;" align="left" colspan="3"><select tabindex="1" id="selectCOM_COD_DPD" name="lCOM_COD_DPD" onchange="populate(this);">
                                                                                <option value=""></option>
                                                                                <%
                                                                            IDipendenteHome d_home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
                                                                            out.print(BuildDipendenteComboBox_DET_CMT(d_home, lCOM_COD_DPD, lCOD_AZL));
                                                                                %>
                                                                                </select></td>
                                </tr>
                                
                                <tr>
                                    <td style="width:23%;"><%=ApplicationConfigurator.LanguageManager.getString("Qualifica")%></td>
                                    <td style="width:26%;"><input tabindex="2" type="text" size="68" name="NOM_FUZ_AZL_COMBO" readonly /></td>
                                    
                                    
                                    
                                    <td style="width:22%;" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Telefono")%></td>
                                    <td style="width:29%;" align="left"><input tabindex="3" type="text" maxlength="15" size="22" name="COM_RES_TEL" value="<%=Formatter.format(strCOM_RES_TEL)%>"/></td>
                                    
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="dContainer" class="mainTabContainer" style="width:100%"></div>
                    </td>
                </tr> 
            </table>
        </form>
        <script>
            populate(document.getElementById("selectCOM_COD_DPD"));
        </script>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
        <%
            if (AnaContServ != null) {
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
        
            var perRischiGenerici = "<br>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Per.rischi.generici")%>";
            tabbar.addTab(new Tab("tab5", "<%=ApplicationConfigurator.LanguageManager.getString("Referenti.in.loco")%>", tabbar));
            
            tabbar.idParentRecord = <%=lCOD_SRV%>;
            tabbar.refreshTabUrl="DET_CMT_Tabs.jsp";
            tabbar.RefreshAllTabs();
            
            //----add action parameters to tabs
            tabbar.tabs[0].tabObj.actionParams ={
                "Feachures":CON_SER_REF_LOC_Feachures,
                "AddNew":	{"url":"../Form_CON_SER_REF_LOC/CON_SER_REF_LOC_Form.jsp",
                    "buttonIndex":0,
                    "disabled": false
                },
                "Edit":	{"url":"../Form_CON_SER_REF_LOC/CON_SER_REF_LOC_Form.jsp",
                    "buttonIndex":1,
                    "disabled": false
                },
                "Delete":	{"url":"../Form_CON_SER_REF_LOC/CON_SER_REF_LOC_Delete.jsp?DELETE_FROM=tab",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"],
                    "disabled": false
                }	
            };
            
        </script>
        <%}%>
        
    </body>
</html>
