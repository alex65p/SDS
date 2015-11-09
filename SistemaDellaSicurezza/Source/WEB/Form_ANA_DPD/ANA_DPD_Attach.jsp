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
    <version number="1.0" date="20/02/2004" author="Mike Kondratyuk">		
      <comments>
			   <comment date="20/02/2004" author="Mike Kondratyuk">
				 	<description>attach file dla ANA_DPD</description>
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
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<script src="../_scripts/Alert.js"></script>
<%
	long id_attachment=0;
	
	IDipendente bean=null;
	String strID = (String)request.getParameter("ID_PARENT");
	try{
		IDipendenteHome home=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
		bean = home.findByPrimaryKey(new Long(strID));
		id_attachment=Long.parseLong((String)request.getParameter("ID"));
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}

	String strSubject=(String)request.getParameter("ATTACH_SUBJECT");
	
	try{
		if ("PCS_FRM".equals(strSubject)){
			bean.addCOD_PCS_FRM(id_attachment);
		}
/*		else if ("LOTTIDPI".equals(strSubject)){
			//bean.addCOD_DOC(id_attachment);
		}
		else if ("AGENTICHIMICI".equals(strSubject)){
			bean.addCOD_SOS_CHI(id_attachment);
		}
		else if ("MACCHINA".equals(strSubject)){
			bean.addCOD_MAC(id_attachment);
		}*/
	else if ("MAN_DPD".equals(strSubject)){
/*			 	String strCOD_UNI_ORG=strID.substring(0,strID.indexOf('|'));
				String strCOD_MAN=strID.substring(strID.indexOf('|')+1,strID.length());
  			lCOD_UNI_ORG=new Long(strCOD_UNI_ORG).longValue();
				lCOD_MAN=new Long(strCOD_MAN).longValue();
			bean.addCOD_MAN(id_attachment);*/		
		}

		else{
			return;
		}
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showDublicateChild", ex));
		return;
	}
%>
<script>
//alert("<%=strSubject %>");
	parent.ToolBar.Return.Do();
</script>
