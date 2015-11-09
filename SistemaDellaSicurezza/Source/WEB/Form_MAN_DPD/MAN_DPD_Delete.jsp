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
        /*
        <file>
        <versions>
        <version number="1.0" date="24/01/2004" author="Malyuk Sergey">
        <comments>
        <comment date="24/01/2004" author="Malyuk Sergey">
        <description></description>
        </comment>
        </comments>
        </version>
        </versions>
        </file>
         */
%>

<%
        response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
        response.setHeader("Pragma", "no-cache"); //HTTP 1.0
        response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
    var err = false;
</script>
<%


        IDipendente bean = null;

        if (request.getParameter("ID") != null) {
            try {

                IDipendenteHome home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
                String strID = request.getParameter("ID");
                String strCOD_UNI_ORG = strID.substring(0, strID.indexOf('|'));
                String strCOD_MAN = strID.substring(strID.indexOf('|') + 1, strID.length());
                long lCOD_UNI_ORG = new Long(strCOD_UNI_ORG).longValue();
                long lCOD_MAN = new Long(strCOD_MAN).longValue();
                Long ID_PARENT = new Long(request.getParameter("ID_PARENT"));
                java.sql.Date dtDAT_INZ = java.sql.Date.valueOf(request.getParameter("dat_inz"));
                bean = home.findByPrimaryKey(ID_PARENT);
                try {
                    bean.removeCOD_MAN(lCOD_MAN, lCOD_UNI_ORG, dtDAT_INZ);
                } catch (Exception ex) {
                    ex.printStackTrace();
                    out.print("<script>err=true;</script>");
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
%>
<script>
    if (!err) {
        Alert.Success.showDeleted();
        parent.del_localRow();
    } else {
        Alert.Error.showDelete();
    }
</script>
