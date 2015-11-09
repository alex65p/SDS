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
     </comments> 
     </version>
     </versions>
     </file> 
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.SchedeInterventoDPI.*" %>

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
        ISchedeInterventoDPIHome aHome = (ISchedeInterventoDPIHome) PseudoContext.lookup("SchedeInterventoDPIBean");
        ISchedeInterventoDPI SchedeInterventoDPI;
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Identificativo.lotto")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Tipologia.intervento")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.pianificata")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.intervento")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Esito.intervento")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                Checker c = new Checker();
                String strTPL_INR_DPI = c.checkStringEx("Tipologia di Intervento", request.getParameter("TPL_INR_DPI"), false);
                String strATI_INR = c.checkStringEx("Attivita Svolta", request.getParameter("ATI_INR"), false);
                java.sql.Date dtDAT_PIF_INR = c.checkDate("Data Pianificata", request.getParameter("DAT_PIF_INR"), false);
                java.sql.Date dtDAT_INR = c.checkDate("Data Intervento", request.getParameter("DAT_INR"), false);
                String strESI_INR = c.checkStringEx("Esito", request.getParameter("ESI_INR"), false);
                String strPBM_RSC = c.checkStringEx("Problemi Riscontrati", request.getParameter("PBM_RSC"), false);
                String strNOM_RSP_INR = c.checkStringEx("Responsabile Intervento", request.getParameter("NOM_RSP_INR"), false);
                Long COD_LOT_DPI = c.checkLongEx("Identificato", request.getParameter("COD_LOT_DPI"), false);
                long lCOD_LOT_DPI = 0;
                if (COD_LOT_DPI != null) {
                    lCOD_LOT_DPI = COD_LOT_DPI.longValue();
                }

                /*
                 if (c.isError) {
                 String err = c.printErrors();
                 out.println("<script>alert(\"" + err + "\");</script>");
                 return;
                 }
                 */
                long COD_AZL = 0;
                long lCOD_AZL = Security.getAzienda();

                java.util.Collection col_nr = aHome.getfindEx(lCOD_AZL, lCOD_LOT_DPI, dtDAT_PIF_INR, dtDAT_INR, strATI_INR, strNOM_RSP_INR, strPBM_RSC, 1);
                java.util.Iterator it_nr = col_nr.iterator();
                int iCount = 0;
                while (it_nr.hasNext()) {
                    findEx_inr_dpi nr = (findEx_inr_dpi) it_nr.next();
            %>
            <tr 
                class="VIEW_TR" valign="top"
                INDEX="<%=nr.COD_SCH_INR_DPI%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)"
                >
               
                <td>&nbsp;<%=++iCount%>&nbsp;</td>
                <td>&nbsp;<%=nr.IDE_LOT_DPI%>&nbsp;</td>
                <td>&nbsp;<%if (nr.TPL_INR_DPI.equals("M")) {
                        out.print("MANUTENZIONE");
                    } else {
                        out.print("SOSTITUZIONE");
                    }%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(nr.DAT_PIF_INR)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(nr.DAT_INR)%>&nbsp;</td>
                <td>&nbsp;<%if (("P").equals(nr.ESI_INR)) {
                        out.print("POSITIVO");
                    } else {
                        if (("N").equals(nr.ESI_INR)) {
                            out.print("NEGATIVO");
                        }
                    } %>&nbsp;</td>
				
				 
            </tr>
            <%

                }
            %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
              
                <th><input type="text" name="cerca_Identificativo.lotto" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Identificativo.lotto")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Tipologia.intervento" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Tipologia.intervento")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.pianificata" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.pianificata")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.intervento" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.intervento")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Esito.intervento" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Esito.intervento")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuDPI, 2));

        parent.g_Handler.New.URL = "/luna/WEB/Form_SCH_INR_DPI/SCH_INR_DPI_Form.jsp";
        parent.g_Handler.New.Width = 54;
        parent.g_Handler.New.Height = "460px";

        parent.g_Handler.Open = parent.g_Handler.New;

        parent.g_Handler.Delete.URL = "/luna/WEB/Form_SCH_INR_DPI/SCH_INR_DPI_Delete.jsp";
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_SCH_INR_DPI/SCH_INR_DPI_Help.jsp";
          parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "10%", "aTargets": [1], "sType": "string"} ,  
                        {"sWidth": "20%", "aTargets": [2], "sType": "string"} ,
                        {"sWidth": "10%", "aTargets":  [3], "sType": "date-eu"},
                        {"sWidth": "10%", "aTargets":  [4], "sType": "date-eu"},
                        {"sWidth": "40%", "aTargets": [5], "sType": "string"}  ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
