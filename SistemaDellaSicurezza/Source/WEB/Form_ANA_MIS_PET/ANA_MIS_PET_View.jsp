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
     <version number="1.0" date="05/02/2004" author="Alex Kyba">		
     <comments>
     <comment date="05/02/2004" author="Alex Kyba">
     <description>Chernovik vieW</description>
     </comment>		
     <comment date="27/01/2004" author="Mike Kondratyuk">
     <description>Peredelal na FindEX()</description>
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
<%@ page import="com.apconsulting.luna.ejb.MisuraPreventiva.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_include/Checker.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        Checker c = new Checker();
        String err = null;
        String FORM_PER_MIS_PET = request.getParameter("FORM_PER_MIS_PET");
        String strPER_MIS_PET = null;
        if (("1").equals(FORM_PER_MIS_PET)) {
            strPER_MIS_PET = c.checkTrigger("PER_MIS_PET", request.getParameter("PER_MIS_PET"));
        } else {
            strPER_MIS_PET = request.getParameter("PER_MIS_PET");
        }
        java.sql.Date dtDAT_PNZ_MIS_PET = c.checkDate("DAT_PNZ_MIS_PET", request.getParameter("DAT_PNZ_MIS_PET"), false);
        String strNOM_MIS_PET = c.checkStringEx("Misura", request.getParameter("NOM_MIS_PET"), false);
        java.sql.Date dtDAT_CMP = c.checkDate("DAT_CMP", request.getParameter("DAT_CMP"), false);
        Long lVER_MIS_PET = c.checkLongEx("VER_MIS_PET", request.getParameter("VER_MIS_PET"), false);
        String strIST_OPE_COR = c.checkStringEx("Istruzioni.Operative.correlate", request.getParameter("IST_OPE_COR"), false);
        java.sql.Date dtDAT_PAR_ADT = c.checkDate("DAT_PAR_ADT", request.getParameter("DAT_PAR_ADT"), false);
        Long lPNZ_MIS_PET_MES = c.checkLongEx("PNZ_MIS_PET_MES", request.getParameter("PNZ_MIS_PET_MES"), false);
        String strDES_MIS_PET = c.checkStringEx("DES_MIS_PET", request.getParameter("DES_MIS_PET"), false);
        String strTPL_DSI_MIS_PET = c.checkStringEx("TPL_DSI_MIS_PET", request.getParameter("TPL_DSI_MIS_PET"), false);

        //  long lCOD_AZL=Security.getAzienda();
        long COD_AZL = c.checkLong("cod_azl", request.getParameter("COD_AZL"), false);
        String NOM_RSO = c.checkString("rischio", request.getParameter("NOM_RSP"), false);
        String STA = c.checkString("sta", request.getParameter("STA"), false);
        
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);

        if (c.isError) {
            err = c.printErrors();
    %><script>alert("<%=err%>");</script><%
            return;
        }

        IMisuraPreventiva bean = null;
        IMisuraPreventivaHome home = (IMisuraPreventivaHome) PseudoContext.lookup("MisuraPreventivaBean");
        Collection col;
        Iterator it;

        COD_AZL = Security.getAzienda();
        //  col = home.getMisure_Preventive_ByAzienda_View(COD_AZL);
        col = home.findEx(COD_AZL, strPER_MIS_PET, dtDAT_PNZ_MIS_PET,
                strNOM_MIS_PET, dtDAT_CMP,
                lVER_MIS_PET, strIST_OPE_COR, dtDAT_PAR_ADT,
                lPNZ_MIS_PET_MES, strDES_MIS_PET,
                strTPL_DSI_MIS_PET, 0);
        it = col.iterator();
        
        String destinazione= "/luna/WEB/Form_ANA_MIS_PET/ANA_MIS_PET_Form.jsp"; 

        if (ifMsr) {
        destinazione =  "/luna/WEB/Form_ANA_MIS_PET/ANA_MIS_PET_Form_MSR.jsp";
        
        }
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                <th style="display: none;">lCOD_MIS_PET</th>
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.compilazione")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Versione")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Periodicità")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                int i = 1;
                if (it != null) {
                    while (it.hasNext()) {
                        Misure_Preventive_ByAzienda_View view = (Misure_Preventive_ByAzienda_View) it.next();
            %>
             <tr class="VIEW_TR" valign="top" INDEX="<%=view.lCOD_MIS_PET%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                <td>&nbsp;<%=i++%>&nbsp;</td>
                <td style="display: none;"><%=view.lCOD_MIS_PET%></td> 
                <td>&nbsp;<%=Formatter.format(view.strNOM_MIS_PET)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.dtDAT_CMP)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.lVER_MIS_PET)%>&nbsp;</td>
                <td>&nbsp;<%if (("S").equals(view.strPER_MIS_PET)) {
                        out.print("Si");
                    } else {
                        out.print("No");
                    }%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.dtDAT_PNZ_MIS_PET)%>&nbsp;</td>
 				
            </tr>
            <%
                    }
                } else {
                    err = ApplicationConfigurator.LanguageManager.getString("MSG_DATI");
                }
            %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
               <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                <th style="display: none;"><input type="text" name="cerca_lCOD_MIS_PET" value="Cerca lCOD_MIS_PET" class="search_init" /></th>
                <th><input type="text" name="cerca_Misura.di.prevenzione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.compilazione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.compilazione")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Versione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Versione")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Periodicità" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Periodicità")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.pianificazione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    <% if (err != null) {%>
    alert("<%=err%>");
    <%	} %>

    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuStrumenti, 0));
        parent.g_Handler.New.URL = "<%=destinazione%>";//"/luna/WEB/Form_ANA_MIS_PET/ANA_MIS_PET_Form.jsp";
        parent.g_Handler.New.Width = "850px";
        parent.g_Handler.New.Height = "550px";
        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_MIS_PET/ANA_MIS_PET_Delete.jsp"; //?ID=32233223
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_MIS_PET/ANA_MIS_PET_Help.jsp";
         parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "5%", "aTargets": [1], "sType": "string"} ,  
                        {"sWidth": "35%", "aTargets": [2], "sType": "string"} ,
                        {"sWidth": "10%", "aTargets":  [3], "sType": "date-eu"},
                        {"sWidth": "10%", "aTargets":  [4], "sType": "string"},
                        {"sWidth": "10%", "aTargets": [5], "sType": "string"}, 
                        {"sWidth": "10%", "aTargets": [6], "sType": "date-eu"}  ]   ;
    }

    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
    <%if (Security.isExtendedMode()) {%>
    parent.g_Handler.Delete.getButton().disabled = true;
    <%}%>
</script>


