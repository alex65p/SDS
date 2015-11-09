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
    <version number="1.0" date="23/01/2004" author="Treskina Maria">
	      <comments>
				  <comment date="23/01/2004" author="Treskina Maria">
				   <description>Forma dla NUM_TEL_FOR_AZL_TAB - FornitoreTelefono</description>
				  </comment>
					<comment date="18/02/2004" author="Treskina Maria">
				   <description>izmenenie vivoda ob soobshenij</description>
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
<script src="../_scripts/Alert.js"></script>

<%@ include file="../src/com/apconsulting/luna/ejb/FornitoreTelefono/FornitoreTelefonoBean_Interfaces.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/FornitoreTelefono/FornitoreTelefonoBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>


<%!
	String ReqMODE;	// parameter of request 
%>	

<script>
var err=false;
var isNew=false;
</script>
<%

IFornitoreTelefono Tel=null;
IFornitoreTelefonoHome TelHome=(IFornitoreTelefonoHome)PseudoContext.lookup("FornitoreTelefonoBean");
//-----start check section--------------------------------
Checker c = new Checker();

//---required fields
Long lngCOD_NUM_TEL_FOR_AZL = new Long(c.checkLong(ApplicationConfigurator.LanguageManager.getString("Contatto.telefonico"),request.getParameter("COD_NUM_TEL_FOR_AZL"), false));
long lCOD_FOR_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_FOR_AZL"),true);
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
		out.println("edt");
		// gettinf of object 
		
		Tel = TelHome.findByPrimaryKey(lngCOD_NUM_TEL_FOR_AZL);
		//getting of parameters and set the new object variables
		try{
			Tel.setTPL_NUM_TEL__NUM_TEL__COD_FOR_AZL(strTPL_NUM_TEL, strNUM_TEL, lCOD_FOR_AZL);		//1
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}	
  		//----------------------------
	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new azienda--------------------------
		out.println("new");
		// creating of object 
		try{
		Tel=TelHome.create(strTPL_NUM_TEL, strNUM_TEL, lCOD_FOR_AZL);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
		out.print("<script>isNew=true;</script>");
	}
}
%>
<script>
if (!err){
	if(isNew){
		Alert.Success.showCreated();
		parent.ToolBar.OnNew("ID=<%=Tel.getCOD_NUM_TEL_FOR_AZL()%>");
	}else{
		Alert.Success.showSaved();
	}
}
</script>

