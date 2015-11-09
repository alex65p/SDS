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

<%@ page import="com.apconsulting.luna.ejb.AssociativaAgentoChimico.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
	String ReqMODE;	// parameter of request 
%>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
var err=false;
var isNew=false;
</script>

<%
IAssociativaAgentoChimico bean=null;
//-----start check section--------------------------------
Checker c = new Checker();

long lCOD_SOS_CHI=c.checkLong("ID Agente Chimico",request.getParameter("COD_SOS_CHI"),true);
String strNOM_COM_SOS=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome.sostanza/preparato"),request.getParameter("NOM_COM_SOS"),true);
String strDES_SOS=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_SOS"),true);
long lCOD_STA_FSC=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Stato.fisico"),request.getParameter("COD_STA_FSC"),true);
long lCOD_CLF_SOS=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Classificazione"),request.getParameter("COD_CLF_SOS"),true);
String strFRS_R=c.checkString("Frase R",request.getParameter("FRS_R"),false);
String strFRS_S=c.checkString("Frase S",request.getParameter("FRS_S"),false);
String strSIM_RIS=c.checkString(ApplicationConfigurator.LanguageManager.getString("Simbolo"),request.getParameter("SIM_RIS"),false);
long lCOD_SIM=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Descrizione.simbolo"),request.getParameter("COD_SIM"),false);
long lCOD_PTA_FSC=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Proprietà.chimico-fisiche"), request.getParameter("COD_PTA_FSC"),false);
String sTIP_RSO= request.getParameter("TIP_RSO");
if (c.isError){
	String err = c.printErrors();
	out.print("<script>err=true;alert(\""+err+"\");</script>");
	return;
}

IAssociativaAgentoChimicoHome home=(IAssociativaAgentoChimicoHome)PseudoContext.lookup("AssociativaAgentoChimicoBean");

//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
		bean = home.findByPrimaryKey(new Long(lCOD_SOS_CHI));
	 try{
 		bean.setDES_SOS(strDES_SOS);
	  bean.setNOM_COM_SOS(strNOM_COM_SOS);
		bean.setCOD_STA_FSC(lCOD_STA_FSC);
		bean.setCOD_CLF_SOS(lCOD_CLF_SOS);
		bean.setCOD_PTA_FSC(lCOD_PTA_FSC);
		bean.setTIP_RSO(sTIP_RSO);
	 }catch(Exception ex){
	   %><script>Alert.Error.showDublicate();err=true;</script><%
	 }
	}
	else{
	 try{
		bean=home.create(  strDES_SOS, strNOM_COM_SOS, lCOD_STA_FSC, lCOD_CLF_SOS, lCOD_PTA_FSC, sTIP_RSO);
	 }catch(Exception ex){
	   %><script>Alert.Error.showDublicate();err=true;</script><%
	 }
       %><script>isNew=true;</script><%
	}
	if(bean!=null){
 		bean.setFRS_R(strFRS_R);
		bean.setFRS_S(strFRS_S);
		bean.setSIM_RIS(strSIM_RIS);
		bean.setCOD_SIM(lCOD_SIM);
	}
}
%>
<script>
if(parent.dialogArguments)
{
	if(!err)
	{
/*		da = parent.dialogArguments;
		da.ID = "<%//=bean.getCOD_ARE()%>";
		da.nome = "<%//=bean.getNOM_ARE()%>";
		da.codDocVlu = "<%//=ID_PARENT%>";
		
		parent.window.returnValue="OK";
		if(isNew) {
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%//=bean.getCOD_ARE()%>");
		} else {
			Alert.Success.showSaved();
			parent.ToolBar.Exit.setEnabled(false);
			parent.ToolBar.Return.setEnabled(true);			 
		}
*/		
	}
	else
	{
		parent.window.returnValue="ERROR";
	}
	parent.close();
}
else
{
 	//------------------------------------------------
 	if(!err){	
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=( bean!=null ? bean.getCOD_SOS_CHI() : 0 )%>"); 
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";	
	}	
}
</script>
