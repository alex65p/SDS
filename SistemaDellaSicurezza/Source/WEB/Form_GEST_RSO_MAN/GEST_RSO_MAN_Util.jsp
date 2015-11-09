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

<!--
<version number="1.0" date="30/07/2007" author="Dario Massaroni">
    <comments>
        <comment date="30/07/2007" author="Dario Massaroni">
            <description>Functions for GEST_RSO_MAN_Form</description>
        </comment>		
    </comments> 
</version>
-->
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%!
String GET_WINDOW_TITLE(String SUBJECT){
    if (SUBJECT == null || SUBJECT.trim().equals("")){
        return "";
    }
    String Title = ApplicationConfigurator.LanguageManager.getString("Gestione.rischi.per.attività.lavorative");
    if (SUBJECT.equals("RISC")){
        return Title + " - " + ApplicationConfigurator.LanguageManager.getString("Rischi");
    }
    if (SUBJECT.equals("CORSO")){
        return Title + " - " + ApplicationConfigurator.LanguageManager.getString("Corsi");
    }
    if (SUBJECT.equals("PROTOCOLO")){
        return Title + " - " + ApplicationConfigurator.LanguageManager.getString("Protocolli");
    }
    if (SUBJECT.equals("DPI")){
        return Title + " - " + ApplicationConfigurator.LanguageManager.getString("D.P.I.");
    }
    return "";
}
%>
