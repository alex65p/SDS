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
    <version number="1.0" date="11/02/2004" author="Artur Denysenko">		
      <comments>
			   <comment date="11/02/2004" author="Artur Denysenko">
				Associate documents and Normative sentenze to Misure preventive
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
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<script src="../_scripts/Alert.js"></script>
<%
	long id_attachment=0;
	long lCOD_AZL = 0;
	String strID = (String)request.getParameter("ID_PARENT");
	
	IUnitaOrganizzativa bean=null;	
	Collection col;
	Iterator it;
	
	out.println(request.getParameter("ID"));
	out.println(strID);
	try{
		IUnitaOrganizzativaHome home=(IUnitaOrganizzativaHome)PseudoContext.lookup("UnitaOrganizzativaBean");	
		Long id=new Long(strID);
		bean = home.findByPrimaryKey(id);
		id_attachment=Long.parseLong((String)request.getParameter("ID"));
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}

	String strSubject=(String)request.getParameter("ATTACH_SUBJECT");
	
	try{
		if ("LUO_FSC_UNI".equals(strSubject)){
			bean.addLuogoFisico(id_attachment);
			//return;
		}
		if ("MAN_UNI".equals(strSubject)){
			out.println("attivita lavorativa");
			bean.addAttivitaLavorativa(id_attachment);
		}
		
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showDublicateChild", ex));
		return;
	}
%>
<script>
	//parent.ToolBar.Return.Do();
</script>
