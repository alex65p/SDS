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
            <version number="1.0" date="11/04/2011" author="Dario Massaroni">
            <comments>
            <comment date="11/04/2011" author="Dario Massaroni">
            <description>Create ANA_IMM_3LV_Tabs.jsp</description>
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */
%>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="ANA_IMM_3LV_Util.jsp" %>

<script type="text/javascript">
    var err=false;
</script>
<script type="text/javascript" src="../_scripts/Alert.js"></script>
<div id="dContent">
    <%
                long COD_IMM = Long.parseLong(request.getParameter("ID_PARENT"));
                IAnagrLuoghiFisiciHome home = (IAnagrLuoghiFisiciHome) PseudoContext.lookup("AnagrLuoghiFisiciBean");
                try {
                    if (request.getParameter("TAB_NAME").equals("tab_luoghi_fisici")) {
                        out.println(BuildLuoghiFisiciTab(home, COD_IMM));
                    } else {
                        return;
                    }
                } catch (Exception ex) {
                    out.print(printErrAlert("divErr", "Error.alert", ex));
                    return;
                }
    %>
</div>
<script type="text/javascript">
    if (!err){
        parent.tabbar.ReloadTabTable(document);
    }
</script>
