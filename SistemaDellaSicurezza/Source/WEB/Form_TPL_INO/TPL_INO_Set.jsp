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
    <version number="1.0" date="29/01/2004" author="Podmasteriev Alexandr">
	  <comments>
				 <comment date="29/01/2004" author="Podmasteriev Alexandr">
				   <description>Shablon formi ANA_CPL_Form.jsp</description>
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

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>


<%@ include file="../src/com/apconsulting/luna/ejb/TipologieAccertamenti/TipologieAccertamentiBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TipologieAccertamenti/TipologieAccertamentiBean.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%!
	String ReqMODE;	// parameter of request
%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
 var isNew = false;
 var err=false;
</script>
<%
ITipologieAccertamenti TipologieAccertamenti=null;
long lCOD=0;
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");

		Checker c = new Checker();
		//- checking for required fields
		String strNOM_TPL_INO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("NOM_TPL_INO"),true);
		if (c.isError)
		{
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}
//=======================================================================================
  if(ReqMODE.equals("edt"))
	{
  	// editing of TipologieAccertamenti--------------------
		// gettinf of object
		ITipologieAccertamentiHome home=(ITipologieAccertamentiHome)PseudoContext.lookup("TipologieAccertamentiBean");

		Long CPL_ID=new Long(c.checkLong("TipologieAccertamenti ID",request.getParameter("CPL_ID"),true));

		if (c.isError)
		{
			String err = c.printErrors();
			out.print("for_id="+err);
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}
		TipologieAccertamenti = home.findByPrimaryKey(CPL_ID);
		//getting of parameters and set the new object variables

		try{
			TipologieAccertamenti.setNOM_TPL_INO(strNOM_TPL_INO);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new TipologieAccertamenti--------------------------
	// creating of object
		ITipologieAccertamentiHome home=(ITipologieAccertamentiHome)PseudoContext.lookup("TipologieAccertamentiBean");
	  out.print("<script>isNew=true;</script>");
		try{
		TipologieAccertamenti=home.create(strNOM_TPL_INO);
		}
		catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	lCOD=TipologieAccertamenti.getCOD_TPL_INO();

	}
//=======================================================================================
}
%>
<script>
 //JS peremennaja vistvliemaja v true esli bila sozdana new zapis'
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

 /*parent.window.returnValue="OK";
 parent.window.close();*/
</script>
