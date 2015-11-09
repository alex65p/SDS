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
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.UnitaSicurezza.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuOrganizzazione,4) + "</title>");
        </script>
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script type="text/javascript" src="../_scripts/tabs.js"></script>
        <script type="text/javascript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <script type="text/javascript" src="../_scripts/cooltree.js"></script>
        <script type="text/javascript">
            window.dialogWidth="900px";
            window.dialogHeight="455px";
            var uni_sic_4_dip = <%=ApplicationConfigurator.isModuleEnabled(MODULES.UNI_SIC_4_DIP)%>
        </script>
        <LINK REL=STYLESHEET TYPE="text/css" HREF="../_styles/style.css" >
        <link rel="stylesheet" href="../_styles/cooltree.css">
    </head>
    <body>
        <%
            boolean EdFlag = false;		//flag of editing
        //   *require Fields*
            long lCOD_UNI_SIC = 0;
            String strCOD_UNI_SIC = "";
            String strNOM_UNI_SIC = "";
            long lCOD_AZL = Security.getAzienda();
        //   *Not require Fields*
            String strDES_UNI_SIC = "";
            long lCOD_UNI_SIC_ASC = 0;

            IUnitaSicurezza UnitaSicurezza = null;
            IUnitaSicurezzaHome home = (IUnitaSicurezzaHome) PseudoContext.lookup("UnitaSicurezzaBean");

            if (request.getParameter("ID") != null) {
                strCOD_UNI_SIC = request.getParameter("ID");
                EdFlag = true;
                // editing of UnitaSicurezza
                //getting of UnitaSicurezza object
                ;
                Long uni_sic_id = new Long(strCOD_UNI_SIC);
                UnitaSicurezza = home.findByPrimaryKey(uni_sic_id);
                lCOD_UNI_SIC = uni_sic_id.longValue();
                lCOD_AZL = UnitaSicurezza.getCOD_AZL();
                strNOM_UNI_SIC = Formatter.format(UnitaSicurezza.getNOM_UNI_SIC());
                //---
                strDES_UNI_SIC = Formatter.format(UnitaSicurezza.getDES_UNI_SIC());
                lCOD_UNI_SIC_ASC = UnitaSicurezza.getCOD_UNI_SIC_ASC();
            }
            IAzienda azienda;
            IAziendaHome AziendaHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");
            azienda = AziendaHome.findByPrimaryKey(new Long(lCOD_AZL));
            String strNOM_AZL = azienda.getRAG_SCL_AZL();
        %>
        <table cellpadding="0" cellspacing="0" width="100%" >
            <tr>
                <td>
                    <form action="ANA_UNI_SIC_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;" >
                        <table border="0">
                            <tr>
                                <td class="title" colspan="100%">
                                    <script type="text/javascript">
                                        document.write(getCompleteMenuPath(SubMenuOrganizzazione,4));
                                    </script>
                                </td>
                            </tr>
                            <tr valign=top>
                                <td  valign="top" style="width:40%; height:100%; border:0px solid red">
                                    <table border="0" cellpadding="1"  bordercolor="#ff0000" cellspacing="1" style="height:100%; width:100%" > 		
                                        <tr>
                                            <td>
                                                <table>
                                                    <tr>	
                                                        <td>
                                                            <!-- ############################ -->  		
                                                            <%@ include file="../_include/ToolBar.jsp" %>      
                                                            <%
                                                                ToolBar.bCanDelete = (UnitaSicurezza != null);
                                                                ToolBar.bCanPrint = false;
                                                                ToolBar.bAlwaysShowPrint = true;
                                                                ToolBar.bShowSearch = false;
                                                            %>		
                                                            <%=ToolBar.build(3)%> 
                                                            <!-- ########################### -->
                                                        </td>
                                                    </tr>
                                                </table>
                                                <Fieldset>
                                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.azienda/ente")%></legend>
                                                    <table width="100%">
                                                        <tr>
                                                            <td>
                                                                <b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b>
                                                            </td>
                                                            <td style="width:80%">
                                                                <input type="text" readonly name="NOM_AZL" style="width:100%" value="<%=strNOM_AZL%>">
                                                            </td>
                                                        </tr>
                                                    </table>											 
                                                </Fieldset>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height:100%">
                                                <div class="treeViewDiv" id="dTreeVew">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <fieldset>
                                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Ricerca")%></legend>
                                                    <table>
                                                        <tr>
                                                            <td  width="98%" id="">
                                                                <input type="text" style="width:100%" id="searchText"  value="" name="ricerca">
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
                                <td style="width:60%">
                                    <table border="0" cellpadding="1"  bordercolor="#ff0000" cellspacing="1">
                                        <tr>
                                            <td id="UNI_SIC">
                                                <fieldset>
                                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.unità.sicurezza")%></legend>
                                                    <table border="0" width="100%">
                                                        <tr>
                                                            <td nowrap align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome.unità.sic.")%>&nbsp;</b></td>
                                                            <td width="80%">
                                                                <input tabindex="1" name="SBM_MODE" type="Hidden" value="<%=(lCOD_UNI_SIC == 0) ? "new" : "edt"%>">
                                                                <input tabindex="1" name="COD_UNI_SIC" type="Hidden" value="<%=lCOD_UNI_SIC%>">
                                                                <input tabindex="1" name="COD_AZL" type="Hidden" value="<%=lCOD_AZL%>">
                                                                <input tabindex="1" type="text" style="width:100%" maxlength="50" readonly name="NOM_UNI_SIC"  value="<%=strNOM_UNI_SIC%>">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign=top align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                                            <td>
                                                                <textarea tabindex="2" style="width:100%" readonly name="DES_UNI_SIC"><%=strDES_UNI_SIC%></textarea>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table width="100%">
                                                        <tr>
                                                            <td>
                                                                <fieldset>
                                                                    <legend>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Unita.sicurezza.associata")%>&nbsp;</legend>
                                                                    <table width="100%" border="0">
                                                                        <tr>
                                                                            <td width="94" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</td>
                                                                            <td>
                                                                                <select disabled tabindex="3" name="COD_UNI_SIC_ASC" style="width:100%">
                                                                                    <option value="0"></option>
                                                                                    <%
                                                                                        String nodes = buildTreeNodes(UnitaSicurezza, home, 0, lCOD_UNI_SIC_ASC);
                                                                                        out.println(nodes);
                                                                                    %>
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
                                            <td>
                                                <div id="dContainer" class="mainTabContainer" style="width:100%; margin-bottom:2px"></div>
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
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
        <iframe name="ifrmTree" class="ifrmWork" src="../empty.txt" id="ifrmTree" style=" width:800px; height:150px"></iframe>
        <script type="text/javascript">
            //-------- TreeView --------------------------
            var dTreeVew, tree, UNI_SIC, ifrmWork, RESP, btnDel, btnNew, btnSave;
            dTreeVew=document.all["dTreeVew"];
            UNI_SIC = document.all["UNI_SIC"];
            ifrmWork = document.all["ifrmWork"];

            function getNodes(){
                dTreeVew.innerHTML="&nbsp;&nbsp;Carica l'albero..."
                document.all['ifrmTree'].src = "ANA_UNI_SIC_Tree.jsp";
	
                btnNew = ToolBar.New.getButton();
                if (btnNew){
                    btnNew.onclick = OnNewNode;
                }
                btnDel = ToolBar.Delete.getButton();
                if (btnDel){
                    btnDel.onclick=OnDelNode;	
                }	
                btnSave = ToolBar.Save.getButton();
	
                return;
            }

            function OnNewNode(){
                if (tree.selectedID){
                    url = "ANA_UNI_SIC_Node.jsp?ID_ASC="+tree.selectedID;
                    ifrmWork.src=url;
                    if (btnDel) btnDel.disabled=false;
                }
                else{
                    url = "ANA_UNI_SIC_Node.jsp?ID_ASC=0";
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

            function buildTree(TREE_NODES){
                tree = new COOLjsTree ("tree1", TREE_NODES, TREE1_FORMAT, dTreeVew);
                btnPrnt.disabled=false;
            }
            function getNode(ID){
                if (ID!=0){
                    ifrmWork.src="ANA_UNI_SIC_Node.jsp?ID="+ID;
                }	
                else{
                    ifrmWork.src="ANA_UNI_SIC_Node.jsp";
                }
                tree.selectedID = ID;	
                if (btnDel) btnDel.disabled=false;
                if (btnSave) btnSave.disabled=false;
            }
            function setUNI_SIC(obj){
                UNI_SIC.innerHTML=obj.innerHTML;
            }

            function OnPrint(){
                if (tree.selectedID)
                    ToolBar.openReport("OrganigrammaSicurezza.jsp?ID="+tree.selectedID);//REP_UNI_ORG
                else
                    alert(arraylng["MSG_0062"]);	
            }

            function init(){
                btnPrnt = ToolBar.Print.getButton();

                btnPrnt.onclick = OnPrint;
            }
            //------------ SEARCH ----------------------
            function GoRicerca(){
                str = document.all["searchText"].value;
                tree.search(str);
            }


            if(window.name!="ifrmWork")
            {
                //--------BUTTONS description-----------------------
                btnParams = new Array();
                btnParams[0] = {"id":"btnNew", 
                    "onclick":addRow,
                    "action":"AddNew"
                };
                btnParams[2] = {"id":"btnCancel", 
                    "onclick":delRow,
                    "action":"Delete"
                };
                btnParams[1] = {"id":"btnEdit", 
                    "onclick":editRow,
                    "action":"Edit"
                };				
                //--------creating tabs--------------------------
                var tabbar = new TabBar("tbr1",document.all["dContainer"]);
                var btnBar = new ButtonPanel("batPanel1", btnParams);
                tabbar.addButtonBar(btnBar);

                if (uni_sic_4_dip == true)
                    tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Lavoratori")%>", tabbar));
                else
                    tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Unità.organizzative")%>", tabbar));
        
                //------adding tables to tabs-----------------------
                tabbar.idParentRecord= <%= lCOD_UNI_SIC%>;
                tabbar.refreshTabUrl="ANA_UNI_SIC_Tabs.jsp"
                tabbar.DEBUG_TABS_IFRM=false;
                //	tabbar.RefreshAllTabs();
                //----add action parameters to tabs

                if (uni_sic_4_dip == true){
                    tabbar.tabs[0].tabObj.actionParams ={
                        "Feachures":{"dialogWidth":"750px",
                            "dialogHeight":"550px"
                        },
                        "AddNew":   {
                            "url":"../Form_DPD_UNI_SIC/DPD_UNI_SIC_Form.jsp?ATTACH_URL=Form_ANA_UNI_SIC/ANA_UNI_SIC_Attach.jsp&ATTACH_SUBJECT=ORGANIZATIVA",
                            "buttonIndex":0,
                            "disabled": false
                        },
                        "Edit":		{
                            "url":"../Form_DPD_UNI_SIC/DPD_UNI_SIC_Form.jsp?ATTACH_URL=Form_ANA_UNI_SIC/ANA_UNI_SIC_Attach.jsp&ATTACH_SUBJECT=ORGANIZATIVA",
                            "buttonIndex":1,
                            "disabled": false
                        },
                        "Delete":	{"url":"../Form_DPD_UNI_SIC/DPD_UNI_SIC_Delete.jsp",
                            "buttonIndex":2,
                            "target_element":document.all["ifrmWork"],
                            "disabled": false
                        }
                    };
                } else {
                    tabbar.tabs[0].tabObj.actionParams ={
                        "Feachures":{"dialogWidth":"750px",
                            "dialogHeight":"550px"
                        },
                        "AddNew":   {
                            "url":"../Form_DPD_UNI_SIC/DPD_UNI_SIC_Form.jsp?ATTACH_URL=Form_ANA_UNI_SIC/ANA_UNI_SIC_Attach.jsp&ATTACH_SUBJECT=ORGANIZATIVA",
                            "buttonIndex":0,
                            "disabled": false
                        },
                        "Edit":		{
                            "url":"../Form_DPD_UNI_SIC/DPD_UNI_SIC_Form.jsp?ATTACH_URL=Form_ANA_UNI_SIC/ANA_UNI_SIC_Attach.jsp&ATTACH_SUBJECT=ORGANIZATIVA",
                            "buttonIndex":1,
                            "disabled": false
                        },
                        "Delete":	{"url":"../Form_DPD_UNI_SIC/DPD_UNI_SIC_Delete.jsp",
                            "buttonIndex":2,
                            "target_element":document.all["ifrmWork"],
                            "disabled": false
                        }
                    };
                }
                //-----activate first tab--------------------------
            }
        </script>

    </body>
</html>
<%!    boolean isError = false;
    String strError = "";

    String buildTreeNodes(IUnitaSicurezza bean, IUnitaSicurezzaHome home, long n, long COD_UNI_SIC) {
        Collection c;
        Iterator i;
        String selected;
        long az = Security.getAzienda();
        String strNodes = "";
        try {
            if (n == 0) {
                c = home.getTopOfTree(az);
                i = c.iterator();
                n++;
                if (i != null) {
                    if (i.hasNext()) {

                        UnitaSicurezzaView view = (UnitaSicurezzaView) i.next();

                        String strNOM_UNI_SIC = view.strNOM_UNI_SIC;
                        long lCOD_UNI_SIC = view.lCOD_UNI_SIC;
                        if (COD_UNI_SIC == lCOD_UNI_SIC) {
                            selected = "selected";
                        } else {
                            selected = "";
                        }
                        strNodes += "<option value=\"" + lCOD_UNI_SIC + "\" " + selected + ">" + strNOM_UNI_SIC + "</option>";
                        bean = home.findByPrimaryKey(new Long(lCOD_UNI_SIC));
                        strNodes += buildTreeNodes(bean, home, n, COD_UNI_SIC);
                        if (isError) {
                            return "";
                        }
                    }
                }
            } else {
                c = bean.getChildren(az);
                i = c.iterator();
                n++;
                if (i != null) {
                    while (i.hasNext()) {
                        UnitaSicurezzaView view = (UnitaSicurezzaView) i.next();
                        String strNOM_UNI_SIC = view.strNOM_UNI_SIC;
                        long lCOD_UNI_SIC = view.lCOD_UNI_SIC;
                        if (COD_UNI_SIC == lCOD_UNI_SIC) {
                            selected = "selected";
                        } else {
                            selected = "";
                        }
                        strNodes += "<option value=\"" + lCOD_UNI_SIC + "\" " + selected + ">";
                        for (long y = 0; y < n; y++) {
                            strNodes += "&nbsp;&nbsp;&nbsp;";
                        }
                        strNodes += strNOM_UNI_SIC + "</option>";
                        bean = home.findByPrimaryKey(new Long(view.lCOD_UNI_SIC));
                        strNodes += buildTreeNodes(bean, home, n, COD_UNI_SIC);
                        if (isError) {
                            return "";
                        }
                    }
                }
            }
        } catch (Exception ex) {
            strError += ex.getMessage();
            return "";
        }
        return strNodes;
    }%>
