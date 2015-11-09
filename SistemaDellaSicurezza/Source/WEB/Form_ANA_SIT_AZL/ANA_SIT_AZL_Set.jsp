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
<%@ page import="com.apconsulting.luna.ejb.SediAziendali.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
	String ReqMODE;	// parameter of request
%>
<script>
  var err=false;
  var isNew=false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>

<%
ISitaAziende SitaAziende=null;

if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	//out.println(ReqMODE);

	Checker c = new Checker();

	//- checking for required fields
	long lCOD_SIT_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Sito.aziendale"),request.getParameter("COD_SIT_AZL"),true);
	long lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);
	String strNOM_SIT_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Identificativo.sito"),request.getParameter("NOM_SIT_AZL"),true);
	String strIDZ_SIT_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Indirizzo"),request.getParameter("IDZ_SIT_AZL"),true);
	String strCIT_SIT_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Città"),request.getParameter("CIT_SIT_AZL"),true);

	//- checking for not required fields
	String strNUM_CIC_SIT_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Numero.civico"),request.getParameter("NUM_CIC_SIT_AZL"),false);
	String strPRV_SIT_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Provincia"),request.getParameter("PRV_SIT_AZL"),false);
	String strCAP_SIT_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("C.a.p."),request.getParameter("CAP_SIT_AZL"),false);

	if (c.isError)
	{
		String err = c.printErrors();
		out.println("<script>alert(\""+err+"\");</script>");
		return;
	}

//=======================================================================================
	if(ReqMODE.equals("edt"))
	{
		// editing of attivitaLavorative--------------------
		// gettinf of object
		String strCOD_SIT_AZL=request.getParameter("COD_SIT_AZL");					//ID of attivitaLavorative
		ISitaAziendeHome home=(ISitaAziendeHome)PseudoContext.lookup("SitaAziendeBean");
		Long sit_azl_id=new Long(strCOD_SIT_AZL);
		SitaAziende = home.findByPrimaryKey(sit_azl_id);

		try{
			SitaAziende.setCOD_AZL_NOM_SIT_AZL(lCOD_AZL, strNOM_SIT_AZL);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
		SitaAziende.setIDZ_SIT_AZL(strIDZ_SIT_AZL);
		SitaAziende.setCIT_SIT_AZL(strCIT_SIT_AZL);
	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new SitaAziende--------------------------
	// creating of object
		ISitaAziendeHome home=(ISitaAziendeHome)PseudoContext.lookup("SitaAziendeBean");
		try{
			SitaAziende=home.create(lCOD_AZL, strNOM_SIT_AZL, strIDZ_SIT_AZL, strCIT_SIT_AZL);
			%><script>isNew=true;</script><%
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}
//=======================================================================================
	if (SitaAziende!=null){
	//   *Not require Fields*
		SitaAziende.setNUM_CIC_SIT_AZL(strNUM_CIC_SIT_AZL);
		SitaAziende.setPRV_SIT_AZL(strPRV_SIT_AZL);
		SitaAziende.setCAP_SIT_AZL(strCAP_SIT_AZL);
	}
}
%>
<script>
if(!err){
	parent.returnValue="OK";
	if(isNew){
		parent.ToolBar.OnNew("ID=<%=SitaAziende.getCOD_SIT_AZL()%>");
			Alert.Success.showCreated();
	}else{
			Alert.Success.showSaved();
	}
}else{
	parent.returnValue="ERROR";
}
</script>
