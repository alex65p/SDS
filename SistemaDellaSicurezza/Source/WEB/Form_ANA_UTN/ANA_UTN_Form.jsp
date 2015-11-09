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
    <version number="1.0" date="19/01/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="19/01/2004" author="Khomenko Juliya">
				   <description>Shablon formi ANA_UTN_Form.jsp</description>
				 </comment>		
				 <comments>
				  <comment date="21/01/2004" author="Treskina Maria">
				   <description>polychenie dannih ANA_UTN_Form.jsp</description>
				 </comment>	
				 <comment date="19/02/2004" author="Kushkarov Yura">
				   <description>peredelivayu na selecti + tabi ANA_UTN_Form.jsp</description>
				 </comment>	
      </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.Utente.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%--@ include file="ANA_UTN_Util.jsp" --%>
<%@ include file="../_include/ComboBox-Dipendente.jsp"%>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
document.write("<title>" + getCompleteMenuPath(SubMenuAccessi,1) + "</title>");
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
window.dialogWidth="830px";
window.dialogHeight="500px";
</script>
<body>

<%
	String 	strCOD_UTN="";			    //1 
	String 	strUSD_UTN="";
	String 	strPSW_UTN="";
	String 	strSTA_UTN="";
	long 		lCOD_DPD=0;
	long			  lCOD_AZL = Security.getAzienda();
	long lCOD_UTN=0;
	//   *Not require Fields*
	String 	strDAT_ATT="";
	String 	strDAT_DIS="";
IUtente Utente=null;
IAzienda azienda;
IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");
if(request.getParameter("ID")!=null)
{
		
		strCOD_UTN = request.getParameter("ID");
		lCOD_UTN = new Long(strCOD_UTN).longValue();
	//getting of utente object
		IUtenteHome home=(IUtenteHome)PseudoContext.lookup("UtenteBean"); 
		Long utn_id=new Long(strCOD_UTN);
		Utente = home.findByPrimaryKey(utn_id);
		
		// getting of object variables
		strUSD_UTN=Utente.getUSD_UTN();
		strPSW_UTN=Utente.getPSW_UTN();
		strSTA_UTN=Utente.getSTA_UTN();
		lCOD_DPD=Utente.getCOD_DPD();
		lCOD_AZL=Utente.getCOD_AZL();
		
		strDAT_ATT = Formatter.format(Utente.getDAT_ATT());
		strDAT_DIS = Formatter.format(Utente.getDAT_DIS());
}	
Long azl_id=new Long(lCOD_AZL);
long COD_AZL=new Long(lCOD_AZL).longValue();
	azienda = AziendaHome.findByPrimaryKey(azl_id);
	String	strRAG_SCL_AZL= azienda.getRAG_SCL_AZL();
%>



<!-- form for addind  Utenzei-->
<form action="ANA_UTN_Set.jsp"  method="POST" target="ifrmWork">
<input name="SBM_MODE" type="hidden" value="<%=(strCOD_UTN=="")?"new":"edt"%>">
<input type="hidden" name="UTN_ID" value="<%=strCOD_UTN%>">
<input type="hidden" name="COD_AZIENDA" value="<%=lCOD_AZL%>">
<input type="hidden" name="COD_DIPENDENTE" value="<%=lCOD_DPD%>">

<table width="100%" border="0">
<tr>
 <td width="10" height="100%" valign="top">
 <!-- <button type="button" class="menu" >&nbsp;1&nbsp;</button><br>
 <button type="button" class="menu">&nbsp;2&nbsp;</button>
 <button type="button" class="menu">&nbsp;3&nbsp;</button><br>
 <button type="button" class="menu">&nbsp;4&nbsp;</button>
 <button type="button" class="menu">&nbsp;5&nbsp;</button><br>
 -->

 </td>
 <td valign="top">
  <tr><td class="title">
    <script>
        document.write(getCompleteMenuPathFunction(SubMenuAccessi,1,<%=request.getParameter("ID")%>));
    </script>
  </td></tr>
</table>
<table width="100%">
	<tr>
  		<td>
  		<!-- ############################ -->
  			<%@ include file="../_include/ToolBar.jsp" %>
      		<%ToolBar.bCanDelete=(Utente!=null);%>
			<%=ToolBar.build(3)%>
 		<!-- ########################### -->
 		</td>
	</tr>
</table>
<table border="0" width="100%" cellspacing="3">
    <tr>
             <td>
                 <fieldset>
                     <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.utenza")%></legend>
                     <table width="80%" border="0" > 
                         <tr>
                             <td align="left"><div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></div></td>
                             <td colspan=3><input tabindex="1" size="97%" type="text" name="RAG_SCL_AZL" readonly value="<%=strRAG_SCL_AZL%>"></td>
                         </tr>
                         <tr>
                             <td align="left"><div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Dipendente")%>&nbsp;</b></div></td>
                             <td colspan=3>
                                 <select tabindex="2" name="COD_DPD" style=" width:100%">
                                     <option></option>
                                     <%
                                          IDipendenteHome d_home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
                                          out.print(BuildDipendenteComboBox(d_home, lCOD_DPD, lCOD_AZL));
                                     %>
                                 </select>
                             </td>
                             
                         </tr>
                         
                         <tr>
                             <td align="right" width="10%" ><div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Userid")%>&nbsp;</b></div></td>
                             <td  width="26%"><input name="USER_ID" type="text"  tabindex="3" value="<%=strUSD_UTN%>" size="40%"></td>
                             <td  width="17%" align="right"><div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Password")%>&nbsp;</b></div></td>
                             <td  width="21%"><nobr> <input tabindex="4"  size="33" type="password" name="PASSWORD" value="<%=strPSW_UTN%>"></nobr></td>
                         </tr>
                         <tr>
                             <td align="right" ><div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Stato.utenza")%>&nbsp;</b></div></td>
                             <td nowrap><select tabindex="5" name="STATO" style=" width:50%">
                                     <option></option>
                                     <option value="A" <%if(strSTA_UTN.equals("A")){out.print("selected");}%>><%=ApplicationConfigurator.LanguageManager.getString("ATTIVO")%></option>
                                     <option value="D" <%if(strSTA_UTN.equals("D")){out.print("selected");}%>><%=ApplicationConfigurator.LanguageManager.getString("DISATTIVO")%></option>
                             </select></td>
                             <!-- <select name="">
                             <option value="<%//=%>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option></select> -->
                             <td nowrap><div align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.attivazione")%>&nbsp;</div></td>
                             <td>
                                 <s2s:Date tabindex="6" id="DATA_ATT" name="DATA_ATT" value="<%=strDAT_ATT%>"/>
                             </td>
                             <td width="17%"><div align="right"><nobr><%=ApplicationConfigurator.LanguageManager.getString("Data.disattivazione")%>&nbsp;</div></td>
                             <td width="9%">
                                 <s2s:Date tabindex="7" id="DATA_DIS"  name="DATA_DIS" value="<%=strDAT_DIS%>"/>
                                 <!--</nobr>-->
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
    
<td colspan="100" width="100%">
<table width="100%">
	<tr>
		<td><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
	</tr>
</table>
</td>
</tr>
</table>

</form>
<!-- /form for addind  Utenzei-->
   <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
	 <%
//-------Loading of Tabs--------------------

if(Utente!=null){

// -----------------------------------------
%>
<script language="JavaScript" src="../_scripts/index.js"></script>
<script language="JavaScript"></script>
<script language="JavaScript">
btnParams = new Array();
	btnParams[0] = {"id":"btnNew", 
					"onmousedown":btnDown, 	
					"onmouseup":btnOver,
					"onmouseover":btnOver,
					"onmouseout":btnOut,
					"onclick":OnClick,
					"src":"../_images/NUOVO.gif", 
					"action":"AddNew"
					};
		/*btnParams[0] = {"id":"btnNew", 
					"onmousedown":btnDown, 	
					"onmouseup":btnOver,
					"onmouseover":btnOver,
					"onmouseout":btnOut,
					"onclick":addRow,
					"src":"../_images/NUOVO.gif", 
					"action":"AddNew"
					};*/
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

 /* btnParams[3] = {"id":"btnHelp", 
					"onmousedown":btnDown, 	
					"onmouseup":btnOver,
					"onmouseover":btnOver,
					"onmouseout":btnOut,
					"onclick":windowHelp,
					"src":"../_images/HELP.GIF",
					"action":"Help"
					};	*/			
                                        
    //--------creating tabs--------------------------
	var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
	var btnBar = new ButtonPanel("batPanel1", btnParams);
	tabbar.addButtonBar(btnBar);
	tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Categorie.documento")%>", tabbar));
	tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Tipologie.documento")%>", tabbar));
	tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Ruoli")%>", tabbar));
	
	//------adding tables to tabs-----------------------
	tabbar.idParentRecord = <%= new Long(lCOD_UTN) %>;
	tabbar.refreshTabUrl="ANA_UTN_Tabs.jsp";	
	tabbar.RefreshAllTabs();
	//-----activate first tab--------------------------
	tabbar.tabs[0].center.click();
	//----add action parameters to tabs
	tabbar.tabs[0].tabObj.actionParams ={
										"Feachures":CAG_DOC_Feachures,
                                                                                        "AddNew":{"url":"../Form_CAG_DOC/CAG_DOC_Form.jsp?ATTACH_URL=Form_ANA_UTN/ANA_UTN_Attach.jsp&ATTACH_SUBJECT=CATEGORIA", 
													"buttonIndex":0,
													"disabled": false
												  	},
										"Edit":	{"url":"../Form_CAG_DOC/CAG_DOC_Form.jsp?ATTACH_URL=Form_ANA_UTN/ANA_UTN_Attach.jsp&ATTACH_SUBJECT=CATEGORIA",
													"buttonIndex":1,
													"disabled": false
										 			},
										 "Delete":	{"url":"../Form_ANA_UTN/ANA_UTN_Delete.jsp?LOCAL_MODE=cag",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": false	
										 			},	
										 "Help":	{"url":"../Form_CAG_DOC/Form_CAG_DOC_Help.jsp",
													"buttonIndex":3,
													"disabled": false	
										 			}	
										}; 
	
  tabbar.tabs[1].tabObj.actionParams ={
										"Feachures":TPL_DOC_Feachures,
											"AddNew":{"url":"../Form_TPL_DOC/TPL_DOC_Form.jsp?ATTACH_URL=Form_ANA_UTN/ANA_UTN_Attach.jsp&ATTACH_SUBJECT=TIPOLOGIA", 
													"buttonIndex":0,
													"disabled": false
													
												  	},
										"Edit":	{"url":"../Form_TPL_DOC/TPL_DOC_Form.jsp?ATTACH_URL=Form_ANA_UTN/ANA_UTN_Attach.jsp&ATTACH_SUBJECT=TIPOLOGIA",
													"buttonIndex":1,
													"disabled": false
										 			},
										 "Delete":	{"url":"../Form_ANA_UTN/ANA_UTN_Delete.jsp?LOCAL_MODE=tpl",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": false	
										 			},
										 "Help":	{"url":"../Form_TPL_DOC/TPL_DOC_Help.jsp",
													"buttonIndex":3,
													"disabled": false	
										 			}	
		  	
										}; 
  tabbar.tabs[2].tabObj.actionParams ={
										"Feachures":{"dialogWidth":"30", 
													  "dialogHeight":"20"
													},
											"AddNew":{"url":"",
													"buttonIndex":0,
													"disabled": false
												  	},
										"Edit":	{"url":"",
													"buttonIndex":1,
													"disabled": true
										 			},
										 "Delete":	{"url":"../Form_ANA_UTN/ANA_UTN_Delete.jsp?LOCAL_MODE=ruo",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": false	
										 			},
                                                                                 "Help":	{"url":"../Form_ANA_RUO/ANA_RUO_Help.jsp",
													"buttonIndex":3,
													"disabled": false	
										 			}	
		  	
										}; 
tabbar.tabs[0].tabObj.OnActivate = function ()
		{
			tabbar.buttonBar.panel.style.display = '';
		};	
tabbar.tabs[1].tabObj.OnActivate = function ()
		{
			tabbar.buttonBar.panel.style.display = '';
		};	
tabbar.tabs[2].tabObj.OnActivate = function ()
		{
			tabbar.buttonBar.panel.style.display = '';
		};	

		function OnClick()
	  {
    if(tabbar.activeTab.id=="tab3")
    {
		  //addRow(this.action);
		  var obj=new Object;
      res=showSearch("Form_ANA_RUO/ANA_RUO_View.jsp", obj);
			if(res=="OK"){ document.all['ifrmWork'].src="ANA_UTN_Attach.jsp?ATTACH_SUBJECT=RUOLI&ID_PARENT="+<%=lCOD_UTN%>+"&ID="+obj.ID;
			}
    }
    else
    {
	    addRow(this.action);
	  }
  }


</script>
<%}else{%>
<script>
window.dialogWidth="830px";
window.dialogHeight="280px";
</script>
<%}%>
</body>
</html>
