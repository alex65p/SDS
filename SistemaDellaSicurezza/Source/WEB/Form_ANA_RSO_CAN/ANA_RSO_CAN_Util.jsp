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


<%@page import="com.apconsulting.luna.ejb.FattoriRischioCantiere.RischioFattore_ComboView"%>
<%@page import="com.apconsulting.luna.ejb.FattoriRischioCantiere.IFattoriRischioCantiereHome"%>
<%!
String BuildFattoreRischioCantiereComboBox(IFattoriRischioCantiereHome home, long SELECTED_ID) {
        String str = "";
        String strSEL = "";
        java.util.Collection col = home.getAnagrFattoriRischioCantiere_All_View();
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            RischioFattore_ComboView dt = (RischioFattore_ComboView) it.next();
            strSEL = "";
            if (SELECTED_ID != 0) {
                if (SELECTED_ID == dt.lCOD_FAT_RSO) {
                    strSEL = "selected";
                }
            }
            str = str + "<option " + strSEL + " value='" + Formatter.format(dt.lCOD_FAT_RSO) + "'>" + Formatter.format(dt.strNOM_FAT_RSO) + "</option>";
        }
        return str;
    }

%>
