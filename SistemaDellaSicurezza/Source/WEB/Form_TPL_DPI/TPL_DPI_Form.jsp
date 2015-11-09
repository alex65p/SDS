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
    <version number="1.0" date="27/01/2004" author="Treskina Maria">
	      <comments>
				  <comment date="27/01/2004" author="Treskina Maria">
				   <description>Shablon formi TPL_DPI_Form.jsp</description>
				  </comment>		
				  <comment date="21/01/2004" author="Treskina Maria">
				   <description>polychenie dannih TPL_DPI_Form.jsp</description>
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
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>
<%@ page import="com.apconsulting.luna.ejb.TipologiaDPI.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%//@ include file="TPL_DPI_Util.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuDPI,0) + "</title>");
</script>
  <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
	<link rel="stylesheet" href="../_styles/tabs.css">
	<script language="JavaScript" src="../_scripts/tabs.js"></script>
	<script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
</head>
<script>
window.dialogTop="5px";
window.dialogWidth="900px";
//window.dialogHeight="725px";
window.dialogHeight="755px";
</script>
<body>
<% 
	//   *require Fields*
	String strCOD_TPL_DPI="";	//1
	String strNOM_TPL_DPI="";				//2
	String strDES_CAR_DPI=""; 				//3
	
	//   *not requered fields
	String strMDL_PTR_UTI_DPI="";
	String strIMG_CSI_DPI=""; 
	String strCAG_DPI="";
	String strPER_MES_SST=""; 
	String strPER_MES_MNT="";
	
	AnagDocumentoFileInfo info=null;
        AnagDocumentoFileInfo infoLink=null;
	
IAnagrDocumento anagrDoc=null;
IAnagrDocumentoHome homeanagrDoc=(IAnagrDocumentoHome)PseudoContext.lookup("AnagrDocumentoBean"); 

	
ITipologiaDPI tipologiaDPI=null;
if( request.getParameter("ID")!=null)
{
		strCOD_TPL_DPI = request.getParameter("ID");
 	// editing of lottiDPI
	//getting of tipologiaDPI object
		ITipologiaDPIHome home=(ITipologiaDPIHome)PseudoContext.lookup("TipologiaDPIBean"); 
		Long tpl_dpi_id=new Long(strCOD_TPL_DPI);
		tipologiaDPI = home.findByPrimaryKey(tpl_dpi_id);
		// getting of object variables
		strNOM_TPL_DPI=tipologiaDPI.getNOM_TPL_DPI();
		strDES_CAR_DPI=tipologiaDPI.getDES_CAR_DPI();
		strMDL_PTR_UTI_DPI=tipologiaDPI.getMDL_PTR_UTI_DPI();
		strIMG_CSI_DPI=tipologiaDPI.getIMG_CSI_DPI();
		strCAG_DPI=Formatter.format(tipologiaDPI.getCAG_DPI());
		strPER_MES_SST=Formatter.format(tipologiaDPI.getPER_MES_SST());
		strPER_MES_MNT=Formatter.format(tipologiaDPI.getPER_MES_MNT());
		info=homeanagrDoc.getFileInfoU("TPL_DPI_TAB",new Long(strCOD_TPL_DPI).longValue());
                infoLink = homeanagrDoc.getFileInfoULink("TPL_DPI_TAB",new Long(strCOD_TPL_DPI).longValue());
}

%>

<form action="TPL_DPI_Set.jsp"  method="POST" target="ifrmWork" ENCTYPE="multipart/form-data">
<input name="SBM_MODE" type="Hidden" value="<%=(strCOD_TPL_DPI=="")?"new":"edt"%>">
<input type="hidden" name="TPL_DPI_ID" value="<%=strCOD_TPL_DPI%>">
<!-- <input type="hidden" name="COD_AZIENDA" value="<%//=lCOD_AZL%>">
<input type="hidden" name="COD_DIPENDENTE" value="<%//=lCOD_DPD %>"> -->


<table border="0" width='100%'>
<!-- posizione precedente della toolbar -->

<tr><td class="title" >
<script>
    document.write(getCompleteMenuPathFunction
        (SubMenuDPI,0,<%=request.getParameter("ID")%>));
</script>
</td></tr>
<tr>
<td>
        <table border="0"  width="100%">
            <tr>
                <!--inserimento toolbar -->
                <td colspan="9" align="left" > <table width="100%" border="0">
                    <tr> 
                        <!-- toolbar --> 
                        <!-- ############################ -->  		
                        <%@ include file="../_include/ToolBar.jsp" %>      
                        <%ToolBar.bCanDelete=(tipologiaDPI!=null);%>		
                        <%=ToolBar.build(3)%> 
                        <!-- ########################### -->
                </tr> </table>
                <fieldset>
                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Tipologia.D.P.I.")%></legend>
                    <table width="100%" border="0">
                        
                        <tr>
                            <!--fine  inserimento -->
		
                            <td width="20%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
                            <td width="80%" align="left"><input name="NOME" type="text" tabindex="1" value="<%=strNOM_TPL_DPI %>" size="145" maxlength="100"></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top"><b><%=ApplicationConfigurator.LanguageManager.getString("Caratteristica")%>&nbsp;</b></td>
                            <td align="left"><textarea tabindex="2" name="CARRATTERISTICA" rows="4" cols="80"><%=strDES_CAR_DPI%></textarea></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Modalità.particolare.d'utilizzo")%>&nbsp;</td>
                            <td align="left"><textarea tabindex="3" name="MODALITA" rows="3" cols="80"><%=strMDL_PTR_UTI_DPI%></textarea></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Impiego.consigliato")%>&nbsp;</td>
                            <td align="left"><textarea tabindex="4" name="IMPIEGO" rows="3" cols="80"><%=strIMG_CSI_DPI%></textarea></td>
                        </tr>
                        <tr>
                            <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Categoria")%>&nbsp;</td>
                            <td align="left"><input tabindex="5" type="text" name="CATEGORIA" size="7" value="<%=strCAG_DPI%>"></td>
                        </tr>
                        <tr>
                        
                        <td colspan=2>
                    </table>
                </fieldset>
                <fieldset>
                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Periodicità.mensile")%></legend>
                    <table width="100%" border="0">
                        <tr>
                            <td width="13%" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Sostituzione")%>&nbsp;</td>
                            <td width="10%" align="left">
                                <input tabindex="6" type="text" size="6" name="SOSTITUZIONE" value="<%=strPER_MES_SST%>">
                            </td>
                            <td width="12%" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Manutenzione")%>&nbsp;<td>
                            <td width="65%" align="left">
                                <input tabindex="7" type="text" size="6" name="MANUTENZIONE" value="<%=strPER_MES_MNT%>">
                            </td>
                        </tr>
                    </table>
                </fieldset>
                
            </tr>
<!-- 	upload	 -->
<!--tr-->
    <table width="100%" border="0">
        <tr>
            <td width="50%">
                <!-- Inizio modifica gestione link esterno documenti-->
                <fieldset>
                    <legend>
                        <%=ApplicationConfigurator.LanguageManager.getString("File")%>
                    </legend>	
                    <div style="height:60px;overflow:hidden;">
                        <table width=100% border="0">
                            <% if(info != null) {%>
                            <tr>
                                <td>
                                    <input tabindex="16" type="checkbox" name="ATTACHMENT_ACTION" value="delete" class=checkbox>
                                        <%=ApplicationConfigurator.LanguageManager.getString("Delete")%>&nbsp;
                                </td>
                                <td align="left">
                                    <a href="../_include/SHOW_File.jsp?ID=<%=strCOD_TPL_DPI%>&NOM_TAB=TPL_DPI_TAB&TYPE=FILE"><%=info.strName%></a>
                                </td>
                                <td>
                                    <%=ApplicationConfigurator.LanguageManager.getString("Dimensione.(KB)")%>:&nbsp;&nbsp;<%=Formatter.format((float)info.lSize/1024)%>
                                </td>
                                <td>
                                    <%=ApplicationConfigurator.LanguageManager.getString("Ultima.modifica")%>:&nbsp;&nbsp;<%=Formatter.format(info.dtModified)%>
                                </td>
                            </tr>
                            <%} else {%>
                            <tr>		
                                <td width=100% colspan=4>
                                    <input tabindex="17" name="ATTACHMENT_FILE" type="file" style="width:100%">
                                </td>
                            </tr>
                            <%}%>
                        </table>
                    </div>
                </fieldset>
            </td>
            <% 
                if (ApplicationConfigurator.isModuleEnabled(MODULES.DOC_LINK)){
                    out.println("<td width=\"50%\">");
                } else {
                    out.println("<td width=\"50%\" style=\"display:none\">");
                }
            %>
                <fieldset>
                    <legend>
                        <%=ApplicationConfigurator.LanguageManager.getString("File.link")%>
                    </legend>		
                    <div style="height:60px;overflow:hidden;">
                        <table width=100% border="0">
                            <% if(infoLink != null) {%>
                            <tr>
                                <td>
                                    <input tabindex="16" type="checkbox" name="ATTACHMENT_ACTION_LINK" value="delete" class=checkbox>
                                        <%=ApplicationConfigurator.LanguageManager.getString("Delete")%>&nbsp;
                                </td>
                                <td align="left">
                                    <!--a href="../_include/SHOW_File.jsp?ID=<%=strCOD_TPL_DPI%>&NOM_TAB=TPL_DPI_TAB&TYPE=FILE_LINK"><%=infoLink.strName%></a-->
                                    <a href="file:///<%=infoLink.strLinkDocument%>" target="_blank"><%=infoLink.strName%></a>
                                </td>
                                <td>
                                    <%=ApplicationConfigurator.LanguageManager.getString("Dimensione.(KB)")%>:&nbsp;&nbsp;<%=Formatter.format((float)infoLink.lSize/1024)%>
                                </td>
                                <td>
                                    <%=ApplicationConfigurator.LanguageManager.getString("Ultima.modifica")%>:&nbsp;&nbsp;<%=Formatter.format(infoLink.dtModified)%>
                                </td>
                            </tr>
                            <%} else {%>
                            <tr>		
                                <td width=100% colspan=4>
                                    <input tabindex="17" name="ATTACHMENT_FILE_LINK" type="file" style="width:100%">
                                </td>
                            </tr>
                            <%}%>
                        </table>
                    </div>
                </fieldset>
                <!-- Fine modifica gestione link esterno documenti-->
            </td>
        </tr>
    </table>
<!--/tr--> 
<!-- 	upload	 -->

	</table>
<table width="100%">
	<tr>
		<td><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
	</tr>
</table>
</td>
</tr>
</table>

</form>
   <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
<%
//-------Loading of Tabs--------------------
if(tipologiaDPI!=null)
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
	tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Normative")%>", tabbar));
	tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti")%>", tabbar));
	tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Lotti")%>", tabbar));
	
	//------adding tables to tabs-----------------------
	tabbar.idParentRecord = <%= new Long(strCOD_TPL_DPI) %>;
	tabbar.refreshTabUrl="TPL_DPI_Tabs.jsp";	
	tabbar.RefreshAllTabs();
	//-----activate first tab--------------------------
	tabbar.tabs[0].center.click();
	//----add action parameters to tabs
	tabbar.tabs[0].tabObj.actionParams ={
										"Feachures":ANA_NOR_SEN_Feachures,
											"AddNew":{"url":"../Form_ANA_NOR_SEN/ANA_NOR_SEN_Form.jsp?ATTACH_URL=Form_TPL_DPI/TPL_DPI_Attach.jsp&ATTACH_SUBJECT=NORSEN", 
													"buttonIndex":0,
													"disabled": false
												  	},
										"Edit":	{"url":"../Form_ANA_NOR_SEN/ANA_NOR_SEN_Form.jsp?ATTACH_URL=Form_TPL_DPI/TPL_DPI_Attach.jsp&ATTACH_SUBJECT=NORSEN",
													"buttonIndex":1,
													"disabled": false
										 			},
										 "Delete":	{"url":"../Form_TPL_DPI/TPL_DPI_Delete.jsp?LOCAL_MODE=ns",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": false	
										 			}	
		  	
										}; 
	
  tabbar.tabs[1].tabObj.actionParams ={
										"Feachures":ANA_DOC_Feachures,
											"AddNew":{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_TPL_DPI/TPL_DPI_Attach.jsp&ATTACH_SUBJECT=DOCUMENT", 
													"buttonIndex":0,
													"disabled": false
												  	},
										"Edit":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_TPL_DPI/TPL_DPI_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
													"buttonIndex":1,
													"disabled": false
										 			},
										 "Delete":	{"url":"../Form_TPL_DPI/TPL_DPI_Delete.jsp?LOCAL_MODE=d",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": false	
										 			}	
		  	
										}; 
  tabbar.tabs[2].tabObj.actionParams ={
										"Feachures":ANA_LOT_DPI_Feachures,
											"AddNew":{"url":"../Form_ANA_LOT_DPI/ANA_LOT_DPI_Form.jsp?ATTACH_URL=Form_TPL_DPI/TPL_DPI_Attach.jsp&ATTACH_SUBJECT=LOTDPI&PARENT=tipologia", 
													"buttonIndex":0,
													"disabled": false
												  	},
										"Edit":	{"url":"../Form_ANA_LOT_DPI/ANA_LOT_DPI_Form.jsp?ATTACH_URL=Form_TPL_DPI/TPL_DPI_Attach.jsp&ATTACH_SUBJECT=LOTDPI&PARENT=tipologia",
													"buttonIndex":1,
													"disabled": false
										 			},
										 "Delete":	{"url":"../Form_TPL_DPI/TPL_DPI_Delete.jsp?LOCAL_MODE=l",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": false	
										 			}	
		  	
										}; 


</script>
<%}else{%>
<script>
window.dialogWidth="900px";
//window.dialogHeight="480px";
window.dialogHeight="580px";
</script>
<%}%>
</body>
</html>
