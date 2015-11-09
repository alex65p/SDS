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
     <version number="1.0" date="25/01/2004" author="Khomenko Juliya">
     <comments>
     <comment date="25/01/2004" author="Khomenko Juliya">
     <description>Delete main data from form ANA_PCS_FRM</description>
     </comment>
     <comment date="26/02/2004" author="Mike Kondratyuk">
     <description>Delete link from tab in form ANA_PCS_FRM</description>
     </comment>
     </comments>
     </version>
     </versions>
     </file>
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.PercorsiFormativi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
            var err = false;
            var errDescr;</script>
    <%
        IPercorsiFormativi bean = null;
        IPercorsiFormativiHome home = (IPercorsiFormativiHome) PseudoContext.lookup("PercorsiFormativiBean");

        String LOCAL_MODE = request.getParameter("LOCAL_MODE");
        if (request.getParameter("LOCAL_MODE") != null) {
            if (request.getParameter("ID") != null) {
                Checker c = new Checker();

                long lCOD_PCS_FRM = c.checkLong("PercorsiFormativi ID", request.getParameter("ID_PARENT"), true);
                long lCOD_COR = c.checkLong("Corsi ID", request.getParameter("ID"), true);
                if (c.isError) {
                    out.println("<script>err=true;alert(\"" + c.printErrors() + "\");</script>");
                    return;
                }
                Long pcs_frm_id = new Long(lCOD_PCS_FRM);
                try {
                    bean = home.findByPrimaryKey(pcs_frm_id);
                    bean.removeCOD_COR(lCOD_COR);
                } catch (Exception ex) {
                    out.print("<script>Alert.Error.showDelete();err=true;</script>");
                    return;
                }
            }
        } else {
            if (request.getParameter("ID") != null) {
                String ID_TO_DEL = request.getParameter("ID");
                Long pcs_frm_id = new Long(ID_TO_DEL);
                try {
                    home.remove(pcs_frm_id);
                } catch (Exception ex) {
                    manageException(request, out, ex);
                }
            }
        }
    %>
<script>
            if (err)
            Alert.Error.showDelete(); // alert(divErr.innerText);

    <%
        if (LOCAL_MODE == null) {
    %>
    else{
    Alert.Success.showDeleted();
            parent.g_Handler.OnRefresh();
    }
    <%
    } else {
    %>
    else{
    parent.del_localRow();
            Alert.Success.showDeleted();
    }

    <%
        }
    %>
</script>
