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
    <version number="1.0" date="27/02/2004" author="Mike Kondratyuk">		
    <comments>
    <comment date="27/02/2004" author="Mike Kondratyuk">
    <description>attach file dla ANA_COR</description>
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
<%@page import="com.apconsulting.luna.ejb.Sopraluogo.*"%>
<%@page import="com.apconsulting.luna.ejb.Dipendente.*"%>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>

<%
//    Map mmm = null;
//    mmm = request.getParameterMap();
//    Object obj = mmm.get("ID");

    long lCOD_AZL = Security.getAzienda();
    String sCOD_DPD = (String) request.getParameter("ID");

    out.print("werwer");

    ISopraluogo bean_dpd = null;
    ISopraluogoHome home_dpd = (ISopraluogoHome) PseudoContext.lookup("SopraluogoBean");

    String strSubject = (String) request.getParameter("ATTACH_SUBJECT");

    try {
        String sCOD_SOP = (String) request.getParameter("ID_PARENT");// session.getAttribute("COD_SOP").toString();
        if (sCOD_SOP != null) {
            bean_dpd = home_dpd.findByPrimaryKey(new Long(sCOD_SOP));
            Long lCOD_DPD = Long.parseLong(sCOD_DPD);
            if ("DPD_INT".equals(strSubject)) {
                bean_dpd.addCOD_SOP_DPD(lCOD_DPD, "");
            }else if ("DPD_EST".equals(strSubject)) {
                bean_dpd.addCOD_SOP_DPD_est(lCOD_DPD, "");
            }else if ("DOC_SOP".equals(strSubject)) {
                bean_dpd.addDOC_GES_CAN_SOP(lCOD_DPD);
            } else {
                return;
            }
        }
    } catch (Exception ex) {
        out.print("<script>Alert.Error.showDublicateChild</script>");
        return;
    }
%>
<script>
    parent.ToolBar.Return.Do();
</script>
