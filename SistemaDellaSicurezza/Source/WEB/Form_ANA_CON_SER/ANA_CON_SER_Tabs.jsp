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
        <version number="1.0" date="28/04/2008" author="Dario Massaroni">
            <comments>
                <comment date="28/04/2008" author="Dario Massaroni">
                    <description>Create ANA_CON_SER_Tabs.jsp</description>
                </comment>
            </comments>
        </version>
    </versions>
</file> 
*/
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache");        //HTTP 1.0
            response.setDateHeader("Expires", 0);            //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServLuoghiEsecuzione.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServSubApp.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServCentriEmergenza.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServServiziSanitari.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServFluidi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/ContServPrestitoMateriali/ContServPrestitoMaterialiBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ContServPrestitoMateriali/ContServPrestitoMaterialiBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/ContServIspezioni/ContServIspezioniBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ContServIspezioni/ContServIspezioniBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/ContServRischiInterferenza/ContServRischiInterferenzaBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ContServRischiInterferenza/ContServRischiInterferenzaBean.jsp"%>

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
            long lCOD_SRV = c.checkLong("Contratto/Servizio", request.getParameter("ID_PARENT"), true);

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
                    // Luoghi di esecuzione
                    if (request.getParameter("TAB_NAME").equals("tab1")) {
                        IContServLuoghiEsecuzioneHome luo_ese_home = (IContServLuoghiEsecuzioneHome) PseudoContext.lookup("ContServLuoghiEsecuzioneBean");
                        out.println(BuildLuoghiEsecuzioneTab(luo_ese_home, lCOD_SRV));
                    } // Dettaglio subappaltatrici
                    else if (request.getParameter("TAB_NAME").equals("tab2")) {
                        IContServSubAppHome sub_app_home = (IContServSubAppHome) PseudoContext.lookup("ContServSubAppBean");
                        out.println(BuildDettaglioSubAppaltTab(sub_app_home, lCOD_SRV));
                    } // Rischi interferenza
                    else if (request.getParameter("TAB_NAME").equals("tab3")) {
                        IContServRischiInterferenzaHome ris_int_home = (IContServRischiInterferenzaHome) PseudoContext.lookup("ContServRischiInterferenzaBean");
                        out.println(BuildRischiInterfTab(ris_int_home, lCOD_SRV));
                    } else if (request.getParameter("TAB_NAME").equals("tab4")) {
                        IContServCentriEmergenzaHome cen_eme_home = (IContServCentriEmergenzaHome) PseudoContext.lookup("ContServCentriEmergenzaBean");
                        out.println(BuildCentriEmergenzaTab(cen_eme_home, lCOD_SRV));
                    } else if (request.getParameter("TAB_NAME").equals("tab5")) {
                        IContServServiziSanitariHome ser_san_home = (IContServServiziSanitariHome) PseudoContext.lookup("ContServServiziSanitariBean");
                        out.println(BuildServiziSanitariTab(ser_san_home, lCOD_SRV));
                    } else if (request.getParameter("TAB_NAME").equals("tab6")) {
                        IContServFluidiHome fluidi_home = (IContServFluidiHome) PseudoContext.lookup("ContServFluidiBean");
                        out.println(BuildFluidiTab(fluidi_home, lCOD_SRV));
                    } else if (request.getParameter("TAB_NAME").equals("tab7")) {
                        IContServPrestitoMaterialiHome pre_mat_home = (IContServPrestitoMaterialiHome) PseudoContext.lookup("ContServPrestitoMaterialiBean");
                        out.println(BuildPrestitoMaterialiTab(pre_mat_home, lCOD_SRV));
                    } else if (request.getParameter("TAB_NAME").equals("tab8")) {
                        IContServIspezioniHome ispezioni_home = (IContServIspezioniHome) PseudoContext.lookup("ContServIspezioniBean");
                        out.println(BuildIspezioniTab(ispezioni_home, lCOD_SRV));
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
// Luoghi di esecuzione
    String BuildLuoghiEsecuzioneTab(IContServLuoghiEsecuzioneHome home, long lCOD_SRV) {
        //String str;
        java.util.Collection col = home.getContServLuoghiEsecuzione_View(lCOD_SRV);

        StringBuilder jspOutputBuilder = new StringBuilder();
        jspOutputBuilder.append("<table border='0' align='left' width='724' id='ContServLuoghiEsecuzioneHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>")
                        .append("<tr>")
                        .append("<td width='362'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Luogo.fisico") + "</strong></td>")
                        .append("<td width='362'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Servizio") + "</strong></td>")
                        .append("</tr>")
                        .append("</table>")
                        .append("<table border='0' align='left' width='724' id='ContServLuoghiEsecuzione' class='dataTable' cellpadding='0' cellspacing='0'>")
                        .append("<tr style='display:none' ID='' INDEX='" + lCOD_SRV + "'>")
                        .append("<td class='dataTd'>")
                        .append("<input type='text' name='COD_LUO_FSC' class='dataInput' readonly  value=''>")
                        .append("</td>")
                        .append("<td class='dataTd'>")
                        .append("<input type='text' name='DES_SER' class='dataInput' readonly  value=''>")
                        .append("</td>")
                        .append("</tr>");

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            ContServLuoghiEsecuzione_View obj = (ContServLuoghiEsecuzione_View) it.next();
            jspOutputBuilder.append("<tr INDEX='" + lCOD_SRV + "' ID='" + obj.COD_LUO_FSC + "'>")
                            .append("<td class='dataTd'>")
                            .append("<input type='text' readonly style='width: 362px;' class='inputstyle'  value=\"" + Formatter.format(obj.NOM_LUO_FSC) + "\">")
                            .append("</td>")
                            .append("<td class='dataTd'>")
                            .append("<input type='text' readonly style='width: 362px;' class='inputstyle'  value=\"" + Formatter.format(obj.DES_SER) + "\">")
                            .append("</td>")
                            .append("</tr>");
        }
        jspOutputBuilder.append("</table>");
        return jspOutputBuilder.toString();
    }

// Dettaglio subappaltatrici
    String BuildDettaglioSubAppaltTab(IContServSubAppHome home, long lCOD_SRV) {
        String str;
        java.util.Collection col = home.findEx_SubApp(Security.getAzienda(), lCOD_SRV, 0, null, 0);

        StringBuilder jspOutputBuilder = new StringBuilder();
        jspOutputBuilder.append("<table border='0' align='left' width='724' id='ContrattoServizioDittaSubAppHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>")
                        .append("<tr>")
                        .append("<td width='222'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Ragione.sociale") + "</strong></td>")
                        .append("<td width='222'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Intervento.assegnato") + "</strong></td>")
                        .append("<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.inizio.lavori") + "</strong></td>")
                        .append("<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.fine.lavori") + "</strong></td>")
                        .append("</tr>")
                        .append("</table>")
                        .append("<table border='0' align='left' width='724' id='ContrattoServizioDittaSubApp' class='dataTable' cellpadding='0' cellspacing='0'>")
                        .append("<tr style='display:none' ID='' INDEX='" + lCOD_SRV + "'>")
                        .append("<td class='dataTd'>")
                        .append("<input type='text' name='COD_DTE' class='dataInput' readonly  value=''>")
                        .append("</td>")
                        .append("<td class='dataTd'>")
                        .append("<input type='text' name='INT_ASS_DES' class='dataInput' readonly  value=''>")
                        .append("</td>")
                        .append("<td class='dataTd'>")
                        .append("<input type='text' name='DAT_INI_LAV' class='dataInput' readonly  value=''>")
                        .append("</td>")
                        .append("<td class='dataTd'>")
                        .append("<input type='text' name='DAT_FIN_LAV' class='dataInput' readonly  value=''>")
                        .append("</td>")
                        .append("</tr>");

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            SubApp_View obj = (SubApp_View) it.next();
            jspOutputBuilder.append("<tr INDEX='" + lCOD_SRV + "' ID='" + obj.COD_SUB_APP + "'>")
                            .append("<td class='dataTd'>")
                            .append("<input type='text' readonly style='width: 222px;' class='inputstyle'  value=\"" + Formatter.format(obj.RAG_SCL_DTE) + "\">")
                            .append("</td>")
                            .append("<td class='dataTd'>")
                            .append("<input type='text' readonly style='width: 222px;' class='inputstyle'  value=\"" + Formatter.format(obj.INT_ASS_DES) + "\">")
                            .append("</td>")
                            .append("<td class='dataTd'>")
                            .append("<input type='text' readonly style='width: 140px;' class='inputstyle'  value=\"" + Formatter.format(obj.DAT_INI_LAV) + "\">")
                            .append("</td>")
                            .append("<td class='dataTd'>")
                            .append("<input type='text' readonly style='width: 140px;' class='inputstyle'  value=\"" + Formatter.format(obj.DAT_FIN_LAV) + "\">")
                            .append("</td>")
                            .append("</tr>");
        }
        jspOutputBuilder.append("</table>");
        return jspOutputBuilder.toString();
    }

// Rischi interferenza
    String BuildRischiInterfTab(IContServRischiInterferenzaHome home, long lCOD_SRV) {
        String str;
        java.util.Collection col = home.getContServRischiInterferenza_View(lCOD_SRV);

        StringBuilder jspOutputBuilder = new StringBuilder();
        jspOutputBuilder
                .append("<table border='0' align='left' width='724' id='ContServRischiInterferenzaHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>")
                .append("<tr>")
                .append("<td width='242'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Fase.di.lavoro") + "</strong></td>")
                .append("<td width='241'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Tipo.di.interferenza") + "</strong></td>")
                .append("<td width='241'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Rischio") + "</strong></td>")
                .append("</tr>")
                .append("</table>")
                .append("<table border='0' align='left' width='724' id='ContServRischiInterferenza' class='dataTable' cellpadding='0' cellspacing='0'>")
                .append("<tr style='display:none' ID='' INDEX='" + lCOD_SRV + "'>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='FAS_LAV' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='TIP_INT' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='RIS' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("</tr>");

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            ContServRischiInterferenza_View obj = (ContServRischiInterferenza_View) it.next();
            jspOutputBuilder
                    .append("<tr INDEX='" + lCOD_SRV + "' ID='" + obj.COD_RIS_INT + "'>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 242px;' class='inputstyle'  value=\"" + Formatter.format(obj.FAS_LAV) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 241px;' class='inputstyle'  value=\"" + Formatter.format(obj.TIP_INT) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 241px;' class='inputstyle'  value=\"" + Formatter.format(obj.RIS) + "\">")
                    .append("</td>")
                    .append("</tr>");
        }
        jspOutputBuilder.append("</table>");
        return jspOutputBuilder.toString();
    }

    String BuildCentriEmergenzaTab(IContServCentriEmergenzaHome home, long lCOD_SRV) {
        java.util.Collection col = home.findEx_CentriEmergenza(lCOD_SRV, 0, null, null, 0);
        StringBuilder jspOutputBuilder = new StringBuilder();
        jspOutputBuilder.append("<table border='0' align='left' width='724' id='ContServCentriEmergenzaHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>")
                .append("<tr>")
                .append("<td width='362'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td>")
                .append("<td width='362'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Riferimento") + "</strong></td>")
                .append("</table>")
                .append("<table border='0' align='left' width='724' id='ContServCentriEmergenza' class='dataTable' cellpadding='0' cellspacing='0'>")
                .append("<tr style='display:none' ID='' INDEX='" + lCOD_SRV + "'>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='DES' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='RIF' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("</tr>");

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            CentriEmergenza_View obj = (CentriEmergenza_View) it.next();
            jspOutputBuilder.append("<tr INDEX='" + lCOD_SRV + "' ID='" + obj.COD_CEN_EME + "'>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 362px;' class='inputstyle'  value=\"" + Formatter.format(obj.DES) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 362px;' class='inputstyle'  value=\"" + Formatter.format(obj.RIF) + "\">")
                    .append("</td>")
                    .append("</tr>");
        }
        jspOutputBuilder.append("</table>");
        return jspOutputBuilder.toString();
    }

    String BuildServiziSanitariTab(IContServServiziSanitariHome home, long lCOD_SRV) {
        java.util.Collection col = home.findEx_ServiziSanitari(lCOD_SRV, 0, null, null, null, null, 0);
        StringBuilder jspOutputBuilder = new StringBuilder();
        jspOutputBuilder.append("<table border='0' align='left' width='724' id='ContServServiziSanitariHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>")
                .append("<tr>")
                .append("<td width='324'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Designazione.servizi.vita") + "</strong></td>")
                .append("<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.inizio.impiego") + "</strong></td>")
                .append("<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.fine.impiego") + "</strong></td>")
                .append("<td width='120'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Orario.d'impiego") + "</strong></td>")
                .append("</tr>")
                .append("</table>")
                .append("<table border='0' align='left' width='724' id='ContServServiziSanitari' class='dataTable' cellpadding='0' cellspacing='0'>")
                .append("<tr style='display:none' ID='' INDEX='" + lCOD_SRV + "'>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='DES_SRV_VIT' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='DAT_INI_IMP' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='DAT_FIN_IMP' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='ORA_IMP' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("</tr>");

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            ServiziSanitari_View obj = (ServiziSanitari_View) it.next();
            jspOutputBuilder.append("<tr INDEX='" + lCOD_SRV + "' ID='" + obj.COD_SRV_SAN + "'>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 324px;' class='inputstyle'  value=\"" + Formatter.format(obj.DES_SRV_VIT) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 140px;' class='inputstyle'  value=\"" + Formatter.format(obj.DAT_INI_IMP) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 140px;' class='inputstyle'  value=\"" + Formatter.format(obj.DAT_FIN_IMP) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 120px;' class='inputstyle'  value=\"" + Formatter.format(obj.ORA_IMP) + "\">")
                    .append("</td>")
                    .append("</tr>");
        }
        jspOutputBuilder.append("</table>");
        return jspOutputBuilder.toString();
    }

    String BuildFluidiTab(IContServFluidiHome home, long lCOD_SRV) {
        java.util.Collection col = home.findEx_Fluidi(lCOD_SRV, 0, null, null, null, null, 0);
        StringBuilder jspOutputBuilder = new StringBuilder();
        jspOutputBuilder.append("<table border='0' align='left' width='724' id='ContServFluidiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>")
                .append("<tr>")
                .append("<td width='222'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Tipo.di.fluido") + "</strong></td>")
                .append("<td width='222'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Luogo.di.collegamento") + "</strong></td>")
                .append("<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.inizio.consegna") + "</strong></td>")
                .append("<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.fine.consegna") + "</strong></td>")
                .append("</tr>")
                .append("</table>")
                .append("<table border='0' align='left' width='724' id='ContServFluidi' class='dataTable' cellpadding='0' cellspacing='0'>")
                .append("<tr style='display:none' ID='' INDEX='" + lCOD_SRV + "'>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='TIP_FLU_DIS' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='LUO_COL' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='DAT_INI_CON' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='DAT_FIN_CON' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("</tr>");

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            Fluidi_View obj = (Fluidi_View) it.next();
            jspOutputBuilder.append("<tr INDEX='" + lCOD_SRV + "' ID='" + obj.COD_FLU + "'>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 222px;' class='inputstyle'  value=\"" + Formatter.format(obj.TIP_FLU_DIS) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 222px;' class='inputstyle'  value=\"" + Formatter.format(obj.LUO_COL) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 140px;' class='inputstyle'  value=\"" + Formatter.format(obj.DAT_INI_CON) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 140px;' class='inputstyle'  value=\"" + Formatter.format(obj.DAT_FIN_CON) + "\">")
                    .append("</td>")
                    .append("</tr>");
        }
        jspOutputBuilder.append("</table>");
        return jspOutputBuilder.toString();
    }

    String BuildPrestitoMaterialiTab(IContServPrestitoMaterialiHome home, long lCOD_SRV) {
        java.util.Collection col = home.findEx_PrestitoMateriali(lCOD_SRV, 0, null, null, null, null, 0);
        StringBuilder jspOutputBuilder = new StringBuilder();
        jspOutputBuilder.append("<table border='0' align='left' width='724' id='ContServPrestitoMaterialiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>")
                .append("<tr>")
                .append("<td width='222'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Tipo.di.materiale") + "</strong></td>")
                .append("<td width='222'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Luogo.di.messa.a.disposizione") + "</strong></td>")
                .append("<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.inizio.prestito") + "</strong></td>")
                .append("<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.fine.prestito") + "</strong></td>")
                .append("</tr>")
                .append("</table>")
                .append("<table border='0' align='left' width='724' id='ContServPrestitoMateriali' class='dataTable' cellpadding='0' cellspacing='0'>")
                .append("<tr style='display:none' ID='' INDEX='" + lCOD_SRV + "'>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='TIP_MAT' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='LUO_MES_DIS' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='DAT_INI_PRE' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='DAT_FIN_PRE' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("</tr>");

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            PrestitoMateriali_View obj = (PrestitoMateriali_View) it.next();
            jspOutputBuilder.append("<tr INDEX='" + lCOD_SRV + "' ID='" + obj.COD_PRE_MAT + "'>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 222px;' class='inputstyle'  value=\"" + Formatter.format(obj.TIP_MAT) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 222px;' class='inputstyle'  value=\"" + Formatter.format(obj.LUO_MES_DIS) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 140px;' class='inputstyle'  value=\"" + Formatter.format(obj.DAT_INI_PRE) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 140px;' class='inputstyle'  value=\"" + Formatter.format(obj.DAT_FIN_PRE) + "\">")
                    .append("</td>")
                    .append("</tr>");
        }
        jspOutputBuilder.append("</table>");
        return jspOutputBuilder.toString();
    }

    String BuildIspezioniTab(IContServIspezioniHome home, long lCOD_SRV) {
        java.util.Collection col = home.findEx_Ispezioni(lCOD_SRV);
        StringBuilder jspOutputBuilder = new StringBuilder();
        jspOutputBuilder
                .append("<table border='0' align='left' width='724' id='ContServIspezioniHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>")
                .append(    "<tr>")
                .append(        "<td width='724'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Documento") + "</strong></td>")
                .append(    "</tr>")
                .append("</table>")
                .append("<table border='0' align='left' width='724' id='ContServIspezioni' class='dataTable' cellpadding='0' cellspacing='0'>")
                .append(    "<tr style='display:none' ID='' INDEX='" + lCOD_SRV + "'>")
                .append(        "<td class='dataTd'>")
                .append(            "<input type='text' name='COD_ISP' class='dataInput' readonly  value=''>")
                .append(        "</td>")
                .append(    "</tr>");
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            Ispezioni_View obj = (Ispezioni_View) it.next();
            jspOutputBuilder
                .append(    "<tr INDEX='" + lCOD_SRV + "' ID='" + obj.COD_ISP + "'>")
                .append(        "<td class='dataTd' width='100%'>")
                .append(            "<input type='text' readonly style='width: 724px;' class='inputstyle'  value=\"" + Formatter.format(obj.FILE_NAME) + "\">")
                .append(        "</td>")
                .append(    "</tr>");
        }
        jspOutputBuilder
                .append("</table>");
        return jspOutputBuilder.toString();
    }
%>
