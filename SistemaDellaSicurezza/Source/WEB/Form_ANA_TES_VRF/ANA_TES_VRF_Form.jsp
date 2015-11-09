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
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/TestVerifica/TestVerificaBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TestVerifica/TestVerificaBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%// include file="ANA_TES_VRF_Util.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuTestVerifica,0) + "</title>");
</script>
  <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
	<link rel="stylesheet" href="../_styles/tabs.css">
	<script language="JavaScript" src="../_scripts/tabs.js"></script>
	<script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>

</head>
<script>
window.dialogWidth="850px";
window.dialogHeight="590px";
</script>
<body style="margin:0 0 0 0;">
<%!  
	boolean EdFlag=false;		//flag of editing
%>
<%
	long lCOD_TES_VRF = 0;		//1
	String strNOM_TES_VRF = "";	//2
 	//-----------------------------
	String strDES_TES_VRF = ""; //3
	long lNUM_MIN_PTG = 0; 	 	//4
	long lNUM_MAX_PTG = 0; 	 	//5
	ITestVerifica TestVerifica = null;

if(request.getParameter("ID")!=null)
{
	String strCOD_TES_VRF = request.getParameter("ID");	
	ITestVerificaHome home=(ITestVerificaHome)PseudoContext.lookup("TestVerificaBean");
	Long tes_vrf_id=new Long(strCOD_TES_VRF);
	TestVerifica = home.findByPrimaryKey(tes_vrf_id);
	lCOD_TES_VRF = TestVerifica.getCOD_TES_VRF();//tes_vrf_id.longValue();
	strNOM_TES_VRF=Formatter.format(TestVerifica.getNOM_TES_VRF());
	// --- 
	strDES_TES_VRF=Formatter.format(TestVerifica.getDES_TES_VRF());
	lNUM_MIN_PTG=TestVerifica.getNUM_MIN_PTG();
	lNUM_MAX_PTG=TestVerifica.getNUM_MAX_PTG();
}
%>

<!-- form for addind  TestVerifica-->
<form action="ANA_TES_VRF_Set.jsp"  name="forma" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="Hidden" value="<%=(lCOD_TES_VRF==0)?"new":"edt"%>">
<input type="hidden" name="TES_VRF_ID" value="<%=lCOD_TES_VRF%>">
<table width="100%" cellpadding="0" cellspacing="0" border="0">

	<tr>
 		<td valign="top" align="left" border="0">
  	<table  border="0" width="100%">
  		<tr><td class="title">
                    <script>
                        document.write(getCompleteMenuPathFunction
                            (SubMenuTestVerifica,0,<%=request.getParameter("ID")%>));
                    </script>
  		</td></tr>
  		<tr>
				<td>
	<!-- ############################ --> 
	<table width="100%" border="0">
	<%@ include file="../_include/ToolBar.jsp" %>      
	<%ToolBar.bCanDelete=(TestVerifica!=null);%>		
	<%ToolBar.strPrintUrl="TestDiVerifica.jsp?";%>
	<%=ToolBar.build(3)%> 
	</table>
	<!-- ########################### -->
	<br>				
  			<fieldset>
	 				<legend><%=ApplicationConfigurator.LanguageManager.getString("Gestione.test.di.verifica")%></legend>
	 				
              <table width="100%" border="0">
                <tr>
			   			   
							
                  <td align="right" width="22%"><%=ApplicationConfigurator.LanguageManager.getString("Punteggio.massimo.del.test")%>&nbsp;</td>
							<td align="left" width="85%"><input  tabindex="4" type="text" id="MAX" name="MAX" value="<% if(lNUM_MAX_PTG!=0) {out.print(lNUM_MAX_PTG);}%>"></td>
						</tr> 
			  
			  
                <tr>
							
                  <td align="right" width="22%"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome.test")%>&nbsp;</b></td>
							<td align="left" width="85%"><input tabindex="1" type="text" name="Nome" value="<%=strNOM_TES_VRF%>" maxlength="50"></td>
						</tr> 
						<tr>
							
                  <td align="right"  width="22%"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione.test")%>&nbsp;</td>
							<td width="85%"><textarea  tabindex="2" rows="5" cols="66" name="DESC"><%= strDES_TES_VRF%></textarea></td>
						</tr>
						<tr>
							
                  <td  align="right" width="22%"><%=ApplicationConfigurator.LanguageManager.getString("Punteggio.minimo.per.approvazione")%>&nbsp;</td>
							<td align="left" width="85%"><input tabindex="3"  type="text" name="MIN" value="<% if(lNUM_MIN_PTG!=0) {out.print(lNUM_MIN_PTG);}%>">
						</tr>
					 </table>
					</fieldset>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td><div id="dContainer" class="mainTabContainer"></div></td>
	</tr>
</table> 
</form>
<!-- /form for addind  TestVerifica-->
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
<%//-------Loading of Tabs--------------------
if(TestVerifica!=null) {
        
%>
<script>
window.dialogWidth="850px";
window.dialogHeight="590px";
</script>
<script language="JavaScript" src="../_scripts/index.js"></script>
<script language="JavaScript">
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
	tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Domande")%>", tabbar));
//------adding tables to tabs-----------------------
	tabbar.idParentRecord = <%= lCOD_TES_VRF %>;
	tabbar.refreshTabUrl="ANA_TES_VRF_Tabs.jsp";	
	tabbar.RefreshAllTabs();
	//-----activate first tab--------------------------
	tabbar.tabs[0].center.click();
	//----add action parameters to tabs
	tabbar.tabs[0].tabObj.actionParams ={
										"Feachures":ANA_DMD_Feachures,
											"AddNew":{"url":"../Form_ANA_DMD/ANA_DMD_Form.jsp?ATTACH_URL=Form_ANA_TES_VRF/ANA_TES_VRF_Attach.jsp&ATTACH_SUBJECT=DOMANDA_TES_VRF", 
													"buttonIndex":0,
													"disabled": false
												  	},
										"Edit":	{"url":"../Form_ANA_DMD/ANA_DMD_Form.jsp?ATTACH_URL=Form_ANA_TES_VRF/ANA_TES_VRF_Attach.jsp&ATTACH_SUBJECT=DOMANDA_TES_VRF",
													"buttonIndex":1,
													"disabled": false
										 			},
										 "Delete":	{"url":"../Form_ANA_TES_VRF/ANA_TES_VRF_Delete.jsp?LOCAL_MODE=d",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": false	
										 			}	
		  	
										}; 
  //----------------------------------------------------------------------
</script>

 <%} else {%>
 <script>
    window.dialogHeight="350px";
 </script>
 <%}%>

</body>
</html> 
