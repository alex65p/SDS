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

<%@page import="s2s.luna.conf.ApplicationConfigurator"%>
<%!
public final static String APP_DB_VERSION="6.0.1 ";
public final static String APP_VERSION="6.0.1.0";
public final static String APP_WINDOW_TITLE="Sistema della Sicurezza - Rel. " + APP_VERSION;
public final static String APP_VIRTUAL_PATH=ApplicationConfigurator.getContextPath();
%>
<%
    



/*public static final*/ boolean DEBUG=false;
/*public /*static final*/ boolean DEBUG_TABS=DEBUG;
/*public /*static final*/ boolean DEBUG_FORM_IFRAME=DEBUG;
/*public /*static final*/ boolean DEBUG_TABS_OPEN=DEBUG;
/*public /*static final*/ boolean RELEASE=!DEBUG;

if(request.getParameter("DEBUG")!=null){
	session.setAttribute("DEBUG", "1");
}

if(session.getAttribute("DEBUG")!=null){
	DEBUG=true;
	DEBUG_TABS=false;
	DEBUG_TABS_OPEN=true;
	DEBUG_FORM_IFRAME=true;
	RELEASE=!DEBUG;
}
%>
