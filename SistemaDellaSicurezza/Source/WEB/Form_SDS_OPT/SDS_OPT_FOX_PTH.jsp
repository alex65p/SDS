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

<%-- 
    Document   : FOX_PTH.jsp
    Created on : 9-gen-2014, 17.44.54
    Author     : Dario
--%>
<%@ page import="com.apconsulting.luna.ejb.OpzioniUtilizzatore.*" %>
<%@ page import="s2s.ejb.pseudoejb.PseudoContext"%>
<%@ page import="s2s.utils.text.StringManager" %>
<%@ page import="java.util.Collection"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%
    long lCOD_UTN = Long.parseLong(request.getParameter("COD_UTN"));
    String OPERATION = request.getParameter("OPERATION");
    boolean BIModule = Boolean.parseBoolean(request.getParameter("BIModule"));
            
    IOpzioniUtilizzatoreHome home = (IOpzioniUtilizzatoreHome) PseudoContext.lookup("OpzioniUtilizzatoreBean");
    
    if (StringManager.isNotEmpty(OPERATION) && OPERATION.equals("DELETE")){
        home.remove(new OpzioniUtilizzatorePK(lCOD_UTN, "FOX_PTH"));
    }
    
    Collection opzioniUtente = home.findEx(lCOD_UTN, "FOX_PTH", null, 1);
    String strFOX_PTH = !opzioniUtente.isEmpty()?((OpzioniUtilizzatore_View)opzioniUtente.iterator().next()).OPZ_VAL:"";
%>
<script type="text/javascript" src="SDS_OPT.js"></script>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td style="display: <%=(StringManager.isEmpty(strFOX_PTH) ? "block;" : "none;")%>">
            <input name="FOX_PTH" type="file" size="35">
        </td>
        <td style="display: <%=(StringManager.isNotEmpty(strFOX_PTH) ? "block;" : "none;")%>">
            <input name="FOX_PTH-READONLY" type="text" size="50" value="<%=strFOX_PTH%>" readonly>
        </td>
        <td style="display: <%=(StringManager.isNotEmpty(strFOX_PTH) && BIModule ? "block;" : "none;")%>">
            <a href="#" onclick="deleteBrowserOption('SDS_OPT_FOX_PTH.jsp?COD_UTN=<%=lCOD_UTN%>&OPERATION=DELETE',document.getElementById('FOX_PTH-AjaxWorker'));">
                <img src="../_images/erase-context.png" alt="<%=ApplicationConfigurator.LanguageManager.getString("Elimina.impostazione")%>" style="border-style: none">
            </a>
        </td>
    </tr>
</table>
