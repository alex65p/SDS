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
     <version number="1.0" date="22/12/2004" author="Mike Kondratyuk">
     <comments>
     <comment date="22/12/2004" author="Mike Kondratyuk">
     <description>ANA_SIT_AZL_View.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.SediAziendali.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<script type="text/javascript" src="../_scripts/Alert.js"></script>
<div id="divContent">
    <%
        ISitaAziendeHome home = (ISitaAziendeHome) PseudoContext.lookup("SitaAziendeBean");
        ISitaAziende SitaAziende;
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border=0>
        <thead>
            <tr class="VIEW_HEADER_TR">
               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nominativo")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Indirizzo")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero.civico.abbreviazione")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Città")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                long lCOD_AZL = Security.getAzienda();
                Checker c = new Checker();
                String NOM_SIT_AZL = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Identificativo.sito"), request.getParameter("NOM_SIT_AZL"), false);
                String IDZ_SIT_AZL = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Indirizzo"), request.getParameter("IDZ_SIT_AZL"), false);
                String CIT_SIT_AZL = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Città"), request.getParameter("CIT_SIT_AZL"), false);
                String NUM_CIC_SIT_AZL = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Numero.civico"), request.getParameter("NUM_CIC_SIT_AZL"), false);
                String PRV_SIT_AZL = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Provincia"), request.getParameter("PRV_SIT_AZL"), false);
                String CAP_SIT_AZL = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("C.a.p."), request.getParameter("CAP_SIT_AZL"), false);

                if (c.isError) {
                    String err = c.printErrors();
                    out.println("<script>alert(\"" + err + "\");</script>");
                    return;
                }
                Collection col = home.findEx(lCOD_AZL, NOM_SIT_AZL, IDZ_SIT_AZL, NUM_CIC_SIT_AZL, CIT_SIT_AZL, PRV_SIT_AZL, CAP_SIT_AZL, 0);
                Iterator it = col.iterator();

                int iCount = 0;
                while (it.hasNext()) {
                    SiteAziendaleByAZLID_View view = (SiteAziendaleByAZLID_View) it.next();
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=view.COD_SIT_AZL%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                <%
                        iCount++;
                        
                            
                        out.println("<td>" + iCount + "</td><td>&nbsp;" + Formatter.format(view.NOM_SIT_AZL) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(view.IDZ_SIT_AZL) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(view.NUM_CIC_SIT_AZL) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(view.CIT_SIT_AZL) + "&nbsp;</td></tr>");
                  
                   }     
                %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                 
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                
                <th><input type="text" name="cerca_Nominativo" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Nominativo")%>" class="search_init" /></th>
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
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuDistribuzioneTerritorialie, 0));
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_SIT_AZL/ANA_SIT_AZL_Form.jsp";
        parent.g_Handler.New.Width = "800px";
        parent.g_Handler.New.Height = "550px";
        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_SIT_AZL/ANA_SIT_AZL_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_SIT_AZL/ANA_SIT_AZL_Help.jsp";
         parent.g_Handler.dataTableOn="Y";
         parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "7%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "20%", "aTargets": [1], "sType": "string"} ,
                        {"sWidth": "33%", "aTargets": [2], "sType": "string"} ,
                        {"sWidth": "10%", "aTargets": [3], "sType": "string"} ,
                        {"sWidth": "30%", "aTargets": [4], "sType": "string"}]   ;
    }
</script>
<script>
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>

