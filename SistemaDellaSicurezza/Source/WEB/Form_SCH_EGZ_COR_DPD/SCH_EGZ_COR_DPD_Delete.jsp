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
    <version number="1.0" date="25/01/2004" author="Kushkarov Yura">
	      <comments>
				  <comment date="25/01/2004" author="Kushkarov Yura">
				   <description>Shablon formi SCH_INR_PSD_Delete.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.SchedeInterventoPSD.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
	var err=false;
</script>
<%
ISchedeInterventoPSD SchedeInterventoPSD=null;
if(request.getParameter("ID")!=null)
{
	//
	String COD_SCH_INR_PSD_DEL=request.getParameter("ID");
	ISchedeInterventoPSDHome home=(ISchedeInterventoPSDHome)PseudoContext.lookup("SchedeInterventoPSDBean");
	Long lCOD_SCH_INR_PSD=new Long(COD_SCH_INR_PSD_DEL);
	try{
		home.remove(lCOD_SCH_INR_PSD);
	}catch(Exception ex){
		out.print("<script>Alert.Error.showDelete();err=true;</script>");
	}

	//
}
%>
<script>
	if (err)Alert.Error.showDelete();// alert(divErr.innerText);
	  else{
		  Alert.Success.showDeleted();
		  //parent.g_Handler.OnRefresh();
		  parent.ToolBar.OnDelete();
	  }
</script>
