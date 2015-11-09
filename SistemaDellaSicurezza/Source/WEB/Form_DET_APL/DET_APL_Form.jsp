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
    Document   : DET_APL_Form
    Created on : 08-mag-2008, 09.24.13
    Author     : Giancarlo Servadei
--%>

<%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.DittaEsterna.*" %>

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
            document.write("<title>" + getCompleteMenuPath(SubMenuContrattiServizi,2) + "</title>");
            
            window.dialogWidth="800px";
            window.dialogHeight="740px";
            
            function gestConsegna(value){
                if (value != 4){
                    document.forms[0].APP_INT_ASS_CON_DES.value = "";
                    document.forms[0].APP_INT_ASS_CON_DES.disabled = true;
                } else {
                document.forms[0].APP_INT_ASS_CON_DES.disabled = false;
            }
        }
        </script>
    </head>
    <body>
        <%
            long lCOD_SRV = 0;
            String strPRO_CON = "";
            String strDES_CON = "";
            String strRAG_SCL_DTE = "";

            String strIDZ_DTE = "";
            String strAPP_TEL = "";
            String strAPP_FAX = "";
            String strAPP_EMAIL = "";

            String strAPP_RES_NOM = "";
            String strAPP_RES_QUA = "";
            String strAPP_RES_TEL = "";

            String strAPP_INT_ASS_DES = "";
            String strAPP_INT_ASS_ORA_LAV = "";
            int iAPP_INT_ASS_COD_CON = 0;
            String strAPP_INT_ASS_CON_DES = "";


            IAnaContServHome home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");
            IAnaContServ AnaContServ = null;

            if (request.getParameter("ID") != null) {

                lCOD_SRV = Long.parseLong(request.getParameter("ID"));

                AnaContServ = home.findByPrimaryKey(new Long(lCOD_SRV));

                strPRO_CON = Formatter.format(AnaContServ.getPRO_CON());
                strDES_CON = Formatter.format(AnaContServ.getDES_CON());
                strRAG_SCL_DTE = Formatter.format(AnaContServ.getRAG_SCL_DTE());
                strIDZ_DTE = Formatter.format(AnaContServ.getIDZ_DTE());

                strAPP_TEL = Formatter.format(AnaContServ.getAPP_TEL());
                strAPP_FAX = Formatter.format(AnaContServ.getAPP_FAX());
                strAPP_EMAIL = Formatter.format(AnaContServ.getAPP_EMAIL());

                strAPP_RES_NOM = Formatter.format(AnaContServ.getAPP_RES_NOM());
                strAPP_RES_QUA = Formatter.format(AnaContServ.getAPP_RES_QUA());
                strAPP_RES_TEL = Formatter.format(AnaContServ.getAPP_RES_TEL());

                strAPP_INT_ASS_DES = Formatter.format(AnaContServ.getAPP_INT_ASS_DES());
                strAPP_INT_ASS_ORA_LAV = Formatter.format(AnaContServ.getAPP_INT_ASS_ORA_LAV());
                iAPP_INT_ASS_COD_CON = AnaContServ.getAPP_INT_ASS_COD_CON();
                strAPP_INT_ASS_CON_DES = Formatter.format(AnaContServ.getAPP_INT_ASS_CON_DES());
            }
        %>
        
        <!-- Form per l'aggiunta di Contratti/Servizi -->
        <form action="DET_APL_Set.jsp"  method="POST" target="ifrmWork">
            <!--input name="SBM_MODE" type="hidden" value="edt"-->
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
                            document.write(getCompleteMenuPathFunction(SubMenuContrattiServizi,2,<%=request.getParameter("ID")%>));
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
    
            
            <table border="0" cellspacing="3" style="width:100%;text-align:center;">
                <tr>
                    <td>
                        <fieldset>
                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.appaltatrice")%></legend>
                            <table border="0" style="width:100%;text-align:center;" cellspacing="5">
                                <tr>
                                    <td style="width:15%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Progressivo.contratto/servizio")%></b></td>
                                    <td style="width:35%;" align="left"><input type="text" size="15" name="PRO_CON" readonly value="<%=strPRO_CON%>" /></td>
                                    <td style="width:15%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%></b></td>
                                    <td style="width:35%;" align="left"><textarea rows="2" cols="38" name="DES_CON" readonly><%=strDES_CON%></textarea></td>
                                </tr>
                                
                                <tr>
                                    <td style="width:15%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Ragione.sociale")%></b></td>
                                    <td style="width:35%;" align="left"><input type="text" size="45" name="lAPP_COD_DTE" value="<%=strRAG_SCL_DTE%>" readonly /></td>
                                    <td style="width:15%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Indirizzo")%></b></td>
                                    <td style="width:35%;" align="left"><input type="text" size="50" name="IDZ_DTE" value="<%=Formatter.format(strIDZ_DTE)%>" readonly /></td>
                                </tr>
                                
                                <tr>
                                    <td style="width:15%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Telefono")%></td>
                                    <td style="width:35%;" align="left"><input tabindex="1" type="text" maxlength="15" size="20" name="APP_TEL" value="<%=Formatter.format(strAPP_TEL)%>" /></td>
                                    <td style="width:15%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Fax")%></td>
                                    <td style="width:35%;" align="left"><input tabindex="2" type="text" maxlength="15" name="APP_FAX" value="<%=Formatter.format(strAPP_FAX)%>" /></td>
                                </tr>
                                
                                <tr>
                                    <td style="width:15%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("E-mail")%></td>
                                    <td style="width:35%;" align="left" colspan="3"><input tabindex="3" size="45" type="text" maxlength="50" name="APP_EMAIL" value="<%=Formatter.format(strAPP_EMAIL)%>" /></td>
                                </tr>
                            </table>
                        </fieldset>
                        
                        <br>
                        
                        <fieldset>
                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Responsabile")%></legend>
                            <table border="0" style="width:100%;text-align:center;" cellspacing="5"> 
                                <tr>
                                    <td style="width:15%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Nominativo")%></td>
                                    <td style="width:35%;" align="left" colspan="3"><input tabindex="4" size="45" maxlength="50" type="text" name="APP_RES_NOM" value="<%=Formatter.format(strAPP_RES_NOM)%>" /></td>
                                </tr>
                                
                                <tr>
                                    <td style="width:15%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Qualifica")%></td>
                                    <td style="width:35%;" align="left"><input tabindex="5" size="45" maxlength="50" type="text" name="APP_RES_QUA" value="<%=strAPP_RES_QUA%>" /></td>
                                    <td style="width:13%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Telefono")%></td>
                                    <td style="width:37%;" align="left"><input tabindex="6" type="text" maxlength="15" name="APP_RES_TEL" value="<%=Formatter.format(strAPP_RES_TEL)%>" /></td>
                                </tr>
                            </table>
                        </fieldset>
                        
                        <br>
                        
                        <fieldset>
                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Intervento.assegnato")%></legend>
                            <table border="0" style="width:100%;text-align:center;" cellspacing="5">
                                <tr>
                                    <td style="width:15%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%></td>
                                    <td style="width:15%;" align="left" colspan="3"><input tabindex="7" type="text" maxlength="50" size="65" name="APP_INT_ASS_DES" value="<%=strAPP_INT_ASS_DES%>" /></td>
                                    <td style="width:7%;" valign="middle" align="right" colspan="2"><%=ApplicationConfigurator.LanguageManager.getString("Orario.di.lavoro")%></td>
                                    <td style="width:18%;" align="left"><input tabindex="8" type="text" size="22" maxlength="15" name="APP_INT_ASS_ORA_LAV" value="<%=Formatter.format(strAPP_INT_ASS_ORA_LAV)%>" /></td>
                                </tr>
                                <tr>
                                    <td style="width:15%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Consegna")%></td>
                                    <td style="width:15%;" align="center"><input type="radio" name="APP_INT_ASS_COD_CON" <%=iAPP_INT_ASS_COD_CON == 1 ? "checked" : ""%> onclick="gestConsegna(this.value);" value="1">ELETTRICA</td>
                                    <td style="width:15%;" align="center"><input type="radio" name="APP_INT_ASS_COD_CON" <%=iAPP_INT_ASS_COD_CON == 2 ? "checked" : ""%> onclick="gestConsegna(this.value);" value="2">MECCANICA</td>
                                    <td style="width:18%;" align="right"><input type="radio" name="APP_INT_ASS_COD_CON" <%=iAPP_INT_ASS_COD_CON == 3 ? "checked" : ""%> onclick="gestConsegna(this.value);" value="3">FIAMMA LIBERA</td>
                                    <td style="width:12%;" align="right"><input type="radio" name="APP_INT_ASS_COD_CON" <%=iAPP_INT_ASS_COD_CON == 4 ? "checked" : ""%> onclick="gestConsegna(this.value);" value="4">ALTRO</td>
                                    <td style="width:25%;" align="left" colspan="2"><input type="text" size="34" name="APP_INT_ASS_CON_DES" maxlength="50" value="<%=strAPP_INT_ASS_CON_DES%>"></td>
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
        <script>gestConsegna(<%=iAPP_INT_ASS_COD_CON%>);</script>
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
            
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Referenti.in.loco.tab")%>", tabbar));
            tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Personale.coinvolto.tab")%>", tabbar));
            tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Prodotti/Sostanze")%>", tabbar));
            tabbar.addTab(new Tab("tab4", "<%=ApplicationConfigurator.LanguageManager.getString("Analisi.dei.rischi.tab")%>", tabbar));
                                           
            tabbar.idParentRecord = <%=lCOD_SRV%>;
            tabbar.refreshTabUrl="DET_APL_Tabs.jsp";
            tabbar.RefreshAllTabs();
                                            
            //----add action parameters to tabs
            tabbar.tabs[0].tabObj.actionParams ={
                "Feachures":APP_REF_LOC_Feachures,
                "AddNew":	{"url":"../Form_APP_REF_LOC/APP_REF_LOC_Form.jsp",
                    "buttonIndex":0,
                    "disabled": false
                },
                "Edit":	{"url":"../Form_APP_REF_LOC/APP_REF_LOC_Form.jsp",
                    "buttonIndex":1,
                    "disabled": false
                },
                "Delete":	{"url":"../Form_APP_REF_LOC/APP_REF_LOC_Delete.jsp?DELETE_FROM=tab",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"],
                    "disabled": false
                }	
            };
            
            tabbar.tabs[1].tabObj.actionParams ={
                "Feachures":APP_PER_COI_Feachures,
                "AddNew":	{"url":"../Form_APP_PER_COI/APP_PER_COI_Form.jsp",
                    "buttonIndex":0,
                    "disabled": false
                },
                "Edit":	{"url":"../Form_APP_PER_COI/APP_PER_COI_Form.jsp",
                    "buttonIndex":1,
                    "disabled": false
                },
                "Delete":	{"url":"../Form_APP_PER_COI/APP_PER_COI_Delete.jsp?DELETE_FROM=tab",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"],
                    "disabled": false
                }	
            };
            
            tabbar.tabs[2].tabObj.actionParams ={
                "Feachures":APP_PRO_SOS_Feachures,
                "AddNew":	{"url":"../Form_APP_PRO_SOS/APP_PRO_SOS_Form.jsp",
                    "buttonIndex":0,
                    "disabled": false
                },
                "Edit":	{"url":"../Form_APP_PRO_SOS/APP_PRO_SOS_Form.jsp",
                    "buttonIndex":1,
                    "disabled": false
                },
                "Delete":	{"url":"../Form_APP_PRO_SOS/APP_PRO_SOS_Delete.jsp?DELETE_FROM=tab",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"],
                    "disabled": false
                }	
            };
            
            tabbar.tabs[3].tabObj.actionParams ={
                "Feachures":APP_ANA_RIS_Feachures,
                "AddNew":	{"url":"../Form_APP_ANA_RIS/APP_ANA_RIS_Form.jsp",
                    "buttonIndex":0,
                    "disabled": false
                },
                "Edit":	{"url":"../Form_APP_ANA_RIS/APP_ANA_RIS_Form.jsp",
                    "buttonIndex":1,
                    "disabled": false
                },
                "Delete":	{"url":"../Form_APP_ANA_RIS/APP_ANA_RIS_Delete.jsp?DELETE_FROM=tab",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"],
                    "disabled": false
                }	
            };

            //-----activate first tab--------------------------
            tabbar.tabs[0].center.click();
        </script>
        <%} else {%>
        <script>
            window.dialogHeight="510px";
        </script>
        <%}%>
    </body>    
</html>
