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
< file>
  < versions>	
    < version number="1.0" date="05/02/2004" author="Podmasteriev Alexandr">		
      < comments>
			   < comment date="05/02/2004" author="Podmasteriev Alexandr">
				   < description>Realizazija EJB dlia objecta SchedaAttivitaSegnalazione
			   < /comment>		
      < /comments> 
    < /version>
  < /versions>
< /file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.SchedaAttivitaSegnalazione.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%!
	String ReqMODE;	// parameter of request 
%>
<script>
var err=false;
var isNew=false;
</script>
<%
ISchedaAttivitaSegnalazione bean=null;
//-----start check section--------------------------------
Checker c = new Checker();
String strTemp="";
long lCOD_SCH_ATI_MNT=c.checkLong("COD_SCH_ATI_MNT",request.getParameter("COD_SCH_ATI_MNT"),false);
long lCOD_MNT_MAC=c.checkLong("Codice",request.getParameter("COD_MNT_MAC"),true);
long lCOD_MAC=c.checkLong("COD_MAC",request.getParameter("COD_MAC"),true);
long lCOD_DPD=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dipendente"),request.getParameter("COD_DPD"),true);
String strATI_SVO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Attività.svolta"),request.getParameter("ATI_SVO"),false);
java.sql.Date dtDAT_ATI_MNT=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.attività"),request.getParameter("DAT_ATI_MNT"),false);
String strESI_ATI_MNT=c.checkString(ApplicationConfigurator.LanguageManager.getString("Esito.attività"),request.getParameter("ESI_ATI_MNT"),false);
String strPBM_ATI_MNT=c.checkString(ApplicationConfigurator.LanguageManager.getString("Problemi.attività"),request.getParameter("PBM_ATI_MNT"),false);
java.sql.Date dtDAT_PIF_INR=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificazione"),request.getParameter("DAT_PIF_INR"),true);
String strTPL_ATI=c.checkString(ApplicationConfigurator.LanguageManager.getString("Tipologia"),request.getParameter("TPL_ATI"),true);
long lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);
if (c.isError){
	String err = c.printErrors();
	out.print("<script>alert(\""+err+"\");</script>");
	return;
}


ISchedaAttivitaSegnalazioneHome home=(ISchedaAttivitaSegnalazioneHome)PseudoContext.lookup("SchedaAttivitaSegnalazioneBean");

//------end check section--------------------------------
	out.print(request.getParameter("SBM_MODE"));
	out.print(lCOD_SCH_ATI_MNT+"  ID");
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
	try{
		bean = home.findByPrimaryKey(new Long(lCOD_SCH_ATI_MNT));
 		bean.setCOD_MNT_MAC(lCOD_MNT_MAC);
		bean.setCOD_MAC(lCOD_MAC);
		bean.setCOD_DPD(lCOD_DPD);
		bean.setDAT_PIF_INR(dtDAT_PIF_INR);
		bean.setTPL_ATI(strTPL_ATI);
		bean.setCOD_AZL(lCOD_AZL);
	}catch(Exception ex){
    			out.println("<script>Alert.Error.showDublicate();err=true;</script>");
    			return;
  }	
	}
	else{
 	try{
		bean=home.create(  lCOD_MNT_MAC, lCOD_MAC, lCOD_DPD, dtDAT_PIF_INR, strTPL_ATI, lCOD_AZL);
		out.println("<script>isNew=true;</script>");
	}catch(Exception ex){
    			out.println("<script>Alert.Error.showDublicate();err=true;</script>");
    			return;
  }
		lCOD_SCH_ATI_MNT=bean.getCOD_SCH_ATI_MNT();
	}
	if(bean!=null){
 		bean.setATI_SVO(strATI_SVO);
		bean.setDAT_ATI_MNT(dtDAT_ATI_MNT);
		bean.setESI_ATI_MNT(strESI_ATI_MNT);
		bean.setPBM_ATI_MNT(strPBM_ATI_MNT);
	}
	strTemp=(strESI_ATI_MNT.equals("P"))?"POSITIVO":"NEGATIVO";
}
%>
<script>
 	if(!err){	
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=bean.getCOD_SCH_ATI_MNT()%>");
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";	
	}	
</script>
