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
     <version number="1.0" date="29/01/2004" author="Artur Denysenko">
     <comments>
     <comment date="29/01/2004" author="Artur Denysenko">
     <description>Shablon formi MULTIAZIENDA</description>
     </comment>		
     </comments> 
     </version>
     </versions>
     </file> 
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.AssociazioneMansioniSAP_S2S.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ page import="s2s.luna.conf.ApplicationConfigurator" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<script>var err = false;</script>

<%    Checker ch = new Checker();
    java.util.ArrayList alAziende = ch.checkAlLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"), request.getParameterValues("COD_AZL"));

    if (ch.isError) {
%>
<div id="divError">
    <%=ch.printErrors()%>
</div>
<script>alert(divError.innerText)</script>
<%
    return;
} else {
    try {
        Security.setAziende(alAziende);

        IAzienda Azienda = ((IAziendaHome) PseudoContext.lookup("AziendaBean")).findByPrimaryKey((Long) alAziende.get(0));
        Security.setAziendaModalitaCalcoloRischio(Azienda.getMOD_CLC_RSO());

        if (ApplicationConfigurator.isModuleEnabled(MODULES.ASSOC_SAP_S2S)) {
            // Se è loggato a sistema un consulente, verifico che esistano delle mansioni SAP ancora da associare ad S2S 
            // ed avverto l'utente connesso.
            if (Security.isConsultant()) {
                AssociazioneMansioniSAP_S2SHome home_ass_man_sap_s2s = (AssociazioneMansioniSAP_S2SHome) PseudoContext.lookup("AssociazioneMansioniSAP_S2SBean");
                long ass_man_sap_s2s_count = home_ass_man_sap_s2s.getDipendenti_Mansioni_SAP_Count(((Long) alAziende.get(0)).longValue());
                if (ass_man_sap_s2s_count > 0) {
                    out.println("<script>alert(\""
                            + ApplicationConfigurator.LanguageManager.getString("Autostrade.per.l'Italia.MSG1")
                            + "\");</script>");
                }
            }
        }
    } catch (Exception ex) {
%>
<div id="divError1">
    <%=ex%>
</div>
<script>alert(divError1.innerText)</script>
<%
        }
    }
%>
<script>
    if (!err) {
        parent.returnValue = "OK";
        parent.close();
    }
</script>


