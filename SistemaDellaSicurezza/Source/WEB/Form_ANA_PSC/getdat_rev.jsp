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
    Document   : getdat_rev
    Created on : 24-mag-2011, 12.42.26
    Author     : Alessandro
--%>

<%@page import="com.apconsulting.luna.ejb.Fascicolo.IFascicoloHome"%>
<%@ page import="com.apconsulting.luna.ejb.SezioneParticolare.*" %>
<%@ page import="com.apconsulting.luna.ejb.SezioneGenerale.*" %>
<%@ page import="com.apconsulting.luna.ejb.SchedediSicurezza.*" %>
<%@ page import="com.apconsulting.luna.ejb.Fascicolo.*" %>
<%@ page import="s2s.utils.text.StringManager" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%
    String ID = request.getParameter("COD");
    long lCOD_PRO = Long.parseLong(request.getParameter("COD_PRO"));

    ISezioneParticolareHome home = (ISezioneParticolareHome) PseudoContext.lookup("SezioneParticolareBean");
    IsezioneGeneraleHome home_SEZ_GEN = (IsezioneGeneraleHome) PseudoContext.lookup("SezioneGeneraleBean");
    ISchedediSicurezzaHome home_SCH_SIC = (ISchedediSicurezzaHome) PseudoContext.lookup("SchedediSicurezzaBean");
    IFascicoloHome home_FAS = (IFascicoloHome) PseudoContext.lookup("FascicoloBean");

    if (ID.equals("001") && (home_SEZ_GEN.getUltimaRevisione(lCOD_PRO) != null)) {
        String DAT_PRO = home_SEZ_GEN.getDataProtocollo(lCOD_PRO);
        out.println(StringManager.isEmpty(DAT_PRO) == false ? "0" : "-1");
    } else if (ID.equals("S01") && (home_SCH_SIC.getUltimaRevisione(lCOD_PRO) != null)) {
        String DAT_PRO = home_SCH_SIC.getDataProtocollo(lCOD_PRO);
        out.println(StringManager.isEmpty(DAT_PRO) == false ? "0" : "-1");
    } else if (ID.equals("F01") && (home_FAS.getUltimaRevisione(lCOD_PRO) != null)) {
        String DAT_PRO = home_FAS.getDataProtocollo(lCOD_PRO);
        out.println(StringManager.isEmpty(DAT_PRO) == false ? "0" : "-1");
    } else if ((!ID.equals("001")) && (!ID.equals("S01")) && (!ID.equals("F01")) && (home.getUltimaRevisione(lCOD_PRO, ID) != null)) {
        String DAT_PRO = home.getDataProtocollo(lCOD_PRO, ID);
        out.println(StringManager.isEmpty(DAT_PRO) == false ? "0" : "-1");
    }
%>
