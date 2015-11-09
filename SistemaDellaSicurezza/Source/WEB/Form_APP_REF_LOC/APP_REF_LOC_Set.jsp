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
    Document   : APP_REF_LOC_Set
    Created on : 28-mag-2008, 08.47.52
    Author     : Giancarlo Servadei
--%>

<%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache");        //HTTP 1.0
            response.setDateHeader("Expires", 0);          //prevents caching at the proxy server
%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/AppReferentiLoco/AppReferentiLocoBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/AppReferentiLoco/AppReferentiLocoBean.jsp"%>

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
    IAppReferentiLocoHome home = (IAppReferentiLocoHome) PseudoContext.lookup("AppReferentiLocoBean");
    IAppReferentiLoco bean = null;
    
    String strCOD_REF_LOC = null;
    long lCOD_REF_LOC = 0;
    long lCOD_SRV = 0;
       
    if (request.getParameter("SBM_MODE") != null) {
                ReqMODE = request.getParameter("SBM_MODE");

        Checker c = new Checker();
        
        //- checking for required fields
        strCOD_REF_LOC = c.checkString(ApplicationConfigurator.LanguageManager.getString("ID.Referente.in.loco"), request.getParameter("COD_REF_LOC"), false);
        lCOD_SRV = c.checkLong(ApplicationConfigurator.LanguageManager.getString("ID.Contratto/Servizio"), request.getParameter("COD_SRV"), false);
        
        //- checking for not required fields
        String strNOM = c.checkString(ApplicationConfigurator.LanguageManager.getString("Nominativo"), request.getParameter("NOM"), true);
        String strQUA = c.checkString(ApplicationConfigurator.LanguageManager.getString("Qualifica"), request.getParameter("QUA"), false);
        String strTEL = c.checkString(ApplicationConfigurator.LanguageManager.getString("Telefono"), request.getParameter("TEL"), false);
        
        if (c.isError) {
            String err = c.printErrors();
            out.println("<script>alert(\"" + err + "\");</script>");
            return;
        }
        
        //con_ser_bean = con_ser_home.findByPrimaryKey(lCOD_SRV);
            
        if (ReqMODE.equals("edt")) {
            lCOD_REF_LOC = Long.parseLong(strCOD_REF_LOC);
            bean = home.findByPrimaryKey(new AppReferentiLocoPK(lCOD_SRV, lCOD_REF_LOC));
            try {
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
        } else if (ReqMODE.equals("new")) {
            out.print("<script>isNew=true;</script>");
            try {
                bean = home.create(lCOD_SRV, strNOM);
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
            lCOD_REF_LOC = bean.getCOD_REF_LOC();
        }
        
        if (bean != null) {
                // *Not require Fields*
                bean.setNOM(strNOM);
                bean.setQUA(strQUA);
                bean.setTEL(strTEL);
        }
    }
%>
<script type="text/javascript">
    if (!err){  
        if(isNew) {
            Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=lCOD_REF_LOC%>");
        }
        else{
            Alert.Success.showSaved(); 
        }
    }
</script>
