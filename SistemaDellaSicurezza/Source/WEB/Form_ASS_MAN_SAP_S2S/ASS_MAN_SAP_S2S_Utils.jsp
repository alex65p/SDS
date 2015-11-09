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

<%!
String BuildListaSAP(AssociazioneMansioniSAP_S2SHome home, long COD_AZL) {
    int rowCount = 0;
    StringBuilder str = new StringBuilder(10000000);
    java.util.Collection col = home.getDipendenti_Mansioni_SAP_View(COD_AZL);
    java.util.Iterator it = col.iterator();
    while(it.hasNext()){
        str.append("<tr class=\"VIEW_TR\" rowIndex=").append(rowCount).append(" onclick=\"g_OnRowClick_SAP(this);\">");
        Dipendenti_Mansioni_SAP_View  row = (Dipendenti_Mansioni_SAP_View)it.next();
        str.append(     "<td>");
        str.append(         "<input type=\"checkbox\" id=\"id_checkbox").append(rowCount).append("\">");
        str.append(         "<input type=\"hidden\" id=\"id_sap").append(rowCount).append("\" value=\"").append(row.ID).append("\">");
        str.append(         "<input type=\"hidden\" value=\"").append(row.COD_AZL_S2S).append("\">");
        str.append(         "<input type=\"hidden\" id=\"id_COD_DPD_S2S").append(rowCount).append("\" value=\"").append(row.COD_DPD_S2S).append("\">");
        str.append(         "<input type=\"hidden\" id=\"id_COD_MAN_SAP_DAT_INI").append(rowCount).append("\" value=\"").append(Formatter.format(row.COD_MAN_SAP_DAT_INI)).append("\">");
        str.append(         "<input type=\"hidden\" id=\"id_COD_MAN_SAP_DAT_FIN").append(rowCount).append("\" value=\"").append(Formatter.format(row.COD_MAN_SAP_DAT_FIN)).append("\">");
        str.append(         "<input type=\"hidden\" id=\"id_DES_LUO_FSC_S2S").append(rowCount).append("\" value=\"").append(Formatter.format(row.DES_LUO_FSC_S2S)).append("\">");
        str.append(     "</td>");
        str.append(     "<td>").append(Formatter.format(row.COG_DPD)).append("</td>");
        str.append(     "<td>").append(Formatter.format(row.NOM_DPD)).append("</td>");
        str.append(     "<td>").append(Formatter.format(row.DES_UNI_ORG_SAP)).append("</td>");
        str.append(     "<td>").append(Formatter.format(row.COD_UNI_ORG_SAP_DAT_INI)).append("</td>");
        str.append(     "<td>").append(Formatter.format(row.COD_UNI_ORG_SAP_DAT_FIN)).append("</td>");        
        str.append(     "<td>").append(Formatter.format(row.DES_MAN_SAP)).append("</td>");
        str.append(     "<td>").append(Formatter.format(row.COD_MAN_SAP_DAT_INI)).append("</td>");
        str.append(     "<td>").append(Formatter.format(row.COD_MAN_SAP_DAT_FIN)).append("</td>");
        str.append(     "<td>").append(Formatter.format(row.DES_POS_SAP)).append("</td>");
        str.append(     "<td>").append(Formatter.format(row.COD_POS_SAP_DAT_INI)).append("</td>");
        str.append(     "<td>").append(Formatter.format(row.COD_POS_SAP_DAT_FIN)).append("</td>");        
        str.append(     "<td>").append(Formatter.format(row.DES_LUO_FSC_S2S)).append("</td>");        
        str.append("</tr>");
        rowCount++;
    }
    return str.toString();
}

String BuildListaS2S(AssociazioneMansioniSAP_S2SHome home, long COD_AZL) {
    int rowCount = 0;
    StringBuilder str = new StringBuilder();
    java.util.Collection col = home.getUO_Mansioni_S2S_View(COD_AZL);
    java.util.Iterator it = col.iterator();
    while(it.hasNext()){
        str.append("<tr class=\"VIEW_TR\" rowIndex=").append(rowCount).append(" onclick=\"BeforeRowClick_S2S();g_OnRowClick(this);AfterRowClick_S2S();\">");
        UO_Mansioni_S2S_View  row = (UO_Mansioni_S2S_View)it.next();
        str.append(     "<td>");
        str.append(         "<input type=\"radio\" id=\"id_radio").append(rowCount).append("\">");
        str.append(         "<input type=\"hidden\" id=\"id_COD_UNI_ORG").append(rowCount).append("\" value=\"").append(row.COD_UNI_ORG).append("\">");
        str.append(         "<input type=\"hidden\" id=\"id_COD_MAN").append(rowCount).append("\" value=\"").append(row.COD_MAN).append("\">");
        str.append(     "</td>");
        str.append(     "<td>").append(Formatter.format(row.NOM_UNI_ORG)).append("</td>");
        str.append(     "<td>").append(Formatter.format(row.NOM_MAN)).append("</td>");
        str.append("</tr>");
        rowCount++;
    }
    return str.toString();
}
%>
