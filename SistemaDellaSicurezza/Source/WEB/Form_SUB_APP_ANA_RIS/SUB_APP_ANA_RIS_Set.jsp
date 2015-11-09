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
    Document   : SUB_APP_ANA_RIS_Set
    Created on : 29-mag-2008, 09.15.22
    Author     : Giancarlo Servadei
--%>

<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache");        //HTTP 1.0
response.setDateHeader ("Expires", 0);          //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.SubAppAnalisiRischi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%!
    String ReqMODE; // parameter of request 
%>
<script type="text/javascript" src="../_scripts/Alert.js"></script>
<script type="text/javascript">
    var isNew = false;
    var err=false;
</script>
<%
    ISubAppAnalisiRischiHome home = (ISubAppAnalisiRischiHome) PseudoContext.lookup("SubAppAnalisiRischiBean");
    ISubAppAnalisiRischi bean = null;
    
    long lCOD_SUB_APP = 0;
    long lCOD_RSO = 0;
    String strFAS_LAV = "";
    String strMOD_OPE = "";
    String strMAT_PRO_IMP = "";
    String strRIS = "";
    String strMIS_PRE_PRO = "";
    
    if (request.getParameter("SBM_MODE") != null) {
        ReqMODE = request.getParameter("SBM_MODE");

        Checker c = new Checker();
        
        //- checking for required fields
        lCOD_SUB_APP = c.checkLong(ApplicationConfigurator.LanguageManager.getString("ID.Contratto/Servizio"), request.getParameter("COD_SUB_APP"), true);
        strRIS = c.checkString(ApplicationConfigurator.LanguageManager.getString("Rischio"), request.getParameter("RIS"), true).trim();
        
        //- checking for not required fields
        lCOD_RSO = c.checkLong("", request.getParameter("COD_RSO"), false);
        strFAS_LAV = c.checkString("", request.getParameter("FAS_LAV"), false).trim();
        strMOD_OPE = c.checkString("", request.getParameter("MOD_OPE"), false).trim();
        strMAT_PRO_IMP = c.checkString("", request.getParameter("MAT_PRO_IMP"), false).trim();
        strMIS_PRE_PRO = c.checkString("", request.getParameter("MIS_PRE_PRO"), false).trim();
        
        if (c.isError) {
            String err = c.printErrors();
            out.println("<script>alert(\"" + err + "\");</script>");
            return;
        }

        if (ReqMODE.equals("edt")) {
            bean = home.findByPrimaryKey(new SubAppAnalisiRischiPK(lCOD_SUB_APP, lCOD_RSO));
            bean.setRIS(strRIS);
        } else
        if (ReqMODE.equals("new")) {
            out.print("<script>isNew=true;</script>");
            try {
                bean = home.create(lCOD_SUB_APP, strRIS);
                lCOD_RSO = bean.getCOD_RSO();
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
        }
        if (bean != null){
            bean.setFAS_LAV(strFAS_LAV);
            bean.setMOD_OPE(strMOD_OPE);
            bean.setMAT_PRO_IMP(strMAT_PRO_IMP);
            bean.setMIS_PRE_PRO(strMIS_PRE_PRO);
        }
    }
%>
<script type="text/javascript">
    if (!err){  
        if(isNew) {
            Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=lCOD_RSO%>");
        }
        else{
            Alert.Success.showSaved(); 
        }
    }
</script>
