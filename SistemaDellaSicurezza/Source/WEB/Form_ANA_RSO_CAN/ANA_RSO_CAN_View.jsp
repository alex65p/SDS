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
     <version number="1.0" date="28/01/2004" author="Artur Denysenko">
     <comments>
     <comment date="28/01/2004" author="Artur Denysenko">
     <description>ANA_RSO_View.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.RischioCantiere.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        Checker c = new Checker();

        long lCOD_AZL = Security.getAzienda();
        long lCOD_RSO = c.checkLong("Rischio", request.getParameter("COD_RSO"), false);

        String strNOM_RSO = c.checkStringEx("Nome rischio", request.getParameter("NOM_RSO"), false);
        String strDES_RSO = c.checkStringEx("Descrizione Rischio", request.getParameter("DES_RSO"), false);
        java.sql.Date dtDAT_RIL = c.checkDate("Data rilievato", request.getParameter("DAT_RIL"), false);
        String strNOM_RIL_RSO = c.checkStringEx("Nominativo Rilevatore", request.getParameter("NOM_RIL_RSO"), false);

        String strCLF_RSO = request.getParameter("CLF_RSO") + request.getParameter("CLF_RSO_TEXT");
        strCLF_RSO = c.checkStringEx("Classificazione Rischio", strCLF_RSO, false);
        strCLF_RSO = c.checkStringEx("Classificazione Rischio", request.getParameter("CLF_RSO"), false);
        String strCLF_RSO_TEXT = c.checkStringEx("Classificazione Rischio", request.getParameter("CLF_RSO_TEXT"), false);

        if (strCLF_RSO != null && strCLF_RSO_TEXT != null) {
            if (!strCLF_RSO.equals(strCLF_RSO_TEXT) && !strCLF_RSO_TEXT.equals("")) {
                strCLF_RSO = strCLF_RSO_TEXT;
            }
        }

        Long lPRB_EVE_LES = c.checkLongEx("Probabilita evento lesivo", request.getParameter("PRB_EVE_LES"), false);
        Long lENT_DAN = c.checkLongEx("Enita danno", request.getParameter("ENT_DAN"), false);
        Long lFRQ_RIP_ATT_DAN = c.checkLongEx("Frequenza attivit� a rischio", request.getParameter("FRQ_RIP_ATT_DAN"), false);
        Long lNUM_INC_INF = c.checkLongEx("N� incidenti / infortuni", request.getParameter("NUM_INC_INF"), false);
        Float lSTM_NUM_RSO = c.checkFloatEx("Stima numerica del Rischio", request.getParameter("STM_NUM_RSO"), false);
        Long lRFC_VLU_RSO_MES = c.checkLongEx("Rifacimento Valutazione Mese:", request.getParameter("RFC_VLU_RSO_MES"), false);
        Long lCOD_FAT_RSO = c.checkLongEx("Fattore di Rischio", request.getParameter("COD_FAT_RSO"), false);

        if (c.isError) {
            String err = c.printErrors();
    %><script>alert("<%=err%>");</script><%
            return;
        }

        IRischioCantiereHome home = (IRischioCantiereHome) PseudoContext.lookup("RischioCantiereBean");

        Collection col = home.findEx(lCOD_AZL, strNOM_RSO, strDES_RSO, dtDAT_RIL, strNOM_RIL_RSO, strCLF_RSO, lPRB_EVE_LES, lENT_DAN,
                lFRQ_RIP_ATT_DAN, lNUM_INC_INF, lSTM_NUM_RSO, lRFC_VLU_RSO_MES, lCOD_FAT_RSO, 0);

        Iterator it = col.iterator();
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                String strNOM_FAT_RSO = "";
                int i = 1;
                while (it.hasNext()) {
                    //  Rischio_Nome_Fattore_View v=(Rischio_Nome_Fattore_View) it.next();
                    Rischio_Nome_Fattore_View v = (Rischio_Nome_Fattore_View) it.next();
                    lCOD_RSO = v.lCOD_RSO;
                    strNOM_RSO = v.strNOM_RSO;
                    strNOM_FAT_RSO = v.strNOM_FAT_RSO;
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=lCOD_RSO%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                <td>&nbsp;<%=i++%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(strNOM_RSO)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(strNOM_FAT_RSO)%>&nbsp;</td>
            </tr>
            <%}%>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Nome" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Nome")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Fattore.di.rischio" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0026"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuRischiCantiere, 1));
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_RSO_CAN/ANA_RSO_CAN_Form.jsp";
        parent.g_Handler.New.Width = "900px";//54;
        parent.g_Handler.New.Height = "400px";//34;
        //  parent.g_Handler.New.Height="630px";//34;

        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_RSO_CAN/ANA_RSO_CAN_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_RSO/ANA_RSO_Help.jsp";
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
    <%if (Security.isExtendedMode()) {%>
    parent.g_Handler.Delete.getButton().disabled = false;
    <%}%>
</script>
