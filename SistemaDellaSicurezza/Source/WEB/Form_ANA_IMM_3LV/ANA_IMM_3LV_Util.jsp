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
            <version number="1.0" date="07/04/2011" author="Dario Massaroni">
            <comments>
            <comment date="07/04/2011" author="Dario Massaroni">
            <description>ANA_IMM_3LV_Util.jsp-functions for ANA_IMM_3LV_Form.jsp</description>
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */
%>
<%@ page import="com.apconsulting.luna.ejb.SediAziendali.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="s2s.luna.conf.ApplicationConfigurator" %>
<%!
//---------------FUNCTIONS FOR TABS-------------------------
    String BuildSitoAzlComboBox(ISitaAziendeHome home, long SELECTED_ID, long FILTER_ID) {
        String str = "";
        java.util.Collection col = home.getSiteAziendaleByAZLID_View(FILTER_ID);
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            SiteAziendaleByAZLID_View obj = (SiteAziendaleByAZLID_View) it.next();
            String strSEL = "";
            if (SELECTED_ID == obj.COD_SIT_AZL) {
                strSEL = "selected";
            }
            str = str + "<option " + strSEL + " value='" + Formatter.format(obj.COD_SIT_AZL) + "'>" + Formatter.format(obj.NOM_SIT_AZL) + "</option>";
        }
        return str;
    }

    String BuildLuoghiFisiciTab(IAnagrLuoghiFisiciHome home, long COD_IMM) {
        String str;
        java.util.Collection col = home.getAnagrLuoghiFisici_Imm_3lv_View(COD_IMM);
        str = "<table border='0' align='left' width='800 id='LuoghiFisiciHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr><td width='800'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nominativo.luogo.fisico") + "</strong></td></tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='800' id='LuoghiFisici' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(COD_IMM) + "'><td width='800' class='dataTd'><input type='text' name='NOM_LUO_FSC' class='dataInput' readonly  value=''></td></tr>";
        if (COD_IMM > 0) {
            java.util.Iterator it_alf = col.iterator();
            while (it_alf.hasNext()) {
                AnagrLuoghiFisici_List_View alf = (AnagrLuoghiFisici_List_View) it_alf.next();
                str += "<tr INDEX='" + Formatter.format(COD_IMM) + "' ID='" + alf.COD_LUO_FSC + "'>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 800px;' class='inputstyle'  value=\"" + Formatter.format(alf.NOM_LUO_FSC) + "\"></td>";
                str += "</tr>";
            }
        }
        str += "</table>";
        return str;
    }
%>
