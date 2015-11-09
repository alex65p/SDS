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
    <version number="1.0" date="27/02/2004" author="Roman Chumachenko">
	      <comments>
			<comment date="27/02/2004" author="Roman Chumachenko">
				<description>MIS_PET_MAN_Set.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.AssMisuraAttivita.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%! String ReqMODE;	// parameter of request %>
<%
IAssMisuraAttivita bean=null;
//--------------------------------------
Checker c = new Checker();
//---required fields
long lCOD_MAN=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa"),request.getParameter("COD_MAN"),true);
long lCOD_RSO=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Rischio"),request.getParameter("COD_RSO"),true);
long lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);
//-----
long lCOD_TPL_MIS_PET=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Adottata/Da.adottare"),request.getParameter("COD_TPL_MIS_PET"),true);
String strTPL_DSI_MIS_PET=c.checkString(ApplicationConfigurator.LanguageManager.getString("Destinatario.tutela"),request.getParameter("TPL_DSI_MIS_PET"),true);
long lVER_MIS_PET=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Versione.misura"),request.getParameter("VER_MIS_PET"),true);
String strADT_MIS_PET=c.checkTrigger(ApplicationConfigurator.LanguageManager.getString("Applicare"),request.getParameter("ADT_MIS_PET"));
java.sql.Date dtDAT_PAR_ADT=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.partenza"),request.getParameter("DAT_PAR_ADT"),false);
String strPER_MIS_PET=c.checkTrigger(ApplicationConfigurator.LanguageManager.getString("Periodicità.(S/N)"),request.getParameter("PER_MIS_PET"));
long lPNZ_MIS_PET_MES=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Pianificazione.mis.di.prev."),request.getParameter("PNZ_MIS_PET_MES"),false);
java.sql.Date dtDAT_PNZ_MIS_PET=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificazione"),request.getParameter("DAT_PNZ_MIS_PET"),false);

if (c.isError){
	String err = c.printErrors();
	out.print("<script>err=true;alert(\""+err+"\");</script>");
	return;
}
%>
<script src="../_scripts/Alert.js"></script>
<script>
  var err=false;
</script>
<%
//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
	IAssMisuraAttivitaHome home=(IAssMisuraAttivitaHome)PseudoContext.lookup("AssMisuraAttivitaBean");
	ReqMODE=request.getParameter("SBM_MODE");
  	if(ReqMODE.equals("edt"))
	{
		// gettinf of object 
		String strCOD_MIS_PET_MAN=request.getParameter("COD_MIS_PET_MAN");
		Long id=new Long(strCOD_MIS_PET_MAN);
		bean = home.findByPrimaryKey(id);
		bean.setCOD_TPL_MIS_PET(lCOD_TPL_MIS_PET);
		bean.setTPL_DSI_MIS_PET(strTPL_DSI_MIS_PET);
		bean.setVER_MIS_PET(lVER_MIS_PET);
		bean.setADT_MIS_PET(strADT_MIS_PET);
		bean.setDAT_PAR_ADT(dtDAT_PAR_ADT);
		bean.setPER_MIS_PET(strPER_MIS_PET);
		bean.setPNZ_MIS_PET_MES(lPNZ_MIS_PET_MES);
		bean.setDAT_PNZ_MIS_PET(dtDAT_PNZ_MIS_PET);
	}
//=======================================================================================
}
out.print("Saving ok");
%>
<script>
//------------------------------------------------
if(!err){	
	parent.returnValue="OK";
	Alert.Success.showSaved();
}else{
	parent.returnValue="ERROR";	
}	
//---------------------------------------------------	
</script>
