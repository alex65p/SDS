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
            <version number="1.0" date="05/02/2004" author="Alex Kyba">
            <comments>
            <comment date="05/02/2004" author="Alex Kyba">
            <description>Shablon formi ANA_MIS_PET_Form.jsp</description>
            </comment>
            <comment date="27/03/2004" author="Treskina Mary">
            <description>dannie kotorie imeut v table tip int prinimau v stroky...eto neobhodimo dla korrektnoj raboti poiska</description>
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
<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.TipologieMacchine.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuMacchinari,1) + "</title>");
        </script>
    </head>
    <link rel="stylesheet" href="../_styles/style.css">
    <link rel="stylesheet" href="../_styles/tabs.css">
    <script language="JavaScript" src="../_scripts/tabs.js"></script>
    <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
    <script>
        window.dialogWidth="900px";
        window.dialogHeight="620px";
    </script>
    <script language="JavaScript" src="../_scripts/textarea.js"></script>
    <style>
        .getList{
            width:20px;
            height:20px;
            vertical-align:middle;
        }
    </style>
    <body style="margin: 0 0 0 0">

        <%
                    String strCOD_MIS_PET_AZL = "";
                    boolean bExtended = false;
                    //-------------------------------------------------
                    long lCOD_AZL = Security.getAzienda();
                    String strRAG_SCL_AZL = new String();
                    //------------------
                    String strIDE_MAC = "";     	//1------
                    String strDES_MAC = ""; 		//2------
                    String strMDL_MAC = "";       //3------
                    String strDIT_CST_MAC = "-";  //4------
                    String strFBR_MAC = "";       //5------
                    long lCOD_TPL_MAC = 0;        //6------
                    long lCOD_MAC = 0;    		//8------
                    //-----------------------
                    //long lYEA_CST_MAC=0;
                    String strYEA_CST_MAC = "";   //9------
                    String strTAR_MAC = "";		//10-----
                    String strPPO_MAC = "";		//11-----
                    String strMRC_MAC = "";		//12-----
                    //long lPRT_MAC=0;		    //13-----
                    String strPRT_MAC = "";		    //13-----
                    String strCAT_MAC = "";		//14-----
                    String strPRE_MAC = "";
                    //---------------------------

                    java.util.Collection col;
                    java.util.Iterator it;
                    //------------------------------------------------------------------
                    //----------------Interfaces & Beans--------------------------------
                    //------------------------------------------------------------------
                    //-----Azienda--------
                    IAziendaHome azHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");
                    IAzienda azienda = null;

                    //----------get current azienda -----------------
                    azienda = azHome.findByPrimaryKey(new Long(lCOD_AZL));
                    strRAG_SCL_AZL = azienda.getRAG_SCL_AZL();
                    //-------Tipologia Macchine--------------
                    ITipologieMacchine tpl = null;
                    ITipologieMacchineHome tplHome = (ITipologieMacchineHome) PseudoContext.lookup("TipologieMacchineBean");

                    //----Nacchina Attrezzatura-----------
                    IMacchina bean = null;
                    IMacchinaHome home = (IMacchinaHome) PseudoContext.lookup("MacchinaBean");
                    //---------
                    // stub for debuging
                    //strCOD_AZL="1042315978732";
                    //if (true) return;
                    if (request.getParameter("ID") != null) {
                        // getting parameters of azienda
                        try {
                            Long ID = new Long(request.getParameter("ID"));
                            bean = home.findByPrimaryKey(new MacchinaPK(lCOD_AZL, ID.longValue()));
                            strIDE_MAC = bean.getIDE_MAC();     	//1------
                            strDES_MAC = bean.getDES_MAC(); 		//2------
                            strMDL_MAC = bean.getMDL_MAC();       //3------
                            strDIT_CST_MAC = bean.getDIT_CST_MAC();   //4------
                            strFBR_MAC = bean.getFBR_MAC();       //5------
                            lCOD_TPL_MAC = bean.getCOD_TPL_MAC();     //6-------
                            lCOD_MAC = bean.getCOD_MAC();    		//8------
                            //-----------------------
                            strYEA_CST_MAC = Formatter.format(bean.getYEA_CST_MAC()); 	//9---------
                            strTAR_MAC = bean.getTAR_MAC();		//10----
                            strPPO_MAC = bean.getPPO_MAC();		//11----
                            strMRC_MAC = bean.getMRC_MAC();		//12----
                            strPRT_MAC = Formatter.format(bean.getPRT_MAC());		//13--------
                            strCAT_MAC = bean.getCAT_MAC();		//14
                            strPRE_MAC = bean.getPRE_MAC();


                        } catch (Exception ex) {
                            out.print("<strong>" + ex.getMessage() + "</strong>");
                            return;
                        }
                    }// if request*/
%>

        <form action="ANA_MAC_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" >
                <!-- posizione precedente della toolbar -->


                <tr style='height:10'><td align="center" colspan="2" height="10" ></td></tr>
                <tr><td align="center" colspan="2" class="title">
                        <script>
                            document.write(getCompleteMenuPathFunction
                            (SubMenuMacchinari,1,<%=request.getParameter("ID")%>));
                        </script>
                        <br></td></tr>
            </table>
            <input name="SBM_MODE" type="Hidden" value="<%if (lCOD_MAC != 0) {
                            out.print("edt");
                        } else {
                            out.print("new");
                        }%>">

            <input type="hidden" size="20" maxlength="20"  name="COD_MAC" value="<%=Formatter.format(lCOD_MAC)%>">
            <input type="hidden" size="20" maxlength="20"  name="DIT_CST_MAC" value="<%=Formatter.format(strDIT_CST_MAC)%>">

            <table border="0" cellpadding="1" cellspacing="1" width="100%">
                <!-- toolbar -->
                <!-- ########################################################################################################## -->
                <%@ include file="../_include/ToolBar.jsp" %>
                <%
                            if (request.getParameter("ID") == null) {
                                ToolBar.bCanDelete = ToolBar.bCanEdit;
                                ToolBar.bCanDelete = false;
                                ToolBar.bCanEdit = false;
                                ToolBar.bCanPrint = false;
                                //ToolBar.strSearchUrl = "";
                            }
                            ToolBar.strPrintUrl = "SchedaMacchinaAttrezzatura.jsp?";
                %>
                <%=ToolBar.build(5)%>
                <%
                            if (Security.isExtendedMode() && (bean == null || bean.isMultiple())) {
                                bExtended = true;
                %><script>isExtendedForm=true;</script><%
                            }
                %>

                <!-- ########################################################################################################## -->
            </table>
            <table width="100%">

                <!--inserimento toolbar -->
                <!--fine  inserimento -->




                <tr>
                    <td colspan="100%" align="center">
                        <fieldset style="width:100%">
                            <legend><%=ApplicationConfigurator.LanguageManager.getString(
                                    ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                        ?"Dati.macchina.attrezzatura.impianto"
                                        :"Dati.macchina/attrezzatura"
                        )%></legend>
                            <table width="100%" border="0">
                                <tr>
                                    <td align="right" width="10%"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</td>
                                    <td  width="750" colspan="6">
                                        <input type="hidden" name="COD_AZL"  id="COD_AZL" value="<%= Formatter.format(lCOD_AZL)%>">
                                        <input style="width:100%" type="text" readonly name="RAG_SCL_AZL"  value="<%= Formatter.format(strRAG_SCL_AZL)%>"></td>
                                </tr>
                                <tr>
                                    <td align="left"></td>
                                    <td align="left" colspan="100%">
                                        <fieldset>
                                            <legend><%=ApplicationConfigurator.LanguageManager.getString(
                                                ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                                    ?"Dati.tipologia.macchina.attrezzatura.impianto"
                                                    :"Dati.tipologia.macchina/attrezzatura"
                                            )%></legend>
                                            <table width="100%" border="0">
                                                <tr>
                                                    <td align="right" width="20%">
                                                        <strong><%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%>&nbsp;</strong>
                                                    </td>
                                                    <td align="left">
                                                        <select  tabindex="1" name="COD_TPL_MAC" id="COD_TPL_MAC">
                                                            <option value=""></option>
                                                            <%
                                                                        col = tplHome.getTipologieMacchineView();
                                                                        String tplMac_cmb = BuildTpologiaMacchineComboBox(col, lCOD_TPL_MAC);
                                                                        out.print(tplMac_cmb);
                                                            %>
                                                        </select>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"  valign="top"><strong><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</strong></td>
                                    <td >
                                        <s2s:textarea tabindex="2" cols="1" rows="5" style="width:100%" name="DES_MAC"  maxlength="900"><%=Formatter.format(strDES_MAC)%></s2s:textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" nowrap><strong><%=ApplicationConfigurator.LanguageManager.getString("Modello")%>&nbsp;</strong></td>
                                    <td>
                                        <table width="100%" cellpadding="0" cellspacing="0" border=0>
                                            <tr>
                                                <td>
                                                    <input tabindex="3" type="text" size="100" maxlength="100"  name="MDL_MAC" value="<%= Formatter.format(strMDL_MAC)%>">
                                                </td>
                                                <td nowrap align="right" width="100%"><strong><%=ApplicationConfigurator.LanguageManager.getString("Identificativo")%>&nbsp;</strong> &nbsp;</td>
                                                <td  align="right" >
                                                    <input tabindex="4" type="text" size="10" maxlength="10"  name="IDE_MAC" value="<%= Formatter.format(strIDE_MAC)%>">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" nowrap><strong><%=ApplicationConfigurator.LanguageManager.getString("Fabbrica")%>&nbsp;</strong></td>
                                    <td>
                                        <input tabindex="5" type="text" size="50" maxlength="100"  name="FBR_MAC" value="<%= Formatter.format(strFBR_MAC)%>">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Targa")%>&nbsp;</td>
                                    <td>
                                        <table width="100%" cellpadding="0" cellspacing="0" border=0>
                                            <tr>
                                                <td>
                                                    <input tabindex="6" type="text" size="50" maxlength="50"  name="TAR_MAC" value="<%= Formatter.format(strTAR_MAC)%>">
                                                </td>
                                                <td nowrap align="right" width="100%"><%=ApplicationConfigurator.LanguageManager.getString("Proprietario")%>&nbsp;</td>
                                                <td  align="right">
                                                    <input tabindex="7" type="text" size="50" maxlength="50"  name="PPO_MAC" value="<%= Formatter.format(strPPO_MAC)%>">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Marcatura")%>&nbsp;</td>
                                    <td>
                                        <table width="100%" cellpadding="0" cellspacing="0" border=0>
                                            <tr>
                                                <td>
                                                    <input tabindex="8" type="text" size="15" maxlength="1"  name="MRC_MAC" value="<%= Formatter.format(strMRC_MAC)%>">
                                                </td>
                                                <td nowrap align="right"><%=ApplicationConfigurator.LanguageManager.getString("Anno")%>&nbsp;</td>
                                                <td  align="left">
                                                    <input tabindex="9" type="text" size="8" maxlength="8"  name="YEA_CST_MAC" value="<%= strYEA_CST_MAC%>">
                                                </td>
                                                <td nowrap align="right"><%=ApplicationConfigurator.LanguageManager.getString("Catalogazione")%>&nbsp;</td>
                                                <td  align="left">
                                                    <input tabindex="10" type="text" size="8" maxlength="4"  name="CAT_MAC" value="<%= Formatter.format(strCAT_MAC)%>">
                                                </td>
                                                <td nowrap align="right"><%=ApplicationConfigurator.LanguageManager.getString("Portata")%>&nbsp;</td>
                                                <td  align="left">
                                                    <input tabindex="11" type="text" size="8" maxlength="8"  name="PRT_MAC" value="<%=strPRT_MAC%>">
                                                </td>
                                                <td nowrap align="right"><%=ApplicationConfigurator.LanguageManager.getString("Pressione")%>&nbsp;</td>
                                                <td  align="right">
                                                    <input tabindex="12" type="text" size="8" maxlength="4"  name="PRE_MAC" value="<%= Formatter.format(strPRE_MAC)%>">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
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
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" id="ifrmWork" ></iframe>
<%
//-------Loading of Tabs--------------------
            String s = "";
            if (bean != null) //if (false)
            {
// -----------------------------------------
%>

<script language="JavaScript">

    ATT_LAV_MAC = <%=ApplicationConfigurator.isModuleEnabled(MODULES.ATT_LAV_MAC)%>

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
    //tabbar.addTab(new Tab("tab2", "Luogo fisico", tabbar));
    tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Manutenzione/Sostituzione")%>", tabbar));
    tabbar.addTab(new Tab("tab4", "<%=ApplicationConfigurator.LanguageManager.getString("Normative/Sentenze")%>", tabbar));
    tabbar.addTab(new Tab("tab5", "<%=ApplicationConfigurator.LanguageManager.getString("Documentazione")%>", tabbar));
    tabbar.addTab(new Tab("tab6", "<%=ApplicationConfigurator.LanguageManager.getString("Fornitori")%>", tabbar));
    if (ATT_LAV_MAC){
        tabbar.addTab(new Tab("tab7", "<%=ApplicationConfigurator.LanguageManager.getString("Utilizzatori")%>", tabbar));
    }
    //------adding tables to tabs-----------------------
    tabbar.idParentRecord = <%=lCOD_MAC%>;
    tabbar.refreshTabUrl="ANA_MAC_RefreshTabs.jsp";
    tabbar.RefreshAllTabs();
	
    tabbar.tabs[0].center.click();
    //----add action parameters to tabs
   
    tabbar.tabs[0].tabObj.actionParams ={"Feachures":ANA_RSO_Feachures,
        "AddNew":	{"url":"../Form_ANA_RSO/ANA_RSO_Form.jsp?ATTACH_URL=Form_ANA_MAC/ANA_MAC_Attach.jsp&ATTACH_SUBJECT=RISCHIO",
            "buttonIndex":0
        },
        "Edit":	{"url":"../Form_ANA_RSO/ANA_RSO_Form.jsp?ATTACH_URL=Form_ANA_MAC/ANA_MAC_Attach.jsp&ATTACH_SUBJECT=RISCHIO",
            "buttonIndex":1
        },
        "Delete":	{"url":"../Form_ANA_MAC/ANA_MAC_Delete.jsp?LOCAL_MODE=risc<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
            "target_element":document.all["ifrmWork"],
            "buttonIndex":2,
            "ExtendedMode": <%=bExtended%>
        }
										 			
    };
    //--------------------------------------------------------------
    tabbar.tabs[1].tabObj.actionParams ={"Feachures":ANA_ATI_MNT_MAC_Feachures,
        "AddNew":	{"url":"../Form_ANA_ATI_MNT_MAC/ANA_ATI_MNT_MAC_Form.jsp?ATTACH_URL=Form_ANA_MAC/ANA_MAC_Attach.jsp&ATTACH_SUBJECT=ATT_MNT",
            "buttonIndex":0
        },
        "Edit":	{"url":"../Form_ANA_ATI_MNT_MAC/ANA_ATI_MNT_MAC_Form.jsp?ATTACH_URL=Form_ANA_MAC/ANA_MAC_Attach.jsp&ATTACH_SUBJECT=ATT_MNT",
            "buttonIndex":1
        },
        "Delete":	{"url":"../Form_ANA_MAC/ANA_MAC_Delete.jsp?LOCAL_MODE=mnt",
            "buttonIndex":2,
            "target_element":document.all["ifrmWork"]
        }
    };
    tabbar.tabs[2].tabObj.actionParams ={"Feachures":ANA_NOR_SEN_Feachures,
        "AddNew":	{"url":"../Form_ANA_NOR_SEN/ANA_NOR_SEN_Form.jsp?ATTACH_URL=Form_ANA_MAC/ANA_MAC_Attach.jsp&ATTACH_SUBJECT=NOR_SEN",
            "buttonIndex":0
        },
        "Edit":	{"url":"../Form_ANA_NOR_SEN/ANA_NOR_SEN_Form.jsp?ATTACH_URL=Form_ANA_MAC/ANA_MAC_Attach.jsp&ATTACH_SUBJECT=NOR_SEN",
            "buttonIndex":1
        },
        "Delete":	{"url":"../Form_ANA_MAC/ANA_MAC_Delete.jsp?LOCAL_MODE=nor",
            "buttonIndex":2,
            "target_element":document.all["ifrmWork"]
        }
    };
    tabbar.tabs[3].tabObj.actionParams ={"Feachures":ANA_DOC_Feachures,
        "AddNew":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_MAC/ANA_MAC_Attach.jsp&ATTACH_SUBJECT=DOC",
            "buttonIndex":0
        },
        "Edit":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_MAC/ANA_MAC_Attach.jsp&ATTACH_SUBJECT=DOC",
            "buttonIndex":1
        },
        "Delete":	{"url":"../Form_ANA_MAC/ANA_MAC_Delete.jsp?LOCAL_MODE=doc",
            "buttonIndex":2,
            "target_element":document.all["ifrmWork"]
        }
    };
    tabbar.tabs[4].tabObj.actionParams ={"Feachures":ANA_FOR_Feachures,
        "AddNew":	{"url":"../Form_ANA_FOR/ANA_FOR_Form.jsp?ATTACH_URL=Form_ANA_MAC/ANA_MAC_Attach.jsp&ATTACH_SUBJECT=FOR_MAC",
            "buttonIndex":0
        },
        "Edit":	{"url":"../Form_ANA_FOR/ANA_FOR_Form.jsp?ATTACH_URL=Form_ANA_MAC/ANA_MAC_Attach.jsp&ATTACH_SUBJECT=FOR_MAC",
            "buttonIndex":1
        },
        "Delete":	{"url":"../Form_ANA_MAC/ANA_MAC_Delete.jsp?LOCAL_MODE=for",
            "buttonIndex":2,
            "target_element":document.all["ifrmWork"]
        }
    };
    // tab UTILIZZATORI PER MILANO SERRAVALLE
    if (ATT_LAV_MAC){

        tabbar.tabs[5].tabObj.actionParams ={"Feachures":ANA_FOR_Feachures,
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

    }
    //-----activate first tab--------------------------
    <%} else {%>
            <script>
            window.dialogWidth="900px";
        window.dialogHeight="390px";
</script>
<%}%>

</script>

</body>
</html>
<%!//================================================================================//
//------------ combobox for assotiated fields ------------------------------------//
//================================================================================//
    String BuildTpologiaMacchineComboBox(java.util.Collection col, long lCOD_TPL_MAC) {
        String str = "";
        String selected = "";
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            TipologiaMacchinaView view = (TipologiaMacchinaView) it.next();
            if (lCOD_TPL_MAC == view.lCOD_TPL_MAC) {
                selected = "selected";
            } else {
                selected = "";
            }
            str += "<option value='" + view.lCOD_TPL_MAC + "' " + selected + " >" + view.strDES_TPL_MAC + "</option>";
        }
        return str;
    }
%>
