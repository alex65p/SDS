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
    <version number="1.0" date="24/02/2004" author="Roman Chumachenko">
	   <comments>
		  <comment date="24/02/2004" author="Roman Chumachenko">
			<description>ANA_AZL_AttachDel.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.DittaEsterna.*" %>
<%@ page import="com.apconsulting.luna.ejb.SediAziendali.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp"%>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<%
	Long id_attachment;
	String strSubject=(String)request.getParameter("ATTACH_SUBJECT");
	id_attachment=new Long((String)request.getParameter("ID"));
    //-------------------------------------------------------------------------
	try{
		if ("DITTA".equals(strSubject))
		{
			IDittaEsternaHome de_home=(IDittaEsternaHome)PseudoContext.lookup("DittaEsternaBean");
			de_home.remove(id_attachment);
//			out.print("<script>Alert.Success.showDeleted();</script>");
			out.println("DELETING DITTA ESTERNA OK");
		}
		if ("SITA".equals(strSubject))
		{
			ISitaAziendeHome se_home=(ISitaAziendeHome)PseudoContext.lookup("SitaAziendeBean");
			se_home.remove(id_attachment);
//			out.print("<script>Alert.Success.showDeleted();</script>");
			out.println("DELETING SITA AZIENDE OK");
		}
	//-------------------------------------------------------------------
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showDelete", ex));
		return;
	}
%>
<script>
	Alert.Success.showDeleted();
	parent.del_localRow();
</script>
