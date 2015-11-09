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
     <version number="1.0" date="30/12/2004" author="Khomenko Juliya">		
     <comments>
     <comment date="30/12/2004" author="Khomenko Juliya">
     <description>Chernovik vieW</description>
     </comment>		
     <comment date="01/03/2004" author="Alex Kyba">
     <description>
     peredelan vyvod view
     dobavlena obrabotka  usloviya vyzova lista iz ANA_INR_ADT
     </description>
     </comment>
     <comment date="29/03/2004" author="Treskina Maria">
     <description>Search</description>
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
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ page import="com.apconsulting.luna.ejb.Presidi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        Checker c = new Checker();

        java.sql.Date dtDAT_ULT_CTL = c.checkDate("Data Ultimo Controllo", request.getParameter("DATA"), false);
        String strIDE_PSD_ACD = c.checkStringEx("Identificatore", request.getParameter("IDENTIFICATORE"), false);
        String strESI_ULT_CTL = c.checkStringEx("Esito Ultimo Controllo", request.getParameter("ESITO"), false);
        Long lCOD_CAG_PSD_ACD = c.checkLongEx("Categoria Prisidi", request.getParameter("CATEGORIA"), false);

        String strNOM_CAG_PSD_ACD = c.checkStringEx("Nome Categoria Presidi", request.getParameter("NOM_CAG_PSD_ACD"), false);
        Long lCOD_LUO_FSC = null;
        if (request.getParameter("COD_LUO_FSC") == null) {
            lCOD_LUO_FSC = c.checkLongEx("Luogo Fisico", request.getParameter("LUOGO"), false);
        } else {
            lCOD_LUO_FSC = c.checkLongEx("Luogo Fisico", request.getParameter("COD_LUO_FSC"), false);
        }

        if (c.isError) {
            String err = c.printErrors();
            out.print("<script>alert(\"" + err + "\");</script>");
            return;
        }

        IPresidiHome home = (IPresidiHome) PseudoContext.lookup("PresidiBean");
        IPresidi Presidi;
        java.util.Collection col;
        java.util.Iterator it;
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
              
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Categoria.presidio.antincendio")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Identificativo")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Ultimo.controllo")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Esito.controllo")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                col = home.findEx(dtDAT_ULT_CTL, strIDE_PSD_ACD, strESI_ULT_CTL, lCOD_CAG_PSD_ACD, lCOD_LUO_FSC, 0);
                it = col.iterator();
                int iCount = 1;
                while (it.hasNext()) {
                    PresidioView p = (PresidioView) it.next();
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=p.lCOD_PSD_ACD%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
               
                <td><%=iCount++%></td>
               
                <%
                        out.println("<td>&nbsp;" + Formatter.format(p.strNOM_CAG_PSD_ACD) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(p.strIDE_PSD_ACD) + "&nbsp;</td>");
                        if (request.getParameter("COD_LUO_FSC") == null) {
                            out.println("<td>&nbsp;" + Formatter.format(p.dtDAT_ULT_CTL) + "&nbsp;</td><td>&nbsp;"
                                    + Formatter.format(p.strESI_ULT_CTL) + "&nbsp;</td></tr>");
                        }
                    }
                %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
              
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
               
                <th><input type="text" name="cerca_Categoria.presidio.antincendio" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Categoria.presidio.antincendio")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Identificativo" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Identificativo")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Ultimo.controllo" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Ultimo.controllo")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Esito.controllo" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Esito.controllo")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuPresidi, 1));
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_PSD_ACD/ANA_PSD_ACD_Form.jsp";
        parent.g_Handler.New.Width = 48;
        parent.g_Handler.New.Height = 30;
        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_PSD_ACD/ANA_PSD_ACD_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_PSD_ACD/ANA_PSD_ACD_Help.jsp";
        parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "30%", "aTargets": [1], "sType": "string"},
                        {"sWidth": "20%", "aTargets": [2], "sType": "string"},
                        {"sWidth": "20%", "aTargets": [3], "sType": "string"},
                        {"sWidth": "20%", "aTargets": [4], "sType": "string"}  ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
