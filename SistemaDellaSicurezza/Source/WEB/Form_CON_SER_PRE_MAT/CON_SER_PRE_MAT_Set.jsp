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
    Document   : CON_SER_PRE_MAT_Set
    Created on : 22-mag-2008, 15.06.04
    Author     : Giancarlo Servadei
--%>

<%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache");        //HTTP 1.0
            response.setDateHeader("Expires", 0);          //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/ContServPrestitoMateriali/ContServPrestitoMaterialiBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ContServPrestitoMateriali/ContServPrestitoMaterialiBean.jsp"%>

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
            IContServPrestitoMaterialiHome home = (IContServPrestitoMaterialiHome) PseudoContext.lookup("ContServPrestitoMaterialiBean");
            IContServPrestitoMateriali bean = null;

            IAnaContServHome con_ser_home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");
            IAnaContServ con_ser_bean = null;

            String strCOD_PRE_MAT = null;
            long lCOD_PRE_MAT = 0;
            long lCOD_SRV = 0;

            if (request.getParameter("SBM_MODE") != null) {
                ReqMODE = request.getParameter("SBM_MODE");

                Checker c = new Checker();

                //- checking for required fields
                strCOD_PRE_MAT = c.checkString(ApplicationConfigurator.LanguageManager.getString("ID.Prestito.materiale"), request.getParameter("COD_PRE_MAT"), false);
                lCOD_SRV = c.checkLong(ApplicationConfigurator.LanguageManager.getString("ID.Contratto/Servizio"), request.getParameter("COD_SRV"), false);
                String strTIP_MAT = c.checkString(ApplicationConfigurator.LanguageManager.getString("Tipo.di.materiale"), request.getParameter("TIP_MAT"), true);

                //- checking for not required fields
                String strLUO_MES_DIS = c.checkString(ApplicationConfigurator.LanguageManager.getString("Luogo.di.messa.a.disposizione"), request.getParameter("LUO_MES_DIS"), false);
                java.sql.Date dtDAT_INI_PRE = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.inizio.prestito"), request.getParameter("DAT_INI_PRE"), false);
                java.sql.Date dtDAT_FIN_PRE = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.fine.prestito"), request.getParameter("DAT_FIN_PRE"), false);
                
                String strPRE_MAT_DES_1 = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione.alta"), request.getParameter("PRE_MAT_DES_1"), false);
                String strPRE_MAT_DES_2 = c.checkString(ApplicationConfigurator.LanguageManager.getString("Osservazioni.all'atto.della.restituzione"), request.getParameter("PRE_MAT_DES_2"), false);
                String strPRE_MAT_ASS_APP_RAD = c.checkString(ApplicationConfigurator.LanguageManager.getString("Assegnazione.apparato.radio"), request.getParameter("PRE_MAT_ASS_APP_RAD"), false);
                if (strPRE_MAT_ASS_APP_RAD.equals("S")) {
                    strPRE_MAT_ASS_APP_RAD = "S";
                } else {
                    strPRE_MAT_ASS_APP_RAD = "N";
                }
                String strPRE_MAT_ASS_TEL_CEL = c.checkString(ApplicationConfigurator.LanguageManager.getString("Assegnazione.apparato.radio"), request.getParameter("PRE_MAT_ASS_TEL_CEL"), false);
                if (strPRE_MAT_ASS_TEL_CEL.equals("S")) {
                    strPRE_MAT_ASS_TEL_CEL = "S";
                } else {
                    strPRE_MAT_ASS_TEL_CEL = "N";
                }
                
                if (c.isError) {
                    String err = c.printErrors();
                    out.println("<script>alert(\"" + err + "\");</script>");
                    return;
                }
                
                con_ser_bean = con_ser_home.findByPrimaryKey(lCOD_SRV);

                if (ReqMODE.equals("edt")) {
                    lCOD_PRE_MAT = Long.parseLong(strCOD_PRE_MAT);
                    bean = home.findByPrimaryKey(new ContServPrestitoMaterialiPK(lCOD_SRV, lCOD_PRE_MAT));
                    try {
                    } catch (Exception ex) {
                        out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                        return;
                    }
                } else if (ReqMODE.equals("new")) {
                    out.print("<script>isNew=true;</script>");
                    try {
                        bean = home.create(lCOD_SRV, strTIP_MAT);
                    } catch (Exception ex) {
                        out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                        return;
                    }
                    lCOD_PRE_MAT = bean.getCOD_PRE_MAT();
                }

                if (bean != null) {
                    // *Not require Fields*  
                    bean.setTIP_MAT(strTIP_MAT);
                    bean.setLUO_MES_DIS(strLUO_MES_DIS);
                    bean.setDAT_INI_PRE(dtDAT_INI_PRE);
                    bean.setDAT_FIN_PRE(dtDAT_FIN_PRE);

                    con_ser_bean.setPRE_MAT_DES_1(strPRE_MAT_DES_1);
                    con_ser_bean.setPRE_MAT_DES_2(strPRE_MAT_DES_2);
                    con_ser_bean.setPRE_MAT_ASS_APP_RAD(strPRE_MAT_ASS_APP_RAD);
                    con_ser_bean.setPRE_MAT_ASS_TEL_CEL(strPRE_MAT_ASS_TEL_CEL);
                }
            }
%>
<script type="text/javascript">
    if (!err){  
        if(isNew) {
            Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=lCOD_PRE_MAT%>");
            }
            else{
                Alert.Success.showSaved(); 
            }
        }
</script>
