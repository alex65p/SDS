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
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.SediLesione.*" %>
<%@ page import="com.apconsulting.luna.ejb.InfortuniIncidenti.*" %>
<%@ page import="com.apconsulting.luna.ejb.NaturaLesione.*" %>
<%@ page import="com.apconsulting.luna.ejb.AgenteMateriale.*" %>
<%@ page import="com.apconsulting.luna.ejb.TipologieFormeDinfortunio.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Localization.jsp"%>
<%@ include file="ANA_INO_Util.jsp" %>
<%@ include file="../_include/ComboBox-Dipendente.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

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
        <script type="text/javascript">
            document.write("<title>" + getCompleteMenuPath(SubMenuInfortuni,6) + "</title>");
        </script>
        <link rel=stylesheet href="../_styles/style.css" type="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css" type="text/css">
        <link rel="stylesheet" href="../_styles/index.css" type="text/css">
        <script type="text/javascript" src="../_scripts/tabs.js"></script>
        <script type="text/javascript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <script type="text/javascript" src="../_scripts/utility-date.js"></script>
        <script type="text/javascript" src="../_scripts/ajax.js"></script>
        <script type="text/javascript" src="ANA_INO.js"></script>
    </head>
    <script type="text/javascript">
        /*
        if(!controllo_data(data1) && !controllo_data(data2)){
            alert('Inserire le date nel formato gg/mm/aaaa');
            return -1;
        }
        if(!confronta_data(data1,data2)){
            diff=data2str-data1str;
            alert('La data di inizio deve essere precedente quella di fine');
            return -1;
        }
         */
        window.dialogWidth="1000px";
        window.dialogHeight="740px";
    </script>
    <body>
        <%
                    IInfortuniIncidentiHome home = (IInfortuniIncidentiHome) PseudoContext.lookup("InfortuniIncidentiBean");
                    IInfortuniIncidenti bean = null;

                    IDipendenteHome dhome = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
                    IDipendente dbean = null;

                    ISediLesioneHome shome = (ISediLesioneHome) PseudoContext.lookup("SediLesioneBean");
                    INaturaLesioneHome nhome = (INaturaLesioneHome) PseudoContext.lookup("NaturaLesioneBean");
                    IAgenteMaterialeHome ahome = (IAgenteMaterialeHome) PseudoContext.lookup("AgenteMaterialeBean");
                    IAnagrLuoghiFisiciHome lhome = (IAnagrLuoghiFisiciHome) PseudoContext.lookup("AnagrLuoghiFisiciBean");
                    ITipologieFormeDinfortunioHome thome = (ITipologieFormeDinfortunioHome) PseudoContext.lookup("TipologieFormeDinfortunioBean");

                    boolean GEST_INFO_EXTENDED = ApplicationConfigurator.isModuleEnabled(MODULES.GEST_INFO_EXTENDED);
                    Long INO_id = null;
                    long lCOD_INO = 0;
                    String strNOM_COM_INO = "";
                    String dtDAT_COM_INO = "";
                    String dtDAT_EVE_INO = "";
                    String strORA_EVE_INO = "";
                    String strGOR_LAV_INO = "";
                    String strORA_LAV_INO = "";
                    String strORA_LAV_TUN_INO = "";
                    String strTPL_TRA_EVE_INO = "";
                    String strIDZ_TRA_EVE_INO = "";
                    String dtDAT_TRA_EVE_INO = "";
                    String dtDAT_INZ_ASZ_LAV = "";
                    String dtDAT_FIE_ASZ_LAV = "";
                    String lGOR_ASZ = "";
                    String strIN_ITI="N";
                    String strNON_IND="N";
                    String strMEZ_TRA="";
                    String dtDAT_TRA = "";
                    String strLUO_TRA="";

                    //  Dinamica di incidente
                    String strDIN_INC_INO = "";

                    // Codice Infortunio relazionato al precedente
                    long lCOD_INO_REL = 0;

                    String strDES_EVE_INO = "";
                    String strDES_ANL_INO = "";
                    String strDES_CRZ_INO = "";
                    String strDES_RAC_INO = "";
                    String strDES_DVU_INO = "";
                    long lCOD_AGE_MAT = 0;
                    long lCOD_TPL_FRM_INO = 0;
                    long lCOD_NAT_LES = 0;
                    long lCOD_SED_LES = 0;
                    long lCOD_LUO_FSC = 0;
                    long lCOD_DPD = 0;
                    long lCOD_AZL = Security.getAzienda();
                    String strNOM_AZL = "";
                    String strORA_EVE_INO_HOUR = "";
                    String strORA_EVE_INO_MIN = "";

                    java.util.Iterator iterInfortuniDipendente = null;

                    if (request.getParameter("ID") != null) {
                        INO_id = new Long(request.getParameter("ID"));
                        bean = home.findByPrimaryKey(INO_id);
                        dbean = dhome.findByPrimaryKey(bean.getCOD_DPD());

                        lCOD_INO = bean.getCOD_INO();
                        strNOM_COM_INO = Formatter.format(bean.getNOM_COM_INO());
                        dtDAT_COM_INO = Formatter.format(bean.getDAT_COM_INO());
                        dtDAT_EVE_INO = Formatter.format(bean.getDAT_EVE_INO());
                        strORA_EVE_INO = Formatter.format(bean.getORA_EVE_INO());
                        strGOR_LAV_INO = Formatter.format(bean.getGOR_LAV_INO());
                        strORA_LAV_INO = Formatter.format(bean.getORA_LAV_INO());
                        strORA_LAV_TUN_INO = Formatter.format(bean.getORA_LAV_TUN_INO());
                        strTPL_TRA_EVE_INO = Formatter.format(bean.getTPL_TRA_EVE_INO());
                        strIDZ_TRA_EVE_INO = Formatter.format(bean.getIDZ_TRA_EVE_INO());
                        dtDAT_TRA_EVE_INO = Formatter.format(bean.getDAT_TRA_EVE_INO());
                        dtDAT_INZ_ASZ_LAV = Formatter.format(bean.getDAT_INZ_ASZ_LAV());
                        dtDAT_FIE_ASZ_LAV = Formatter.format(bean.getDAT_FIE_ASZ_LAV());
                        lGOR_ASZ = Formatter.format(bean.getGOR_ASZ());
                        strIN_ITI = Formatter.format(bean.getIN_ITI());
                        strNON_IND = Formatter.format(bean.getNON_IND());
                        strMEZ_TRA = Formatter.format(bean.getMEZ_TRA());
                        dtDAT_TRA = Formatter.format(bean.getDAT_TRA());
                        strLUO_TRA = Formatter.format(bean.getLUO_TRA());

                        //  Dinamica di incidente
                        strDIN_INC_INO = Formatter.format(bean.getDIN_INC_INO());

                        //  Codice Infortunio relazionato al precedente
                        lCOD_INO_REL = bean.getCOD_INO_REL();

                        strDES_EVE_INO = Formatter.format(bean.getDES_EVE_INO());
                        strDES_ANL_INO = Formatter.format(bean.getDES_ANL_INO());
                        strDES_CRZ_INO = Formatter.format(bean.getDES_CRZ_INO());
                        strDES_RAC_INO = Formatter.format(bean.getDES_RAC_INO());
                        strDES_DVU_INO = Formatter.format(bean.getDES_DVU_INO());
                        lCOD_AGE_MAT = bean.getCOD_AGE_MAT();
                        lCOD_TPL_FRM_INO = bean.getCOD_TPL_FRM_INO();
                        lCOD_NAT_LES = bean.getCOD_NAT_LES();
                        lCOD_SED_LES = bean.getCOD_SED_LES();
                        lCOD_LUO_FSC = bean.getCOD_LUO_FSC();
                        lCOD_DPD = bean.getCOD_DPD();
                        lCOD_AZL = bean.getCOD_AZL();

                        if (strORA_EVE_INO.length() > 4) {
                            strORA_EVE_INO_HOUR = strORA_EVE_INO.substring(0, 2);
                            strORA_EVE_INO_MIN = strORA_EVE_INO.substring(3, 5);
                        }
                       // java.util.Collection infortuniDipendente = home.getInfortuniIncidentiDipendenteView(COD_DPD, COD_AZL, DAT_EVE_INO, COD_INO, COD_INO_REL));
                       // iterInfortuniDipendente = infortuniDipendente.iterator();
                    }

                    IAzienda azienda = null;
                    IAziendaHome AziendaHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");

                    Long azl_id = new Long(lCOD_AZL);
                    azienda = AziendaHome.findByPrimaryKey(azl_id);
                    strNOM_AZL = azienda.getRAG_SCL_AZL();
        %>
        <form action="ANA_INO_Set.jsp" method="post" target="ifrmWork" name="form_infortuni" id="form_infortuni_id">
            <input type="hidden" name="SBM_MODE" value="<%=(lCOD_INO == 0) ? "new" : "edt"%>">
            <input type="hidden" name="COD_INO" value="<%=lCOD_INO%>">
            <input type="hidden" name="COD_AZL" value="<%=lCOD_AZL%>">
            <table width="100%" border="0">
                <tr>
                    <td class="title">
                        <script type="text/javascript">
                            document.write(getCompleteMenuPathFunction
                            (SubMenuInfortuni,6,<%=request.getParameter("ID")%>));
                        </script>
                    </td>
                </tr>
                <tr>
                    <td>
                        <!-- ############################ -->
                        <table width="100%" border="0">
                            <%@ include file="../_include/ToolBar.jsp" %>
                            <%
                    ToolBar.bCanDelete = (bean != null);
                    ToolBar.bShowPrint2 = true;
                    ToolBar.bCanPrint2 = true;
                    ToolBar.strPrintUrl = "SchedaInfortunioIncidente.jsp?";
                            %>
                            <%=ToolBar.build(4)%>
                        </table>
                        <!-- ########################### -->
                    </td>
                </tr>
                <tr>
                    <td>
                        <fieldset>
                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.infortunio/incidente")%></legend>
                            <table width="100%" border="0">
                                <tr>
                                    <td>
                                        <fieldset>
                                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.lavoratore")%></legend>
                                            <table width="100%">
                                                <tr>
                                                    <td width="95px" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
                                                    <td align="left"><input type="text" size="100" readonly value="<%=strNOM_AZL%>" style="width:100%;"></td>
                                                </tr>
                                                <tr>
                                                    <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Lavoratore")%>&nbsp;</b></td>
                                                    <td align="left">
                                                        <% if (bean == null){ %>
                                                        <select tabindex="1"  onchange="checkRiaperturaInfortuni('checkRiaperturaInfortuni.jsp?COD_DPD='+this.value+'&DAT_EVE_INO='+document.getElementById('DAT_EVE_INO').value+'&COD_INO='+document.getElementById('COD_INO').value+'&COD_INO_REL='+document.getElementById('ID_COD_REL_INO').value,document.getElementById('IDMessage'));" name="COD_DPD" style="width:100%;">
                                                            <option value="0"></option>=
                                                            <%=BuildDipendenteComboBox(dhome, lCOD_DPD, lCOD_AZL)%>
                                                        </select>
                                                        <% } else { %>
                                                        <input tabindex="1" style="width:100%;"
                                                               value="<%=dbean.getMTR_DPD()+" - "+dbean.getCOG_DPD()+" "+dbean.getNOM_DPD()%>"
                                                               disabled>
                                                        <input type="hidden" name="COD_DPD" value="<%=lCOD_DPD%>">
                                                        <% } %>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <!-- inizio tabella -->
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td align="right" nowrap><b><%=ApplicationConfigurator.LanguageManager.getString("Sede.lesione")%>&nbsp;</b></td>
                                                <td width="450px" align="left">
                                                    <select tabindex="2" name="COD_SED_LES" style="width:100%;">
                                                        <option></option>
                                                        <%=BuildSediLesioneComboBox(shome, lCOD_SED_LES)%>
                                                    </select>
                                                </td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.comunicazione")%>&nbsp;</td>
                                                <td align="left">
                                                    <s2s:Date tabindex="3" onchange="data_valida();" id="DAT_COM_INO" name="DAT_COM_INO" value="<%=dtDAT_COM_INO%>"/></td>
                                                <td align="right" width="10%"><%=ApplicationConfigurator.LanguageManager.getString("Ora.della.comunicazione")%>&nbsp;</td>
                                                <td align="left"><input tabindex="4" type="text" size="5" maxlength="5"  name="ORA_LAV_INO" value="<%=strORA_LAV_INO%>"></td>
                                                <!--td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.evento")%>&nbsp;</td>
                                                <td align="left">
                                                <s2s:Date tabindex="5" id="DAT_EVE_INO" name="DAT_EVE_INO" value="<%=dtDAT_EVE_INO%>"
                                                          onchange="setGiornoLavorativo();checkRiaperturaInfortuni('checkRiaperturaInfortuni.jsp?COD_DPD='+document.getElementById('COD_DPD').value+'&DAT_EVE_INO='+document.getElementById('DAT_EVE_INO').value+'&COD_INO='+document.getElementById('COD_INO').value+'&COD_INO_REL='+document.getElementById('ID_COD_REL_INO').value,document.getElementById('IDMessage'));
                                                          data_valida();"/>
                                            </td-->
                                            <!--td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Ora.dell'evento.(hh.mm)")%>&nbsp;</td>
                                            <td align="left">
                                                <input tabindex="7" type="text" maxlength="2" name="ORA_EVE_INO_HOUR" value="<%=strORA_EVE_INO_HOUR%>" style="width:25px;">
                                                &nbsp;:&nbsp;
                                                <input tabindex="8" type="text" maxlength="2"  name="ORA_EVE_INO_MIN" value="<%=strORA_EVE_INO_MIN%>" style="width:25px;"></td-->
                                            </tr>
                                            <tr>
                                                <td align="right" nowrap><b><%=ApplicationConfigurator.LanguageManager.getString("Tipo.infortunio")%>&nbsp;</b></td>
                                                <td align="left">
                                                    <select tabindex="6" name="COD_TPL_FRM_INO" style="width:100%;">
                                                        <option></option>
                                                        <%=BuildTipologieFormeDinfortunioComboBox(thome, lCOD_TPL_FRM_INO)%>
                                                    </select>
                                                </td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.evento")%>&nbsp;</td>
                                                <td align="left">
                                                    <s2s:Date tabindex="7" id="DAT_EVE_INO" name="DAT_EVE_INO" value="<%=dtDAT_EVE_INO%>"
                                                              onchange="setGiornoLavorativo();checkRiaperturaInfortuni('checkRiaperturaInfortuni.jsp?COD_DPD='+document.getElementById('COD_DPD').value+'&DAT_EVE_INO='+document.getElementById('DAT_EVE_INO').value+'&COD_INO='+document.getElementById('COD_INO').value+'&COD_INO_REL='+document.getElementById('ID_COD_REL_INO').value,document.getElementById('IDMessage'));
                                                              data_valida();"/>
                                                </td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Ora.dell'evento.(hh.mm)")%>&nbsp;</td>
                                                <td align="left">
                                                    <input tabindex="8" type="text" maxlength="2" name="ORA_EVE_INO_HOUR" value="<%=strORA_EVE_INO_HOUR%>" style="width:25px;">
                                                    &nbsp;:&nbsp;
                                                    <input tabindex="9" type="text" maxlength="2"  name="ORA_EVE_INO_MIN" value="<%=strORA_EVE_INO_MIN%>" style="width:25px;"></td>

                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Giorno.lavorativo")%>&nbsp;</td>
                                                <td align="left">
                                                    <select style="width: 100%; display: none;" tabindex="10" name="GOR_LAV_INO" id="GOR_LAV_INO_ID">
                                                        <option value="-1" <%=("-1".equals(strGOR_LAV_INO)) ? "selected" : ""%>></option>
                                                        <option value="1" <%=("1".equals(strGOR_LAV_INO)) ? "selected" : ""%>><%=ApplicationConfigurator.LanguageManager.getString("Lunedì")%></option>
                                                        <option value="2" <%=("2".equals(strGOR_LAV_INO)) ? "selected" : ""%>><%=ApplicationConfigurator.LanguageManager.getString("Martedì")%></option>
                                                        <option value="3" <%=("3".equals(strGOR_LAV_INO)) ? "selected" : ""%>><%=ApplicationConfigurator.LanguageManager.getString("Mercoledì")%></option>
                                                        <option value="4" <%=("4".equals(strGOR_LAV_INO)) ? "selected" : ""%>><%=ApplicationConfigurator.LanguageManager.getString("Giovedì")%></option>
                                                        <option value="5" <%=("5".equals(strGOR_LAV_INO)) ? "selected" : ""%>><%=ApplicationConfigurator.LanguageManager.getString("Venerdì")%></option>
                                                        <option value="6" <%=("6".equals(strGOR_LAV_INO)) ? "selected" : ""%>><%=ApplicationConfigurator.LanguageManager.getString("Sabato")%></option>
                                                        <option value="0" <%=("0".equals(strGOR_LAV_INO)) ? "selected" : ""%>><%=ApplicationConfigurator.LanguageManager.getString("Domenica")%></option>
                                                    </select>
                                                    <input style="width: 100%;" tabindex="11" id="GOR_LAV_INO_TXT_ID" value="" readonly>
                                                    <script type="text/javascript">document.getElementById("GOR_LAV_INO_TXT_ID").value = getDayOfWeek(<%=strGOR_LAV_INO%>);</script>
                                                </td>
                                                <!--td align="right" width="10%"><%=ApplicationConfigurator.LanguageManager.getString("Ora")%>&nbsp;</td>
                                                <td align="left"><input tabindex="10" type="text" size="5" maxlength="5"  name="ORA_LAV_INO" value="<%=strORA_LAV_INO%>"></td-->
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Turno")%>&nbsp;</td>
                                                <td align="left"><input tabindex="12" type="text" size="15" maxlength="15" name="ORA_LAV_TUN_INO" value="<%=strORA_LAV_TUN_INO%>"></td>
                                            </tr>
                                            <tr>
                                                <td align="right" nowrap><b><%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%>&nbsp;</b></td>
                                                <td align="left">
                                                    <select tabindex="13" name="COD_LUO_FSC" style="width:100%;">
                                                        <option></option>
                                                        <%=BuildLuogoFisicoComboBox(lhome, lCOD_LUO_FSC, lCOD_AZL)%>
                                                    </select>
                                                </td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.inizio.assenza")%>&nbsp;</td>
                                                <td align="left"><s2s:Date tabindex="14" id="DAT_INZ_ASZ_LAV" onchange="giorni_differenza(document.getElementById('DAT_INZ_ASZ_LAV').value,document.getElementById('DAT_FIE_ASZ_LAV').value);data_valida();" name="DAT_INZ_ASZ_LAV" value="<%=dtDAT_INZ_ASZ_LAV%>"/></td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.fine.assenza")%>&nbsp;</td>
                                                <td align="left"><s2s:Date tabindex="15" id="DAT_FIE_ASZ_LAV" onchange="giorni_differenza(document.getElementById('DAT_INZ_ASZ_LAV').value,document.getElementById('DAT_FIE_ASZ_LAV').value);data_valida();" name="DAT_FIE_ASZ_LAV" value="<%=dtDAT_FIE_ASZ_LAV%>"/></td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Giorni.assenza")%>&nbsp;</td>
                                                <td align="left"><input style="width:100%;" id="GOR_ASZ" tabindex="16"  type="text" size="20" maxlength="20" name="GOR_ASZ" value="<%=lGOR_ASZ%>"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                        <tr style="display: <%=GEST_INFO_EXTENDED?"none":"block"%>;">
                                                            <td align="right" width="105px;"><%=ApplicationConfigurator.LanguageManager.getString("Competenza")%>&nbsp;</td>
                                                            <td colspan="3" align="left">
                                                                <input tabindex="17" type="text" maxlength="100"  name="NOM_COM_INO" value="<%=strNOM_COM_INO%>" style="width:100%;">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("In.itinere")%>&nbsp;
                                                            </td>
                                                            <td align="left">
                                                                <input type="checkbox" value="S" class="checkbox" name="IN_ITI" <%=(strIN_ITI.equals("S")) ? "checked" : ""%> tabindex="17">
                                                            </td>
                                                            <td align="right">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Non.indennizzato")%>&nbsp;
                                                            </td>
                                                            <td align="left">
                                                                <input type="checkbox" value="S" class="checkbox" name="NON_IND" <%=(strNON_IND.equals("S")) ? "checked" : ""%> tabindex="18">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4">
                                                                <input  type="hidden" id="ID_COD_REL_INO" name="COD_REL_INO" value="<%=lCOD_INO_REL%>">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione.evento")%>&nbsp;</td>
                                                <td colspan="100%" align="left"><TEXTAREA tabindex="18" cols="100" rows="2" name="DES_EVE_INO" style="width:100%;"><%=strDES_EVE_INO%></TEXTAREA></td>
                                            </tr>
                                            <tr>
                                                <td align="right" nowrap>
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Mezzo.di.trasporto")%>&nbsp;
                                                </td>
                                                <td align="left" colspan="5">
                                                    <input style="width:100%;" tabindex="19" type="text" size="20" maxlength="20" name="MEZ_TRA" value="<%=strMEZ_TRA%>">
                                                </td>
                                                <td align="right">
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Data.trasporto")%>&nbsp;
                                                </td>
                                                <td align="left"><s2s:Date tabindex="20" id="DAT_TRA" name="DAT_TRA" value="<%=dtDAT_TRA%>"/></td>
                                            </tr>
                                            <tr>
                                                <td align="right" nowrap>
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Luogo.di.trasporto")%>&nbsp;
                                                </td>
                                                <td align="left" colspan="7">
                                                    <input style="width:100%;" tabindex="21" type="text" size="20" maxlength="20" name="LUO_TRA" value="<%=strLUO_TRA%>">
                                                </td>
                                            </tr>
                                            <!-- Inizio Riapertura infortunio -->
                                            <tr>
                                                <td colspan="100%">
                                                    <fieldset>
                                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Riapertura.infortunio")%>
                                                        </legend>
                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td width="100%"><!-- CHECK-->
                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                        <tr>
                                                                            <td align="right"
                                                                                width="15%"><%=ApplicationConfigurator.LanguageManager.getString("Con.din.ca.inc.te")%>
                                                                                &nbsp;</td>
                                                                            <td width="5%"><input <%=((strDIN_INC_INO != null && strDIN_INC_INO.equals("C")) ? "checked='true'" : "")%>
                                                                                    tabindex="33" type="radio" id="CON_DIN_INC" class="checkbox"
                                                                                    name="DIN_INC_INO" value="C"></td>
                                                                            <td align="right"
                                                                                width="15%"
                                                                                nowrap><%=ApplicationConfigurator.LanguageManager.getString("Senza.din.ca.inc.te")%>
                                                                                &nbsp;</td>
                                                                            <td width="5%"><input <%=((strDIN_INC_INO != null && strDIN_INC_INO.equals("S")) ? "checked='true'" : "")%>
                                                                                    tabindex="34" type="radio" id="SZA_DIN_INC" class="checkbox"
                                                                                    name="DIN_INC_INO" value="S"></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <!--iNIZIO TABELLA -->
                                                                            <td valign="top" align="left" colspan="4">
                                                                                <table width="98%" border="0" class="VIEW_TABLE" cellpadding="0" cellspacing="0">
                                                                                    <tbody>
                                                                                        <tr class="VIEW_HEADER_TR">
                                                                                            <td width="251px" nowrap>
                                                                                                &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Sede.lesione")%>
                                                                                                &nbsp;</td>
                                                                                            <td width="251px" nowrap>
                                                                                                &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Tipo.infortunio")%>
                                                                                                &nbsp;</td>
                                                                                            <td width="251px" nowrap>
                                                                                                &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%>
                                                                                                &nbsp;</td>
                                                                                            <td width="92px" nowrap>
                                                                                                &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.evento")%>
                                                                                                &nbsp;</td>
                                                                                            <td width="92px" nowrap>
                                                                                                &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.com.ne")%>
                                                                                                &nbsp;</td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                </table>
                                                                            </td>
                                                                            <!--FINE TABELLA -->
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="4">
                                                                                <div id="IDMessage" style="width:100%;height:70px;overflow:auto">
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <!-- Fine Riapertura infortunio -->
                                        </table>
                                        <!-- fine tabella -->
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td colspan="100%"><div id="dContainer" class="mainTabContainer"></div></td>
                </tr>
            </table>
        </form>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <% if (INO_id != null) {%>
        <table border='0' id='AnalisiHeader' cellpadding='0' cellspacing='0'>
            <tr>
                <td>
                    <TEXTAREA cols="123" rows="11"  name="DES_ANL_INO" style="width: 680px; height: 170px;"><%=strDES_ANL_INO%></TEXTAREA>
                </td>
            </tr>
        </table>
        <table border='0' id='Analisi' class='dataTable' cellpadding='0' cellspacing='0'>
            <tr><td>&nbsp;</td></tr>
        </table>

        <table border='0' id='RaccomandazioniHeader' cellpadding='0' cellspacing='0'>
            <tr>
                <td>
                    <TEXTAREA cols="123" rows="11"  name="DES_RAC_INO" style="width: 680px; height: 170px;"><%=strDES_RAC_INO%></TEXTAREA>
                </td>
            </tr>
        </table>
        <table border='0' id='Raccomandazioni' class='dataTable' cellpadding='0' cellspacing='0'>
            <tr><td>&nbsp;</td></tr>
        </table>

        <table border='0' id='CorrezioneHeader' cellpadding='0' cellspacing='0'>
            <tr>
                <td>
                    <TEXTAREA cols="123" rows="11"  name="DES_CRZ_INO" style="width: 680px; height: 170px;"><%=strDES_CRZ_INO%></TEXTAREA>
                </td>
            </tr>
        </table>
        <table border='0' id='Correzione' class='dataTable' cellpadding='0' cellspacing='0'>
            <tr><td>&nbsp;</td></tr>
        </table>

        <table border='0' id='DivulgazioneHeader' cellpadding='0' cellspacing='0'>
            <tr>
                <td>
                    <TEXTAREA cols="123" rows="11"  name="DES_DVU_INO" style="width: 680px; height: 170px;"><%=strDES_DVU_INO%></TEXTAREA>
                </td>
            </tr>
        </table>
        <table border='0' id='Divulgazione' class='dataTable' cellpadding='0' cellspacing='0'>
            <tr><td>&nbsp;</td></tr>
        </table>

        <!--table border='0' id='TrasportoHeader' cellpadding='0' cellspacing='0'>
            <tr>
                <td align="left"><%=ApplicationConfigurator.LanguageManager.getString("Tipologia.trasporto")%>&nbsp;</td>
                <td><input type="text" size="30" maxlength="30"  name="TPL_TRA_EVE_INO" value="<%=strTPL_TRA_EVE_INO%>"></td>
                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.trasporto")%>&nbsp;</td>
                <td><s2s:Date id="DAT_TRA_EVE_INO" name="DAT_TRA_EVE_INO" value="<%=dtDAT_TRA_EVE_INO%>"/></td>
            </tr>
            <tr>
                <td colspan="4" height="8"></td>
            </tr>
            <tr>
                <td align="left"><%=ApplicationConfigurator.LanguageManager.getString("Luogo.trasporto")%>&nbsp;</td>
                <td colspan="3">
                    <input type="text" maxlength="50"  name="IDZ_TRA_EVE_INO" value="<%=strIDZ_TRA_EVE_INO%>" style="width:520px;">
                </td>
            </tr>
        </table>
        <table border='0' id='Trasporto' class='dataTable' cellpadding='0' cellspacing='0'>
            <tr><td>&nbsp;</td></tr>
        </table-->

        <script type="text/javascript" src="../_scripts/index.js"></script>
        <script type="text/javascript">

            DOC_ASS = <%=ApplicationConfigurator.isModuleEnabled(MODULES.DOC_ASS)%>
            MOD_FORM_MSR = <%=ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_MSR)%>
            //--------BUTTONS description-----------------------
            btnParams = new Array();
            btnParams[0] = {"id":"btnNew",
                "onclick":addRow,
                "action":"AddNew"
            };
            btnParams[1] = {"id":"btnEdit",
                "onclick":editRow,
                "action":"Edit"
            };
            btnParams[2] = {"id":"btnCancel",
                "onclick":delRow,
                "action":"Delete"
            };
            //--------creating tabs--------------------------
            var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
            var btnBar = new ButtonPanel("batPanel1", btnParams);
            tabbar.addButtonBar(btnBar);
    
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Testimoni")%>", tabbar));
            tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Analisi")%>", tabbar));
            tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Raccomandazioni")%>", tabbar));
            tabbar.addTab(new Tab("tab4", "<%=ApplicationConfigurator.LanguageManager.getString("Correzioni")%>", tabbar));
            tabbar.addTab(new Tab("tab5", "<%=ApplicationConfigurator.LanguageManager.getString("Divulgazioni")%>", tabbar));
            // tabbar.addTab(new Tab("tab6", "<%=ApplicationConfigurator.LanguageManager.getString("Trasporti")%>", tabbar));
            if (!MOD_FORM_MSR){
                tabbar.addTab(new Tab("tab6", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti")%>", tabbar));
            }
            else{
                tabbar.addTab(new Tab("tab6", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti.associati")%>", tabbar));
            }
            //------adding tables to tabs-----------------------
    
            tabbar.idParentRecord = <%=lCOD_INO%>;
            tabbar.refreshTabUrl = "ANA_INO_Tabs.jsp";
            tabbar.RefreshAllTabs();
 
            //-----activate first tab--------------------------
            tabbar.tabs[0].center.click();

            tabbar.tabs[1].tabObj.addTable( document.all["AnalisiHeader"],document.all["Analisi"], true);
            tabbar.tabs[2].tabObj.addTable( document.all["RaccomandazioniHeader"],document.all["Raccomandazioni"], true);
            tabbar.tabs[3].tabObj.addTable( document.all["CorrezioneHeader"],document.all["Correzione"], true);
            tabbar.tabs[4].tabObj.addTable( document.all["DivulgazioneHeader"],document.all["Divulgazione"], true);
            // tabbar.tabs[5].tabObj.addTable( document.all["TrasportoHeader"],document.all["Trasporto"], true);

            //----add action parameters to tabs
            tabbar.tabs[0].tabObj.actionParams ={
                "Feachures":ANA_TST_EVE_Feachures,
                "AddNew":	{"url":"../Form_ANA_TST_EVE/ANA_TST_EVE_Form.jsp?ATTACH_URL=Form_GEST_AZN_CRR_PET/GEST_AZN_CRR_PET_Attach.jsp&ATTACH_SUBJECT=DOC",
                    "buttonIndex":0,
                    "disabled": <%=bean == null%>//false
                },
                "Delete":	{"url":"../Form_ANA_INO/ANA_INO_Delete.jsp?LOCAL_MODE=TST_EVE",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"],
                    "disabled": <%=bean == null%>//false
                },
                "Edit":	{"url":"../Form_ANA_TST_EVE/ANA_TST_EVE_Form.jsp",
                    "buttonIndex":1,
                    "disabled": <%=bean == null%>//false
                }
       
            };
            tabbar.tabs[0].tabObj.OnActivate = function(){
                tabbar.buttonBar.panel.style.display = 'block';
            };
            tabbar.tabs[1].tabObj.OnActivate = function(){
                obj = tabbar.tabs[1].tabContainer;
                obj.style.display = 'none';
                tabbar.buttonBar.panel.style.display = 'none';
            };
            tabbar.tabs[2].tabObj.OnActivate = function(){
                obj = tabbar.tabs[2].tabContainer;
                obj.style.display = 'none';
                tabbar.buttonBar.panel.style.display = 'none';
            };
            tabbar.tabs[3].tabObj.OnActivate = function(){
                obj = tabbar.tabs[3].tabContainer;
                obj.style.display = 'none';
                tabbar.buttonBar.panel.style.display = 'none';
            };
            tabbar.tabs[4].tabObj.OnActivate = function(){
                obj = tabbar.tabs[4].tabContainer;
                obj.style.display = 'none';
                tabbar.buttonBar.panel.style.display = 'none';
            };
            /*
            tabbar.tabs[5].tabObj.OnActivate = function(){
                obj = tabbar.tabs[5].tabContainer;
                obj.style.display = 'none';
                tabbar.buttonBar.panel.style.display = 'none';
            };
             */
            tabbar.tabs[5].tabObj.OnActivate = function() {
                tabbar.buttonBar.panel.style.display = 'block';
            };
            // DOCUMENTI
            
            if (!DOC_ASS){
                tabbar.tabs[5].tabObj.actionParams ={
                    "Feachures":ANA_DOC_Feachures,
                    "AddNew":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_INO/ANA_INO_Attach.jsp&ATTACH_SUBJECT=DOCUMENTO",
                        "buttonIndex":0,
                        "disabled": false
                    },
                    "Edit":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_INO/ANA_INO_Attach.jsp&ATTACH_SUBJECT=DOCUMENTO",
                        "buttonIndex":1,
                        "disabled": false
                    },
                    "Delete":{
                        "url":"ANA_INO_Delete.jsp?LOCAL_MODE=DOCUMENTO",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false
                    },
                    "Associate":{"url":"", "buttonIndex":3, "disabled": true }}}
            else{
                tabbar.tabs[5].tabObj.actionParams ={
                    "Feachures":ANA_DOC_Feachures,
                    "AddNew":	{"url":"../Form_DOC_ASS_INF/DOC_ASS_INF_Form.jsp?ATTACH_URL=Form_ANA_INO/ANA_INO_Attach.jsp&ATTACH_SUBJECT=DOCUMENTO",
                        "buttonIndex":0,
                        "disabled": false
                    },
                    "Edit":	{"url":"../Form_DOC_ASS_INF/DOC_ASS_INF_Form.jsp?ATTACH_URL=Form_ANA_INO/ANA_INO_Attach.jsp&ATTACH_SUBJECT=DOCUMENTO",
                        "buttonIndex":1,
                        "disabled": false
                    },
                    "Delete":	{"url":"../Form_DOC_ASS_INF/DOC_ASS_INF_Delete.jsp",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false
                    },
                    "Help":	{"url":"../Form_DOC_CSG_DTE/DOC_CSG_DTE_Help.jsp",
                        "buttonIndex":3,
                        "disabled": false
                    }};

            }
            
            // DOCUMENTI
        </script>
        <%} else {%>
        <script type="text/javascript">
            window.dialogHeight="490px";
        </script>
        <%}%>
        <script type="text/javascript">
            btnSave = ToolBar.Save.getButton();
            btnSave.onclick = saveForm;
        </script>
        <%if (lCOD_INO != 0) {%>
        <script type="text/javascript">
            checkRiaperturaInfortuni('checkRiaperturaInfortuni.jsp?COD_DPD='+document.getElementById('COD_DPD').value+'&DAT_EVE_INO='+document.getElementById('DAT_EVE_INO').value+'&COD_INO='+document.getElementById('COD_INO').value+'&COD_INO_REL='+document.getElementById('ID_COD_REL_INO').value,document.getElementById('IDMessage'));
        </script>
        <%}%>

