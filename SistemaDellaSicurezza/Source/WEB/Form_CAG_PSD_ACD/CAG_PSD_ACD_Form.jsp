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
    <version number="1.0" date="25/01/2004" author="Podmasteriev Alexandr">
	      <comments>
				  <comment date="25/01/2004" author="Podmasteriev Alexandr">
				   <description>Shablon formi CAG_PSD_ACD_Form.jsp</description>
				 </comment>		
				  <comment date="28/02/2004" author="Alexey Kolesnik">
				   <description> Rebuild for dynamic tabbars </description>
				 	</comment>	
					<comment date="29/03/2004" author="Treskina Mary">
				   <description> Izmanila tip PER_MES_SST, PER_MES_MNT na string(dla korrektnoj raboti searc) </description>
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
<%@ page import="com.apconsulting.luna.ejb.CategoriePreside.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="CAG_PSD_ACD_Util.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuPresidi,0) + "</title>");
</script>
<link rel="stylesheet" href="../_styles/style.css">
<link rel="stylesheet" href="../_styles/tabs.css">
<script language="JavaScript" src="../_scripts/tabs.js"></script>
<script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>

</head>
<script>
window.dialogWidth="740px";
window.dialogHeight="530px";
</script>
<body>
<% 
	//   *require Fields*
	String strNOM_CAG_PSD_ACD=""; //nom_cag_psd_acd
  String iCOD_CAG_PSD_ACD="";   //cod_cag_psd_acd
	
	//   *Not require Fields*
	String strDES_CAG_PSD_ACD="";   //des_cag_psd_acd
	String strPER_MES_SST="";            //per_mes_sst
	String strPER_MES_MNT="";            //per_mes_mnt
  //long iPER_MES_SST=0;            //per_mes_sst
	//long iPER_MES_MNT=0;            //per_mes_mnt
  ICategoriePreside CategoriePreside=null;
if( request.getParameter("ID")!=null)
{
  	iCOD_CAG_PSD_ACD = request.getParameter("ID");
	// editing of CategoriePreside
	//getting of CategoriePreside object
	
		ICategoriePresideHome home=(ICategoriePresideHome)PseudoContext.lookup("CategoriePresideBean"); 
		Long for_id=new Long(iCOD_CAG_PSD_ACD);
		CategoriePreside = home.findByPrimaryKey(for_id);
		// getting of object variables
		strNOM_CAG_PSD_ACD=CategoriePreside.getNOM_CAG_PSD_ACD();//good
		strDES_CAG_PSD_ACD=CategoriePreside.getDES_CAG_PSD_ACD();//good
		strPER_MES_SST=Formatter.format(CategoriePreside.getPER_MES_SST());
		strPER_MES_MNT=Formatter.format(CategoriePreside.getPER_MES_MNT());
		//--- 

}

%>
<!-- form for addind azienda --> 
<form action="CAG_PSD_ACD_Set.jsp?par=add" method="POST" target="ifrmWork">
<table width="100%" border="0">
<tr>
 <td valign="top">
  <table  width="100%">
  <tr>
		<td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuPresidi,0,<%=request.getParameter("ID")%>));
    </script>      
<input name="SBM_MODE" type="Hidden" value="<%if(iCOD_CAG_PSD_ACD==""){out.print("new");}else{out.print("edt");}%>">
<input name="FOR_ID" type="Hidden" value="<%=iCOD_CAG_PSD_ACD%>">

		</td>
	</tr>
  <tr>
  <td>
  <table width="100%">
  <!-- ############################ -->
  <%@ include file="../_include/ToolBar.jsp" %>
  <%ToolBar.bCanDelete=(CategoriePreside!=null);
  ToolBar.strPrintUrl="RegistroAntincendio.jsp?";%>	
  <%=ToolBar.build(2)%> 
  <!-- ########################### -->
  </table>
  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Categoria.presidio")%></legend>
   <table  width="100%" border="0" align="right">
	 		<tr>
                        <td align="right" width="20%" ><b><%=ApplicationConfigurator.LanguageManager.getString("Nome.categoria")%>&nbsp;</b></td>
                        <td>
             <input  align="left" tabindex="1" size="50" maxlength="30" type="text" name="NOM" value="<%=strNOM_CAG_PSD_ACD%>"></td>
	    </tr>
                        <td align="right">
                        <%=ApplicationConfigurator.LanguageManager.getString("Periodicità.manutenzione")%>&nbsp;</td>
                            <td>
                                <input tabindex="2" size="2" type="text" name="MNT" value="<%=strPER_MES_MNT%>">
                                &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("mesi")%>
                                
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <%=ApplicationConfigurator.LanguageManager.getString("Periodicità.sostituzione")%>&nbsp;<input tabindex="3" size="2" type="text" name="SST" value="<%=strPER_MES_SST%>">
                        &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("mesi")%></td>			</td>
			<tr>
					
			<td valign="top" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
			<td width="87%" align="right"><textarea tabindex="4" cols="80" name="DES" rows="4"><%=strDES_CAG_PSD_ACD%></textarea></td>
		
			
			</tr>
   </table>
	</fieldset> 
	</td> 
	</tr>
<tr>
	<td><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
</tr> 
</table>

    </form>

<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>

<%
//-------Loading of Tabs--------------------


if(CategoriePreside!=null)
{
/*
	String s="";
	long lCOD_AZL = Security.getAzienda();
  ICategoriePresideHome resronsabiliti_home =(ICategoriePresideHome)PseudoContext.lookup("CategoriePresideBean");
	s=BuildResTab(resronsabiliti_home, lCOD_AZL, iCOD_CAG_PSD_ACD);
	out.print(s);
*/
// -----------------------------------------
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
	tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Responsabili.categoria")%>", tabbar));
	
	//------adding tables to tabs-----------------------
	tabbar.idParentRecord = <%= iCOD_CAG_PSD_ACD %>;
	tabbar.refreshTabUrl="CAG_PSD_ACD_Tabs.jsp";	
	tabbar.RefreshAllTabs();

	//----add action parameters to tabs
	tabbar.tabs[0].tabObj.actionParams ={
										 "Feachures":{
														"dialogWidth":"500px", 
													  "dialogHeight":"200px"
													},
										 "AddNew":	{"url":"../Form_RSP_CAG_PSD_ACD/RSP_CAG_PSD_ACD_Form.jsp?ATTACH_URL=Form_RSP_CAG_PSD_ACD/RSP_CAG_PSD_ACD_Set.jsp",
													"buttonIndex":0
												  	},
										 "Edit":	  {"url":"../Form_RSP_CAG_PSD_ACD/RSP_CAG_PSD_ACD_Form.jsp?ATTACH_URL=Form_RSP_CAG_PSD_ACD/RSP_CAG_PSD_ACD_Set.jsp",
													"buttonIndex":1
										 			},		
		  	
										 "Delete":	{"url":"../Form_RSP_CAG_PSD_ACD/RSP_CAG_PSD_ACD_Delete.jsp?LOCAL_MODE=tab",
													"buttonIndex":2, 
													"target_element":document.all["ifrmWork"]
													}
										}; 
	
</script>
<%}else{%>
<script>
window.dialogWidth="740px";
window.dialogHeight="300px";
</script>
<%}%>


<!-- /form for addind azienda -->


</body>
</html>
