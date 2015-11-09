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
     <version number="1.0" date="13/02/2004" author="Kushkarov Yuriy">		
     <comments>
     <comment date="13/02/2004" author="Kushkarov Yuriy">
     RischioFattore
     </comment>		
     </comments> 
     </version>
     </versions>
     </file> 
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.MisurePreventive.*" %>
<%@ page import="com.apconsulting.luna.ejb.InterventoAudut.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script>
    var err = false;
</script>
<div id="dContent">

    <% long lCOD_AZL = Security.getAzienda();
        long lCOD_MIS_PET = 0;
        String s;
        String q;
        String w;
        String e;
        IMisurePreventive bean = null;
        String strID = (String) request.getParameter("ID_PARENT");
        try {
            IMisurePreventiveHome home = (IMisurePreventiveHome) PseudoContext.lookup("MisurePreventiveBean");
            bean = home.findByPrimaryKey(new Long(strID));
            lCOD_MIS_PET = bean.getCOD_MIS_PET();
            out.print(lCOD_MIS_PET);

        } catch (Exception ex) {
            out.print(printErrAlert("divErr", "Error.showNotFound", ex));
            return;
        }
        out.print(strID);
        try {
            if (bean != null) {
                String strCOD_MIS_PET = new Long(lCOD_MIS_PET).toString();
                if (request.getParameter("TAB_NAME").equals("tab1")) {
                    IInterventoAudutHome nr_home = (IInterventoAudutHome) PseudoContext.lookup("InterventoAudutBean");
                    s = BuildInterventiAuditTab(nr_home, lCOD_AZL, strID);
                    out.println(s);
                } else {
                    if (request.getParameter("TAB_NAME").equals("tab2")) {
                        IMisurePreventiveHome d_home = (IMisurePreventiveHome) PseudoContext.lookup("MisurePreventiveBean");
                        q = BuildDocumentiTab(d_home, strCOD_MIS_PET, strID);
                        out.print(q);
                    } else {
                        if (request.getParameter("TAB_NAME").equals("tab3")) {
                            IMisurePreventiveHome ns_home = (IMisurePreventiveHome) PseudoContext.lookup("MisurePreventiveBean");
                            w = BuildNormativeSentenzeTab(ns_home, strCOD_MIS_PET, strID);
                            out.println(w);
                        } else {
                            if (request.getParameter("TAB_NAME").equals("tab4")) {
                                IMisurePreventiveHome as_home = (IMisurePreventiveHome) PseudoContext.lookup("MisurePreventiveBean");
                                e = BuildAttivitaSegnalazioneTab(as_home, strCOD_MIS_PET, strID);
                                out.println(e);
                            } else {
                                return;
                            }
                        }
                    }
                }
            }
        } catch (Exception ex) {
            out.print(printErrAlert("divErr", "Error.alert", ex));
            return;
        }
    %>
</div>	
<script>
    if (!err) {
        parent.tabbar.ReloadTabTable(document);
    }
</script>

<%!//---------------FUNCTIONS FOR TABS-------------------------
    String BuildDocumentiTab(IMisurePreventiveHome home, String COD_MIS_PET, String strID) {
        String str;
        java.util.Collection col_d = home.getMisurePreventive_ForDOC_TAB_View(new Long(COD_MIS_PET).longValue());
        str = "<table border='0' align='left' width='752' id='DocumentiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr><td width='376'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo") + "</strong></td>";
        str += "<td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>";
        str += "<td width='176'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td></tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='752' id='Documenti' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(strID) + "'><td width='376' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
        str += "<td width='200' class='dataTd'><input type='text' name='RSP_DOC' readonly class='dataInput'  value=''></td>";
        str += "<td width='176' class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='dataInput'  value=''></td></tr>";
        if (!COD_MIS_PET.equals("")) {
            java.util.Iterator it_d = col_d.iterator();
            while (it_d.hasNext()) {
                MisurePreventive_ForDOC_TAB_View d = (MisurePreventive_ForDOC_TAB_View) it_d.next();
                str += "<tr INDEX='" + Formatter.format(strID) + "' ID='" + d.COD_DOC + "'>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 376px;' class='inputstyle'  value=\"" + Formatter.format(d.TIT_DOC) + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value=\"" + Formatter.format(d.RSP_DOC) + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 176px;' class='inputstyle'  value=\"" + Formatter.format(d.DAT_REV_DOC) + "\"></td>";
                str += "</tr>";
            }
        }
        str += "</table>";
        return str;
    }

    String BuildNormativeSentenzeTab(IMisurePreventiveHome home, String COD_MIS_PET, String strID) {
        String str;
        java.util.Collection col_ns = home.getMisurePreventive_ForNORSEN_TAB_View(new Long(COD_MIS_PET).longValue());

        str = "<table border='0' align='left' width='752' id='NormativeSentenzeHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr><td width='552'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.normativa/sentenza") + "</strong></td>";
        str += "<td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.normativa") + "</strong></td></tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='752' id='NormativeSentenze' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(strID) + "'><td width='552' class='dataTd'><input type='text' name='TIT_NOR_SEN' class='dataInput' readonly  value=''></td>";
        str += "<td width='200' class='dataTd'><input type='text' name='DAT_NOR_SEN' readonly class='dataInput'  value=''></td></tr>";
        if (!COD_MIS_PET.equals("")) {
            java.util.Iterator it_ns = col_ns.iterator();
            while (it_ns.hasNext()) {
                MisurePreventive_ForNORSEN_TAB_View ns = (MisurePreventive_ForNORSEN_TAB_View) it_ns.next();
                str += "<tr INDEX='" + Formatter.format(strID) + "' ID='" + ns.COD_NOR_SEN + "'>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 552px;' class='dataInput'  value=\"" + Formatter.format(ns.TIT_NOR_SEN) + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 200px;' class='dataInput'  value=\"" + Formatter.format(ns.DAT_NOR_SEN) + "\"></td>";
                str += "</tr>";
            }
        }
        str += "</table>";
        return str;
    }

    String BuildAttivitaSegnalazioneTab(IMisurePreventiveHome home, String COD_MIS_PET, String strID) {
        String str;
        java.util.Collection col_as = home.getMisurePreventive_ForATI_EGZ_TAB_View(new Long(COD_MIS_PET).longValue());
        str = "<table border='0' align='left' width='752' id='AttivitaSegnalazioneHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr><td width='552'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Attività.segnalazione") + "</strong></td>";
        str += "<td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.attività") + "</strong></td>";
        str += "</tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='752' id='AttivitaSegnalazione' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(strID) + "'><td width='552' class='dataTd'><input type='text' name='DES_ATI_SGZ' class='dataInput' readonly  value=''></td>";
        str += "<td width='200' class='dataTd'><input type='text' name='DAT_SCA' readonly class='dataInput'  value=''></td>";
        str += "</tr>";
        if (!COD_MIS_PET.equals("")) {
            java.util.Iterator it_as = col_as.iterator();
            while (it_as.hasNext()) {
                MisurePreventive_ForATI_EGZ_TAB_View as = (MisurePreventive_ForATI_EGZ_TAB_View) it_as.next();
                str += "<tr INDEX='" + Formatter.format(strID) + "' ID='" + as.COD_ATI_SGZ + "'>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 552px;' class='dataInput'  value=\"" + Formatter.format(as.DES_ATI_SGZ) + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 200px;' class='dataInput'  value=\"" + Formatter.format(as.DAT_SCA) + "\"></td>";
                str += "</tr>";
            }
        }
        str += "</table>";
        return str;
    }

    String BuildInterventiAuditTab(IInterventoAudutHome home, long AZL_ID, String strID) {
        String str;
        long lID = new Long(strID).longValue();
        java.util.Collection col_au = home.getInterventoAuditFORLUOView(AZL_ID, lID);
        str = "<table border='0' align='left' width='752' id='InterventiAuditHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr><td width='752'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Intervento.di.audit") + "</strong></td>";
        str += "</tr>";
        str += "</table>";
        str += "<table border='1' align='left' width='752' id='InterventiAudit' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(strID) + "'><td width='752' class='dataTd'><input type='text' name='DES_INR_ADT' class='dataInput' readonly  value=''></td>";
        str += "</tr>";
        if (!strID.equals("")) {
            java.util.Iterator it_au = col_au.iterator();
            while (it_au.hasNext()) {
                InterventoAuditFORLUOView au = (InterventoAuditFORLUOView) it_au.next();
                str += "<tr INDEX='" + Formatter.format(strID) + "' ID='" + au.lCOD_INR_ADT + "'>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 752px;' class='dataInput'  value=\"" + Formatter.format(au.strDES_INR_ADT) + "\"></td>";
                str += "</tr>";
            }
        }
        str += "</table>";
        return str;
    }
%>
