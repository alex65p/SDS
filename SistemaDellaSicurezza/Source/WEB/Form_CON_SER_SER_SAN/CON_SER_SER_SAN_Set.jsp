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
    Document   : CON_SER_SAN_Set
    Created on : 21-mag-2008, 17.05.13
    Author     : Giancarlo Servadei
--%>

<%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache");        //HTTP 1.0
            response.setDateHeader("Expires", 0);          //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServServiziSanitari.*" %>

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
            IContServServiziSanitariHome home = (IContServServiziSanitariHome) PseudoContext.lookup("ContServServiziSanitariBean");
            IContServServiziSanitari bean = null;

            IAnaContServHome con_ser_home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");
            IAnaContServ con_ser_bean = null;

            String strCOD_SRV_SAN = null;
            long lCOD_SRV_SAN = 0;
            long lCOD_SRV = 0;

            if (request.getParameter("SBM_MODE") != null) {
                ReqMODE = request.getParameter("SBM_MODE");

                Checker c = new Checker();

                //- checking for required fields
                strCOD_SRV_SAN = c.checkString(ApplicationConfigurator.LanguageManager.getString("ID.Servizio.sanitario"), request.getParameter("COD_SRV_SAN"), false);
                lCOD_SRV = c.checkLong(ApplicationConfigurator.LanguageManager.getString("ID.Contratto/Servizio"), request.getParameter("COD_SRV"), false);

                //- checking for not required fields
                String strDES_SRV_VIT = c.checkString(ApplicationConfigurator.LanguageManager.getString("Designazione.dei.servizi.vita"), request.getParameter("DES_SRV_VIT"), true);
                java.sql.Date dtDAT_INI_IMP = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.inizio.consegna"), request.getParameter("DAT_INI_IMP"), false);
                java.sql.Date dtDAT_FIN_IMP = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.fine.consegna"), request.getParameter("DAT_FIN_IMP"), false);
                String strORA_IMP = c.checkString(ApplicationConfigurator.LanguageManager.getString("Orario.d'impiego"), request.getParameter("ORA_IMP"), false);

                String strSER_SAN_DES_1 = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione.alta"), request.getParameter("SER_SAN_DES_1"), false);
                String strSER_SAN_DES_2 = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione.bassa"), request.getParameter("SER_SAN_DES_2"), false);
                String strSER_SAN_DES_3 = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione.bassa"), request.getParameter("SER_SAN_DES_3"), false);

                if (c.isError) {
                    String err = c.printErrors();
                    out.println("<script>alert(\"" + err + "\");</script>");
                    return;
                }
                
                con_ser_bean = con_ser_home.findByPrimaryKey(lCOD_SRV);

                if (ReqMODE.equals("edt")) {
                    lCOD_SRV_SAN = Long.parseLong(strCOD_SRV_SAN);
                    bean = home.findByPrimaryKey(new ContServServiziSanitariPK(lCOD_SRV, lCOD_SRV_SAN));
                    try {
                    } catch (Exception ex) {
                        out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                        return;
                    }
                } else if (ReqMODE.equals("new")) {
                    out.print("<script>isNew=true;</script>");
                    try {
                        bean = home.create(lCOD_SRV, strDES_SRV_VIT);
                    } catch (Exception ex) {
                        out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                        return;
                    }
                    lCOD_SRV_SAN = bean.getCOD_SRV_SAN();
                }

                if (bean != null) {
                    // *Not require Fields*  
                    bean.setDES_SRV_VIT(strDES_SRV_VIT);
                    bean.setDAT_INI_IMP(dtDAT_INI_IMP);
                    bean.setDAT_FIN_IMP(dtDAT_FIN_IMP);
                    bean.setORA_IMP(strORA_IMP);

                    con_ser_bean.setSER_SAN_DES_1(strSER_SAN_DES_1);
                    con_ser_bean.setSER_SAN_DES_2(strSER_SAN_DES_2);
                    con_ser_bean.setSER_SAN_DES_3(strSER_SAN_DES_3);
                }
            }
%>
<script type="text/javascript">
    if (!err){ 
        if(isNew) {
            Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=lCOD_SRV_SAN%>");
        } else {
            Alert.Success.showSaved(); 
        }
    }
</script>
