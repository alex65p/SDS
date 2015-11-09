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
    Document   : getNextRev
    Created on : 6-mag-2011, 16.22.09
    Author     : Alessandro
--%>
<%@ page import="com.apconsulting.luna.ejb.SezioneGenerale.*" %>
<%@ page import="com.apconsulting.luna.ejb.SchedediSicurezza.*" %>
<%@ page import="com.apconsulting.luna.ejb.SezioneParticolare.*" %>
<%@ page import="com.apconsulting.luna.ejb.Fascicolo.*" %>
<%@ page import="s2s.utils.Alphabet" %>
<%@ page import="s2s.utils.text.StringManager" %>

<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%
    String DAT_EMI = request.getParameter("DAT_EMI");
    String COD_PRO = request.getParameter("COD_PRO");
    String REV = request.getParameter("REV");
    String par = request.getParameter("par");
    String newID = request.getParameter("COD");
    long lCOD_PRO = Long.parseLong(COD_PRO);

    String StatoInLavorazione = "In lavorazione";

    // REVISIONE SEZIONE GENERALE
    if (par.equals("G")) {
        if (StringManager.isEmpty(DAT_EMI) == false) {
            if (REV.equals(StatoInLavorazione)) {
                // Calcolo la revisione successiva
                Alphabet c = new Alphabet();
                IsezioneGeneraleHome home = (IsezioneGeneraleHome) PseudoContext.lookup("SezioneGeneraleBean");
                REV = home.getUltimaRevisione(lCOD_PRO);
                REV = StringManager.isEmpty(REV) ? "0" : REV;
                REV = c.getNextElement(REV);
            }
        } else {
            REV = StatoInLavorazione;
        }
    }

    // REVISIONE SCHEDE DI SICUREZZA
    if (par.equals("S")) {
        if (StringManager.isEmpty(DAT_EMI) == false) {
            if (REV.equals(StatoInLavorazione)) {
                // Calcolo la revisione successiva
                Alphabet c = new Alphabet();
                ISchedediSicurezzaHome home = (ISchedediSicurezzaHome) PseudoContext.lookup("SchedediSicurezzaBean");
                REV = home.getUltimaRevisione(lCOD_PRO);
                REV = StringManager.isEmpty(REV) ? "0" : REV;
                REV = c.getNextElement(REV);
            }
        } else {
            REV = StatoInLavorazione;
        }
    }

    // REVISIONE SEZIONE PARTICOLARE
    if (par.equals("P")) {
        if (StringManager.isEmpty(DAT_EMI) == false) {
            if (REV.equals(StatoInLavorazione)) {
                // Calcolo la revisione successiva
                Alphabet c = new Alphabet();
                ISezioneParticolareHome home = (ISezioneParticolareHome) PseudoContext.lookup("SezioneParticolareBean");
                REV = home.getUltimaRevisione(lCOD_PRO, newID);
                REV = StringManager.isEmpty(REV) ? "0" : REV;
                REV = c.getNextElement(REV);
            }
        } else {
            REV = StatoInLavorazione;
        }
    }

    // REVISIONE FASCICOLO
    if (par.equals("F")) {
        if (StringManager.isEmpty(DAT_EMI) == false) {
            if (REV.equals(StatoInLavorazione)) {
                // Calcolo la revisione successiva
                Alphabet c = new Alphabet();
                IFascicoloHome home = (IFascicoloHome) PseudoContext.lookup("FascicoloBean");
                REV = home.getUltimaRevisione(lCOD_PRO);
                REV = StringManager.isEmpty(REV) ? "0" : REV;
                REV = c.getNextElement(REV);
            }
        } else {
            REV = StatoInLavorazione;
        }
    }
    REV = REV.equals("1") ? "Emissione" : REV;
%>
<input readonly tabindex="6" type="text" maxlength="1" id="REV" name="REV" value="<%=REV%>">
