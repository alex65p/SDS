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
    Document   : CON_SER_SUB_APP_Set
    Created on : 13-mag-2008, 14.09.09
    Author     : Giancarlo Servadei
--%>
<%@ page import="com.apconsulting.luna.ejb.ContServSubApp.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp"%>

<%@ include file="../_include/Checker.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp"%>

<script type="text/javascript" src="../_scripts/Alert.js"></script>

<%!    String ReqMODE;   %>

<script type="text/javascript">
    var err = false;
    var isNew = false;
</script>

<%
            IContServSubAppHome home = null;
            IContServSubApp bean = null;
            long lCOD_SUB_APP = 0;
            if (request.getParameter("SBM_MODE") != null) {
                ReqMODE = request.getParameter("SBM_MODE");
                Checker c = new Checker();

                long COD_SRV = c.checkLong(ApplicationConfigurator.LanguageManager.getString("ID.Contratto/Servizio"), request.getParameter("lCOD_SRV"), true);
                long COD_DTE = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Ragione.sociale"), request.getParameter("lCOD_DTE"), true);
                
                String strTEL = c.checkString(ApplicationConfigurator.LanguageManager.getString("Telefono"), request.getParameter("TEL"), false);
                String strFAX = c.checkString(ApplicationConfigurator.LanguageManager.getString("Fax"), request.getParameter("FAX"), false);
                String strEMAIL = c.checkEmail(ApplicationConfigurator.LanguageManager.getString("E-mail"), request.getParameter("EMAIL"), false);
                
                String strRES_LOC_NOM = c.checkString(ApplicationConfigurator.LanguageManager.getString("Nominativo"), request.getParameter("RES_LOC_NOM"), false);
                String strRES_LOC_QUA = c.checkString(ApplicationConfigurator.LanguageManager.getString("Qualifica"), request.getParameter("RES_LOC_QUA"), false);
                String strRES_LOC_TEL = c.checkString(ApplicationConfigurator.LanguageManager.getString("Telefono"), request.getParameter("RES_LOC_TEL"), false);

                String strINT_ASS_DES = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione.intervento"), request.getParameter("INT_ASS_DES"), false);
                String strORA_LAV = c.checkString(ApplicationConfigurator.LanguageManager.getString("Orario.di.lavoro"), request.getParameter("ORA_LAV"), false);
                java.sql.Date dtDAT_INI_LAV = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.inizio.lavori"), request.getParameter("DAT_INI_LAV"), false);
                java.sql.Date dtDAT_FIN_LAV = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.fine.lavori"), request.getParameter("DAT_FIN_LAV"), false);
                
                String strLAV_NOT = c.checkString(ApplicationConfigurator.LanguageManager.getString("Lavoro.notturno"), request.getParameter("LAV_NOT"), false);
                if (strLAV_NOT.equals("S")) {
                    strLAV_NOT = "S";
                } else {
                    strLAV_NOT = "N";
                }
                int iCOD_CON = c.checkInt(ApplicationConfigurator.LanguageManager.getString("Codice.consegna"), request.getParameter("COD_CON"), false);
                String strCON_DES = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descr.ALTRA.consegna"), request.getParameter("CON_DES"), false);

                if (c.isError) {
                    String err = c.printErrors();
                    out.println(
                            "<script>" +
                                "alert(\"" + err + "\");" +
                                "err=true;" +
                            "</script>");
                    return;
                }
                
                home = (IContServSubAppHome) PseudoContext.lookup("ContServSubAppBean");
                
                if (ReqMODE.equals("edt")) {
                    lCOD_SUB_APP = Long.parseLong(request.getParameter("COD_SUB_APP"));
                    bean = home.findByPrimaryKey(lCOD_SUB_APP);
                    try {
                    } catch (Exception ex) {
                        out.print(
                                "<script>" +
                                    "Alert.Error.showDublicate();" +
                                    "err=true;" +
                                "</script>");
                        return;
                    }
                } else if (ReqMODE.equals("new")) {
                    try {
                        bean = home.create(COD_SRV, COD_DTE);
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
                    lCOD_SUB_APP = bean.getCOD_SUB_APP();
                }
                
                if (bean != null) {
                    // *Not require Fields*
                    bean.setTEL(strTEL);
                    bean.setFAX(strFAX);
                    bean.setEMAIL(strEMAIL);
                    bean.setRES_LOC_NOM(strRES_LOC_NOM);
                    bean.setRES_LOC_QUA(strRES_LOC_QUA);
                    bean.setRES_LOC_TEL(strRES_LOC_TEL);
                    bean.setINT_ASS_DES(strINT_ASS_DES);
                    bean.setORA_LAV(strORA_LAV);
                    bean.setDAT_INI_LAV(dtDAT_INI_LAV);
                    bean.setDAT_FIN_LAV(dtDAT_FIN_LAV);
                    bean.setLAV_NOT(strLAV_NOT);
                    bean.setCOD_CON(iCOD_CON);
                    bean.setCON_DES(strCON_DES);
                }
            }
%>
<script type="text/javascript">
if(!err){
    if(isNew){
        Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=lCOD_SUB_APP%>");
        }else{
            Alert.Success.showSaved();
    }
    parent.returnValue="OK";
}
</script>
