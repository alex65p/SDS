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
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.LottiDPI.*" %>
<%@ page import="com.apconsulting.luna.ejb.Nazionalita.*" %>
<%@ page import="com.apconsulting.luna.ejb.Fornitore.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Localization.jsp"%>
<%@ include file="ANA_FOR_Util.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/FornitoreTelefono/FornitoreTelefonoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/FornitoreTelefono/FornitoreTelefonoBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<html>
<head>
<script>
document.write("<title>" + getCompleteMenuPath(SubMenuAzienda,1) + "</title>");
</script>
<link rel="stylesheet" href="../_styles/style.css">
<link rel="stylesheet" href="../_styles/tabs.css">
<script language="JavaScript" src="../_scripts/tabs.js"></script>
<script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
</head>
<script>
window.dialogWidth="800px";
window.dialogHeight="650px";
</script>
<body>
<% 
	//boolean EdFlag=false;		//flag of editing
	//   *require Fields*
	String strRAG_SOC_FOR_AZL="";
  	String strCAG_FOR="";
  	String strIDZ_FOR="";
	String strCIT_FOR="";
	String strQLF_RSP_FOR="";
	String strNOM_RSP_FOR="";
	String strCOD_FOR_AZL="";
	long lCOD_AZL=Security.getAzienda();	
	//long lCOD_STA=2;
	String strCOD_STA="";
	
	//   *Not require Fields*
	String strNUM_CIC_FOR="";
  String strPRV_FOR="";
	String strCAP_FOR="";
	String strIDZ_PSA_ELT_RSP="";
	String strSIT_INT_FOR="";
	
	//---
	String strNOM_AZL="";


IFornitore fornitore=null;
if( request.getParameter("ID")!=null)
{
		strCOD_FOR_AZL = request.getParameter("ID");
		IFornitoreHome home=(IFornitoreHome)PseudoContext.lookup("FornitoreBean"); 
		Long for_id=new Long(strCOD_FOR_AZL);
		fornitore = home.findByPrimaryKey(for_id);
		// getting of object variables
		strRAG_SOC_FOR_AZL=fornitore.getRAG_SOC_FOR_AZL();
		strCAG_FOR=fornitore.getCAG_FOR();
		strIDZ_FOR=fornitore.getIDZ_FOR();
		strCIT_FOR=fornitore.getCIT_FOR();
		strQLF_RSP_FOR=fornitore.getQLF_RSP_FOR();
		strNOM_RSP_FOR=fornitore.getNOM_RSP_FOR();
		lCOD_AZL=fornitore.getCOD_AZL();
		strCOD_STA=Formatter.format(fornitore.getCOD_STA());
		//--- 
		strNUM_CIC_FOR=fornitore.getNUM_CIC_FOR();
		strPRV_FOR=fornitore.getPRV_FOR();
		strCAP_FOR=fornitore.getCAP_FOR();
		strIDZ_PSA_ELT_RSP=fornitore.getIDZ_PSA_ELT_RSP();
		strSIT_INT_FOR=fornitore.getSIT_INT_FOR();
}

IAzienda azienda=null;
IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");

	Long azl_id=new Long(lCOD_AZL);
	azienda = AziendaHome.findByPrimaryKey(azl_id);
	String	strRAG_SCL_AZL = azienda.getRAG_SCL_AZL();
	long  lCOD_STA_AZL   = azienda.getCOD_STA();
	
INazionalita  nazionalita =null;
INazionalitaHome NazionalitaHome=(INazionalitaHome)PseudoContext.lookup("NazionalitaBean");
  Long naz_id=new Long(lCOD_STA_AZL);
	nazionalita = NazionalitaHome.findByPrimaryKey(naz_id);/**/
	String	strNOM_STA_AZL = nazionalita.getNOM_STA();
%>
<!-- form for addind azienda -->

<table width="100%" border="0">
<form action="ANA_FOR_Set.jsp?par=add" method="POST" target="ifrmWork" >

<tr>
 <td valign="top">
  <table  width="100%">
  <tr>
		<td class="title">
                        <script>document.write(getCompleteMenuPathFunction(SubMenuAzienda,1,<%=request.getParameter("ID")%>));</script>
<input name="SBM_MODE" type="Hidden" value="<%if(strCOD_FOR_AZL==""){out.print("new");}else{out.print("edt");}%>">
<input name="FOR_ID" type="Hidden" value="<%=strCOD_FOR_AZL%>">

		</td>
	</tr>
  <tr>
	<td>
		<table>
			<tr><td>
			<!-- ############################ -->  		
			<%@ include file="../_include/ToolBar.jsp" %>      
			<%ToolBar.bCanDelete=(fornitore!=null);%>		
			<%=ToolBar.build(3)%> 
			<!-- ########################### -->
		</table>
  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.fornitore")%></legend>
              <table  width="100%" border="0">
                <tr> 
                  <td width="97%"> <fieldset>
                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.azienda")%></legend>
                    <table width="100%">
                      <tr> 
                        <td width="15%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b> 
                    <td width="37%"> 
                            <input tabindex="1" type="text"  style="width:100%;" readonly value="<%=strRAG_SCL_AZL%>">
                            <input type="hidden" name="COD_AZIENDA" value="<%=lCOD_AZL %>">
                          </td>
                        <td width="10%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Stato")%>&nbsp;</b></td>
                        <td width="37%"> <input tabindex="2" type="text" readonly style="width:100%;" value="<%=strNOM_STA_AZL%>"></td>
                      </tr>
                    </table>
                    </fieldset></td>
                </tr>
                <tr> 
                  <td> <table width="100%">
                      <tr> 
                        <td width="15%" align="left"> 
                          <div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Categoria")%>&nbsp;</b></div></td>
                        <td width="37%">
<input tabindex="3" style="width:100%;" type="text" maxlength="50" name="CATEGORIA" value="<%=strCAG_FOR%>"></td>
                      </tr>
                      <tr> 
                        <td width="15%" align="left"> 
                          <div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Ragione.sociale")%>&nbsp;</b></div></td>
                        <td width="40%">
<input tabindex="4" style="width:100%;" type="text" name="RAG_SOC" maxlength="50" value="<%=strRAG_SOC_FOR_AZL%>"></td>
                      </tr>
                      <tr> 
                        <td width="15%" align="left"> 
                          <div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Indirizzo")%>&nbsp;</b></div></td>
                        <td width="40%">
<input tabindex="5" style="width:100%;" type="text" maxlength="50" name="INDIRIZZO" value="<%=strIDZ_FOR%>"> 
                        <td width="10%" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Numero.civico")%>&nbsp;</td>
                        <td width="37%"> 
                          <input tabindex="6" size="22" type="text" name="NUM_CIC" maxlength="30" value="<%=strNUM_CIC_FOR%>"></td>
                      </tr>
                      <tr> 
                        <td width="15%" align="left"> 
                          <div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Città")%>&nbsp;</b></div></td>
                        <div align="left"> 
                          <td width="40%">
<input tabindex="7" style="width:100%;" type="text" name="CITTA" maxlength="20" value="<%=strCIT_FOR%>"> 
                          <td width="10%" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Provincia")%>&nbsp;</td>
                          <td width="35%">
<input name="PROV" type="text" tabindex="8" value="<%=strPRV_FOR%>" size="1" maxlength="2"></td>
                        </div>
                      </tr>
                      <tr> 
                        <td width="15%" align="left"> 
                          <div align="right"><%=ApplicationConfigurator.LanguageManager.getString("Sito.internet")%>&nbsp;</div></td>
                        <td width="40%">
<input tabindex="9" style="width:100%;" type="text" maxlength="50" name="SITO_INTERNET" value="<%=strSIT_INT_FOR%>"> 
                          <!-- <button type="button">...</button> -->
                        </td>
                        <td width="10%" align="right"><%=ApplicationConfigurator.LanguageManager.getString("C.a.p.")%>&nbsp;</td>
                        <td width="35%">
<input tabindex="10" size="22" type="text" name="CAP" maxlength="15" value="<%=strCAP_FOR%>"></td>
                      </tr>
                      <tr> 
                        <td width="15%" align="left"> 
                          <div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro")%>&nbsp;</b></div></td>
                        <td><input tabindex="11" style="width:100%;" type="text" maxlength="100" name="DATORE_LAVORO" value="<%=strNOM_RSP_FOR%>"> 
                        <td width="10%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Qualifica.del.datore.lavoro")%>&nbsp;</b></td>
                        <td width="35%">
<input tabindex="12" style="width:100%;" type="text" maxlength="50" name="QUALIFICA" value="<%=strQLF_RSP_FOR%>"></td>
                      </tr>
                      <tr> 
                        <td width="15%" align="left"> 
                          <div align="right"><%=ApplicationConfigurator.LanguageManager.getString("E-mail")%>&nbsp;</div></td>
                        <td><input tabindex="13" style="width:100%;" type="text" maxlength="50" name="EMAIL" value="<%=strIDZ_PSA_ELT_RSP%>"> 
                        <td width="10%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Stato")%>&nbsp;</b> 
                        <td width="35%">
<select tabindex="14" name="STATO" style="width:100%;" >
                            <option value=''></option>
                            <% 
							INazionalitaHome n_home=(INazionalitaHome)PseudoContext.lookup("NazionalitaBean");
							if(strCOD_STA.equals("")){
								strCOD_STA="0";
							}
							long COD_LNG=Localization.getCurrentLanguageCode();
							String n_cb=BuildNazionalitaComboBox(n_home, new Long(strCOD_STA).longValue(),COD_LNG);
							out.print(n_cb);
	 					%>
                          </select> </td>
                      </tr>
                    </table> 
              </table>	 
	 </fieldset></td></tr>
  </table>
 </td>
</tr>
<tr>
	<td><div id="dContainer" class="mainTabContainer" style="width:100%;"></div></td>
</tr> 
</form>	
</table>

  
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>      
<%
//-------Loading of Tabs--------------------
if(fornitore!=null)
{
%>
		

<script language="JavaScript" src="../_scripts/index.js"></script>
<script language="JavaScript">
if(window.name!="ifrmWork")
{

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
	tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Numeri.telefonici")%>", tabbar));
	tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("D.P.I.")%>", tabbar));
	tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Agenti.chimici")%>", tabbar));
	tabbar.addTab(new Tab("tab4", "<%=ApplicationConfigurator.LanguageManager.getString(
                                    ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                        ?"Macchine.attrezzature.impianti"
                                        :"Macchine/Attrezzature"
                                )%>", tabbar));
	
	//------adding tables to tabs-----------------------
	tabbar.idParentRecord = <%= new Long(strCOD_FOR_AZL) %>;
	tabbar.refreshTabUrl="ANA_FOR_Tabs.jsp";	
	tabbar.RefreshAllTabs();

	//-----activate first tab--------------------------
	tabbar.tabs[0].center.click();
	//----add action parameters to tabs
	tabbar.tabs[0].tabObj.actionParams ={
										"Feachures":NUM_TEL_FOR_Feachures
													,
"AddNew":{"url":"../Form_NUM_TEL_FOR/NUM_TEL_Form.jsp?ATTACH_URL=Form_ANA_FOR/ANA_FOR_Attach.jsp&ATTACH_SUBJECT=TELEFONO", 
													"buttonIndex":0,
													"disabled": false
												  	},
										"Edit":	{"url":"../Form_NUM_TEL_FOR/NUM_TEL_Form.jsp?ATTACH_URL=Form_ANA_FOR/ANA_FOR_Attach.jsp&ATTACH_SUBJECT=TELEFONO",
													"buttonIndex":1,
													"disabled": false
										 			},
										 "Delete":	{"url":"../Form_ANA_FOR/ANA_FOR_Delete.jsp?LOCAL_MODE=t",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": false	
										 			}	
										}; 
	tabbar.tabs[1].tabObj.actionParams ={
										"Feachures":ANA_LOT_DPI_Feachures,
"AddNew":{"url":"../Form_ANA_LOT_DPI/ANA_LOT_DPI_Form.jsp?ATTACH_URL=Form_ANA_FOR/ANA_FOR_Attach.jsp&ATTACH_SUBJECT=LOTTIDPI&PARENT=fornitore", 
													"buttonIndex":0,
													"disabled": false
												  	},
										"Edit":	{"url":"../Form_ANA_LOT_DPI/ANA_LOT_DPI_Form.jsp?ATTACH_URL=Form_ANA_FOR/ANA_FOR_Attach.jsp&ATTACH_SUBJECT=LOTTIDPI&PARENT=fornitore",
													"buttonIndex":1,
													"disabled": false
										 			},
										 "Delete":	{"url":"../Form_ANA_FOR/ANA_FOR_Delete.jsp?LOCAL_MODE=l",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": false	
										 			}	
										}; 
	tabbar.tabs[2].tabObj.actionParams ={
										"Feachures":ANA_SOS_CHI_Feachures,
"AddNew":{"url":"../Form_ANA_SOS_CHI/ANA_SOS_CHI_Form.jsp?ATTACH_URL=Form_ANA_FOR/ANA_FOR_Attach.jsp&ATTACH_SUBJECT=AGENTICHIMICI", 
													"buttonIndex":0,
													"disabled": false
												  	},
										"Edit":	{"url":"../Form_ANA_SOS_CHI/ANA_SOS_CHI_Form.jsp?ATTACH_URL=Form_ANA_FOR/ANA_FOR_Attach.jsp&ATTACH_SUBJECT=AGENTICHIMICI",
													"buttonIndex":1,
													"disabled": false
										 			},
										"Delete":	{"url":"../Form_ANA_FOR/ANA_FOR_Delete.jsp?LOCAL_MODE=ac",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": false	
										 			}	
										};
	tabbar.tabs[3].tabObj.actionParams ={
										"Feachures":ANA_MAC_Feachures,
"AddNew":{"url":"../Form_ANA_MAC/ANA_MAC_Form.jsp?ATTACH_URL=Form_ANA_FOR/ANA_FOR_Attach.jsp&ATTACH_SUBJECT=MACCHINA", 
													"buttonIndex":0,
													"disabled": false
												  	},
										"Edit":	{"url":"../Form_ANA_MAC/ANA_MAC_Form.jsp?ATTACH_URL=Form_ANA_FOR/ANA_FOR_Attach.jsp&ATTACH_SUBJECT=MACCHINA",
													"buttonIndex":1,
													"disabled": false
										 			},
										 "Delete":	{"url":"../Form_ANA_FOR/ANA_FOR_Delete.jsp?LOCAL_MODE=m",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": false	
										 			}	
										};
}
</script>
<%}else{%>
<script>
window.dialogWidth="800px";
window.dialogHeight="400px";
</script>
<%}%>


<!-- /form for addind azienda -->


</body>
</html>
