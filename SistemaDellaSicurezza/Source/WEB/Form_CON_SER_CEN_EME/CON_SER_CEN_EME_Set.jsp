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
    Document   : CON_SER_CEN_EME_Set
    Created on : 21-mag-2008, 11.45.44
    Author     : Giancarlo Servadei
--%>

<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache");        //HTTP 1.0
response.setDateHeader ("Expires", 0);          //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServCentriEmergenza.*" %>

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
    IContServCentriEmergenzaHome home = (IContServCentriEmergenzaHome) PseudoContext.lookup("ContServCentriEmergenzaBean");
    IContServCentriEmergenza bean = null;
    
    IAnaContServHome con_ser_home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");            
    IAnaContServ con_ser_bean = null;
    
    String strCOD_CEN_EME = null;
    long lCOD_CEN_EME = 0;
    long lCOD_SRV = 0;
       
    if (request.getParameter("SBM_MODE") != null) {
        ReqMODE = request.getParameter("SBM_MODE");

        Checker c = new Checker();
        
        //- checking for required fields
        strCOD_CEN_EME = c.checkString(ApplicationConfigurator.LanguageManager.getString("ID.Centro.emergenza"), request.getParameter("COD_CEN_EME"), false);
        lCOD_SRV = c.checkLong(ApplicationConfigurator.LanguageManager.getString("ID.Contratto/Servizio"), request.getParameter("COD_SRV"), false);
        
        //- checking for not required fields
        String strDES = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"), request.getParameter("DES"), false);
        String strRIF = c.checkString(ApplicationConfigurator.LanguageManager.getString("Riferimento"), request.getParameter("RIF"), true);
        
        String strCEN_EME_DES = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione.alta"), request.getParameter("CEN_EME_DES"), false);
        
        if (c.isError) {
            String err = c.printErrors();
            out.println("<script>alert(\"" + err + "\");</script>");
            return;
        }
        
        con_ser_bean = con_ser_home.findByPrimaryKey(lCOD_SRV);
        
        if (ReqMODE.equals("edt")) {
            lCOD_CEN_EME = Long.parseLong(strCOD_CEN_EME);
            bean = home.findByPrimaryKey(new ContServCentriEmergenzaPK(lCOD_SRV, lCOD_CEN_EME));
            try {
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
        } else if (ReqMODE.equals("new")) {
            out.print("<script>isNew=true;</script>");
            try {
                bean = home.create(lCOD_SRV, strRIF);
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
            lCOD_CEN_EME = bean.getCOD_CEN_EME();//grazie a questo posso fare new salva e delete sullo stesso form
        }
        
        if (bean != null) {
                // *Not require Fields*
            try {
                bean.setDES(strDES);
                bean.setRIF(strRIF);
                
                con_ser_bean.setCEN_EME_DES(strCEN_EME_DES);
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
        }
    }
%>
<script type="text/javascript">
    if (!err){  
        if(isNew) {
            Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=lCOD_CEN_EME%>");
        }
        else{
            Alert.Success.showSaved(); 
        }
    }
</script>
