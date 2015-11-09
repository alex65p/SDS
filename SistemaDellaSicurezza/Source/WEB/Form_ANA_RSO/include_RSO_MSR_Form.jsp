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
<link rel="stylesheet" href="../_styles/style.css">
<link rel="stylesheet" href="../_styles/tabs.css">
<script src="../_scripts/tabs.js"></script>
<script src="../_scripts/tabbarButtonFunctions.js"></script>
<script src="../_scripts/js_ANA_AZL.js"></script>
<script src="../_scripts/Alert.js"></script>
<fieldset>
    <legend><%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.rischio")%></legend>
    <table border="0" width="100%">
        <tr style="display:none">
            <td colspan="6">
                <% if (bean != null) {%>
                <input name="SBM_MODE" type="Hidden" value="edt">
                <%} else {%>
                <input name="SBM_MODE" type="Hidden" value="new">
                <%}%>
            </td>
        </tr>
        <tr style="display:none">
            <td colspan="6">
                <input name="COD_RSO" type="Hidden" value="<%=Formatter.format(lCOD_RSO)%>">
            </td>
        </tr>
        <tr>
            <td  align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome.rischio")%></b>&nbsp;</td>
            <td colspan="5">
                <input style="width:100%;" tabindex="1" type="text" size="50" maxlength="100"  name="NOM_RSO"  id="NOM_RSO" value="<%=Formatter.format(strNOM_RSO)%>">
            </td>
        </tr>
        <tr>
            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio")%></b>&nbsp;</td>
            <td colspan="5" tabindex="2">
                <%
                    class FactorBuilder implements IComboParser {

                        public void parse(Object obj, ComboItem item) {
                            RischioFattore_ComboView w = (RischioFattore_ComboView) obj;
                            item.lIndex = w.lCOD_FAT_RSO;
                            item.strValue = w.strNOM_FAT_RSO;
                        }
                    }

                    IRischioFattoreHome hrfb = (IRischioFattoreHome) PseudoContext.lookup("RischioFattoreBean");
                    ComboBuilder b = new ComboBuilder(lCOD_FAT_RSO, new FactorBuilder(), hrfb.getComboView());
                    b.strName = "COD_FAT_RSO";
                %>
                <%=b.build()%>
            </td>
        </tr>
        <tr>                                                

            <%
                boolean bInList = false;
            %>
            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Classificazione.rischio")%></b>&nbsp;</td>
            <td>
                <SELECT tabindex="4" name="CLF_RSO">
                    <option selected></option>
                    <option selected value="PER TUTTI"
                            <%
                                if (strCLF_RSO.equals("PER TUTTI")) {
                                    bInList = true;
                                    out.print("selected");
                                }
                            %>
                            >
                        <%=ApplicationConfigurator.LanguageManager.getString("PER.TUTTI")%>
                    </option>
                    <option value="PER OPERATORE"
                            <%
                                if (strCLF_RSO.equals("PER OPERATORE")) {
                                    bInList = true;
                                    out.print("selected");
                                }
                            %>
                            >
                        <%=ApplicationConfigurator.LanguageManager.getString("PER.OPERATORE")%>
                    </option>
                </SELECT>
            </td>

        </tr>

        <tr>
            <td colspan="6">
                <fieldset class="stimaRischio">
                    <legend class="stimaRischio">
                        <%=ApplicationConfigurator.LanguageManager.getString("Stima.numerica.del.rischio")%>
                    </legend>
                    <table border="0" width="100%">
                        <tr>
                            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Probabilità.evento.lesivo")%></b>&nbsp;</td>
                            <td>
                                <input tabindex="7" type="text" size="10" maxlength="2"  name="PRB_EVE_LES"
                                       value="<%=bean == null ? "" : Formatter.format(lPRB_EVE_LES)%>"
                                       onchange="<%=sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED ? "RecalculateExtended()" : "Recalculate()"%>">
                            </td>
                            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Entità.danno")%></b>&nbsp;</td>
                            <td>
                                <input  tabindex="8" type="text" size="10"  maxlength="2"  name="ENT_DAN"
                                        value="<%=bean == null ? "" : Formatter.format(lENT_DAN)%>"
                                        onchange="<%=sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED ? "RecalculateExtended()" : "Recalculate()"%>">
                            </td>
                            <% if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {%>
                            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Frequenza.dell'attività.a.rischio")%></b>&nbsp;</td>
                            <td>
                                <input tabindex="9" type="text" size="10"  maxlength="2"  name="FRQ_RIP_ATT_DAN" value="<%=bean == null ? "" : Formatter.format(lFRQ_RIP_ATT_DAN)%>" onchange="RecalculateExtended()">
                            </td>
                            <td align="right">
                                <b><%=ApplicationConfigurator.LanguageManager.getString("Numero.di.incidenti/infortuni.(negli.ultimi.3.anni)")%></b>&nbsp;
                            </td>
                            <td>
                                <input tabindex="10" type="text" size="10"  maxlength="2"  name="NUM_INC_INF" value="<%=bean == null ? "" : Formatter.format(lNUM_INC_INF)%>" onchange="RecalculateExtended()">
                            </td>
                            <% }%>
                            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Stima.numerica.del.rischio")%></b>&nbsp;</td>
                            <td>
                                <input class="stimaRischio" tabindex="11" readonly type="text" size="10" name="STM_NUM_RSO" value="<%=bean == null ? "" : Formatter.format(lSTM_NUM_RSO)%>">&nbsp;&nbsp;
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
        <script>
            function RecalculateExtended() {
                var FattoreMoltiplicativo = 1 + (document.forms[0].NUM_INC_INF.value - 1) * 0.5;
                var StimaRischio = document.forms[0].ENT_DAN.value *
                        document.forms[0].FRQ_RIP_ATT_DAN.value *
                        document.forms[0].PRB_EVE_LES.value *
                        FattoreMoltiplicativo;
                SetStimaRischio(StimaRischio);
            }

            function Recalculate() {
                var StimaRischio = (document.forms[0].ENT_DAN.value) * (document.forms[0].PRB_EVE_LES.value);
                SetStimaRischio(StimaRischio);
            }

            function SetStimaRischio(sr) {
                if (sr == null || sr == "NaN")
                    x = 0;
                document.forms[0].STM_NUM_RSO.value = sr;
            }

        </script>
        <%

            if (bCalledFromMachina) {
                if (bean != null) {
                    String _strID = (String) request.getParameter("ID_PARENT");
                    IMacchinaHome _home = (IMacchinaHome) PseudoContext.lookup("MacchinaBean");
                    Long _id = new Long(_strID);
                    //IMacchina _bean = _home.findByPrimaryKey(_id);
                    IMacchina _bean = _home.findByPrimaryKey(new MacchinaPK(Security.getAzienda(), _id.longValue()));
                    //lCOD_RSO;
                    Iterator it = _bean.getTipClassView(lCOD_RSO, lCOD_AZL).iterator();
                    if (it != null) {
                        while (it.hasNext()) {
                            RischioMacchinaView view = (RischioMacchinaView) it.next();
                            strTPL_CLF_RSO = view.strTPL_CLF_RSO;
                        }
                    }
                }
            }
            if (bCalledFromSostanza) {
                if (bean != null) {
                    String _strID = (String) request.getParameter("ID_PARENT");
                    IAssociativaAgentoChimicoHome _home = (IAssociativaAgentoChimicoHome) PseudoContext.lookup("AssociativaAgentoChimicoBean");
                    Long _id = new Long(_strID);
                    IAssociativaAgentoChimico _bean = _home.findByPrimaryKey(_id);
                    strTPL_CLF_RSO = _bean.getTipClassView(lCOD_RSO, lCOD_AZL);
                }
            }
            if (strTPL_CLF_RSO.equals("")) {
                strTPL_CLF_RSO = "O";
            }
        %>
        <%
            if (bCalledFromMachina || bCalledFromSostanza) {
                if (bean != null) {
        %>

        <tr>
            <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Rischio.per")%></b></td>
            <td colspan=2>
                <SELECT name="CLF_RSO" onchange="OnPerChange(this)" tabindex="12">
                    <option  value="O" <%if (strTPL_CLF_RSO.equals("O")) {
                            out.print("selected");
                        }%>><%=ApplicationConfigurator.LanguageManager.getString("OPERATORE")%></option>
                    <option value="T" <%if (strTPL_CLF_RSO.equals("T")) {
                            out.print("selected");
                        }%>><%=ApplicationConfigurator.LanguageManager.getString("TUTTI")%></option>
                    <option value="O/T" <%if (strTPL_CLF_RSO.equals("O/T")) {
                            out.print("selected");
                        }%>><%=ApplicationConfigurator.LanguageManager.getString("OPERATORE.TUTTI")%></option>
                </SELECT>
            </td>
        </tr>
        <%
                }
            }
        %>
        <tr>
            <td align="right" valign="top"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione.rischio")%></b>&nbsp;</td>
            <td colspan="5">
                <TEXTAREA tabindex="13" style="width:720px;" name="DES_RSO"><%=Formatter.format(strDES_RSO)%></TEXTAREA>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
       
