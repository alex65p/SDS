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
     <version number="1.0" date="06/02/2004" author="Khomenko Juliya">
     <comments>

     <comment date="06/02/2004" author="Khomenko Juliya">
     <description></description>
     </comment>
     <comment date="18/02/2004" author="Mike Kondratyuk">
     <description>Proverka na ID_PARENT</description>
     </comment>
     <comment date="13/03/2004" author="Khomenko Juliya">
     <description>pereveden findAll -> view</description>
     </comment>
     <comment date="27/03/2004" author="Khomenko Juli">
     <description>Transform View</description>
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
<%@ page import="com.apconsulting.luna.ejb.Paragrafo.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<div id="divContent">
    <%
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
             
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                IParagrafoHome home = (IParagrafoHome) PseudoContext.lookup("ParagrafoBean");
                Checker c = new Checker();
                long lCOD_AZL = Security.getAzienda();
                String strNOM_PRG = c.checkStringEx("Titolo", request.getParameter("TITOLO"), false);
                String strDES_PRG = c.checkStringEx("Descrizione", request.getParameter("DESC"), false);
                Long lCOD_ARE = c.checkLongEx("Sezione", request.getParameter("COD_ARE"), false);
                Long lCOD_CPL = c.checkLongEx("Capitolo", request.getParameter("COD_CPL"), false);
                //  Long lCOD_AZL=c.checkLongEx("Azienda",request.getParameter("COD_AZL"),false);
                if (c.isError) {
                    String err = c.printErrors();
                    out.print("<script>alert(\"" + err + "\");</script>");
                    return;
                }
                //  out.print("<script>alert(\""+strDES_PRG+"\");</script>");
                Collection col = home.findEx(lCOD_AZL, strNOM_PRG, strDES_PRG, lCOD_CPL, lCOD_ARE, 0);
                Iterator it = col.iterator();
                int iCount = 0;
                while (it.hasNext()) {
                    Paragrafo_View view = (Paragrafo_View) it.next();
            %>		<tr	class="VIEW_TR" valign="top" INDEX="<%=view.COD_PRG%>"
                onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                
                <%  
                        out.println("<td>&nbsp;" + ++iCount + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(view.NOM_PRG) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(view.DES_PRG) + "&nbsp;</td></tr>");
                 
                }
                %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
               
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
               
                <th><input type="text" name="cerca_Nome" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Nome")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Descrizione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuDVR, 2));

        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_PRG/ANA_PRG_Form.jsp";
        parent.g_Handler.New.Width = "720px";
        parent.g_Handler.New.Height = "585px";

        parent.g_Handler.Open = parent.g_Handler.New;

        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_PRG/ANA_PRG_Delete.jsp"; //?ID=32233223
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_PRG/ANA_PRG_Help.jsp";
         parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "40%", "aTargets": [1], "sType": "string"},
                        {"sWidth": "50%", "aTargets": [2], "sType": "string"}  ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
