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
        <version number="1.0" date="21/05/2008" author="Dario Massaroni">
            <comments>
                <comment date="21/05/2008" author="Dario Massaroni">
                    <description>Create CON_SER_RIS_INT_Set.jsp</description>
                </comment>		
            </comments> 
        </version>
    </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache");        //HTTP 1.0
response.setDateHeader ("Expires", 0);          //prevents caching at the proxy server
%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/ContServRischiInterferenza/ContServRischiInterferenzaBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ContServRischiInterferenza/ContServRischiInterferenzaBean.jsp"%>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%!
    String ReqMODE; // parameter of request 
%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
    var isNew = false;
    var err=false;
</script>
<%
    IContServRischiInterferenzaHome home = (IContServRischiInterferenzaHome) 
            PseudoContext.lookup("ContServRischiInterferenzaBean");
    IContServRischiInterferenza bean = null;
    
    long lCOD_SRV = 0;
    long lCOD_RIS_INT = 0;
    String strFAS_LAV = "";
    String strTIP_INT = "";
    String strIMP_INT = "";
    String strRIS = "";
    String strMIS_PRE = "";
    
    if (request.getParameter("SBM_MODE") != null) {
        ReqMODE = request.getParameter("SBM_MODE");

        Checker c = new Checker();
        
        //- checking for required fields
        lCOD_SRV = c.checkLong(ApplicationConfigurator.LanguageManager.getString("ID.Contratto/Servizio"), request.getParameter("COD_SRV"), true);
        strRIS = c.checkString(ApplicationConfigurator.LanguageManager.getString("Rischio"), request.getParameter("RIS"), true).trim();
        
        //- checking for not required fields
        lCOD_RIS_INT = c.checkLong("", request.getParameter("COD_RIS_INT"), false);
        strFAS_LAV = c.checkString("", request.getParameter("FAS_LAV"), false).trim();
        strTIP_INT = c.checkString("", request.getParameter("TIP_INT"), false).trim();
        strIMP_INT = c.checkString("", request.getParameter("IMP_INT"), false).trim();
        strMIS_PRE = c.checkString("", request.getParameter("MIS_PRE"), false).trim();
        
        if (c.isError) {
            String err = c.printErrors();
            out.println("<script>alert(\"" + err + "\");</script>");
            return;
        }

        if (ReqMODE.equals("edt")) {
            bean = home.findByPrimaryKey(new ContServRischiInterferenzaPK(lCOD_SRV, lCOD_RIS_INT));
            bean.setRIS(strRIS);
        } else
        if (ReqMODE.equals("new")) {
            out.print("<script>isNew=true;</script>");
            try {
                bean = home.create(lCOD_SRV, strRIS);
                lCOD_RIS_INT = bean.getCOD_RIS_INT();
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
        }
        if (bean != null){
            bean.setFAS_LAV(strFAS_LAV);
            bean.setTIP_INT(strTIP_INT);
            bean.setIMP_INT(strIMP_INT);
            bean.setMIS_PRE(strMIS_PRE);
        }
    }
%>
<script>
    if (!err){  
        if(isNew) {
            Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=lCOD_RIS_INT%>");
        }
        else{
            Alert.Success.showSaved(); 
        }
    }
</script>
