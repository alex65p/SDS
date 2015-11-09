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

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="s2s.luna.conf.ApplicationConfigurator" %>
<%@ page import="s2s.utils.Date.DateManager" %>
<%@ page import="s2s.luna.reports.Report_DOC_VAL_RSO" %>
<%@ page import="com.apconsulting.luna.ejb.ValutazioneRischi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp"%>
<%@ include file="../_include/Checker.jsp" %>
<%
    Checker c = new Checker();
    long lCOD_DOC_VLU = c.checkLong(ApplicationConfigurator.LanguageManager.getString("DVR"), request.getParameter("ID"), true);
    if (c.isError) {
%>
<html><body>
        <h2><%=c.printErrors()%></h2>
    </body></html>
<%
        return;
    }
    // Determino data e nome del DVR
    java.sql.Date dtDVR_DATE = DateManager.getCurrentSQLDate();
    String DATE_FORMAT_NOW = "yyyy-MM-dd HH:mm:ss";
    SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT_NOW);
    String strDVR_NAME = "DVR-"+sdf.format(dtDVR_DATE);
       
    // Genero il DVR
    out.clearBuffer();
    Report_DOC_VAL_RSO report = new Report_DOC_VAL_RSO();
    report.lCOD_DOC_VLU = lCOD_DOC_VLU;
    report.doReport4Generate(request, response, strDVR_NAME);
    
    // lo salvo nell'archivio
    IValutazioneRischiHome home = (IValutazioneRischiHome) PseudoContext.lookup("ValutazioneRischiBean");
    IValutazioneRischi bean = home.findByPrimaryKey(lCOD_DOC_VLU);
    bean.addCOD_ARC(strDVR_NAME, dtDVR_DATE, report.m_out.toByteArray());
%>
