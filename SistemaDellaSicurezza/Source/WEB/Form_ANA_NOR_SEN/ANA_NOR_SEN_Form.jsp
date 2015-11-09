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
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<%@ page import="com.apconsulting.luna.ejb.NormativeSentenze.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/Organi/OrganiBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/Organi/OrganiBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/Settori/SettoriBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/Settori/SettoriBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/Sottosettori/SottosettoriBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/Sottosettori/SottosettoriBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/TipologieNomativeSentenze/TipologieNomativeSentenzeBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TipologieNomativeSentenze/TipologieNomativeSentenzeBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="ANA_NOR_SEN_Util.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
    <script>
        document.write("<title>" + getCompleteMenuPath(SubMenuNormative,4) + "</title>");
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
    <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
    <link rel="stylesheet" href="../_styles/tabs.css">
    <script language="JavaScript" src="../_scripts/tabs.js"></script>
    <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
    <script src="../_scripts/Alert.js"></script>
</head>
<body>
<script>
    window.dialogWidth="725px";
    window.dialogHeight="570px";
    </script>

<%
            long lCOD_NOR_SEN = 0;				 //UID NormativeSentenze
            String strTIT_NOR_SEN = "";			 //UNIC Nome NormativeSentenze
            String strDES_NOR_SEN = "";			 //3
            String dtDAT_NOR_SEN = "";			 //4
            long lCOD_ORN = 0;			 			 //5
            String strCOD_ORN = "";			 		 //5a
            long lCOD_SET = 0;			 			 //6
            String strCOD_SET = "";			 		 //6a
            long lCOD_TPL_NOR_SEN = 0;		 //7
            String strCOD_TPL_NOR_SEN = "";	 //7a
            long lCOD_SOT_SET = 0;			 	 //8
            String strCOD_SOT_SET = "";			 //8a
//-----------------------------
            String strNUM_DOC_NOR_SEN = "";		// 9
            String strFON_NOR_SEN = "";				// 10

//--- mary for tab
            String strID_PARENT = ""; // TPL_DPI_TAB.COM_TPL_DPI
            strID_PARENT = request.getParameter("ID_PARENT"); // TPL_DPI_TAB.COM_TPL_DPI
%>

<%
            INormativeSentenze norma = null;

            IOrgani organi = null;
            IOrganiHome OrganiHome = (IOrganiHome) PseudoContext.lookup("OrganiBean");

            ISettori settori = null;
            ISettoriHome SettoriHome = (ISettoriHome) PseudoContext.lookup("SettoriBean");

            ISottosettori sottosettori = null;
            ISottosettoriHome SottosettoriHome = (ISottosettoriHome) PseudoContext.lookup("SottosettoriBean");

            ITipologieNomativeSentenze sentenze = null;
            ITipologieNomativeSentenzeHome TipologieNomativeSentenzeHome = (ITipologieNomativeSentenzeHome) PseudoContext.lookup("TipologieNomativeSentenzeBean");

            if (request.getParameter("ID") != null) {
                String strCOD_NOR_SEN = request.getParameter("ID");
// editing of norma

                INormativeSentenzeHome home = (INormativeSentenzeHome) PseudoContext.lookup("NormativeSentenzeBean");

                try {
                    norma = home.findByPrimaryKey(new Long(strCOD_NOR_SEN));
                } catch (Exception ex) {
                    out.print("<script>Alert.Error.showNotFound(); window.self.close();</script>");
                    return;
                }

                lCOD_NOR_SEN = norma.getCOD_NOR_SEN();
                strTIT_NOR_SEN = norma.getTIT_NOR_SEN();
                strDES_NOR_SEN = norma.getDES_NOR_SEN();
                dtDAT_NOR_SEN = Formatter.format(norma.getDAT_NOR_SEN());

                lCOD_ORN = norma.getCOD_ORN();
                lCOD_SET = norma.getCOD_SET();
                lCOD_TPL_NOR_SEN = norma.getCOD_TPL_NOR_SEN();
                lCOD_SOT_SET = norma.getCOD_SOT_SET();

//-----------------------------
                strNUM_DOC_NOR_SEN = norma.getNUM_DOC_NOR_SEN();
                strFON_NOR_SEN = norma.getFON_NOR_SEN();

            }// if request
%>

<!-- form for adding  NormativeSentenze-->
<form action="ANA_NOR_SEN_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
    <input name="SBM_MODE" type="Hidden" value="<%=(lCOD_NOR_SEN == 0) ? "new" : "edt"%>">
    <input type="hidden" name="COD_NOR_SEN" value="<%=lCOD_NOR_SEN%>">
    <!-- mary for tab -->
    <input name="ID_PARENT" type="Hidden" value="<%=strID_PARENT%>">
    
    <table width="100%" border="0">
        <tr>
            <td valign="top">
            <table  width="100%">
                <tr><td class="title">
                        <script>
                            document.write(getCompleteMenuPathFunction
                                (SubMenuNormative,4,<%=request.getParameter("ID")%>));
                        </script>      
                </td></tr>
                <tr>
                    <td>
                        <!-- ############################ -->
                        <table border=0>
                            <%@ include file="../_include/ToolBar.jsp" %>
                            <%ToolBar.bCanDelete = (norma != null);
                            %>
                            <%=ToolBar.build(2)%>
                        </table>
                        <!-- ########################### -->
                        <fieldset>
                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.normativa/sentenza")%></legend>
                        <table  width="100%" border="0">
                        <tr>
                            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>&nbsp;</b></td>
                            <td colspan="5">
                                <input tabindex="1" size="118" type="text" maxlength="200" name="TIT_NOR_SEN" value="<%=strTIT_NOR_SEN%>">
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Fonte")%>&nbsp;</td>
                            <td><input tabindex="2" size="44" type="text" maxlength="50" name="FON_NOR_SEN" value="<%=strFON_NOR_SEN%>"></td>
                            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Data")%>&nbsp;</b></td>
                            <td><s2s:Date tabindex="3" id="DAT_NOR_SEN" name="DAT_NOR_SEN" value="<%=dtDAT_NOR_SEN%>"/></td>
                            <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</td>
                            <td><input tabindex="4" size="12" type="text" maxlength="10" name="NUM_DOC_NOR_SEN" value="<%=strNUM_DOC_NOR_SEN%>"></td>
                        </tr>
                        <tr>
                            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%>&nbsp;</b></td>
                            <td>
                                <select tabindex="5" name="COD_TPL_NOR_SEN" style="width: 250px;">
                                    <option value=""></option>
                                    <%=BuildTipologieNomativeSentenzeComboBox(TipologieNomativeSentenzeHome, lCOD_TPL_NOR_SEN)%>
                                </select>
                            </td>
                            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Organo")%>&nbsp;</b></td>
                            <td colspan="3">
                                <select tabindex="6" name="COD_ORN" style="width: 250px;">
                                    <option value=""></option>
                                    <%=BuildOrganiComboBox(OrganiHome, lCOD_ORN)%>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Settore")%>&nbsp;</b></td>
                            <td>
                                <select tabindex="7" name="COD_SET" style="width: 250px;">
                                    <option value=""></option>
                                    <%=BuildSettoriComboBox(SettoriHome, lCOD_SET)%>
                                </select>
                            </td>
                            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Sottosettore")%>&nbsp;</b></td>
                            <td colspan="3">
                                <select tabindex="8" name="COD_SOT_SET" style="width: 250px;">
                                    <option value=""></option>
                                    <%=BuildSottosettoriComboBox(SottosettoriHome, lCOD_SOT_SET)%>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</b></td>
                            <td colspan="5">
                                <textarea tabindex="9" rows="5" cols="119" style="width:615" name="DES_NOR_SEN"><%=strDES_NOR_SEN%></textarea>
                            </td>
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
            </td>
        </tr>
    </table>
</form>

<!-- /form for addind  NormativeSentenze-->

<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>

<%
//-------Loading of Tabs--------------------
            if (norma != null) {

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
    var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
    var btnBar = new ButtonPanel("batPanel1", btnParams);
    tabbar.addButtonBar(btnBar);
    tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti.associati")%>", tabbar));
    
    //------adding tables to tabs-----------------------
    tabbar.idParentRecord = <%= new Long(lCOD_NOR_SEN) %>;
    tabbar.refreshTabUrl="ANA_NOR_SEN_Tabs.jsp";
    tabbar.RefreshAllTabs();
    //tabbar.tabs[0].tabObj.addTable( document.all["NormativeSentenzeHeader"],document.all["NormativeSentenze"], true);
    //----add action parameters to tabs
    tabbar.tabs[0].tabObj.actionParams ={
        "Feachures":ANA_DOC_Feachures,
        "AddNew":{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_NOR_SEN/ANA_NOR_SEN_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
            "whidth":"750px",
            "height":"700px",
            "buttonIndex":0,
            "disabled": false
        },
        "Edit":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_NOR_SEN/ANA_NOR_SEN_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
            "whidth":"750px",
            "height":"700px",
            "buttonIndex":1,
            "disabled": false
        },
        "Delete":	{"url":"../Form_ANA_NOR_SEN/ANA_NOR_SEN_Delete.jsp?LOCAL_MODE=d",
            "target_element":document.all["ifrmWork"],
            "buttonIndex":2,
            "disabled": false
        }
    };
    //-----activate first tab--------------------------
    tabbar.tabs[0].center.click();
    </script>

<%} else {%>
<script>
    window.dialogWidth="725px";
    window.dialogHeight="350px";
    </script>
<%}%>


<%if (strID_PARENT == null) { // Zamenil != na == Mike Kondratyuk
%>
<script>ToolBar.Return.setEnabled(false);</script>
<%}%>
</body>
</html>
