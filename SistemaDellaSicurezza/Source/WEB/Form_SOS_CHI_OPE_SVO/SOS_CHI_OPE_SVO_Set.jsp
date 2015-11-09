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

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
	String ReqMODE;	// parameter of request 
%>

<%
//--------------------------------------
Checker c = new Checker();

//---required fields
String strNOM_COM_SOS=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome.sostanza/preparato"),request.getParameter("NOM_COM_SOS"),true);
String strDES_SOS=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_SOS"),true); 
long lCOD_CLF_SOS=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Classificazione"),request.getParameter("DES_CLF_SOS"),true);   
long lCOD_STA_FSC=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Stato.fisico"),request.getParameter("DES_STA_FSC"),true);   

long lCOD_PTA_FSC=
        request.getParameter("COD_PTA_FSC") != null && 
        !request.getParameter("COD_PTA_FSC").equals("")
        ?Long.parseLong(request.getParameter("COD_PTA_FSC"))
        :0;

String sTIP_RSO=request.getParameter("TIP_RSO");
if (c.isError){
	String err = c.printErrors();
	%><script>alert("<%=err%>");</script><%
	return;
}

%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
  var err=false;
  var isNew=false;  
</script>

<%
IAssociativaAgentoChimicoHome home=(IAssociativaAgentoChimicoHome)PseudoContext.lookup("AssociativaAgentoChimicoBean");
IAssociativaAgentoChimico bean=null;
//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
		// gettinf of object 
		
		try{
			String strCOD_SOS_CHI=request.getParameter("COD_SOS_CHI");
			Long id=new Long(strCOD_SOS_CHI);
			bean = home.findByPrimaryKey(id);
			try{
				bean.setDES_SOS(strDES_SOS);
			}catch(Exception ex){
				ex.printStackTrace();
				out.println("<script>Alert.Error.showDublicate();</script>");
				return;
			}
			bean.setNOM_COM_SOS(strNOM_COM_SOS);
			bean.setCOD_STA_FSC(lCOD_STA_FSC);
			bean.setCOD_CLF_SOS(lCOD_CLF_SOS);
			bean.setCOD_PTA_FSC(lCOD_PTA_FSC);
			bean.setTIP_RSO(sTIP_RSO);
		}catch(Exception ex){
			ex.printStackTrace();
			out.println("<script>Alert.Error.showDublicate();</script>");
			return;
		}
	}
	//===============================================================================
	if(ReqMODE.equals("new"))
	{
	// creating of object 
		try{
			%><script>isNew=true;</script><%
			bean=home.create( strDES_SOS, strNOM_COM_SOS, lCOD_STA_FSC, lCOD_CLF_SOS, lCOD_PTA_FSC, sTIP_RSO);
		}catch(Exception ex){
			ex.printStackTrace();
			out.println("<script>Alert.Error.showDublicate();</script>");
			return;
		}
	}
//===================================================================================
}
out.print("Saving ok");
%>
<script>
 if(parent.dialogArguments){
 	if(!err){	
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.Return.OnClick();
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";	
	}	
 }else{
 	//------------------------------------------------
 	if(!err){	
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			//parent.ToolBar.Return.OnClick();
			parent.ToolBar.OnNew("ID=<%=bean.getCOD_SOS_CHI()%>");
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";	
	}	
 }//---------------------------------------------------	
</script>
