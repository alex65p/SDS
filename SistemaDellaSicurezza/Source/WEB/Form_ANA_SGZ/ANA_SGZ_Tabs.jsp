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
    <version number="1.0" date="30/01/2004" author="Alexey Kolesnik">
    <comments>
    <comment date="30/01/2004" author="Alexey Kolesnik">
    <description>ANA_SGZ_Tabs.jsp-functions for ANA_ATI_SGZ_Form.jsp</description>
    </comment>
    <comment date="30/01/2004" author="Podmasteriev Alexandr">
    <description>Perebrosil funki is Util faila dla dinamic tabov</description>
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
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.RapportiniSegnalazione.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script>
    var err=false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<div id="dContent">
    <%
        long lCOD_SGZ = new Long(request.getParameter("ID_PARENT")).longValue();
        try {
            if (request.getParameter("TAB_NAME").equals("tab1")) {
                IRapportiniSegnalazioneHome sgz_home = (IRapportiniSegnalazioneHome) PseudoContext.lookup("RapportiniSegnalazioneBean");
                out.println(BuildAttivitaSegnalazioneTab(sgz_home, lCOD_SGZ));
            } else if (request.getParameter("TAB_NAME").equals("tab2")) {
                IRapportiniSegnalazioneHome sgz_home = (IRapportiniSegnalazioneHome) PseudoContext.lookup("RapportiniSegnalazioneBean");
                out.println(BuildRischiTab(sgz_home, lCOD_SGZ, Security.getAzienda()));
            } else {
                return;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            out.print(printErrAlert("divErr", "Error.alert", ex));
            return;
        }
    %>
</div>
<script>
    if (!err){
        parent.tabbar.ReloadTabTable(document);
    }
</script>
<%!//---------------FUNCTIONS FOR TABS-------------------------
    String BuildAttivitaSegnalazioneTab(IRapportiniSegnalazioneHome home, long COD_SGZ) {
        String str;
        java.util.Collection col_rst = home.getRapportiniSegnalazione_List_ID_View(COD_SGZ);

        str = "<table border='0' align='left' width='760' id='RapportiniSegnalazioneHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr><td width='600'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione.attività") + "</strong></td>";
        str += "<td width='164'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.scadenza") + "</strong></td></tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='760' id='RapportiniSegnalazione' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(COD_SGZ) + "'>";
        str += "<td width='600' class='dataTd'><input type='text' name='COD_SGZ' class='dataInput' readonly  value=''></td>";
        str += "<td width='160' class='dataTd'><input type='text' name='DAT_SCA' class='dataInput' readonly  value=''></td></tr>";
        if (COD_SGZ != 0) {
            java.util.Iterator it_rst = col_rst.iterator();
            while (it_rst.hasNext()) {
                RapportiniSegnalazione_List_ID_View rst = (RapportiniSegnalazione_List_ID_View) it_rst.next();
                str += "<tr INDEX='" + Formatter.format(COD_SGZ) + "' ID='" + rst.COD_ATI_SGZ + "'>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 600px;' class='inputstyle'  value=\"" + Formatter.format(rst.DES_ATI_SGZ) + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 160px;' class='inputstyle'  value=\"" + Formatter.format(rst.DAT_SCA) + "\"></td>";
                str += "</tr>";
            }
        }
        str += "</table>";
        return str;
    }

    String BuildRischiTab(IRapportiniSegnalazioneHome home, long COD_SGZ, long COD_AZL) {
        String str;
        java.util.Collection col_rso = home.getRischi_View(COD_SGZ, COD_AZL);

        str = "<table border='0' align='left' width='760' id='RischiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
        str += "<td width='380'><strong>&nbsp;"
                + ApplicationConfigurator.LanguageManager.getString("Nominativo.rischio")
                + "</strong></td>";
        str += "<td width='380'><strong>&nbsp;"
                + ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio")
                + "</strong></td>";
        str += "</tr></table>";
        str += "<table border='0' align='left' width='760' id='Rischi' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(COD_SGZ) + "'>";
        str += "<td width='380' class='dataTd'><input type='text' name='NOM_RSO' class='dataInput' readonly  value=''></td>";
        str += "<td width='380' class='dataTd'><input type='text' name='NOM_FAT_RSO' class='dataInput' readonly  value=''></td></tr>";
        if (COD_SGZ != 0) {
            java.util.Iterator it = col_rso.iterator();
            while (it.hasNext()) {
                Rischi_View rc = (Rischi_View) it.next();
                str += "<tr INDEX='" + Formatter.format(COD_SGZ) + "' ID='" + rc.COD_RSO + "'>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 380px;' class='inputstyle'  value=\"" + Formatter.format(rc.NOM_RSO) + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 380px;' class='inputstyle'  value=\"" + Formatter.format(rc.NOM_FAT_RSO) + "\"></td>";
                str += "</tr>";
            }
        }
        str += "</table>";
        return str;
    }
%>
