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
            <version number="1.0" date="18/02/2004" author="Khomenko Juliya">
            <comments>
            <comment date="18/02/2004" author="Khomenko Juliya">
            <description>Create ANA_SIT_AZL_Tabs.jsp</description>
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */
%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.SediAziendali.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="com.apconsulting.luna.ejb.Immobili3lv.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="ANA_SIT_AZL_Util.jsp" %>

<script type="text/javascript">
    var err=false;
</script>
<script type="text/javascript" src="../_scripts/Alert.js"></script>
<div id="dContent">
    <%
                long lCOD_SIT_AZL = 0;
                ISitaAziende bean = null;
                ISitaAziendeHome home = (ISitaAziendeHome) PseudoContext.lookup("SitaAziendeBean");
                String strID = (String) request.getParameter("ID_PARENT");

                try {
                    bean = home.findByPrimaryKey(new Long(strID));
                    lCOD_SIT_AZL = bean.getCOD_SIT_AZL();
                } catch (Exception ex) {
                    out.print(printErrAlert("divErr", "Error.showNotFound", ex));
                    return;
                }
                try {
                    if (bean != null) {
                        if (request.getParameter("TAB_NAME").equals("tab_luoghi_fisici")) {
                            IAnagrLuoghiFisiciHome lfHome = (IAnagrLuoghiFisiciHome) PseudoContext.lookup("AnagrLuoghiFisiciBean");
                            out.println(BuildLuoghiFisiciTab(lfHome, lCOD_SIT_AZL));
                        } else if (request.getParameter("TAB_NAME").equals("tab_immobili")) {
                            IImmobili3lvHome immHome = (IImmobili3lvHome) PseudoContext.lookup("Immobili3lvBean");
                            out.println(BuildImmobiliTab(immHome, Security.getAzienda(), lCOD_SIT_AZL));
                        } else {
                            return;
                        }
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
