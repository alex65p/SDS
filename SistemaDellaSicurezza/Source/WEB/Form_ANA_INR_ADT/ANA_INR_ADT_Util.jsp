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

<%@page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.AnagrLuoghiFisici_List_View"%>
<%!
    boolean isError = false;
    String strError = "";

    String BuildLuogoFisicoComboBox(java.util.Collection col, long lCOD_LUO_FSC) {
        String str = "";
        String selected = "";
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            AnagrLuoghiFisici_List_View view = (AnagrLuoghiFisici_List_View) it.next();
            if (lCOD_LUO_FSC == view.COD_LUO_FSC) {
                selected = "selected";
            } else {
                selected = "";
            }
            str += "<option value='" + view.COD_LUO_FSC + "' " + selected + " >" + view.NOM_LUO_FSC + "</option>";
        }
        return str;
    }
    long app = 0;
    int cont = 1;
%>
