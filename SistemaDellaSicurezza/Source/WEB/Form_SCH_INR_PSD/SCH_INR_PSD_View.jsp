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
     <version number="1.0" date="24/01/2004" author="Kushkarov Yura">		
     <comments>
     <comment date="24/01/2004" author="Kushkarov Yura">
     <description>Chernovik vieW</description>
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
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.SchedeInterventoPSD.*" %>

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
        String strTPL_INR_PSD = c.checkStringEx("Tipologia", request.getParameter("TPL_INR_PSD"), false);
        Long lCOD_PSD_ACD = c.checkLongEx("Presidio", request.getParameter("COD_PSD_ACD"), false);
        String strATI_SVO = c.checkStringEx("ATI_SVO", request.getParameter("ATI_SVO"), false);
        java.sql.Date dtDAT_INR = c.checkDate("DAT_INR", request.getParameter("DAT_INR"), false);
        java.sql.Date dtDAT_PIF_INR = c.checkDate("Data Pianificata", request.getParameter("DAT_PIF_INR"), false);
        String strNOM_RSP_INR = c.checkStringEx("NOM_RSP_INR", request.getParameter("NOM_RSP_INR"), false);

        if (c.isError) {
            String err = c.printErrors();
            out.println("<script>alert(\"" + err + "\");</script>");
            return;
        }

        ISchedeInterventoPSDHome home = (ISchedeInterventoPSDHome) PseudoContext.lookup("SchedeInterventoPSDBean");
        ISchedeInterventoPSD SchedeInterventoPSD;
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Identificativo")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Categoria")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Luogo")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.intervento")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Responsabile")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                //  java.util.Collection col = home.getSchedeInterventoPSD_ForView_View();
                java.util.Collection col = home.findEx(strTPL_INR_PSD, lCOD_PSD_ACD, strATI_SVO, dtDAT_INR, dtDAT_PIF_INR, strNOM_RSP_INR, 0);
                java.util.Iterator it = col.iterator();
                int iCount = 0;
                while (it.hasNext()) {
                    SchedeInterventoPSD_ForView_View rst = (SchedeInterventoPSD_ForView_View) it.next();
                    long var1 = rst.COD_SCH_INR_PSD;
            %>
            <tr 
                class="VIEW_TR" valign="top"
                INDEX="<%=var1%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)"
                >
             
                <td>&nbsp;<%=++iCount%>&nbsp;</td>
                
                <td>&nbsp;<%=Formatter.format(rst.IDE_PSD_ACD)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(rst.NOM_CAG_PSD_ACD)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(rst.NOM_LUO_FSC)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(rst.DAT_INR)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(rst.NOM_RSP_INR)%>&nbsp;</td>
            </tr>
            <%
                }
            %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
             
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
              
                <th><input type="text" name="cerca_Identificativo" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Identificativo")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Categoria" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Categoria")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Luogo" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Luogo")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.intervento" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.intervento")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Responsabile" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Responsabile")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuPresidi, 2));

        parent.g_Handler.New.URL = "/luna/WEB/Form_SCH_INR_PSD/SCH_INR_PSD_Form.jsp";
        parent.g_Handler.New.Width = 54;
        parent.g_Handler.New.Height = 35;

        parent.g_Handler.Open = parent.g_Handler.New;

        parent.g_Handler.Delete.URL = "/luna/WEB/Form_SCH_INR_PSD/SCH_INR_PSD_Delete.jsp"; //?ID=32233223
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_SCH_INR_PSD/SCH_INR_PSD_Help.jsp";
        parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "10%", "aTargets": [1], "sType": "string"},
                        {"sWidth": "30%", "aTargets": [2], "sType": "string"} ,
                        {"sWidth": "20%", "aTargets": [3], "sType": "string"},
                        {"sWidth": "10%", "aTargets": [4], "sType": "date-eu"},
                        {"sWidth": "20%", "aTargets": [5], "sType": "string"} ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
    //  InitView();
</script>
