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

<%@ page import="com.apconsulting.luna.ejb.Procedimento.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrOpere.*" %>
<%@ page import="com.apconsulting.luna.ejb.Cantiere.*" %>
<%@ page import="s2s.luna.conf.ApplicationConfigurator"%>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%!
    String BuildProcedimentoComboBox(IProcedimentoHome home, long SELECTED_ID, long lCOD_AZL) {
	String str = "";
	String strSEL = "";
	java.util.Collection col = home.getProcedimento_View(lCOD_AZL);
	java.util.Iterator it = col.iterator();
	while (it.hasNext()) {
	    Procedimento_View dt = (Procedimento_View) it.next();
	    strSEL = "";
	    if (SELECTED_ID != 0) {
		if (SELECTED_ID == dt.COD_PRO) {
		    strSEL = "selected";
		}
	    }
	    str = str + "<option " + strSEL + " value='" + Formatter.format(dt.COD_PRO) + "'>" + Formatter.format(dt.DES_PRO) + "</option>";
	}
	return str;
    }

    String BuildCantiereComboBox(ICantiereHome home, long lCOD_PRO, long SELECTED_ID, long lCOD_AZL) {
	String str = "";
	String strSEL = "";
	java.util.Collection col = home.getCantiere_View(lCOD_PRO, lCOD_AZL);
	java.util.Iterator it = col.iterator();
	while (it.hasNext()) {
	    Cantiere_View dt = (Cantiere_View) it.next();
	    strSEL = "";
	    if (SELECTED_ID != 0) {
		if (SELECTED_ID == dt.COD_CAN) {
		    strSEL = "selected";
		}
	    }
	    str = str + "<option " + strSEL + " value='" + Formatter.format(dt.COD_CAN) + "'>" + Formatter.format(dt.NOM_CAN) + "</option>";
	}
	return str;
    }
    
    String BuildOperaComboBox(IAnagrOpereHome home, long lCOD_CAN, long SELECTED_ID, long lCOD_AZL) {
	String str = "";
	String strSEL = "";
	java.util.Collection col = home.getOpera_View(lCOD_CAN, lCOD_AZL);
	java.util.Iterator it = col.iterator();
	while (it.hasNext()) {
	    Opere_View dt = (Opere_View) it.next();
	    strSEL = "";
	    if (SELECTED_ID != 0) {
		if (SELECTED_ID == dt.COD_OPE) {
		    strSEL = "selected";
		}
	    }
	    str = str + "<option " + strSEL + " value='" + Formatter.format(dt.COD_OPE) + "'>" + Formatter.format(dt.NOM_OPE) + "</option>";
	}
	return str;
    }
%>
