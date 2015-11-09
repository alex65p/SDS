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
     <version number="1.0" date="15/12/2004" author="Treskina Maria">		
     <comments>
     <comment date="15/12/2004" author="Treskina Maria">
     <description>Chernovik vieW</description>
     </comment>
     <comment date="26/03/2004" author="Treskina Maria">
     <description>Search</description>
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
<%@ page import="com.apconsulting.luna.ejb.Fornitore.*" %>

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
        long lCOD_AZL = Security.getAzienda();
        Checker c = new Checker();
        String strRAG_SOC_FOR_AZL = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Ragione.sociale"), request.getParameter("RAG_SOC"), false);
        String strCAG_FOR = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Categoria"), request.getParameter("CATEGORIA"), false);
        String strIDZ_FOR = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Indirizzo"), request.getParameter("INDIRIZZO"), false);
        String strCIT_FOR = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Città"), request.getParameter("CITTA"), false);
        String strQLF_RSP_FOR = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Qualifica.del.datore.lavoro"), request.getParameter("QUALIFICA"), false);
        String strNOM_RSP_FOR = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro"), request.getParameter("DATORE_LAVORO"), false);
        String strNUM_CIC_FOR = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Numero.civico"), request.getParameter("NUM_CIC"), false);
        String strPRV_FOR = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Provincia"), request.getParameter("PROV"), false);
        String strCAP_FOR = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("C.a.p."), request.getParameter("CAP"), false);
        String strIDZ_PSA_ELT_RSP = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("E-mail"), request.getParameter("EMAIL"), false);
        String strSIT_INT_FOR = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Sito.internet"), request.getParameter("SITO_INTERNET"), false);
        
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);

        if (c.isError) {
            String err = c.printErrors();
            out.println("<script>alert(\"" + err + "\");err=true;</script>");
            return;
        }

        IFornitoreHome aHome = (IFornitoreHome) PseudoContext.lookup("FornitoreBean");

        // Collection col = aHome.getFornitore_Categoria_RagSoc_View(lCOD_AZL);
        Collection col = aHome.findEx(lCOD_AZL, strRAG_SOC_FOR_AZL, strCAG_FOR, strIDZ_FOR, strNUM_CIC_FOR, strCIT_FOR, strPRV_FOR, strCAP_FOR, strQLF_RSP_FOR, strNOM_RSP_FOR, strIDZ_PSA_ELT_RSP, strSIT_INT_FOR, 0);

        Iterator it = col.iterator();
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Categoria")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Ragione.sociale")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                int i = 1;
                while (it.hasNext()) {
                    Fornitore_Categoria_RagSoc_View view = (Fornitore_Categoria_RagSoc_View) it.next();
            %>
            <tr 
                class="VIEW_TR" valign="top"
                INDEX="<%=view.COD_FOR_AZL%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)"
                >
             
                <td>&nbsp;<%=i++%>&nbsp;</td>
              
                <td>&nbsp;<%=Formatter.format(view.CAG_FOR)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.RAG_SOC_FOR_AZL)%>&nbsp;</td>
            </tr>
            <%
                }
            %>
            <!-- <tr><td colspan=3></td></tr> -->
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
               
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                
                <th><input type="text" name="cerca_Categoria" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Categoria")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Ragione.sociale" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Ragione.sociale")%>" class="search_init" /></th>
            </tr>
        </tfoot>        
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0021"]);
    }
    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuAzienda, 1));

        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_FOR/ANA_FOR_Form.jsp";
        parent.g_Handler.New.Width = 50;
        parent.g_Handler.New.Height = 41;

        parent.g_Handler.Open = parent.g_Handler.New;

        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_FOR/ANA_FOR_Delete.jsp"; //?ID=32233223
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_FOR/ANA_FOR_Help.jsp";
         parent.g_Handler.dataTableOn="Y";
         parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "40%", "aTargets": [1], "sType": "string"} ,
                        {"sWidth": "50%", "aTargets": [2], "sType": "string"} ]   ;
    } 
</script>

<script>
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
    //InitView();
</script>

