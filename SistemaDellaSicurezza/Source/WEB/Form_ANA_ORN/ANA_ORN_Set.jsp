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
    <version number="1.0" date="16/01/2004" author="Pogrebnoy Yura">
	      <comments>
				  <comment date="16/01/2004" author="Pogrebnoy Yura">
				   <description>Shablon formi ANA_ORN_Form.jsp</description>
				 </comment>
      </comments>
    </version>
  </versions>
</file>
*/
%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/Organi/OrganiBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/Organi/OrganiBean.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script>
 var err = false;
 var isNew = false;
</script>
<%!	String ReqMODE;	// parameter of request%>

<%IOrgani organi=null;
long COD_ORN=0;
String strDES_ORN="";
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	Checker c = new Checker();
	//- checking for required fields
	String strNOM_ORN=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"),request.getParameter("NOM_ORN"),true);

	//- checking for not required fields
	strDES_ORN=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_ORN"),false);
	  if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\"); err=true; </script>");
			return;
		}

//=======================================================================================
  
	if(ReqMODE.equals("edt"))
	{
		Long lCOD_ORN=new Long(c.checkLong("Organi ID",request.getParameter("COD_ORN"),true));
  	if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\"); err=true; </script>");
			return;
		}
		IOrganiHome home=(IOrganiHome)PseudoContext.lookup("OrganiBean");
		organi = home.findByPrimaryKey(lCOD_ORN);
		//getting of parameters and set the new object variables
		organi.setNOM_ORN(strNOM_ORN);
		COD_ORN=organi.getCOD_ORN();
	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
		try{
		IOrganiHome home=(IOrganiHome)PseudoContext.lookup("OrganiBean");
		organi=home.create(strNOM_ORN);
		COD_ORN=organi.getCOD_ORN();
		%>
		<script>isNew=true;</script>
		<%
		}
		catch(Exception ex){out.print("<script>Alert.Error.showDublicate(); err=true;</script>");}
	}
//=======================================================================================

  if (organi!=null){
	//   *Not require Fields*
		organi.setDES_ORN(strDES_ORN);
  }
%>
<script>
if (!err){
if(isNew){
			Alert.Success.showCreated();
		}else{
			Alert.Success.showSaved();}
  if(isNew) parent.ToolBar.OnNew("ID=<%=COD_ORN%>");
}
</script>
<% }%>
