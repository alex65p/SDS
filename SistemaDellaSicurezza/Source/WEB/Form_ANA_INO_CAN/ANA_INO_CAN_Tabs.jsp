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
            <version number="1.0" date="28/02/2004" author="Mike Kondratyuk">
            <comments>
            <comment date="28/02/2004" author="Mike Kondratyuk">
            <description>Create ANA_INO_Tabs.jsp</description>
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */
%>
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>
<%@ page import="com.apconsulting.luna.ejb.InfortuniIncidenti.*" %>
<%@ page import="com.apconsulting.luna.ejb.Testimone.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script type="text/javascript">
    var err=false;
</script>
<script type="text/javascript" src="../_scripts/Alert.js"></script>
<div id="dContent">
    <%
                long lCOD_INO = new Long(request.getParameter("ID_PARENT")).longValue();
                long lCOD_AZL = Security.getAzienda();

                try {
                    if (request.getParameter("TAB_NAME").equals("tab1")) {
                        ITestimoneHome home = (ITestimoneHome) PseudoContext.lookup("TestimoneBean");
                        out.println(BuildTestimoneTab(home, lCOD_INO));
                    } else if (request.getParameter("TAB_NAME").equals("tab6")) {
                        IInfortuniIncidentiHome home = (IInfortuniIncidentiHome) PseudoContext.lookup("InfortuniIncidentiBean");
                        out.print(BuildDocumentiTab(home, lCOD_INO, lCOD_AZL));
                    } else {
                        return;
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                    return;
                }
    %>
</div>
<script type="text/javascript">
    if (!err){
        parent.tabbar.ReloadTabTable(document);
    }
</script>
<%!    String BuildTestimoneTab(ITestimoneHome home, long lCOD_INO) {
        String str;
        java.util.Collection col = home.getTestimone_View(lCOD_INO);

        str = "<table border='0' align='left' width='960' id='TestimoneHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr>";
        str += "<td width='300'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.testimone") + "</strong></td>";
        str += "<td width='500'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Testimonianza") + "</strong></td>";
        str += "<td width='160'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Contatto.testimone") + "</strong></td>";
        str += "</tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='960' id='Testimone' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(lCOD_INO) + "'>";
        str += "<td class='dataTd'><input type='text' name='NOM_TST_EVE' class='dataInput' readonly  value=''></td>";
        str += "<td class='dataTd'><input type='text' name='DES_TST_EVE' class='dataInput' readonly  value=''></td>";
        str += "<td class='dataTd'><input type='text' name='CTO_TST_EVE' class='dataInput' readonly  value=''></td>";
        str += "</tr>";
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            Testimone_View obj = (Testimone_View) it.next();
            str += "<tr INDEX='" + Formatter.format(lCOD_INO) + "' ID='" + obj.lCOD_TST_EVE + "'>";
            str += "<td class='dataTd'><input type='text' readonly style='width: 300px;' class='inputstyle'  value=\"" + Formatter.format(obj.strNOM_TST_EVE) + "\"></td>";
            str += "<td class='dataTd'><input type='text' readonly style='width: 500px;' class='inputstyle'  value=\"" + Formatter.format(obj.strDES_TST_EVE) + "\"></td>";
            str += "<td class='dataTd'><input type='text' readonly style='width: 160px;' class='inputstyle'  value=\"" + Formatter.format(obj.strCTO_TST_EVE) + "\"></td>";
            str += "</tr>";
        }
        str += "</table>";
        return str;
    }

    String BuildDocumentiTab(IInfortuniIncidentiHome home, long lCOD_INO, long lCOD_AZL) {
        String str;
        java.util.Collection col = home.getDocumenti_View(lCOD_INO, lCOD_AZL);

        str = "<table border='0' align='left' width='960' id='DocumentiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr><td width='600'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong></td>";
        str += "<td width='245'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>";
        str += "<td width='115'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td></tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='960' id='Documenti' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(lCOD_INO) + "'><td width='600' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
        str += "<td width='245' class='dataTd'><input type='text' name='RSP_DOC' readonly class='dataInput'  value=''></td>";
        str += "<td width='115' class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='dataInput'  value=''></td></tr>";

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            InfortuniIncidenti_Documenti_View view = (InfortuniIncidenti_Documenti_View) it.next();
            str += "<tr style='display:' ID='" + Formatter.format(view.lCOD_DOC) + "' INDEX='" + Formatter.format(lCOD_INO) + "'><td class='dataTd'><input type='text' name='TIT_DOC' class='inputstyle' readonly style='width: 600px;'  value=\"" + Formatter.format(view.strTIT_DOC) + "\"></td>";
            str += "<td class='dataTd'><input type='text' name='RSP_DOC' readonly style='width: 245px;' class='inputstyle'  value=\"" + Formatter.format(view.strRSP_DOC) + "\"></td>";
            str += "<td class='dataTd'><input type='text' name='DAT_REV_DOC' readonly style='width: 115px;' class='inputstyle'  value=\"" + Formatter.format(view.dtDAT_REV_DOC) + "\"></td></tr>";
        }
        str += "</table>";
        return str;
    }
%>
