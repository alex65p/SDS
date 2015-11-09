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
    Document   : DET_CMT_Tabs
    Created on : 27-mag-2008, 10.40.45
    Author     : Giancarlo Servadei
--%>

<%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache");        //HTTP 1.0
            response.setDateHeader("Expires", 0);            //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/ContServReferentiLoco/ContServReferentiLocoBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ContServReferentiLoco/ContServReferentiLocoBean.jsp"%>

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
                    // Operazioni svolte per rischi generici
                    if (request.getParameter("TAB_NAME").equals("tab1")) {
                        out.println(BuildOperazioniSvoltePerRischiGenericiTab());
                    } // Luoghi fisici per rischi generici
                    else if (request.getParameter("TAB_NAME").equals("tab2")) {
                        out.println(BuildLuoghiFisiciPerRischiGenericiTab());
                    } // Macchine per rischi generici
                    else if (request.getParameter("TAB_NAME").equals("tab3")) {
                        out.println(BuildMacchinePerRischiGenericiTab());
                    } // Impianti/Prodotti per rischi generici
                    else if (request.getParameter("TAB_NAME").equals("tab4")) {
                        out.println(BuildImpiantiProdottiPerRischiGenericiTab());
                    } // Referenti in loco
                    else if (request.getParameter("TAB_NAME").equals("tab5")) {
                        IContServReferentiLocoHome ref_loc_home = (IContServReferentiLocoHome) PseudoContext.lookup("ContServReferentiLocoBean");
                        out.println(BuildReferentiLocoTab(ref_loc_home, lCOD_SRV));
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
// Operazioni svolte per rischi generici
    String BuildOperazioniSvoltePerRischiGenericiTab() {
        String str = "";
        //CODE
        return str;
    }
    
// Macchine per rischi generici
    String BuildMacchinePerRischiGenericiTab() {
        String str = "";
        //CODE
        return str;
    }
    
// Luoghi fisici per rischi generici
    String BuildLuoghiFisiciPerRischiGenericiTab() {
        String str = "";
        //CODE
        return str;
    }
    
// Impianti/Prodotti per rischi generici
    String BuildImpiantiProdottiPerRischiGenericiTab() {
        String str = "";
        //CODE
        return str;
    }

// Referenti in loco
    String BuildReferentiLocoTab(IContServReferentiLocoHome home, long lCOD_SRV) {
        java.util.Collection col = home.findEx_ReferentiLocoCmt(Security.getAzienda(), lCOD_SRV, 0L, null);
        StringBuilder jspOutputBuilder = new StringBuilder();
        jspOutputBuilder.append("<table border='0' align='left' width='680' id='ContServReferentiLocoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>")
                .append("<tr>")
                .append("<td width='275'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nominativo") + "</strong></td>")
                .append("<td width='265'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Qualifica") + "</strong></td>")
                .append("<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Telefono") + "</strong></td>")
                .append("</table>")
                .append("<table border='0' align='left' width='680' id='ContServReferentiLoco' class='dataTable' cellpadding='0' cellspacing='0'>")
                .append("<tr style='display:none' ID='' INDEX='" + lCOD_SRV + "'>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='COG_DPD' class='dataInput' readonly  value=''>")
                .append(" ")
                .append("<input type='text' name='NOM_DPD' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='NOM_FUZ_AZL' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("<td class='dataTd'>")
                .append("<input type='text' name='TEL' class='dataInput' readonly  value=''>")
                .append("</td>")
                .append("</tr>");

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            ComReferentiLoco_View obj = (ComReferentiLoco_View) it.next();
            jspOutputBuilder.append("<tr INDEX='" + lCOD_SRV + "' ID='" + obj.COD_DPD + "'>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 275px;' class='inputstyle'  value=\"" + Formatter.format(obj.COG_DPD))
                    .append(" ")
                    .append(Formatter.format(obj.NOM_DPD) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 265px;'class='inputstyle'  value=\"" + Formatter.format(obj.NOM_FUZ_AZL) + "\">")
                    .append("</td>")
                    .append("<td class='dataTd'>")
                    .append("<input type='text' readonly style='width: 140px;' class='inputstyle'  value=\"" + Formatter.format(obj.TEL) + "\">")
                    .append("</td>")
                    .append("</tr>");
        }
        jspOutputBuilder.append("</table>");
        return jspOutputBuilder.toString();
    }

%>
