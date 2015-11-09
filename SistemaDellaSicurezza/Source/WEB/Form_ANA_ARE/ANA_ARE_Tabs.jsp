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
    <version number="1.0" date="17/02/2004" author="Mike Kondratyuk">
	      <comments>
				  <comment date="17/02/2004" author="Mike Kondratyuk">
				   <description>Create ANA_ARE_Tabs.jsp</description>
				  </comment>		
        </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.GestioniSezioni.*" %>
<%@ page import="com.apconsulting.luna.ejb.Capitoli.*" %>
<%@ page import="com.apconsulting.luna.ejb.Paragrafo.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="ANA_ARE_Util.jsp" %>
<script>
  var err=false;
//alert('<%=request.getParameter("TAB_NAME")%>');
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<div id="dContent">
<%
	IGestioniSezioni bean = null;
	IGestioniSezioniHome home=(IGestioniSezioniHome)PseudoContext.lookup("GestioniSezioniBean");

	long lCOD_ARE = new Long(request.getParameter("ID_PARENT")).longValue();
   bean = home.findByPrimaryKey(new Long(lCOD_ARE));
	long lCOD_AZL = bean.getCOD_AZL();

   out.print(lCOD_ARE+"<br>"+lCOD_AZL+"<br>"+request.getParameter("TAB_NAME")+"<br>");
   
	try{
    	if(request.getParameter("TAB_NAME").equals("tab1")){
			out.println(BuildGestioniSezioniTab(home, lCOD_ARE, lCOD_AZL));
    	}
		else{
			return;
		}
	}
	catch(Exception ex){
			out.print(printErrAlert("divErr", "Error.alert",ex));
			return;
	}
%>
</div>
<script>
 if (!err){
    parent.tabbar.ReloadTabTable(document);
 }
</script>
