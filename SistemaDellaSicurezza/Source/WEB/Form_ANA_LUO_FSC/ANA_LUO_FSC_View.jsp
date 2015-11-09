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
     <version number="1.0" date="15/01/2004" author="Alexey Kolesnik">
     <comments>

     <comment date="15/01/2004" author="Alexey Kolesnik">
     <description> Initial template </description>
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
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

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
        Long lCOD_SIT_AZL = c.checkLongEx("lCOD_SIT_AZL", request.getParameter("COD_SIT_AZL"), false);
        long lCOD_AZL = Security.getAzienda();

        String strNOM_LUO_FSC = c.checkStringEx("Nome Luogo Fisico", request.getParameter("strNOM_LUO_FSC"), false);
        Long lCOD_ALA = c.checkLongEx("COD_ALA", request.getParameter("COD_ALA"), false);
        Long lCOD_IMO = c.checkLongEx("COD_IMO", request.getParameter("COD_IMO"), false);
        Long lCOD_IMM_3LV = c.checkLongEx("COD_IMM_3LV", request.getParameter("COD_IMM_3LV"), false);
        Long lCOD_PNO = c.checkLongEx("COD_PNO", request.getParameter("COD_PNO"), false);
        String strDES_LUO_FSC = c.checkStringEx("Descrisione", request.getParameter("strDES_LUO_FSC"), false);
        String strQLF_RSP_LUO_FSC = c.checkStringEx("Qualifica'", request.getParameter("strQLF_RSP_LUO_FSC"), false);
        String strNOM_RSP_LUO_FSC = c.checkStringEx("Preposto", request.getParameter("strNOM_RSP_LUO_FSC"), false);
        String strIDZ_PSA_ELT_RSP_LUO_FSC = c.checkStringEx("E-mail", request.getParameter("strIDZ_PSA_ELT_RSP_LUO_FSC"), false);
        String strFLG_IMP = c.checkStringEx("Impianto", request.getParameter("FLG_IMP"), false);
        strFLG_IMP = (strFLG_IMP == null || strFLG_IMP.equals("")) ? null : "S";

        boolean LUOGHI_FISICI_3_LIVELLI
                = ApplicationConfigurator.isModuleEnabled(MODULES.LUOGHI_FISICI_3_LIVELLI);
        
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);

        IAnagrLuoghiFisiciHome aHome = (IAnagrLuoghiFisiciHome) PseudoContext.lookup("AnagrLuoghiFisiciBean");
        Collection col;
        col = aHome.findEx(lCOD_AZL,
                lCOD_SIT_AZL,
                lCOD_PNO,
                lCOD_ALA,
                lCOD_IMO,
                lCOD_IMM_3LV,
                strNOM_LUO_FSC,
                strDES_LUO_FSC,
                strNOM_RSP_LUO_FSC,
                strIDZ_PSA_ELT_RSP_LUO_FSC,
                strQLF_RSP_LUO_FSC,
                strFLG_IMP,
                0);
        Iterator it = col.iterator();
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                  
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
               
                    <%=LUOGHI_FISICI_3_LIVELLI ? "<th>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Immobile") + "&nbsp;</th>" : ""%>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Responsabile")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Qualifica.resp.")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                int i = 1;
                while (it.hasNext()) {
                    AnagrLuoghiFisici_List_View view = (AnagrLuoghiFisici_List_View) it.next();
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=view.COD_LUO_FSC%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
               
                <td>&nbsp;<%=i++%>&nbsp;</td>
              
                <%=LUOGHI_FISICI_3_LIVELLI ? "<td>&nbsp;" + Formatter.format(view.NOM_IMM) + "&nbsp;</td>" : ""%>
                <td>&nbsp;<%=Formatter.format(view.NOM_LUO_FSC)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.DES_LUO_FSC)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.NOM_RSP_LUO_FSC)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.QLF_RSP_LUO_FSC)%>&nbsp;</td>
            </tr>
            <%
                }
            %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
               
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
              
                    <%=LUOGHI_FISICI_3_LIVELLI ? "<th><input type=\"text\" name=\"cerca_Immobile\" value=\"Cerca " + ApplicationConfigurator.LanguageManager.getString("Immobile") + "\" class=\"search_init\" /></th>" : ""%>
                <th><input type="text" name="cerca_Luogo.fisico" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Descrizione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Responsabile" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Responsabile")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Qualifica.resp." value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Qualifica.resp.")%>" class="search_init" /></th>
            </tr>
        </tfoot>        
    </table>
</div>
<script type="text/javascript">
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }
    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuDistribuzioneTerritorialie, 1));
    <% if (ID_PARENT != null) {%>
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_LUO_FSC/ANA_LUO_FSC_Form.jsp?ID_PARENT=<%=ID_PARENT%>";
    <%} else {%>
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_LUO_FSC/ANA_LUO_FSC_Form.jsp";
    <% }%>
        //----------------
        parent.g_Handler.New.Width = "840px";
        parent.g_Handler.New.Height = "670px";
        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_LUO_FSC/ANA_LUO_FSC_Delete.jsp"; //?ID=32233223
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_LUO_FSC/ANA_LUO_FSC_Help.jsp";
         parent.g_Handler.dataTableOn="Y";
         parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "7%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "20%", "aTargets": [1], "sType": "string"} ,
                        {"sWidth": "23%", "aTargets": [2], "sType": "string"} ,
                        {"sWidth": "20%", "aTargets": [3], "sType": "string"} ,
                        {"sWidth": "15%", "aTargets": [4], "sType": "string"},
                        {"sWidth": "15%", "aTargets": [4], "sType": "string"}]   ;
        
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
    <%if (Security.isExtendedMode()) {%>
    parent.g_Handler.Delete.getButton().disabled = true;
    <%}%>
</script>
