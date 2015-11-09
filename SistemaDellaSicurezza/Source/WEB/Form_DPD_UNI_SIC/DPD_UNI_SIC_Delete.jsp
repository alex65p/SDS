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
            <comment date="26/02/2004" author="Alex Kyba">
            <description>
            pofiksal bugi
            </description>
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
<%@ page import="com.apconsulting.luna.ejb.UnitaSicurezza.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script type="text/javascript" src="../_scripts/Alert.js"></script>
<script type="text/javascript">var err=false;</script>
<%
    long lCOD_UNI_SIC = 0;
    long lCOD_DPD = 0;
    long lCOD_AZL = Security.getAzienda();
    long lCOD_UNI_ORG = 0;
    long lCOD_RUO_SIC = 0;

    boolean uni_sic_4_dip =
            ApplicationConfigurator.isModuleEnabled(MODULES.UNI_SIC_4_DIP);

    String strCOD_UNI_SIC = "";

    IUnitaSicurezza bean = null;

    if (request.getParameter("ID_PARENT") != null && request.getParameter("ID") != null && request.getParameter("ID2")!=null) {
        strCOD_UNI_SIC = request.getParameter("ID_PARENT");
        lCOD_UNI_SIC = new Long(strCOD_UNI_SIC).longValue();
        lCOD_DPD = new Long(request.getParameter("ID")).longValue();

        IUnitaSicurezzaHome home = (IUnitaSicurezzaHome) PseudoContext.lookup("UnitaSicurezzaBean");
        bean = home.findByPrimaryKey(new Long(strCOD_UNI_SIC));
        
        try {
            if (lCOD_DPD != 0) {
                if (uni_sic_4_dip){
                    lCOD_RUO_SIC = new Long(request.getParameter("ID2"));
                    bean.removeDIP(lCOD_UNI_SIC, lCOD_AZL, lCOD_DPD, lCOD_RUO_SIC);
                } else {
                    lCOD_UNI_ORG = new Long(request.getParameter("ID2"));
                    bean.removeUO(lCOD_UNI_SIC, lCOD_AZL, lCOD_DPD, lCOD_UNI_ORG);
                }
            }
        } catch (Exception ex) {
            out.print("<script>err=true;</script>");
        }
    } else {
        out.print("<script>err=true;</script>");
    }
%>
<script>
    if (!err){
        Alert.Success.showDeleted();
        parent.returnValue="OK";
        parent.del_localRow();
    }else{
        Alert.Error.showDelete();
        parent.returnValue="CANCEL";
    }
</script>
