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

<%@ page import="com.apconsulting.luna.ejb.InfortuniIncidenti.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
	String ReqMODE;	// parameter of request 

	public String lpad(String str) {
		String mystring = "00";
		if (str.length() == 1) {
			mystring = "0" + str;
		}
		if (str.length() == 2) {
			mystring = str;
		}
		return mystring;
	}
%>

<script>
var err=false;
var isNew=false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
IInfortuniIncidenti bean=null;
//-----start check section--------------------------------
Checker c = new Checker();

long lCOD_INO=c.checkLong("COD_INO",request.getParameter("COD_INO"),true);
String strNOM_COM_INO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Competenza"),request.getParameter("NOM_COM_INO"),false);
java.sql.Date dtDAT_COM_INO=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.comunicazione.infortunio"),request.getParameter("DAT_COM_INO"),false);
java.sql.Date dtDAT_EVE_INO=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.evento"),request.getParameter("DAT_EVE_INO"),false);
String strORA_EVE_INO="";
try{
    strORA_EVE_INO=c.checkTime(ApplicationConfigurator.LanguageManager.getString("Ora.dell'evento.(hh.mm)"),lpad(request.getParameter("ORA_EVE_INO_HOUR"))+":"+lpad(request.getParameter("ORA_EVE_INO_MIN")),false);
}
catch(Exception e){
    e.printStackTrace(System.err);
}
String strGOR_LAV_INO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Giorno.lavorativo"),request.getParameter("GOR_LAV_INO"),false);
String strORA_LAV_INO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Ora"),request.getParameter("ORA_LAV_INO"),false);
String strORA_LAV_TUN_INO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Turno"),request.getParameter("ORA_LAV_TUN_INO"),false);
String strTPL_TRA_EVE_INO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Tipologia.trasporto"),request.getParameter("TPL_TRA_EVE_INO"),false);
String strIDZ_TRA_EVE_INO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Luogo.trasporto"),request.getParameter("IDZ_TRA_EVE_INO"),false);
java.sql.Date dtDAT_TRA_EVE_INO=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.trasporto"),request.getParameter("DAT_TRA_EVE_INO"),false);
java.sql.Date dtDAT_INZ_ASZ_LAV=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.inizio.assenza"),request.getParameter("DAT_INZ_ASZ_LAV"),false);
java.sql.Date dtDAT_FIE_ASZ_LAV=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.fine.assenza"),request.getParameter("DAT_FIE_ASZ_LAV"),false);
long lGOR_ASZ=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Giorni.assenza"),request.getParameter("GOR_ASZ"),false);
out.println("lGOR_ASZ:"+lGOR_ASZ);
String strIN_ITI = c.checkString(ApplicationConfigurator.LanguageManager.getString("In.itinere"), request.getParameter("IN_ITI"), false);
String strNON_IND = c.checkString(ApplicationConfigurator.LanguageManager.getString("Non.indennizzato"), request.getParameter("NON_IND"), false);
String strLUO_TRA = c.checkString(ApplicationConfigurator.LanguageManager.getString("Luogo.trasporto"), request.getParameter("LUO_TRA"), false);

// Dinamica incidente
String strDIN_INC_INO = c.checkString("", request.getParameter("DIN_INC_INO"), false);

// Codice Infortunio relazionato al precedente
long lCOD_INO_REL = c.checkLong("", request.getParameter("COD_REL_INO"), false);

String strMEZ_TRA = c.checkString(ApplicationConfigurator.LanguageManager.getString("Tipologia.trasporto"), request.getParameter("MEZ_TRA"), false);
java.sql.Date dtDAT_TRA=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.trasporto"),request.getParameter("DAT_TRA"),false);
String strDES_EVE_INO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione.evento"),request.getParameter("DES_EVE_INO"),false);
String strDES_ANL_INO=c.checkString("Analisi",request.getParameter("DES_ANL_INO"),false);
String strDES_CRZ_INO=c.checkString("Correzione",request.getParameter("DES_CRZ_INO"),false);
String strDES_RAC_INO=c.checkString("Raccomandazioni",request.getParameter("DES_RAC_INO"),false);
String strDES_DVU_INO=c.checkString("Divulgazione",request.getParameter("DES_DVU_INO"),false);
long lCOD_AGE_MAT=c.checkLong("Agenti materiali",request.getParameter("COD_AGE_MAT"),false);
long lCOD_TPL_FRM_INO=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Tipo.infortunio"),request.getParameter("COD_TPL_FRM_INO"), true);
long lCOD_NAT_LES=c.checkLong("Natura lesione",request.getParameter("COD_NAT_LES"), false);
long lCOD_SED_LES=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Sede.lesione"),request.getParameter("COD_SED_LES"),true);
long lCOD_LUO_FSC=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Luogo.fisico"),request.getParameter("COD_LUO_FSC"),true);
long lCOD_DPD=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Lavoratore"),request.getParameter("COD_DPD"),true);
long lCOD_AZL=c.checkLong("COD_AZL",request.getParameter("COD_AZL"),true);
if (strIN_ITI.equals("S")){
		 strIN_ITI="S";
	}
	else{
		 strIN_ITI="N";
	}
if (strNON_IND.equals("S")){
		 strNON_IND="S";
	}
	else{
		 strNON_IND="N";
	}

if (c.isError){
	String err = c.printErrors();
	out.print("<script>err=true;alert(\""+err+"\");</script>");
	return;
}

IInfortuniIncidentiHome home=(IInfortuniIncidentiHome)PseudoContext.lookup("InfortuniIncidentiBean");

//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
		bean = home.findByPrimaryKey(new Long(lCOD_INO));
		
 		bean.setCOD_AGE_MAT(lCOD_AGE_MAT);
		bean.setCOD_TPL_FRM_INO(lCOD_TPL_FRM_INO);
		bean.setCOD_NAT_LES(lCOD_NAT_LES);
		bean.setCOD_SED_LES(lCOD_SED_LES);
		bean.setCOD_LUO_FSC(lCOD_LUO_FSC);
		bean.setCOD_DPD(lCOD_DPD);
		bean.setCOD_AZL(lCOD_AZL);	
	}
	else{
		try{
			bean=home.create(lCOD_AGE_MAT, lCOD_TPL_FRM_INO, lCOD_NAT_LES, lCOD_SED_LES, lCOD_LUO_FSC, lCOD_DPD, lCOD_AZL);

			%><script>isNew=true;bRefresh=true;</script><%
		}
		catch(Exception ex){
			ex.printStackTrace(System.err);
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}
	if(bean!=null){
 		bean.setNOM_COM_INO(strNOM_COM_INO);
		bean.setDAT_COM_INO(dtDAT_COM_INO);
		bean.setDAT_EVE_INO(dtDAT_EVE_INO);
		bean.setORA_EVE_INO(strORA_EVE_INO);
		bean.setGOR_LAV_INO(strGOR_LAV_INO);
		bean.setORA_LAV_INO(strORA_LAV_INO);
		bean.setORA_LAV_TUN_INO(strORA_LAV_TUN_INO);
		bean.setTPL_TRA_EVE_INO(strTPL_TRA_EVE_INO);
		bean.setIDZ_TRA_EVE_INO(strIDZ_TRA_EVE_INO);
		bean.setDAT_TRA_EVE_INO(dtDAT_TRA_EVE_INO);
		bean.setDAT_INZ_ASZ_LAV(dtDAT_INZ_ASZ_LAV);
		bean.setDAT_FIE_ASZ_LAV(dtDAT_FIE_ASZ_LAV);
		bean.setGOR_ASZ(lGOR_ASZ);
		bean.setIN_ITI(strIN_ITI);
		bean.setNON_IND(strNON_IND);
		bean.setMEZ_TRA(strMEZ_TRA);
		bean.setDAT_TRA(dtDAT_TRA);
		bean.setLUO_TRA(strLUO_TRA);
                bean.setDIN_INC_INO(strDIN_INC_INO);
                bean.setCOD_INO_REL(lCOD_INO_REL);
		bean.setDES_EVE_INO(strDES_EVE_INO);
		bean.setDES_ANL_INO(strDES_ANL_INO);
		bean.setDES_CRZ_INO(strDES_CRZ_INO);
		bean.setDES_RAC_INO(strDES_RAC_INO);
		bean.setDES_DVU_INO(strDES_DVU_INO);
	}
}
%>
<script>
if (!err){
	if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=bean.getCOD_INO()%>");
		}else{
			Alert.Success.showSaved();
		}
}
</script>
