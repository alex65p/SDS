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
<%@ page import="com.apconsulting.luna.ejb.AssociativaAgentoChimico.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/ClassificazioneAgentiChimici/ClassificazioneAgentiChimiciBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ClassificazioneAgentiChimici/ClassificazioneAgentiChimiciBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/StatoFisico/StatoFisicoBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/StatoFisico/StatoFisicoBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="SOS_CHI_OPE_SVO_Util.jsp"%>

<%	
  // *require Fields
  long lCOD_AZL=Security.getAzienda();
  String strCOD_SOS_CHI=""; //1
  String strNOM_COM_SOS="";	//2
  String strDES_SOS=""; 	//3
  long lCOD_CLF_SOS=0;	  	//4
  long lCOD_STA_FSC=0; 		//5
  long lCOD_PTA_FSC=0; 		//6
  String sTIP_RSO="";
IAssociativaAgentoChimico bean=null;
if(request.getParameter("ID")!=null)
{
	strCOD_SOS_CHI = request.getParameter("ID");	
	//getting of object
	IAssociativaAgentoChimicoHome home=(IAssociativaAgentoChimicoHome)PseudoContext.lookup("AssociativaAgentoChimicoBean");
	Long id=new Long(strCOD_SOS_CHI);
	bean = home.findByPrimaryKey(id);
	// getting of object variables
	strNOM_COM_SOS=Formatter.format(bean.getNOM_COM_SOS());
	strDES_SOS=Formatter.format(bean.getDES_SOS());
	lCOD_CLF_SOS=bean.getCOD_CLF_SOS();
  lCOD_STA_FSC=bean.getCOD_STA_FSC();
  lCOD_PTA_FSC=bean.getCOD_PTA_FSC();
  sTIP_RSO=bean.getTIP_RSO();

}// if request
%>

<html>
<head><title><%=ApplicationConfigurator.LanguageManager.getString("Associativa.agenti.chimici")%></title></head>
<link rel="stylesheet" href="../_styles/style.css">
<link rel="stylesheet" href="../_styles/tabs.css">
<script language="JavaScript" src="../_scripts/tabs.js"></script>
<script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
<script>
    window.dialogWidth="700px";
    window.dialogHeight="590px";
</script>

<body style="margin:0 0 0 0;">
<form action="SOS_CHI_OPE_SVO_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<table cellpadding="0" cellspacing="2" border="0" width='100%'>
    <tr>
        <td>
            <table border="0" cellpadding="0" cellspacing="0" width='100%'>
                <tr>
                     <td align="center" class="title"><%=ApplicationConfigurator.LanguageManager.getString("Associativa.agenti.chimici")%></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table border=0>
         <!-- ############################################################## -->
                        <%@ include file="../_include/ToolBar.jsp"%>
                        <% ToolBar.bShowDelete=false;%>
                        <% ToolBar.bShowPrint=false;%>
                        <%=ToolBar.build(4)%>
        <!-- ############################################################### -->
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <fieldset>
            <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.agente.chimico")%></legend>
            <table border="0" cellpadding="0" cellspacing="2" width='100%'>
                <tr><td><input name="SBM_MODE" type="Hidden" value="<%if(!strCOD_SOS_CHI.equals("")){out.print("edt");}else{out.print("new");}%>"></td></tr>
                <tr><td><input name="COD_SOS_CHI" type="Hidden" value="<%if(!strCOD_SOS_CHI.equals("")){out.print(strCOD_SOS_CHI);}%>"></td></tr>
                <!-- Sostanza/Preparato -->
                <tr>
                    <td align="right" valign="top"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome.sostanza/preparato")%>&nbsp;</td>
                    <td colspan="2"><textarea  tabindex="1" name="NOM_COM_SOS" cols="100" rows="3" style='width:98%'><%=strNOM_COM_SOS%></textarea></td>
                </tr>
                <!-- Descrizione: -->
                <tr><td height="3"></td></tr>
                <tr>
                    <td align="right" valign="top"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                    <td colspan="2"><textarea  tabindex="2" name="DES_SOS" cols="100" rows="4" style='width:98%'><%=strDES_SOS%></textarea></td>
                </tr>
                <!-- Classificazione -->
                <tr><td height="3"></td></tr>
                <tr>
                    <td align="right" valign="top"><b><%=ApplicationConfigurator.LanguageManager.getString("Classificazione")%>&nbsp;</td>
                    <td colspan="2">
                        <SELECT  tabindex="3" name="DES_CLF_SOS" style="width:300px">
                            <option value=''></option>
                            <%
                            IClassificazioneAgentiChimiciHome ca_home=(IClassificazioneAgentiChimiciHome)PseudoContext.lookup("ClassificazioneAgentiChimiciBean");
                            out.print(BuildClassificazioneComboBox(ca_home, lCOD_CLF_SOS ));
                            %>
                        </SELECT>
                    </td>
                </tr>
                <!-- Stato Fisico -->
                <tr><td height="3"></td></tr>
                <tr>
                    <td align="right" valign="top"><b><%=ApplicationConfigurator.LanguageManager.getString("Stato.fisico")%>&nbsp;</td>
                    <td colspan="2">
                        <SELECT  tabindex="4" name="DES_STA_FSC" style="width:300px">
                            <option value=''></option>
                            <%
                            IStatoFisicoHome sf_home=(IStatoFisicoHome)PseudoContext.lookup("StatoFisicoBean");
                            out.print(BuildStatoFisicoComboBox(sf_home, lCOD_STA_FSC ));
                            %>
                        </SELECT>
                    </td>
                </tr>
                <tr>
                    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Proprietà.chimico-fisiche")%>&nbsp;</td>
                    <td colspan=3>
                        <select tabindex="5" name="COD_PTA_FSC" style="width:300px">
                            <%
                            IAssociativaAgentoChimicoHome home=(IAssociativaAgentoChimicoHome)PseudoContext.lookup("AssociativaAgentoChimicoBean");
                            out.print(BuildProprietaChiFisComboBox(home, lCOD_PTA_FSC));
                            %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Tipologia.rischio.chimico")%>&nbsp;</td>
                    <td colspan=3>
                        <select tabindex="6" name="TIP_RSO" style="width:300px">
                            <%=BuildTipoRischioComboBox(home, sTIP_RSO)%>
                        </select>
                    </td>
                </tr>
                <tr><td height="8"></td></tr>
            </table>
            </fieldset>
        </td>
    </tr>
    <tr>
        <td colspan="100%"><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
    </tr>
    </table>
</form>
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
<%
//-------Loading of Tabs---------------------------------
if(bean!=null)
{
	out.print(BuildRischiAgenteTab(bean, lCOD_AZL));
// ------------------------------------------------------
%>
<script language="JavaScript">
	function RischiAgenteDialogParams(){
		obj = new DialogParameters();
		obj.NOM_RSO = null;
		obj.NOM_FAT_RSO = null;
		obj.COD_OPE_SVO = null;
		obj.toRow = function (row){
			if(this.NOM_OPE_SVO==null) return;
			row.id = this.ID;
			row.INDEX = this.COD_OPE_SVO;
			colInput=row.getElementsByTagName("INPUT");
			colInput[0].value=this.NOM_RSO;
			colInput[1].value=this.NOM_FAT_RSO;
			return row;
		}
		return obj;
	}
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
	tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Rischi.degli.agenti")%>", tabbar));

        //------adding tables to tabs-----------------------
	tabbar.tabs[0].tabObj.addTable( document.all["RischiAgenteHeader"],document.all["RischiAgente"], true);
	//----add action parameters to tabs
	
	tabbar.tabs[0].tabObj.actionParams ={"AddNew":	{"url":"../Form_SOS_CHI_OPE_SVO/SOS_CHI_OPE_SVO_Form.jsp", 
													"whidth":"800px", 
													"height":"450px",
													"addDialogParameters":new RischiAgenteDialogParams(),
													"alert": null, 
													"buttonIndex":0,
													"disabled": true
												  	},
										 "Edit":	{"url":"../Form_SOS_CHI_OPE_SVO/SOS_CHI_OPE_SVO_Form.jsp",
													"whidth":"800px", 
													"height":"450px",
													"editDialogParameters":new RischiAgenteDialogParams(),
													"alert": null,
													"buttonIndex":1,
													"disabled": true
										 			},			  	
										 "Delete":	{"url":"../Form_SOS_CHI_OPE_SVO/SOS_CHI_OPE_SVO_Delete.jsp",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": true	
										 			}		
										};
</script>
<%} else {%>
<script>
    window.dialogHeight="350px";
</script>
<%}%>
</body>
</html>
