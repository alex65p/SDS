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
     <version number="1.0" date="24/01/2004" author="Mike Kondratyuk">
     <comments>
     <comment date="05/02/2004" author="Malyuk Sergey">
     <description>added for tabs in ana_pro_san_tab</description>
     </comment>
     <comment date="27/02/2004" author="Alexey Kolesnik">
     <description> Rebuild for dynamic tabbars </description>
     </comment>
     </comments>
     </version>
     </versions>
     </file>
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.GestioneVisiteMediche.*" %>
<%@ page import="com.apconsulting.luna.ejb.ProtocoleSanitare.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
    var err = false;
</script>

<%
    long lCOD_AZL = Security.getAzienda();
    IProtocoleSanitare ProtocoleSanitare = null;
    String COD_PRO_SAN_DEL = "";
    String ID_TO_DEL = "";
    if (request.getParameter("ID") != null) {
        ID_TO_DEL = request.getParameter("ID");
        if (request.getParameter("ID_PARENT") != null) {
            if (request.getParameter("ID_PARENT") != null) {
                COD_PRO_SAN_DEL = request.getParameter("ID_PARENT");
            }
            COD_PRO_SAN_DEL = request.getParameter("ID_PARENT");
        }
        if (ID_TO_DEL != null && !COD_PRO_SAN_DEL.equals("") && !COD_PRO_SAN_DEL.equals("null")) {
            long lID_TO_DEL = Long.parseLong(ID_TO_DEL);
            Long lCOD_PRO_SAN_DEL = new Long(COD_PRO_SAN_DEL);
            IProtocoleSanitareHome prohome = (IProtocoleSanitareHome) PseudoContext.lookup("ProtocoleSanitareBean");
            ProtocoleSanitare = prohome.findByPrimaryKey(new ProtocoleSanitarePK(lCOD_AZL, lCOD_PRO_SAN_DEL.longValue()));
            try {
                ProtocoleSanitare.removeMediche(lID_TO_DEL);
            } catch (Exception ex) {
                out.print("<script>err=true; errDescr = 'Integrity violation';</script>");
            }
        } else {
            IGestioneVisiteMedicheHome home = (IGestioneVisiteMedicheHome) PseudoContext.lookup("GestioneVisiteMedicheBean");
            Long vst_med_id = new Long(ID_TO_DEL);
            try {
                home.remove(vst_med_id);
            } catch (Exception ex) {
                manageException(request, out, ex);
            }
        }
    }
%>
<script>
    if (!err) {
        Alert.Success.showDeleted();
        parent.ToolBar.OnDelete();
    } else {
        Alert.Error.showDelete();
    }
</script>
