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
    <version number="1.0" date="19/02/2004" author="Mike Kondratyuk">
	      <comments>
				  <comment date="19/02/2004" author="Mike Kondratyuk">
				   <description>Shablon formi NUM_TEL_Set.jsp</description>
				 </comment>
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteTelefono/DipendenteTelefonoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteTelefono/DipendenteTelefonoBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%!
	String ReqMODE;	// parameter of request 
%>	
<script>
 var err=false;
 var isNew = false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>

<%
 IDipendenteTelefono bean=null;
 IDipendenteTelefonoHome beanHome=(IDipendenteTelefonoHome)PseudoContext.lookup("DipendenteTelefonoBean");

//-----start check section--------------------------------
Checker c = new Checker();
//---required fields
Long lngCOD_NUM_TEL_DPD = new Long(c.checkLong(ApplicationConfigurator.LanguageManager.getString("Contatto.telefonico"),request.getParameter("COD_NUM_TEL_AZL"), false));
long lCOD_DPD=c.checkLong("ID Dipedente",request.getParameter("COD_DPD"),true);
long lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);
String strTPL_NUM_TEL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Tipologia"),request.getParameter("TPL_NUM_TEL"), true); 
String strNUM_TEL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Numero"),request.getParameter("NUM_TEL"), true);

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
	// editing of azienda--------------------
		// gettinf of object 
		bean = beanHome.findByPrimaryKey(lngCOD_NUM_TEL_DPD);
		//getting of parameters and set the new object variables
		try{
			bean.setTPL_NUM_TEL__NUM_TEL__COD_DPD(strTPL_NUM_TEL, strNUM_TEL, lCOD_DPD);
		}catch(Exception ex){
			out.println("<script>Alert.Error.showDublicate();err=true</script>");
			return;
		}	
		bean.setCOD_AZL(lCOD_AZL);
  		//----------------------------
	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new azienda--------------------------
		// creating of object
		try{
			bean=beanHome.create(strTPL_NUM_TEL, strNUM_TEL, lCOD_DPD, lCOD_AZL);
			%><script>isNew=true;</script><%
		}catch(Exception ex){
			out.println("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}	
	}
%>
<script>
if (!err){
	if(isNew){
		Alert.Success.showCreated();
		parent.ToolBar.OnNew("ID=<%=bean.getCOD_NUM_TEL_DPD()%>");
	}else{
		Alert.Success.showSaved();
	}
}
</script>
<%}%>
