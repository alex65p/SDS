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
				 <comment date="27/01/2004" author="Treskina Maria">
						<description>Dobavlen kod dlya tabika s formy ANA_LOT_DPI_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.SchedeInterventoDPI.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
var err=false;
var isNew=false;
</script>

<%!	String ReqMODE;	// parameter of request%>

<%ISchedeInterventoDPI SchedeInterventoDPI=null;
long THIS_ID=0;

if(request.getParameter("SBM_MODE")!=null){
	ReqMODE=request.getParameter("SBM_MODE");
	Checker c = new Checker();
	
	//- checking for required fields
	//String strNOM_NAT_LES=c.checkString("Descrizioni",request.getParameter("NOM_NAT_LES"),true);   
  //	String         strCOD_SCH_INR_DPI="";              //1
  long lCOD_LOT_DPI=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Identificativo"),request.getParameter("COD_LOT_DPI"),true);
	if (lCOD_LOT_DPI==0)
	{
	  out.print("<script>parent.alert(arraylng[\"MSG_0083\"]);</script>");
		return;
	}
  long lCOD_TPL_DPI=c.checkLong("COD_TPL_DPI",request.getParameter("COD_TPL_DPI"),true);           //3
	String strTPL_INR_DPI=c.checkString(ApplicationConfigurator.LanguageManager.getString("Tipologia.d'intervento"),request.getParameter("TPL_INR_DPI"),true);            //4
        if (strTPL_INR_DPI.equals(""))
	{
	  out.print("<script>parent.alert(arraylng[\"MSG_0084\"]);</script>");
		return;
	}

	String strATI_INR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Attività.svolta"),request.getParameter("ATI_INR"),true);                //5
	java.sql.Date dtDAT_PIF_INR=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificata"),request.getParameter("DAT_PIF_INR"),true);        //6
	//-------------------------------------------------
  java.sql.Date dtDAT_INR=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.intervento"),request.getParameter("DAT_INR"),false);        //7
	String strESI_INR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Esito"),request.getParameter("ESI_INR"),false);                //8
	String strPBM_RSC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Problemi.riscontrati"),request.getParameter("PBM_RSC"),false);
	String strNOM_RSP_INR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Responsabile.intervento"),request.getParameter("NOM_RSP_INR"),false);  
	
	  if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}

//=======================================================================================
  if(ReqMODE.equals("edt"))
	{
		// editing of SchedeIntervento--------------------
		// gettinf of object 
		Long lCOD_SCH_INR_DPI=new Long(c.checkLong("SchedeIntervento ID",request.getParameter("COD_SCH_INR_DPI"),true));
  	if (c.isError){
			String err = c.printErrors();
			//out.println("<script>alert(\""+err+"\");</script>");
			return;
		}

		ISchedeInterventoDPIHome home=(ISchedeInterventoDPIHome)PseudoContext.lookup("SchedeInterventoDPIBean");
		SchedeInterventoDPI = home.findByPrimaryKey(lCOD_SCH_INR_DPI);
		//getting of parameters and set the new object variables
		SchedeInterventoDPI.setCOD_LOT_DPI(lCOD_LOT_DPI);
		SchedeInterventoDPI.setCOD_TPL_DPI(lCOD_TPL_DPI);
		SchedeInterventoDPI.setTPL_INR_DPI(strTPL_INR_DPI);
		SchedeInterventoDPI.setATI_INR(strATI_INR);
		SchedeInterventoDPI.setDAT_PIF_INR(dtDAT_PIF_INR);
		 THIS_ID=SchedeInterventoDPI.getCOD_SCH_INR_DPI();
		//----------
			}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new SchedeIntervento--------------------------
	// creating of object 
		ISchedeInterventoDPIHome home=(ISchedeInterventoDPIHome)PseudoContext.lookup("SchedeInterventoDPIBean");
		SchedeInterventoDPI=home.create(lCOD_LOT_DPI, lCOD_TPL_DPI, strTPL_INR_DPI, strATI_INR, dtDAT_PIF_INR);
	  THIS_ID=SchedeInterventoDPI.getCOD_SCH_INR_DPI();
		%>
		<script>isNew=true;</script>
		<%
	}
//=======================================================================================
  if (SchedeInterventoDPI!=null){
	//   *Not require Fields*
		SchedeInterventoDPI.setDAT_INR(dtDAT_INR);
		SchedeInterventoDPI.setESI_INR(strESI_INR);
		SchedeInterventoDPI.setPBM_RSC(strPBM_RSC);
		SchedeInterventoDPI.setNOM_RSP_INR(strNOM_RSP_INR);
	}
}
%>	
<script>
/*
	<comment date="27/01/2004" author="Treskina Maria">
		<description>Dobavlen kod dlya tabika s formy ANA_LOT_DPI_Form.jsp</description>
*/
//parent.alert(par);
if (!err){
  if(isNew)
	{
		Alert.Success.showCreated();
	}else{
		Alert.Success.showSaved();}
  if(isNew) {parent.ToolBar.OnNew("ID=<%=THIS_ID%>");
	}
}
</script>
