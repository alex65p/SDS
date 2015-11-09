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
    <version number="1.0" date="29/01/2004" author="Roman Chumachenko">
	      <comments>
				  <comment date="29/01/2004" author="Roman Chumachenko">
				   <description>NUM_TEL_DTE_Set.jsp</description>
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

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/DittaEsternaTelefono/DittaEsternaTelefonoBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/DittaEsternaTelefono/DittaEsternaTelefonoBean.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>


<%!
	String ReqMODE;	// parameter of request 
%>	
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
  var err=false;
  var isNew=false;  
</script>
<%
IDittaEsternaTelefono Tel=null;
IDittaEsternaTelefonoHome TelHome=(IDittaEsternaTelefonoHome)PseudoContext.lookup("DittaEsternaTelefonoBean");
//-----start check section--------------------------------
Checker c = new Checker();
//---required fields
 Long COD_NUM_TEL_DTE = new Long(c.checkLong(ApplicationConfigurator.LanguageManager.getString("Contatto.telefonico"),request.getParameter("COD_NUM_TEL_DTE"), false));
 long COD_DTE=c.checkLong("ID Ditta Esterna",request.getParameter("COD_DTE"),true);
 String TPL_NUM_TEL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Tipologia"),request.getParameter("TPL_NUM_TEL"), true); 
 String NUM_TEL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Numero"),request.getParameter("NUM_TEL"), true);

if (c.isError){
	String err = c.printErrors();
	%><script>alert("<%=err%>");</script><%
	return;
}
//------end check section--------------------------------

if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
	// editing --------------------
		out.println("edt");
		// gettinf of object 
		Tel = TelHome.findByPrimaryKey(COD_NUM_TEL_DTE);
		//getting of parameters and set the new object variables
		try{
			Tel.setTPL_NUM_TEL__NUM_TEL__COD_DTE(TPL_NUM_TEL, NUM_TEL, COD_DTE);
		}catch(Exception ex){
			out.println("<script>Alert.Error.showDublicate();</script>");
			return;
		}	
	}
//=======================================================================================
if(ReqMODE.equals("new"))
{
// new --------------------------
	out.println("new");
	// creating new
	try{
		Tel=TelHome.create(TPL_NUM_TEL, NUM_TEL, COD_DTE);
		%><script>isNew=true;</script><%
	}catch(Exception ex){
		out.println("<script>Alert.Error.showDublicate();</script>");
		return;
	}
}
%>
<script>
 if (!err){  
 	if(isNew) {Alert.Success.showCreated();
		parent.ToolBar.OnNew("ID=<%=Tel.getCOD_NUM_TEL_DTE()%>");
	}else{
		Alert.Success.showSaved(); 
	}
}
</script>
<%}%>
