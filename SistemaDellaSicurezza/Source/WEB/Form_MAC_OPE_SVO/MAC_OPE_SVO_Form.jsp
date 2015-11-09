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
<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>
<%@ page import="com.apconsulting.luna.ejb.TipologieMacchine.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="MAC_OPE_SVO_Util.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
    <head>
        <title><%=ApplicationConfigurator.LanguageManager.getString(
                ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                ? "Associativa.macchine.attrezzature.impianti"
                : "Associativa.macchine/attrezzature")%></title>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
    </head>
    <link rel="stylesheet" href="../_styles/style.css">
    <link rel="stylesheet" href="../_styles/tabs.css">
    <script language="JavaScript" src="../_scripts/tabs.js"></script>
    <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
    <script>
        window.dialogWidth="690px";
        window.dialogHeight="510px";
    </script>
    <body>
        <%
            //   *require Fields*
            String strCOD_MAC = "";     //int8
            String strIDE_MAC = "";     //varchar10
            String strDES_MAC = "";     //varchar200
            String strMDL_MAC = "";     //varchar100
            String strDIT_CST_MAC = ""; //varchar200
            String strFBR_MAC = "";     //varchar100
            String strCOD_TPL_MAC = ""; //int8
            String strCOD_AZL = "";     //int8
            //   *not require Fields*
            String strYEA_CST_MAC = ""; //int8
            String strTAR_MAC = "";     //varchar50
            String strPPO_MAC = "";     //varchar50
            String strMRC_MAC = "";     //char1
            String strPRT_MAC = "";     //int8
            String strCAT_MAC = "";     //varchar4
            String strPRE_MAC = "";     //varchar4
            String strCOD_MAN = "";
            IMacchina macopesvo = null;
            IMacchinaHome home = (IMacchinaHome) PseudoContext.lookup("MacchinaBean");

            String NomeParent = request.getParameter("ATTACH_SUBJECT");
            String strID_PARENT = request.getParameter("ID_PARENT");

            if (request.getParameter("COD_MAN") != null) {
                strCOD_MAN = request.getParameter("COD_MAN");
            }
            if (request.getParameter("ID") != null) {
                strCOD_MAC = request.getParameter("ID");
                Long COD_MAC = new Long(strCOD_MAC);
                macopesvo = home.findByPrimaryKey(new MacchinaPK(Security.getAzienda(), COD_MAC.longValue()));
                // getting of object variables
                strIDE_MAC = Formatter.format(macopesvo.getIDE_MAC());
                strDES_MAC = Formatter.format(macopesvo.getDES_MAC());
                strMDL_MAC = Formatter.format(macopesvo.getMDL_MAC());
                strDIT_CST_MAC = Formatter.format(macopesvo.getDIT_CST_MAC());
                strFBR_MAC = Formatter.format(macopesvo.getFBR_MAC());
                strCOD_TPL_MAC = Formatter.format(macopesvo.getCOD_TPL_MAC());
                if ("".equals(strCOD_TPL_MAC)) {
                    strCOD_TPL_MAC = "0";
                }
            }
        %>
        <form action="MAC_OPE_SVO_Return.jsp" id="formWork"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <table cellpadding="0" cellspacing="2" border="0">
                <tr>
                    <td valign="top">
                        <table  align="left" cellpadding="0" cellspacing="0">
                            <tr><td class="title"><%=ApplicationConfigurator.LanguageManager.getString(
                                    ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                    ? "Associativa.macchine.attrezzature.impianti"
                                    : "Associativa.macchine/attrezzature")%></td>
                            <input name="SBM_MODE" type="hidden" value="<%if (strCOD_MAC == "") {
                                    out.print("new");
                                } else {
                                    out.print("edt");
                                }%>">
                            <input name="COD_MAC" type="hidden" value="<%=strCOD_MAC%>">
                            <input name="ID_PARENT" type="hidden" value="<%=strID_PARENT%>">
                            <input name="NomeParent" type="hidden" value="<%=NomeParent%>">
                            <input name="DIT_CST_MAC" type="hidden" value="<%=strDIT_CST_MAC%>">
                            <input name="COD_MAN" type="hidden" value="<%=strCOD_MAN%>">
                            </tr>
                            <tr><td>
                                    <table border=0>
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%ToolBar.strSearchUrl = ToolBar.strSearchUrl.replace('&', '|');%>
                                        <%ToolBar.bShowSave = false;%>
                                        <%ToolBar.bShowDelete = false;%>
                                        <%ToolBar.bShowPrint = false;%>
                                        <%=ToolBar.build(3)%>
                                    </table>
                                </td></tr>
                            <tr><td width="700px" align="center">
                                    <fieldset><legend><%=ApplicationConfigurator.LanguageManager.getString(
                                        ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                            ?"Dati.macchina.attrezzatura.impianto"
                                            :"Dati.macchina/attrezzatura"
                                        )%></legend>
                                        <br>
                                        <table border="0" cellpadding="0" cellspacing="0">
                                            <tr align="center"><td align="center" colspan="2" >
                                                    <fieldset><legend><%=ApplicationConfigurator.LanguageManager.getString(
                                                            ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                                                ?"Tipologia.macchina.attrezzatura.impianto"
                                                                :"Tipologia.macchina/attrezzatura"
                                                            )%></legend>
                                                        <table><tr>
                                                                <td align="center"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione.tipologia")%>&nbsp;</td>
                                                                <td><select name="COD_TPL_MAC" id="COD_TPL_MAC" style="width:320;" onchange="ClearFields()">
                                                                        <option value=''></option>
                                                                        <%
                                                                            ITipologieMacchine tpl = null;
                                                                            ITipologieMacchineHome thome = (ITipologieMacchineHome) PseudoContext.lookup("TipologieMacchineBean");
                                                                            java.util.Collection tplcol = thome.findAll();
                                                                            java.util.Iterator it = tplcol.iterator();
                                                                            int iCount = 0;
                                                                            while (it.hasNext()) {
                                                                                Long i = (Long) it.next();
                                                                                tpl = thome.findByPrimaryKey(i);
                                                                                String selstr = "";
                                                                                if (strCOD_TPL_MAC.equals(Formatter.format(tpl.getCOD_TPL_MAC()))) {
                                                                                    selstr = "selected";
                                                                                }
                                                                                out.print("<option " + selstr + "  value=\"" + Formatter.format(tpl.getCOD_TPL_MAC()) + "\">" + Formatter.format(tpl.getDES_TPL_MAC()) + "</option>");
                                                                            }
                                                                        %>
                                                                    </select></td>
                                                        </table>
                                                    </fieldset><br></td></tr>
                                            </tr>
                                            <tr><td align="right" valign="top"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                                <td colspan="100%"><textarea name="DES_MAC" id="DES_MAC" cols="102" rows="3"><%=strDES_MAC%></textarea></td>
                                            </tr>
                                            <tr><td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Modello")%>&nbsp;</b></td>
                                                <td><input size="102" type="text" maxlength="100" name="MDL_MAC" id="MDL_MAC" value="<%=strMDL_MAC%>"></td>
                                            </tr>
                                            <tr><td align="right">&nbsp;<b><%=ApplicationConfigurator.LanguageManager.getString("Identificativo")%>&nbsp;</b></td>
                                                <td><input size="50" type="text" maxlength="10" name="IDE_MAC" id="IDE_MAC" value="<%=strIDE_MAC%>"></td>
                                                <td><br><br></td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td></tr>
                            <tr><td colspan="100%" valign="top">
                                    <div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <%
                //-------Loading of Tabs--------------------
                if (macopesvo != null) {
                    out.print(BuildRischioTab(home, strCOD_MAC));
            %>
            <script language="JavaScript" src="../_scripts/index.js"></script>
            <script language="JavaScript">
                if(window.name!="ifrmWork")
                {
                    function MacchinaParams(){
                        obj = new DialogParameters();
                        obj.nom_rso = "";
                        obj.ent_dan = "";
                        obj.rfc_vlu_rso_mes = "";
                        obj.codMAC = "";
                        obj.toRow = function (row){
                            row.id = this.ID;
                            row.INDEX = this.codMAC;
                            colInput=row.getElementsByTagName("INPUT");
                            colInput[0].value=this.nom_rso;
                            colInput[1].value=this.ent_dan;
                            colInput[2].value=this.rfc_vlu_rso_mes;
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
                    btnParams[2] = {"id":"btnCancel", 
                        "onclick":delRow,
                        "action":"Delete"
                    };
                    btnParams[1] = {"id":"btnEdit", 
                        "onclick":editRow,
                        "action":"Edit"
                    };				
                    //--------creating tabs--------------------------
                    var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
                    var btnBar = new ButtonPanel("batPanel1", btnParams);
                    tabbar.addButtonBar(btnBar);
                    tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString(
                                ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                ? "Rischi.macchine.attrezzature.impianti"
                                : "Rischi.macchine/attrezzature"
                                )%>", tabbar));
                    //------adding tables to tabs-----------------------
                    tabbar.tabs[0].tabObj.addTable( document.all["RischioMacchinaHeader"],document.all["RischioMacchina"], true);
                    //----add action parameters to tabs
                    tabbar.tabs[0].tabObj.actionParams ={"AddNew":	{"url":"../Form_COL_INT/COL_INT_Form.jsp",
                            "buttonIndex":0, 
                            "addDialogParameters":new MacchinaParams(),
                            "alert": null, 
                            "disabled": true
                        },
                        "Delete":	{"url":"../Form_COL_INT/COL_INT_Delete.jsp",
                            "buttonIndex":2, 
                            "target_element":document.all["ifrmWork"],
                            "alert": null, 
                            "disabled": true
                        },
                        "Edit":	{"url":"../Form_COL_INT/COL_INT_Form.jsp",
                            "buttonIndex":1, 
                            "editDialogParameters":new MacchinaParams(),
                            "alert": null,
                            "disabled": true
                        },
                        "Feachures":COL_INT_Feachures
                    };
                    //-----activate first tab--------------------------
                    tabbar.tabs[0].center.click();
                }
            </script>
            <%} else {%>
            <script>
                window.dialogHeight="280px";
            </script>
            <%}%>
        </form>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>

        <script>
            btn2=ToolBar.Search.getButton();
            btn2.onclick = goTab2;
            //---
            function goTab2(){
                var searchurl=tb_url_Search        ;
                tb_url_Search += "|COD_TPL_MAC="+document.all['COD_TPL_MAC'].value+"|DES_MAC="+document.all['DES_MAC'].value+"|MDL_MAC="+document.all['MDL_MAC'].value+"|IDE_MAC="+document.all['IDE_MAC'].value+"|NomeParent=<%=NomeParent%>";
                ToolBar.Search.OnClick();
                tb_url_Search = searchurl;
            }
            btn1 = ToolBar.Return.getButton();
            btn1.onclick = goTab;
            //---
            function goTab(){
                document.all['formWork'].submit();
            }
            //---
            function ClearFields(){
                document.all["DES_MAC"].value="";
                document.all["MDL_MAC"].value="";
                document.all["IDE_MAC"].value="";
            }
        </script>
    </body>
</html>
