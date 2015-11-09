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
     <version number="1.0" date="05/04/2011" author="Dario Massaroni">
     <comments>
     <comment date="05/04/2011" author="Dario Massaroni">
     <description> Initial release </description>
     </comment>
     </comments>
     </version>
     </versions>
     </file>
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache");        //HTTP 1.0
    response.setDateHeader("Expires", 0);          //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Immobili3lv.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<script type="text/javascript" src="../_scripts/Alert.js"></script>
<div id="divContent">
    <%
        Checker c = new Checker();
        String ID_PARENT = request.getParameter("ID_PARENT");

        Long lCOD_SIT_AZL = c.checkLongEx(ApplicationConfigurator.LanguageManager.getString("Sito.aziendale"), request.getParameter("COD_SIT_AZL"), false);
        String strNOM_IMM = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Immobile"), request.getParameter("strNOM_IMM"), false);
        String strDES_IMM = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Descrizione"), request.getParameter("strDES_IMM"), false);
        String strIND_IMM = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Indirizzo"), request.getParameter("strIND_IMM"), false);
        String strNUM_CIV_IMM = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Numero.civico"), request.getParameter("strNUM_CIV_IMM"), false);
        String strCIT_IMM = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Città"), request.getParameter("strCIT_IMM"), false);
        String strPRO_IMM = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Provincia"), request.getParameter("strPRO_IMM"), false);
        String strCAP_IMM = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("C.a.p."), request.getParameter("strCAP_IMM"), false);

        IImmobili3lvHome aHome = (IImmobili3lvHome) PseudoContext.lookup("Immobili3lvBean");
        Collection col;

        col = aHome.findEx(Security.getAzienda(),
                lCOD_SIT_AZL,
                strNOM_IMM,
                strDES_IMM,
                strIND_IMM,
                strNUM_CIV_IMM,
                strCIT_IMM,
                strPRO_IMM,
                strCAP_IMM,
                0);
        Iterator it = col.iterator();
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Immobile")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Sito.aziendale")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                int i = 1;
                while (it.hasNext()) {
                    Immobili3liv_View view = (Immobili3liv_View) it.next();
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=view.COD_IMM%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                <td>&nbsp;<%=i++%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.NOM_IMM)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.DES_IMM)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.NOM_SIT_AZL)%>&nbsp;</td>
            </tr>
            <%
                }
            %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Immobile" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Immobile")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Descrizione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Sito.aziendale" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Sito.aziendale")%>" class="search_init" /></th>
            </tr>
        </tfoot>        
    </table>
</div>
<script type="text/javascript">
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }
    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuDistribuzioneTerritorialie, 2));
    <% if (ID_PARENT != null) {%>
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_IMM_3LV/ANA_IMM_3LV_Form.jsp?ID_PARENT=<%=ID_PARENT%>";
    <%} else {%>
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_IMM_3LV/ANA_IMM_3LV_Form.jsp";
    <% }%>
        parent.g_Handler.New.Width = "840px";
        parent.g_Handler.New.Height = "670px";
        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_IMM_3LV/ANA_IMM_3LV_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_IMM_3LV/ANA_IMM_3LV_Help.jsp";
    }
</script>
<script type="text/javascript">
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
