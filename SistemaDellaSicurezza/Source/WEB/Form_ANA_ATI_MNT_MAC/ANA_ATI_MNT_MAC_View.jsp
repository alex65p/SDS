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
     <version number="1.0" date="14/01/2004" author="Mike Kondratyuk">		
     <comments>
     <comment date="16/02/2004" author="Alex Kyba">
     <description>
     Dobavil ogranichenie po COD_MAC, esli on prihodit v url (to est' esli forma ANA_ATI_MNT_MAC
     vyzuvaetsia s formy ANA_MAC)
     </description>
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
<%@ page import="com.apconsulting.luna.ejb.AttivaManutenzione.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        String Descrizione_macchina_attrezzatura
                = ApplicationConfigurator.LanguageManager.getString(
                        ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                        ? "Descrizione.macchina.attrezzatura.impianto"
                        : "Descrizione.macchina.attrezzatura");

        Checker c = new Checker();

        //- checking for required fields
        String strDES_ATI_MNT_MAC = c.checkStringEx("Descrizione Attivita", request.getParameter("DES_ATI_MNT_MAC"), false);
        Long lCOD_MAC = c.checkLongEx(Descrizione_macchina_attrezzatura, request.getParameter("COD_MAC"), false);
        java.sql.Date DAT_PAR_MNT_MAC = c.checkDate("Data di Partenza", request.getParameter("DAT_PAR_MNT_MAC"), false);
        Long lPER_ATI_MNT_MES = c.checkLongEx("Periiodicita Mensite", request.getParameter("PER_ATI_MNT_MES"), false);
        String strATI_MNT_PER = c.checkStringEx("Attivita Periodica", request.getParameter("ATI_MNT_PER"), false);
        //out.print(strATI_MNT_PER);

        /*
         if (request.getParameter("COD_MNT_MAC") != null) {
         if (!"S%".equals(strATI_MNT_PER)) {
         strATI_MNT_PER = "N";
         }
         }
         */
        if (c.isError) {
            String err = c.printErrors();
            out.println("<script>alert(\"" + err + "\");</script>");
            return;
        }

        String strCOD_MAC = "";
        boolean isCOD_MAC = false;

        if ("ATT_MNT".equals(request.getParameter("ATTACH_SUBJECT"))) {
            lCOD_MAC = c.checkLongEx(Descrizione_macchina_attrezzatura, request.getParameter("ID_PARENT"), false);
        }

        IAttivaManutenzioneHome aHome = (IAttivaManutenzioneHome) PseudoContext.lookup("AttivaManutenzioneBean");
        Collection col;
        Iterator it;

        /*
         if (!isCOD_MAC) {
         col = aHome.getAttivaManutenzione_UserID_View();
         } //-- esli forma vyzvana iz ANA_MAC vybiraem vse activnosti, sootvetstvuyuschgie dannoy mashine---
         else {
         long lCOD_MAC = (new Long(strCOD_MAC)).longValue();
         col = aHome.getAttivaManutenzioneByMacchina(lCOD_MAC);
         }
         */
        col = aHome.findEx(strDES_ATI_MNT_MAC,
                lCOD_MAC,
                DAT_PAR_MNT_MAC,
                lPER_ATI_MNT_MES,
                strATI_MNT_PER, 0);
        it = col.iterator();
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
             
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione.attività")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Manutenzione.mensile")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Manutenzione.periodica")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.partenza")%>&nbsp;</th>
                <th>&nbsp;<%=Descrizione_macchina_attrezzatura%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                int i = 1;
                while (it.hasNext()) {
                    AttivaManutenzione_UserID_View view = (AttivaManutenzione_UserID_View) it.next();
            %>
            <tr 
                class="VIEW_TR" valign="top"
                INDEX="<%=Formatter.format(view.COD_MNT_MAC)%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)"
                >
               
                <td>&nbsp;<%=i++%>&nbsp;</td>
              
                <td>&nbsp;<%=Formatter.format(view.DES_ATI_MNT_MAC)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.strPER_ATI_MNT_MES)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.strNB_ATI_MNT_PER)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.dtDAT_PAR_MNT_MAC)%>&nbsp;</td>
                <td>&nbsp;<%=Formatter.format(view.strDES_MAC)%>&nbsp;</td>
            </tr>
            <%
                }
            %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
              
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
               
                <th><input type="text" name="cerca_Descrizione.attività" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Descrizione.attività")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Manutenzione.mensile" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Manutenzione.mensile")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Manutenzione.periodica" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Manutenzione.periodica")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.partenza" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.partenza")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Descrizione_macchina_attrezzatura" value="Cerca <%=Descrizione_macchina_attrezzatura%>" class="search_init" /></th>
            </tr>
        </tfoot>        
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0017"]);
    }
    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuMacchinari, 2));

        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_ATI_MNT_MAC/ANA_ATI_MNT_MAC_Form.jsp";
        parent.g_Handler.New.Width = 55;
        parent.g_Handler.New.Height = "300px";
        //  parent.g_Handler.New.Height="470px";

        parent.g_Handler.Open = parent.g_Handler.New;

        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_ATI_MNT_MAC/ANA_ATI_MNT_MAC_Delete.jsp"; //?ID=32233223
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_ATI_MNT_MAC/ANA_ATI_MNT_MAC_Help.jsp";
         parent.g_Handler.dataTableOn="Y";
         parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "7%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "23%", "aTargets": [1], "sType": "string"},
                     {"sWidth": "7%", "aTargets": [2], "sType": "string"},
                  {"sWidth": "7%", "aTargets": [3], "sType": "date-eu"},
               {"sWidth": "10%", "aTargets": [4], "sType": "string"} ,
            {"sWidth": "26%", "aTargets": [5], "sType": "string"} ]   ;
    }

    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
    //InitView();
</script>


