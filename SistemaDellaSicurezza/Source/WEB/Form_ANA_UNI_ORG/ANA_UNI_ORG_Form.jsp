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
        </comments>
        </version>
        </versions>
        </file>
         */
        response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
        response.setHeader("Pragma", "no-cache"); //HTTP 1.0
        response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>   
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/TipologieUnitaOrganizzativa/TipologieUnitaOrganizzativaBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/TipologieUnitaOrganizzativa/TipologieUnitaOrganizzativaBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuOrganizzazione,1) + "</title>");
        </script>
    </head>
    <link rel="stylesheet" href="../_styles/style.css">
    <link rel="stylesheet" href="../_styles/tabs.css">
    <link rel="stylesheet" href="../_styles/cooltree.css">
    <script language="JavaScript" src="../_scripts/tabs.js"></script>
    <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
    <script language="JavaScript" src="../_scripts/cooltree.js"></script>
    <script type="text/javascript" src="../_scripts/textarea.js"></script>
    <script>
        window.dialogWidth="900px";
        window.dialogHeight="640px";
    </script>
    <body style="margin: 0 0 0 0">
        <%
        //------------------
        String strCOD_MIS_PET_AZL = "";
        long lCOD_AZL = Security.getAzienda();
        //-------------------------------------------------

        String strRAG_SCL_AZL = new String();
        //------------------
        long lCOD_UNI_ORG = 0;
        String strNOM_UNI_ORG = "";
        String strDES_UNI_ORG = "";
        long lCOD_TPL_UNI_ORG = 0;
        long lCOD_UNI_ORG_ASC = 0;
        long lCOD_DPD = 0;
        //---------------------------

        java.util.Collection col;
        java.util.Iterator it;
        //------------------------------------------------------------------
        //----------------Interfaces & Beans--------------------------------
        //------------------------------------------------------------------
        //-----Azienda--------
        IAziendaHome azHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");
        IAzienda azienda = null;
        //----Unita organizzativa----
        IUnitaOrganizzativa bean = null;
        IUnitaOrganizzativaHome home = (IUnitaOrganizzativaHome) PseudoContext.lookup("UnitaOrganizzativaBean");
        //----------get current azienda -----------------
        azienda = azHome.findByPrimaryKey(new Long(lCOD_AZL));
        strRAG_SCL_AZL = azienda.getRAG_SCL_AZL();
        //------ Tipologia Unita -----------------
        ITipologieUnitaOrganizzativaHome tplHome = (ITipologieUnitaOrganizzativaHome) PseudoContext.lookup("TipologieUnitaOrganizzativaBean");
        //---------
        // stub for debuging

        if (request.getParameter("ID") != null) {
            // getting parameters of azienda
            try {
                Long ID = new Long(request.getParameter("ID"));
                bean = home.findByPrimaryKey(ID);
                lCOD_UNI_ORG = bean.getCOD_UNI_ORG();
                strNOM_UNI_ORG = bean.getNOM_UNI_ORG();
                strDES_UNI_ORG = bean.getDES_UNI_ORG();
                lCOD_TPL_UNI_ORG = bean.getCOD_TPL_UNI_ORG();
                lCOD_UNI_ORG_ASC = bean.getCOD_UNI_ORG_ASC();
                lCOD_DPD = bean.getCOD_DPD();
            } catch (Exception ex) {
                out.print("<strong>" + ex.getMessage() + "</strong>");
                return;
            }
        }// if request*/
%>
        <table cellpadding="0" cellspacing="0" width="100%" border="0">
            <tr>
                <td>
                    <form action="ANA_UNI_ORG_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" >
                            <tr><td align="center" colspan="100%" class="title">
                                    <script>
                                        document.write(getCompleteMenuPath(SubMenuOrganizzazione,1));
                                    </script>
                            </td></tr>
                            <tr>
                                <td width="36%" height="100%" bordercolor="">
                                    <table width="100%" border="0" cellpadding="1" cellspacing="1"  bordercolor="#ff0000"  style="height:100%; width:100%" >
                                        <tr><td></td></tr>
                                        <tr>
                                            <td>
                                                <input type="hidden" size="20" maxlength="20"  name="COD_UNI_ORG_" value="<%//=Formatter.format(lCOD_UNI_ORG)%>">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="100%" width="45%" align="center">
                                                <!-- ########################################################################################################## -->
                                                <table width="100%" border="0">
                                                    <%@ include file="../_include/ToolBar.jsp" %>
                                                    <%
        if (request.getParameter("ID") == null) {
            ToolBar.bCanDelete = ToolBar.bCanEdit;
            ToolBar.bCanDelete = false;
            ToolBar.bCanEdit = false;
            ToolBar.bCanPrint = false;
            ToolBar.bCanSearch = false;
            ToolBar.bCanSave = false;
        } else {
            ToolBar.bCanDetail = true;//
        }
        ToolBar.bCanPrint = false;
        ToolBar.bAlwaysShowPrint = true;
        ToolBar.bShowPrint2 = true;
        ToolBar.bCanPrint2 = true;
        ToolBar.bShowSearch = false;
        ToolBar.bShowDetail = true;
        ToolBar.bCanDetail = true; //
%>
                                                    <%=ToolBar.build(4)%>
                                                </table>
                                                <!-- ########################################################################################################## -->
                                                <fieldset style="width:100%">
                                                    <legend><strong><%=ApplicationConfigurator.LanguageManager.getString("Dati.azienda/ente")%></strong></legend>
                                                    <table width="100%" border="0"><tr>
                                                            <td  width="98%" colspan="6" align="center">
                                                                <input type="hidden" name="COD_AZL"  id="COD_AZL" value="<%= Formatter.format(lCOD_AZL)%>">
                                                                <input style="width:100%" type="text" readonly name="RAG_SCL_AZL"  value="<%= Formatter.format(strRAG_SCL_AZL)%>">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </fieldset>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height:100%">
                                                <div class="treeViewDiv" id="dTreeVew" >
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="100%" align="center">
                                                <fieldset style="width:100%">
                                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Ricerca")%></legend>
                                                    <table width="100%" style="margin: 5 0 9 0" border="0">
                                                        <tr>
                                                            <td  width="98%" id="">
                                                                <input type="text" style="width:100%" value="" id="searchText" name="ricerca">
                                                            </td>
                                                            <td width="2%">
                                                                <button class="getlist" onclick="GoRicerca()" id="btnRicerca">
                                                                    <strong>&middot;&middot;&middot;</strong>
                                                                </button>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </fieldset>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="64%" >
                                    <table border="0" height="100%" width="100%">
                                        <tr>
                                            <td height="100%" id="UNI_ORG">
                                                <fieldset>
                                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.unità.organizzativa")%></legend>
                                                    <br>
                                                    <table width="100%" border="0" cellpadding="2">
                                                        <tr>

                                                            <td width="15%" align="right" nowrap> <strong><%=ApplicationConfigurator.LanguageManager.getString("Nome.unità")%>&nbsp;</strong></td>
                                                            <td width="85%">
                                                                <input tabindex="1" name="SBM_MODE" type="Hidden" value="<%if (lCOD_UNI_ORG != 0) {
                                                                         out.print("edt");
                                                                         } else
                                                                             out.print("new");
                                                                           %>">
                                                                <input tabindex="1" type="hidden" size="20" maxlength="20"  name="COD_UNI_ORG" value="0">
                                                                <input tabindex="1" type="text"  size="90" maxlength="80"  name="NOM_UNI_ORG" value="" readonly>
                                                            </td>
                                                        </tr>
                                                        <tr>

                                                            <td width="15%" align="right" nowrap><strong><%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%>&nbsp;</strong></td>
                                                            <td width="85%">
                                                                <select tabindex="2" name="COD_TPL_UNI_ORG" style="width:100%" disabled>
                                                                    <option value=""></option>
                                                                    <%
                                                                      col = tplHome.getTipologiaUnitaView();
                                                                      String tplString = BuildTipologiaUnitaComboBox(col, lCOD_TPL_UNI_ORG);
                                                                      out.println(tplString);
                                                                    %>
                                                                </select>
                                                            </td>
                                                        </tr>
                                                        <tr>

                                                            <td width="15%" align="right" nowrap><%=ApplicationConfigurator.LanguageManager.getString("D.V.R.")%>&nbsp;</td>
                                                            <td width="85%">
                                                                <input type="checkbox" class="checkbox" name="DVR" value="1" tabindex="3" disabled>
                                                            </td>
                                                        </tr>
                                                                                                   <tr>

                                                            <td width="15%" align="right" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                                            <td width="85%" >
                                                                <s2s:textarea readonly="true" tabindex="4"  name="DES_UNI_ORG" rows="4" cols="100" style="height:70px">
                                                                    <%=Formatter.format(strDES_UNI_ORG)%>
                                                                    </s2s:textarea>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="15%" align="right" nowrap>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("E-mail")%>&nbsp;
                                                            </td>
                                                            <td width="85%" >
                                                                <input type="text" name="Email" style="width:50%" tabindex="5" readonly>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="100%" id="RESP">
                                                                <jsp:include page="ANA_UNI_ORG_Responsabile.jsp"></jsp:include>


                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="100%">
                                                                <fieldset style="width:100%">
                                                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Unita.organizzativa.associata")%></legend>
                                                                    <table width="100%" cellpadding="2" cellspacing="2" border="0">
                                                                        <tr>

                                                                            <td width="14%" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</td>
                                                                            <td width="86%">
                                                                                <select tabindex="7" name="COD_UNI_ORG" style="width:100%" disabled>
                                                                                    <option value="0"></option>
                                                                                </select>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </fieldset>
                                                            </td>
                                                        </tr>

                                                    </table>
                                                </fieldset>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="100%">
                                                <div id="dContainer" class="mainTabContainer" style="width:100%;"></div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </form>
                </td>
            </tr>
        </table>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" id="ifrmWork" ></iframe>
        <iframe name="ifrmTree" id="ifrmTree" class="ifrmWork" src="../empty.txt" style="display:inline; width:100%; height:150"></iframe>
        <script language="JavaScript">
            //-------- TreeView --------------------------
            var dTreeVew, tree, UNI_ORG, ifrmWork, RESP, btnDel, btnNew, btnSave;
            var btnPrnt, btnPrnt2;
            dTreeVew=document.all["dTreeVew"];
            UNI_ORG = document.all["UNI_ORG"];
            ifrmWork = document.all["ifrmWork"];
            RESP= document.all["RESP"];

            function getNodes(){
                dTreeVew.innerHTML="&nbsp;&nbsp;Carica l'albero..."
                document.all['ifrmTree'].src = "ANA_UNI_ORG_Tree.jsp";
                btnNew = ToolBar.New.getButton();
                if (btnNew){
                    btnNew.onclick = OnNewNode;
                }
                btnDel = ToolBar.Delete.getButton();
                if (btnDel){
                    btnDel.onclick=OnDelNode;
                }
                btnSave = ToolBar.Save.getButton();

            }

            function OnNewNode(){
                if (tree){
                    if (tree.selectedID){
                        url = "ANA_UNI_ORG_Node.jsp?ID_ASC="+tree.selectedID;
                        ifrmWork.src=url;
                        if (btnDel) btnDel.disabled=false;
                    }
                    else{
                        url = "ANA_UNI_ORG_Node.jsp?ID_ASC=0";
                        ifrmWork.src=url;
                    }
                }
                else{
                    url = "ANA_UNI_ORG_Node.jsp?ID_ASC=0";
                    ifrmWork.src=url;
                }
                tabbar.ResetAllTabsContent();
                if (btnSave) btnSave.disabled=false;
            }
            function OnDelNode(){
                if (tree.selectedID){
                    if (!confirm(arraylng["MSG_0036"])) return;
                    ifrmWork.src=tb_url_Delete+"&ID="+tree.selectedID;
                }
            }

            function buildTree(TREE1_NODES){
                tree = new COOLjsTree ("tree1", TREE1_NODES, TREE1_FORMAT, dTreeVew);
                btnPrnt.disabled=false;
                btnPrnt2.disabled=false;
            }
            function getNode(ID){
                if (ID!=0){
                    ifrmWork.src="ANA_UNI_ORG_Node.jsp?ID="+ID;
                }
                else{
                    ifrmWork.src="ANA_UNI_ORG_Node.jsp";
                }
                tree.selectedID = ID;
                if (btnDel) btnDel.disabled=false;
                if (btnSave) btnSave.disabled=false;
            }
            function setUNI_ORG(obj){
                UNI_ORG.innerHTML=obj.innerHTML;
                RESP = document.all["RESP"];

            }
            function getDipenedentiList(){
                var obj=new Object();
                var url="Form_ANA_DPD/ANA_DPD_View.jsp?noFindEx=1";
                if(showSearch(url, obj, "dialogHeight:30; dialogWidth:50;help:no;resizable:yes;status:yes;scroll:no;")=="OK"){
                    ifrmWork.src="ANA_UNI_ORG_Responsabile.jsp?RESP_ID="+obj.ID;
                }
            }
            //------Init variables & others -----
            function init(){
                btnPrnt2=ToolBar.Print2.getButton();
                btnPrnt = ToolBar.Print.getButton();
                btnPrnt2.disabled=true;
                btnPrnt.disabled=true;
                btnPrnt2.onclick=OnPrint2;
                btnPrnt.onclick = OnPrint;

            }

            //<details>
            function OnDetails(){
                if (tree.selectedID)
                    var str = window.showModalDialog("../Form_GEST_FAT_RSO_UNI_ORG/GEST_FAT_RSO_UNI_ORG_Form.jsp?ID_PARENT="+tree.selectedID, null, "dialogHeight:200px; dialogWidth:45;help:no;resizable:no;status:no;scroll:no;");
                //var str = window.open("../Form_GEST_FAT_RSO_UNI_ORG/GEST_FAT_RSO_UNI_ORG_Form.jsp?ID_PARENT="+tree.selectedID);
                else
                    alert(arraylng["MSG_0059"]);
            }
            ToolBar.Detail.OnClick = OnDetails;

            //</details>

            function OnPrint(){
                if (tree.selectedID)
                    ToolBar.openReport("SchedaReparto.jsp?ID="+tree.selectedID);//REP_UNI_ORG
                else
                    alert(arraylng["MSG_0059"]);
            }

            function OnPrint2(){
                if (tree.selectedID)
                    ToolBar.openReport("OrganigrammaUnitaOrganizzativa.jsp?ID="+tree.selectedID);
                else
                    alert(arraylng["MSG_0059"]);
            }

            //------------ SEARCH ----------------------
            function GoRicerca(){
                str = document.all["searchText"].value;
                tree.search(str);
            }
            //-------Start TABS section--------------------

            //--------BUTTONS description-----------------------
            btnParams = new Array();
            btnParams[0] = {"id":"btnNew",
                "onclick":OnClick,
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
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Luoghi.fisici")%>", tabbar));
            tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Attivita.lavorative")%>", tabbar));
            tabbar.DEBUG_TABS_IFRM =false;
            //tabbar.tabs[0].tabObj.DEBUG_TAB_IFRM = true;

            //------adding tables to tabs ----------------------
            tabbar.refreshTabUrl="ANA_UNI_ORG_RefreshTabs.jsp";
            //----add action parameters to tabs ----------------
            tabbar.tabs[0].tabObj.actionParams ={"Feachures":ANA_LUO_FSC_Feachures,
                "AddNew":	{"url":"../Form_ANA_LUO_FSC/ANA_LUO_FSC_Form.jsp?ATTACH_URL=Form_ANA_UNI_ORG/ANA_UNI_ORG_Attach.jsp&ATTACH_SUBJECT=LUO_FSC_UNI",
                    "buttonIndex":0
                },
                "Edit":	{"url":"../Form_ANA_LUO_FSC/ANA_LUO_FSC_Form.jsp?ATTACH_URL=Form_ANA_UNI_ORG/ANA_UNI_ORG_Attach.jsp&ATTACH_SUBJECT=LUO_FSC_UNI",
                    "buttonIndex":1
                },
                "Delete":	{"url":"../Form_ANA_UNI_ORG/ANA_UNI_ORG_Delete.jsp?LOCAL_MODE=luo",
                    "target_element":document.all["ifrmWork"],
                    "buttonIndex":2
                }

            };
            //--------------------------------------------------------------
            tabbar.tabs[1].tabObj.actionParams ={"Feachures":{"dialogWidth":"800px",
                    "dialogHeight":"130px"
                },
                "AddNew":	{"url":"../Form_ANA_UNI_ORG/MAN_UNI_ORG_Form.jsp?ATTACH_URL=Form_ANA_UNI_ORG/ANA_UNI_ORG_Attach.jsp&ATTACH_SUBJECT=MAN_UNI",
                    "buttonIndex":0
                },
                "Edit":	{"url":"../Form_ANA_UNI_ORG/MAN_UNI_ORG_Form.jsp?ATTACH_URL=Form_ANA_UNI_ORG/ANA_UNI_ORG_Attach.jsp&ATTACH_SUBJECT=MAN_UNI",
                    "buttonIndex":1
                },
                "Delete":	{"url":"../Form_ANA_UNI_ORG/ANA_UNI_ORG_Delete.jsp?LOCAL_MODE=att",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"]
                }
            };

            //-----activate first tab--------------------------
            function OnClick(){
                addRow(this.action);
            }


            //---------End of TABS section----------------------------

        </script>
    </body>
</html>

<%!   

    String BuildTipologiaUnitaComboBox(java.util.Collection col, long lCOD_TPL_UNI_ORG) {
        String str = "";
        String selected = "";
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            TipologiaUnitaView view = (TipologiaUnitaView) it.next();
            if (lCOD_TPL_UNI_ORG == view.lCOD_TPL_UNI_ORG) {
                selected = "selected";
            } else {
                selected = "";
            }
            str += "<option value='" + view.lCOD_TPL_UNI_ORG + "' " + selected + " >" + view.strNOM_TPL_UNI_ORG + "</option>";
        }
        return str;
    }
    %>
