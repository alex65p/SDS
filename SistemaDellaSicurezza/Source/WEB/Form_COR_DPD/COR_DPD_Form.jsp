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
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.DipendenteCorsi.*" %>

<%@ page import="java.text.*" %>
<%@ page import="java.util.Collection" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<html>
    <head>
        <title><%=ApplicationConfigurator.LanguageManager.getString("Corsi")%></title>
        <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
        <script language="JavaScript" src="COR_DPD_Script.js"></script>
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

    <script>
        window.dialogWidth="800px";
        window.dialogHeight="340px";
    </script>

    <body>
        <%
            IDipendenteHome home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
            IDipendenteCorsiHome homeCorsi = (IDipendenteCorsiHome) PseudoContext.lookup("DipendenteCorsiBean");

            long lCOD_AZL = Security.getAzienda();
            long lCOD_COR = 0;
            long lCOD_DPD = 0;
            java.sql.Date dtDAT_EFT_TES_VRF = null;
            java.sql.Date dtDAT_EFT_COR = null;
            String strATE_FRE_DPD = "";
            String strMAT_CSG = "";
            String strESI_TES_VRF = "";
            long lPTG_OTT_DPD = 0;
            String DISABL = "";
            String ADDD = "";
            java.sql.Date dtDAT_CSG_MAT = null;

            lCOD_DPD = new Long(request.getParameter("ID_PARENT"));
            if (!(request.getParameter("ID") == null || request.getParameter("ID").equals(""))) {
                lCOD_COR = new Long(request.getParameter("ID"));
            } else if (!(request.getParameter("COD_COR") == null || request.getParameter("COD_COR").equals("0"))) {
                lCOD_COR = new Long(request.getParameter("COD_COR"));
            }

            if (lCOD_COR > 0) {
                dtDAT_EFT_COR = java.sql.Date.valueOf(request.getParameter("dat_eft_cor"));
                try {
                    Collection<DipendentiCorsi> col =
                            homeCorsi.getDipendentiCorsi(lCOD_COR, lCOD_AZL, lCOD_DPD, dtDAT_EFT_COR);
                    for (DipendentiCorsi riga : col) {
                        dtDAT_EFT_TES_VRF = riga.DAT_EFT_TES_VRF;
                        strATE_FRE_DPD = riga.ATE_FRE_DPD;
                        strMAT_CSG = riga.MAT_CSG;
                        strESI_TES_VRF = riga.ESI_TES_VRF;
                        lPTG_OTT_DPD = riga.PTG_OTT_DPD;
                    }

                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            if (dtDAT_EFT_COR != null) {
                Format df = new SimpleDateFormat("dd/MM/yyyy");
                String dataStringa = df.format(dtDAT_EFT_COR);

                if (dataStringa.equals("01/01/1900")) {
                    dtDAT_EFT_COR = null;
                }
            }
            if (strMAT_CSG.equals("")) {
                ADDD = "add";
            } else {
                DISABL = "disabled";
            }
        %>
        <!-- form for addind  corbean-->
        <form action="COR_DPD_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value="<%if ((lCOD_COR == 0) || (ADDD.equals("add"))) {
                    out.print("new");
                } else {
                    out.print("edt");
                }%>">
            <input type="hidden" name="COD_DPD" value="<%=lCOD_DPD%>">
            <input type="hidden" name="AZL_ID" value="<%=lCOD_AZL%>">
            <input type="hidden" name="oldDAT_EFT_COR" value="<%=dtDAT_EFT_COR%>">
            <table width="100%" border="0">
                <tr>
                    <td valign="top">
                        <table  width="100%">
                            <tr><td class="title"><%=ApplicationConfigurator.LanguageManager.getString("Corsi")%></td></tr>
                            <tr>
                                <td>
                                    <!-- ############################ -->
                                    <table border=0>
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%
                                            ToolBar.bShowDelete = false;
                                            ToolBar.bShowPrint = false;
                                            ToolBar.bShowReturn = false;
                                            ToolBar.bShowSearch = false;
                                        %>
                                        <%=ToolBar.build(2)%>
                                    </table>
                                    <!-- ########################### -->
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.corso")%></legend>
                                        <table  width="100%" border="0">
                                            <tr>
                                                <td align="right" width="15%"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
                                                <td  colspan="6">
                                                    <select style="width:100%" name="COR_DPD" id="COR_DPD" <%=DISABL%> onchange="changeFields(this.value)">
                                                        <option></option>
                                                        <%
                                                            String str = "";
                                                            String strSEL = "";
                                                            java.util.Collection col = home.getDipendente_CORCOM_View();
                                                            java.util.Iterator it1 = col.iterator();
                                                            while (it1.hasNext()) {
                                                                Dipendente_CORCOM_View dt = (Dipendente_CORCOM_View) it1.next();
                                                                strSEL = "";
                                                                if (lCOD_COR != 0) {
                                                                    if (lCOD_COR == dt.COD_COR) {
                                                                        strSEL = "selected";
                                                                    }
                                                                }
                                                                str = str + "<option " + strSEL + " value=\"" + dt.COD_COR + "\">" + dt.NOM_COR + "</option>";
                                                            }
                                                            out.print(str);
                                                        %>
                                                    </select>
                                                </td>
                                            </tr>
                                            <%
                                                if (DISABL.equals("disabled")) {
                                                    out.print("<input type='hidden' name='COR_DPD' value=\"" + lCOD_COR + "\">");
                                                }
                                            %>
                                            <tr>
                                                <td valign="top" align="right" ><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                                <td colspan="6">
                                                    <textarea rows="5" cols="110" name="DES_COR" id="DES_COR" readonly></textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Data.corso")%></b>&nbsp;</td>

                                                <td colspan="5">
                                                    <s2s:Date id="DAT_EFT_COR" name="DAT_EFT_COR" value="<%=Formatter.format(dtDAT_EFT_COR)%>"/>
                                                </td>

                                                <td rowspan="3" width="15%" valign="top" align="center">
                                                    <fieldset>
                                                        <legend><b><%=ApplicationConfigurator.LanguageManager.getString("Att.Freq.")%></b></legend>
                                                        <input class="checkbox" <%if (strATE_FRE_DPD.equals("S")) {
                                                                out.print("checked");
                                                            }%> type="radio" name="ATE_FRE_DPD" value="S">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Si")%>
                                                        <input class="checkbox" <%if (strATE_FRE_DPD.equals("N")) {
                                                                out.print("checked");
                                                            }%> type="radio" name="ATE_FRE_DPD" value="N">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("No")%>
                                                    </fieldset>
                                                    <br>
                                                    <fieldset>
                                                        <legend><b><%=ApplicationConfigurator.LanguageManager.getString("Mat.Cons.")%></b></legend>
                                                        <input class="checkbox" <%if (strMAT_CSG.equals("S")) {
                                                                out.print("checked");
                                                            }%> type="radio" name="MAT_CSG" value="S">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Si")%>
                                                        <input class="checkbox" <%if (strMAT_CSG.equals("N")) {
                                                                out.print("checked");
                                                            }%> type="radio" name="MAT_CSG" value="N">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("No")%>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.test")%>&nbsp;</td>
                                                <td valign="top">
                                                    <s2s:Date id="DAT_EFT_TES_VRF" name="DAT_EFT_TES_VRF" value="<%=Formatter.format(dtDAT_EFT_TES_VRF)%>"/>
                                                </td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Punteggio")%>&nbsp;</td>
                                                <td>
                                                    <input type="text" size="20" maxlength="20" name="PTG_OTT_DPD" value="<%=Formatter.format(lPTG_OTT_DPD)%>">
                                                </td>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Esito.test")%>&nbsp;</b></td>
                                                <td>
                                                    <select style="width:100px" name="ESI_TES_VRF">
                                                        <option></option>
                                                        <option <%if (strESI_TES_VRF.equals("P")) {
                                                                out.print("selected");
                                                            }%> value="P"><%=ApplicationConfigurator.LanguageManager.getString("POSITIVO")%></option>
                                                        <option <%if (strESI_TES_VRF.equals("N")) {
                                                                out.print("selected");
                                                            }%> value="N"><%=ApplicationConfigurator.LanguageManager.getString("NEGATIVO")%></option>
                                                        <option <%if (strESI_TES_VRF.equals("D")) {
                                                                out.print("selected");
                                                            }%> value="D"><%=ApplicationConfigurator.LanguageManager.getString("DA.FARE")%></option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="middle" align="right" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Data.consegna.materiale")%>&nbsp;</td>
                                                <td colspan="5" valign="top">
                                                    <s2s:Date  id="DAT_CSG_MAT" name="DAT_CSG_MAT" value="<%=Formatter.format(dtDAT_CSG_MAT)%>"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td></tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>

        <!-- /form for addind  corbean-->
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <%
            if (lCOD_COR != 0) {
        %><script>changeFields(<%=lCOD_COR%>);</script><%
            }
        %>
    </body>
</html>
