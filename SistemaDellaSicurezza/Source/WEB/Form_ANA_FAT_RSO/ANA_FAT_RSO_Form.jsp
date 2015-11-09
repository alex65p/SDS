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
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>
<%@ page import="com.apconsulting.luna.ejb.IndirizzoPostaElettronica.*" %>
<%@ page import="com.apconsulting.luna.ejb.CollegamentoInternet.*" %>
<%@ page import="com.apconsulting.luna.ejb.CategorieFattoreRischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.RischioFattore.*" %>
<%@ page import="com.apconsulting.luna.ejb.NormativeSentenze.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="ANA_FAT_RSO_Util.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuRischi,1) + "</title>");
</script>
  <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
	<link rel="stylesheet" href="../_styles/tabs.css">
	<script language="JavaScript" src="../_scripts/tabs.js"></script>
	<script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>

</head>
<script>
//alert(window.dialogWidth+" x "+window.dialogHeight);
window.dialogWidth="780px";
window.dialogHeight="600px";
</script>
<body>
<%   
	//   *require Fields*
	String strCOD_FAT_RSO="";
	String strNOM_FAT_RSO="";
  	String strNUM_FAT_RSO="";
	//   *Not require Fields*
  	String strDES_FAT_RSO="";
	//--CAG_FAT_RSO_TAB fields
  	String strCOD_CAG_FAT_RSO="";
	String strNOM_CAG_FAT_RSO="";
	//--ANA_NOR_SEN_TAB fields
	String strCOD_NOR_SEN="";
	String strTIT_NOR_SEN="";
	String strDAT_NOR_SEN="";
	//--vse
	
IRischioFattore fr=null;
INormativeSentenze norsen=null;
INormativeSentenzeHome nhome=(INormativeSentenzeHome)PseudoContext.lookup("NormativeSentenzeBean");
IAnagrDocumento anadoc=null;
IAnagrDocumentoHome dhome=(IAnagrDocumentoHome)PseudoContext.lookup("AnagrDocumentoBean");

if( request.getParameter("ID")!=null){
		strCOD_FAT_RSO = request.getParameter("ID");
		IRischioFattoreHome home=(IRischioFattoreHome)PseudoContext.lookup("RischioFattoreBean");
		Long lCOD_FAT_RSO=new Long(strCOD_FAT_RSO);
		fr = home.findByPrimaryKey(lCOD_FAT_RSO);
		// getting of object variables
		strNOM_FAT_RSO=Formatter.format(fr.getNOM_FAT_RSO());
		strNUM_FAT_RSO=Formatter.format(fr.getNUM_FAT_RSO());
		strCOD_CAG_FAT_RSO=Formatter.format(fr.getCOD_CAG_FAT_RSO());
		strDES_FAT_RSO=Formatter.format(fr.getDES_FAT_RSO());
		strCOD_NOR_SEN=Formatter.format(fr.getCOD_NOR_SEN());
		//out.print("strCOD_NOR_SEN: "+strCOD_NOR_SEN);
		//if (true) return;
		//---ANA_NOR_SEN_TAB
		if (!strCOD_NOR_SEN.equals("0")){
			Long lCOD_NOR_SEN=new Long(strCOD_NOR_SEN);
			norsen = nhome.findByPrimaryKey(lCOD_NOR_SEN);
			strTIT_NOR_SEN=Formatter.format(norsen.getTIT_NOR_SEN());
			strDAT_NOR_SEN=Formatter.format(norsen.getDAT_NOR_SEN());
		}
}
%>

<!-- form for addind  FattoriRischo-->
<form action="ANA_FAT_RSO_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="Hidden" value="<%=(strCOD_FAT_RSO.equals(""))?"new":"edt"%>">
<input type="hidden" name="COD_FAT_RSO" value="<%=strCOD_FAT_RSO%>">
  <table  width="100%" border="0" >
  <tr><td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuRischi,1,<%=request.getParameter("ID")%>));
    </script>
  </td></tr>
  <tr><td>
 			<table width="100%" border="0">
 				 <%@ include file="../_include/ToolBar.jsp" %>
 	 			 <%
  					ToolBar.bCanDelete=(fr!=null);
  					ToolBar.strPrintUrl="SchedaFattoreRischio.jsp?";
  				 %>
  				 <%=ToolBar.build(2)%>
			</table>
  <tr><td valign="top">
  <fieldset>
  <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.anagrafica.fattore.di.rischio")%></legend>
	    <table width="100%" align="center" cellspacing="3">
          <tr> 
            <td align="right" width="15%"> <div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome.fattore.di.rischio")%>&nbsp;</b></div></td>
            <td width="35%">
<input tabindex="1" style="width:100%;" type="text" name="NOM_FAT_RSO" maxlength="50" value="<%=strNOM_FAT_RSO%>">
            </td>
            <td width="15%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("N.Fatt.Rischio")%>&nbsp;</b> </td>
            <td width="10%">
<input tabindex="2" style="width:70%;" type="text" name="NUM_FAT_RSO" value="<%=strNUM_FAT_RSO%>">
            </td>
          </tr>
          <tr> 
            <td align="right" width="197"><div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome.categoria")%>&nbsp;</b></div></td>
            <td colspan="4"> <select tabindex="3" style="width:59%;" name="NOM_CAG_FAT_RSO">
                <option value=''></option>
                <%    ICategorioRischioHome crhome=(ICategorioRischioHome)PseudoContext.lookup("CategorioRischioBean");
      Collection crcol = crhome.getCategorioRischio_Name_Address_View();
      if(strCOD_CAG_FAT_RSO.equals("")){strCOD_CAG_FAT_RSO="0";}
			String cag_fat_rso=BuildCategorioRischioComboBox(crcol,strCOD_CAG_FAT_RSO);
			out.print(cag_fat_rso);
%>
              </select> </td>
          </tr>
          <tr align="center"> 
            <td align="center" colspan="6"> <fieldset>
              <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.normativa.di.riferimento")%></legend>
              <table width="100%" border="0">
                <tr align="left"> 
                  <td width="22%">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.normativa")%>&nbsp;</td>
                  <td width="78%"><%=ApplicationConfigurator.LanguageManager.getString("Titolo.normativa")%>&nbsp;</td>
                </tr>
                <input tabindex="4" type="hidden" name="COD_NOR_SEN" id="COD_NOR_SEN" value="<%=strCOD_NOR_SEN%>">
                <tr> 
                  <td colspan="2"> <select tabindex="5" style="width:100%;" id="TIT_NOR_SEN" onchange="document.all['COD_NOR_SEN'].value=document.all['TIT_NOR_SEN'].value;">
                      <option value=''></option>
                      <% String str="";
 java.util.Collection ncol = nhome.findAll();
 java.util.Iterator it = ncol.iterator();
 int iCount=0;
 while(it.hasNext()){
   Long i=(Long)it.next();
   norsen = nhome.findByPrimaryKey(i);
	  String selstr="";
		String str1=Formatter.format(norsen.getCOD_NOR_SEN());
		String str2=Formatter.format(norsen.getDAT_NOR_SEN());
		String str3=Formatter.format(norsen.getTIT_NOR_SEN());
		if(strCOD_NOR_SEN.equals(str1))selstr="selected";
		str=str+"<option "+selstr+" value=\""+str1+"\">"+str2
		  +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
                  "|" +
                  "&nbsp;&nbsp;&nbsp;"
			+str3+"</option>";
 }
 out.print(str);
%>
                    </select> </td>
                </tr>
              </table>
              </fieldset></td>
          </tr>
          <tr> 
            <td align="right" width="15%" valign="top">
                <div align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</div></td>
            <td colspan="4"><textarea style="width:100%;" tabindex="6" rows="5" cols="100" name="DES_FAT_RSO"><%=strDES_FAT_RSO%></textarea></td>
          </tr>
        </table>
	</fieldset> 
	</td></tr>
	</tr>
  <tr><td colspan="100%" align="center"><div id="dContainer" class="mainTabContainer" style="width:750px"></div></td></tr>
  </table>
 </td>
</table>
</form>
<!-- /form for addind  FattoriRischo-->
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
<%if(fr!=null){%>
<script language="JavaScript" src="../_scripts/index.js"></script>
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
	var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
	var btnBar = new ButtonPanel("batPanel1", btnParams);
	tabbar.addButtonBar(btnBar);
	tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Collegamenti.internet")%>", tabbar));
	tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Indirizzi.di.posta.elettronica")%>", tabbar));
	tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti")%>", tabbar));
	//------adding tables to tabs-----------------------
	tabbar.idParentRecord = <%=strCOD_FAT_RSO%>;
	tabbar.refreshTabUrl="ANA_FAT_RSO_Tabs.jsp";	
	tabbar.RefreshAllTabs();
	//-----activate first tab--------------------------
	tabbar.tabs[0].center.click();
	//----add action parameters to tabs
	tabbar.tabs[0].tabObj.actionParams ={
	                   "AddNew":	{"url":"../Form_COL_INT/COL_INT_Form.jsp",
	                        "buttonIndex":0, 
													"disabled": false
												  	},
										 "Delete":	{"url":"../Form_COL_INT/COL_INT_Delete.jsp",
	                        "buttonIndex":2,
													"target_element":document.all["ifrmWork"],
													"disabled": false
										 			},
										 "Edit":	{"url":"../Form_COL_INT/COL_INT_Form.jsp",
	                        "buttonIndex":1, 
													"disabled": false
										 			},
										"Feachures":COL_INT_Feachures
										};
	tabbar.tabs[1].tabObj.actionParams ={
	                   "AddNew":	{"url":"../Form_IDZ_PSA_ELT/IDZ_PSA_ELT_Form.jsp",
	                        "buttonIndex":0, 
													"disabled": false
												  },
										 "Delete":	{"url":"../Form_IDZ_PSA_ELT/IDZ_PSA_ELT_Delete.jsp",
	                        "buttonIndex":2, 
													"target_element":document.all["ifrmWork"],
													"disabled": false
										 			},
										 "Edit":	{"url":"../Form_IDZ_PSA_ELT/IDZ_PSA_ELT_Form.jsp",
	                        "buttonIndex":1, 
													"disabled": false
										 			},
										"Feachures":IDZ_PSA_ELT_Feachures
										};
	tabbar.tabs[2].tabObj.actionParams ={
	                   "AddNew":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_FAT_RSO/ANA_FAT_RSO_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
	                        "buttonIndex":0,
													"disabled": false
												  	},
										 "Delete":	{"url":"../Form_ANA_FAT_RSO/ANA_FAT_RSO_Delete.jsp?LOCAL_MODE=doc",
	                        "buttonIndex":2,
													"target_element":document.all["ifrmWork"],
													"disabled": false
										 			},
										 "Edit":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp",
	                        "buttonIndex":1, 
													"disabled": false
										 			},
										 "Feachures":ANA_DOC_Feachures
										};
</script>
<%}else{%>
<script>
window.dialogWidth="780px";
window.dialogHeight="350px";
</script>
<%}%>
</body>
</html>
