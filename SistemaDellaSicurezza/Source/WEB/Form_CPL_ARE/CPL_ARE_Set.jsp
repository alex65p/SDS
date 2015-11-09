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
	<version number="1.0" date="06/02/2004" author="Mike Kondratyuk">
	  <comments>
			   <comment date="06/02/2004" author="Mike Kondratyuk">
				   <description>Dobavlenie linki.</description>
			   </comment>
	  </comments>
	</version>
  </versions>
</file>
*/
%>
<%@ page import="com.apconsulting.luna.ejb.GestioniSezioni.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script>
var err=false;
var isNew=false;
</script>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%!
	String ReqMODE;	// parameter of request
%>
<%
long	lCOD_ARE = 0;
long	lCOD_AZL = 0;
long 	lCOD_CPL = 0;
String	strDES_CPL_ARE = "";
long	lPRIORITY = 0;

if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");

	IGestioniSezioni GestioniSezioni = null;
	IGestioniSezioniHome home=(IGestioniSezioniHome)PseudoContext.lookup("GestioniSezioniBean");

	Checker c = new Checker();

	if(request.getParameter("ID_PARENT")!=null)
	{
		lCOD_ARE = (new Long(request.getParameter("ID_PARENT"))).longValue();

		Long are_id=new Long(lCOD_ARE);
		GestioniSezioni = home.findByPrimaryKey(are_id);

		lCOD_CPL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Capitolo"), request.getParameter("ID"), true);
		strDES_CPL_ARE = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"), request.getParameter("DES_CPL_ARE"), false);
		lPRIORITY = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Priorità"), request.getParameter("PRIORITY"), false);

		if (c.isError){
			String err = c.printErrors();
			out.print("<script>alert(\""+err+"\");</script>");
			return;
		}

		if(ReqMODE.equals("edt"))
		{
	  		try{
  				GestioniSezioni.editCOD_CPL(lCOD_CPL, strDES_CPL_ARE, lPRIORITY);
  			}catch(Exception ex){
  				out.println("<script>Alert.Error.showDublicate();err=true;</script>");
  				return;
  			}
		}
		else
		{
			%><script type="text/javascript">isNew=true;</script><%
			try{
				GestioniSezioni.addCOD_CPL(lCOD_CPL, strDES_CPL_ARE, lPRIORITY);
			}catch(Exception ex){
				out.println("<script>Alert.Error.showDublicate();err=true;</script>");
				return;
			}
		}
	}
}
%>
<script type="text/javascript">
<!--
	if(!err)
	{
		parent.window.returnValue="OK";
		if(isNew) {
		  Alert.Success.showCreated();
		  parent.ToolBar.OnNew("ID=<%=lCOD_CPL%>");
		} else {
		  Alert.Success.showSaved();
		  parent.ToolBar.Exit.setEnabled(false);
		  parent.ToolBar.Return.setEnabled(true);
		}
	}
	else
	{
		parent.window.returnValue="ERROR";
	}
// -->
</script>
