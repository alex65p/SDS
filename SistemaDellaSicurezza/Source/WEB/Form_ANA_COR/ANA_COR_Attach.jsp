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
    <version number="1.0" date="27/02/2004" author="Mike Kondratyuk">		
      <comments>
			   <comment date="27/02/2004" author="Mike Kondratyuk">
				 	<description>attach file dla ANA_COR</description>
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
<%@ page import="com.apconsulting.luna.ejb.Corsi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>

<%
out.print("werwer");
	long id_attachment=0;
	
	ICorsi bean=null;
	ICorsiHome home=(ICorsiHome)PseudoContext.lookup("CorsiBean");
   
   String strID = (String)request.getParameter("ID_PARENT");
	try{
		bean = home.findByPrimaryKey(new Long(strID));
		id_attachment=Long.parseLong((String)request.getParameter("ID"));
	}
	catch(Exception ex){
		out.print("<script>Alert.Error.showNotFound</script>");
		return;
	}

	String strSubject=(String)request.getParameter("ATTACH_SUBJECT");
	
	try{
		if ("TES_VRF".equals(strSubject)){
			bean.addCOD_TES_VRF(id_attachment);
		}
		else if ("DOC".equals(strSubject)){
			bean.addCOD_DOC(id_attachment);
		}
		else{
			return;
		}
	}
	catch(Exception ex){
		out.print("<script>Alert.Error.showDublicateChild</script>");
		return;
	}
%>
<script>
	parent.ToolBar.Return.Do();
</script>
