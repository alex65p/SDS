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
    <version number="1.0" date="03/03/2004" author="Roman Chumachenko">
	   <comments>
		  <comment date="03/03/2004" author="Roman Chumachenko">
			<description>AZN_CRR_PET_Interventi.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.InterventoAudut.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<% 
	long COD_INR_ADT=0;
	String DES_INR_ADT="";
	IInterventoAudutHome home=(IInterventoAudutHome)PseudoContext.lookup("InterventoAudutBean");
	IInterventoAudut bean=null;

if(request.getParameter("ID")!=null)
{
 	// getting parameters of azienda
	try{
		Long ID = new Long(request.getParameter("ID"));
		bean=home.findByPrimaryKey(ID);
		COD_INR_ADT = bean.getCOD_INR_ADT();
		DES_INR_ADT = bean.getDES_INR_ADT();
	}
	catch(Exception ex){
		out.print("<strong>"+ex.getMessage()+"</strong>");
		return;
	}
}
%>
<div id="divContent">
</div>
<script>
	if (parent){
		parent.document.all["COD_INR_ADT"].value="<%=Formatter.format(COD_INR_ADT)%>";
		parent.document.all["DES_INR_ADT"].value="<%=Formatter.format(DES_INR_ADT)%>";
	}	
</script>


