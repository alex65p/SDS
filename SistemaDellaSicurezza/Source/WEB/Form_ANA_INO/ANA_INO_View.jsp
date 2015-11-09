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
     <version number="1.0" date="27/02/2004" author="Mike Kondratyuk">
     <comments>

     <comment date="27/02/2004" author="Mike Kondratyuk">
     <description>ANA_INO_View</description>
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
<%@page import="com.apconsulting.luna.ejb.InfortuniIncidenti.*" %>
<%@page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        boolean GEST_INFO_EXTENDED = ApplicationConfigurator.isModuleEnabled(MODULES.GEST_INFO_EXTENDED);
        Checker c = new Checker();
        long lCOD_AGE_MAT = c.checkLong("Agenti materiali", request.getParameter("COD_AGE_MAT"), false);
        long lCOD_TPL_FRM_INO = c.checkLong("Tipo infortunio", request.getParameter("COD_TPL_FRM_INO"), false);
        long lCOD_NAT_LES = c.checkLong("Natura lesione", request.getParameter("COD_NAT_LES"), false);
        long lCOD_SED_LES = c.checkLong("Sede lesione", request.getParameter("COD_SED_LES"), false);
        long lCOD_LUO_FSC = c.checkLong("Luogo fisico", request.getParameter("COD_LUO_FSC"), false);
        long lCOD_DPD = c.checkLong("Lavoratore", request.getParameter("COD_DPD"), false);
        long lCOD_AZL = Security.getAzienda();
        if (c.isError) {
            String err = c.printErrors();
            out.print("<script>err=true;alert(\"" + err + "\");</script>");
            return;
        }
        IInfortuniIncidentiHome home = (IInfortuniIncidentiHome) PseudoContext.lookup("InfortuniIncidentiBean");
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                 
                    <%=!GEST_INFO_EXTENDED ? "<th>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.comunicazione") + "&nbsp;</th>" : ""%>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.evento")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Cognome")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.inizio.assenza")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.fine.assenza")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Non.indennizzato")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("In.itinere")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                java.util.Collection col = home.findEx(lCOD_AZL, lCOD_LUO_FSC, lCOD_DPD, lCOD_NAT_LES, lCOD_AGE_MAT, lCOD_TPL_FRM_INO, lCOD_SED_LES);
                java.util.Iterator it = col.iterator();
                int iCount = 1;
                while (it.hasNext()) {
                    InfortuniIncidenti_View view = (InfortuniIncidenti_View) it.next();
            %>
            <tr valign="top"
                class="VIEW_TR" valign="top"
                INDEX="<%=view.COD_INO%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
               
                <td><%=iCount++%></td>
                
                <%
                        out.println(
                                (!GEST_INFO_EXTENDED ? "<td>&nbsp;" + Formatter.format(view.DAT_COM_INO) + "&nbsp;</td>" : "")
                                + "<td>&nbsp;" +(ifMsr? Formatter.formatYYYYMMDD(view.DAT_EVE_INO) :Formatter.format(view.DAT_EVE_INO)) + "&nbsp;</td>"
                                + "<td>&nbsp;" + Formatter.format(view.COG_DPD) + "&nbsp;</td>"
                                + "<td>&nbsp;" + Formatter.format(view.NOM_DPD) + "&nbsp;</td>"
                                + "<td>&nbsp;" +Formatter.format(view.DAT_INZ_ASZ_LAV) + "&nbsp;</td>"
                                + "<td>&nbsp;" +Formatter.format(view.DAT_FIE_ASZ_LAV) + "&nbsp;</td>"                                
                                + "<td " + Formatter.format(
                                        (view.NON_IND != null && view.NON_IND.trim().toUpperCase().equals("S"))
                                        ? "style='"
                                        + "background-image: url(_images/check_medium.png);"
                                        + "background-repeat: no-repeat;"
                                        + "background-position: center;'" : "")
                                + ">&nbsp;</td>"
                                + "<td " + Formatter.format(
                                        (view.IN_ITI != null && view.IN_ITI.trim().toUpperCase().equals("S"))
                                        ? "style='"
                                        + "background-image: url(_images/check_medium.png);"
                                        + "background-repeat: no-repeat;"
                                        + "background-position: center;'" : "")
                                + ">&nbsp;</td>"
                                + "</tr>");
                    }
                %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
               
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                 
                    <%=!GEST_INFO_EXTENDED
                            ? "<th><input type=\"text\" name=\"cerca_Data.comunicazione\" value=\"Cerca" + ApplicationConfigurator.LanguageManager.getString("Data.comunicazione") + "\" class=\"search_init\" /></th>"
                            : ""%>
                <th><input type="text" name="cerca_Data.evento" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.evento")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Cognome" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Cognome")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Nome" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Nome")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.inizio.assenza" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.inizio.assenza")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.fine.assenza" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.fine.assenza")%>" class="search_init" /></th>
                <th><input style="display: none;" type="text" name="cerca_Non.indennizzato" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Non.indennizzato")%>" class="search_init" /></th>
                <th><input style="display: none;" type="text" name="cerca_In.itinere" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("In.itinere")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script type="text/javascript">
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuInfortuni, 6));

        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_INO/ANA_INO_Form.jsp";
        parent.g_Handler.New.Width = 49;
        parent.g_Handler.New.Height = 43;

        parent.g_Handler.Open = parent.g_Handler.New;

        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_INO/ANA_INO_Delete.jsp"; //?ID=32233223
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_INO/ANA_INO_Help.jsp";
        parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "10%", "aTargets": [1], "sType": "date-eu"},
                        {"sWidth": "10%", "aTargets": [2], "sType": "date-eu"},
                        {"sWidth": "20%", "aTargets": [3], "sType": "string"},
                        {"sWidth": "20%", "aTargets": [4], "sType": "string"},
                        {"sWidth": "10%", "aTargets": [5], "sType": "date-eu"},
                        {"sWidth": "10%", "aTargets": [6], "sType": "date-eu"},
                        {"sWidth": "5%",  "aTargets": [7], "sType": "string"},
                        {"sWidth": "5%",  "aTargets": [8], "sType": "string"} ]   ;
    }
</script>
<script type="text/javascript">
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
    //InitView();
</script>
