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
    <version number="1.0" date="16/01/2004" author="Pogrebnoy Yura">
	      <comments>
			  <comment date="16/01/2004" author="Pogrebnoy Yura">
				   <description>Shablon formi ANA_ALA_Form.jsp</description>
			  </comment>
      </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ include file="../../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../../_menu/menu/menuStructure.jsp" %>
<html>
<head>
<LINK REL=STYLESHEET HREF="../../_styles/style.css" TYPE="text/css">
</head>
<body style="margin:0 0 0 0;">
    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:50%;">
        <tr>
            <td align="center" style="font-size:large;">
                <a href="Analisi Infortuni Tecnici.pdf" target="_Rep1">Analisi Infortuni Tecnici</a>
            </td>
        </tr>
        <tr>
            <td align="center" style="font-size:large;">
                <a href="Analisi Infortuni Tecnici - Drill.pdf" target="_Rep2">Analisi Infortuni Tecnici - Drill</a>
            </td>
        </tr>
        <tr>
            <td align="center" style="font-size:large;">
                <a href="Analisi Infortuni per Tipologia.pdf" target="_Rep3">Analisi Infortuni per Tipologia</a>
            </td>
        </tr>
    </table>
</body>
</html>
