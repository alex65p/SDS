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
    <version number="1.0" date="08/03/2004" author="Roman Chumachenko">
	   <comments>
		  <comment date="08/03/2004" author="Roman Chumachenko">
			<description>SCH_EGZ_COR_Corso.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.Corsi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<% 
	long COD_SCH_COR=0;
	String COR_TPL="";
	String COR_DUR="";
	ICorsiHome home=(ICorsiHome)PseudoContext.lookup("CorsiBean");
	ICorsi bean=null;

if(request.getParameter("ID")!=null)
{
 	// getting parameters of azienda
	try{
		Long ID = new Long(request.getParameter("ID"));
		bean=home.findByPrimaryKey(ID);
		COR_TPL = bean.getCorsoTipologia();
		COR_DUR = Formatter.format( bean.getDUR_COR_GOR() );
		out.print("COR_TPL:"+COR_TPL+"<br>");
		out.print("COR_DUR:"+COR_DUR+"<br>");
	}
	catch(Exception ex){
		out.print("<b>"+ex.getMessage()+"</b>");
		return;
	}
}
%>
<div id="divContent">
</div>
<script>
	if (parent){
		parent.document.all["COR_TPL2"].value="<%=COR_TPL%>";
		parent.document.all["COR_DUR3"].value="<%=COR_DUR%>";
		parent.document.all["COD_COR"].value="<%=request.getParameter("ID")%>";
	}	
</script>


