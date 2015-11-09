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
<%@ page import="com.apconsulting.luna.ejb.ProtocoleSanitare.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="ANA_PRO_SAN_Util.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuVerificheSanitarie,3) + "</title>");
        </script>
        <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
    </head>
    <script>
        window.dialogWidth="700px";
        window.dialogHeight="490px";
    </script>
<body>
<%!
    boolean EdFlag=false;        //flag of editing
%>
<%
    long   lCOD_PRO_SAN = 0;     //1
    long   lCOD_PRO_SAN_RPO = 0; //2
    String strCOD_PRO_SAN = "";  //3
    String strNOM_PRO_SAN = "";  //4
    String strNOM_AZL = "";      //5
  	long   lCOD_AZL = Security.getAzienda();;
    String strDES_PRO_SAN = "";                                         //5

    IProtocoleSanitare ProtocoleSanitare = null;
    if(request.getParameter("ID")!=null)
    {
        strCOD_PRO_SAN = "0";
        strCOD_PRO_SAN = request.getParameter("ID");
        //getting of ProtocoleSanitare object
        EdFlag=true;
        IProtocoleSanitareHome home=(IProtocoleSanitareHome)PseudoContext.lookup("ProtocoleSanitareBean");
        //Long pro_san_id=new Long(strCOD_PRO_SAN);
        lCOD_PRO_SAN = new Long(strCOD_PRO_SAN).longValue();
        ProtocoleSanitare = home.findByPrimaryKey(new ProtocoleSanitarePK(lCOD_AZL, lCOD_PRO_SAN));
        //getting of object variables
        strNOM_PRO_SAN=Formatter.format(ProtocoleSanitare.getNOM_PRO_SAN());
        // ---
        strDES_PRO_SAN=Formatter.format(ProtocoleSanitare.getDES_PRO_SAN());
        lCOD_PRO_SAN_RPO=ProtocoleSanitare.getCOD_PRO_SAN_RPO();
    }
    IAzienda azienda;
    IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");

    azienda = AziendaHome.findByPrimaryKey(new Long(lCOD_AZL));
    strNOM_AZL = azienda.getRAG_SCL_AZL();
%>
<form action="ANA_PRO_SAN_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
    <input name="SBM_MODE" type="Hidden" value="<%=(lCOD_PRO_SAN==0)?"new":"edt"%>">
    <input type="hidden" name="PRO_SAN_ID" value="<%=lCOD_PRO_SAN%>">
    <input type="hidden" name="COD_AZL" value="<%=lCOD_AZL%>">
    <table width="100%" border="0">
        <tr>
            <td>
                <table width="100%" border="0">
                    <tr>
                        <td class="title">
                            <script>
                                document.write(getCompleteMenuPathFunction
                                    (SubMenuVerificheSanitarie,3,<%=request.getParameter("ID")%>));
                            </script>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table width="100%" border="0">
                    <%@ include file="../_include/ToolBar.jsp" %>
                    <%
                        ToolBar.bCanDelete=(ProtocoleSanitare!=null);
                        ToolBar.strPrintUrl="ProtocolloSanitario.jsp?";
                    %>
                    <%=ToolBar.build(2)%>
                </table>
                 <%
                    if (Security.isExtendedMode() && (ProtocoleSanitare==null || ProtocoleSanitare.isMultiple()) )
                    {
                    %>
                        <script>isExtendedForm=true;</script>
                    <%
                    }
                    %>
            </td>
        </tr>
        <tr>
            <td>
                <fieldset>
                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Protocollo.sanitario")%></legend>
                    <table width="100%" border="0">
                        <tr>
                            <td align="right" style="width:15%;"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
                            <td align="left"><input style="width:100%;" type="text" name="NOM_AZL" value="<%=Formatter.format(strNOM_AZL)%>" readonly></td>
                        </tr>
                        <tr>
                            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
                            <td align="left"><input style="width:100%;" tabindex="1" type="text" name="NOM_PRO_SAN" value="<%=strNOM_PRO_SAN%>" maxlength="50"></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                            <td align="left"><textarea tabindex="2" rows="3" cols="87" name="DES_PRO_SAN"><%=strDES_PRO_SAN%></textarea></td>
                        </tr>
                        <tr>
                            <td colspan="100%">
                                <div id="dContainer" class="mainTabContainer" style="width:100%"></div>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
    </table>
</form>
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
<script type="text/javascript">
function CaricaDbProtocolli(){ 
    <%if(DEBUG){%>
            window.open("../Form_CRM_PRO_SAN/CRM_PRO_SAN_Form.jsp");
    <%}else{%>
            window.showModalDialog("../Form_CRM_PRO_SAN/CRM_PRO_SAN_Form.jsp", 0, "dialogWidth:830px;dialogHeight:340px;status:no;help:no;scroll:no;");
    <%}%>
}

function CaricaRpProtocolli(){
    document.all['ifrmWork'].src = "../Form_CRM_PRO_SAN/CRM_PRO_SAN_Set.jsp?LOCAL_MODE=caricaRpProtocolli&NOM_PRO_SAN="+document.all['NOM_PRO_SAN'].value;
}
</script>
<%
// -------Loading of Tabs--------------------
if(ProtocoleSanitare!=null){
%>
<script language="JavaScript">
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
    var    tabbar = new TabBar("tbr1",document.all["dContainer"]);
    var butBar = new ButtonPanel("batPanel1", btnParams);
    tabbar.addButtonBar(butBar);
    tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti.sanitari")%>", tabbar));
    tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Visite.di.idoneita")%>", tabbar));
    tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Visite.mediche")%>", tabbar));

    //------adding tables to tabs-----------------------
    tabbar.idParentRecord = <%=lCOD_PRO_SAN %>;
    tabbar.refreshTabUrl="ANA_PRO_SAN_Tabs.jsp";
    tabbar.RefreshAllTabs();
    //----add action parameters to tabs
    tabbar.tabs[0].tabObj.actionParams =
                                {
                                "Feachures":ANA_DOC_Feachures,
                                "AddNew":{
"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_PRO_SAN/ANA_PRO_SAN_Attach.jsp&ATTACH_SUBJECT=DOCUMENTI",
                                "buttonIndex":0
                                },
                                "Edit":{
"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_PRO_SAN/ANA_PRO_SAN_Attach.jsp&ATTACH_SUBJECT=DOCUMENTI",
                                "buttonIndex":1
                                             },
                                "Delete":    {
	 							"url":"../Form_ANA_PRO_SAN/ANA_PRO_SAN_Delete.jsp?LOCAL_MODE=doc",
                                "target_element":document.all["ifrmWork"],
                                "buttonIndex":2
                                }
                            };
    //------------------------------------------------------
    tabbar.tabs[1].tabObj.actionParams =
                                 {
                                  "Feachures": ANA_VST_IDO_Feachures,
                                  "AddNew":{
"url":"../Form_ANA_VST_IDO/ANA_VST_IDO_Form.jsp?ATTACH_URL=Form_ANA_PRO_SAN/ANA_PRO_SAN_Attach.jsp&ATTACH_SUBJECT=IDONEITA",
                                  "buttonIndex":0
                                  },
                                  "Edit":{
"url":"../Form_ANA_VST_IDO/ANA_VST_IDO_Form.jsp?ATTACH_URL=Form_ANA_PRO_SAN/ANA_PRO_SAN_Attach.jsp&ATTACH_SUBJECT=IDONEITA",
                                  "buttonIndex":1
                                  },
                                  "Delete":{
"url":"../Form_ANA_PRO_SAN/ANA_PRO_SAN_Delete.jsp?LOCAL_MODE=ido",
                                "target_element":document.all["ifrmWork"],
                                "buttonIndex":2
                                 }
                                };
	//------------------------------------------------------
    tabbar.tabs[2].tabObj.actionParams =
                             {
                               "Feachures": ANA_VST_MED_Feachures,
                               "AddNew":
                               {
"url":"../Form_ANA_VST_MED/ANA_VST_MED_Form.jsp?ATTACH_URL=Form_ANA_PRO_SAN/ANA_PRO_SAN_Attach.jsp&ATTACH_SUBJECT=MEDICHE",
                               "buttonIndex":0
                               },
                               "Edit":{
"url":"../Form_ANA_VST_MED/ANA_VST_MED_Form.jsp?ATTACH_URL=Form_ANA_PRO_SAN/ANA_PRO_SAN_Attach.jsp&ATTACH_SUBJECT=MEDICHE",
                               "buttonIndex":1
                               },
                               "Delete":{
"url":"../Form_ANA_PRO_SAN/ANA_PRO_SAN_Delete.jsp?LOCAL_MODE=med",
                                "target_element":document.all["ifrmWork"],
                                "buttonIndex":2
                                }
                               }
//------------------------------------------------------
</script>
<%}else{%>
<script>
    window.dialogHeight="250px";
</script>
<%}%>
</body>
</html>
