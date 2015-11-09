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
     <description>Chernovik vieW</description>
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
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.GestioniSezioni.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                Checker c = new Checker();

                IGestioniSezioniHome home = (IGestioniSezioniHome) PseudoContext.lookup("GestioniSezioniBean");
                //  java.util.Collection col = home.getGestioniSezioni_Paragrafo_View();
                String strNOM_ARE = c.checkStringEx("Nome", request.getParameter("NOM_ARE"), true);
                java.util.Collection col = home.findEx(Security.getAzienda(), strNOM_ARE, 0);
                java.util.Iterator it = col.iterator();
                int iCount = 0;
                while (it.hasNext()) {
                    GestioniSezioni_Paragrafo_View obj = (GestioniSezioni_Paragrafo_View) it.next();
            %>		<tr	class="VIEW_TR" valign="top"	INDEX="<%=obj.COD_ARE%>"
                onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                
                <%   
                        out.println("<td>&nbsp;" + ++iCount + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.NOM_ARE) + "&nbsp;</td></tr>");
                 }
                %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
              
                <th><input type="text" name="cerca_Nome" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Nome")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuDVR, 0));

        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_ARE/ANA_ARE_Form.jsp";
        parent.g_Handler.New.Width = "700px";
        parent.g_Handler.New.Height = "480px";

        parent.g_Handler.Open = parent.g_Handler.New;

        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_ARE/ANA_ARE_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_ARE/ANA_ARE_Help.jsp";
         
         parent.g_Handler.dataTableOn="Y";
         parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "90%", "aTargets": [1], "sType": "string"} ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
