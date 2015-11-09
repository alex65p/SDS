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
     <version number="1.0" date="24/01/2004" author="Malyuk Sergey">
     <comments>
     <comment date="24/01/2004" author="Malyuk Sergey">
     <description></description>
     </comment>
     <comment date="29/01/2004" author="Mike Kondratyuk">
     <description>Peredelal na FindEX()</description>
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
<%@ page import="com.apconsulting.luna.ejb.GestioneVisiteIdoneita.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<div id="divContent">
    <%
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table border="0" class="VIEW_TABLE">
        <thead>
            <tr class="VIEW_HEADER_TR">
               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
              
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Periodicità")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                Checker c = new Checker();

                long lCOD_AZL = Security.getAzienda();
                String strNOM_VST_IDO = c.checkStringEx("Nome Visita", request.getParameter("NOM_VST_IDO"), false);
                String strDES_VST_IDO = c.checkStringEx("Descrizione", request.getParameter("DES_VST_IDO"), false);
                Long lPER_VST = c.checkLongEx("Periodicita Visita", request.getParameter("PER_VST"), false);

                if (c.isError) {
                    String err = c.printErrors();
                    out.println("<script>alert(\"" + err + "\");</script>");
                    return;
                }

                IGestioneVisiteIdoneitaHome home = (IGestioneVisiteIdoneitaHome) PseudoContext.lookup("GestioneVisiteIdoneitaBean");
                IGestioneVisiteIdoneita GestioneVisiteIdoneita = null;
                java.util.Collection col = home.findEx(lCOD_AZL, strNOM_VST_IDO, strDES_VST_IDO, lPER_VST, 0);
                String Per = "";
                java.util.Iterator it = col.iterator();
                int nCount = 0;
                while (it.hasNext()) {
                    VisiteIdoneita_All_View obj = (VisiteIdoneita_All_View) it.next();
            %><tr class="VIEW_TR" valign="top" INDEX="<%=obj.COD_VST_IDO%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                <%
                        if (obj.FAT_PER.equals("U")) {
                            Per = ApplicationConfigurator.LanguageManager.getString("Unica");
                        }
                        if (obj.FAT_PER.equals("M")) {
                            if ((obj.PER_VST == null) | (Integer.parseInt(obj.PER_VST) == 0)) {
                                Per = ApplicationConfigurator.LanguageManager.getString("Ogni.mese");
                            } else {
                                if (Integer.parseInt(obj.PER_VST) == 1) {
                                    Per = ApplicationConfigurator.LanguageManager.getString("Ogni.mese");
                                } else {
                                    Per = ApplicationConfigurator.LanguageManager.getString("Ogni") + " " + Formatter.format(obj.PER_VST) + " " + ApplicationConfigurator.LanguageManager.getString("mesi");
                                }
                            }
                        }
                       
                        out.println("<td>&nbsp;" + ++nCount + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.NOM_VST_IDO) + "&nbsp;</td><td>&nbsp;"
                                + Per + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.DES_VST_IDO) + "&nbsp;</td></tr>");
                    
                       
                        
                      }
                %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
               
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
               
                <th><input type="text" name="cerca_Nome" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Nome")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Periodicità" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Periodicità")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Descrizione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0031"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuVerificheSanitarie, 1));
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_VST_IDO/ANA_VST_IDO_Form.jsp";
        parent.g_Handler.New.Width = 48;
        parent.g_Handler.New.Height = 19;
        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_VST_IDO/ANA_VST_IDO_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_VST_IDO/ANA_VST_IDO_Help.jsp";
        parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "30%", "aTargets": [1], "sType": "string"} ,  
                        {"sWidth": "20%", "aTargets": [2], "sType": "string"} ,
                        {"sWidth": "40%", "aTargets":  [3], "sType": "string"}  ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
