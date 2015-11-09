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
    Document   : ANA_CON_Util
    Created on : 23-mar-2011, 14.25.02
    Author     : Alessandro
--%>

<%!
    String BuildRischiRilevatiTab() {
        String str = ""; //strTIT_DOC;
        //java.util.Collection col = bean.getDocumentiAssociatiView();
        str += "<table border='1' align='left' width='749' id='RischiRilevatiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
        str += "<td width='749'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.rischio") + "</strong></td>";
        str += "</tr></table>";
        str += "<table border='0' align='left' width='749' id='RischiRilevati' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX=''>";
        str += "<td width='749' class='dataTd'><input type='text' name='' class='dataInput' readonly  value=''></td></tr>";
        str += "</table>";
        return str;
    }

%>
