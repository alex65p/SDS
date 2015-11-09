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

<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../../../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../../../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../../../src/com/apconsulting/luna/util/Security.jsp"%>

<%@ include file="../../../_include/Checker.jsp" %>
<%@ include file="../Report.jsp"%>

<%@ include file="REP_ANA_UNI_ORG.jsp"%>

<%
//==========================================================

Checker c = new Checker();
		
long lCOD_UNI_ORG=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Attività"), request.getParameter("ID"), true);


if ( c.isError){
	%>
		<html><body>
			<h2><%=c.printErrors()%></h2>
		</body></html>
	<%
	return;
}

out.clearBuffer();
Report_REP_ANA_UNI_ORG report = new Report_REP_ANA_UNI_ORG();

	report.lCOD_UNI_ORG=lCOD_UNI_ORG;
	
/*
	report.bAttivitaSvolte=(1==c.checkLong("as", request.getParameter("as"), false));
	report.bLuoghiLavoro=(1==c.checkLong("ldl", request.getParameter("ldl"), false));
	report.bRischi=(1==c.checkLong("r", request.getParameter("r"), false));
	report.bInformazioneFormazione=(1==c.checkLong("ief", request.getParameter("ief"), false));
	report.bDocumentazione=(1==c.checkLong("d", request.getParameter("d"), false));
	report.bDPI=(1==c.checkLong("dpi", request.getParameter("dpi"), false));
	report.bSorveglianzaSanitaria=(1==c.checkLong("ss", request.getParameter("ss"), false));
*/

report.doReport(request, response);
%>
