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
    <version number="1.0" date="22/03/2004" author="Malyuk Sergey">
      <comments>
			   <comment date="22/03/2004" author="Malyuk Sergey">
				   <description>CRM_RSO_Set.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.Capitoli.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

 <script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
var err=false;
</script> 
<%
	ICapitoliHome home=(ICapitoliHome)PseudoContext.lookup("CapitoliBean");
	ICapitoli Capitoli=null;
	String []ar_strCOD_CPL_R = request.getParameterValues("COD_CPL_R");
	String nom_cpl="";
	long colvo=0;
	if(ar_strCOD_CPL_R != null)
	{
		for(int i = 0; i < ar_strCOD_CPL_R.length; i++)
		{
			long lCOD_CPL_R = new Long(ar_strCOD_CPL_R[i]).longValue();
			nom_cpl=home.getCaricaDbCapitoli(lCOD_CPL_R);
			try
			 {
			 	Capitoli=home.create(nom_cpl);
 			 	Capitoli.setCOD_CPL_R(lCOD_CPL_R);
				colvo=colvo+1;
			 }
	catch(Exception ex){
			if (colvo==0)
				 {
				 	out.print("<script>Alert.Error.showErrorRepositoryImport();err=true;</script>");
				 }else
				 {
				 	out.print("<script>Alert.Success.showRepositoryImport('"+colvo+" ');err=true;</script>");
				 }
			return;
		}
		}
	}
%>
<script>
if (err==false)
	 {
	 Alert.Success.showAllRepositoryImport();
	 }
</script>
