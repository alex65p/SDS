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
     <version number="1.0" date="26/12/2004" author="Khomenko Juliya">		
     <comments>
     <comment date="26/12/2004" author="Khomenko Juliya">
     <description></description>
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
<%@ page import="com.apconsulting.luna.ejb.ValutazioneRischi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<div id="divContent">
    <%
        Checker c = new Checker();

        java.sql.Date dtDAT_DOC_VLU = c.checkDate("Data Documento", request.getParameter("DAT_DOC_VLU"), false);
        String strNOM_RSP_DOC = c.checkStringEx("NOM_RSP_DOC", request.getParameter("NOM_RSP_DOC"), false);
        String strVER_DOC = c.checkStringEx("Versione", request.getParameter("VER_DOC"), false);
        long lCOD_UNI_ORG = c.checkLong("COD_UNI_ORG", request.getParameter("COD_UNI_ORG"), false);

        if (c.isError) {
            String err = c.printErrors();
            out.print("<script>alert(\"" + err + "\");</script>");
            return;
        }

        if (request.getParameter("MENU") != null) {
            Security.setCurrentDvrUniOrg(null);
            Security.setCurrentDvrUniOrgName(null);
        }

        long lCOD_AZL = Security.getAzienda();
        IValutazioneRischiHome home = (IValutazioneRischiHome) PseudoContext.lookup("ValutazioneRischiBean");
        IValutazioneRischi ValutazioneRischi = null;
        boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);

        //  Collection col = aHome.getValutazioneRischi_Categoria_RagSoc_View();
        //  Iterator it = col.iterator(); 
    %>
    <table class="VIEW_TABLE" border="0">
        <thead>
            <tr class="VIEW_HEADER_TR">
               
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.redazione")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Versione")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            <%
                //  java.util.Collection col = home.getValutazioneRischiSezioniNames_View(lCOD_AZL);

                Collection col = home.findEx(lCOD_AZL, dtDAT_DOC_VLU, strNOM_RSP_DOC, strVER_DOC, lCOD_UNI_ORG, 0);
                java.util.Iterator it = col.iterator();
                int iCount = 0;
                while (it.hasNext()) {
                    ValutazioneRischiSezioniNames_View obj = (ValutazioneRischiSezioniNames_View) it.next();
                    /*
                     Long i = (Long) it.next();
                     if (true) {
                     continue;
                     }
                     ValutazioneRischi = home.findByPrimaryKey(i);
                     */
            %>
            <tr 
                class="VIEW_TR" valign="top"
                INDEX="<%=obj.COD_DOC_VLU%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                
                <%  
                        out.println("<td>&nbsp;" + ++iCount + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.DAT_DOC_VLU) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.NOM_RSP_DOC) + "&nbsp;</td><td>&nbsp;"
                                + Formatter.format(obj.VER_DOC) + "&nbsp;</td><td>&nbsp;" + Formatter.format(obj.RAG_SCL_AZL) + "&nbsp;</td></tr>");
                  
              }
                %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID) ? "style='display: none;'" : ""%>>
            <tr>
                
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
            
                <th><input type="text" name="cerca_Data.redazione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.redazione")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Datore.di.lavoro" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Versione" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Versione")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Azienda/Ente" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>" class="search_init" /></th>
            </tr>
        </tfoot>
    </table>
</div>
<script>
    function OnBeforeDelete(id, tr) {
        return confirm(arraylng["MSG_0016"]);
    }

    function OnViewLoad() {
        parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuDVR, 3));

        parent.g_Handler.New.URL = "/luna/WEB/Form_ANA_DOC_VLU/ANA_DOC_VLU_Form.jsp";
        parent.g_Handler.New.Width = 48;
        parent.g_Handler.New.Height = "300px";
        //  parent.g_Handler.New.Height="438px";

        parent.g_Handler.Open = parent.g_Handler.New;

        parent.g_Handler.Delete.URL = "/luna/WEB/Form_ANA_DOC_VLU/ANA_DOC_VLU_Delete.jsp"; //?ID=32233223
        parent.g_Handler.Delete.OnBefore = OnBeforeDelete;
        parent.g_Handler.Help.URL = "/luna/WEB/Form_ANA_DOC_VLU/ANA_DOC_VLU_Help.jsp";
          parent.g_Handler.dataTableOn="Y";
        parent.g_Handler.dataTableArrayWidth=  [
                        {"bSortable": true, "bOrderable": true, "aTargets": [0]},
                        {"sWidth": "10%", "aTargets": [0], "sType": "string"},
                        {"sWidth": "10%", "aTargets": [1], "sType": "date-eu"},
                        {"sWidth": "30%", "aTargets": [2], "sType": "string"} ,
                        {"sWidth": "20%", "aTargets": [3], "sType": "string"} ,
                        {"sWidth": "30%", "aTargets": [4], "sType": "string"}  ]   ;
    }
    parent.g_Handler.OnViewChange(divContent, OnViewLoad);
    //  InitView();
</script>
