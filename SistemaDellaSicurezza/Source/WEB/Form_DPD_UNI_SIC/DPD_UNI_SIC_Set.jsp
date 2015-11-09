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
            <version number="1.0" date="24/02/2004" author="Alexey Kolesnik">
            <comments>
            <comment date="24/02/2004" author="Alexey Kolesnik">
            <description>Realizazija EJB dlia svyazki
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */
%>
<%@ page import="com.apconsulting.luna.ejb.UnitaSicurezza.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%!
    String ReqMODE;	// parameter of request
%>
<script type="text/javascript" src="../_scripts/Alert.js"></script>
<script type="text/javascript">
    var err=false;
</script>
<%
    boolean uni_sic_4_dip =
            ApplicationConfigurator.isModuleEnabled(MODULES.UNI_SIC_4_DIP);
    IUnitaSicurezza bean = null;
    Checker c = new Checker();

    long lCOD_UNI_SIC = c.checkLong("COD_UNI_SIC", request.getParameter("COD_UNI_SIC"), true);
    long lCOD_AZL = c.checkLong("COD_AZL", request.getParameter("COD_AZL"), true);

    long lCOD_DPD = c.checkNoZeroLong(ApplicationConfigurator.LanguageManager.getString("Responsabile"), request.getParameter("COD_DPD"), true);
    long lCOD_UNI_ORG = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Unità.organizzativa"), request.getParameter("COD_UNI_ORG"), !uni_sic_4_dip);
    long lCOD_RUO_SIC = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Ruoli.sicurezza"), request.getParameter("COD_RUO_SIC"), uni_sic_4_dip);

    if (c.isError) {
        String err = c.printErrors();
        out.print("<script>err=true;alert(\"" + err + "\");</script>");
        return;
    }

    IUnitaSicurezzaHome home = (IUnitaSicurezzaHome) PseudoContext.lookup("UnitaSicurezzaBean");

    bean = home.findByPrimaryKey(new Long(request.getParameter("COD_UNI_SIC")));

    if (request.getParameter("SBM_MODE") != null) {
        ReqMODE = request.getParameter("SBM_MODE");
        try {
            if (uni_sic_4_dip)
                bean.addDIP
                    (lCOD_UNI_SIC, lCOD_AZL, lCOD_DPD, lCOD_RUO_SIC);
            else
                bean.addUO
                    (lCOD_UNI_SIC, lCOD_AZL, lCOD_DPD, lCOD_UNI_ORG);
        } catch (Exception ex) {
            ex.printStackTrace();
            out.print(printErrAlert("divErr", "Error.showDublicateChild", ex));
            return;
        }
    }
%>
<script type="text/javascript">
    if (!err){
        Alert.Success.showSaved();
        parent.ToolBar.Return.Do();
    }
</script>
