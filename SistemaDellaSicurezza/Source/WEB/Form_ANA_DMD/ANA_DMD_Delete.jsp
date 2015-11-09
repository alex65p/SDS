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
     <version number="1.0" date="23/01/2004" author="Alexey Kolesnik">
     <comments>
     <comment date="23/01/2004" author="Alexey Kolesnik">
     <description> Shablon formi ANA_DMD_Delete.jsp </description>
     </comment>
     <comment date="31/01/2004" author="Alexey Kolesnik">
     <description> Added new toolbar </description>
     </comment>
     <comment date="26/02/2004" author="Alexey Kolesnik">
     <description> Rebuild for dynamic tabbars </description>
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

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/Domande/DomandeBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/Domande/DomandeBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/TestVerifica/TestVerificaBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TestVerifica/TestVerificaBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script>
    var err = false;
    var errDescr;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>

<%
    IDomande domande = null;
    ITestVerifica TestVerifica = null;
    long lSUM_NUM_PTG = 0;
    String LOCAL_MODE = request.getParameter("LOCAL_MODE");
    String COD_TES_DEL = "";
    String COD_DMD_DEL = "";

    if (request.getParameter("ID") != null) {
        String ID_TO_DEL = request.getParameter("ID");
        if (request.getParameter("ID_PARENT") != null) {
            if ("ris".equals(LOCAL_MODE)) {
                COD_DMD_DEL = request.getParameter("ID_PARENT");
            } else {
                COD_TES_DEL = request.getParameter("ID_PARENT");
            }
        }
        if (ID_TO_DEL != null && !COD_TES_DEL.equals("") && !COD_TES_DEL.equals("null")) {
            long lID_TO_DEL = Long.parseLong(ID_TO_DEL);
            Long lCOD_TES_DEL = new Long(COD_TES_DEL);
            ITestVerificaHome teshome = (ITestVerificaHome) PseudoContext.lookup("TestVerificaBean");
            TestVerifica = teshome.findByPrimaryKey(lCOD_TES_DEL);
            try {
                TestVerifica.removeCOD_DMD(lID_TO_DEL);
                lSUM_NUM_PTG = TestVerifica.sumNUM_PTG_DMD();
                TestVerifica.setNUM_MAX_PTG(lSUM_NUM_PTG);

            } catch (Exception ex) {
                out.print("<script>err=true; errDescr = 'Integrity violation';</script>");
            }
        } else {
            if (ID_TO_DEL != null && !COD_DMD_DEL.equals("") && !COD_DMD_DEL.equals("null")) {
                long lCOD_RST_DEL = Long.parseLong(ID_TO_DEL);
                Long lCOD_DMD_DEL = new Long(COD_DMD_DEL);
                IDomandeHome dhome = (IDomandeHome) PseudoContext.lookup("DomandeBean");
                domande = dhome.findByPrimaryKey(lCOD_DMD_DEL);
                try {
                    domande.removeCOD_RST(lCOD_RST_DEL);
                } catch (Exception ex) {
                    out.print("<script>err=true; errDescr = 'Integrity violation';</script>");
                }
            } else {
                IDomandeHome home = (IDomandeHome) PseudoContext.lookup("DomandeBean");
                Long dmd_id = new Long(ID_TO_DEL);
                try {
                    home.remove(dmd_id);
                } catch (Exception ex) {
                    manageException(request, out, ex);
                }
            }
        }
    } else {
        out.print("<script>err=true; errDescr = 'Non puoi trovare ID di Risposta'</script>");
    }
%>
<script>
    <%if (LOCAL_MODE != null || (COD_DMD_DEL != null && !COD_DMD_DEL.equals("")) || (COD_TES_DEL != null && !COD_TES_DEL.equals(""))) {%>
    if (!err) {
        Alert.Success.showDeleted();
        parent.del_localRow();
        try {
            if (parent.document.forma.MAX)
                parent.document.forma.MAX.value = "<%=lSUM_NUM_PTG%>";
        } catch (ex) {
            // zaglushka by forest
            var q;
        }
    } else {
        Alert.Error.showDelete();
    }

    <%} else {%>
    if (!err) {
        Alert.Success.showDeleted();
        parent.g_Handler.OnRefresh();
    } else {
        Alert.Error.showDelete();
    }
    <%}%>
</script>
