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
    <version number="1.0" date="05/03/2004" author="Roman Chumachenko">
	      <comments>
				  <comment date="05/03/2004" author="Roman Chumachenko">
				   <description>REP_PNG_GRD_Report.jsp</description>
				 </comment>
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="s2s.luna.reports.Report_SCH_DBT_FRM" %>

<%@ include file="../../../src/com/apconsulting/luna/util/Security.jsp"%>

<%@ include file="../../../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../../../src/com/apconsulting/luna/util/FormatterPlain.jsp"%>
<%@ include file="../../../_include/Checker.jsp" %>
<%@ include file="../Report.jsp"%>

<%
Checker c = new Checker();
String NOM_MAN=c.checkString(ApplicationConfigurator.LanguageManager.getString("Attivit�.lavorativa"), request.getParameter("COD_ATT"), true);
if (c.isError){
	%>
	<html><body>
		<h2><%=c.printErrors()%></h2>
	</body></html>
	<%
	return;
}
out.clearBuffer();
Report_SCH_DBT_FRM report = new Report_SCH_DBT_FRM(NOM_MAN);
report.doReport(request, response);
%>
