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
    <version number="1.0" date="25/01/2004" author="Podmasteriev Alexandr">
	      <comments>
				  <comment date="25/01/2004" author="Podmasteriev Alexandr">
				   <description>Set dlya Formi ANA_ATI_MNT_MAC_Form.jsp</description>
				 </comment>
      </comments>
    </version>
  </versions>
</file>
*/
%>
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AttivaManutenzione.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
	String ReqMODE;	// parameter of request
%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
 var isNew = false;
 var err=false;
</script>
<%
IAttivaManutenzione AttivaManutenzione=null;
//long lCOD=0;

if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	//out.println(ReqMODE);

	Checker c = new Checker();

	//- checking for required fields
	long	 lCOD_MNT_MAC = c.checkLong("",request.getParameter("COD_MNT_MAC"),false);                                     //1
	String strDES_ATI_MNT_MAC = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione.attività"),request.getParameter("DES_ATI_MNT_MAC"),true);    //2
	long	 lCOD_MAC = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("COD_MAC"),true);                        //3
	//- checking for not required fields
  java.sql.Date	DAT_PAR_MNT_MAC = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.di.partenza"),request.getParameter("DAT_PAR_MNT_MAC"),false);     //4
  long	 lPER_ATI_MNT_MES = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Periodicità.mensile"),request.getParameter("PER_ATI_MNT_MES"),false);       //5
  String strATI_MNT_PER=c.checkString(ApplicationConfigurator.LanguageManager.getString("Attività.periodica"),request.getParameter("ATI_MNT_PER"),false);               //6
	if (strATI_MNT_PER.equals("S")){
		 strATI_MNT_PER="S";
	}
	else{
		 strATI_MNT_PER="N";
	}

	if (c.isError)
	{
		String err = c.printErrors();
//		err = err.replace('\"','\'');
		out.println("<script>alert(\""+err+"\");</script>");
		return;
	}
//=======================================================================================
  if(ReqMODE.equals("edt"))
	{
		// editing of AttivaManutenzione--------------------
		// gettinf of object
		String iCOD_MNT_MAC=request.getParameter("COD_MNT_MAC");					//ID of AttivaManutenzione
		IAttivaManutenzioneHome home=(IAttivaManutenzioneHome)PseudoContext.lookup("AttivaManutenzioneBean");
		Long ctl_san_id=new Long(lCOD_MNT_MAC);
		AttivaManutenzione = home.findByPrimaryKey(ctl_san_id);
		try{
				AttivaManutenzione.setDES_ATI_MNT_MAC(strDES_ATI_MNT_MAC);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
		try{
		AttivaManutenzione.setCOD_MAC(lCOD_MAC);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}

	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new AttivaManutenzione--------------------------
	// creating of object
		out.print("<script>isNew=true;</script>");
		IAttivaManutenzioneHome home=(IAttivaManutenzioneHome)PseudoContext.lookup("AttivaManutenzioneBean");
		try{
		AttivaManutenzione=home.create(strDES_ATI_MNT_MAC,lCOD_MAC);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}

	}
//=======================================================================================
	if (AttivaManutenzione!=null){
	//   *Not require Fields*
		AttivaManutenzione.setDAT_PAR_MNT_MAC(DAT_PAR_MNT_MAC);
		AttivaManutenzione.setPER_ATI_MNT_MES(lPER_ATI_MNT_MES);
		AttivaManutenzione.setATI_MNT_PER(strATI_MNT_PER);
		}
}
%>
<script>
  if (!err){
 						 if(isNew) {
						 					 Alert.Success.showCreated();
						 					 parent.ToolBar.OnNew("ID=<%=AttivaManutenzione.getCOD_MNT_MAC()%>");
						 }
						 else
						 {Alert.Success.showSaved();}
					}
</script>
