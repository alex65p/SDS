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
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/FormatterHtml.jsp" %>
<script type="text/javascript" src="../_scripts/utility-date.js"></script>
<%
            
            String COD_PRO = request.getParameter("COD_PRO");
            String DAT_EMI = request.getParameter("DAT_EMI");
            String COD = request.getParameter("COD");
            SimpleDateFormat sdfSource = new SimpleDateFormat("dd/MM/yy");
            if(DAT_EMI!=""){
            Date DAT_EMI2 = sdfSource.parse(DAT_EMI);
            SimpleDateFormat sdfDestination = new SimpleDateFormat("yyyy-MM-dd");
            DAT_EMI = sdfDestination.format(DAT_EMI2);
            long lCOD_PRO = Long.parseLong(COD_PRO);
            ISezioneParticolareHome home = (ISezioneParticolareHome) PseudoContext.lookup("SezioneParticolareBean");
            IsezioneGeneraleHome home_SEZ_GEN = (IsezioneGeneraleHome) PseudoContext.lookup("SezioneGeneraleBean");
            ISchedediSicurezzaHome home_SCH_SIC = (ISchedediSicurezzaHome) PseudoContext.lookup("SchedediSicurezzaBean");
            IFascicoloHome home_FAS = (IFascicoloHome) PseudoContext.lookup("FascicoloBean");
            String REV1 =home_SEZ_GEN.getUltimaRevisione(lCOD_PRO);
            String REV2 =home_SCH_SIC.getUltimaRevisione(lCOD_PRO);
            String REV3 =home.getUltimaRevisione(lCOD_PRO, COD);
            String REV4 =home_FAS.getUltimaRevisione(lCOD_PRO);
            if(COD.equals("001")&&(REV1!=null)){
            String DAT_PRO_SEZ_GEN = home_SEZ_GEN.getDataProtocolloPREC(lCOD_PRO);
            out.println(DAT_EMI.compareTo(DAT_PRO_SEZ_GEN)>0?"0":"-1");}
            else if(COD.equals("S01")&&(REV2!=null)){
            String DAT_PRO_SCH_SIC = home_SCH_SIC.getDataProtocolloPREC(lCOD_PRO);
            out.println(DAT_EMI.compareTo(DAT_PRO_SCH_SIC)>0?"0":"-1");}
            else if(COD.equals("F01")&&(REV3!=null)){
                String DAT_PRO_FAS = home_FAS.getDataProtocolloPREC(lCOD_PRO);
            out.println(DAT_EMI.compareTo(DAT_PRO_FAS)>0?"0":"-1");}
            else if((!COD.equals("001"))&&(!COD.equals("S01"))&&(!COD.equals("F01"))&&(REV4!=null)){
                String DAT_PRO_SEZ_PAR = home.getDataProtocolloPREC(lCOD_PRO,COD);
            out.println(DAT_EMI.compareTo(DAT_PRO_SEZ_PAR)>0?"0":"-1");}}

%>
