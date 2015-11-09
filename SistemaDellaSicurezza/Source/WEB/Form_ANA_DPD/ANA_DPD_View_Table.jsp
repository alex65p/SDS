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

     </comments> 
     </version>
     </versions>
     </file> 
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
 
     <table border="0"  class="VIEW_TABLE">
        <thead>
            <tr  class="VIEW_HEADER_TR">
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Matricola")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Cognome")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Funz.Aziendale")%>&nbsp;</th>
                <th>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Fornitore.personale/servizi")%>&nbsp;</th>
                <th nowrap>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.di.nascita")%>&nbsp;</th>
            </tr>
        </thead>        
        <tbody>
            <%
                long lCOD_AZL = Security.getAzienda();
                Checker c = new Checker();
                Long lCOD_DTE = c.checkLongEx("DTE ID", (String) request.getParameter("COD_DTE"), false);
                Long lCOD_FUZ_AZL = c.checkLongEx(ApplicationConfigurator.LanguageManager.getString("Funz.Aziendale"), (String) request.getParameter("COD_FUZ_AZL"), false);
                String strSTA_DPD = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Stato"), (String) request.getParameter("STA_DPD"), false);
                String strMTR_DPD = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Matricola"), (String) request.getParameter("MTR_DPD"), false);
                String strCOG_DPD = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Cognome"), (String) request.getParameter("COG_DPD"), false);
                String strNOM_DPD = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Nome"), (String) request.getParameter("NOM_DPD"), false);
                String strCOD_FIS_DPD = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Cod.fiscale"), (String) request.getParameter("COD_FIS_DPD"), false);
                Long lCOD_STA = c.checkLongEx(ApplicationConfigurator.LanguageManager.getString("Nazione"), (String) request.getParameter("COD_STA"), false);
                String strLUO_NAS_DPD = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Luogo.di.nascita"), (String) request.getParameter("LUO_NAS_DPD"), false);
                java.sql.Date dtDAT_NAS_DPD = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.di.nascita"), (String) request.getParameter("DAT_NAS_DPD"), false);
                String strIDZ_DPD = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Indirizzo"), (String) request.getParameter("IDZ_DPD"), false);
                String strNUM_CIC_DPD = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Numero.civico"), (String) request.getParameter("NUM_CIC_DPD"), false);
                String strCAP_DPD = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("C.a.p."), (String) request.getParameter("CAP_DPD"), false);
                String strCIT_DPD = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Città"), (String) request.getParameter("CIT_DPD"), false);
                String strPRV_DPD = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Provincia"), (String) request.getParameter("PRV_DPD"), false);
                String strIDZ_PSA_ELT_DPD = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Posta.elettronica"), (String) request.getParameter("IDZ_PSA_ELT_DPD"), false);
                java.sql.Date dtDAT_ASS_DPD = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.assunzione"), (String) request.getParameter("DAT_ASS_DPD"), false);
                String strLIV_DPD = c.checkStringEx(ApplicationConfigurator.LanguageManager.getString("Livello"), (String) request.getParameter("LIV_DPD"), false);
                java.sql.Date dtDAT_CES_DPD = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.cessazione"), (String) request.getParameter("DAT_CES_DPD"), false);
                Long lNOFINDEX = c.checkLongEx("no find ex", (String) request.getParameter("noFindEx"), false);
                boolean fromMenu = request.getParameter("_Refresh") != null ? true : false;
                String strSubject = (String) request.getParameter("ATTACH_SUBJECT");
                System.out.println(strSubject);
                Collection col;
                if (lNOFINDEX != null) {
                    col = home.getDipendenti_Search_View(lCOD_AZL);
                } else {
                    if (strSubject == null) {
                        col = home.findEx(
                                lCOD_AZL,
                                strNOM_DPD,
                                strCOG_DPD,
                                strMTR_DPD,
                                lCOD_FUZ_AZL,
                                dtDAT_NAS_DPD,
                                strLUO_NAS_DPD,
                                strCIT_DPD,
                                strIDZ_DPD,
                                strNUM_CIC_DPD,
                                strCAP_DPD,
                                strPRV_DPD,
                                lCOD_DTE,
                                dtDAT_ASS_DPD,
                                strLIV_DPD,
                                dtDAT_CES_DPD,
                                fromMenu,
                                0);
                    } else {
                        col = home.findExSOP(
                                lCOD_AZL,
                                strNOM_DPD,
                                strCOG_DPD,
                                strMTR_DPD,
                                lCOD_FUZ_AZL,
                                dtDAT_NAS_DPD,
                                strLUO_NAS_DPD,
                                strCIT_DPD,
                                strIDZ_DPD,
                                strNUM_CIC_DPD,
                                strCAP_DPD,
                                strPRV_DPD,
                                lCOD_DTE,
                                dtDAT_ASS_DPD,
                                strLIV_DPD,
                                dtDAT_CES_DPD,
                                fromMenu, strSubject,
                                0);
                    }
                }
                java.util.Iterator it = col.iterator();
                int nCount = 1;

                String RowStyle = "";
                StringBuilder jspOutputBuilder = null;
                while (it.hasNext()) {
                    Dipendenti_Search_View view = (Dipendenti_Search_View) it.next();
                    RowStyle = home.dipendenteCessato(view.DAT_CES_DPD) == true ? "VIEW_TR_DIP_CESSATO" : "VIEW_TR";
            %>		
            <tr class="<%=RowStyle%>" valign="top" INDEX="<%=view.COD_DPD%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                <td>&nbsp;<%=nCount++%>&nbsp;</td>
                <%
                        jspOutputBuilder = new StringBuilder(300);
                        jspOutputBuilder.append("<td nowrap>")
                                .append(Formatter.format(view.MTR_DPD)).append("</td><td nowrap>&nbsp;")
                                .append(Formatter.format(view.COG_DPD)).append("&nbsp;</td><td nowrap>&nbsp;")
                                .append(Formatter.format(view.NOM_DPD)).append("&nbsp;</td><td nowrap>&nbsp;")
                                .append(Formatter.format(view.NOM_FUZ_AZL)).append("&nbsp;</td><td nowrap>&nbsp;")
                                .append(Formatter.format(view.RAG_SCL_DTE)).append("&nbsp;</td><td nowrap>&nbsp;")
                                .append(Formatter.format(view.DAT_NAS_DPD)).append("&nbsp;</td>");
                        out.println(jspOutputBuilder.toString());
                    }
                %>
        </tbody>
        <tfoot <%=!ApplicationConfigurator.isModuleEnabled(MODULES.ENHANCED_GRID)?"style='display: none;'":""%>>
            <tr>
                <th><input type="text" name="cerca_Numero" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Numero")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Matricola" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Matricola")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Cognome" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Cognome")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Nome" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Nome")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Funz.Aziendale" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Funz.Aziendale")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Fornitore.personale/servizi" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Fornitore.personale/servizi")%>" class="search_init" /></th>
                <th><input type="text" name="cerca_Data.di.nascita" value="Cerca <%=ApplicationConfigurator.LanguageManager.getString("Data.di.nascita")%>" class="search_init" /></th>
            </tr>
        </tfoot>        
    </table>
