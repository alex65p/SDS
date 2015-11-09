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



<%@page import="com.apconsulting.luna.ejb.AnagrCantieri.IAnagrCantieriHome"%>
<%@page import="com.apconsulting.luna.ejb.AnagrCantieri.IAnagrCantieri"%>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<script>
</script>
<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuAnagraficagenerale,1) + "</title>");
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
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
    </head>
    <script>
        window.dialogWidth="700px";
        window.dialogHeight="170px";
    </script>
    <body>
        <%! long lCOD_CAN;
            String strDES_CAN;
            String strNOM_CAN;
            boolean bExtended=false;
        %>
        <%
            lCOD_CAN = 0;
            strDES_CAN = "";
            strNOM_CAN = "";

            IAnagrCantieri bean = null;
            IAnagrCantieriHome home = (IAnagrCantieriHome) PseudoContext.lookup("AnagrCantieriBean");

            if (request.getParameter("ID") != null) {
                String strCOD_CAN = request.getParameter("ID");

                Long ope_id = new Long(strCOD_CAN);
                bean = home.findByPrimaryKey(ope_id);

                lCOD_CAN = ope_id.longValue();                          //1
                strDES_CAN = Formatter.format(bean.getstrDES_CAN());  
                strNOM_CAN = Formatter.format(bean.getstrNOM_CAN());                     	//2
            }
        %>
        <!-- form for addind azienda -->
        <form action="ANA_CAN_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0; ">
            <input name="SBM_MODE" type="Hidden" value="<%=(lCOD_CAN == 0) ? "new" : "edt"%>">
            <input type="hidden" name="CAN_ID" value="<%=lCOD_CAN%>">
            <input type="hidden" name="ID_PARENT" value="<%//=request.getParameter("ID_PARENT")%>">
            <table width="100%" border="0">
                <tr>
                    <td valign="top">
                        <table  width="100%" border="0">
                            <tr>
                                <td class="title">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                        (SubMenuAnagraficagenerale,1,<%=request.getParameter("ID")%>));
                                    </script>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <!-- 	********************************** -->
                                    
                                   
                                    
                                    <table width="100%" border="0">
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%=ToolBar.build(3)%>
                                        
                                                                                    <%
                                                    if (Security.isExtendedMode()){
                                                            bExtended=true;
                                                    }
                                            %>
                                    </table>
                                    <!-- 	********************************** -->
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <fieldset>  
                                        <legend>Descrizione Opera</legend>
                                        <table  width="100%" border="0" cellspacing='5' cellpadding='0'>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Codice")%>&nbsp;</b></td>
                                                <td align="left" colspan="3">
                                                   <td align="left" width="89.5%" colspan="9">
                                                    <input tabindex="2" size="110" type="text" maxlength="100" name="NOM_CAN" id="NOM" value="<%=strNOM_CAN%>"></td>
                                            </tr>
                                            <tr>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                                <td align="left" colspan="3">
                                                <td align="left" width="89.5%" colspan="9"><TEXTAREA tabindex="16" cols="70" rows="2" maxlength="4000" name="DES_CAN"><%=Formatter.format(strDES_CAN)%></TEXTAREA></td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <script>
                    window.dialogWidth="700px";
                    window.dialogHeight="460px";
                </script>
            </table>
            <tr>
                <td colspan="100%"><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
            </tr>
        </form>
        <!-- /form for addind Dipendente -->
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" >none</iframe>

<script language="JavaScript" src="../_scripts/index.js"></script>
<script language="JavaScript">




    <%if (bean != null) //if (false)
            {
    %>
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
	tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Opera")%>", tabbar));

	//------adding tables to tabs-----------------------
	tabbar.idParentRecord = <%= lCOD_CAN%>
   tabbar.refreshTabUrl = "ANA_CAN_Tabs.jsp";
   tabbar.RefreshAllTabs();

	tabbar.tabs[0].tabObj.actionParams ={
										"Feachures": ANA_OPE_Feachures,
										"AddNew":	{"url":"../Form_ANA_OPE/ANA_OPE_Form.jsp?ATTACH_URL=Form_ANA_CAN/ANA_CAN_Attach.jsp&ATTACH_SUBJECT=CANOPE",
													"buttonIndex":0
												  	},
										 "Delete":	{"url":"../Form_ANA_CAN/ANA_CAN_Delete.jsp?LOCAL_MODE=OPE",
													"buttonIndex":2,
													"target_element":document.all["ifrmWork"]
										 			},
										 "Edit":	{"url":"../Form_ANA_OPE/ANA_OPE_Form.jsp?ATTACH_URL=Form_ANA_PRO/ANA_PRO_Attach.jsp&ATTACH_SUBJECT=PROOPE",
													"buttonIndex":1
										 			}
										};


	//-----------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	//-----activate first tab-------------------------
	tabbar.tabs[0].center.click();
    <%}else{%>
        window.dialogHeight="225px";
<%}%>
</script>
    </body>
</html>

