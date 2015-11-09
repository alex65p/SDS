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
    < version number="1.0" date="18/02/2003" author="EJBun 1.0">		
      < comments>
			   < comment date="18/02/2003" author="EJBun 1.0">
				   < description>Realizazija EJB dlia objecta UnitaOrganizzativa</description>
			   < /comment>		
      < /comments> 
    < /version>
  < /versions>
< /file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.InterventoAudut.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_include/Checker.jsp"%>
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
IInterventoAudut bean=null;
//-----start check section--------------------------------
Checker c = new Checker();

long lCOD_INR_ADT=c.checkLong("Intervento Audit",request.getParameter("COD_INR_ADT"),true);
String strDES_INR_ADT=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_INR_ADT"),false);
java.sql.Date dtDAT_PIF_INR=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificazione"),request.getParameter("DAT_PIF_INR"),true);
long lNUM_VIS_ISP=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Visita.ispettiva"),request.getParameter("NUM_VIS_ISP"),false);
java.sql.Date dtDAT_ADT=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.audit"),request.getParameter("DAT_ADT"),false);
long lCOD_MIS_PET=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dati.misura.di.prevenzione.applicata.a"),request.getParameter("COD_MIS_PET"),false);
long lCOD_PSD_ACD=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dati.presidio.antincendio"),request.getParameter("COD_PSD_ACD"),false);
long lCOD_LUO_FSC=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Luogo.fisico"),request.getParameter("COD_LUO_FSC"),false);
long lCOD_DPD=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dati.lavoratore"),request.getParameter("COD_DPD"),false);
long lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);
String strSEC_PNO_YEA=c.checkTrigger(ApplicationConfigurator.LanguageManager.getString("Piano.annuale(default)"),request.getParameter("SEC_PNO_YEA"));
long lPNG_TEO=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Punteggio.teorico"),request.getParameter("PNG_TEO"),false);
long lPNG_RIL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Punteggio.rilevato"),request.getParameter("PNG_RIL"),false);
long lPNG_PCT=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Punteggio.%"),request.getParameter("PNG_PCT"),false);
long lCOD_UNI_ORG=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Unità.org."),request.getParameter("COD_UNI_ORG"),false);
long lCOD_MIS_RSO_LUO=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Misura"),request.getParameter("COD_MIS_RSO_LUO"),false);
long lCOD_MIS_PET_MAN=c.checkLong("COD_MIS_PET_MAN",request.getParameter("COD_MIS_PET_MAN"),false);
//
if (c.isError){
	String err = c.printErrors();
	%><script>alert("<%=err%>");</script><%
	return;
}

IInterventoAudutHome home=(IInterventoAudutHome)PseudoContext.lookup("InterventoAudutBean");
//------end check section--------------------------------
out.println(request.getParameter("SBM_MODE"));

try{
	if(request.getParameter("SBM_MODE")!=null)
	{
		ReqMODE=request.getParameter("SBM_MODE");
		if(ReqMODE.equals("edt"))
		{
			bean = home.findByPrimaryKey(new Long(lCOD_INR_ADT));
			
	 		bean.setDAT_PIF_INR(dtDAT_PIF_INR);
			bean.setCOD_AZL(lCOD_AZL);	
			
		}
		else{
			bean=home.create(  dtDAT_PIF_INR, lCOD_AZL);
			lCOD_INR_ADT = bean.getCOD_INR_ADT();
			out.println("<script>isNew=true;</script>");
		}
		if(bean!=null){
	 		bean.setDES_INR_ADT(strDES_INR_ADT);
			bean.setNUM_VIS_ISP(lNUM_VIS_ISP);
			bean.setDAT_ADT(dtDAT_ADT);
			bean.setCOD_MIS_PET(lCOD_MIS_PET);
			bean.setCOD_PSD_ACD(lCOD_PSD_ACD);
			bean.setCOD_LUO_FSC(lCOD_LUO_FSC);
			bean.setCOD_DPD(lCOD_DPD);
			bean.setSEC_PNO_YEA(strSEC_PNO_YEA);
			bean.setPNG_TEO(lPNG_TEO);
			bean.setPNG_RIL(lPNG_RIL);
			bean.setPNG_PCT(lPNG_PCT);
			bean.setCOD_UNI_ORG(lCOD_UNI_ORG);
			bean.setCOD_MIS_RSO_LUO(lCOD_MIS_RSO_LUO);
			bean.setCOD_MIS_PET_MAN(lCOD_MIS_PET_MAN);
		}
	}
}
catch(Exception ex){
	%><script>err=true;</script><%
}
%>
<script>
if (!err){  
	if(isNew){
		 Alert.Success.showCreated();
		 parent.ToolBar.OnNew("ID=<%=lCOD_INR_ADT%>");
	}
	else{	 
		Alert.Success.showSaved(); 
	}
}
else{
	Alert.Error.showDublicate();
}
</script>

