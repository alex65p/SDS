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
     <version number="1.0" date="27/01/2004" author="Roman Chumachenko">		
     <comments>
     <comment date="27/01/2004" author="Roman Chumachenko">
     <description>ANA_DTE_View.jsp</description>
     </comment>		
     <comment date="27/03/2004" author="Malyuk Sergey">
     <description>Peredelival view</description>
     </comment>						 
     </comments> 
     </version>
     </versions>
     </file> 
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server

%>
<%@ page import="java.util.*"%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.DittaEsterna.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%    Checker c = new Checker();

        String strRAG_SCL_DTE = c.checkStringEx("Ragione sociale", request.getParameter("RAG_SCL_DTE"), false);
        String strCAG_DTE = c.checkStringEx("Categoria", request.getParameter("CAG_DTE"), false);
        String strIDZ_DTE = c.checkStringEx("Indirizzo", request.getParameter("IDZ_DTE"), false);
        String strNUM_CIC_DTE = c.checkStringEx("Numero Civico", request.getParameter("NUM_CIC_DTE"), false);
        String strCIT_DTE = c.checkStringEx("Citta'", request.getParameter("CIT_DTE"), false);
        String strPRV_DTE = c.checkStringEx("Ppovincia", request.getParameter("PRV_DTE"), false);
        Long lCOD_STA = c.checkLongEx("Stato", request.getParameter("COD_STA"), false);
        String strCAP_DTE = c.checkStringEx("CAP", request.getParameter("CAP_DTE"), false);

        String strQLF_RSP_DTE = c.checkStringEx("Qualifica responcible  S.P.P.", request.getParameter("QLF_RSP_DTE"), false);
        String strNOM_RSP_DTE = c.checkStringEx("Datore di lavoro", request.getParameter("NOM_RSP_DTE"), false);
        String strNOM_RSP_SPP_DTE = c.checkStringEx("Responsable S.P.P.", request.getParameter("NOM_RSP_SPP_DTE"), false);

        java.sql.Date dtDAT_INZ_LAV = c.checkDate("Data inizio lavori", request.getParameter("DAT_INZ_LAV"), false);
        java.sql.Date dtDAT_FIE_LAV = c.checkDate("Data fine lavori", request.getParameter("DAT_FIE_LAV"), false);
        
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
        
        long WHE_AZL = Security.getAzienda();
        IDittaEsternaHome DEHome = (IDittaEsternaHome) PseudoContext.lookup("DittaEsternaBean");
        // Collection col = DEHome.getDittaEsterneByAZLID_View(WHE_AZL);
        Collection col = DEHome.findEx(WHE_AZL,
                strRAG_SCL_DTE,
                strCAG_DTE,
                strIDZ_DTE,
                strNUM_CIC_DTE,
                strCIT_DTE,
                strPRV_DTE,
                lCOD_STA,
                strCAP_DTE,
                strQLF_RSP_DTE,
                strNOM_RSP_DTE,
                strNOM_RSP_SPP_DTE,
                dtDAT_INZ_LAV,
                dtDAT_FIE_LAV, 0);
        Iterator it = col.iterator();
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Ragione.sociale")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Responsabile")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Indirizzo")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero.civico.abbreviazione")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Città")%>&nbsp;</th>
                <!-- Non eliminare, ne spostare di posto, viene utilizzata dalla gestione cantieri - INIZIO -->
                <th style="display: none;">&nbsp;</th>
                <!-- Non eliminare, ne spostare di posto, viene utilizzata dalla gestione cantieri - FINE -->
            </tr>
        </thead>
        <tbody>
            <%
                int i = 1;
                while (it.hasNext()) {
                    DittaEsterneByAZLID_View view = (DittaEsterneByAZLID_View) it.next();
            %>
            <tr class="VIEW_TR" valign="top"	INDEX="<%=view.COD_DTE%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
              
                <td>&nbsp;<%=i++%>&nbsp;</td>
               
                <td>&nbsp;<%=Formatter.format(view.RAG_SCL_DTE)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.NOM_RSP_DTE)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.IDZ_DTE)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.NUM_CIC_DTE)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.CIT_DTE)%>&nbsp;</td>
                <!-- Non eliminare, ne spostare di posto, viene utilizzata dalla gestione cantieri - INIZIO -->
                <td style="display: none;"><%=Formatter.format(view.COD_DTE)%></td>
                <!-- Non eliminare, ne spostare di posto, viene utilizzata dalla gestione cantieri - FINE -->
            </tr>
            <%
                }
            %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                
                <th><input type="text" name="cerca_numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                
                <th><input type="text" name="cerca_Ragione.sociale" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Ragione.sociale")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Responsabile" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Responsabile")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Indirizzo" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Indirizzo")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Numero.civico.abbreviazione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero.civico.abbreviazione")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Città" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Città")%>" class="search_init" /></th>
            </tr>
        </tfoot>        
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }
    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuAzienda, 2));
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_DTE/ANA_DTE_Form.jsp";
        parent.g_Handler.New.Width = "880px";
        parent.g_Handler.New.Height = "650px";
        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_DTE/ANA_DTE_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_DTE/ANA_DTE_Help.jsp";
        
          parent.g_Handler.dataTableOn="Y";
         parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "20%", "aTargets": [1], "sType": "string"} ,
                        {"sWidth": "20%", "aTargets": [2], "sType": "string"} ,
                        {"sWidth": "20%", "aTargets": [3], "sType": "string"} ,
                        {"sWidth": "10%", "aTargets": [4], "sType": "string"},
                        {"sWidth": "20%", "aTargets": [5], "sType": "string"}]   ;
    }
</script>
<script>
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
    //InitView();
</script>
