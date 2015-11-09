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
    Document   : ANA_PRO_View
    Created on : 8-apr-2011, 11.34.42
    Author     : Alessandro
--%>
<%    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@page import="com.apconsulting.luna.ejb.AnagrOpere.AnagrOpere_All_View"%>
<%@page import="com.apconsulting.luna.ejb.AnagrOpere.IAnagrOpereHome"%>

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

        long lCOD_OPE = c.checkLong("Opera", request.getParameter("COD_OPE"), false);
        String strDES_OPE = c.checkStringEx("Descrizione", request.getParameter("DES_OPE"), false);
        String strNOM_OPE = c.checkStringEx("Codice", request.getParameter("NOM_OPE"), false);

        /*
         String strCLF_RSO = request.getParameter("CLF_RSO") + request.getParameter("CLF_RSO_TEXT");
         strCLF_RSO = c.checkStringEx("Classificazione Rischio", strCLF_RSO, false);
         strCLF_RSO = c.checkStringEx("Classificazione Rischio", request.getParameter("CLF_RSO"), false);
         String strCLF_RSO_TEXT = c.checkStringEx("Classificazione Rischio", request.getParameter("CLF_RSO_TEXT"), false);

         Long lPRB_EVE_LES = c.checkLongEx("Probabilita evento lesivo", request.getParameter("PRB_EVE_LES"), false);
         Long lENT_DAN = c.checkLongEx("Enita danno", request.getParameter("ENT_DAN"), false);
         Long lFRQ_RIP_ATT_DAN = c.checkLongEx("Frequenza attività a rischio", request.getParameter("FRQ_RIP_ATT_DAN"), false);
         Long lNUM_INC_INF = c.checkLongEx("N° incidenti / infortuni", request.getParameter("NUM_INC_INF"), false);
         Float lSTM_NUM_RSO = c.checkFloatEx("Stima numerica del Rischio", request.getParameter("STM_NUM_RSO"), false);
         Long lRFC_VLU_RSO_MES = c.checkLongEx("Rifacimento Valutazione Mese:", request.getParameter("RFC_VLU_RSO_MES"), false);
         Long lCOD_FAT_RSO = c.checkLongEx("Fattore di Rischio", request.getParameter("COD_FAT_RSO"), false);
         */
        if (c.isError) {
            String err = c.printErrors();
    %><script>alert("<%=err%>");</script><%
            return;
        }

        IAnagrOpereHome home = (IAnagrOpereHome) PseudoContext.lookup("AnagrOpereBean");
        Collection col = home.findEx(strDES_OPE, strNOM_OPE, Security.getAzienda());
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Codice")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                Iterator it = col.iterator();

                /*  String strNOM_FAT_RSO="";   */
                int i = 1;
                while (it.hasNext()) {
                    AnagrOpere_All_View v = (AnagrOpere_All_View) it.next();
                    lCOD_OPE = v.COD_OPE;
                    strDES_OPE = v.DES_OPE;
                    strNOM_OPE = v.NOM_OPE;
                    //  strNOM_FAT_RSO=v.strNOM_FAT_RSO;
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=lCOD_OPE%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                <td>&nbsp;<%=i++%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(strNOM_OPE)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(strDES_OPE)%>&nbsp;</td>
            </tr>
            <%}%>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Codice" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Codice")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Descrizione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0026"]);
    }
    
    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuAnagraficagenerale, 2));
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_OPE/ANA_OPE_Form.jsp";
        parent.g_Handler.New.Width = "900px";//54;
        parent.g_Handler.New.Height = "400px";//34;
        //  parent.g_Handler.New.Height="630px";//34;

        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_OPE/ANA_OPE_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        //  parent.g_Handler.Help.URL="/luna/WEB/Form_ANA_RSO/ANA_RSO_Help.jsp";
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
    <%if (Security.isExtendedMode()) {%>
    //  parent.g_Handler.Delete.getButton().disabled=true;
    <%}%>
</script>
