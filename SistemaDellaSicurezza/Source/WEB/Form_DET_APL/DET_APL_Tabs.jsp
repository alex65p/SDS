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
    Document   : DET_APL_Tabs
    Created on : 23-mag-2008, 22.18.27
    Author     : Giancarlo Servadei
--%>

<%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache");        //HTTP 1.0
            response.setDateHeader("Expires", 0);            //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>
<%@ page import="com.apconsulting.luna.ejb.AppProdottiSostanze.*" %>
                                           
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/AppReferentiLoco/AppReferentiLocoBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/AppReferentiLoco/AppReferentiLocoBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/AppPersonaleCoinvolto/AppPersonaleCoinvoltoBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/AppPersonaleCoinvolto/AppPersonaleCoinvoltoBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/AppAnalisiRischi/AppAnalisiRischiBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/AppAnalisiRischi/AppAnalisiRischiBean.jsp"%>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<html>
<body>
<script type="text/javascript" src="../_scripts/Alert.js"></script>
<script>
    var err = false;
    </script>
<div id="dContent">
    <%
            Checker c = new Checker();
            long lCOD_SRV = c.checkLong(ApplicationConfigurator.LanguageManager.getString("ID.Contratto/Servizio"), request.getParameter("ID_PARENT"), true);

            if (c.isError) {
                String err = c.printErrors();
    %><script>alert("<%=err%>");</script><%
                return;
            }

            IAnaContServHome home = null;
            IAnaContServ bean = null;
            try {
                home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");
                bean = home.findByPrimaryKey(lCOD_SRV);
            } catch (Exception ex) {
                ex.printStackTrace();
                out.print(printErrAlert("divErr", "Error.showNotFound", ex));
                return;
            }
            try {
                if (bean != null) {
                    //Referenti in loco
                    if (request.getParameter("TAB_NAME").equals("tab1")) {
                        IAppReferentiLocoHome ref_loc_home = (IAppReferentiLocoHome) PseudoContext.lookup("AppReferentiLocoBean");
                        out.println(BuildReferentiInLocoTab(ref_loc_home, lCOD_SRV));
                    } // Personale coinvolto
                    else if (request.getParameter("TAB_NAME").equals("tab2")) {
                        IAppPersonaleCoinvoltoHome per_coi_home = (IAppPersonaleCoinvoltoHome) PseudoContext.lookup("AppPersonaleCoinvoltoBean");
                        out.println(BuildPersonaleCoinvoltoTab(per_coi_home, lCOD_SRV));
                    } // Prodotti/Sostanze
                    else if (request.getParameter("TAB_NAME").equals("tab3")) {
                        IAppProdottiSostanzeHome pro_sos_home = (IAppProdottiSostanzeHome) PseudoContext.lookup("AppProdottiSostanzeBean");
                        out.println(BuildProdottiSostanzeTab(pro_sos_home, lCOD_SRV));
                    } // AnalisiDeiRischi
                    else if (request.getParameter("TAB_NAME").equals("tab4")) {
                        IAppAnalisiRischiHome ana_ris_home = (IAppAnalisiRischiHome) PseudoContext.lookup("AppAnalisiRischiBean");
                        out.println(BuildAnalisiDeiRischiTab(ana_ris_home, lCOD_SRV));
                    } else {
                        return;
                    }
                }
            } catch (Exception ex) {
                ex.printStackTrace();
    %><%
            }
    %>
</div>
<script>
    if (!err){
        parent.tabbar.ReloadTabTable(document);
    }
    else{
        Alert.Error.showNotFound();
    }
    </script>
<%!
// Referenti in loco
    String BuildReferentiInLocoTab(IAppReferentiLocoHome home, long lCOD_SRV) {
        java.util.Collection col = home.findEx_ReferentiLocoApp(lCOD_SRV, 0, null, null, null, 0);
        StringBuilder jspOutputBuilder = new StringBuilder();
        jspOutputBuilder.append("<table border='0' align='left' width='755' id='AppReferentiLocoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>")
                .append("<tr>")
                .append("<td width='400'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nominativo") + "</strong></td>")
                .append("<td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Qualifica") + "</strong></td>")
                .append("<td width='155'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Telefono") + "</strong></td>")
                .append("</table>")
                .append("<table border='0' align='left' width='755' id='AppReferentiLoco' class='dataTable' cellpadding='0' cellspacing='0'>")
                .append("<tr style='display:none' ID='' INDEX='" + lCOD_SRV + "'>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='NOM' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='QUA' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='TEL' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("</tr>");

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            AppReferentiLoco_View obj = (AppReferentiLoco_View) it.next();
            jspOutputBuilder.append("<tr INDEX='" + lCOD_SRV + "' ID='" + obj.COD_REF_LOC + "'>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 400px;' class='inputstyle'  value=\"" + Formatter.format(obj.NOM) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 200px;' class='inputstyle'  value=\"" + Formatter.format(obj.QUA) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 155px;' class='inputstyle'  value=\"" + Formatter.format(obj.TEL) + "\">")
                    .append("</td>")
                    .append("</tr>");
        }
        jspOutputBuilder.append("</table>");
        return jspOutputBuilder.toString();
    }

// Personale coinvolto
    String BuildPersonaleCoinvoltoTab(IAppPersonaleCoinvoltoHome home, long lCOD_SRV) {
        java.util.Collection col = home.findEx_PersonaleCoinvoltoApp(lCOD_SRV, 0, null, null, 0);
        StringBuilder jspOutputBuilder = new StringBuilder();
        jspOutputBuilder.append("<table border='0' align='left' width='755' id='AppPersonaleCoinvoltoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>")
                .append("<tr>")
                .append("<td width='500'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td>")
                .append("<td width='255'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Qualifica") + "</strong></td>")
                .append("</table>")
                .append("<table border='0' align='left' width='755' id='AppPersonaleCoinvolto' class='dataTable' cellpadding='0' cellspacing='0'>")
                .append("<tr style='display:none' ID='' INDEX='" + lCOD_SRV + "'>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='NOM' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='QUA' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("</tr>");

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            AppPersonaleCoinvolto_View obj = (AppPersonaleCoinvolto_View) it.next();
            jspOutputBuilder.append("<tr INDEX='" + lCOD_SRV + "' ID='" + obj.COD_PER_COI + "'>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 500px;' class='inputstyle'  value=\"" + Formatter.format(obj.NOM) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 255px;' class='inputstyle'  value=\"" + Formatter.format(obj.QUA) + "\">")
                    .append("</td>")
                    .append("</tr>");
        }
        jspOutputBuilder.append("</table>");
        return jspOutputBuilder.toString();
    }

// Prodotti/Sostanze
    String BuildProdottiSostanzeTab(IAppProdottiSostanzeHome home, long lCOD_SRV) {
        java.util.Collection col = home.findEx_ProdottiSostanzeApp(lCOD_SRV, 0, null, 0);
        StringBuilder jspOutputBuilder = new StringBuilder();
        jspOutputBuilder.append("<table border='0' align='left' width='755' id='AppProdottiSostanzeHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>")
                .append("<tr>")
                .append("<td width='755'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td>")
                .append("</table>")
                .append("<table border='0' align='left' width='755' id='AppProdottiSostanze' class='dataTable' cellpadding='0' cellspacing='0'>")
                .append("<tr style='display:none' ID='' INDEX='" + lCOD_SRV + "'>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='DES' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("</tr>");

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            ProdottiSostanzeApp_View obj = (ProdottiSostanzeApp_View) it.next();
            jspOutputBuilder.append("<tr INDEX='" + lCOD_SRV + "' ID='" + obj.COD_PRO_SOS + "'>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 755px;' class='inputstyle'  value=\"" + Formatter.format(obj.DES) + "\">")
                    .append("</td>")
                    .append("</tr>");
        }
        jspOutputBuilder.append("</table>");
        return jspOutputBuilder.toString();
    }

// Analisi dei rischi
    String BuildAnalisiDeiRischiTab(IAppAnalisiRischiHome home, long lCOD_SRV) {
        java.util.Collection col = home.findEx_AnalisiRischiApp(lCOD_SRV);
        StringBuilder jspOutputBuilder = new StringBuilder();
        jspOutputBuilder.append("<table border='0' align='left' width='755' id='AppAnalisiRischiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>")
                .append("<tr>")
                .append("<td width='253'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Fase.di.lavoro") + "</strong></td>")
                .append("<td width='251'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Modalità.operative") + "</strong></td>")
                .append("<td width='251'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Rischi") + "</strong></td>")
                .append("</table>")
                .append("<table border='0' align='left' width='755' id='AppAnalisiRischi' class='dataTable' cellpadding='0' cellspacing='0'>")
                .append("<tr style='display:none' ID='' INDEX='" + lCOD_SRV + "'>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='FAS_LAV' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='MOD_OPE' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='RIS' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("</tr>");

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            AnalisiRischiApp_View obj = (AnalisiRischiApp_View) it.next();
            jspOutputBuilder.append("<tr INDEX='" + lCOD_SRV + "' ID='" + obj.COD_RSO + "'>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 253px;' class='inputstyle'  value=\"" + Formatter.format(obj.FAS_LAV) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 251px;' class='inputstyle'  value=\"" + Formatter.format(obj.MOD_OPE) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 251px;' class='inputstyle'  value=\"" + Formatter.format(obj.RIS) + "\">")
                    .append("</td>")
                    .append("</tr>");
        }
        jspOutputBuilder.append("</table>");
        return jspOutputBuilder.toString();
    }
%>
