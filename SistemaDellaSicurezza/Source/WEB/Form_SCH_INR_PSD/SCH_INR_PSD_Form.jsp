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
    <version number="1.0" date="27/01/2004" author="Kushkarov Yura">
	      <comments>
				  <comment date="27/01/2004" author="Kushkarov Yura">
				   <description>Shablon formi NAT_LES_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.SchedeInterventoPSD.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="SCH_INR_PSD_Util.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuPresidi,2) + "</title>");
</script>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">
			<link rel="stylesheet" href="../_styles/tabs.css">
      <script language="JavaScript" src="../_scripts/tabs.js"></script>
<script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>

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
</head>
<script>
window.dialogWidth="885px";
window.dialogHeight="555px";
</script>
<body>
<%
	//boolean EdFlag=false;		//flag of editing
	String         strCOD_SCH_INR_PSD="";              //1
  long           lCOD_PSD_ACD=0;            //2
	String				 sCOD_PSD_ACD="";
	String         strTPL_INR_PSD="";            //4
	String         strATI_SVO="";                //5
	String         strDAT_PIF_INR="";            //6
	
//-------------------------------------------------
  String         strDAT_INR="";                //7
	String         strESI_INR="";                //8
	String         strPBM_RSC="";
	String         strNOM_RSP_INR="";                //9
//-------------------------------------------------
  String         DChecked="";
	String         PChecked="";
	String         NChecked="";
	String         MSel="";
	String         SSel="";
	String         DISABL="";
ISchedeInterventoPSD SchedeInterventoPSD = null;
		strCOD_SCH_INR_PSD = request.getParameter("ID");
if( request.getParameter("ID")!=null)
{

	// editing of ala
	//getting of ala object
		ISchedeInterventoPSDHome home=(ISchedeInterventoPSDHome)PseudoContext.lookup("SchedeInterventoPSDBean"); 
		Long COD_SCH_INR_PSD=new Long(strCOD_SCH_INR_PSD);
		SchedeInterventoPSD = home.findByPrimaryKey(COD_SCH_INR_PSD);
		// getting of object variables
		lCOD_PSD_ACD=SchedeInterventoPSD.getCOD_PSD_ACD();
		strTPL_INR_PSD=SchedeInterventoPSD.getTPL_INR_PSD();
		strATI_SVO=SchedeInterventoPSD.getATI_SVO();
		strDAT_PIF_INR=Formatter.format(SchedeInterventoPSD.getDAT_PIF_INR());
		//-----------------------------
		strDAT_INR=Formatter.format(SchedeInterventoPSD.getDAT_INR());
		strESI_INR=SchedeInterventoPSD.getESI_INR();
		strPBM_RSC=SchedeInterventoPSD.getPBM_RSC();
		strNOM_RSP_INR=SchedeInterventoPSD.getNOM_RSP_INR();
		//---		
	//	out.print("<script>alert(\""+lCOD_PSD_ACD+"\");</script>");
}
if(request.getParameter("ID_PARENT")!=null)
{
  sCOD_PSD_ACD=request.getParameter("ID_PARENT");
	DISABL="disabled";
	lCOD_PSD_ACD=new Long(sCOD_PSD_ACD).longValue();
}
%>

<!-- form for addind  -->
<form action="SCH_INR_PSD_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
 <!-- <button type="button" class="menu" >&nbsp;1&nbsp;</button><br>
 <button type="button" class="menu">&nbsp;2&nbsp;</button>
 <button type="button" class="menu">&nbsp;3&nbsp;</button><br>
 <button type="button" class="menu">&nbsp;4&nbsp;</button>
 <button type="button" class="menu">&nbsp;5&nbsp;</button><br>
 -->


<table width="100%" border="0">
<tr>
  <td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuPresidi,2,<%=request.getParameter("ID")%>));
    </script>      
  </td>
</tr>
</table>
<input name="SBM_MODE" type="hidden" value="<%=(strCOD_SCH_INR_PSD==null)?"new":"edt"%>">
<input name="COD_SCH_INR_PSD" type="hidden" value="<%=strCOD_SCH_INR_PSD%>">
<input type="hidden" name="ID_PARENT" value="<%=request.getParameter("ID_PARENT")%>">

  <table width="100%">
<!-- ############################ -->
	<%@ include file="../_include/ToolBar.jsp" %>
    <%ToolBar.bCanDelete=(SchedeInterventoPSD!=null);%>
	<%ToolBar.bShowReturn=false;%>
	<%=ToolBar.build(3)%>
 <!-- ########################### -->
  
  </table>
  <table border="0" width="100%" align="center"> 
      <tr> 
          <td>
  <fieldset>
         <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.scheda.d'intervento")%></legend>
		   
  <table border="0" width="100%">
    <tr> 
      <td align="right" valign="top" width="14%"><b><%=ApplicationConfigurator.LanguageManager.getString("Presidio")%>&nbsp;</b></td>
      <td valign="top" colspan="4"> 
        <!-- <input type="text" value="<%=lCOD_PSD_ACD%>"> -->
        <select tabindex="1" name="COD_PSD_ACD" id="COD_PSD_ACD" style="width:100%" <%=DISABL%>>
          <option></option>
          <%ISchedeInterventoPSDHome SchedeInterventoPSD_mt=(ISchedeInterventoPSDHome)PseudoContext.lookup("SchedeInterventoPSDBean");
		              	String ACDPSD_cb=BuildACDBox(SchedeInterventoPSD_mt, lCOD_PSD_ACD);
		                out.print(ACDPSD_cb);%>
        </select></td>
      <%if(DISABL.equals("disabled"))
							  {
								  %>
      <input tabindex="2"type="hidden" name="COD_PSD_ACD" value="<%=lCOD_PSD_ACD%>">
      <%
								}
							%>
    </tr>
    <%
		   if((strESI_INR!=null)&&(strESI_INR.equals("D")))
		 {
		   DChecked="checked";
		 }
		 if((strESI_INR!=null)&&(strESI_INR.equals("P")))
		 {
		   PChecked="checked";
		 }
		 if((strESI_INR!=null)&&(strESI_INR.equals("N")))
		 {
		   NChecked="checked";
		 }
		 if((strTPL_INR_PSD!=null)&&(strTPL_INR_PSD.equals("M")))
		 {
		   MSel="selected";
		 }
		 if((strTPL_INR_PSD!=null)&&(strTPL_INR_PSD.equals("S")))
		 {
		   SSel="selected";
		 }
		 %>
    <tr> 
      <td width="14%" align="right" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Esito.intervento")%>&nbsp;</td>
      <td width="13%" align="left" valign="top"> 
        <input tabindex="3" class="checkbox" type="radio" name="ESI_INR" id="ESI_INR" value="D" <%=DChecked%>> 
        &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("DA.FARE")%>&nbsp;&nbsp;&nbsp;&nbsp;</td>
      <td width="13%" align="left" valign="top"> 
        <input tabindex="4" class="checkbox" type="radio" name="ESI_INR" id="radio2" value="P" <%=PChecked%>> 
        &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("POSITIVO")%>&nbsp;&nbsp;&nbsp;&nbsp;</td>
      <td width="13%" align="left" valign="top"> 
        <input tabindex="5" class="checkbox" type="radio" name="ESI_INR" id="radio" value="N" <%=NChecked%>> 
        &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("NEGATIVO")%></td>
      <td colspan="3" align="left" valign="top"></td>
    </tr>
    <tr> 
      <td width="14%" align="right" valign="top"><b><%=ApplicationConfigurator.LanguageManager.getString("Data.pianificata")%>&nbsp;</b></td>
      <td valign="top">
      <s2s:Date tabindex="6"  name="DAT_PIF_INR" id="DAT_PIF_INR" value="<%=strDAT_PIF_INR %>"/></td>
      <td width="15%" align="right" valign="top"><b><%=ApplicationConfigurator.LanguageManager.getString("Tipologia.intervento")%>&nbsp;</b></td>
      <td width="29%" valign="top"><select tabindex="7" name="TPL_INR_PSD" id="TPL_INR_PSD" style="width:100%">
          <option value=""></option>
          <option value="M" <%=MSel%>><%=ApplicationConfigurator.LanguageManager.getString("Manutenzione")%></option>
          <option value="S" <%=SSel%>><%=ApplicationConfigurator.LanguageManager.getString("Sostituzione")%></option>
        </select></td>
    </tr>
    <tr> 
      <td width="14%" align="right" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Data")%>&nbsp;</td>
      <td valign="top">
      <s2s:Date tabindex="8" name="DAT_INR" id="DAT_INR" value="<%=strDAT_INR%>"/></td>
      <td align="right" valign="top" width="15%" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Responsabile")%>&nbsp;</td>
      <td valign="top"><input tabindex="9" type="text"  style="width:100%" maxlength="100" name="NOM_RSP_INR" id="NOM_RSP_INR" value="<%=strNOM_RSP_INR%>"></td>
    </tr>
    <tr> 
      <td width="14%" align="right" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Attività.svolta")%>&nbsp;</td>
      <td colspan="103" valign="top"><input tabindex="10" style="width:100%" name="ATI_SVO" type="multitext" value="<%=Formatter.format(strATI_SVO)%>" ></td>
    </tr>
    <tr> 
      <td width="14%" align="right" valign="top" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Problemi.riscontrati")%>&nbsp;</td>
      <td colspan="103" valign="top"><input tabindex="11" style="width:100%" name="PBM_RSC" type="multitext" value="<%=Formatter.format(strPBM_RSC)%>" ></td>
    </tr>
  </table>	 
	 </fieldset></td></tr>
  </table>
 </td>
</tr>
<tr width="500px">

        <!-- <td colspan="100" width="100%"><div id="dContainer" style="" class="mainTabContainer" width="100%"></div></td> -->
		<td colspan="100" width="100%"><div id="dContainer" style="height:235px" class="mainTabContainer" ></div></td>
  </tr> 
</table>
</form>
<!-- /form for addind  -->

<iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
<%
//-------Loading of Tabs--------------------
if(SchedeInterventoPSD!=null)
{
%>
<script language="JavaScript" src="../_scripts/index.js"></script>
<script language="JavaScript">
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
	tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti.associati")%>", tabbar));
	
	//------adding tables to tabs-----------------------
	tabbar.idParentRecord = <%= new Long(strCOD_SCH_INR_PSD) %>;
	tabbar.refreshTabUrl="SCH_INR_PSD_Tabs.jsp";	
	tabbar.RefreshAllTabs();
	//-----activate first tab--------------------------
	tabbar.tabs[0].center.click();
	//----add action parameters to tabs
  tabbar.tabs[0].tabObj.actionParams ={
										"Feachures":ANA_DOC_Feachures,
											"AddNew":{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_SCH_INR_PSD/SCH_INR_PSD_Attach.jsp&ATTACH_SUBJECT=DOCUMENT", 
													"buttonIndex":0,
													"disabled": false
												  	},
										"Edit":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_SCH_INR_PSD/SCH_INR_PSD_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
													"buttonIndex":1,
													"disabled": false
										 			},
										 "Delete":	{"url":"../Form_SCH_INR_PSD/SCH_INR_PSD_Delete.jsp?LOCAL_MODE=d",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": false	
										 			}	
		  	
										}; 
</script>
<%}else{%>
<script>
window.dialogWidth="885px";
window.dialogHeight="330px";
</script>
<%}%>
<script type="text/javascript">
if (document.all("ID_PARENT").value!= "") {
   ToolBar.Return.setEnabled(false);
}
</script>
</body>
</html>
