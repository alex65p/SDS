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
<%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
            response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server

%>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="ANA_SGZ_Utils.jsp"%>
<%
    long COD_AZL = Long.parseLong(request.getParameter("COD_AZL"));
    long COD_LUO_FSC = Long.parseLong(request.getParameter("COD_LUO_FSC"));
    long COD_IMM_3LV = Long.parseLong(request.getParameter("COD_IMM_3LV"));
%>
<select tabindex="9" name="COD_LUO_FSC" style="width: 100%;" id="COD_LUO_FSC_ID" onchange="setImmobile(this,<%=COD_AZL%>);">
    <option value="0" COD_IMM_3LV="0"></option>
<%
        IAnagrLuoghiFisiciHome luogoFisicoHome = (IAnagrLuoghiFisiciHome) PseudoContext.lookup("AnagrLuoghiFisiciBean");        
        out.println(BuildLuoghiFisiciComboBox
                (luogoFisicoHome, COD_LUO_FSC, COD_IMM_3LV, COD_AZL));
%>
</select>
