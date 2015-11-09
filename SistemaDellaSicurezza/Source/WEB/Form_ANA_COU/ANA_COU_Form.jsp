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
<%@ page import="com.apconsulting.luna.ejb.Consulente.*" %>
<%@taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
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

<head>
    <script>
        document.write("<title>" + getCompleteMenuPath(SubMenuAccessi,0) + "</title>");
    </script>
    <LINK REL=STYLESHEET
          HREF="../_styles/style.css"
          TYPE="text/css">
</head>
<link rel="stylesheet" href="../_styles/style.css">
<link rel="stylesheet" href="../_styles/tabs.css">
<script language="JavaScript" src="../_scripts/tabs.js"></script>
<script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
<script>
    window.dialogWidth="900px";
    window.dialogHeight="490px";
    </script>
<body>
    <%
            //   *require Fields*
            String strCOD_COU = "";
            String strNOM_COU = "";
            String strUSD_COU = "";
            String strPSW_COU = "";
            String strSTA_COU = "";
            //   *Not require Fields*
            String strRUO_COU = "";
            String strDAT_ATT = "";
            String strDAT_DIS = "";
            IConsultant cou = null;

            if (request.getParameter("ID") != null) {
                strCOD_COU = request.getParameter("ID");
                // editing of cou
                //getting of cou object
                IConsultantHome home = (IConsultantHome) PseudoContext.lookup("ConsultantBean");
                cou = home.findByPrimaryKey(new Long(strCOD_COU));
                // getting of object variables<br />
                strNOM_COU = Formatter.format(cou.getNOM_COU());
                strUSD_COU = Formatter.format(cou.getUSD_COU());
                strPSW_COU = Formatter.format(cou.getPSW_COU());
                strSTA_COU = Formatter.format(cou.getSTA_COU());
                //--- 
                strRUO_COU = Formatter.format(cou.getRUO_COU());
                strDAT_ATT = Formatter.format(cou.getDAT_ATT());
                strDAT_DIS = Formatter.format(cou.getDAT_DIS());
            }
    %>
    
    <form action="ANA_COU_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
    
    <table  width="100%" align="left">
        <tr><td class="title"><script>document.write(getCompleteMenuPathFunction(SubMenuAccessi,0,<%=request.getParameter("ID")%>));</script></td>
            <input name="SBM_MODE" type="Hidden" value="<%if (strCOD_COU == "") {
                out.print("new");
            } else {
                out.print("edt");
            }%>">
            <input name="COD_COU" type="Hidden" value="<%=strCOD_COU%>">
        </tr>
        <tr><td>
                <table width="100%" border="0">
                    <tr>
                    <td width="10px" valign="top">
                    <%@ include file="../_include/ToolBar.jsp" %>
                    <%ToolBar.bCanDelete = (cou != null);
            ToolBar.bShowPrint = false;
            ToolBar.bShowDelete = true;
                    %>
                    <%=ToolBar.build(3)%>
                </table>
                
                <fieldset><legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.consulente")%></legend>
                    <table  border="0" width="100%">
                        <tr><td width="14%"></td>
                            <td width="48%"></td>
                            <td width="13%"></td>
                            <td width="24%"></td>
                            <td width="1%"></td>
                        </tr> 
                        <tr><td align="right"><div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nominativo")%>&nbsp;</b></div></td>
                            <td><input tabindex="1" style="width:90%;" type="text" maxlength="50" name="NOM_COU" value="<%=strNOM_COU%>"></td>
                            <td align="right"><div align="right"><%=ApplicationConfigurator.LanguageManager.getString("Ruolo")%>&nbsp;</div></td>
                            <td><input tabindex="2" style="width:100%;" type="text" maxlength="30" name="RUO_COU" value="<%=strRUO_COU%>"></td>
                        </tr>
                        <tr><td align="right"><div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Userid")%>&nbsp;</b></div></td>
                            <td><input tabindex="3" style="width:25%;" type="text" maxlength="15" name="USD_COU" value="<%=strUSD_COU%>"></td>
                            <td align="right"><div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Password")%>&nbsp;</b></div></td>
                            <td><input tabindex="4" style="width:50%;" type="password" maxlength="15" name="PSW_COU" value="<%=strPSW_COU%>"></td>
                        </tr>
                        <tr><td align="right"><div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Stato")%>&nbsp;</b></div></td>
                            <td><select tabindex="5" name="STA_COU" style="width:25%;">
                                    <option value="A" <%=(strSTA_COU.equals("A")) ? "selected" : ""%>><%=ApplicationConfigurator.LanguageManager.getString("ATTIVO")%></option>
                                    <option value="D" <%=(strSTA_COU.equals("D")) ? "selected" : ""%>><%=ApplicationConfigurator.LanguageManager.getString("DISATTIVO")%></option>
                                </select>
                            </td> <td>&nbsp;</td><td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td align="right">
                                <div align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.attivazione")%>&nbsp;</div>
                            </td>
                            <td>
                                <s2s:Date tabindex="6" id="DAT_ATT" name="DAT_ATT" value="<%=strDAT_ATT%>"/>                                                                
                            </td>
                            <td align="right">
                                <div align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.disattivazione")%>&nbsp;</div>
                            </td>
                            <td>
                                <s2s:Date tabindex="7" id="DAT_DIS" name="DAT_DIS" value="<%=strDAT_DIS%>"/>                                
                            </td>
                        </tr>
                    </table>
        </fieldset></td></tr>
        <tr>
            <td colspan="100%" valign="top"><div id="dContainer" class="mainTabContainer"></div></td>
        </tr>
    </table>
    <!--/td>
    </tr>
    </table-->
    
    <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
    
    <%
            //-------Loading of Tabs--------------------
            if (cou != null) {
    %>
    <!--script language="JavaScript" src="../_scripts/index.js"></script-->
    <script language="JavaScript">
        if(window.name!="ifrmWork")
            {
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
                btnParams[2] = {"id":"btnCancel", 
                    "onmousedown":btnDown, 
                    "onmouseup":btnOver,
                    "onmouseover":btnOver,
                    "onmouseout":btnOut,
                    "onclick":delRow,
                    "src":"../_images/DEL_DET.gif",
                    "action":"Delete"
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
                /*
                btnParams[3] = {"id":"btnHelp", 
                "onmousedown":btnDown, 	
                "onmouseup":btnOver,
                "onmouseover":btnOver,
                "onmouseout":btnOut,
                "onclick":windowHelp,
                "src":"../_images/HELP.GIF",
                "action":"Help"
                };				
                */                                 
                //--------creating tabs--------------------------
                var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
                var btnBar = new ButtonPanel("batPanel1", btnParams);
                tabbar.addButtonBar(btnBar);
                tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Aziende.associate")%>", tabbar));
                //------adding tables to tabs-----------------------
                tabbar.idParentRecord= <%= new Long(strCOD_COU) %>;
                tabbar.tabs[0].tabObj.refreshTabUrl="ANA_COU_Tabs.jsp"
                tabbar.RefreshAllTabs();
                //----add action parameters to tabs
                tabbar.tabs[0].tabObj.actionParams ={
                    "Feachures":ANA_AZL_Feachures,	
                    "AddNew":	{
                        "url":"../Form_ANA_AZL/ANA_AZL_Form.jsp?ATTACH_URL=Form_ANA_COU/ANA_COU_Attach.jsp&ATTACH_SUBJECT=CONSULTANT",
                        "buttonIndex":0,
                        "disabled": false 
                    },
                    "Edit":	{"url":"../Form_ANA_AZL/ANA_AZL_Form.jsp?ATTACH_URL=Form_ANA_COU/ANA_COU_Attach.jsp&ATTACH_SUBJECT=CONSULTANT",
                        "buttonIndex":1, 
                        "disabled": false													
                    },
                    "Delete":	{"url":"../Form_ANA_COU/AZL_COU_Delete.jsp",
                        "buttonIndex":2, 
                        "target_element":document.all["ifrmWork"],
                        "disabled": false
                    },
                    "Help":	{"url":"../Form_ANA_AZL/ANA_AZL_Help.jsp",
                        "buttonIndex":3,
                        "disabled": false	
                    }	
                    
                    
                };
                //-----activate first tab--------------------------
                tabbar.tabs[0].center.click();
            }
    </script>
    <%} else {%>
    <script>
        window.dialogWidth="900px";
        window.dialogHeight="280px";
    </script>
    <%}%>
    
</body>
</html>
