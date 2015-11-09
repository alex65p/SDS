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

<%-- 
    Document   : ANA_PSC_Set
    Created on : 4-apr-2011, 16.15.47
    Author     : Alessandro
--%>

<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.PSC.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!    String ReqMODE;	// parameter of request
%>
<script>
    var err=false;
    var isNew=false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
    IPSC bean = null;

    if (request.getParameter("SBM_MODE") != null) {
        ReqMODE = request.getParameter("SBM_MODE");
        out.println(ReqMODE);

        Checker c = new Checker();

        //- checking for fields
        long lCOD_PRO = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Procedimento"), request.getParameter("COD_PRO"), true);         //2
        String strTIT = c.checkString(ApplicationConfigurator.LanguageManager.getString("Titolo"), request.getParameter("TIT"), false);                  //3
        String strOGG = c.checkString(ApplicationConfigurator.LanguageManager.getString("Oggetto"), request.getParameter("OGG"), false);                 //4
        String strCOD = c.checkString(ApplicationConfigurator.LanguageManager.getString("Codice"), request.getParameter("COD_PSC"), true);                  //5
        java.sql.Date dtDAT_PRM_REG = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data"), request.getParameter("DAT_PRM_REG_ID"), false);        //6
        String strCOD_ELA = c.checkString(ApplicationConfigurator.LanguageManager.getString("Codifica.elaborato"), request.getParameter("COD_ELA"), false);                  //3
        long lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"), request.getParameter("COD_AZL"), true);         //7

        if (c.isError) {
            String err = c.printErrors();
            out.println("<script>alert(\"" + err + "\");</script>");
            return;
        }
        
        if (ReqMODE.equals("edt")) {
            Long lCOD_PSC = new Long(c.checkLong("PSC", request.getParameter("PSC_ID"), true));
            IPSCHome home = (IPSCHome) PseudoContext.lookup("PSCBean");
            bean = home.findByPrimaryKey(lCOD_PSC);
            bean.setlCOD_PRO(lCOD_PRO);
            bean.setstrTIT(strTIT);
            bean.setstrCOD(strCOD);
            bean.setstrOGG(strOGG);
            bean.setdtDAT_PRM_REG(dtDAT_PRM_REG);
            bean.setCOD_ELA(strCOD_ELA);
        }
        
        if (ReqMODE.equals("new")) {
            IPSCHome home = (IPSCHome) PseudoContext.lookup("PSCBean");
            try {
                bean = home.create(lCOD_PRO, strTIT, strOGG, strCOD, dtDAT_PRM_REG, strCOD_ELA, lCOD_AZL);
%><script>isNew=true;</script><%
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
        }
    }
%>
<script>
    if(!err){
        if(isNew){
            Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=bean.getlCOD_PSC()%>");
        }else{
            Alert.Success.showSaved();
        }
    }
</script>
