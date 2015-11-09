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
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/ExtendedMode.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!	String ReqMODE;	// parameter of request %>
<%
//-----start check section--------------------------------
Checker c = new Checker();
long lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"), request.getParameter("COD_AZL"),true);
String strNOM_MAN=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"), request.getParameter("NOM_MAN"),true);   
//- checking for not required fields		
String strDES_MAN=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_MAN"),false);
String strDES_RSP_COM=c.checkString(
        ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_SDP)
                ?ApplicationConfigurator.LanguageManager.getString("Gruppi.omogenei.di.rferimento")
                :ApplicationConfigurator.LanguageManager.getString("Descrizione.responsabilità.e.competenze"),
        request.getParameter("DES_RSP_COM"),false);   
String strNOTE=c.checkString(ApplicationConfigurator.LanguageManager.getString("Note"),request.getParameter("NOTE"),false);
long lCOD_MAN_RPO=c.checkLong("",request.getParameter("COD_MAN_RPO"),false);
long lRSO_VAL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Indice.rischio.chimico"),request.getParameter("RSO_VAL"),false);
java.util.ArrayList alAziende=null;
// Correzione bug 1.95
// if (Security.isExtendedMode()){ 
	 alAziende = ExtendedMode.getAziende(c); //EXTENDED
// }
if (c.isError){
	String err = c.printErrors();
	%><script>alert("<%=err%>");</script><%
	return;
}
%>
<script src="../_scripts/Alert.js"></script>
<script>
  var err=false;	
  var isNew=false;  
</script>
<%
IAttivitaLavorativeHome home=(IAttivitaLavorativeHome)PseudoContext.lookup("AttivitaLavorativeBean");
IAttivitaLavorative attivitaLavorative=null;
if(request.getParameter("SBM_MODE")!=null)
{
  ReqMODE=request.getParameter("SBM_MODE");
  if(ReqMODE.equals("edt"))
	{
		// getting of object 
		Long man_id=new Long(c.checkLong("Attivita Lavorative ID",request.getParameter("COD_MAN"),true));
		attivitaLavorative = home.findByPrimaryKey( new AttivitaLavorativePK(lCOD_AZL, man_id.longValue()) );
		try{
			attivitaLavorative.store(strNOM_MAN, strDES_MAN, strDES_RSP_COM, strNOTE, lCOD_MAN_RPO, lRSO_VAL, alAziende);
			//out.print("Saving OK <br>");
		}catch(Exception ex){
			ex.printStackTrace(System.err);
			out.print("<script>Alert.Error.showDublicate();</script>");
			return;
		}
	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// creating of object 
		try{
			attivitaLavorative=home.create(lCOD_AZL, strNOM_MAN, strDES_MAN, strDES_RSP_COM, strNOTE, lCOD_MAN_RPO, lRSO_VAL, alAziende);
			%><script>isNew=true;</script><%
		}catch(Exception ex){
			ex.printStackTrace(System.err);
			out.print("<script>Alert.Error.showDublicate();</script>");
			return;
		}
	}
//=======================================================================================
}
out.print("Saving ok");
%>
<script>
//-------------------------------------------------------------------------
if(!err){	
	parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=attivitaLavorative.getCOD_MAN()%>");
		}else{Alert.Success.showSaved();}
	}else{
	 	parent.returnValue="ERROR";
	}	
//--------------------------------------------------------------------------	
</script>
