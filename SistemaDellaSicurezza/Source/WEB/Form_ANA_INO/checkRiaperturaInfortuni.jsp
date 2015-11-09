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
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
            response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server

%>
<%@ page import="com.apconsulting.luna.ejb.InfortuniIncidenti.*" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<table border="0" class="VIEW_TABLE" cellpadding="1" cellspacing="1">
    <tbody>
        <%
                    IInfortuniIncidentiHome home = (IInfortuniIncidentiHome) PseudoContext.lookup("InfortuniIncidentiBean");
                    IInfortuniIncidenti bean = null;
                    long lCOD_AZL = Security.getAzienda();

                    Long COD_DPD = new Long(request.getParameter("COD_DPD"));
                    Long COD_INO = new Long(request.getParameter("COD_INO"));
                    String DAT_EVE_INO = request.getParameter("DAT_EVE_INO");
                    Long COD_INO_REL = new Long(request.getParameter("COD_INO_REL"));

                    java.util.Collection col = home.getInfortuniIncidentiDipendenteView(COD_DPD, lCOD_AZL, DAT_EVE_INO, COD_INO, COD_INO_REL);
                    java.util.Iterator it = col.iterator();
                    while (it.hasNext()) {
                        SchedaInfortunioIncidenteView view = (SchedaInfortunioIncidenteView) it.next();
        %>
        <tr id="<%=view.lCOD_INO%>" class="VIEW_TR" onclick="g_OnRowClick_Form(this);">
            <%
                            out.println("<td width=\"251px\">&nbsp;" + Formatter.format(view.strNOM_SED_LES) + "&nbsp;</td>"
                                    + "<td width=\"251px\">&nbsp;" + Formatter.format(view.strNOM_TPL_FRM_INO) + "&nbsp;</td>"
                                    + "<td width=\"251px\">&nbsp;" + Formatter.format(view.strNOM_LUO_FSC) + "&nbsp;</td>"
                                    + "<td width=\"92px\">&nbsp;" + Formatter.format(view.dtDAT_EVE_INO) + "&nbsp;</td>"
                                    + "<td width=\"92px\">&nbsp;" + Formatter.format(view.dtDAT_COM_INO) + "&nbsp;</td>"
                                    + "</tr>");
                        }
            %>
    </tbody>
</table>
