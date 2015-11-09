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

<%@ page import="s2s.luna.reports.Report_REP_MAN" %>
<%@ page import="s2s.luna.conf.ApplicationConfigurator" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../../../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../../../src/com/apconsulting/luna/util/Security.jsp"%>
<%@ include file="../../../_include/Checker.jsp" %>
<%
    Checker c = new Checker();

    long lCOD_MAN=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Attività"), request.getParameter("ID"), true);
    long lCOD_AZL=Security.getAziendaR();

    if ( c.isError){
%>
        <html>
            <body>
                <h2><%=c.printErrors()%></h2>
            </body>
        </html>
<%
    return;
}
out.clearBuffer();
Report_REP_MAN report = new Report_REP_MAN(lCOD_MAN, lCOD_AZL);
report.bAttivitaSvolte=(1==c.checkLong("as", request.getParameter("as"), false));
report.bLuoghiLavoro=(1==c.checkLong("ldl", request.getParameter("ldl"), false));
report.bRischi=(1==c.checkLong("r", request.getParameter("r"), false));
report.bAgentiChimici=(1==c.checkLong("rch", request.getParameter("rch"), false));
report.bInformazioneFormazione=(1==c.checkLong("ief", request.getParameter("ief"), false));
report.bDocumentazione=(1==c.checkLong("d", request.getParameter("d"), false));
report.bDPI=(1==c.checkLong("dpi", request.getParameter("dpi"), false));
report.bMacchineAttrezature=(1==c.checkLong("ma", request.getParameter("dpi"), false));
 if (ApplicationConfigurator.isModuleEnabled(MODULES.ATT_LAV_MAC)){
report.bMacchineAttrezatureMansioni=(1==c.checkLong("mam", request.getParameter("mam"), false));}
report.bSorveglianzaSanitaria=(1==c.checkLong("ss", request.getParameter("ss"), false));
report.doReport(request, response);
%>
