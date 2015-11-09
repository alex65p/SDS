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
    Document   : getFOX_PTH
    Created on : 10-gen-2014, 13.00.38
    Author     : Dario
--%>
<%@ page import="java.util.Collection"%>
<%@ page import="com.apconsulting.luna.ejb.OpzioniUtilizzatore.*" %>
<%@ page import="com.apconsulting.luna.ejb.Utente.*" %>
<%@ page import="s2s.ejb.pseudoejb.PseudoContext"%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%
    IOpzioniUtilizzatoreHome home = (IOpzioniUtilizzatoreHome) PseudoContext.lookup("OpzioniUtilizzatoreBean");
    IUtenteHome utenteHome = (IUtenteHome)PseudoContext.lookup("UtenteBean");
    
    // Determino il codice dell'utente connesso.
    long lCOD_UTN = 
            ((view_sc_users)utenteHome.getUserS2S(Security.getUserPrincipal().getName()).iterator().next()).CODICE;

    Collection opzioniUtente = home.findEx(lCOD_UTN, "FOX_PTH", null, 1);
    String strFOX_PTH = !opzioniUtente.isEmpty()?((OpzioniUtilizzatore_View)opzioniUtente.iterator().next()).OPZ_VAL:"";
    strFOX_PTH = strFOX_PTH.indexOf("FirefoxPortable.exe")>-1?strFOX_PTH:"";
%>
<input id="getFOX_PTH" value="<%=strFOX_PTH%>">
