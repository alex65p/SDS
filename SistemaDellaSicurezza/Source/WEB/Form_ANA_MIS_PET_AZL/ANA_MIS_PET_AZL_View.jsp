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
     <version number="1.0" date="14/12/2004" author="Artur Denysenko">		
     <comments>
     <comment date="14/12/2004" author="Artur Denysenko">
     <description>Chernovik vieW</description>
     </comment>		
     <comment date="14/12/2004" author="Artur Denysenko">
     <description>API esho ne stabilizirovalos'</description>
     </comment>	
     <comment date="05/04/2004" author="Alexey Kolesnik">
     <description> Added findEx() </description>
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
<%@ page import="com.apconsulting.luna.ejb.MisurePreventProtettiveAz.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        Checker c = new Checker();
        String err = null;

        //  long lCOD_AZL=Security.getAzienda();
        long COD_AZL = c.checkLong("cod_azl", request.getParameter("COD_AZL"), false);
        long ANA_MAN = c.checkLong("ana_man", request.getParameter("ANA_MAN"), false);
        long LUO_FSC = c.checkLong("luo_fsc", request.getParameter("LUO_FSC"), false);
        String NOM_RSO = c.checkStringEx("rischio", request.getParameter("NOM_RSO"), false);
        String STA = c.checkStringEx("sta", request.getParameter("STA"), false);

        Long COD_ANA_MAN = c.checkLongEx("ana_man", request.getParameter("COD_MAN"), false);
        Long COD_LUO_FSC = c.checkLongEx("luo_fsc", request.getParameter("COD_LUO_FSC"), false);
        String NOM_MIS_PET = c.checkStringEx("nom_mis_pet", request.getParameter("NOM_MIS_PET"), false);
        String DES_MIS_PET = c.checkStringEx("des_mis_pet", request.getParameter("DES_MIS_PET"), false);
        Long VER_MIS_PET = c.checkLongEx("ver_mis_pet", request.getParameter("VER_MIS_PET"), false);
        Long COD_TPL_MIS_PET = c.checkLongEx("cod_tpl_mis_pet", request.getParameter("COD_TPL_MIS_PET"), false);
        java.sql.Date DAT_CMP = c.checkDate("date", request.getParameter("DAT_CMP"), false);
        java.sql.Date DAT_PNZ_MIS_PET = c.checkDate("date", request.getParameter("DAT_PNZ_MIS_PET"), false);
        Long PNZ_MIS_PET_MES = c.checkLongEx("pnz_mis_pet", request.getParameter("PNZ_MIS_PET_MES"), false);
        String TPL_DSI_MIS_PET = c.checkStringEx("tpl_mis_pet", request.getParameter("TPL_DSI_MIS_PET"), false);
        
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);

        if (c.isError) {
            err = c.printErrors();
    %><script>alert("<%=err%>");</script><%
            return;
        }

        IMisurePreventProtettiveAz bean = null;
        IMisurePreventProtettiveAzHome home = (IMisurePreventProtettiveAzHome) PseudoContext.lookup("MisurePreventProtettiveAzBean");
        Collection col;
        Iterator it;

        /*
         if (ANA_MAN != 0) {
         col = home.getMisureByAttivitaAndRischiView(COD_AZL, ANA_MAN, STA, NOM_RSO);
         it = col.iterator();
         } else if (LUO_FSC != 0) {
         col = home.getMisureByLuoghiAndRischiView(COD_AZL, LUO_FSC, STA, NOM_RSO);
         it = col.iterator();

         }
         */
        if (ANA_MAN != 0 || LUO_FSC != 0) {
            col = home.findEx(COD_AZL, COD_ANA_MAN, COD_LUO_FSC, STA, NOM_RSO, NOM_MIS_PET, DES_MIS_PET, VER_MIS_PET, COD_TPL_MIS_PET, DAT_CMP, DAT_PNZ_MIS_PET, PNZ_MIS_PET_MES, TPL_DSI_MIS_PET, 0);
            it = col.iterator();
        } else {
            COD_AZL = Security.getAzienda();
            col = home.getMisure_Preventive_ByAzienda_View(COD_AZL);
            it = col.iterator();
            int i = 1;
            //  return;
        }
        //  Collection col = home.getMisure_Preventive_ByAzienda_View(lCOD_AZL);
        //  Iterator it = col.iterator();
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
                <th style="display: none;">lCOD_MIS_PET_AZL</th>
              
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Versione")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                int i = 1;
                if (it != null) {
                    while (it.hasNext()) {
                        MisureByParamsView view = (MisureByParamsView) it.next();
            %>
            <tr 
                class="VIEW_TR" valign="top"
                INDEX="<%=view.lCOD_MIS_PET_AZL%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)"
                >
                <td>&nbsp;<%=i++%>&nbsp;</td>
                <td style="display: none;"><%=view.lCOD_MIS_PET_AZL%></td>
                <td>&nbsp;<%=view.strNOM_MIS_PET_AZL%>&nbsp;</td>
                <td>&nbsp;<%=view.lVER_MIS_PET%>&nbsp;</td>
            </tr>
            <%
                    }
                } else {
                    err = ApplicationConfigurator.LanguageManager.getString("MSG_DATI");
                }%>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr> 
                     <th style="display: none;"><input type="text" name="cerca_lCOD_MIS_PET_AZL" value="Cerca lCOD_MIS_PET_AZL" class="search_init" /></th>
                     <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                  <th><input type="text" name="cerca_Nome" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Nome")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Versione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Versione")%>" class="search_init" /></th>
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
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuStrumenti, 1));
        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_MIS_PET_AZL/ANA_MIS_PET_AZL_Form.jsp";
        parent.g_Handler.New.Width = "850px";
        parent.g_Handler.New.Height = "470px";
        //  parent.g_Handler.New.Height="670px";

        parent.g_Handler.Open = parent.g_Handler.New;
        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_MIS_PET_AZL/ANA_MIS_PET_AZL_Delete.jsp"; //?ID=32233223
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_MIS_PET_AZL/ANA_MIS_PET_AZL_Help.jsp";
           parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "5%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "10%", "aTargets": [1], "sType": "string"} ,  
                        {"sWidth": "40%", "aTargets": [2], "sType": "string"} ,
                         {"sWidth": "40%", "aTargets": [3], "sType": "string"}]   ;
    }

    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
    //  InitView();
</script>
