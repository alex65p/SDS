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
    < version number="1.0" date="27/01/2004" author="Artur Denysenko">
      < comments>
			   < comment date="27/01/2004" author="Artur Denysenko">
				   < description>Realizazija EJB dlia objecta MisurePreventProtettiveAz</description>
			   < /comment>
      < /comments>
    < /version>
  < /versions>
< /file>
*/
%>
<%@ page import="com.apconsulting.luna.ejb.MisurePreventProtettiveAz.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_include/Checker.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
	String ReqMODE;	// parameter of request
%>
<script>var err=false; var isNew=false;</script>
<script src="../_scripts/Alert.js"></script>
<%
IMisurePreventProtettiveAz bean=null;
//-----start check section--------------------------------
Checker c = new Checker();

long lCOD_MAN=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa"),request.getParameter("COD_MAN"),false);
long lCOD_RSO_LUO_FSC=c.checkLong("COD_RSO_LUO_FSC",request.getParameter("COD_RSO_LUO_FSC"),false);
long lCOD_RSO_MAN=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Rischio"),request.getParameter("COD_RSO_MAN"),false);
long lCOD_LUO_FSC=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Luogo.fisico"),request.getParameter("COD_LUO_FSC"),false);

if (lCOD_RSO_LUO_FSC==0 && lCOD_RSO_MAN==0){
	long check_COD_RSO = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Rischio"), null, true );
}
if (lCOD_LUO_FSC==0 && lCOD_MAN==0){
	long check_COD_MAN__LUO_FSC = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa/Luogo.fisico"), null, true );
}

long lCOD_MIS_PET_AZL=c.checkLong("COD_MIS_PET_AZL", request.getParameter("COD_MIS_PET_AZL"),true);
String strNOM_MIS_PET=c.checkString(ApplicationConfigurator.LanguageManager.getString("Misura"), request.getParameter("NOM_MIS_PET"),true);
java.sql.Date dtDAT_CMP=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.compilazione"), request.getParameter("DAT_CMP"),true);
long lVER_MIS_PET=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Versione"), request.getParameter("VER_MIS_PET"),true);
long lPNZ_MIS_PET_MES=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Pianificazione.mis.di.prev."), request.getParameter("PNZ_MIS_PET_MES"),false);
java.sql.Date dtDAT_PNZ_MIS_PET=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificazione"), request.getParameter("DAT_PNZ_MIS_PET"),true);
String strDES_MIS_PET=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"), request.getParameter("DES_MIS_PET"),false);
String strTPL_DSI_MIS_PET=c.checkString(ApplicationConfigurator.LanguageManager.getString("Destinatario.tutela"),request.getParameter("TPL_DSI_MIS_PET"),true);
String strSTA_MIS_PET=c.checkString("STA_MIS_PET",request.getParameter("STA_MIS_PET"),true);
if(strSTA_MIS_PET.length() == 0)
	strSTA_MIS_PET="D";
long lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);
long lCOD_TPL_MIS_PET=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Adottata/Da.adottare"),request.getParameter("COD_TPL_MIS_PET"),true);

String strPER_MIS_PET=c.checkTrigger(ApplicationConfigurator.LanguageManager.getString("Periodicità.(S/N)"),request.getParameter("PER_MIS_PET"));


if (c.isError){
	String err = c.printErrors();
	out.print("<script>alert(\""+err+"\");</script>");
	return;
}

IMisurePreventProtettiveAzHome home=(IMisurePreventProtettiveAzHome)PseudoContext.lookup("MisurePreventProtettiveAzBean");

//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
 try{
	ReqMODE=request.getParameter("SBM_MODE");
	out.println(ReqMODE);


	if(ReqMODE.equals("edt"))
	{
		bean = home.findByPrimaryKey(new Long(lCOD_MIS_PET_AZL));

 		bean.setNOM_MIS_PET(strNOM_MIS_PET);
		bean.setDAT_CMP(dtDAT_CMP);
		bean.setVER_MIS_PET(lVER_MIS_PET);
		bean.setPER_MIS_PET(strPER_MIS_PET);
		bean.setDAT_PNZ_MIS_PET(dtDAT_PNZ_MIS_PET);
		bean.setTPL_DSI_MIS_PET(strTPL_DSI_MIS_PET);
		bean.setSTA_MIS_PET(strSTA_MIS_PET);
		bean.setCOD_AZL(lCOD_AZL);
		bean.setCOD_TPL_MIS_PET(lCOD_TPL_MIS_PET);
		//--------------------------
	}
	else{
		bean=home.create(  strNOM_MIS_PET, dtDAT_CMP, lVER_MIS_PET, strPER_MIS_PET, dtDAT_PNZ_MIS_PET, strTPL_DSI_MIS_PET, strSTA_MIS_PET, lCOD_AZL, lCOD_TPL_MIS_PET);
		lCOD_MIS_PET_AZL=bean.getCOD_MIS_PET_AZL();
		%>
				<script>
					isNew=true;
				</script>
			<%
	}
	if(bean!=null){
		out.println("lCOD_RSO_MAN-"+lCOD_RSO_MAN+"<br>");
		out.println("lCOD_MAN-"+lCOD_MAN+"<br>");
		out.println("lCOD_RSO_LUO_FSC-"+lCOD_RSO_LUO_FSC+"<br>");
		out.println("lCOD_LUO_FSC-"+lCOD_LUO_FSC);

		bean.setPNZ_MIS_PET_MES(lPNZ_MIS_PET_MES);
		bean.setDES_MIS_PET(strDES_MIS_PET);
		bean.setCOD_RSO_LUO_FSC_COD_LUO_FSC(lCOD_RSO_LUO_FSC, lCOD_LUO_FSC);
		bean.setCOD_RSO_MAN_COD_MAN(lCOD_RSO_MAN,lCOD_MAN);
	}
  }
  catch(Exception ex){
			System.err.println("ANA_MIS_PET_AZL_Set.jsp");
			ex.printStackTrace(System.err);
  			%>
			<div id="divErr">
				<%=ex.getMessage()%>
			</div>
		<%
		out.print("<script>err=true;Alert.Error.showDublicate();</script>");
  }
}
%>
<script>

if (!err){
  Alert.Success.showSaved();
  if(isNew) parent.ToolBar.OnNew("ID=<%=lCOD_MIS_PET_AZL%>");
}
</script>
