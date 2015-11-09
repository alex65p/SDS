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
    <version number="1.0" date="26/02/2004" author="Roman Chumachenko">
	      <comments>
				  <comment date="26/02/2004" author="Roman Chumachenko">
				   <description>GEST_RSO_MAN_Set.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.RischioFattore.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%!
	String ReqMODE;	// parameter of request 
%>	
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
	var err=false;
</script>
<%
try{
	IRischioFattoreHome home=(IRischioFattoreHome)PseudoContext.lookup("RischioFattoreBean");
	Iterator it=null;
	Checker c = new Checker();
	long lCOD_MAN=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa"),request.getParameter("COD_MAN"), true);
	long lCOD_AZL = Security.getAzienda();
	java.util.ArrayList arlist =  c.checkAlLong(ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio"),request.getParameterValues("CHK_ITEM"));
	
	out.println(lCOD_MAN);
	if (c.isError){
		String err = c.printErrors();
		%><script>alert("<%=err%>");</script><%
		return;
	}
	//-- array of ids ---
	home.deleteFattoriRischiByAttivita(lCOD_AZL, lCOD_MAN);
	
	it = arlist.iterator();
	if (it!=null){	
		while (it.hasNext()){
			Long lCOD_FAT_RSO = (Long)it.next();
			home.addFattoreRischioPerAttivita(lCOD_AZL, lCOD_MAN, lCOD_FAT_RSO.longValue());
			out.print(lCOD_FAT_RSO +"<br>");
		}
	}	
}
catch(Exception ex){
	%>
	<script>
		err=true;
	Alert.Error.showDublicate();
	</script>	
	<%
}
//=====================================================================
%>
<script>
 	if(!err){	
		parent.returnValue="OK";
		Alert.Success.showSaved();
		parent.ToolBar.Return.Do();
	}else{
		parent.returnValue="ERROR";	
	}	
</script>
