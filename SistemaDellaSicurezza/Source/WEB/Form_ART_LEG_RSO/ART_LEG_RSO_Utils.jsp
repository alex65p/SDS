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
    Document   : ART_LEG_RSO_Utils
    Created on : 9-giu-2011, 16.18.06
    Author     : Alessandro
--%>

<%!
String BuildArtLegge(IArtLeggeHome home) {
    int rowCount = 0;
    StringBuilder str = new StringBuilder();
    java.util.Collection col = home.ejbGetArt_Legge_View();
    java.util.Iterator it = col.iterator();
    str.append("<table>");
    while(it.hasNext()){
        str.append("<tr class=\"VIEW_TR\" rowIndex=").append(rowCount).append(" onclick=\"BeforeRowClick_S2S();g_OnRowClick(this);AfterRowClick_S2S();\">");
        Art_Legge_View  row = (Art_Legge_View)it.next();
        str.append(     "<td>")
            .append(         "<input type=\"radio\" id=\"id_radio").append(rowCount).append("\">")
            .append(         "<input type=\"hidden\" id=\"id_COD_ARL").append(rowCount).append("\" value=\"").append(row.COD_ARL).append("\">")
            .append(     "</td>")
            .append(     "<td>").append(Formatter.format(row.NOM_ARL)).append("</td>")
            .append(     "<td>").append(Formatter.format(row.DES_ARL)).append("</td>")
            .append("</tr>");
        rowCount++;
    }
    str.append("</table>");
    return str.toString();
}
%>
