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

<%@ include file="../_include/Global.jsp" %>
<%@ page import="s2s.luna.Toolbar.Toolbar"%>
<%
Toolbar ToolBar = new Toolbar(request );
%>
<%
if (DEBUG_TABS)  out.println("<style>.ifrm1{display:inline;}</style>");
	else out.println("<style>.ifrm1{display:none;}</style>");
if (DEBUG_FORM_IFRAME)  out.println("<style>.ifrmWork{display:inline; }</style>");
	else out.println("<style> .ifrmWork{display:none; } </style>");

%>
<script>
	var DEBUG_TABS_OPEN=<%=DEBUG_TABS_OPEN%>;		
</script>
