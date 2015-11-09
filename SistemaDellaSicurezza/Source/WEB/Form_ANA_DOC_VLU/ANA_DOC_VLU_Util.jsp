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
    <version number="1.0" date="26/01/2004" author="Khomenko Juli">
    <comments>
    <comment date="26/01/2004" author="Khomenko Juli">
    <description>ANA_DOC_VLU_Util.jsp-functions for ANA_DOC_VLU_Form.jsp</description>
    </comment>		
    </comments> 
    </version>
    </versions>
    </file> 
     */
%> 
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%!
//---------------FUNCTIONS FOR TABS-------------------------
//	IValutazioneRischiHome home = Home interface of ValutazioneRischi
//	String COD_DOC_VLU = COD_DOC_VLU of current ValutazioneRischi
    String ValutazioneRischiSezioniTab(IValutazioneRischiHome home, String COD_DOC_VLU) {
        String str;
        java.util.Collection col_are = home.getValutazioneRischiSezioniByID_View(new Long(COD_DOC_VLU).longValue());

        str = "<table border='0' align='left' width='620' id='ValutazioneRischiSezioniHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr>";
        str += "<td width='620'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td></tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='620' id='ValutazioneRischiSezioni' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(COD_DOC_VLU) + "'>";
        str += "<td width='620' class='dataTd'><input type='text' name='NOM_RSP_DOC' readonly class='dataInput'  value=''></td>";
        str += "</tr>";
        if (!COD_DOC_VLU.equals("")) {
            java.util.Iterator it_are = col_are.iterator();
            while (it_are.hasNext()) {
                ValutazioneRischiSezioniByID_View are = (ValutazioneRischiSezioniByID_View) it_are.next();
                str += "<tr INDEX='" + Formatter.format(COD_DOC_VLU) + "' ID='" + are.COD_ARE + "'>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 620px;' class='inputstyle'  value=\"" + Formatter.format(are.NOM_RSP_DOC) + "\"></td>";
                str += "</tr>";
            }
        }// 	 
        str += "</table>";
        return str;
    }

    String ValutazioneRischiAllegatiTab(IValutazioneRischiHome home, String COD_DOC_VLU) {
        String str;
        java.util.Collection col_doc = home.getValutazioneRischiAllegati(new Long(COD_DOC_VLU).longValue());

        str = "<table border='0' align='left' width='620' id='ValutazioneRischiAllegatiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr>";
        str += "<td width='620'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong></td></tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='620' id='ValutazioneRischiAllegati' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(COD_DOC_VLU) + "'>";
        str += "<td width='620' class='dataTd'><input type='text' name='NOM_DOC' readonly class='dataInput'  value=''></td>";
        str += "</tr>";
        if (!COD_DOC_VLU.equals("")) {
            java.util.Iterator it_doc = col_doc.iterator();
            while (it_doc.hasNext()) {
                ValutazioneRischiAllegati doc = (ValutazioneRischiAllegati) it_doc.next();
                str += "<tr INDEX='" + Formatter.format(COD_DOC_VLU) + "' ID='" + doc.COD_DOC + "'>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 620px;' class='inputstyle'  value=\"" + Formatter.format(doc.TIT_DOC) + "\"></td>";
                str += "</tr>";
            }
        }//
        str += "</table>";
        return str;
    }

    String ValutazioneRischiArchivioTab(IValutazioneRischiHome home, long lCOD_DOC_VLU, long lCOD_AZL) {
        String str;
        java.util.Collection col_arc = home.getValutazioneRischiArchivio(lCOD_DOC_VLU, lCOD_AZL);

        str = "<table border='0' align='left' width='620' id='ValutazioneRischiArchivioHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr>";
        str += "<td width='620'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td></tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='620' id='ValutazioneRischiArchivio' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(lCOD_DOC_VLU) + "'>";
        str += "<td width='620' class='dataTd'><input type='text' name='NOM_ARC' readonly class='dataInput'  value=''></td>";
        str += "</tr>";
        if (lCOD_DOC_VLU > 0) {
            java.util.Iterator it_arc = col_arc.iterator();
            while (it_arc.hasNext()) {
                ValutazioneRischiArchivio arc = (ValutazioneRischiArchivio) it_arc.next();
                str += "<tr INDEX='" + Formatter.format(lCOD_DOC_VLU) + "' ID='" + arc.COD_ARC + "'>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 620px;' class='inputstyle'  value=\"" + Formatter.format(arc.NOM_ARC) + "\"></td>";
                str += "</tr>";
            }
        }//
        str += "</table>";
        return str;
    }
%>
