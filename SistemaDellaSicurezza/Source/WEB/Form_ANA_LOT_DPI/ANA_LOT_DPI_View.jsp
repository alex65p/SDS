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
     <version number="1.0" date="15/12/2004" author="Treskina Maria">		
     <comments>
     <comment date="15/12/2004" author="Treskina Maria">
     <description>ANA_LOT_DPI_View.jsp</description>
     </comment>	
     <comment date="27/03/2004" author="Treskina Maria">
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
<%@ page import="com.apconsulting.luna.ejb.LottiDPI.*" %>

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
        long lCOD_AZL = Security.getAzienda();

        Checker c = new Checker();
        Long lCOD_TPL_DPI = c.checkLongEx("TipologiaID", request.getParameter("COD_TIPOLOGIA"), false);
        String strIDE_LOT_DPI = c.checkStringEx("Identivicativo", request.getParameter("IDENTIFICATIVO"), false);
        java.sql.Date dDAT_CSG_LOT = c.checkDate("Data Consegna", request.getParameter("DATA_CONSEGNA"), false);
        Long lQTA_FRT = c.checkLongEx("Fornita", request.getParameter("Q_FORNITA"), false);
        Long lCOD_FOR_AZL = c.checkLongEx("Fornitore ID", request.getParameter("COD_FORNITORE"), false);

        //  long lQTA_AST=c.checkLongEx("Assegnata",request.getParameter("Q_ASSEGNATA"),false);
        //  long lQTA_DSP=c.checkLongEx("Disponibile",request.getParameter("Q_DISPONIBILE"),false);
        if (c.isError) {
            String err = c.printErrors();
            out.println("<script>alert(\"" + err + "\");err=true;</script>");
            return;
        }

        ILottiDPIHome aHome = (ILottiDPIHome) PseudoContext.lookup("LottiDPIBean");
        //  Collection col = aHome.getLottiDPI_IDE_DATA_View(lCOD_AZL);
        Collection col = aHome.findEx(lCOD_AZL, lCOD_TPL_DPI, strIDE_LOT_DPI, dDAT_CSG_LOT, lQTA_FRT, lCOD_FOR_AZL, 0);
        Iterator it = col.iterator();
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
              
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Identificativo")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.consegna")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Quantità.fornita")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Quantità.assegnata")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Quantità.disponibile")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Tipologia.D.P.I.")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                int i = 1;
                while (it.hasNext()) {
                    LottiDPI_IDE_DATA_View view = (LottiDPI_IDE_DATA_View) it.next();
            %>
            <tr class="VIEW_TR" valign="top" INDEX="<%=view.COD_LOT_DPI%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
             
                <td>&nbsp;<%=i++%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.IDE_LOT_DPI)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.DAT_CSG_LOT)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.QTA_FRT)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.QTA_AST)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.QTA_DSP)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.NOM_TPL_DPI)%>&nbsp;</td>
				
				 
            </tr>
            <%
                }
            %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
              
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
               
                <th><input type="text" name="cerca_Identificativo" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Identificativo")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.consegna" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.consegna")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Quantità.fornita" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Quantità.fornita")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Quantità.assegnata" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Quantità.assegnata")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Quantità.disponibile" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Quantità.disponibile")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Tipologia.D.P.I." value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Tipologia.D.P.I.")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuDPI, 1));

        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_LOT_DPI/ANA_LOT_DPI_Form.jsp";
        parent.g_Handler.New.Width = 55;
        parent.g_Handler.New.Height = "545px";
        //  parent.g_Handler.New.Height="530px";

        parent.g_Handler.Open = parent.g_Handler.New;

        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_LOT_DPI/ANA_LOT_DPI_Delete.jsp"; //?ID=32233223
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_LOT_DPI/ANA_LOT_DPI_Help.jsp";
        parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "10%", "aTargets": [1], "sType": "string"} ,  
                        {"sWidth": "10%", "aTargets": [2], "sType": "date-eu"} ,
                        {"sWidth": "10%", "aTargets":  [3], "sType": "string"},
                        {"sWidth": "10%", "aTargets":  [4], "sType": "string"},
                        {"sWidth": "10%", "aTargets": [5], "sType": "string"}, 
                        {"sWidth": "25%", "aTargets": [6], "sType": "date-eu"}  ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
    //  InitView();
</script>
