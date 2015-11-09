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
    < version number="1.0" date="17/02/2004" author="Artur Denysenko">		
      < comments>
			   < comment date="17/02/2004" author="Artur Denysenko">
				   < description>Realizazija EJB dlia objecta f
			   < /comment>		
      < /comments> 
    < /version>
  < /versions>
< /file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.MisurePreventive.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%!
	String ReqMODE;	// parameter of request 
%>

<script>
var err=false;
var isNew=false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
IMisurePreventive bean=null;
//-----start check section--------------------------------
Checker c = new Checker();

long lCOD_MIS_RSO_LUO=c.checkLong("COD_MIS_RSO_LUO",request.getParameter("COD_MIS_RSO_LUO"),true);//
long lCOD_MIS_PET=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione/protezione"),request.getParameter("COD_MIS_PET"),true);//
java.util.Date cdt=new java.util.Date();
java.sql.Date dtDAT_INZ = new java.sql.Date(cdt.getYear(),cdt.getMonth(),cdt.getDate());
java.sql.Date dtDAT_FIE=null;
String strPRS_MIS_PET="S";
long lVER_MIS_PET=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Versione.misura"),request.getParameter("VER_MIS_PET"),true);
String strADT_MIS_PET=c.checkString(ApplicationConfigurator.LanguageManager.getString("Applicare"),request.getParameter("ADT_MIS_PET"),true);
java.sql.Date dtDAT_PAR_ADT=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.partenza"),request.getParameter("DAT_PAR_ADT"),false);
String strPER_MIS_PET=c.checkString(ApplicationConfigurator.LanguageManager.getString("Periodicità.(S/N)"),request.getParameter("PER_MIS_PET"),true);
long lPNZ_MIS_PET_MES=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Periodicità.mensile"),request.getParameter("PNZ_MIS_PET_MES"),false);
java.sql.Date dtDAT_PNZ_MIS_PET=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificazione"),request.getParameter("DAT_PNZ_MIS_PET"),true);
String strTPL_DSI_MIS_PET=c.checkString(ApplicationConfigurator.LanguageManager.getString("Destinatario.tutela"),request.getParameter("TPL_DSI_MIS_PET"),true);
String strDSI_AZL_MIS_PET="N";
String strSTA_MIS_PET=c.checkString(ApplicationConfigurator.LanguageManager.getString("Stato"),request.getParameter("STA_MIS_PET"),true);
long lCOD_RSO_LUO_FSC=c.checkLong("COD_RSO_LUO_FSC",request.getParameter("COD_RSO_LUO_FSC"),true);
long lCOD_LUO_FSC=c.checkLong("COD_LUO_FSC",request.getParameter("COD_LUO_FSC"),true);
long lCOD_TPL_MIS_PET=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Adottata/Da.adottare"),request.getParameter("COD_TPL_MIS_PET"),true);

if (c.isError){
	String err = c.printErrors();
	out.print("<script>err=true;alert(\""+err+"\");</script>");
	return;
}

IMisurePreventiveHome home=(IMisurePreventiveHome)PseudoContext.lookup("MisurePreventiveBean");

//------end check section--------------------------------
try{
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
		bean = home.findByPrimaryKey(new Long(lCOD_MIS_RSO_LUO));
		
 		//bean.setCOD_MIS_PET(lCOD_MIS_PET);
		bean.setPRS_MIS_PET(strPRS_MIS_PET);
		bean.setVER_MIS_PET(lVER_MIS_PET);
		bean.setADT_MIS_PET(strADT_MIS_PET);
		bean.setPER_MIS_PET(strPER_MIS_PET);
		bean.setDAT_PNZ_MIS_PET(dtDAT_PNZ_MIS_PET);
		bean.setTPL_DSI_MIS_PET(strTPL_DSI_MIS_PET);
		bean.setDSI_AZL_MIS_PET(strDSI_AZL_MIS_PET);
		bean.setSTA_MIS_PET(strSTA_MIS_PET);
		//bean.setCOD_RSO_LUO_FSC(lCOD_RSO_LUO_FSC);
		//bean.setCOD_LUO_FSC(lCOD_LUO_FSC);
		bean.setCOD_TPL_MIS_PET(lCOD_TPL_MIS_PET);	
		bean.setCOD_LUO_FSC__COD_MIS_PET__COD_RSO_LUO_FSC(lCOD_LUO_FSC, lCOD_MIS_PET, lCOD_RSO_LUO_FSC);
	}
	else{
		bean=home.create(  lCOD_MIS_PET, strPRS_MIS_PET, lVER_MIS_PET, strADT_MIS_PET, strPER_MIS_PET, dtDAT_PNZ_MIS_PET, strTPL_DSI_MIS_PET, strDSI_AZL_MIS_PET, strSTA_MIS_PET, lCOD_RSO_LUO_FSC, lCOD_LUO_FSC, lCOD_TPL_MIS_PET);
		%>
		<script>isNew=true;</script>
		<%	
	}
	if(bean!=null){
 		bean.setDAT_INZ(dtDAT_INZ);
		bean.setDAT_FIE(dtDAT_FIE);
		bean.setDAT_PAR_ADT(dtDAT_PAR_ADT);
		bean.setPNZ_MIS_PET_MES(lPNZ_MIS_PET_MES);
	}
	else{	throw new Exception("Invalid operation");}
}
}catch(Exception ex){
%>
		<div id="divErr">
			<%=ex.getMessage()%>
		</div>
		<script>err=true;</script>
<%
}

%>
%>
<script>
if (err) Alert.Error.showDublicate();
 if(!err){	
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=bean.getCOD_MIS_RSO_LUO()%>"); 
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";	
	}	
</script>
