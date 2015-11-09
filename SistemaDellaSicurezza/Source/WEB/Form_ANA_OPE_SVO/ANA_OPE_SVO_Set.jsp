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
    <version number="1.0" date="24/01/2004" author="Malyuk Sergey">
	      <comments>
			<comment date="24/01/2004" author="Malyuk Sergey">
				<description></description>
			</comment>
			<comment date="06/02/2004" author="Roman Chumachenko">
				<description>UpMaking to new requirements</description>
		  </comment>
      </comments> 
    </version>
  </versions>
</file> 
*/

response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server

%>
<%@ page import="com.apconsulting.luna.ejb.OperazioneSvolta.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!	String ReqMODE;	// parameter of request %>

<%
IOperazioneSvolta OperazioneSvolta=null;
//--------------------------------------
Checker c = new Checker();
//---required fields
String strNOM_OPE_SVO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"),request.getParameter("NOM_OPE_SVO"),true);   
//----not required fields
String strDES_OPE_SVO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_OPE_SVO"),false);
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
//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
  	if(ReqMODE.equals("edt"))
	{
		// gettinf of object 
		String strCOD_OPE_SVO=request.getParameter("COD_OPE_SVO");
		IOperazioneSvoltaHome home=(IOperazioneSvoltaHome)PseudoContext.lookup("OperazioneSvoltaBean");
		Long ope_svo_id=new Long(strCOD_OPE_SVO);
		OperazioneSvolta = home.findByPrimaryKey(ope_svo_id);
		try{
			OperazioneSvolta.setNOM_OPE_SVO(strNOM_OPE_SVO);
		}catch(Exception ex){
			out.println("<script>Alert.Error.showDublicate();</script>");
			return;
		}
	}
	//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// creating of object 
		IOperazioneSvoltaHome home=(IOperazioneSvoltaHome)PseudoContext.lookup("OperazioneSvoltaBean");
		try{
			%><script>isNew=true;</script><%
			OperazioneSvolta=home.create(strNOM_OPE_SVO);
		}catch(Exception ex){
			out.println("<script>Alert.Error.showDublicate();</script>");
			return;
		}
	}
//=======================================================================================
	if (OperazioneSvolta!=null){
		//*Not require Fields*
		OperazioneSvolta.setDES_OPE_SVO(strDES_OPE_SVO);
	}
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
			parent.ToolBar.OnNew("ID=<%=OperazioneSvolta.getCOD_OPE_SVO()%>");
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";	
	}	
 }//---------------------------------------------------	
</script>
