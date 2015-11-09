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
     <version number="1.0" date="27/02/2004" author="Alex Kyba">		
     <comments>
     <comment date="27/02/2004" author="Alex Kyba">
     <description>vieW</description>
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
<%@ page import="com.apconsulting.luna.ejb.InterventoAudut.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        Checker c = new Checker();

        Long lCOD_LUO_FSC = c.checkLongEx("COD_LUO_FSC", request.getParameter("COD_LUO_FSC"), false);
        String strDES_INR_ADT = c.checkStringEx("DES_INR_ADT", request.getParameter("DES_INR_ADT"), false);
        Long lPNG_TEO = c.checkLongEx("PNG_TEO", request.getParameter("PNG_TEO"), false);
        Long lPNG_RIL = c.checkLongEx("PNG_RIL", request.getParameter("PNG_RIL"), false);
        Long lNUM_VIS_ISP = c.checkLongEx("NUM_VIS_ISP", request.getParameter("NUM_VIS_ISP"), false);
        java.sql.Date dtDAT_ADT = c.checkDate("DAT_ADT", request.getParameter("DAT_ADT"), false);
        java.sql.Date dtDAT_PIF_INR = c.checkDate("DAT_PIF_INR", request.getParameter("DAT_PIF_INR"), false);
        Long lPNG_PCT = c.checkLongEx("PNG_PCT", request.getParameter("PNG_PCT"), false);

        Long lCOD_DPD = c.checkLongEx("COD Dipendente", request.getParameter("COD_DPD"), false);
        String strCOG_DPD = c.checkStringEx("Cognome Dipendente", request.getParameter("COG_DPD"), false);
        String strNOM_DPD = c.checkStringEx("Nome Dipendente", request.getParameter("NOM_DPD"), false);
        String strMTR_DPD = c.checkStringEx("Matricola", request.getParameter("MTR_DPD"), false);

        String strINR_ADT_AZL = "S";
        String strNOM_MIS_PET = c.checkStringEx("Misura", request.getParameter("NOM_MIS_PET"), false);
        String strRB_LUO_FSC_MAN = c.checkString("Dati Misura di Prevenzione Applicata a", request.getParameter("RB_LUO_FSC_MAN"), false);

        if (c.isError) {
            String err = c.printErrors();
            out.print("< script>err=true;alert(\"" + err + "\");< /script>");
            return;
        }

        String err = null;
        long lCOD_AZL = 0;

        if (c.isError) {
            err = c.printErrors();
    %><script>alert("<%=err%>");</script><%
            return;
        }

        IInterventoAudut bean = null;
        IInterventoAudutHome home = (IInterventoAudutHome) PseudoContext.lookup("InterventoAudutBean");

        Collection col;
        Iterator it;

        lCOD_AZL = Security.getAzienda();
        //  col = home.getInterventoAuditView(lCOD_AZL);
        col = home.findEx(lCOD_AZL, lCOD_LUO_FSC, strDES_INR_ADT, lPNG_TEO, lPNG_RIL, lNUM_VIS_ISP, dtDAT_ADT, dtDAT_PIF_INR, lPNG_PCT, lCOD_DPD, strCOG_DPD, strNOM_DPD, strMTR_DPD, strINR_ADT_AZL, strNOM_MIS_PET, strRB_LUO_FSC_MAN, 0);
        it = col.iterator();
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.intervento")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.audit")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                int i = 1;
                if (it != null) {
                    while (it.hasNext()) {
                        InterventoAuditView view = (InterventoAuditView) it.next();
            %>
            <tr  class="VIEW_TR" valign="top" INDEX="<%=Formatter.format(view.lCOD_INR_ADT)%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)" >
             
                <td>&nbsp;<%=i++%>&nbsp;</td>
             
                <td>&nbsp;<%= Formatter.format(view.dtDAT_PIF_INR) %>&nbsp;</td>
                <td>&nbsp;<%= Formatter.format(view.dtDAT_ADT) %>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.strDES_INR_ADT)%>&nbsp;</td>
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
                
                <th><input type="text" name="cerca_Data.intervento" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.intervento")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.audit" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.audit")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Descrizione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    <% if (err != null) {%>
    alert("<%=err%>");
    <%	}%>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }

    function OnViewLoad() {
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_INR_ADT/ANA_INR_ADT_Form.jsp";
        parent.g_Handler.New.Width = "850px";
        parent.g_Handler.New.Height = "685px";
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuVerificheSPP, 0));
        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_INR_ADT/ANA_INR_ADT_Delete.jsp"; //?ID=32233223
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_INR_ADT/ANA_INR_ADT_Help.jsp";
          parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "20%", "aTargets": [1], "sType": "date-eu"},
                        {"sWidth": "20%", "aTargets": [2], "sType": "date-eu"} ,
                        {"sWidth": "50%", "aTargets": [3], "sType": "string"}  ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
