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
    <version number="1.0" date="09/02/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="09/02/2004" author="Khomenko Juliya">
				   <description></description>
				  </comment>		
        </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.SchedeParagrafo.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.GestioniSezioni.*" %>
<%@ page import="com.apconsulting.luna.ejb.Capitoli.*" %>
<%@ page import="com.apconsulting.luna.ejb.Paragrafo.*" %>
<%@ page import="com.apconsulting.luna.ejb.GestioneTabellare.*" %>
<%@ page import="com.apconsulting.luna.ejb.Collegamenti.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="ANA_PRG_Util.jsp" %>
<%
long           	lCOD_ARE=0;
long 				lCOD_AZL=0;
long 				lCOD_CPL=0;

String				Script="";
	
IGestioniSezioniHome GestioniSezioniHome=(IGestioniSezioniHome)PseudoContext.lookup("GestioniSezioniBean");
IGestioniSezioni GestioniSezioni;

if( request.getParameter("ID")!=null)
{
	if(!request.getParameter("ID").equals("")){
   	lCOD_ARE = new Long (request.getParameter("ID")).longValue();
   }
	lCOD_AZL = new Long (request.getParameter("AZL")).longValue();
	lCOD_CPL = new Long (request.getParameter("SEL")).longValue();
%>
<div id="sel"><select id="CAPITOLO" name="COD_CPL" style="width:556" <%=("true".equals(request.getParameter("PAR")))?"disabled":""%>><%=RebuildCapitoloComboBox(GestioniSezioniHome, lCOD_ARE, lCOD_AZL, lCOD_CPL)%></select></div>
<script>
parent.document.all['sel'].innerHTML = document.all['sel'].innerHTML; 
//alert(<%//=strDES_CPL_ARE%>);
//	parent.document.all['CAPITOLO'].value='<%//=strDES_CPL_ARE%>';
//	parent.document.all['COD_CPL'].value='<%//=lCOD_CPL%>';	
</script>
<%
}
%>
