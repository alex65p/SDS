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
    Document   : APP_PRO_SOS_Set
    Created on : 25-mag-2008, 9.16.53
    Author     : Giancarlo Servadei
--%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>
<%@ page import="com.apconsulting.luna.ejb.AppProdottiSostanze.*" %>

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
    IAppProdottiSostanzeHome home = (IAppProdottiSostanzeHome) PseudoContext.lookup("AppProdottiSostanzeBean");
    IAppProdottiSostanze bean = null;
    
    IAnaContServHome con_ser_home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");            
    IAnaContServ con_ser_bean = null;
    
    String strCOD_PRO_SOS = null;
    long lCOD_PRO_SOS = 0;
    long lCOD_SRV = 0;
       
    if (request.getParameter("SBM_MODE") != null) {
                ReqMODE = request.getParameter("SBM_MODE");

        Checker c = new Checker();
        
        //- checking for required fields
        strCOD_PRO_SOS = c.checkString(ApplicationConfigurator.LanguageManager.getString("ID.Prodotto/Sostanza"), request.getParameter("COD_PRO_SOS"), false);
        lCOD_SRV = c.checkLong(ApplicationConfigurator.LanguageManager.getString("ID.Contratto/Servizio"), request.getParameter("COD_SRV"), false);
        
        //- checking for not required fields
        String strDES = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"), request.getParameter("DES"), true);
        
        String strPRO_SOS_DES = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione.bassa"), request.getParameter("PRO_SOS_DES"), false);
        
        if (c.isError) {
            String err = c.printErrors();
            out.println("<script>alert(\"" + err + "\");</script>");
            return;
        }
        
        //long lCOD_SRV = sub_app_home.getCodSrvByCodSubApp(lCOD_SUB_APP);
        con_ser_bean = con_ser_home.findByPrimaryKey(lCOD_SRV);
            
        if (ReqMODE.equals("edt")) {
            lCOD_PRO_SOS = Long.parseLong(strCOD_PRO_SOS);
            bean = home.findByPrimaryKey(new AppProdottiSostanzePK(lCOD_SRV, lCOD_PRO_SOS));
            try {
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
        } else if (ReqMODE.equals("new")) {
            out.print("<script>isNew=true;</script>");
            try {
                bean = home.create(lCOD_SRV, strDES);
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
            lCOD_PRO_SOS = bean.getCOD_PRO_SOS();
        }
        
        if (bean != null) {
                // *Not require Fields*  
                bean.setDES(strDES);
                
                con_ser_bean.setPRO_SOS_DES(strPRO_SOS_DES);
        }
    }
%>
<script type="text/javascript">
    if (!err){  
        if(isNew) {
            Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=lCOD_PRO_SOS%>");
        }
        else{
            Alert.Success.showSaved(); 
        }
    }
</script>
