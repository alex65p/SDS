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

<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server

    long lCOD_AZL = Security.getAzienda();
    String strTYPE = "";
    String newNOM_MAN = "";
    IDipendenteHome home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
    if ((request.getParameter("ID") != null) && (!request.getParameter("ID").equals(""))) {
        newNOM_MAN = request.getParameter("ID");
        String str = "";
        int i = 0;
        if (request.getParameter("ORDER") != null) {
            strTYPE = request.getParameter("ORDER");
%><div id="div_s"><%
            java.util.Collection col = home.getDipendenti_FOD_DBT_View(lCOD_AZL, newNOM_MAN, strTYPE.equals("dw"));
            str = "<table border='1' class='dataTable' cellpadding='0' cellspacing='0' width='100%'>";
            java.util.Iterator it = col.iterator();
            while (it.hasNext()) {
                Dipendenti_FOD_DBT_View d = (Dipendenti_FOD_DBT_View) it.next();
                str += "<tr INDEX='" + d.COD_DPD + "' ID='tr" + d.COD_COR + "' onclick='selCOR_DPD(this.id, " + i + ")' ondblclick='openCORDPD()'>";
                str += "<td class='dataTd' width='304px'>"
                        + "<input type='hidden' value='" + d.COD_DPD + "' id='" + i + "hidtr" + d.COD_COR + "'>"
                        + "<input type='text' id='" + i + "tr" + d.COD_COR + "1' readonly class='dataInput' value=\"" + Formatter.format(d.COG_DPD) + "&nbsp;" + Formatter.format(d.NOM_DPD) + "\">"
                        + "</td>";
                str += "<td class='dataTd' width='304px'><input type='text' id='" + i + "tr" + d.COD_COR + "2' readonly  class='dataInput' value=\"" + Formatter.format(d.NOM_COR) + "\"></td>";
                str += "<td class='dataTd' width=''><input type='text' id='" + i + "tr" + d.COD_COR + "3' readonly  class='dataInput' value=\"" + Formatter.format(d.DAT_COR) + "\"></td>";
                str += "</tr>";
                i++;
            }
            str += "</table>";
            out.print(str);
        }
    }
    %>
</div>
<script>
    parent.document.all['divFile'].innerHTML=document.all['div_s'].innerHTML;
</script>
