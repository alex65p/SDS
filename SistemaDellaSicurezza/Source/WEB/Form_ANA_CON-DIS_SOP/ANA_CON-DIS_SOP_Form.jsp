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


<%@page import="com.apconsulting.luna.ejb.Procedimento.*"%>
<%@page import="com.apconsulting.luna.ejb.AnagrOpere.*"%>
<%@page import="com.apconsulting.luna.ejb.Cantiere.*"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="javax.swing.text.html.HTMLDocument"%>
<%@page import="com.lowagie.text.Document"%>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%-- 
    Document   : ANA_SOP_Form
    Created on : 22-mar-2011, 18.03.17
    Author     : Alessandro
--%>
<%@ page import="com.apconsulting.luna.ejb.Sopraluogo.*" %>
<%@ page import="com.apconsulting.luna.ejb.DittaEsterna.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrAttivitaCantieri.*" %>
<%@ page import="s2s.utils.text.StringManager" %>
<%@ page import="s2s.utils.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<style>
    .text
    {
        font-size: 80%;
    }
    td
    {
        white-space: nowrap;
    }
    .text_gendis_eq
    {
        font-size: 80%;
        border-color: greenyellow;
        white-space:normal;
        word-wrap:break-word;
    }
    .text_gendis_ne
    {
        font-size: 80%;
        border-color: red;
        white-space:normal;
        word-wrap:break-word;
    }
    .art_leg
    {
        font-size: 80%;
        white-space:normal;
        word-wrap:break-word;
        vertical-align: top;
        background-color: #ffffcc;
    }
</style>
<html>
    <head>
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

        <link rel=STYLESHEET href="../_styles/style.css" type="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <script type="text/javascript" src="../_scripts/ajax.js"></script>
        <script type="text/javascript" src="ANA_CON-DIS_SOP_JS.js"></script>
        <script language="JavaScript" src="../_scripts/textarea.js"></script>

        <script>
            window.dialogWidth="1000px";
            window.dialogHeight="650px";
        </script>
        <title><%=ApplicationConfigurator.LanguageManager.getString("Constatazioni.Disposizioni")%></title>
    </head>
    <body>
        <%
            // Campi relativi al sopralluogo
            long lCOD_SOP = 0;
            long lCOD_PRO = 0;
            long lCOD_OPE = 0;
            long lCOD_CAN = 0;
            String sNUM_SOP = "";
            String sDAT_SOP = "";
            String sORA_SOP_INI = "";
            String sORA_SOP_FIN = "";
            String sCOD_SOP = "";
            String sORA_INI = "";
            String sMIN_INI = "";
            String sORA_FIN = "";
            String sMIN_FIN = "";

            ISopraluogoHome home = null;
            ISopraluogo sopraluogo = null;
            home = (ISopraluogoHome) PseudoContext.lookup("SopraluogoBean");

            // Estraggo i campi del sopralluogo
            if (request.getParameter("ID_PARENT") != null) {
                sCOD_SOP = (String) request.getParameter("ID_PARENT");
                lCOD_SOP = new Long(sCOD_SOP);
                sopraluogo = home.findByPrimaryKey(lCOD_SOP);

                lCOD_PRO = sopraluogo.getCOD_PRO();
                lCOD_OPE = sopraluogo.getCOD_OPE();
                lCOD_CAN = sopraluogo.getCOD_CAN();

                sNUM_SOP = sopraluogo.getNUM_SOP();
                sDAT_SOP = Formatter.format(sopraluogo.getDAT_SOP());

                int ini, fin;
                if (sopraluogo.getORA_INI() != null) {
                    sORA_SOP_INI = sopraluogo.getORA_INI().toString();

                    ini = sORA_SOP_INI.indexOf(':');
                    fin = sORA_SOP_INI.indexOf(':', (ini + 1));
                    sORA_INI = sORA_SOP_INI.substring(0, ini);
                    sMIN_INI = sORA_SOP_INI.substring((ini + 1), fin);
                }
                if (sopraluogo.getORA_FIN() != null) {
                    sORA_SOP_FIN = sopraluogo.getORA_FIN().toString();

                    ini = sORA_SOP_FIN.indexOf(':');
                    fin = sORA_SOP_FIN.indexOf(':', (ini + 1));
                    sORA_FIN = sORA_SOP_FIN.substring(0, ini);
                    sMIN_FIN = sORA_SOP_FIN.substring((ini + 1), fin);
                }
            }
            
            // Campi relativi alla constatazione
            String sCOD_SOP_CST = null;
            long lCOD_CST = 0;
            long lCOD_FAT_RSO = 0;
            long lCOD_DTE = 0;
            long lCOD_DOC = 0;
            String sDES_LIB = "";

            // Estraggo i campi della constatazione
            if (request.getParameter("ID") != null) {
                try {
                    sCOD_SOP_CST = (String) request.getParameter("ID");
                    jbConstatazione constatazione = home.getConstatazioneSOP(new Long(sCOD_SOP_CST));
                    lCOD_CST = constatazione.lCOD_CST;
                    lCOD_FAT_RSO = constatazione.lCOD_FAT_RSO;
                    lCOD_DTE = constatazione.lCOD_DTE;
                    lCOD_DOC = constatazione.lCOD_DOC;
                    sDES_LIB = Formatter.format(constatazione.sDES_LIB);
                } catch (Exception ex) {
                    out.print("<script>alert('ERRORE " + ex.getMessage() + "');</script>");
                    return;
                }
            }
        %>
        <!-- form for addind  -->
        <form action="ANA_CON-DIS_SOP_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input type="hidden" name="SBM_MODE" value="<%=(lCOD_CST == 0) ? "new" : "edt"%>">
            <input type="hidden" name="COD_SOP" value="<%=lCOD_SOP%>">
            <input type="hidden" id="ID_PARENT" name="ID_PARENT" value="<%=sCOD_SOP_CST%>">
            <input type="hidden" id="PARENT" name="PARENT" value="<%=sCOD_SOP_CST%>">
            <input type="hidden" name="COD_CST" value="<%=lCOD_CST%>">
            <table width="100%" border="0">
                <tr>
                    <td width="10" height="100%" valign="top">
                    </td>
                    <td valign="top">
                        <table  width="100%" border="0">
                            <tr>
                                <td class="title" colspan="2">
                                    <%=ApplicationConfigurator.LanguageManager.getString("Constatazioni.Disposizioni")%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="100%">
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%
                                            ToolBar.bShowReturn = false;
                                            ToolBar.bShowDelete = false;
                                            ToolBar.bShowSearch = false;
                                        %>
                                        <%=ToolBar.build(2)%>
                                    </table>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Sopralluogo")%></legend>
                                        <table width="100%" border="0">
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Procedimento")%>:&nbsp;</b></td>
                                                <td style="width: 40%;"> <%
                                                    IProcedimentoHome pro_home = (IProcedimentoHome) PseudoContext.lookup("ProcedimentoBean");
                                                    IProcedimento procedimento = pro_home.findByPrimaryKey(lCOD_PRO);
                                                    String sDES_PRO = procedimento.getDES_PRO();
                                                    %>
                                                    <div style="width: 400px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"><%=Formatter.format(sDES_PRO)%></div>
                                                </td>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Cantiere")%>:&nbsp;</b></td>
                                                <td style="width: 10%;"> <%
                                                    ICantiereHome can_home = (ICantiereHome) PseudoContext.lookup("CantiereBean");
                                                    ICantiere cantiere = can_home.findByPrimaryKey(lCOD_CAN);
                                                    String sNOM_CAN = cantiere.getNOM_CAN();
                                                    %>
                                                    <div style="width: 100px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"><%=Formatter.format(sNOM_CAN)%></div>
                                                </td>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Opera")%>:&nbsp;</b></td>
                                                <td colspan="3"  style="width: 10%;">
                                                    <div style="width: 160px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
                                                    <%
                                                    if (lCOD_OPE != 0) {
                                                        IAnagrOpereHome ope_home = (IAnagrOpereHome) PseudoContext.lookup("AnagrOpereBean");
                                                        IAnagrOpere opera = ope_home.findByPrimaryKey(lCOD_OPE);
                                                        String sNOM_OPE = opera.getstrNOM_OPE();
                                                        out.print(Formatter.format(sNOM_OPE));
                                                    } else {
                                                        out.print("&nbsp;");
                                                    }
                                                    %>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Numero.sopralluogo")%>:&nbsp;</b></td>
                                                <td><%=sNUM_SOP%></td>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Data")%>:&nbsp;</b></td>
                                                <td ><%=sDAT_SOP%></td>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Ora.inizio")%>:&nbsp;</b></td>
                                                <td align="left">
                                                    <%=sORA_INI%>
                                                    &nbsp;:&nbsp;
                                                    <%=sMIN_INI%></td>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Ora.fine")%>:&nbsp;</b></td>
                                                <td align="left">
                                                    <%=sORA_FIN%>
                                                    &nbsp;:&nbsp;
                                                    <%=sMIN_FIN%>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Constatazioni.Disposizioni")%></legend>
                                        <table border="0" width="100%" cellspacing="4" cellpadding="4">
                                            <tr>
                                                <td colspan="2">
                                                    <table border="1" width="100%" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td style="width: 50%;">
                                                                <table border="0" width="100%" id="constDittaAttivitaTable" <%=sCOD_SOP_CST==null?"disabled":""%>>
                                                                    <tr>
                                                                        <%
                                                                            String strRAG_SCL_DTE = "";
                                                                            if (StringManager.isNotEmptyOrZero(String.valueOf(lCOD_DTE))){
                                                                                IDittaEsternaHome dittaHome = (IDittaEsternaHome) PseudoContext.lookup("DittaEsternaBean");
                                                                                IDittaEsterna dittaBean = dittaHome.findByPrimaryKey(lCOD_DTE);
                                                                                strRAG_SCL_DTE = " " + dittaBean.getRAG_SCL_DTE();
                                                                            }
                                                                        %>
                                                                        <td style="text-align: right;"><%=ApplicationConfigurator.LanguageManager.getString("Ditta")%>:&nbsp;</td>
                                                                        <td>
                                                                            <input name="CON_DIS_COD_DTE" type="hidden" value="<%=lCOD_DTE%>" <%=sCOD_SOP_CST==null?"disabled":""%>/>
                                                                            <input readonly width="100%" size="70" maxlength="100" tabindex="1" name="CON_DIS_RAG_SCL_DTE" value="<%=strRAG_SCL_DTE%>" <%=sCOD_SOP_CST==null?"disabled":""%>/>
                                                                        </td>
                                                                        <td>
                                                                            <button 
                                                                                tabindex="2" 
                                                                                class="getlist" 
                                                                                onclick="getDitteEsterne();" 
                                                                                title='<%=ApplicationConfigurator.LanguageManager.getString("Seleziona.valore")%>'
                                                                                name="btnGetDitteEsterneName"
                                                                                id="btnGetDitteEsterne"
                                                                                <%=sCOD_SOP_CST==null?"disabled":""%>>
                                                                                <strong>&middot;&middot;&middot;</strong>
                                                                            </button>
                                                                        </td>
                                                                        <td>
                                                                            <button 
                                                                                tabindex="3"
                                                                                class="getlist"
                                                                                onclick="clearDitteEsterne();" 
                                                                                title='<%=ApplicationConfigurator.LanguageManager.getString("Cancella.valore")%>'
                                                                                name="btnClearDitteEsterneName"
                                                                                id="btnClearDitteEsterne"
                                                                                <%=sCOD_SOP_CST==null?"disabled":""%>>
                                                                                <img src='../_images/new/erase_data.png' alt="<%=ApplicationConfigurator.LanguageManager.getString("Cancella.valore")%>" height="18" width="18">
                                                                            </button>                                                                        
                                                                        <td>
                                                                    </tr>
                                                                    <tr>
                                                                        <%
                                                                            String strNOM_ATT = "";
                                                                            if (StringManager.isNotEmptyOrZero(String.valueOf(lCOD_DOC))){
                                                                                IAnagrAttivitaCantieriHome attivitaHome = (IAnagrAttivitaCantieriHome)PseudoContext.lookup("AnagrAttivitaCantieriBean"); 
                                                                                IAnagrAttivitaCantieri attivitaBean = attivitaHome.findByPrimaryKey(lCOD_DOC);
                                                                                strNOM_ATT = " " + attivitaBean.getstrCOD()+" - "+attivitaBean.getstrNOM_ATT();
                                                                            }
                                                                        %>
                                                                        <td style="text-align: right;"><%=ApplicationConfigurator.LanguageManager.getString("Attivita")%>:&nbsp;</td>
                                                                        <td>
                                                                            <input name="CON_DIS_COD_DOC" type="hidden" value="<%=lCOD_DOC%>" <%=sCOD_SOP_CST==null?"disabled":""%>/>
                                                                            <input readonly width="100%" size="70" maxlength="100" tabindex="4" name="CON_DIS_NOM_ATT" value="<%=strNOM_ATT%>" <%=sCOD_SOP_CST==null?"disabled":""%>/>
                                                                        </td>
                                                                        <td>
                                                                            <button 
                                                                                tabindex="5" 
                                                                                class="getlist" 
                                                                                onclick="getAttivita();" 
                                                                                title='<%=ApplicationConfigurator.LanguageManager.getString("Seleziona.valore")%>'
                                                                                name="btnAttivitaName"
                                                                                id="btnAttivita"
                                                                                <%=sCOD_SOP_CST==null?"disabled":""%>>
                                                                                <strong>&middot;&middot;&middot;</strong>
                                                                            </button>
                                                                        </td>
                                                                        <td>
                                                                            <button 
                                                                                tabindex="6"
                                                                                class="getlist"
                                                                                onclick="clearAttivita();" 
                                                                                title='<%=ApplicationConfigurator.LanguageManager.getString("Cancella.valore")%>'
                                                                                name="btnClearAttivitaName"
                                                                                id="btnClearAttivita"
                                                                                <%=sCOD_SOP_CST==null?"disabled":""%>>
                                                                                <img src='../_images/new/erase_data.png' alt="<%=ApplicationConfigurator.LanguageManager.getString("Cancella.valore")%>" height="18" width="18">
                                                                            </button>                                                                        
                                                                        <td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td style="width: 50%;">
                                                                <table border="0" width="100%" id="constFreeFieldTable" <%=sCOD_SOP_CST==null?"disabled":""%>>
                                                                    <tr>
                                                                        <td style="text-align: right; vertical-align: middle; width: 130px;"><%=ApplicationConfigurator.LanguageManager.getString("Campo.a.testo.libero")%>:&nbsp;</td>
                                                                        <td>
                                                                            <textarea style="width: 100%;" cols="1" rows="3" name="CON_DIS_DES_LIB" tabindex="7" maxlength="100" <%=(sCOD_SOP_CST==null?"disabled":"")%>><%=sDES_LIB%></textarea>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: top">
                                                    <table border="1" style="background: #ffffcc">
                                                        <tr style=" text-align: center">
                                                            <td style="width: 200px; background-color: #2E8B57; font: bold;" ><font color="white"><%=ApplicationConfigurator.LanguageManager.getString("Fattori.di.rischio").toUpperCase()%></font></td>
                                                            <td style="width: 200px; background-color: #2E8B57; font: bold;" ><font color="white"><%=ApplicationConfigurator.LanguageManager.getString("Constatazioni").toUpperCase()%></font></td>
                                                            <td style="width: 200px; background-color: #2E8B57; font: bold;"><font color="white"><%=ApplicationConfigurator.LanguageManager.getString("Rischi").toUpperCase()%></font></td>
                                                            <td style="display: none; width: 200px; background-color: #2E8B57; font: bold;"><font color="white"><%=ApplicationConfigurator.LanguageManager.getString("Disposizioni").toUpperCase()%></font></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="vertical-align: top; height: 360px;">
                                                                <div ID="ajaxRetFATRSO">
                                                                </div>
                                                            </td>
                                                            <td style="vertical-align: top;">
                                                                <div ID="ajaxRetCONST">
                                                                </div>
                                                            </td>
                                                            <td style="vertical-align: top;">
                                                                <div ID="ajaxRetRISC">
                                                                </div>
                                                            </td>
                                                            <td style="display: none; vertical-align: top;">
                                                                <div ID="ajaxRetDISP">
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="vertical-align: top;">
                                                    <table border="1"  width="322px">
                                                        <tr style="background-color: #2E8B57;">
                                                            <td style="font: bold">
                                                                <font color="white">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Disposizione.generata").toUpperCase()%>&nbsp;
                                                                </font>
                                                                <input id='aggiorna_disp' type='button' 
                                                                       value='<%=ApplicationConfigurator.LanguageManager.getString("Refresh")%>' 
                                                                       OnClick="ajaxListCONST(null,null,true);">
                                                            </td>
                                                        </tr>
                                                        <tr style="background: white">
                                                            <TD  height="164px">
                                                                <div ID="ajaxRetGENDIS">
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: #2E8B57;">
                                                            <tD style="font: bold"><font color="white"><%=ApplicationConfigurator.LanguageManager.getString("Articoli.di.legge")%></font></td>
                                                        </tr>
                                                        <tr style="background: #ffffcc">
                                                            <TD height="164px">
                                                                <div ID="ajaxRetRETLEG">
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                </td>
                            </tr>

                            </fieldset>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</form>
<iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
</body>
<script>
    ajaxListCONST(<%=lCOD_FAT_RSO%>,<%=lCOD_CST%>);
</script>
</html>
