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

<%@ page import="s2s.utils.text.StringManager" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="ANA_CON-DIS_SOP_Util.jsp"%>

<%
	    Map mmm = null;
	    mmm = request.getParameterMap();
	    Object xobj = mmm.get("IDD");

    Long cod = null;
    if (request.getParameter("COD") != null) {
	Object obj = request.getParameter("COD");
	cod = Long.parseLong(request.getParameter("COD"));
    }

    Long lcod_sop_cst = new Long(0);
    String cod_sop_cst = null;
    try {
	cod_sop_cst = request.getParameter("COD_SOP_CST");
	if (cod_sop_cst != null) {
	    lcod_sop_cst = new Long(cod_sop_cst);
	}
    } catch (Exception ex) {
	String sss=ex.getMessage();
	String xxx=sss;
	String zzz=xxx;
    }

    String tipo = request.getParameter("TIPO");
    if (tipo == null) {
	return;
    }

    Long lCOD_AZL = Security.getAzienda();

    ISopraluogoHome home = (ISopraluogoHome) PseudoContext.lookup("SopraluogoBean");
//    jbConstatazione constatazione = home.getConstatazione(cod);
//    cod=constatazione.lCOD_CST;

    if (tipo.equals("CONST")) {
	out.println(ListaConstatazioni(home, cod, lCOD_AZL));
    } else if (tipo.equals("RISC")) {
	out.println(ListaRischi(home, new Long(0), lCOD_AZL, cod));
    } else if (tipo.equals("DISP")) {
	out.println(ListaDisposizioni(home, new Long(0), lCOD_AZL, cod));
    } else if (tipo.equals("GENDIS")) {
	out.println(ListaDisposizioniGenerate(home, new Long(0), lCOD_AZL, cod, lcod_sop_cst,1));
    } else if (tipo.equals("RETLEG")) {
	out.println(ListaArticoliLegge(home, new Long(0), lCOD_AZL, cod, lcod_sop_cst,1);
    }
%>
