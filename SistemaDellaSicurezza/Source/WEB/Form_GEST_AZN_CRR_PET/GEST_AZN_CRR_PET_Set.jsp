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
    <version number="1.0" date="30/01/2004" author="Artur Denysenko">		
      <comments>
			   <comment date="30/01/2004" author="Artur Denysenko">
				   <description>Realizazija EJB dlia objecta AzioniCorrectivePreventive
			   </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.AzioniCorrectivePreventive.*" %>

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
IAzioniCorrectivePreventive bean=null;
//-----start check section--------------------------------
Checker c = new Checker();

long lCOD_AZN_CRR_PET=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dati.richiesta.di.azione.correttiva/preventiva"),request.getParameter("AZN_CRR_PET_ID"),true);
long lCOD_INR_ADT=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Descrizione.intervento.d'audit"),request.getParameter("COD_INR_ADT"),false);
String strDES_AZN_RCH=c.checkString(ApplicationConfigurator.LanguageManager.getString("Azione.richiesta"),request.getParameter("DES_AZN_RCH"),true);
String strRCH_AZN_CRR_PET=c.checkString(ApplicationConfigurator.LanguageManager.getString("Richiesta.di"),request.getParameter("RCH_AZN_CRR_PET"),true);
java.sql.Date dtDAT_RCH=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.richiesta"),request.getParameter("DAT_RCH"),true);
String strTPL_ATT=c.checkString(ApplicationConfigurator.LanguageManager.getString("Richiesta"),request.getParameter("TPL_ATT"),false);
String strMTZ_ATT=c.checkString("MTZ_ATT",request.getParameter("MTZ_ATT"),false);
String strDES_AZN_CRR_PET=c.checkString(ApplicationConfigurator.LanguageManager.getString("Azione.correttiva/preventiva"),request.getParameter("DES_AZN_CRR_PET"),false);
String strTPL_AZN=c.checkString(ApplicationConfigurator.LanguageManager.getString("Azione"),request.getParameter("TPL_AZN"),false);
String strMTZ_AZN=c.checkString("MTZ_AZN",request.getParameter("MTZ_AZN"),false);
java.sql.Date dtDAT_AZN=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.azione"),request.getParameter("DAT_AZN"),false);
long lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);

if (c.isError){
	String err = c.printErrors();
	out.print("<script>alert(\""+err+"\");</script>");
	return;
}
//
IAzioniCorrectivePreventiveHome home=(IAzioniCorrectivePreventiveHome)PseudoContext.lookup("AzioniCorrectivePreventiveBean");
//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
	  try{
		 bean = home.findByPrimaryKey(new Long(lCOD_AZN_CRR_PET));
 		 bean.setDES_AZN_RCH(strDES_AZN_RCH);
		 bean.setRCH_AZN_CRR_PET(strRCH_AZN_CRR_PET);
		 bean.setDAT_RCH(dtDAT_RCH);
		 bean.setCOD_AZL(lCOD_AZL);
	  }catch(Exception ex){
		 out.print("<script>Alert.Error.showDublicate();err=true;</script>");
	  }
	}
	else{
	  try{
		  	bean=home.create(  strDES_AZN_RCH, strRCH_AZN_CRR_PET, dtDAT_RCH, lCOD_AZL);
			%><script>isNew=true;</script><%
	  }catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
	  }
	}
	if(bean!=null){
 		bean.setCOD_INR_ADT(lCOD_INR_ADT);
		bean.setTPL_ATT(strTPL_ATT);
		bean.setMTZ_ATT(strMTZ_ATT);
		bean.setDES_AZN_CRR_PET(strDES_AZN_CRR_PET);
		bean.setTPL_AZN(strTPL_AZN);
		bean.setMTZ_AZN(strMTZ_AZN);
		bean.setDAT_AZN(dtDAT_AZN);
	}
}
%>
<script>
 	if(!err){	
		if(isNew){
			parent.ToolBar.OnNew("ID=<%=bean.getCOD_AZN_CRR_PET()%>");
			Alert.Success.showCreated();
		}else{
			Alert.Success.showSaved();
		}
	  parent.ToolBar.Exit.setEnabled(true);
		parent.returnValue="OK";
	}else{
		parent.returnValue="ERROR";	
	}	
</script>
