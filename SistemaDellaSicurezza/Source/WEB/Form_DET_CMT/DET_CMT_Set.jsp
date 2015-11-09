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
    Document   : DET_CMT_Set
    Created on : 7-mag-2008, 1.45.05
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
                long lCOM_COD_DPD = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Nominativo"), request.getParameter("lCOM_COD_DPD"), false);
                String strCOM_RES_TEL = c.checkString(ApplicationConfigurator.LanguageManager.getString("Telefono"), request.getParameter("COM_RES_TEL"), false);

                if (c.isError) {
                    String err = c.printErrors();
                    out.println(
                            "<script>" +
                            "alert(\"" + err + "\");" +
                            "err=true;" +
                            "</script>");
                    return;
                }

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
                    bean.setCOM_COD_DPD(lCOM_COD_DPD);
                    bean.setCOM_RES_TEL(strCOM_RES_TEL);
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
