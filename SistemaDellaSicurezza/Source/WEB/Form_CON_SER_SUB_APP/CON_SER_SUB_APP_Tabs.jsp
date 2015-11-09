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

<%
/*
<file>
    <versions>
        <version number="1.0" date="22/05/2008" author="Giancarlo Servadei">
            <comments>
                <comment date="22/05/2008" author="Giancarlo Servadei">
                    <description>Create CON_SER_SUB_APP_Tabs.jsp</description>
                </comment>
            </comments>
        </version>
    </versions>
</file> 
*/
%>
<%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache");        //HTTP 1.0
            response.setDateHeader("Expires", 0);            //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.SubAppAnalisiRischi.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServSubApp.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/SubAppPersonaleCoinvolto/SubAppPersonaleCoinvoltoBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/SubAppPersonaleCoinvolto/SubAppPersonaleCoinvoltoBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/SubAppProdottiSostanze/SubAppProdottiSostanzeBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/SubAppProdottiSostanze/SubAppProdottiSostanzeBean.jsp"%>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<html>
<body>
<script type="text/javascript" src="../_scripts/Alert.js"></script>
<script type="text/javascript">
    var err = false;
</script>
<div id="dContent">
    <%
            Checker c = new Checker();
            long lCOD_SUB_APP = c.checkLong(ApplicationConfigurator.LanguageManager.getString("ID.Subappaltatrice"), request.getParameter("ID_PARENT"), true);

            if (c.isError) {
                String err = c.printErrors();
    %><script>alert("<%=err%>");</script><%
                return;
            }

            IContServSubAppHome home = null;
            IContServSubApp bean = null;
            try {
                home = (IContServSubAppHome) PseudoContext.lookup("ContServSubAppBean");
                bean = home.findByPrimaryKey(lCOD_SUB_APP);
            } catch (Exception ex) {
                ex.printStackTrace();
                out.print(printErrAlert("divErr", "Error.showNotFound", ex));
                return;
            }
            try {
                if (bean != null) {
                    // Personale coinvolto
                    if (request.getParameter("TAB_NAME").equals("tab1")) {
                        ISubAppPersonaleCoinvoltoHome per_coi_home = (ISubAppPersonaleCoinvoltoHome) PseudoContext.lookup("SubAppPersonaleCoinvoltoBean");
                        out.println(BuildPersonaleCoinvoltoTab(per_coi_home, lCOD_SUB_APP));
                    } // Dettaglio subappaltatrici
                    else if (request.getParameter("TAB_NAME").equals("tab2")) {
                        ISubAppProdottiSostanzeHome pro_sos_home = (ISubAppProdottiSostanzeHome) PseudoContext.lookup("SubAppProdottiSostanzeBean");
                        out.println(BuildProdottiSostanzeTab(pro_sos_home, lCOD_SUB_APP));
                    } // Rischi interferenza
                    else if (request.getParameter("TAB_NAME").equals("tab3")) {
                        ISubAppAnalisiRischiHome ana_ris_home = (ISubAppAnalisiRischiHome) PseudoContext.lookup("SubAppAnalisiRischiBean");
                        out.println(BuildAnalisiDeiRischiTab(ana_ris_home, lCOD_SUB_APP));
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
// Personale coinvolto
    String BuildPersonaleCoinvoltoTab(ISubAppPersonaleCoinvoltoHome home, long lCOD_SUB_APP) {
        java.util.Collection col = home.findEx_PersonaleCoinvoltoSubApp(lCOD_SUB_APP, 0, null, null, 0);
        StringBuilder jspOutputBuilder = new StringBuilder();
        jspOutputBuilder.append("<table border='0' align='left' width='756' id='SubAppPersonaleCoinvoltoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>")
                .append("<tr>")
                .append("<td width='378'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td>")
                .append("<td width='378'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Qualifica") + "</strong></td>")
                .append("</table>")
                .append("<table border='0' align='left' width='756' id='SubAppPersonaleCoinvolto' class='dataTable' cellpadding='0' cellspacing='0'>")
                .append("<tr style='display:none' ID='' INDEX='" + lCOD_SUB_APP + "'>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='NOM' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='QUA' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("</tr>");

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            SubAppPersonaleCoinvolto_View obj = (SubAppPersonaleCoinvolto_View) it.next();
            jspOutputBuilder.append("<tr INDEX='" + lCOD_SUB_APP + "' ID='" + obj.COD_PER_COI + "'>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 378px;' class='inputstyle'  value=\"" + Formatter.format(obj.NOM) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 378px;' class='inputstyle'  value=\"" + Formatter.format(obj.QUA) + "\">")
                    .append("</td>")
                    .append("</tr>");
        }
        jspOutputBuilder.append("</table>");
        return jspOutputBuilder.toString();
    }

// Prodotti/Sostanze
    String BuildProdottiSostanzeTab(ISubAppProdottiSostanzeHome home, long lCOD_SUB_APP) {
        java.util.Collection col = home.findEx_ProdottiSostanzeSubApp(lCOD_SUB_APP, 0, null, 0);
        StringBuilder jspOutputBuilder = new StringBuilder();
        jspOutputBuilder.append("<table border='0' align='left' width='756' id='SubAppProdottiSostanzeHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>")
                .append("<tr>")
                .append("<td width='756'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td>")
                .append("</table>")
                .append("<table border='0' align='left' width='756' id='SubAppProdottiSostanze' class='dataTable' cellpadding='0' cellspacing='0'>")
                .append("<tr style='display:none' ID='' INDEX='" + lCOD_SUB_APP + "'>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='DES' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("</tr>");

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            ProdottiSostanzeSubApp_View obj = (ProdottiSostanzeSubApp_View) it.next();
            jspOutputBuilder.append("<tr INDEX='" + lCOD_SUB_APP + "' ID='" + obj.COD_PRO_SOS + "'>")
                    .append("<td class='dataTd' width='100%'>")
                    .append("<input type='text' readonly style='width: 756px;' class='inputstyle'  value=\"" + Formatter.format(obj.DES) + "\">")
                    .append("</td>")
                    .append("</tr>");
        }
        jspOutputBuilder.append("</table>");
        return jspOutputBuilder.toString();
    }

// Analisi dei rischi
    String BuildAnalisiDeiRischiTab(ISubAppAnalisiRischiHome home, long lCOD_SUB_APP) {
        java.util.Collection col = home.findEx_AnalisiRischiSubApp(lCOD_SUB_APP);
        StringBuilder jspOutputBuilder = new StringBuilder();
        jspOutputBuilder.append("<table border='0' align='left' width='756' id='SubAppAnalisiRischiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>")
                .append("<tr>")
                .append("<td width='252'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Fase.di.lavoro") + "</strong></td>")
                .append("<td width='252'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Modalità.operative") + "</strong></td>")
                .append("<td width='252'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Rischio") + "</strong></td>")
                .append("</table>")
                .append("<table border='0' align='left' width='756' id='SubAppAnalisiRischi' class='dataTable' cellpadding='0' cellspacing='0'>")
                .append("<tr style='display:none' ID='' INDEX='" + lCOD_SUB_APP + "'>")
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
            AnalisiRischiSubApp_View obj = (AnalisiRischiSubApp_View) it.next();
            jspOutputBuilder.append("<tr INDEX='" + lCOD_SUB_APP + "' ID='" + obj.COD_RSO + "'>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 252px;' class='inputstyle'  value=\"" + Formatter.format(obj.FAS_LAV) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 252px;' class='inputstyle'  value=\"" + Formatter.format(obj.MOD_OPE) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 252px;' class='inputstyle'  value=\"" + Formatter.format(obj.RIS) + "\">")
                    .append("</td>")
                    .append("</tr>");
        }
        jspOutputBuilder.append("</table>");
        return jspOutputBuilder.toString();
    }
%>
