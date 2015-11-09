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
            <version number="1.0" date="08/04/2011" author="Dario Massaroni">
            <comments>
            <comment date="08/04/2011" author="Dario Massaroni">
            <description>ANA_IMM_3LV_Delete.jsp</description>
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */
            response.setHeader("Cache-Control", "no-cache");    //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
            response.setDateHeader("Expires", 0); 		//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Immobili3lv.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script type="text/javascript">
    var err=false;
    var errDescr;
</script>
<script type="text/javascript" src="../_scripts/Alert.js"></script>
<%
            Checker c = new Checker();
            long ID;
            IImmobili3lvHome home = (IImmobili3lvHome) PseudoContext.lookup("Immobili3lvBean");

            String LOCAL_MODE = request.getParameter("LOCAL_MODE");
            ID = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Immobile"), request.getParameter("ID"), true);
            if (c.isError) {
                out.println("<script>alert(\"" + c.printErrors() + "\");</script>");
                return;
            }

            try {
                home.remove(ID);
            } catch (Exception ex) {
                manageException(request, out, ex);
            }
%>
<script type="text/javascript">
    if (err) Alert.Error.showDelete();
    <%if (LOCAL_MODE == null) {%>
        if (!err){
            Alert.Success.showDeleted();
            if(parent.ToolBar != null){
                parent.ToolBar.OnDelete();
            }
            parent.g_Handler.OnRefresh();
        }
    <%} else {%>
        if (!err){
            parent.del_localRow();
            Alert.Success.showDeleted();
        }
    <%}%>
</script>
