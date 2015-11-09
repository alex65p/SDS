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
    Document   : DET_APL_Set
    Created on : 8-mag-2008, 9.24.03
    Author     : Giancarlo Servadei
--%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp"%>

<%@ include file="../_include/Checker.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp"%>

<script type="text/javascript" src="../_scripts/Alert.js"></script>

<%!    String ReqMODE;%>

<script>
    var err = false;
    var isNew = false;
    </script>

<%
            IAnaContServHome home = null;
            IAnaContServ bean = null;
            long COD_SRV;

            if (request.getParameter("SBM_MODE") != null) {
                ReqMODE = request.getParameter("SBM_MODE");
                Checker c = new Checker();

                //- checking for required fields
                String strPRO_CON = c.checkString(ApplicationConfigurator.LanguageManager.getString("Progressivo.contratto/servizio"), request.getParameter("PRO_CON"), true);
                String strAPP_TEL = c.checkString(ApplicationConfigurator.LanguageManager.getString("Telefono"), request.getParameter("APP_TEL"), false);
                String strAPP_FAX = c.checkString(ApplicationConfigurator.LanguageManager.getString("Fax"), request.getParameter("APP_FAX"), false);
                String strAPP_EMAIL = c.checkEmail(ApplicationConfigurator.LanguageManager.getString("E-mail"), request.getParameter("APP_EMAIL"), false);

                String strAPP_RES_NOM = c.checkString(ApplicationConfigurator.LanguageManager.getString("Nominativo"), request.getParameter("APP_RES_NOM"), false);
                String strAPP_RES_QUA = c.checkString(ApplicationConfigurator.LanguageManager.getString("Qualifica"), request.getParameter("APP_RES_QUA"), false);
                String strAPP_RES_TEL = c.checkString(ApplicationConfigurator.LanguageManager.getString("Telefono"), request.getParameter("APP_RES_TEL"), false);

                String strAPP_INT_ASS_DES = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"), request.getParameter("APP_INT_ASS_DES"), false);
                String strAPP_INT_ASS_ORA_LAV = c.checkString(ApplicationConfigurator.LanguageManager.getString("Orario.di.lavoro"), request.getParameter("APP_INT_ASS_ORA_LAV"), false);
                int iAPP_INT_ASS_COD_CON = c.checkInt(ApplicationConfigurator.LanguageManager.getString("Codice.consegna"), request.getParameter("APP_INT_ASS_COD_CON"), false);
                String strAPP_INT_ASS_CON_DES = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descr.Interv.Assegnato"), request.getParameter("APP_INT_ASS_CON_DES"), false);


                if (c.isError) {
                    String err = c.printErrors();
                    out.println(
                            "<script>" +
                            "alert(\"" + err + "\");" +
                            "err=true;" +
                            "</script>");
                    return;
                }

                long lCOD_AZL = Security.getAzienda();

                home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");

                if (ReqMODE.equals("edt")) {
                    COD_SRV = Long.parseLong(request.getParameter("COD_SRV"));
                    bean = home.findByPrimaryKey(COD_SRV);
                    try {
                        bean.setPRO_CON(strPRO_CON);
                    } catch (Exception ex) {
                        out.print(
                                "<script>" +
                                "Alert.Error.showDublicate();" +
                                "err=true;" +
                                "</script>");
                        return;
                    }
                }

                if (bean != null) {
                    // *Not require Fields*
                    bean.setAPP_TEL(strAPP_TEL);
                    bean.setAPP_FAX(strAPP_FAX);
                    bean.setAPP_EMAIL(strAPP_EMAIL);
                    bean.setAPP_RES_NOM(strAPP_RES_NOM);
                    bean.setAPP_RES_QUA(strAPP_RES_QUA);
                    bean.setAPP_RES_TEL(strAPP_RES_TEL);
                    bean.setAPP_INT_ASS_DES(strAPP_INT_ASS_DES);
                    bean.setAPP_INT_ASS_ORA_LAV(strAPP_INT_ASS_ORA_LAV);
                    bean.setAPP_INT_ASS_COD_CON(iAPP_INT_ASS_COD_CON);
                    bean.setAPP_INT_ASS_CON_DES(strAPP_INT_ASS_CON_DES);
                }
            }
%>
<script>
    if(!err){
        if(isNew){
            Alert.Success.showCreated();
        }else{
        Alert.Success.showSaved();
    }
    parent.returnValue="OK";
}

</script>            
