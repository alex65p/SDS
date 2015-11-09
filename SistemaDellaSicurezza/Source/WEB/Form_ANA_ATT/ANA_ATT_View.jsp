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
    Document   : ANA_ATT_View
    Created on : 24-mar-2011, 17.34.51
    Author     : Alessandro
--%>
<%    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@page import="com.apconsulting.luna.ejb.AnagrAttivitaCantieri.AnagrAttivitaCantieri_All_View"%>
<%@page import="com.apconsulting.luna.ejb.AnagrAttivitaCantieri.IAnagrAttivitaCantieriHome"%>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        Checker c = new Checker();
        long lCOD_DOC = c.checkLong("Attivita", request.getParameter("COD_DOC"), false);
        String strDES_ATT = c.checkStringEx("Descrizione", request.getParameter("DES_ATT"), false);
        String strNOM_ATT = c.checkStringEx("Nome", request.getParameter("NOM_ATT"), false);
        String strCOD = c.checkStringEx("Codice", request.getParameter("COD"), false);

        if (c.isError) {
            String err = c.printErrors();
    %><script>alert("<%=err%>");</script><%
            return;
        }

        IAnagrAttivitaCantieriHome home = (IAnagrAttivitaCantieriHome) PseudoContext.lookup("AnagrAttivitaCantieriBean");
        Collection col = home.findEx(strDES_ATT, strCOD, strNOM_ATT, Security.getAzienda());
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Codice")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</th>
                <!-- Non eliminare, ne spostare di posto, viene utilizzata dalla gestione cantieri - INIZIO -->
                <th style="display: none;">COD_DOC</th>
                <!-- Non eliminare, ne spostare di posto, viene utilizzata dalla gestione cantieri - FINE -->
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("File")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                Iterator it = col.iterator();
                int i = 1;
                while (it.hasNext()) {
                    AnagrAttivitaCantieri_All_View v = (AnagrAttivitaCantieri_All_View) it.next();
                    lCOD_DOC = v.COD_DOC;
                    strCOD = v.COD;
                    strDES_ATT = v.DES_ATT;
                    strNOM_ATT = v.NOM_ATT;
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=lCOD_DOC%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                <td>&nbsp;<%=i++%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(strCOD)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(strNOM_ATT)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(strDES_ATT)%>&nbsp;</td>
                <!-- Non eliminare, ne spostare di posto, viene utilizzata dalla gestione cantieri - INIZIO -->
                <td style="display: none;"><%=Formatter.format(v.COD_DOC)%></td>
                <!-- Non eliminare, ne spostare di posto, viene utilizzata dalla gestione cantieri - FINE -->
                <td>&nbsp;<a href="Form_ANA_ATT/ANA_ATT_File.jsp?ID=<%=v.COD_DOC%>&TYPE=FILE"><%=Formatter.format(v.FILE)%></a>&nbsp;</td>
            </tr>
            <%}%>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Codice" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Codice")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Nome" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Nome")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Descrizione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>" class="search_init" /></th>
                <th style="display: none;"><input type="text" name="cerca_COD_DOC" value="Cerca COD_DOC" class="search_init" /></th>
                <th><input type="text" name="cerca_File" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("File")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuAnagraficagenerale, 3));

        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_ATT/ANA_ATT_Form.jsp";
        parent.g_Handler.New.Width = 60;
        parent.g_Handler.New.Height = 17;

        parent.g_Handler.Open = parent.g_Handler.New;

        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_ATT/ANA_ATT_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
    }

    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
