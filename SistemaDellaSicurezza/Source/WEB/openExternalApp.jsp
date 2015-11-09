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

<%@page import="s2s.utils.text.StringManager"%>
<%@page import="s2s.luna.conf.ApplicationConfigurator"%>
<%@ page import="java.io.*" %>
<%
    String appToLaunch = request.getParameter("App");
    if (appToLaunch.equals("Firefox")){
        appToLaunch = 
            "Firefox-Portable-3.5.19-for-BO-XI-3.1" + File.separator + 
            "FirefoxPortable.exe";
        String appParameter = request.getParameter("Par1");
        if (StringManager.isNotEmpty(appParameter)){
            appToLaunch += " " + StringManager.doubleQuote(appParameter);
        }
    }
    String SdSAppPath = 
            ApplicationConfigurator.getApplicationPath() + 
            "WEB" + File.separator + appToLaunch;
    Runtime runTime = Runtime.getRuntime();
    try {
        runTime.exec(SdSAppPath);
    } catch (IOException e) {
        e.printStackTrace();
    }
%>
