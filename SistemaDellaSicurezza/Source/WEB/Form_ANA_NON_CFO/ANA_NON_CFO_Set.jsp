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
    <version number="1.0" date="20/01/2004" author="Kushkarov Yura">
	      <comments>
				  <comment date="20/01/2004" author="Kushkarov Yura">
				   <description>Shablon formi ANA_ALA_Form.jsp</description>
				 </comment>
      </comments>
    </version>
  </versions>
</file>
*/
%>
<%@ page import="com.apconsulting.luna.ejb.NonConformita.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!	String ReqMODE;	// parameter of request%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
 var err = false;
 var isNew = false;
</script>
<%INonConformita NonConformita=null;
long lCOD_INR_ADT=0;
long lCOD_AZL=0;
String strDES_NON_CFO="";
String strNOM_RIL_NON_CFO="";
String strOSS_NON_CFO="";
long THIS_ID=0;

if(request.getParameter("SBM_MODE")!=null){
	ReqMODE=request.getParameter("SBM_MODE");
	Checker c = new Checker();
	//- checking for required fields
	lCOD_INR_ADT=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Descrizione.intervento.d'audit"),request.getParameter("COD_INR_ADT"),false);
	lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);
	strDES_NON_CFO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione.non.conformità"),request.getParameter("DES_NON_CFO"),true);
    java.sql.Date dtDAT_RIL_NON_CFO=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.rilievo.non.conformità"),request.getParameter("DAT_RIL_NON_CFO"),true);
	strNOM_RIL_NON_CFO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Rilevatore.non.conformità"),request.getParameter("NOM_RIL_NON_CFO"),true);
	strOSS_NON_CFO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Osservazione.non.conformità"),request.getParameter("OSS_NON_CFO"),false);
	out.print(lCOD_AZL);
	
	if (c.isError){
		String err = c.printErrors();
		out.println("<script>alert(\""+err+"\");err=true;</script>");
		return;
	}
//=======================================================================================
  if(ReqMODE.equals("edt"))
	{
		// editing of NonConformita--------------------
		// gettinf of object
		Long lCOD_NON_CFO=new Long(c.checkLong("ID",request.getParameter("COD_NON_CFO"),true));
  	if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");err=true;</script>");
			return;
		}
    try{
		INonConformitaHome home=(INonConformitaHome)PseudoContext.lookup("NonConformitaBean");
		NonConformita = home.findByPrimaryKey(lCOD_NON_CFO);
		//getting of parameters and set the new object variables
	    NonConformita.setDES_NON_CFO(strDES_NON_CFO);
		NonConformita.setDAT_RIL_NON_CFO(dtDAT_RIL_NON_CFO);
		NonConformita.setNOM_RIL_NON_CFO(strNOM_RIL_NON_CFO);
		NonConformita.setCOD_AZL(lCOD_AZL);
		THIS_ID=NonConformita.getCOD_NON_CFO();
		}
		catch(Exception ex){out.print("<script>Alert.Error.showDublicate();err=true;</script>");}
	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new NonConformita--------------------------
	// creating of object
	 try{
	 	out.println("new");
		out.println(strDES_NON_CFO);
		INonConformitaHome home=(INonConformitaHome)PseudoContext.lookup("NonConformitaBean");
		NonConformita=home.create(strDES_NON_CFO,dtDAT_RIL_NON_CFO,strNOM_RIL_NON_CFO,lCOD_AZL);
		THIS_ID=NonConformita.getCOD_NON_CFO();
		%>
		<script>isNew=true;</script>
		<%
		}
		catch(Exception ex){
		out.print(ex);
		out.print("<script>Alert.Error.showDublicate();err=true;</script>");}
	}
//=======================================================================================
  if (NonConformita!=null){
	//   *Not require Fields*
	if (lCOD_INR_ADT!=0){
		NonConformita.setCOD_INR_ADT(lCOD_INR_ADT);}
		NonConformita.setOSS_NON_CFO(strOSS_NON_CFO);

	}
}
%>
<script>
if (!err){
  if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=THIS_ID%>");

		}else{
			Alert.Success.showSaved();
			<%if (request.getParameter("ATTACH_SUBJECT")!=null){%>
			parent.ToolBar.Return.Do();
			<%}%>
		}

}
</script>
