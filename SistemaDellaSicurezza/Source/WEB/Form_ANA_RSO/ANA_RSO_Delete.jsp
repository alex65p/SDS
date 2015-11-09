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
     <version number="1.0" date="14/12/2004" author="Artur Denysenko">
     <comments>
     <comment date="14/12/2004" author="Artur Denysenko">
     <description>ANA_RSO_Delete.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/ExtendedMode.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script>
    var err = false;
    var errDescr;
</script>

<%
    Checker c = new Checker();

    long ID;
    long lCOD_COR = 0, lCOD_NOR_SEN = 0, lCOD_TPL_DPI = 0, lCOD_PRO_SAN = 0, lCOD_MIS_PET = 0, lCOD_DOC = 0;
    ArrayList alAziende = null;

    String LOCAL_MODE = request.getParameter("LOCAL_MODE");

    if (LOCAL_MODE != null) {
        ID = c.checkLong("Rischio", request.getParameter("ID_PARENT"), true);

        if (LOCAL_MODE.equals("c")) {
            lCOD_COR = c.checkLong("Corso", request.getParameter("ID"), true);
        }

        if (LOCAL_MODE.equals("n")) {
            lCOD_NOR_SEN = c.checkLong("Normativa", request.getParameter("ID"), true);
        }

        if (LOCAL_MODE.equals("d")) {
            lCOD_TPL_DPI = c.checkLong("Dpi", request.getParameter("ID"), true);
        }

        if (LOCAL_MODE.equals("p")) {
            lCOD_PRO_SAN = c.checkLong("Protocollo", request.getParameter("ID"), true);
        }

        if (LOCAL_MODE.equals("m")) {
            lCOD_MIS_PET = c.checkLong("Misura", request.getParameter("ID"), true);
        }

        if (LOCAL_MODE.equals("doc")) {
            lCOD_DOC = c.checkLong("Documento", request.getParameter("ID"), true);
        }
    } else {
        ID = c.checkLong("Rischio", request.getParameter("ID"), true);
        //if (Security.isExtendedMode()){ 
        alAziende = ExtendedMode.getAziende(c); //EXTENDED
        //}

    }

    if (c.isError) {
        out.println("<script>err=true;alert(\"" + c.printErrors() + "\");</script>");
        return;
    }

    IRischioHome home = (IRischioHome) PseudoContext.lookup("RischioBean");

    try {
        if (LOCAL_MODE != null) {
            IRischio bean = home.findByPrimaryKey(new RischioPK(Security.getAzienda(), ID));

            if (lCOD_COR != 0) {
                bean.removeCorso(lCOD_COR, alAziende);
            } else if (lCOD_NOR_SEN != 0) {
                bean.removeNormativaSentenza(lCOD_NOR_SEN);
            } else if (lCOD_TPL_DPI != 0) {
                bean.removeDpi(lCOD_TPL_DPI, alAziende);
            } else if (lCOD_PRO_SAN != 0) {
                bean.removeProtocolloSanitario(lCOD_PRO_SAN, alAziende);
            } else if (lCOD_MIS_PET != 0) {
                // bean.removeMisuraPp(lCOD_MIS_PET, alAziende);
                bean.removeMisuraPp(lCOD_MIS_PET, ExtendedMode.getAziende(c));
            } else if (lCOD_DOC != 0) {
                bean.removeDocumento(lCOD_DOC);
            } else {
                throw new Exception("Invalid operation");
            }
        } else {
            home.remove(new RischioPK(Security.getAzienda(), ID), alAziende);
        }

    } catch (Exception ex) {
        manageException(request, out, ex);
%>
<div id="divErr">
    <%=ex.getMessage()%>
</div>
<script>err = true;</script>
<%
    }

%>

<script>
    if (err)
        Alert.Error.showDelete();

    <%if (LOCAL_MODE == null) {%>
    //else parent.g_Handler.OnRefresh();
    else{
        Alert.Success.showDeleted();
        parent.g_Handler.OnRefresh();
        //parent.ToolBar.OnDelete();
    }
    <%} else {%>

    if (!err) {
        parent.del_localRow();
        Alert.Success.showDeleted();
    }

    <%}%>
</script>
