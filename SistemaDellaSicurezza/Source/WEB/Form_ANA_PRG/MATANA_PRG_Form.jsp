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
    <version number="1.0" date="06/02/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="06/02/2004" author="Khomenko Juliya">
				   <description>Shablon formi ANA_PRG_Form.jsp</description>
				  </comment>		
				  <comment date="17/02/2004" author="Mike Kondratyuk">
				   <description>ComboBox v DIV</description>
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
<%@ page import="com.apconsulting.luna.ejb.SchedeParagrafo.*" %>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.GestioniSezioni.*" %>
<%@ page import="com.apconsulting.luna.ejb.Capitoli.*" %>
<%@ page import="com.apconsulting.luna.ejb.Paragrafo.*" %>
<%@ page import="com.apconsulting.luna.ejb.GestioneTabellare.*" %>
<%@ page import="com.apconsulting.luna.ejb.Collegamenti.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="ANA_PRG_Util.jsp" %>
<script language="JavaScript" type="text/javascript" src="ANA_PRG_Script.js"></script>
<html>
<head>
<title><%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.paragrafi")%></title>
  <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
	<link rel="stylesheet" href="../_styles/tabs.css">
	<script language="JavaScript" src="../_scripts/tabs.js"></script>
	<script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
</head>
<body>

<%
	long			  lCOD_PRG = 0;			    //1 
	String			strNOM_PRG = "";			//2
	String			strDES_PRG = "";			//3
	long			  lCOD_ARE = 0;			    //4
	long			  lCOD_AZL = Security.getAzienda();			    //5
	long			  lCOD_CPL = 0;			    //6
	String			strNOM_CPL = "";
	long        lPRIORITY = 0;
	
	IParagrafo Paragrafo=null;
	IParagrafoHome home=(IParagrafoHome)PseudoContext.lookup("ParagrafoBean");
	IGestioniSezioniHome GestioniSezioniHome = (IGestioniSezioniHome)PseudoContext.lookup("GestioniSezioniBean");
	Long cod_id_parent = null;
	if(request.getParameter("ID_PARENT")!=null)
	{
		cod_id_parent=new Long(request.getParameter("ID_PARENT"));
		IGestioniSezioni bean = GestioniSezioniHome.findByPrimaryKey(cod_id_parent);

   	lCOD_ARE = cod_id_parent.longValue();
       lCOD_AZL = bean.getCOD_AZL();
   }
	if(request.getParameter("COD_CPL")!=null)
	{
		Long cod_cpl=new Long(request.getParameter("COD_CPL"));
   	lCOD_CPL = cod_cpl.longValue();
   }
	if(request.getParameter("ID")!=null)
	{
		String strCOD_PRG = request.getParameter("ID");


		Long cod_id=new Long(strCOD_PRG);
		Paragrafo = home.findByPrimaryKey(cod_id);

		lCOD_PRG = cod_id.longValue(); 						    //1
		strNOM_PRG = Paragrafo.getNOM_PRG();					//2
		strDES_PRG = Paragrafo.getDES_PRG();					//3
		lCOD_ARE = Paragrafo.getCOD_ARE();						//4
		lCOD_AZL = Paragrafo.getCOD_AZL();						//5
		lCOD_CPL = Paragrafo.getCOD_CPL();						//6
		lPRIORITY= Paragrafo.getPRIORITY();

		ICapitoli capitoli=null;
		ICapitoliHome CapitoliHome=(ICapitoliHome)PseudoContext.lookup("CapitoliBean");

		Long cpl_id=new Long(lCOD_CPL);
		capitoli = CapitoliHome.findByPrimaryKey(cpl_id);
		strNOM_CPL= capitoli.getNOM_CPL();

	}
	
	IAzienda azienda=null;
	IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");

	Long azl_id=new Long(lCOD_AZL);
	azienda = AziendaHome.findByPrimaryKey(azl_id);
	String	strRAG_SCL_AZL= azienda.getRAG_SCL_AZL();
	
	boolean bShowSchede=false;
	
	if(Security.getCurrentDvrUniOrg()!=null){
		try{
			IUnitaOrganizzativaHome home_uni=(IUnitaOrganizzativaHome)PseudoContext.lookup("UnitaOrganizzativaBean");
			IUnitaOrganizzativa bean_uni=home_uni.findByPrimaryKey(Security.getCurrentDvrUniOrg());
			strRAG_SCL_AZL+=", "+ bean_uni.getNOM_UNI_ORG();
			bShowSchede=true;
		}
		catch(Exception ex){
			//throw ex;
		}
	}
%>
<script type="text/javascript">
<!--
var hasParent = <%=(request.getParameter("ID_PARENT")!=null)%>;
// -->
</script>

<!-- form for addind  Paragrafo-->
<form action="ANA_PRG_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="Hidden" value="<%=(lCOD_PRG==0)?"new":"edt"%>">
<input type="hidden" name="PRG_ID" value="<%=lCOD_PRG%>">
<input type="hidden" name="COD_AZL" value="<%=lCOD_AZL%>">

<table width="100%" border="0">
<!-- ############################ -->  		
<%@ include file="../_include/ToolBar.jsp" %>      
<%ToolBar.bCanDelete=(Paragrafo!=null);
ToolBar.bShowPrint=false;
ToolBar.bShowSearch=(request.getParameter("ID_PARENT")==null);
ToolBar.bShowReturn=(request.getParameter("ID_PARENT")!=null);
%>
<%=ToolBar.build(2)%> 
<!-- ########################### --> 
<tr>
 <td valign="top">
  <table  width="100%">
  <tr><td class="title"><%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.paragrafi")%></td></tr>
  <tr>
	<td>
  <fieldset>
   <table  width="100%" border="0">
   <tr>
   <td align="right" width="10%"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
	 <td ><input size="105" maxlength="50" type="text" name="" value="<%=strRAG_SCL_AZL%>" readonly>
   </td></tr>
   </table>	 
	 </fieldset>
	</td></tr>
  <tr><td>
  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.paragrafo")%></legend>
   <table  width="100%" border="0">
   <tr><td colspan="2">
   <fieldset>
   <table  width="100%" border="0">
     <tr><td align="right" width="12%"><b><%=ApplicationConfigurator.LanguageManager.getString("Sezione")%>&nbsp;</b></td>
	   <td>&nbsp;
<%
String hid;
if(request.getParameter("ID_PARENT")!=null)
{
	out.print("<input type=\"hidden\" name=\"COD_ARE\" value="+lCOD_ARE+">");
	hid = "disabled";
}
else
{
	hid = "name=\"COD_ARE\" id=\"COD_ARE\" onchange=\"changeFields();\"";
}
%>      
		 <select tabindex="1" <%=hid%> style="width:556">
	    	<option value=""></option>
   	    <%=BuildSezioneComboBox(GestioniSezioniHome, lCOD_ARE, lCOD_AZL)%>
		 </select></td></tr>
     <tr><td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Capitolo")%>&nbsp;</b></td>
	   <td>&nbsp;
<%
if(request.getParameter("ID_PARENT")!=null)
{
	out.print("<input type=\"hidden\" name=\"COD_CPL\" value="+lCOD_CPL+">");
}
%>
	    <div id="sel" style="width:556;margin:-15 0 0 8;"><select tabindex="2" id="CAPITOLO" name="COD_CPL" style="width:556">
       	<option value="0"></option>
       </select></div>
   </table>	 
	 </fieldset>
	 </td></tr>
   <tr>
   <td align="right" width="13%"><b><%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>&nbsp;</b></td>
	 <td><input tabindex="3" size="105" maxlength="50" type="text" name="TITOLO" value="<%=strNOM_PRG%>">
   </td></tr>
	 <tr><td valign="top" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
	 <td><textarea tabindex="4" rows="5" cols="107" name="DESC"><%=Formatter.format(strDES_PRG)%></textarea>
   </td></tr>
<% if (cod_id_parent != null){ %>
	 <tr><td valign="top" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Priorità")%>&nbsp;</td>
	     <td><input tabindex="5" name="PRIORITY" value="<%=Formatter.format(lPRIORITY)%>" /></td>
	 </tr>
<% }%>
   </table>	 
	 </fieldset>
	</td></tr>
	 <tr>
	   <td><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
   </tr>	
  </table>
 </td>
</tr>  
</table>
</form>

<!-- /form for addind  Paragrafo-->
   <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" src="ANA_PRG_UtilFind.jsp?ID=<%=lCOD_ARE%>&AZL=<%=lCOD_AZL%>&SEL=<%=lCOD_CPL%>&PAR=<%=(request.getParameter("ID_PARENT")!=null)%>"></iframe>
<script type="text/javascript">
<!--
changeFields();
// -->
</script>
<%
//-------Loading of Tabs--------------------
if(Paragrafo!=null)
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
	tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti")%>", tabbar));
	tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Collegamenti.internet")%>", tabbar));
	tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Schede.dei.paragrafi")%>", tabbar));
	tabbar.addTab(new Tab("tab4", "<%=ApplicationConfigurator.LanguageManager.getString("Tabelle")%>", tabbar));
	
	//------adding dinamic tables to tabs-----------------------
	tabbar.idParentRecord = <%= lCOD_PRG%>;
	tabbar.refreshTabUrl="ANA_PRG_Tabs.jsp";	
	tabbar.RefreshAllTabs();

	//----add action parameters to tabs
	tabbar.tabs[0].tabObj.actionParams ={"AddNew":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_PRG/ANA_PRG_Attach.jsp&ATTACH_SUBJECT=DOC", 
													"buttonIndex":0
												  	},
										 "Delete":	{"url":"../Form_ANA_PRG/ANA_PRG_Delete.jsp?LOCAL_MODE=DOC",
													"buttonIndex":2,
													"target_element":document.all["ifrmWork"]
										 			},		
										 "Edit":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_PRG/ANA_PRG_Attach.jsp&ATTACH_SUBJECT=DOC",
													"buttonIndex":1
										 			},
										 "Feachures": ANA_DOC_Feachures
										};  
						
	tabbar.tabs[1].tabObj.actionParams ={"AddNew":	{"url":"../Form_COL_INT_PRG/COL_INT_PRG_Form.jsp?ATTACH_URL=Form_ANA_PRG/ANA_PRG_Attach.jsp&ATTACH_SUBJECT=INT", 
													"buttonIndex":0
												  },
										 "Delete":	{"url":"../Form_COL_INT_PRG/COL_INT_PRG_Delete.jsp?LOCAL_MODE=INT",
													"buttonIndex":2,
													"target_element":document.all["ifrmWork"]
										 			},		
										 "Edit":	{"url":"../Form_COL_INT_PRG/COL_INT_PRG_Form.jsp?ATTACH_URL=Form_ANA_PRG/ANA_PRG_Attach.jsp&ATTACH_SUBJECT=INT",
													"buttonIndex":1
										 			},
										 "Feachures": COL_INT_PRG_Feachures
										}; 
										
   
	tabbar.tabs[2].tabObj.actionParams ={"AddNew":	
													{"url":"../Form_ANA_SCH_PRG/ANA_SCH_PRG_Form.jsp?ATTACH_URL=Form_ANA_PRG/ANA_PRG_Attach.jsp&ATTACH_SUBJECT=SCHPAR", 
													"buttonIndex":0
												  	},
										 "Delete":	
										      {"url":"../Form_ANA_SCH_PRG/ANA_SCH_PRG_Delete.jsp?LOCAL_MODE=SCHPAR",
													"buttonIndex":2,
													"target_element":document.all["ifrmWork"]
										 			},		
										 "Edit":	
										      {"url":"../Form_ANA_SCH_PRG/ANA_SCH_PRG_Form.jsp?ATTACH_URL=Form_ANA_PRG/ANA_PRG_Attach.jsp&ATTACH_SUBJECT=SCHPAR",
													"buttonIndex":1
										 			},
										 "Feachures": ANA_SCH_PRG_Feachures
										};   
	
	tabbar.tabs[3].tabObj.actionParams ={"AddNew":	{"url":"../Form_ANA_TAB_UTN/ANA_TAB_UTN_Form.jsp?ATTACH_URL=Form_ANA_PRG/ANA_PRG_Attach.jsp&ATTACH_SUBJECT=TAB", 
													"buttonIndex":0
												  },
										 "Delete":	{"url":"../Form_ANA_TAB_UTN/ANA_TAB_UTN_Delete.jsp?PAR=1&LOCAL_MODE=TAB",
													"buttonIndex":2,
													"target_element":document.all["ifrmWork"]
										 			},		
										 "Edit":	{"url":"../Form_ANA_TAB_UTN/ANA_TAB_UTN_Form.jsp?ATTACH_URL=Form_ANA_PRG/ANA_PRG_Attach.jsp&ATTACH_SUBJECT=TAB",
													"buttonIndex":1
										 			},
										 "Feachures": ANA_TAB_UTN_Feachures
										}; 

	//-----activate first tab--------------------------
	tabbar.tabs[0].center.click(); 

</script>
<%}%>
</body>

</html>
