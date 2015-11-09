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
    <version number="1.0" date="25/01/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="25/01/2004" author="Khomenko Juliya">
				   <description>Shablon formi ANA_LOT_DPI_Form.jsp</description>
				  </comment>		
				  <comment date="21/01/2004" author="Treskina Maria">
				   <description>polychenie dannih ANA_LOT_DPI_Form.jsp</description>
				  </comment>
					<comment date="13/02/2004" author="Treskina Maria">
				   <description>dinamicheskie tabi</description>
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
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.TipologiaDPI.*" %>
<%@ page import="com.apconsulting.luna.ejb.LottiDPI.*" %>
<%@ page import="com.apconsulting.luna.ejb.Fornitore.*" %>
<%@ page import="com.apconsulting.luna.ejb.SchedeInterventoDPI.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="ANA_LOT_DPI_Util.jsp" %>

<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<% 
	//   *require Fields*
	String strCOD_LOT_DPI="";           //1
	String strCOD_TPL_DPI="1234568";    //2
	String strIDE_LOT_DPI="";         	//3
	String strDAT_CSG_LOT=""; 					//4
	String strQTA_FRT="";           		//5
	String strQTA_AST="";           		//6
	String strQTA_DSP="";           		//7
	String strCOD_FOR_AZL="0";           //8
	long lCOD_AZL=Security.getAzienda(); //9
	
	//--- mary for tab
	String strID_PARENT  = ""; // TPL_DPI_TAB.COD_TPL_DPI
	String strNameParent = "";
	String strDisFornitore="", strDisTipologia="";
	strID_PARENT = request.getParameter("ID_PARENT"); // TPL_DPI_TAB.COM_TPL_DPI
	if (strID_PARENT!=null) {
		strNameParent=request.getParameter("PARENT");
		if (strNameParent!=null) {
			if (strNameParent.equals("fornitore")) {strCOD_FOR_AZL=strID_PARENT; strDisFornitore="disabled";}
			else if (strNameParent.equals("tipologia")){strCOD_TPL_DPI=strID_PARENT; strDisTipologia="disabled";}
		}
	}

ILottiDPI lottiDPI=null;
if( request.getParameter("ID")!=null)
{
		strCOD_LOT_DPI = request.getParameter("ID");
 	// editing of lottiDPI
	//getting of lottiDPI object
		ILottiDPIHome home=(ILottiDPIHome)PseudoContext.lookup("LottiDPIBean"); 
		Long lot_dpi_id=new Long(strCOD_LOT_DPI);
		lottiDPI = home.findByPrimaryKey(lot_dpi_id);
		// getting of object variables
		strCOD_TPL_DPI=Formatter.format(lottiDPI.getCOD_TPL_DPI());
		strIDE_LOT_DPI=lottiDPI.getIDE_LOT_DPI();
		strDAT_CSG_LOT=Formatter.format(lottiDPI.getDAT_CSG_LOT());
		strQTA_FRT=Formatter.format(lottiDPI.getQTA_FRT());
		strQTA_AST=Formatter.format(lottiDPI.getQTA_AST());
		strQTA_DSP=Formatter.format(lottiDPI.getQTA_DSP());
		strCOD_FOR_AZL=Formatter.format(lottiDPI.getCOD_FOR_AZL());
		lCOD_AZL=lottiDPI.getCOD_AZL();
}

	
IAzienda azienda=null;
IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");

	Long azl_id=new Long(lCOD_AZL);
	azienda = AziendaHome.findByPrimaryKey(azl_id);
	String	strRAG_SCL_AZL= azienda.getRAG_SCL_AZL();

 %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuDPI,1) + "</title>");
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
</head>
<script>
window.dialogWidth="950px";
window.dialogHeight="560px";
</script>
<body>

<!-- form for addind  Utenzei-->
<form action="ANA_LOT_DPI_Set.jsp"  method="POST" target="ifrmWork">
<input name="SBM_MODE" type="Hidden" value="<%=(strCOD_LOT_DPI=="")?"new":"edt"%>">
<input type="hidden" name="LOT_DPI_ID" value="<%=strCOD_LOT_DPI%>">
<input type="hidden" name="COD_AZIENDA" value="<%=lCOD_AZL%>">

<table width="100%" border="0">
<!-- ############################ -->  		
	<tr>
 		<td width="10" height="100%" valign="top">
 		</td>
 		<td valign="top">
  	<table  width="100%">
                <tr><td class="title">
                    <script>
                        document.write(getCompleteMenuPathFunction
                            (SubMenuDPI,1,<%=request.getParameter("ID")%>));
                    </script>
                </td></tr>
  		<tr>
				<td>
			<table width="100%">
			<%@ include file="../_include/ToolBar.jsp" %>      
           <%
           ToolBar.bCanDelete=(lottiDPI!=null);
           if (strID_PARENT!=null) ToolBar.bShowSearch=false;
           /*	ToolBar.bShowDelete=false;
           	    ToolBar.bShowNew=false;}	*/%>	
           <%=ToolBar.build(3)%> 
           <!-- ########################### -->
			</table>
   			<fieldset>
	 				<legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.lotto")%></legend>
   				<table  width="100%" border="0" >
						<tr>
							<td align="right" width="15%"><div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></div></td>
	 						<td width="80%" colspan="3"><input size="100%" type="text" readonly value="<%=strRAG_SCL_AZL%>"></td>
	 					</tr>
	 					<tr>
							<td colspan="4">
	 						<fieldset>
	 							<legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.tipologia")%></legend>
	 							<table  width="100%" border="0">
     							<tr>
										<td align="right" width="138px"><div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Tipologia.D.P.I.")%>&nbsp;</b></div></td>
	   								    <td>
                                          <select tabindex="1" name="COD_TIPOLOGIA" style="width:90%" <%=strDisTipologia %>>
                                            <option value=''></option>
                                            <%
			ITipologiaDPIHome t_home=(ITipologiaDPIHome)PseudoContext.lookup("TipologiaDPIBean");
			if (strCOD_TPL_DPI.equals("")) {strCOD_TPL_DPI="0";}
			String t_cb=BuildTipologiaDPIComboBox(t_home, new Long(strCOD_TPL_DPI).longValue());
			out.print(t_cb);
	 	%>
                                          </select>										
                                  <%if (strDisTipologia.equals("disabled"))  out.println("<input type='hidden' name='COD_TIPOLOGIA' value='"+strCOD_TPL_DPI+"'>"); %>								  </td>
								  </tr>
   							</table>
	 						</fieldset>
	 						</td>
						</tr> 
   					<tr>
   						<td align="right" width="13%" ><div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Identificativo")%>&nbsp;</b></div></td>
	 					<td  width="43%">
                                                     <input tabindex="2" maxlength="20" type="text" size="35" name="IDENTIFICATIVO" value="<%=strIDE_LOT_DPI%>">
                                                 </td>
                                                 <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Data.consegna")%>&nbsp;</b><nobr></td>
                                                 <td>
                                                     <s2s:Date tabindex="3" id="DATA_CONSEGNA" name="DATA_CONSEGNA" value="<%=strDAT_CSG_LOT%>"/><nobr>
                                                 </td>
                                        </tr>
   					<tr>
							<td align="right" width="15%"><div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Fornitore")%>&nbsp;</b></div></td>
							<td width="80%" colspan="3">
							<select tabindex="4" name="COD_FORNITORE" style="width:90%" <%=strDisFornitore %>>
	 							<option value=''></option>
	 	<% 
			IFornitoreHome f_home=(IFornitoreHome)PseudoContext.lookup("FornitoreBean");
			if(strCOD_FOR_AZL.equals("")){strCOD_FOR_AZL="0";}
			String f_cb=BuildFornitoreComboBox(f_home, new Long(strCOD_FOR_AZL).longValue());
			out.print(f_cb);
	 	%>
	 						</select>
							<%if (strDisFornitore.equals("disabled"))  out.println("<input type='hidden' name='COD_FORNITORE' value='"+strCOD_FOR_AZL+"'>"); %> 
	 						</td>
						</tr>
	 					<tr>
							<td colspan="4">
	 						<fieldset>
	 							<legend><%=ApplicationConfigurator.LanguageManager.getString("Quantità.in.pezzi")%></legend>
	 							<table  width="100%" border="0">
     							<tr>
										<td align="right" width="16%"><b><%=ApplicationConfigurator.LanguageManager.getString("Fornita")%>&nbsp;</b></td>
	   								    <td align="left"><input tabindex="5" size="10%" type="text" name="Q_FORNITA" value="<%=strQTA_FRT%>"></td>
	   								<td align="right" width="17%"><b><%=ApplicationConfigurator.LanguageManager.getString("Assegnata")%>&nbsp;</b></td>  
	   								<td><input tabindex="6" size="10%" type="text" name="Q_ASSEGNATA" value="<%=strQTA_AST%>"></td>
	   								<td align="right" width="17%"><b><%=ApplicationConfigurator.LanguageManager.getString("Disponibile")%>&nbsp;</b></td>
	   								<td><input tabindex="7" size="10%" type="text" name="Q_DISPONIBILE" value="<%=strQTA_DSP%>"></td>
	   							</tr>
   							</table>
	 						</fieldset>
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
                <td colspan="4" valign="top"><div id="dContainer" class="mainTabContainer" style="width:100%;"></div></td>
	</tr> 
</table>
</form>
<!-- /form for addind  Utenzei-->
   <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
<%
//-------Loading of Tabs--------------------
if(lottiDPI!=null)
{
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
	    //--------creating tabs--------------------------
	var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
	var btnBar = new ButtonPanel("batPanel1", btnParams);
	tabbar.addButtonBar(btnBar);
	tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Schede.di.intervento")%>", tabbar));
		//------adding tables to tabs-----------------------
	tabbar.idParentRecord = <%= new Long(strCOD_LOT_DPI) %>;
	tabbar.refreshTabUrl="ANA_LOT_DPI_Tabs.jsp";	
	tabbar.RefreshAllTabs();
	//----add action parameters to tabs
		tabbar.tabs[0].tabObj.actionParams ={
										"Feachures":SCH_INR_DPI_Feachures,
											"AddNew":{"url":"../Form_SCH_INR_DPI/SCH_INR_DPI_Form.jsp?ATTACH_URL=Form_ANA_LOT_DPI/ANA_LOT_DPI_Attach.jsp&ATTACH_SUBJECT=SHEDEINTERVENTO", 
													"buttonIndex":0,
													"disabled": false
												  	},
										"Edit":	{"url":"../Form_SCH_INR_DPI/SCH_INR_DPI_Form.jsp?ATTACH_URL=Form_ANA_LOT_DPI/ANA_LOT_DPI_Attach.jsp&ATTACH_SUBJECT=SHEDEINTERVENTO",
													"buttonIndex":1,
													"disabled": false
										 			},
										 "Delete":	{"url":"../Form_ANA_LOT_DPI/ANA_LOT_DPI_Delete.jsp?LOCAL_MODE=si",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": false	
										 			}	
										}; 
	//-----activate first tab--------------------------
	tabbar.tabs[0].center.click();
</script>
<%}else{%>
<script>
window.dialogWidth="950px";
window.dialogHeight="330px";
</script>
<%}%>
</body>
</html>
