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
<%@page import="com.apconsulting.luna.ejb.InfortuniIncidentiCantiere.*" %>
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
        long lCOD_CAN = c.checkLong("Cantiere", request.getParameter("COD_CAN"), false);
        long lCOD_LUO_FSC = c.checkLong("Luogo fisico", request.getParameter("COD_LUO_FSC"), false);
        long lCOD_DPD = c.checkLong("Lavoratore", request.getParameter("COD_DPD"), false);
        long lCOD_DTE = c.checkLong("", request.getParameter("COD_DTE"), false);
        long lCOD_AZL = Security.getAzienda();
        if (c.isError) {
            String err = c.printErrors();
            out.print("<script>err=true;alert(\"" + err + "\");</script>");
            return;
        }
        IInfortuniIncidentiCantiereHome home = (IInfortuniIncidentiCantiereHome) PseudoContext.lookup("InfortuniIncidentiCantiereBean");
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                    <%=!GEST_INFO_EXTENDED ? "<th>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.comunicazione") + "&nbsp;</th>" : ""%>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.infortunio")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Cognome")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</th>
                <!--td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.inizio.assenza")%>&nbsp;</td-->
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.fine.infortunio")%>&nbsp;</th>
                <!--td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Non.indennizzato")%>&nbsp;</td-->
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("In.itinere")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                java.util.Collection col = home.findEx(lCOD_AZL, lCOD_LUO_FSC, lCOD_DPD, lCOD_DTE, lCOD_NAT_LES, lCOD_AGE_MAT, lCOD_TPL_FRM_INO, lCOD_SED_LES, lCOD_CAN);
                java.util.Iterator it = col.iterator();
                int iCount = 1;
                while (it.hasNext()) {
                    InfortuniIncidentiCantiere_View view = (InfortuniIncidentiCantiere_View) it.next();
            %>
            <tr valign="top"
                class="VIEW_TR" valign="top"
                INDEX="<%=view.COD_INO%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                <td><%=iCount++%></td>
                <%
                        out.println(
                                (!GEST_INFO_EXTENDED ? "<td>&nbsp;" + Formatter.format(view.DAT_COM_INO) + "&nbsp;</td>" : "")
                                + "<td>&nbsp;" + Formatter.format(view.DAT_EVE_INO) + "&nbsp;</td>"
                                + "<td>&nbsp;" + Formatter.format(view.COG_DPD) + "&nbsp;</td>"
                                + "<td>&nbsp;" + Formatter.format(view.NOM_DPD) + "&nbsp;</td>"
                                /*  + "<td>&nbsp;" + Formatter.format(view.DAT_INZ_ASZ_LAV) + "&nbsp;</td>"*/
                                + "<td>&nbsp;" + Formatter.format(view.DAT_FIE_ASZ_LAV) + "&nbsp;</td>"
                                /* + "<td " + Formatter.format(
                                 (view.NON_IND != null && view.NON_IND.trim().toUpperCase().equals("S"))
                                 ? "style='"
                                 + "background-image: url(_images/check_medium.png);"
                                 + "background-repeat: no-repeat;"
                                 + "background-position: center;'" : "")
                                 + ">&nbsp;</td>"*/
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
                            ? "<th><input type=\"text\" name=\"cerca_Data.comunicazione\" value=\"Cerca " + ApplicationConfigurator.LanguageManager.getString("Data.comunicazione") + "\" class=\"search_init\" /></th>"
                            : ""%>
                <th><input type="text" name="cerca_Data.infortunio" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.infortunio")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Cognome" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Cognome")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Nome" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Nome")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.fine.infortunio" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.fine.infortunio")%>" class="search_init" /></th>
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
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuInfortuniCantiere, 2));

        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_INO_CAN/ANA_INO_CAN_Form.jsp";
        parent.g_Handler.New.Width = 49;
        parent.g_Handler.New.Height = 43;

        parent.g_Handler.Open = parent.g_Handler.New;

        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_INO_CAN/ANA_INO_CAN_Delete.jsp"; //?ID=32233223
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_INO/ANA_INO_Help.jsp";
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
    //  InitView();
</script>

