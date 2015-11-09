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

<%    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.RapportiniSegnalazione.*" %>

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
        Checker c = new Checker();
        Long lCOD_DPD = c.checkLongEx("COD_DPD", request.getParameter("COD_DPD"), false);
        String strDES_SGZ = c.checkStringEx("Descrizione", request.getParameter("DES_SGZ"), false);
        java.sql.Date dtDAT_SGZ = c.checkDate("Data", request.getParameter("DAT_SGZ"), false);
        Long lNUM_SGZ = c.checkLongEx("Numero", request.getParameter("NUM_SGZ"), false);
        Long lVER_SGZ = c.checkLongEx("Versione", request.getParameter("VER_SGZ"), false);
        String strTIT_SGZ = c.checkStringEx("Titolo", request.getParameter("TIT_SGZ"), false);
        String strSTA_SGZ = c.checkStringEx("Stato", request.getParameter("STA_SGZ"), false);
        String strURG_SGZ = c.checkStringEx("Urgente", request.getParameter("URG_SGZ"), false);
        String strDES_ATI_SGZ = c.checkStringEx("Attivita", request.getParameter("DES_ATI_SGZ"), false);
        String strSTA_FIE_SGZ = c.checkStringEx("STA_FIE_SGZ", request.getParameter("STA_FIE_SGZ"), false);
        java.sql.Date dtDAT_FIE = c.checkDate("Data Fine", request.getParameter("DAT_FIE"), false);
        String strNOM_RIL_SGZ = c.checkStringEx("Rilevatore", request.getParameter("NOM_RIL_SGZ"), false);
        long lCOD_IMM = c.checkLong("Immobile", request.getParameter("COD_IMM"), false);
        long lCOD_LUO_FSC = c.checkLong("Luogo.fisico", request.getParameter("COD_LUO_FSC"), false);

        if (c.isError) {
            String err = c.printErrors();
            out.print("<script>alert(\"" + err + "\");</script>");
            return;
        }

        IRapportiniSegnalazioneHome dHome = (IRapportiniSegnalazioneHome) PseudoContext.lookup("RapportiniSegnalazioneBean");

        long lCOD_AZL = 0;
        lCOD_AZL = Security.getAzienda();
        Collection col = dHome.findEx(lCOD_DPD, strDES_SGZ, dtDAT_SGZ, lNUM_SGZ, lVER_SGZ,
                strTIT_SGZ, strSTA_SGZ, strURG_SGZ, strDES_ATI_SGZ,
                strSTA_FIE_SGZ, dtDAT_FIE, strNOM_RIL_SGZ, lCOD_IMM,
                lCOD_LUO_FSC, lCOD_AZL, 0);

        Iterator it = col.iterator();
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
              
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Dipendente")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                int i = 1;
                while (it.hasNext()) {
                    RapportiniSegnalazione_List_View view = (RapportiniSegnalazione_List_View) it.next();
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=view.COD_SGZ%>" 
                onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
            
                <td>&nbsp;<%=i++%>&nbsp;</td>
              
                <td>&nbsp;<%=Formatter.format(view.TIT_SGZ)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.DAT_SGZ) %>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.COG_DPD + " " + view.NOM_DPD)%>&nbsp;</td>
            </tr>
            <%
                }
            %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
              
                <th><input type="text" name="cerca_Titolo" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Dipendente" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Dipendente")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0027"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuVerificheSPP, 2));

        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_SGZ/ANA_SGZ_Form.jsp";
        parent.g_Handler.New.Width = 54;
        parent.g_Handler.New.Height = 41;

        parent.g_Handler.Open = parent.g_Handler.New;

        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_SGZ/ANA_SGZ_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_SGZ/ANA_SGZ_Help.jsp";
        parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "30%", "aTargets": [1], "sType": "date-eu"},
                        {"sWidth": "10%", "aTargets": [2], "sType": "string"} ,
                        {"sWidth": "50%", "aTargets": [3], "sType": "string"}  ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
