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
    <version number="1.0" date="24/01/2004" author="Kushkarov Yura">
	      <comments>
				  <comment date="24/01/2004" author="Kushkarov Yura">
				   <description>Shablon formi ANA_ALA_Form.jsp</description>
				 </comment>
				 <comment date="04/02/2004" author="Kushkarov Yura">
				   <description>Izmenila dlya vyzova iz Anagrafica Presidi</description>
				 </comment>
      </comments>
    </version>
  </versions>
</file>
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.SchedeInterventoPSD.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<script>
var err=false;
var isNew=false;
</script>
<script src="../_scripts/Alert.js"></script>
<%!
  String ReqMODE;	// parameter of request%>

<%
ISchedeInterventoPSD SchedeInterventoPSD=null;
long THIS_ID=0;
long lCOD_PSD_ACD=0;
String strTPL_INR_PSD="";
String strATI_SVO="";
java.sql.Date dtDAT_PIF_INR=null;
java.sql.Date dtDAT_INR=null;
String strESI_INR="";
String strPBM_RSC="";
String strNOM_RSP_INR="";
out.print(request.getParameter("SBM_MODE"));
//
if(request.getParameter("SBM_MODE")!=null){
	ReqMODE=request.getParameter("SBM_MODE");
	Checker c = new Checker();

	//- checking for required fields
	lCOD_PSD_ACD=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Presidio"),request.getParameter("COD_PSD_ACD"),true);            //2
	strTPL_INR_PSD=c.checkString(ApplicationConfigurator.LanguageManager.getString("Tipologia.intervento"),request.getParameter("TPL_INR_PSD"),true);            											 //4
	strATI_SVO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Attività.svolta"),request.getParameter("ATI_SVO"),false);                //5
	dtDAT_PIF_INR=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificata"),request.getParameter("DAT_PIF_INR"),true);        //6
//	out.println("<script>parent.alert(\""+lCOD_PSD_ACD+"&"+strTPL_INR_PSD+"&"+dtDAT_PIF_INR+"\");</script>");
//-------------------------------------------------
  dtDAT_INR=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data"),request.getParameter("DAT_INR"),false);        //7
	strESI_INR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Esito.intervento"),request.getParameter("ESI_INR"),false);                //8
	strPBM_RSC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Problemi.riscontrati"),request.getParameter("PBM_RSC"),false);
	strNOM_RSP_INR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Responsabile"),request.getParameter("NOM_RSP_INR"),false);
	out.print("GET_PAR_OK");
	  if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}

//=======================================================================================
  if(ReqMODE.equals("edt"))
	{
	out.print("GO_EDIT");
		// editing of SchedeIntervento--------------------
		// gettinf of object
		Long lCOD_SCH_INR_PSD=new Long(c.checkLong("SchedeIntervento ID",request.getParameter("COD_SCH_INR_PSD"),true));
  	if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");err=true;</script>");
			return;
		}
		ISchedeInterventoPSDHome home=(ISchedeInterventoPSDHome)PseudoContext.lookup("SchedeInterventoPSDBean");
		SchedeInterventoPSD = home.findByPrimaryKey(lCOD_SCH_INR_PSD);
		//getting of parameters and set the new object variables
		SchedeInterventoPSD.setCOD_PSD_ACD(lCOD_PSD_ACD);
		SchedeInterventoPSD.setTPL_INR_PSD(strTPL_INR_PSD);
		SchedeInterventoPSD.setDAT_PIF_INR(dtDAT_PIF_INR);
		THIS_ID=SchedeInterventoPSD.getCOD_SCH_INR_PSD();
		//----------
			}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	out.print("GO_ADD");
	// new SchedeIntervento--------------------------
	// creating of object
		out.print("ll-"+request.getParameter("TPL_INR_PSD"));
		ISchedeInterventoPSDHome home=(ISchedeInterventoPSDHome)PseudoContext.lookup("SchedeInterventoPSDBean");
	try{
		SchedeInterventoPSD=home.create(lCOD_PSD_ACD, strTPL_INR_PSD, dtDAT_PIF_INR);
	}catch(Exception ex){
		out.println("<script>Alert.Error.showDublicate();err=true;</script>");
		return;
	}
		THIS_ID=SchedeInterventoPSD.getCOD_SCH_INR_PSD();
		%>
		<script>isNew=true;</script>
		<%
	}
//=======================================================================================
  if (SchedeInterventoPSD!=null){
	//   *Not require Fields*
		SchedeInterventoPSD.setATI_SVO(strATI_SVO);
		SchedeInterventoPSD.setDAT_INR(dtDAT_INR);
		SchedeInterventoPSD.setESI_INR(strESI_INR);
		SchedeInterventoPSD.setPBM_RSC(strPBM_RSC);
		SchedeInterventoPSD.setNOM_RSP_INR(strNOM_RSP_INR);
	}
}
if (SchedeInterventoPSD!=null)
{
%>
<script>
if (!err){
  if(isNew){
			Alert.Success.showCreated();
		}else{
			Alert.Success.showSaved();
			}
  //
	if(isNew) parent.ToolBar.OnNew("ID=<%=THIS_ID%>");
}
</script>
<%}%>
