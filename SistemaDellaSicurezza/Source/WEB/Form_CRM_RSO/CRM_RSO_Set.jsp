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
    <version number="1.0" date="16/03/2004" author="Mike Kondratyuk">
      <comments>
			   <comment date="16/03/2004" author="Mike Kondratyuk">
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
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<script src="../_scripts/Alert.js"></script>

<%
	IRischioHome home=(IRischioHome)PseudoContext.lookup("RischioBean");

	long lCOD_AZL = Security.getAzienda();

	if("caricaDbRischi".equals(request.getParameter("LOCAL_MODE"))){

		String []ar_strCOD_RSO = request.getParameterValues("COD_RSO");

		int i, status = 0;

		if(ar_strCOD_RSO != null)
		{
			for(i = 0; i < ar_strCOD_RSO.length; i++)
			{
				long lCOD_RSO = new Long(ar_strCOD_RSO[i]).longValue();

				if(home.caricaDbRischi(lCOD_AZL, lCOD_RSO)){
					out.print(lCOD_RSO+" - OK");
					status++;
				}
				else{
					out.print(lCOD_RSO+" - Error");
				}
				out.print("<br>");
			}
			if(status == i){
				out.print("<script>Alert.Success.showAllRepositoryImport();</script>");
			}
			else if(status == 0){
				out.print("<script>Alert.Error.showErrorRepositoryImport();</script>");
			}
			else {
				out.print("<script>Alert.Success.showAllRepositoryImport("+status+");</script>");
			}
			out.print("<script>parent.goSearch();</script>");
		}
	}
	if("caricaRpRischi".equals(request.getParameter("LOCAL_MODE"))){
		String strNOM_RSO = request.getParameter("NOM_RSO");
		if(home.caricaRpRischi(lCOD_AZL, strNOM_RSO)){
			out.print(strNOM_RSO+" - OK");
			out.print("<script>Alert.Success.showRepositoryExport();</script>");
		}
		else{
			out.print(strNOM_RSO+" - Error");
			out.print("<script>Alert.Error.showErrorRepositoryExport();</script>");
		}
	}
%>
