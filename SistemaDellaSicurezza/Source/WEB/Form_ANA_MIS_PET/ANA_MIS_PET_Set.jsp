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
    < version number="1.0" date="05/02/2004" author="Alex Kyba">		
      < comments>
			   < comment date="05/02/2004" author="Alex Kyba">
				   < description>Realizazija EJB dlia objecta MisurePreventProtettive</description>
			   < /comment>		
      < /comments> 
    < /version>
  < /versions>
< /file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.MisuraPreventiva.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_include/Checker.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/ExtendedMode.jsp"%>
<%!
	String ReqMODE;	// parameter of request 
%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
	var err=false; 
	var isNew=false;
</script>	
<%
IMisuraPreventiva bean=null;
//-----start check section--------------------------------
Checker c = new Checker();
//
boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
java.sql.Date dtDAT_CMP= null;
long lVER_MIS_PET = 0;

long lCOD_MIS_PET=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione"),request.getParameter("COD_MIS_PET"),true);
String strNOM_MIS_PET=c.checkString(ApplicationConfigurator.LanguageManager.getString("Misura"),request.getParameter("NOM_MIS_PET"),true);
if (!ifMsr) {
dtDAT_CMP=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.compilazione"),request.getParameter("DAT_CMP"),true);
lVER_MIS_PET=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Versione"),request.getParameter("VER_MIS_PET"),true);
}
String strADT_MIS_PET=c.checkTrigger("ADT_MIS_PET",request.getParameter("ADT_MIS_PET"));
java.sql.Date dtDAT_PAR_ADT=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.partenza"),request.getParameter("DAT_PAR_ADT"),false);
String strPER_MIS_PET=c.checkTrigger(ApplicationConfigurator.LanguageManager.getString("Periodicità.(S/N)"),request.getParameter("PER_MIS_PET"));
long lPNZ_MIS_PET_MES=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Periodicità.mensile"),request.getParameter("PNZ_MIS_PET_MES"),false);
java.sql.Date dtDAT_PNZ_MIS_PET=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificazione"),request.getParameter("DAT_PNZ_MIS_PET"),false);
String strDES_MIS_PET=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_MIS_PET"),false);
String strTPL_DSI_MIS_PET=c.checkString(ApplicationConfigurator.LanguageManager.getString("Destinatario.tutela"),request.getParameter("TPL_DSI_MIS_PET"),true);
String strIST_OPE_COR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Istruzioni.Operative.correlate"),request.getParameter("IST_OPE_COR"),true);
String strDSI_AZL_MIS_PET=c.checkString("DSI_AZL_MIS_PET",request.getParameter("DSI_AZL_MIS_PET"),true);
long lCOD_TPL_MIS_PET=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Adottata/Da.adottare"),request.getParameter("COD_TPL_MIS_PET"),true);
long lCOD_MIS_PET_RPO=c.checkLong("COD_MIS_PET_RPO",request.getParameter("COD_MIS_PET_RPO"),false);
long lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);
//if (Security.isExtendedMode()){ 
	java.util.ArrayList alAziende = ExtendedMode.getAziende(c); //EXTENDED
//}

if (c.isError){
	String err = c.printErrors();
	out.print("<script>err=true;alert(\""+err+"\");</script>");
	return;
}
IMisuraPreventivaHome home=(IMisuraPreventivaHome)PseudoContext.lookup("MisuraPreventivaBean");
//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
		bean = home.findByPrimaryKey( new MisuraPreventivaPK(lCOD_AZL, lCOD_MIS_PET) );
		try{
			bean.store(
				strNOM_MIS_PET,
			    dtDAT_CMP,
			    lVER_MIS_PET,
                            strIST_OPE_COR,
			    strADT_MIS_PET,
			    dtDAT_PAR_ADT,
			    strPER_MIS_PET,
			    lPNZ_MIS_PET_MES,
			    dtDAT_PNZ_MIS_PET,
			    strDES_MIS_PET,
			    strTPL_DSI_MIS_PET,
			    strDSI_AZL_MIS_PET,
			    lCOD_TPL_MIS_PET,
			    lCOD_MIS_PET_RPO,
			    lCOD_AZL,
			  	alAziende
			);
		}catch(Exception ex){
			System.err.println("ANA_MIS_PET_Set.jsp");
			ex.printStackTrace(System.err);
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	//-----------------------------------------------------------------------------------
	}else{
		try{
			bean=home.create( 
				strNOM_MIS_PET,
			    dtDAT_CMP,
			    lVER_MIS_PET,
                            strIST_OPE_COR,
			    strADT_MIS_PET,
			    dtDAT_PAR_ADT,
			    strPER_MIS_PET,
			    lPNZ_MIS_PET_MES,
			    dtDAT_PNZ_MIS_PET,
			    strDES_MIS_PET,
			    strTPL_DSI_MIS_PET,
			    strDSI_AZL_MIS_PET,
			    lCOD_TPL_MIS_PET,
			    lCOD_MIS_PET_RPO,
			    lCOD_AZL,
			  	alAziende
			);
			lCOD_MIS_PET=bean.getCOD_MIS_PET();
			%><script>isNew=true;</script><%
		}catch(Exception ex){
			System.err.println("ANA_MIS_PET_Set.jsp");
			ex.printStackTrace(System.err);
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}//else
}//
%>
<script>
if (!err){
	if(isNew){
   		 parent.ToolBar.OnNew("ID=<%=lCOD_MIS_PET%>");
		 Alert.Success.showCreated();
	}	 
	else
		 Alert.Success.showSaved();
}
</script>

