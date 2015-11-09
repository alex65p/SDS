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
<%@ page import="com.apconsulting.luna.ejb.AnagrProcedimento.*" %>

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
            document.write("<title>" + getCompleteMenuPath(SubMenuAnagraficagenerale,0) + "</title>");
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
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>

    </head>

    <body>

        <%!           long lCOD_AZL;
            long lCOD_PSC;
            long lCOD_PRO;
            String strDES;
            String strNOM_RUP;
            String strCOD;
            String dtDAT_AMM;
        %>
        <%
                    lCOD_AZL = 0;
                    lCOD_PRO = 0;
                    strDES = strNOM_RUP = strCOD = "";
                    dtDAT_AMM = null;


                    IAzienda azienda;
                    IAziendaHome AziendaHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");

                    IAnagrProcedimento bean = null;
                    IAnagrProcedimentoHome home = (IAnagrProcedimentoHome) PseudoContext.lookup("AnagrProcedimentoBean");

                    lCOD_AZL = Security.getAzienda();
                    if (request.getParameter("ID") != null) {
                        String strCOD_PRO = request.getParameter("ID");

                        Long pro_id = new Long(strCOD_PRO);
                        bean = home.findByPrimaryKey(pro_id);

                        lCOD_PRO = pro_id.longValue();                          //1
                        strDES = Formatter.format(bean.getstrDES());        	//2
                        strNOM_RUP = Formatter.format(bean.getstrNOM_RUP());        	//3
                        strCOD = Formatter.format(bean.getstrCOD());        	//4
                        dtDAT_AMM = Formatter.format(bean.getdtDAT_AMM());        	//5                         //6
                        lCOD_AZL = bean.getlCOD_AZL();                          //6
                    }

                    // Get Aziende/Ente

        %>

        <!-- form for addind azienda -->
        <form action="ANA_PRO_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value="<%=(lCOD_PRO == 0) ? "new" : "edt"%>">
            <input type="hidden" name="PRO_ID" value="<%=lCOD_PRO%>">
            <input type="hidden" name="COD_AZL" value="<%=lCOD_AZL%>">
            <table width="100%" border="0">

                <tr>
                    <td valign="top">

                        <table  width="100%">
                            <tr><td class="title">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                        (SubMenuAnagraficagenerale,0,<%=request.getParameter("ID")%>));
                                    </script>
                                </td></tr>
                            <tr>
                                <td><table>

                                        <!-- 	********************************** -->
                                        <table width="100%" border="0">
                                            <%@ include file="../_include/ToolBar.jsp" %>
                                            <%=ToolBar.build(3)%>
                                        </table>
                                        <!-- 	********************************** -->
                                </td></tr></table>
                        <table  width="100%" border="0" cellspacing='5' cellpadding='0'>
                            <tr><td>
                                    <fieldset>
                                        <legend ></legend><table>
                                                <!--tr>
                                                    <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
                                                    <td colspan="3"><input tabindex="1" size="110" type="text" readonly value="">
                                                    </td></tr-->
                                                <tr>
                                                    <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Codice")%>&nbsp;</b></td>
                                                    <td align="left"><input tabindex="2" size="46" type="text" maxlength="20" name="COD" id="COD" value="<%=strCOD%>"></td>
                                                </tr>
                                                <tr>
                                                    <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</b></td>
                                                    <td align="left" colspan="3"><input tabindex="2" size="110" type="text" maxlength="100" name="DES" id="DES" value="<%=strDES%>"></td>
                                                </tr>
                                                <tr>
                                                    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Nome.RUP")%>&nbsp;</td>
                                                    <td align="left" colspan="3"><input tabindex="2" size="110" type="text" maxlength="100" name="NOM_RUP" id="DES" value="<%=strNOM_RUP%>"></td>
                                                </tr>

                                            </table>
                                    </fieldset>
                                </td></tr>
                        </table>

                    </td></tr>

                <script>
                    window.dialogWidth="700px";
                    window.dialogHeight="475px";
                </script>

            </table>
            <tr>
                <td colspan="100%"><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
            </tr>

        </form>
        <!-- /form for addind Dipendente -->

        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" >none</iframe>
        
                  

        
        
        <%
//-------Loading of Tabs--------------------
//if(AgentoChimico!=null)
//{
%>
<%//=BuildFrasiRTab(home, lCOD_SOS_CHI)%>
<%//=BuildFrasiSTab(home, lCOD_SOS_CHI)%>
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
	tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Cantiere")%>", tabbar));
	
	//------adding tables to tabs-----------------------
	tabbar.idParentRecord = <%= lCOD_PRO%>
   tabbar.refreshTabUrl = "ANA_PRO_Tabs.jsp";
   tabbar.RefreshAllTabs();

	/*tabbar.tabs[0].tabObj.actionParams ={
										"Feachures": ANA_OPE_Feachures,
										"AddNew":	{"url":"../Form_ANA_OPE/ANA_OPE_Form.jsp?ATTACH_URL=Form_ANA_PRO/ANA_PRO_Attach.jsp&ATTACH_SUBJECT=PROOPE", 
													"buttonIndex":0
												  	},
										 "Delete":	{"url":"../Form_ANA_PRO/ANA_PRO_Delete.jsp?LOCAL_MODE=OPE",
													"buttonIndex":2,
													"target_element":document.all["ifrmWork"]
										 			},		
										 "Edit":	{"url":"../Form_ANA_OPE/ANA_OPE_Form.jsp?ATTACH_URL=Form_ANA_PRO/ANA_PRO_Attach.jsp&ATTACH_SUBJECT=PROOPE",
													"buttonIndex":1
										 			}			  	
										};*/

       tabbar.tabs[0].tabObj.actionParams ={
										"Feachures": ANA_CAN_Feachures,
										"AddNew":	{"url":"../Form_ANA_CAN/ANA_CAN_Form.jsp?ATTACH_URL=Form_ANA_PRO/ANA_PRO_Attach.jsp&ATTACH_SUBJECT=PROCAN",
													"buttonIndex":0
												  	},
										 "Delete":	{"url":"../Form_ANA_PRO/ANA_PRO_Delete.jsp?LOCAL_MODE=CAN",
													"buttonIndex":2,
													"target_element":document.all["ifrmWork"]
										 			},
										 "Edit":	{"url":"../Form_ANA_CAN/ANA_CAN_Form.jsp?ATTACH_URL=Form_ANA_OPE/ANA_OPE_Attach.jsp&ATTACH_SUBJECT=OPECAN",
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
        window.dialogHeight="240px";
<%}%>
</script>

      </body>
</html>
 
        
   
