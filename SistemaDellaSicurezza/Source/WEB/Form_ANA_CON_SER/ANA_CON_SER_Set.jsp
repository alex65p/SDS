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
    Document   : ANA_CON_SER_Set
    Created on : 1-mag-2008, 9.12.52
    Author     : Giancarlo Servadei
--%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp"%>

<%@ include file="../_include/Checker.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp"%>

<%!
    String ReqMODE;
%>

<script>
    var err = false;
    var isNew = false;
</script>

<script type="text/javascript" src="../_scripts/Alert.js"></script>

<%
            IAnaContServHome home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");
            long lCOD_AZL = Security.getAzienda();
            IAnaContServ bean = null;
            long COD_SRV;
            String strPRO_CON;
            
            if (request.getParameter("SBM_MODE") != null) {
                ReqMODE = request.getParameter("SBM_MODE");
                
                if (ReqMODE.equals("new")) {
                    strPRO_CON = home.getProgressivoContratto
                            (lCOD_AZL, String.valueOf(Calendar.getInstance().get(Calendar.YEAR)));    
                } else {
                    strPRO_CON = request.getParameter("PRO_CON");
                }
                
                Checker c = new Checker();

                //- checking for required fields
                strPRO_CON = c.checkString(ApplicationConfigurator.LanguageManager.getString("Progressivo.contratto/servizio"), strPRO_CON, true);
                long lAPP_COD_DTE = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Ditta.appaltatrice"), request.getParameter("APP_COD_DTE"), true);

                //- checking for not required fields		
                String strDES_CON = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"), request.getParameter("DES_CON"), false);
                String strRIF_CON = c.checkString(ApplicationConfigurator.LanguageManager.getString("Riferimento.contratto"), request.getParameter("RIF_CON"), false);
                Long lCOD_UNI_ORG = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Servizio.responsabile"), request.getParameter("COD_UNI_ORG"), false);
                java.sql.Date dtDAT_INI_LAV = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.inizio.lavori"), request.getParameter("DAT_INI_LAV"), false);
                java.sql.Date dtDAT_FIN_LAV = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.fine.lavori"), request.getParameter("DAT_FIN_LAV"), false);
                String strORA_LAV = c.checkString(ApplicationConfigurator.LanguageManager.getString("Orario.di.lavoro"), request.getParameter("ORA_LAV"), false);
  
                String strLAV_NOT = c.checkString(ApplicationConfigurator.LanguageManager.getString("Lavoro.notturno"), request.getParameter("LAV_NOT"), false);
                if (strLAV_NOT.equals("S")) {
                    strLAV_NOT = "S";
                } else {
                    strLAV_NOT = "N";
                }
                
                int iNUM_LAV_PRE = c.checkInt(ApplicationConfigurator.LanguageManager.getString("N.ro.lavoratori.in.cantiere"), request.getParameter("NUM_LAV_PRE"), false);

                if (c.isError) {
                    String err = c.printErrors();
                    out.println(
                            "<script>" +
                                "alert(\"" + err + "\");" +
                                "err=true;" +
                            "</script>");
                    return;
                }
                
                if (ReqMODE.equals("new")) {
                    try {
                        bean = home.create(lCOD_AZL, strPRO_CON, lAPP_COD_DTE);
                        out.print(
                                "<script>" +
                                    "isNew=true;" +
                                "</script>");
                    } catch (Exception ex) {
                        out.print(
                                "<script>" +
                                    "Alert.Error.showDublicate();" +
                                    "err=true;" +
                                "</script>");
                        return;
                    }
                    out.print(
                            "<script>" +
                                "isNew=true;" +
                            "</script>");
                } else
                if (ReqMODE.equals("edt")) {
                    COD_SRV = Long.parseLong(request.getParameter("COD_SRV"));
                    bean = home.findByPrimaryKey(COD_SRV);
                    try {
                        bean.setPRO_CON(strPRO_CON);
                        bean.setAPP_COD_DTE(lAPP_COD_DTE);
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
                    bean.setDES_CON(strDES_CON);
                    bean.setRIF_CON(strRIF_CON);
                    bean.setCOD_UNI_ORG(lCOD_UNI_ORG);
                    bean.setDAT_INI_LAV(dtDAT_INI_LAV);
                    bean.setDAT_FIN_LAV(dtDAT_FIN_LAV);
                    bean.setORA_LAV(strORA_LAV);
                    bean.setLAV_NOT(strLAV_NOT);
                    bean.setNUM_LAV_PRE(iNUM_LAV_PRE);
                }
            }
%>
<script>
if(!err){
    if(isNew){
        Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=bean.getCOD_SRV()%>");
        }else{
            Alert.Success.showSaved();
    }
    parent.returnValue="OK";
}
</script>
