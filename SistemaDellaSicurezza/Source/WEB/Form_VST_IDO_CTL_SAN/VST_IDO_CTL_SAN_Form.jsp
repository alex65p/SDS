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
        <version number="1.0" date="27/02/2004" author="Malyuk Sergey">
        <comment date="27/02/2004" author="Malyuk Sergey">
        <description></description>
        </comment>
        </version>
        </versions>
        </file>
         */
%>
<%@ page import="com.apconsulting.luna.ejb.GestioneVisiteIdoneita.*" %>
<%@ page import="com.apconsulting.luna.ejb.CartelleSanitarie.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="VST_IDO_CTL_SAN_Util.jsp" %>
<%@ include file="../_include/ToolBar.jsp" %>      
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<html>
    <head>
        <title><%=ApplicationConfigurator.LanguageManager.getString("Visite.di.idoneita")%></title>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
        <!-- autocompose data field -->
        <script type="text/javascript" src="../_scripts/calendar/utility.js"></script>
        <!-- import the calendar script -->
        <script type="text/javascript" src="../_scripts/calendar/calendar.js"></script>
        <!-- import the language module -->
        <script type="text/javascript" src="../_scripts/calendar/lang.js"></script>
        <!-- import calendar utility function -->
        <script type="text/javascript" src="../_scripts/calendar/showCalendar.js"></script>
        <!-- style sheet for calendar -->
        <link rel="stylesheet" type="text/css" media="all" href="../_styles/calendar/skins/aqua/theme.css" title="Aqua" />

    </head>
    <body>
        <script>
            window.dialogWidth="790px";
            window.dialogHeight="330px";
        </script>
        <%
        ICartelleSanitarie bean = null;
        ICartelleSanitarieHome home = (ICartelleSanitarieHome) PseudoContext.lookup("CartelleSanitarieBean");

        long lCOD_VST_IDO = 0;
        Long ID_PARENT = new Long(request.getParameter("ID_PARENT"));
        long lCOD_CTL_SAN = ID_PARENT.longValue();
        String dtDAT_PIF_VST = null;
        String dtDAT_EFT_VST = null;
        String IDO_VST = "";
        String strTPL_ACR_VLU_MED = "";
        String strTPL_ACR_VLU_RSO = "";
        String strTPL_ACR_EFT = "";
        String strNOT_VST_IDO = "";
        bean = home.findByPrimaryKey(ID_PARENT);
        long lCOD_AZL = bean.getCOD_AZL();
        long lCOD_DPD = bean.getCOD_DPD();
        

        if (request.getParameter("ID") != null) {

            lCOD_VST_IDO = new Long(request.getParameter("ID")).longValue();
            dtDAT_PIF_VST = request.getParameter("dat_pif_vst_ido");

            java.util.Collection col = home.getCTL_VST_IDO_All_View(lCOD_VST_IDO, lCOD_AZL, lCOD_DPD, lCOD_CTL_SAN, java.sql.Date.valueOf(dtDAT_PIF_VST));
            java.util.Iterator it = col.iterator();
            while (it.hasNext()) {

                CTL_VST_IDO_All_View vst = (CTL_VST_IDO_All_View) it.next();
                dtDAT_PIF_VST = Formatter.format(vst.DAT_PIF_VST);
                dtDAT_EFT_VST = Formatter.format(vst.DAT_EFT_VST);
                strTPL_ACR_VLU_RSO = Formatter.format(vst.TPL_ACR_VLU_RSO);
                strTPL_ACR_VLU_MED = Formatter.format(vst.TPL_ACR_VLU_MED);
                strTPL_ACR_EFT = Formatter.format(vst.TPL_ACR_EFT);
                IDO_VST = Formatter.format(vst.IDO_VST);
                strNOT_VST_IDO = Formatter.format(vst.NOT_VST_IDO);

            }
        } 
        %>
        <form action="VST_IDO_CTL_SAN_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value='<%=(lCOD_VST_IDO == 0) ? "new" : "edt"%>'>
            <input type="hidden" name="newDAT_PIF_VST" value="<%=dtDAT_PIF_VST%>">
            <input type="hidden" name="COD_CTL_SAN" value="<%=ID_PARENT%>">
            <input type="hidden" name="COD_AZL" value="<%=lCOD_AZL%>">
            <input type="hidden" name="COD_DPD" value="<%=lCOD_DPD%>">
            <input type="hidden" name="oldCOD_VST_IDO" value="<%=lCOD_VST_IDO%>">
            <input type="hidden" name="oldDat_PIF_VST" value="<%=dtDAT_PIF_VST%>">
            <input type="hidden" name="oldDAT_PIF_VST" value="<%=dtDAT_PIF_VST%>">

            <table width="100%" border="0">
                <tr>
                    <td valign="top">
                        <table  width="100%" border="0">
                            <tr>
                                <td class="title">
                                    <%=ApplicationConfigurator.LanguageManager.getString("Visite.di.idoneita")%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="100" border="0">
                                        <%
        if (request.getParameter("ID_PARENT") != null) {
            ToolBar.strSearchUrl = ToolBar.strSearchUrl.replace('&', '|');
        }
        ToolBar.bShowReturn = false;
        ToolBar.bShowSearch = false;
        ToolBar.strPrintUrl = "InvitoVisitaIdoneita.jsp?DPD=" + lCOD_DPD + "&CTL_SAN=" + lCOD_CTL_SAN + "&";
                                        %>
                                        <%=ToolBar.build(2)%>
                                    </table>
                                    <fieldset>
                                        <legend>
                                            <%=ApplicationConfigurator.LanguageManager.getString("Dati.visita.di.idoneità")%>
                                        </legend>
                                        <table border="0">
                                            <tr>
                                                <td align="right">
                                                    <b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b>
                                                </td>
                                                <td colspan="5" align="left">
                                                    <select name="COD_VST_IDO" style="width:100%;">
                                                        <option></option>
                                                        <%
        IGestioneVisiteIdoneitaHome vst_ido_home = (IGestioneVisiteIdoneitaHome) PseudoContext.lookup("GestioneVisiteIdoneitaBean");
        out.print(BuildVST_IDOComboBox(vst_ido_home, lCOD_VST_IDO));
                                                        %>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <b><%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione.visita")%>&nbsp;</b>
                                                </td>
                                                <%
        String valueDAT_PIF_VST = "";
        String valuedtDAT_EFT_VST = "";
        if (dtDAT_PIF_VST != null) {
            valueDAT_PIF_VST = dtDAT_PIF_VST;
        }
        if (dtDAT_EFT_VST != null) {
            valuedtDAT_EFT_VST = dtDAT_EFT_VST;
        }
                                                %>
                                                <td align="left">
                                                    <s2s:Date id="DAT_PIF_VST" name="DAT_PIF_VST" value="<%=valueDAT_PIF_VST %>"/>
                                                </td>
                                                <td align="right" width="140px;">
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Data.svolgimento.visita")%>&nbsp;
                                                </td>
                                                <td align="left">
                                                    <s2s:Date id="DAT_EFT_VST" name="DAT_EFT_VST" value="<%=valuedtDAT_EFT_VST %>"/>
                                                </td>
                                                <td align="right" width="70px;">
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Idoneità")%>&nbsp;
                                                </td>
                                                <td align="left">
                                                    <input type="radio" size="14" name="IDO_VST" class="checkbox" value="S" <%=("S".equals(IDO_VST)) ? "checked" : ""%>>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Si")%></input><br>
                                                    <input type="radio" size="14" name="IDO_VST" class="checkbox" value="N" <%=("N".equals(IDO_VST)) ? "checked" : ""%>>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("No")%></input><br>
                                                    <input type="radio" size="14" name="IDO_VST" class="checkbox" value="C" <%=("C".equals(IDO_VST)) ? "checked" : ""%>>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Con.prescrizione")%></input>
                                                </td>
                                            </tr>
                                            <tr>

                                                <td align="right">
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Tipo.di.accertamento.effettuato")%>&nbsp;
                                                </td>
                                                <td colspan="5" align="left">
                                                    <input type="text" style="width:100%" maxlength="70"  name="TPL_ACR_VLU_MED" value="<%=strTPL_ACR_VLU_MED%>">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" width="200px">
                                                    <b><%=ApplicationConfigurator.LanguageManager.getString("Tipo.di.accertamento.della.valutazione.del.rischio")%>&nbsp;</b>
                                                </td>
                                                <td colspan="5" align="left">
                                                    <input type="text" maxlength="70"  style="width:100%" name="TPL_ACR_VLU_RSO" value="<%=strTPL_ACR_VLU_RSO%>">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Note")%>&nbsp;
                                                </td>
                                                <td colspan="5" align="left">
                                                    <textarea rows="3" cols="103" name="NOT_VST_IDO"><%=strNOT_VST_IDO%></textarea>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <script>
            /*function init(){
    btnPrint=ToolBar.Print.getButton();
    OnPrintOld=btnPrint.onclick;
    btnPrint.onclick=OnPrint;
 }
 function OnPrint(){
    OnPrintOld();
    alert(tb_url_Print);
 }*/

        </script>
    </body>
</html>
