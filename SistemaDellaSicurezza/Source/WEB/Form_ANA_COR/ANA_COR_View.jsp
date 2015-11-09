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
     <version number="1.0" date="21/01/2004" author="Pogrebnoy Yura">		
     <comments>
     <comment date="21/01/2004" author="Pogrebnoy Yura">
     <description>Chernovik vieW</description>
     </comment>		
     <comment date="29/03/2004" author="Khomenko Juli">
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
<%@ page import="com.apconsulting.luna.ejb.Corsi.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        Checker c = new Checker();
        Long lDUR_COR_GOR = c.checkLongEx("Durata Corso", request.getParameter("DUR_COR_GOR"), false);
        String strNOM_COR = c.checkStringEx("Nome Corso", request.getParameter("NOM_COR"), false);
        String strDES_COR = c.checkStringEx("Descrizione Corso", request.getParameter("DES_COR"), false);
        //  Long lCOD_TPL_COR=c.checkLongEx("Tipologia Corso",request.getParameter("COD_TPL_COR"),true);

        if (c.isError) {
            String err = c.printErrors();
            out.print("<script>alert(\"" + err + "\");</script>");
            return;
        }

        ICorsiHome aHome = (ICorsiHome) PseudoContext.lookup("CorsiBean");
        ICorsi Corsi;
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
              
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Frequenza")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Punteggio")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Durata")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                java.util.Collection col = aHome.findEx(lDUR_COR_GOR, strNOM_COR, strDES_COR, 0);
                java.util.Iterator it = col.iterator();
                String FRQ = "", PTG = "";
                int iCount = 0;
                while (it.hasNext()) {
                    Corsi_All_View obj = (Corsi_All_View) it.next();
                    if (obj.USO_ATE_FRE_COR != null) {
                        if (obj.USO_ATE_FRE_COR.equals("S")) {
                            FRQ = "Si";
                        } else {
                            FRQ = "No";
                        }
                    }
                    if (obj.USO_PTG_COR != null) {
                        if (obj.USO_PTG_COR.equals("S")) {
                            PTG = "Si";
                        } else {
                            PTG = "No";
                        }
                    }
            %>
            <tr	class="VIEW_TR" valign="top" INDEX="<%=obj.COD_COR%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                
                <%  
                        out.print("<td>&nbsp;" + ++iCount + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.NOM_COR) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(FRQ) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(PTG) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.DUR_COR_COG) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.DES_COR) + "&nbsp;</td></tr>");
              
                    }
                %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
              
                <th><input type="text" name="cerca_Nome" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Nome")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Frequenza" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Frequenza")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Punteggio" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Punteggio")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Durata" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Durata")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Descrizione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0018"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuCorsi, 1));

        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_COR/ANA_COR_Form.jsp";
        parent.g_Handler.New.Width = "760px";
        parent.g_Handler.New.Height = "300px";
        //  parent.g_Handler.New.Height = "535px";

        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_COR/ANA_COR_Delete.jsp"; //?ID=32233223
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_COR/ANA_COR_Help.jsp";
         parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "30%", "aTargets": [1], "sType": "string"} ,  
                        {"sWidth": "10%", "aTargets": [2], "sType": "string"} ,
                        {"sWidth": "10%", "aTargets":  [3], "sType": "string"},
                        {"sWidth": "10%", "aTargets":  [4], "sType": "string"},
                        {"sWidth": "30%", "aTargets": [5], "sType": "string"}  ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
    //  InitView();
</script>
