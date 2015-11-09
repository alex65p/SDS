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
     <version number="1.0" date="25/01/2004" author="Alexey Kolesnik">		
     <comments>

     <comment date="25/01/2004" author="Alexey Kolesnik">
     <description> Initial template </description>
     </comment>		
     <comment date="31/01/2004" author="Alexey Kolesnik">
     <description> Added new toolbar </description>
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

<%@ page import="com.apconsulting.luna.ejb.NormativeSentenze.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        Checker c = new Checker();

        java.sql.Date DAT_NOR_SEN = c.checkDate("Data", request.getParameter("DAT_NOR_SEN"), false);
        String NUM_DOC_NOR_SEN = c.checkStringEx("NUM_DOC_NOR_SEN", request.getParameter("NUM_DOC_NOR_SEN"), false);
        String TIT_NOR_SEN = c.checkStringEx("Titolo", request.getParameter("TIT_NOR_SEN"), false);
        String FON_NOR_SEN = c.checkStringEx("FON_NOR_SEN", request.getParameter("FON_NOR_SEN"), false);
        String DES_NOR_SEN = c.checkStringEx("Descrizione", request.getParameter("DES_NOR_SEN"), false);
        Long COD_ORN = c.checkLongEx("Organo", request.getParameter("COD_ORN"), false);
        Long COD_SET = c.checkLongEx("Settore", request.getParameter("COD_SET"), false);
        Long COD_TPL_NOR_SEN = c.checkLongEx("Tipologia", request.getParameter("COD_TPL_NOR_SEN"), false);
        Long COD_SOT_SET = c.checkLongEx("Sottosettore", request.getParameter("COD_SOT_SET"), false);

        if (c.isError) {
            out.println("<script>alert(\"" + c.printErrors() + "\");</script>");
            return;
        }

        INormativeSentenzeHome dHome = (INormativeSentenzeHome) PseudoContext.lookup("NormativeSentenzeBean");

        //  getNormativeSentenze_List_View();
        Collection col = dHome.findEx(TIT_NOR_SEN, DES_NOR_SEN, DAT_NOR_SEN, COD_ORN, COD_SET, COD_TPL_NOR_SEN,
                COD_SOT_SET, NUM_DOC_NOR_SEN, FON_NOR_SEN, 2);

        Iterator it = col.iterator();
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome.normativa/sentenza")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                int i = 1;
                while (it.hasNext()) {
                    NormativeSentenze_List_View view = (NormativeSentenze_List_View) it.next();
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=view.COD_NOR_SEN%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                 
                <td>&nbsp;<%=i++%>&nbsp;</td>
              
                <td>&nbsp;<%=view.TIT_NOR_SEN%>&nbsp;</td>
            </tr>
            <%
                }
            %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                
                <th><input type="text" name="cerca_Nome.normativa/sentenza" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Nome.normativa/sentenza")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0024"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuNormative, 4));

        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_NOR_SEN/ANA_NOR_SEN_Form.jsp";
        parent.g_Handler.New.Width = 50;
        //  parent.g_Handler.New.Height=33;
        parent.g_Handler.New.Height = 22;

        parent.g_Handler.Open = parent.g_Handler.New;

        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_NOR_SEN/ANA_NOR_SEN_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_NOR_SEN/ANA_NOR_SEN_Help.jsp";
          parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "90%", "aTargets": [1], "sType": "string"}  ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
