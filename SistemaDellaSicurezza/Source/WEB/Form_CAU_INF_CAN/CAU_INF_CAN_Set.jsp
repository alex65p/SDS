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
    <version number="1.0" date="24/01/2004" author="Podmasteriev Alexandr">
	  <comments>
				 <comment date="24/01/2004" author="Podmasteriev Alexandr">
				   <description>Shablon formi TPL_FRM_INO_Form.jsp</description>
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

<%@ page import="com.apconsulting.luna.ejb.CauseInfortuni.*" %>

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
var isNew=true;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
ICauseInfortuni causeinfortuni=null;
long lCOD=0;
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");

		Checker c = new Checker();
		//- checking for required fields
		String strTIP_TPL_FRM_INO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Tipo.di.infortunio"),request.getParameter("TIP"),true);
		String strNOM_TPL_FRM_INO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("NOM"),true);


	if (c.isError)
		{
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}
//=======================================================================================
  if(ReqMODE.equals("edt"))
	{
		// editing of TipologieFormeDinfortunio--------------------
		// gettinf of object
		out.print("<script>isNew=false;</script>");
		ICauseInfortuniHome home=(ICauseInfortuniHome)PseudoContext.lookup("CauseInfortuniBean");
		Long utn_id=new Long(c.checkLong("CauseInfortuni ID",request.getParameter("UTN_ID"),true));
		if (c.isError)
		{
			String err = c.printErrors();
			out.print("for_id="+err);
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}
		causeinfortuni = home.findByPrimaryKey(utn_id);
		//getting of parameters and set the new object variables

		try{
			causeinfortuni.setNOM_TPL_FRM_INO(strNOM_TPL_FRM_INO);
			causeinfortuni.setTIP_TPL_FRM_INO(strTIP_TPL_FRM_INO);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
		}
		}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new TipologieFormeDinfortunio--------------------------
	// creating of object
	try{
		ICauseInfortuniHome home=(ICauseInfortuniHome)PseudoContext.lookup("CauseInfortuniBean");
		causeinfortuni=home.create(strTIP_TPL_FRM_INO,strNOM_TPL_FRM_INO);
		lCOD=causeinfortuni.getCOD_TPL_FRM_INO();
	}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
		}
		}
//=======================================================================================
}
%>


<script>  //JS peremennaja vistvliemaja v true esli bila sozdana new zapis'

 	if(!err){
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=lCOD%>");
		}else{
			Alert.Success.showSaved();
		}
	}else{
	 	parent.returnValue="ERROR";
	}
</script>
