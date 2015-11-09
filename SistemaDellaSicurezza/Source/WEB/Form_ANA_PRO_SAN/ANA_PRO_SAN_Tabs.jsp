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
    <version number="1.0" date="26/02/2004" author="Alexey Kolesnik">		
      <comments>
			   <comment date="26/02/2004" author="Alexey Kolesnik">
				ANAGRAFICA PROTOCOLLE SANITARE Tabs
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
<%@ page import="com.apconsulting.luna.ejb.ProtocoleSanitare.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="ANA_PRO_SAN_Util.jsp" %>

<script>
	var err = false;
</script>
<script src="../_scripts/Alert.js"></script>
<div id="dContent">
<%
 	long   lCOD_PRO_SAN = 0;					 //UID
	long   lCOD_AZL = Security.getAzienda();

	IProtocoleSanitare bean = null;
	IProtocoleSanitareHome home=(IProtocoleSanitareHome)PseudoContext.lookup("ProtocoleSanitareBean");

	String strID = (String)request.getParameter("ID_PARENT");
	try{
		bean = home.findByPrimaryKey(new ProtocoleSanitarePK(lCOD_AZL, new Long(strID).longValue() ));
		lCOD_PRO_SAN=bean.getCOD_PRO_SAN();
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}

try{
	if (bean!=null){	
		
		if(request.getParameter("TAB_NAME").equals("tab1")){
			out.println(BuildDocumenteSanitareTab(home, lCOD_AZL, Formatter.format(lCOD_PRO_SAN)));
		}
		
		else if(request.getParameter("TAB_NAME").equals("tab2")){
			out.println(BuildVisiteIdoneiteTab(home, lCOD_AZL, Formatter.format(lCOD_PRO_SAN)));
		}
		
		else if(request.getParameter("TAB_NAME").equals("tab3")){
			out.println(BuildVisiteMedicheTab(home, lCOD_AZL, Formatter.format(lCOD_PRO_SAN)));
		}
		
		else{
			return;
		}
	}
}
catch(Exception ex){
	out.print(printErrAlert("divErr", "Error.alert", ex));
	return;
}
%>
 </div>
 <script>
 if (!err){
	  parent.tabbar.ReloadTabTable(document);
 }	
 </script>
