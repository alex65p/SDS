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
    <description>ANA_ATI_SGZ_Tabs.jsp-functions for ANA_ATI_SGZ_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.AttivitaSegnalazione.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<script>
    var err=false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<div id="dContent">
    <%long lCOD_ATI_SGZ = new Long(request.getParameter("ID_PARENT")).longValue();

        try {
            if (request.getParameter("TAB_NAME").equals("tab1")) {
                IAttivitaSegnalazioneHome sgz_home = (IAttivitaSegnalazioneHome) PseudoContext.lookup("AttivitaSegnalazioneBean");
                out.println(BuildDocumenti(sgz_home, lCOD_ATI_SGZ));
            } else if (request.getParameter("TAB_NAME").equals("tab2")) {
                IAttivitaSegnalazioneHome sgz_home = (IAttivitaSegnalazioneHome) PseudoContext.lookup("AttivitaSegnalazioneBean");
                out.println(BuildMisure(sgz_home, lCOD_ATI_SGZ));
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
    String BuildDocumenti(IAttivitaSegnalazioneHome home, long COD_ATI_SGZ) {
        String str;
        java.util.Collection col_rst = home.getAnagraficaDocumenti_List_ID_View(COD_ATI_SGZ);

        str = "<table border='0' align='left' width='725' id='AttivitaSegnalazioneHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr><td width='300'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile.documento") + "</strong></td>";
        str += "<td width='125'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td>";
        str += "<td width='300'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong></td></tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='725' id='AttivitaSegnalazione' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(COD_ATI_SGZ) + "'>";
        str += "<td width='300' class='dataTd'><input type='text' name='RSP_DOC' class='dataInput' readonly  value=''></td>";
        str += "<td width='125' class='dataTd'><input type='text' name='DAT_REV' class='dataInput' readonly  value=''></td>";
        str += "<td width='300' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td></tr>";
        if (COD_ATI_SGZ != 0) {
            java.util.Iterator it_rst = col_rst.iterator();
            while (it_rst.hasNext()) {
                AnagraficaDocumenti_List_ID_View rst = (AnagraficaDocumenti_List_ID_View) it_rst.next();
                str += "<tr INDEX='" + Formatter.format(COD_ATI_SGZ) + "' ID='" + rst.COD_DOC + "'>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 300px;' class='inputstyle'  value=\"" + Formatter.format(rst.RSP_DOC) + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 125px;' class='inputstyle'  value=\"" + Formatter.format(rst.DAT_REV_DOC) + "'\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 300px;' class='inputstyle'  value=\"" + Formatter.format(rst.TIT_DOC) + "\"></td>";
                str += "</tr>";
            }
        }
        str += "</table>";
        return str;
    }
    
    String BuildMisure(IAttivitaSegnalazioneHome home, long COD_ATI_SGZ) {
        String str;
        java.util.Collection col_rst = home.getMisure_View(COD_ATI_SGZ);

        str = "<table border='0' align='left' width='725' id='MisureHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr><td width='360'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td>";
        str += "<td width='365'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td></tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='725' id='Misure' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(COD_ATI_SGZ) + "'>";
        str += "<td width='360' class='dataTd'><input type='text' name='RSP_DOC' class='dataInput' readonly  value=''></td>";
        str += "<td width='365' class='dataTd'><input type='text' name='DAT_REV' class='dataInput' readonly  value=''></td></tr>";
        if (COD_ATI_SGZ != 0) {
            java.util.Iterator it_rst = col_rst.iterator();
            while (it_rst.hasNext()) {
                Misure_View misura = (Misure_View) it_rst.next();
                str += "<tr INDEX='" + Formatter.format(COD_ATI_SGZ) + "' ID='" + misura.lCOD_MIS_PET + "'>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 360px;' class='inputstyle'  value=\"" + Formatter.format(misura.strNOM_MIS_PET) + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 365px;' class='inputstyle'  value=\"" + Formatter.format(misura.strDES_MIS_PET) + "'\"></td>";
                str += "</tr>";
            }
        }
        str += "</table>";
        return str;
    }
%>
