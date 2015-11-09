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
    <version number="1.0" date="25/01/2004" author="Mike Kondratyuk">
	      <comments>
				  <comment date="25/01/2004" author="Mike Kondratyuk">
				   <description>Set dlya Formi ANA_CTL_SAN_Form.jsp</description>
				 </comment>
 			  <comment date="26/02/2004" author="Malyuk Sergey">
				   <description>Dinamicheskie tabi i ih reaalizaciia</description>
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
<%@ page import="com.apconsulting.luna.ejb.CartelleSanitarie.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
	String ReqMODE;	// parameter of request 
%>
<script>
  var err=false;
  var isNew=false;  
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
ICartelleSanitarie CartelleSanitarie=null;

if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	out.println(ReqMODE);

	Checker c = new Checker();
		
	//- checking for required fields		
	long			lCOD_CTL_SAN = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Cartella.sanitaria"),request.getParameter("CTL_SAN_ID"),true);            //1
	java.sql.Date	datDAT_CRE_CTL_SAN = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data"),request.getParameter("DAT_CRE_CTL_SAN"),true);        //2
	String			strNOM_MED_RSP_CTL_SAN = c.checkString(ApplicationConfigurator.LanguageManager.getString("Medico.competente"),request.getParameter("NOM_MED_RSP_CTL_SAN"),true);    //3
	long			lCOD_DPD = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dipendente"),request.getParameter("COD_DPD"),true);
	long			lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);
	out.print(lCOD_DPD);
	//- checking for not required fields		

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
		// editing of CartelleSanitarie--------------------
		// gettinf of object 
		String strCOD_CTL_SAN=request.getParameter("CTL_SAN_ID");					//ID of CartelleSanitarie
		ICartelleSanitarieHome home=(ICartelleSanitarieHome)PseudoContext.lookup("CartelleSanitarieBean");
		Long ctl_san_id=new Long(lCOD_CTL_SAN);
		CartelleSanitarie = home.findByPrimaryKey(ctl_san_id);
		CartelleSanitarie.setCOD_CTL_SAN(lCOD_CTL_SAN);            //1
		CartelleSanitarie.setDAT_CRE_CTL_SAN(datDAT_CRE_CTL_SAN);        //2
		CartelleSanitarie.setNOM_MED_RSP_CTL_SAN(strNOM_MED_RSP_CTL_SAN);    //3
		try{
                    CartelleSanitarie.setCOD_DPD(lCOD_DPD);
		}catch(Exception ex){
                    out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                    return;
		}
		CartelleSanitarie.setCOD_AZL(lCOD_AZL);
	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new CartelleSanitarie--------------------------
	// creating of object 
		ICartelleSanitarieHome home=(ICartelleSanitarieHome)PseudoContext.lookup("CartelleSanitarieBean");
		try{
			CartelleSanitarie=home.create(datDAT_CRE_CTL_SAN, strNOM_MED_RSP_CTL_SAN, lCOD_DPD, lCOD_AZL);
			%><script>isNew=true;</script><%
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}
//=======================================================================================
	if (CartelleSanitarie!=null){
	//   *No require Fields*
	}
}
%>
<script>
 	if(!err){	
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=CartelleSanitarie.getCOD_CTL_SAN()%>"); 
		}else{
	     Alert.Success.showSaved();
		}
	}else{
		//Alert.Error.showCreated();	
	}	
</script>
