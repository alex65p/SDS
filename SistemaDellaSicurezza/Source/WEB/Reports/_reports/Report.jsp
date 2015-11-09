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

<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>

<%@ page import="com.lowagie.text.*"%>
<%@ page import="com.lowagie.text.pdf.*"%>
<%@ page import="com.lowagie.text.pdf.PdfWriter"%>
<%@ page import="s2s.luna.conf.ApplicationConfigurator" %>

<%@ page import="s2s.report.MiddleTable" %>
<%@ page import="s2s.report.CenterMiddleTable" %>
<%@ page import="s2s.report.MyPageEvents" %>
<%@ page import="s2s.report.ZREPORT_SETTINGS" %>
<%@ page import="s2s.report.Report" %>
<%!
    public final ZREPORT_SETTINGS REPORT_SETTINGS= new ZREPORT_SETTINGS();
%>
