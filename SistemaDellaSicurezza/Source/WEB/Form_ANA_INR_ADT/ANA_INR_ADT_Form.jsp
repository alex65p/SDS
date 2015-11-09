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
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.InterventoAudut.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="ANA_INR_ADT_Util.jsp" %>

<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuVerificheSPP, 0) + "</title>");
        </script>
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
    <link rel="stylesheet" href="../_styles/style.css">
    <link rel="stylesheet" href="../_styles/tabs.css">
    <link rel="stylesheet" href="../_styles/cooltree.css">
    <script language="JavaScript" src="../_scripts/tabs.js"></script>
    <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>

    <script>
        window.dialogWidth = "720px";
        window.dialogHeight = "720px";
    </script>
    <body style="margin: 0 0 0 0">
        <%
            long lCOD_AZL = Security.getAzienda();
            String strRAG_SCL_AZL = new String();

            long lCOD_INR_ADT = 0;
            String strDES_INR_ADT = "";
            java.sql.Date dtDAT_PIF_INR = null;
            String lNUM_VIS_ISP = "";
            java.sql.Date dtDAT_ADT = null;
            long lCOD_MIS_PET = 0;
            long lCOD_PSD_ACD = 0;
            long lCOD_LUO_FSC = 0;
            String lCOD_DPD = "";
            String strSEC_PNO_YEA = "";
            String lPNG_TEO = "";
            String lPNG_RIL = "";
            String lPNG_PCT = "";
            long lCOD_UNI_ORG = 0;
            long lCOD_MIS_RSO_LUO = 0;
            long lCOD_MIS_PET_MAN = 0;

            String strCOG_DPD = "";
            String strNOM_DPD = "";
            String strMTR_DPD = "";
            String strNOM_CAG_PSD_ACD = "";
            String strIDE_PSD_ACD = "";
            String strNOM_MIS_PET = "";

            String strATTACH = "";
            java.util.Collection col;
            java.util.Iterator it;
            
            //-----Azienda--------
            IAziendaHome azHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");
            IAzienda azienda = null;
            
            //----Intervento d'audit----
            IInterventoAudut bean = null;
            IInterventoAudutHome home = (IInterventoAudutHome) PseudoContext.lookup("InterventoAudutBean");
            
            //----luogo fisico -----------
            IAnagrLuoghiFisiciHome aHome = (IAnagrLuoghiFisiciHome) PseudoContext.lookup("AnagrLuoghiFisiciBean");
            
            //----Unita organizzativa----
            IUnitaOrganizzativa uoBean = null;
            IUnitaOrganizzativaHome uoHome = (IUnitaOrganizzativaHome) PseudoContext.lookup("UnitaOrganizzativaBean");
            
            //----------get current azienda -----------------
            azienda = azHome.findByPrimaryKey(new Long(lCOD_AZL));
            strRAG_SCL_AZL = azienda.getRAG_SCL_AZL();

            if (request.getParameter("ID") != null) {
                // getting parameters of azienda
                try {
                    Long ID = new Long(request.getParameter("ID"));
                    bean = home.findByPrimaryKey(ID);

                    lCOD_INR_ADT = bean.getCOD_INR_ADT();
                    strDES_INR_ADT = bean.getDES_INR_ADT();
                    dtDAT_PIF_INR = bean.getDAT_PIF_INR();
                    lNUM_VIS_ISP = Formatter.format(bean.getNUM_VIS_ISP());
                    dtDAT_ADT = bean.getDAT_ADT();
                    lCOD_MIS_PET = bean.getCOD_MIS_PET();
                    lCOD_PSD_ACD = bean.getCOD_PSD_ACD();
                    lCOD_LUO_FSC = bean.getCOD_LUO_FSC();
                    lCOD_DPD = Formatter.format(bean.getCOD_DPD());
                    strSEC_PNO_YEA = bean.getSEC_PNO_YEA();
                    lPNG_TEO = Formatter.format(bean.getPNG_TEO());
                    lPNG_RIL = Formatter.format(bean.getPNG_RIL());
                    lPNG_PCT = Formatter.format(bean.getPNG_PCT());
                    lCOD_UNI_ORG = bean.getCOD_UNI_ORG();
                    lCOD_MIS_RSO_LUO = bean.getCOD_MIS_RSO_LUO();
                    lCOD_MIS_PET_MAN = bean.getCOD_MIS_PET_MAN();
                } catch (Exception ex) {
                    ex.printStackTrace(System.err);
                    out.print("<strong>" + ex.getMessage() + "</strong>");
                    return;
                }
            }
        %>
        <table cellpadding="0" cellspacing="10" width="100%" >
            <tr><td>
                    <form action="ANA_INR_ADT_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" >
                            <tr><td colspan="2" height="4"></td></tr>
                            <tr>
                                <td align="center" colspan="2" class="title">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                                (SubMenuVerificheSPP, 0,<%=request.getParameter("ID")%>));
                                    </script>      
                                </td>
                            </tr>
                            <tr>
                                <td bordercolor="" height="100%">
                                    <!--#################################################################-->
                                    <table border=0>
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%if (request.getParameter("ID") == null) {
                        ToolBar.bCanDelete = ToolBar.bCanEdit;
                    }%>
                                        <%ToolBar.strPrintUrl = "SchedaInterventoAudit.jsp?";%> 
                                        <%=ToolBar.build(5)%>
                                    </table>
                                    <!--##################################################################-->
                                    <fieldset style="width:100%">
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Gestione.intervento.audit")%></legend>
                                        <table border="0" cellpadding="0"   cellspacing="0"  style="height:100%; width:100%" > 
                                            <tr>
                                                <td rowspan="100%">&nbsp;&nbsp;</td>
                                                <td><input name="SBM_MODE" type="Hidden" value="<%if (lCOD_INR_ADT != 0) {
                                                out.print("edt");
                                            } else {
                                                out.print("new");
                                            }%>"> 
                                                    <input type="hidden" size="20" maxlength="20"  name="COD_INR_ADT" value="<%=Formatter.format(lCOD_INR_ADT)%>">

                                                </td>
                                                <td rowspan="100%">&nbsp;&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td   align="center">
                                                    <table width="100%">
                                                        <tr>
                                                            <td nowrap align="right" ><strong><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</strong></td>
                                                            <td  width="98%" colspan="6" align="center">
                                                                <input type="hidden" name="COD_AZL"  id="COD_AZL" value="<%= Formatter.format(lCOD_AZL)%>">
                                                                <input style="width:100%" type="text" readonly name="RAG_SCL_AZL"  value="<%= Formatter.format(strRAG_SCL_AZL)%>">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td  align="center" id="LAVORATORE">
                                                    <fieldset style="width:100%">
                                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.lavoratore")%></legend>
                                                        <%
                                                            if (bean != null) {
                                                                LavoratoreView resp = bean.getLavoratore(lCOD_AZL);
                                                                strNOM_DPD = resp.strNOM_DPD;
                                                                strMTR_DPD = resp.strMTR_DPD;
                                                                strCOG_DPD = resp.strCOG_DPD;
                                                            }
                                                        %>
                                                        <table  cellpadding="0" cellspacing="0" width="100%" style="margin: 5 0 9 0" border="0">
                                                            <tr>

                                                                <td align="right">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Cognome")%>&nbsp;
                                                                </td>
                                                                <td  align="left" width="30%" id="">
                                                                    <input type="hidden" size="20" maxlength="20"   name="COD_DPD" value="<%if (("0").equals(lCOD_DPD)) {
                                                                                 out.print("");
                                                                             } else {
                                                                                 out.print(lCOD_DPD);
                                                                             }%>">
                                                                    <input type="text" style="width:100%" value="<%= Formatter.format(strCOG_DPD)%>" id="COG_DPD" name="COG_DPD">
                                                                </td>
                                                                <td align="right">
                                                                    &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;
                                                                </td>
                                                                <td align="left" style="width:25%">
                                                                    <input type="text" style="width:100%"  value="<%= Formatter.format(strNOM_DPD)%>" id="NOM_DPD" name="NOM_DPD">
                                                                </td>
                                                                <td align="right">
                                                                    &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Matricola")%>&nbsp;
                                                                </td>
                                                                <td align="left" style="width:20%">
                                                                    <input type="text" style="width:100%" value="<%= Formatter.format(strMTR_DPD)%>" id="MTR_DPD" name="MTR_DPD">
                                                                </td>
                                                                <td>
                                                                    <button class="getlist" onclick="getLavoratoriList()" id="btnLavoratore">
                                                                        <strong>&middot;&middot;&middot;</strong>
                                                                    </button>							
                                                                </td>
                                                                <td>&nbsp;</td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" id="MISURA">
                                                    <fieldset style="width:100%">
                                                        <%
                                                            String selLuogo = "";
                                                            String selAttivita = "checked";
                                                            MisuraPreventivaView mis;
                                                            if (bean != null) {
                                                                if (lCOD_MIS_RSO_LUO != 0) {
                                                                    mis = home.getMisuraPreventivaByLuogo(lCOD_MIS_RSO_LUO, lCOD_AZL);
                                                                    lCOD_MIS_PET = mis.lCOD_MIS_PET;
                                                                    strNOM_MIS_PET = mis.strNOM_MIS_PET;
                                                                    selLuogo = "checked";
                                                                    selAttivita = "";
                                                                } else if (lCOD_MIS_PET_MAN != 0) {
                                                                    mis = home.getMisuraPreventivaByAttivita(lCOD_MIS_PET_MAN, lCOD_AZL);
                                                                    lCOD_MIS_PET = mis.lCOD_MIS_PET;
                                                                    strNOM_MIS_PET = mis.strNOM_MIS_PET;
                                                                    selAttivita = "checked";
                                                                    selLuogo = "";
                                                                }
                                                            } else if (request.getParameter("ATTACH_SUBJECT") != null) {
                                                                strATTACH = request.getParameter("ATTACH_SUBJECT");
                                                                if (request.getParameter("ID_PARENT") != null) {
                                                                    if (strATTACH.equals("AUDIT_MAN")) {
                                                                        lCOD_MIS_PET_MAN = new Long(request.getParameter("ID_PARENT")).longValue();
                                                                        mis = home.getMisuraPreventivaByAttivita(lCOD_MIS_PET_MAN, lCOD_AZL);
                                                                        lCOD_MIS_PET = mis.lCOD_MIS_PET;
                                                                        strNOM_MIS_PET = mis.strNOM_MIS_PET;
                                                                        selAttivita = "checked";
                                                                        selLuogo = "";
                                                                    }
                                                                    if (strATTACH.equals("AUDIT")) {
                                                                        lCOD_MIS_RSO_LUO = new Long(request.getParameter("ID_PARENT")).longValue();
                                                                        mis = home.getMisuraPreventivaByLuogo(lCOD_MIS_RSO_LUO, lCOD_AZL);
                                                                        lCOD_MIS_PET = mis.lCOD_MIS_PET;
                                                                        strNOM_MIS_PET = mis.strNOM_MIS_PET;
                                                                        selLuogo = "checked";
                                                                        selAttivita = "";
                                                                    }
                                                                }
                                                            }
                                                        %>
                                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.misura.di.prevenzione.applicata.a")%></legend>
                                                        <table cellpadding="0" cellspacing="0" width="100%" style="margin: 5 0 9 0" border="0">
                                                            <tr>
                                                                <td>&nbsp;&nbsp;&nbsp;</td>
                                                                <td align="right" nowrap>&nbsp;<LABEL for="RB_LUO_FSC"><%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%>&nbsp;</LABEL></td>
                                                                <td align="left" width="10%" id="">
                                                                    <input tabindex="1" type="radio" style="" <%= selLuogo%> class="checkbox" value="L" id="RB_LUO_FSC" name="RB_LUO_FSC_MAN">
                                                                </td>
                                                                <td align="right" nowrap>
                                                                    &nbsp;<LABEL for="RB_MAN"><%=ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa")%>&nbsp;</LABEL>
                                                                </td>
                                                                <td align="left" style="width:10%">
                                                                    <input tabindex="2" type="radio" class="checkbox" <%= selAttivita%>  value="M" id="RB_MAN" name="RB_LUO_FSC_MAN">
                                                                </td>
                                                                <td align="right">
                                                                    &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Misura")%>&nbsp;
                                                                </td>
                                                                <td align="left" style="width:60%">
                                                                    <input tabindex="3" type="hidden" style="width:100%"  value="<%if (lCOD_MIS_RSO_LUO != 0) {
                                                                                out.print(Formatter.format(lCOD_MIS_RSO_LUO));
                                                                            } %>" id="COD_MIS_RSO_LUO" name="COD_MIS_RSO_LUO">
                                                                    <input tabindex="3" type="hidden" style="width:100%"  value="<%if (lCOD_MIS_PET_MAN != 0) {
                                                                                out.print(Formatter.format(lCOD_MIS_PET_MAN));
                                                                            } %>" id="COD_MIS_PET_MAN" name="COD_MIS_PET_MAN">
                                                                    <input tabindex="3" type="hidden" style="width:100%"  value="<%if (lCOD_MIS_PET != 0) {
                                                                                out.print(Formatter.format(lCOD_MIS_PET));
                                                                            }%>" id="COD_MIS_PET" name="COD_MIS_PET">
                                                                    <input tabindex="3" type="text"  style="width:100%"  value="<%=Formatter.format(strNOM_MIS_PET)%>" id="NOM_MIS_PET" name="NOM_MIS_PET">
                                                                </td>
                                                                <td>
                                                                    <button tabindex="4" class="getlist" onclick="getMisPetList()" id="btnMisPet">
                                                                        <strong>&middot;&middot;&middot;</strong>
                                                                    </button>							
                                                                </td>
                                                                <td>&nbsp;</td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" id="PRESIDIO">
                                                    <fieldset style="width:100%">
                                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.presidio.antincendio")%></legend>
                                                        <%
                                                            if (bean != null) {
                                                                ADT_PresidioView p = bean.getPresidio();
                                                                lCOD_PSD_ACD = p.lCOD_PSD_ACD;
                                                                strNOM_CAG_PSD_ACD = p.strNOM_CAG_PSD_ACD;
                                                                strIDE_PSD_ACD = p.strIDE_PSD_ACD;
                                                            }
                                                        %>
                                                        <table width="100%"  cellpadding="0" cellspacing="0" style="margin: 5 0 9 0" border="0">
                                                            <tr>
                                                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                                <td align="right" nowrap>
                                                                    <%=ApplicationConfigurator.LanguageManager.getString("Categoria")%>&nbsp;
                                                                </td>
                                                                <td  align="left" width="70%" id="">
                                                                    <input tabindex="5" type="hidden" style="width:100%" value="<%= Formatter.format(lCOD_PSD_ACD)%>"  id="COD_PSD_ACD" name="COD_PSD_ACD">
                                                                    <input tabindex="5" type="text"  style="width:100%"  value="<%= Formatter.format(strNOM_CAG_PSD_ACD)%>" id="NOM_CAG_PSD_ACD" name="NOM_CAG_PSD_ACD">
                                                                </td>
                                                                <td align="right" nowrap>
                                                                    &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Identificativo")%>&nbsp;
                                                                </td>
                                                                <td align="left" style="width:20%">
                                                                    <input tabindex="6" type="text"   style="width:100%" value="<%= Formatter.format(strIDE_PSD_ACD)%>" id="IDE_PSD_ACD" name="IDENTIFICATORE">
                                                                </td>
                                                                <td>
                                                                    <button tabindex="7" class="getlist" onclick="getPresidiList()" id="btnMisPet">
                                                                        <strong>&middot;&middot;&middot;</strong>
                                                                    </button>							
                                                                </td>
                                                                <td>&nbsp;</td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr><td style="height:7px"></td></tr>
                                            <tr>
                                                <td  align="center" id="">
                                                    <table width="100%" style=""  cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td align="left" nowrap>
                                                                &nbsp;&nbsp;&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%>&nbsp;
                                                            </td>
                                                            <td  align="left" width="45%" id="">
                                                                <select tabindex="8" id="NOM_LUO_FSC" style="width:100%"  name="COD_LUO_FSC">
                                                                    <option value=""></option>
                                                                    <% 
                                                                        col = aHome.getAnagrLuoghiFisici_List_View(lCOD_AZL);
                                                                        String str = BuildLuogoFisicoComboBox(col, lCOD_LUO_FSC);
                                                                        out.println(str);
                                                                    %>

                                                                </select>
                                                            </td>
                                                            <td align="right" nowrap>
                                                                &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Unità.org.")%>&nbsp;
                                                            </td>
                                                            <td align="left" style="width:45%">
                                                                <select  tabindex="9" style="width:100%" name="COD_UNI_ORG">
                                                                    <option value="0"></option>
                                                                    <%
                                                                        String nodes = uoHome.buildTreeNodes(uoBean, uoHome, 0, lCOD_UNI_ORG, lCOD_AZL, false);
                                                                        out.println(nodes);
                                                                    %>
                                                                </select>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr><td style="height:7px"></td></tr>
                                            <tr>
                                                <td  align="left" id="">
                                                    <table width="100%" style=""  cellpadding="0" cellspacing="0" border="0">
                                                        <tr>

                                                            <td align="right" nowrap width="15%">
                                                                <strong><%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione")%>&nbsp;</strong>
                                                            </td>
                                                            <td  align="left" width="15%" id="">
                                                                <s2s:Date tabindex="11"  value="<%= Formatter.format(dtDAT_PIF_INR)%>" id="DAT_PIF_INR" name="DAT_PIF_INR"/>
                                                            </td>
                                                            <td align="right" width="5%" nowrap>
                                                                &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Punteggio.teorico")%>&nbsp;
                                                            </td>
                                                            <td align="left" style="width:7%">
                                                                <input tabindex="12" type="text" maxlength="10"  style="width:100%" value="<%= lPNG_TEO%>" id="PNG_TEO" name="PNG_TEO">
                                                            </td>
                                                            <td align="right" nowrap width="10%">
                                                                &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Punteggio.rilevato")%>&nbsp;
                                                            </td>
                                                            <td align="left" style="width:15%">
                                                                <input tabindex="13" type="text" maxlength="10"  style="width:100%" value="<%= lPNG_RIL%>" id="PNG_RIL" name="PNG_RIL">
                                                            </td>
                                                            <td align="right" nowrap>
                                                                &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Punteggio.%")%>&nbsp;
                                                            </td>
                                                            <td align="left" style="width:10%">
                                                                <input tabindex="14" type="text" maxlength="3"  style="width:100%" value="<%= lPNG_PCT%>" id="PNG_PCT" name="PNG_PCT">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" nowrap>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Data.audit")%>&nbsp;
                                                            </td>
                                                            <td  align="left" width="15%" id="">
                                                                <s2s:Date tabindex="15" value="<%= Formatter.format(dtDAT_ADT)%>" id="DAT_ADT" name="DAT_ADT"/>
                                                            </td>
                                                            <td align="right" width="8%" colspan="2" nowrap>
                                                                &nbsp;<strong><%=ApplicationConfigurator.LanguageManager.getString("Piano.annuale(default)")%></strong>&nbsp;
                                                                <input tabindex="15" type="checkbox"  class="checkbox" <% if (strSEC_PNO_YEA.equals("S")) {
                                                                        out.print("checked");
                                                                    }%> value="S" id="SEC_PNO_YEA" name="SEC_PNO_YEA">
                                                            </td>
                                                            <td align="right" nowrap width="10%">
                                                                &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Visita.ispettiva")%>&nbsp;
                                                            </td>
                                                            <td align="left" style="width:15%">
                                                                <input tabindex="16" type="text" maxlength="10"  style="width:100%" value="<%= lNUM_VIS_ISP%>" id="NUM_VIS_ISP" name="NUM_VIS_ISP">
                                                            </td>
                                                            <td align="right" nowrap>

                                                            </td>
                                                            <td align="left" style="width:10%">

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" nowrap valign="top">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;
                                                            </td>
                                                            <td  align="left" colspan="7"  width="15%" id="">
                                                                <s2s:textarea  tabindex="17" id="DES_INR_ADT" cols="94" style="width:"  rows="5" name="DES_INR_ADT"><%= Formatter.format(strDES_INR_ADT)%></s2s:textarea>
                                                            </td>
                                                        </tr>	
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr><td>&nbsp;</td></tr>
                                        </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="100%">
                                    <div id="dContainer" class="mainTabContainer" style="width:100%;"></div>
                                </td>
                            </tr>
                        </table>
                    </form>
                </td>
            </tr>
        </table> 
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" id="ifrmWork" ></iframe>
        <script language="JavaScript" src="ANA_INR_ADT.js"></script>
        <%
            if (bean != null) {
        %>
        <script language="JavaScript">
            //--------BUTTONS description-----------------------
            btnParams = new Array();
            btnParams[0] = {"id": "btnNew",
                "onclick": OnClick,
                "action": "AddNew"
            };

            btnParams[1] = {"id": "btnEdit",
                "onclick": editRow,
                "action": "Edit"
            };
            btnParams[2] = {"id": "btnCancel",
                "onclick": delRow,
                "action": "Delete"
            };
            /*btnParams[3] = {"id":"btnRefresh", 
             "onclick":RefreshTab,
             "action":"Refresh"
             };*/
            //--------creating tabs--------------------------
            var tabbar = new TabBar("tbr1", document.all["dContainer"]);
            var btnBar = new ButtonPanel("batPanel1", btnParams);
            tabbar.addButtonBar(btnBar);        
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Non.conformita")%>", tabbar));
            tabbar.DEBUG_TABS_IFRM = false;
            //------adding tables to tabs ----------------------
            tabbar.idParentRecord = <%=Formatter.format(lCOD_INR_ADT)%>;
            tabbar.refreshTabUrl = "ANA_INR_ADT_RefreshTabs.jsp";
            tabbar.RefreshAllTabs();
            //----add action parameters to tabs ----------------
            tabbar.tabs[0].tabObj.actionParams = {"Feachures": {"dialogWidth": "850px",
                    "dialogHeight": "360px"
                },
                "AddNew": {"url": "../Form_ANA_NON_CFO/ANA_NON_CFO_Form.jsp?ATTACH_URL=Form_ANA_INR_ADT/ANA_INR_ADT_Attach.jsp&ATTACH_SUBJECT=INR_NON_CFO",
                    "buttonIndex": 0
                },
                "Edit": {"url": "../Form_ANA_NON_CFO/ANA_NON_CFO_Form.jsp?ATTACH_URL=Form_ANA_INR_ADT/ANA_INR_ADT_Attach.jsp&ATTACH_SUBJECT=INR_NON_CFO",
                    "buttonIndex": 1
                },
                "Delete": {"url": "../Form_ANA_INR_ADT/ANA_INR_ADT_Delete.jsp?LOCAL_MODE=non_cfo",
                    "target_element": document.all["ifrmWork"],
                    "buttonIndex": 2
                }
            };
            //-----activate first tab--------------------------
            function OnClick() {
                addRow(this.action);
            }
        </script>
        <%} else {%>
        <script>
            window.dialogHeight = "490px";
        </script>
        <%}%>
    </body>
</html>
