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
// DUVRI
    String BuildRSCollegatiTab(IAnagrDocumentiGestioneCantieri bean) {
        java.util.Collection col = bean.getRSCollegati();
        StringBuilder jspOutputBuilder = new StringBuilder();
        jspOutputBuilder.append("<table border='0' align='left' width='935' id='RSCollegatiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>")
                        .append("<tr>")
                        .append("<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Numero.sopralluogo") + "</strong></td>")
                        .append("<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data") + "</strong></td>")
                        .append("<td width='245'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Procedimento") + "</strong></td>")
                        .append("<td width='245'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Cantiere") + "</strong></td>")
                        .append("<td width='245'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Opera") + "</strong></td>")
                        .append("</tr>")
                        .append("</table>")
                        .append("<table border='0' align='left' width='755 id='RSCollegati' class='dataTable' cellpadding='0' cellspacing='0'>")
                        .append("<tr style='display:none' ID='' INDEX='" + bean.getCOD_DOC() + "'>")
                        .append("<td class='dataTd'>")
                        .append("<input type='text' name='NUM_SOP' class='dataInput' readonly  value=''>")
                        .append("</td>")
                        .append("<td class='dataTd'>")
                        .append("<input type='text' name='DAT_SOP' class='dataInput' readonly  value=''>")
                        .append("</td>")
                        .append("<td class='dataTd'>")
                        .append("<input type='text' name='NOM_PRO' class='dataInput' readonly  value=''>")
                        .append("</td>")
                        .append("<td class='dataTd'>")
                        .append("<input type='text' name='NOM_CAN' class='dataInput' readonly  value=''>")
                        .append("</td>")
                        .append("<td class='dataTd'>")
                        .append("<input type='text' name='NOM_OPE' class='dataInput' readonly  value=''>")
                        .append("</td>")
                        .append("</tr>");
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            RSCollegati_View obj = (RSCollegati_View) it.next();
            jspOutputBuilder.append("<tr INDEX='" + obj.COD_DOC + "' ID='" + obj.COD_SOP + "'>")
                            .append("<td class='dataTd'>")
                            .append("<input type='text' readonly style='width: 100px;' class='inputstyle'  value=\"" + Formatter.format(obj.NUM_SOP) + "\">")
                            .append("</td>")
                            .append("<td class='dataTd'>")
                            .append("<input type='text' readonly style='width: 100px;' class='inputstyle'  value=\"" + Formatter.format(obj.DAT_SOP) + "\">")
                            .append("</td>")
                            .append("<td class='dataTd'>")
                            .append("<input type='text' readonly style='width: 245px;' class='inputstyle'  value=\"" + Formatter.format(obj.NOM_PRO) + "\">")
                            .append("</td>")
                            .append("<td class='dataTd'>")
                            .append("<input type='text' readonly style='width: 245px;' class='inputstyle'  value=\"" + Formatter.format(obj.NOM_CAN) + "\">")
                            .append("</td>")
                            .append("<td class='dataTd'>")
                            .append("<input type='text' readonly style='width: 245px;' class='inputstyle'  value=\"" + Formatter.format(obj.NOM_OPE) + "\">")
                            .append("</td>")
                            .append("</tr>");
        }
        jspOutputBuilder.append("</table>");
        return jspOutputBuilder.toString();
    }
%>
