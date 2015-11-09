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

<%@page import="com.apconsulting.luna.ejb.AnagrConstatazioni.IAnagrConstatazioniHome"%>
<%@page import="com.apconsulting.luna.ejb.AnagrConstatazioni.IAnagrConstatazioni"%>
<%@page import="com.apconsulting.luna.ejb.FattoriRischioCantiere.IFattoriRischioCantiere"%>
<%@page import="com.apconsulting.luna.ejb.FattoriRischioCantiere.IFattoriRischioCantiereHome"%>
<%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
            response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.RischioCantiere.*" %>
<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>
<%@ page import="com.apconsulting.luna.ejb.AssociativaAgentoChimico.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.RischioFattore.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/ComboBuilder.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%@ include file="ANA_RSO_CAN_Util.jsp" %>

<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuRischiCantiere,1) + "</title>");
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
    <link rel="stylesheet" href="../_styles/style.css">
    <link rel="stylesheet" href="../_styles/tabs.css">
    <script src="../_scripts/tabs.js"></script>
    <script src="../_scripts/tabbarButtonFunctions.js"></script>
    <script src="../_scripts/js_ANA_AZL.js"></script>
    <script src="../_scripts/Alert.js"></script>
    </head>
    <body style="margin:0 0 0 0;">

        <script>
            window.dialogWidth="855px";
        </script>

        <%
            boolean bCalledFromMachina = (request.getParameter("ID_PARENT") != null && "RISCHIO".equals(request.getParameter("ATTACH_SUBJECT")));
            boolean bCalledFromSostanza = (request.getParameter("ID_PARENT") != null && "RSO".equals(request.getParameter("ATTACH_SUBJECT")));
            short sMOD_CLC_RSO = Security.getAziendaModalitaCalcoloRischio();
            out.println("<script>");
            out.print("window.dialogHeight=\"");
            if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_BASE) {
                if (bCalledFromMachina || bCalledFromSostanza) {
                    out.print("470");
                } else {
                    out.print("470");
                }
            } else if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {
                if (bCalledFromMachina || bCalledFromSostanza) {
                    out.print("470");
                } else {
                    out.print("470");
                }
            }
            out.print("px\"");
            out.println("</script>");
        %>
        <%!
            long lCOD_AZL;
            long lCOD_RSO;
            String strNOM_RSO;
            String strDES_RSO;
            java.sql.Date dtDAT_RIL;
            String strNOM_RIL_RSO;
            String strCLF_RSO;
            long lPRB_EVE_LES;
            long lENT_DAN;
            long lFRQ_RIP_ATT_DAN;
            long lNUM_INC_INF;
            float lSTM_NUM_RSO;
            long lRFC_VLU_RSO_MES;
            String strCOD_FAT_RSO;
            long lCOD_RSO_RPO;
        %>
        <%
            lCOD_AZL = 0;
            lCOD_RSO = 0;
            strNOM_RSO = strDES_RSO = strNOM_RIL_RSO = strCLF_RSO = "";
            dtDAT_RIL = null;
            lPRB_EVE_LES = 0;
            lENT_DAN = 0;
            lFRQ_RIP_ATT_DAN = 0;
            lNUM_INC_INF = 0;
            lSTM_NUM_RSO = 0;
            lRFC_VLU_RSO_MES = 0;
            strCOD_FAT_RSO = "";
            lCOD_RSO_RPO = 0;
            long lCOD_FAT_RSO=0;

String strSubject=(String)request.getParameter("ATTACH_SUBJECT");
if((strSubject!=null)&&(strSubject.equals("CSTRSO"))){
    strCOD_FAT_RSO = request.getParameter("lCOD_FAT_RSO");
 lCOD_FAT_RSO=Long.parseLong(strCOD_FAT_RSO);}
            IRischioCantiereHome home = null;
            IRischioCantiere bean = null;

            boolean bExtended = false;

            String strID = "";
            if (request.getParameter("ID") != null) {
                // getting parameters of azienda
                strID = (String) request.getParameter("ID");
                try {
                    home = (IRischioCantiereHome) PseudoContext.lookup("RischioCantiereBean");
                    RischioPK id = new RischioPK(Security.getAzienda(), Long.parseLong(strID)); // PK

                    bean = home.findByPrimaryKey(id);
                    lCOD_AZL = bean.getCOD_AZL();
                    lCOD_RSO = bean.getCOD_RSO();
                    strNOM_RSO = bean.getNOM_RSO();
                    strDES_RSO = bean.getDES_RSO();
                    dtDAT_RIL = bean.getDAT_RIL();
                    strNOM_RIL_RSO = bean.getNOM_RIL_RSO();
                    strCLF_RSO = bean.getCLF_RSO();
                    lPRB_EVE_LES = bean.getPRB_EVE_LES();
                    lENT_DAN = bean.getENT_DAN();
                    lFRQ_RIP_ATT_DAN = bean.getFRQ_RIP_ATT_DAN();
                    lNUM_INC_INF = bean.getNUM_INC_INF();
                    lSTM_NUM_RSO = bean.getSTM_NUM_RSO();
                    lRFC_VLU_RSO_MES = bean.getRFC_VLU_RSO_MES();
                    lCOD_FAT_RSO = bean.getCOD_FAT_RSO();
                    lCOD_RSO_RPO = bean.getCOD_RSO_RPO();
                } catch (Exception ex) {
        %>
        <div id="errDiv" style="display:none">
            <%=Formatter.format(ex.getMessage())%>
        </div>
        <script>Alert.Error.showNotFound()</script>
        <%
                }
            }
        %>
        <form action="ANA_RSO_CAN_Set.jsp" method="POST"  target="ifrmWork" style="margin:0 0 0 0;">
            <table border="0" width="100%">
                <tr>
                    <td>
                        <table border="0" cellpadding="0" cellspacing="0"  width="100%">
                            <tr>
                                <td align="center" class="title">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                        (SubMenuRischiCantiere,1,<%=request.getParameter("ID")%>));
                                    </script>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <!-- ########################################################################################################## -->
                                    <table border="0">
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%
            ToolBar.bCanDelete = (bean != null);
            if (bCalledFromMachina) {
                ToolBar.bCanReturn = (bean != null);
            }
                                        %>
                                        <%=ToolBar.build(2)%>
                                        <%
            if (Security.isExtendedMode() && (bean == null || bean.isMultiple())) {
                bExtended = true;
                                        %>
                                        <script>
                                            isExtendedForm=true;
                                            isExtendedFormParName="NOM_RSO";
                                        </script>
                                        <%
            }
                                        %>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.rischio")%></legend>
                                        <table border="0" width="100%" cellpadding="2" cellspacing="5">
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
                                                    <input style="width:99%;" tabindex="1" type="text" size="48" maxlength="100"  name="NOM_RSO"  id="NOM_RSO" value="<%=Formatter.format(strNOM_RSO)%>">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio")%></b>&nbsp;</td>
                                                <%if((strSubject!=null)&&(strSubject.equals("CSTRSO"))){%>
                                                <td align="left">
                                                     <%
                                                        IFattoriRischioCantiereHome home_rso=(IFattoriRischioCantiereHome)PseudoContext.lookup("FattoriRischioCantiereBean");
                                                        IFattoriRischioCantiere fattore = home_rso.findByPrimaryKey(lCOD_FAT_RSO);
                                                        String sFAT_RSO = fattore.getNOM_FAT_RSO();
                                                        out.print(Formatter.format(sFAT_RSO));

                                                        %>
                                                        <input tabindex="6" type="Hidden" readonly size="25" maxlength="100" name="COD_FAT_RSO" id="COD_FAT_RSO" value="<%=lCOD_FAT_RSO%>">
                                                </td>
                                                <%}else{%>
                                                <td width="50%">
                                                    <select tabindex="1" name="COD_FAT_RSO" style="width:100%;">
                                                        <option value=''></option>
                                                        <%
                                                        IFattoriRischioCantiereHome home_rso=(IFattoriRischioCantiereHome)PseudoContext.lookup("FattoriRischioCantiereBean");

                                                                    out.print(BuildFattoreRischioCantiereComboBox(home_rso, lCOD_FAT_RSO));
                                                        %>
                                                    </select>

                                                </td>
                                               <% }%>
                                                <!--td width="50%">
                                                    <select tabindex="1" name="COD_FAT_RSO" style="width:100%;">
                                                        <option value=''></option>
                                                       
                                                    </select>

                                                </td-->
                                                <!--td colspan="3" tabindex="2">
                                                    <!--%
            class FactorBuilder implements IComboParser {

                public void parse(Object obj, ComboItem item) {
                    RischioFattore_ComboView w = (RischioFattore_ComboView) obj;
                    item.lIndex = w.lCOD_FAT_RSO;
                    item.strValue = w.strNOM_FAT_RSO;
                }
            }

            IFattoriRischioCantiereHome hrfb = (IFattoriRischioCantiereHome) PseudoContext.lookup("FattoriRischioCantiereBean");
            ComboBuilder b = new ComboBuilder(lCOD_FAT_RSO, new FactorBuilder(), hrfb.getComboView());
            b.strName = "COD_FAT_RSO";
                                                    %-->
                                                    <!--%=b.build()%-->
                                                <!--/td-->
                                                 <%
            boolean bInList = false;
                                                %>
                                                 <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Classificazione.rischio")%>&nbsp;</td>
                                                <td>
                                                    <SELECT tabindex="4" name="CLF_RSO">
                                                        <option selected></option>
                                                        <option value="PER TUTTI"
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
                                            
                                            <!--tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nominativo.rilevatore")%></b>&nbsp;</td>
                                                <td colspan=5>
                                                    <input tabindex="6" type="text" style="width:100%;" maxlength="100"  name="NOM_RIL_RSO" value="<%=Formatter.format(strNOM_RIL_RSO)%>">
                                                </td>
                                            </tr-->
                                            <!--tr>
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
                                            </tr-->
                                            <script>
                                                function RecalculateExtended(){
                                                    var FattoreMoltiplicativo = 1 + (document.forms[0].NUM_INC_INF.value - 1) * 0.5;
                                                    var StimaRischio =  document.forms[0].ENT_DAN.value *
                                                        document.forms[0].FRQ_RIP_ATT_DAN.value *
                                                        document.forms[0].PRB_EVE_LES.value *
                                                        FattoreMoltiplicativo;
                                                    SetStimaRischio(StimaRischio);
                                                }

                                                function Recalculate(){
                                                    var StimaRischio=(document.forms[0].ENT_DAN.value)*(document.forms[0].PRB_EVE_LES.value);
                                                    SetStimaRischio(StimaRischio);
                                                }

                                                function SetStimaRischio(sr){
                                                    if(sr==null || sr=="NaN") x=0;
                                                    document.forms[0].STM_NUM_RSO.value=sr;
                                                }

                                            </script>
                                            <%
            String strTPL_CLF_RSO = "";
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
                                                <td align="right" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione.rischio")%>&nbsp;</td>
                                                <td colspan="5">
                                                    <TEXTAREA tabindex="13" style="width:760px;" name="DES_RSO"><%=Formatter.format(strDES_RSO)%></TEXTAREA>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                            <tr>
                                <td><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <iframe name="ifrmWork" id="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <script>
            function OnPerChange(obj){
                TPL_CLF_RSO="&TPL_CLF_RSO="+obj.options[obj.selectedIndex].value;
            }

            function OnReturn(){
                tb_url_Attach=tb_url_Attach+TPL_CLF_RSO;
                OldReturn();
            }

            var TPL_CLF_RSO="&TPL_CLF_RSO=<%=strTPL_CLF_RSO%>";
            var OldReturn= ToolBar.Return.OnClick;
            ToolBar.Return.OnClick=OnReturn;
        </script>
        <script>
            function CaricaDbRischio(){
            <%if (DEBUG) {%>
                    window.open("../Form_CRM_RSO/CRM_RSO_Form.jsp");
            <%} else {%>

                    window.showModalDialog("../Form_CRM_RSO/CRM_RSO_Form.jsp", 0, "dialogWidth:830px;dialogHeight:280px;status:no;help:no;scroll:no;");
            <%}%>
                }

                function CaricaRpRischio(){
                    document.all['ifrmWork'].src = "../Form_CRM_RSO/CRM_RSO_Set.jsp?LOCAL_MODE=caricaRpRischi&NOM_RSO="+document.all['NOM_RSO'].value;
                }
        </script>

        <%if (bean != null) {%>
        <script src="../_scripts/index.js"></script>
        <script>
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
            /*   btnParams[3] = {"id":"btnHelp",
            "onmousedown":btnDown,
            "onmouseup":btnOver,
            "onmouseover":btnOver,
            "onmouseout":btnOut,
            "onclick":windowHelp,
            "src":"../_images/HELP.GIF",
            "action":"Help"
            };  */
            //--------creating tabs--------------------------
          //  MOD_DVR_MSR = <%=ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_MSR)%>
          //  CORSI_4_ATT_LAV = <%=ApplicationConfigurator.isModuleEnabled(MODULES.CORSI_4_ATT_LAV)%>
          //  DPI_4_ATT_LAV = <%=ApplicationConfigurator.isModuleEnabled(MODULES.DPI_4_ATT_LAV)%>
          //  PRO_SAN_4_ATT_LAV = <%=ApplicationConfigurator.isModuleEnabled(MODULES.PRO_SAN_4_ATT_LAV)%>
            TIT_4 = <%=ApplicationConfigurator.isModuleEnabled(MODULES.TIT_4)%>
            var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
            tabbar.DEBUG_TABS_IFRM =false;

            var btnBar = new ButtonPanel("batPanel1", btnParams);
            tabbar.addButtonBar(btnBar);

          /*  if (!CORSI_4_ATT_LAV){
                tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Corsi")%>", tabbar));}
            if (!MOD_DVR_MSR){
                tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Normative/Sentenze")%>", tabbar));}
            if (!DPI_4_ATT_LAV){
                tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("D.P.I.")%>", tabbar));}
            if (!PRO_SAN_4_ATT_LAV){
                tabbar.addTab(new Tab("tab4", "<%=ApplicationConfigurator.LanguageManager.getString("Protocolli.sanitari")%>", tabbar));}
            if (!MOD_DVR_MSR){
                tabbar.addTab(new Tab("tab5", "<%=ApplicationConfigurator.LanguageManager.getString("Misure.di.prevenzione.e.protezione")%>", tabbar));
                tabbar.addTab(new Tab("tab6", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti")%>", tabbar));
            }
            if ((MOD_DVR_MSR)&&(CORSI_4_ATT_LAV)&&(DPI_4_ATT_LAV)&&(PRO_SAN_4_ATT_LAV)){
                tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Misure.di.prevenzione.e.protezione")%>", tabbar));
            }*/
            if (TIT_4) {
                tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Art.Legge.Ex81/08")%>", tabbar));
            }
            //------adding tables to tabs-----------------------
            tabbar.idParentRecord = <%= lCOD_RSO%>;
            tabbar.refreshTabUrl="ANA_RSO_CAN_Tabs.jsp";
            tabbar.RefreshAllTabs();

            //----add action parameters to tabs
           /* if (!CORSI_4_ATT_LAV){
                tabbar.tabs[0].tabObj.actionParams ={
                    "Feachures":ANA_COR_Feachures,
                    "AddNew":{"url":"../Form_ANA_COR/ANA_COR_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=CORSO<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":0,
                        "disabled": false
                    },
                    "Edit":	{"url":"../Form_ANA_COR/ANA_COR_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=CORSO<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":1,
                        "disabled": false
                    },
                    "Delete":	{"url":"../Form_ANA_RSO/ANA_RSO_Delete.jsp?LOCAL_MODE=c",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false,
                        "ExtendedMode": <%=bExtended%>
                    },
                    "Help":	{"url":"../Form_ANA_COR/ANA_COR_Help.jsp",
                        "buttonIndex":3,
                        "disabled": false
                    }
                };}
            //-------------------------------------------------
            if (!MOD_DVR_MSR){
                tabbar.tabs[1].tabObj.actionParams ={
                    "Feachures":ANA_NOR_SEN_Feachures,
                    "AddNew":	{"url":"../Form_ANA_NOR_SEN/ANA_NOR_SEN_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=NORMATIVA",
                        "buttonIndex":0,
                        "disabled": false
                    },
                    "Edit":	{"url":"../Form_ANA_NOR_SEN/ANA_NOR_SEN_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=NORMATIVA",
                        "buttonIndex":2,
                        "disabled": false
                    },
                    "Delete":	{"url":"../Form_ANA_RSO/ANA_RSO_Delete.jsp?LOCAL_MODE=n",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false
                    },
                    "Help":	{"url":"../Form_ANA_NOR_SEN/ANA_NOR_SEN_Help.jsp",
                        "buttonIndex":3,
                        "disabled": false
                    }

                };}
            //-------------------------------------------------
            if (!DPI_4_ATT_LAV){
                tabbar.tabs[2].tabObj.actionParams ={
                    "Feachures":{"dialogWidth":"55","dialogHeight":"710px"},
                    "AddNew":	{"url":"../Form_TPL_DPI/TPL_DPI_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=DPI<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":0,
                        "disabled": false
                    },
                    "Edit":	{"url":"../Form_TPL_DPI/TPL_DPI_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=DPI<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":1,
                        "disabled": false
                    },
                    "Delete":	{"url":"../Form_ANA_RSO/ANA_RSO_Delete.jsp?LOCAL_MODE=d",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false,
                        "ExtendedMode": <%=bExtended%>
                    },
                    "Help":	{"url":"../Form_TPL_DPI/TPL_DPI_Help.jsp",
                        "buttonIndex":3,
                        "disabled": false
                    }

                };}
            //-------------------------------------------------
            if (!PRO_SAN_4_ATT_LAV){
                tabbar.tabs[3].tabObj.actionParams ={
                    "Feachures": ANA_PRO_SAN_Feachures,
                    "AddNew":	{"url":"../Form_ANA_PRO_SAN/ANA_PRO_SAN_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=PROSAN<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":0,
                        "disabled": false

                    },
                    "Edit":	{"url":"../Form_ANA_PRO_SAN/ANA_PRO_SAN_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=PROSAN<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":1,
                        "disabled": false
                    },
                    "Delete":	{"url":"../Form_ANA_RSO/ANA_RSO_Delete.jsp?LOCAL_MODE=p",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false,
                        "ExtendedMode": <%=bExtended%>
                    },
                    "Help":	{"url":"../Form_ANA_PRO_SAN/ANA_PRO_SAN_Help.jsp",
                        "buttonIndex":3,
                        "disabled": false
                    }

                };}
            //-------------------------------------------------
            if (!MOD_DVR_MSR){
                tabbar.tabs[4].tabObj.actionParams ={
                    "Feachures":{"dialogWidth":"850px","dialogHeight":"550px"
                    },
                    "AddNew":	{"url":"../Form_ANA_MIS_PET/ANA_MIS_PET_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=MISPET<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":0,
                        "disabled": false
                    },
                    "Edit":	{"url":"../Form_ANA_MIS_PET/ANA_MIS_PET_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=MISPET<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":1,
                        "disabled": false
                    },
                    "Delete":	{"url":"../Form_ANA_RSO/ANA_RSO_Delete.jsp?LOCAL_MODE=m",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false,
                        "ExtendedMode": <%=bExtended%>
                    },
                    "Help":	{"url":"../Form_ANA_MIS_PET/ANA_MIS_PET_Help.jsp",
                        "buttonIndex":3,
                        "disabled": false
                    }
                };
                //-------------------------------------------------
                tabbar.tabs[5].tabObj.actionParams ={
                    "Feachures":ANA_DOC_Feachures,
                    "AddNew":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
                        "buttonIndex":0,
                        "disabled": false
                    },
                    "Edit":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=DOCUMENT",
                        "buttonIndex":1,
                        "disabled": false
                    },
                    "Delete":	{"url":"../Form_ANA_RSO/ANA_RSO_Delete.jsp?LOCAL_MODE=doc",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false
                    },
                    "Help":	{"url":"../Form_ANA_DOC/ANA_DOC_Help.jsp",
                        "buttonIndex":3,
                        "disabled": false
                    }
                }; }
            else if ((MOD_DVR_MSR)&&(CORSI_4_ATT_LAV)&&(DPI_4_ATT_LAV)&&(PRO_SAN_4_ATT_LAV)){
                tabbar.tabs[0].tabObj.actionParams ={
                    "Feachures":{"dialogWidth":"850px","dialogHeight":"550px"
                    },
                    "AddNew":	{"url":"../Form_ANA_MIS_PET/ANA_MIS_PET_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=MISPET<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":0,
                        "disabled": false
                    },
                    "Edit":	{"url":"../Form_ANA_MIS_PET/ANA_MIS_PET_Form.jsp?ATTACH_URL=Form_ANA_RSO/ANA_RSO_Attach.jsp&ATTACH_SUBJECT=MISPET<%=bExtended ? "&EXTENDED_ATTACH=1" : ""%>",
                        "buttonIndex":1,
                        "disabled": false
                    },
                    "Delete":	{"url":"../Form_ANA_RSO/ANA_RSO_Delete.jsp?LOCAL_MODE=m",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false,
                        "ExtendedMode": <%=bExtended%>
                    },
                    "Help":	{"url":"../Form_ANA_MIS_PET/ANA_MIS_PET_Help.jsp",
                        "buttonIndex":3,
                        "disabled": false
                    }
                };
            }*/
            if (TIT_4){

            tabbar.tabs[0].tabObj.actionParams ={
                   "Feachures":{"dialogWidth":"850px","dialogHeight":"550px"
                    },
                    "AddNew":	{"url":"../Form_ART_LEG_RSO/ART_LEG_RSO_Form.jsp",
                        "buttonIndex":0,
                        "disabled": false
                    },
                    "Edit":	{"url":"../Form_ART_LEG_RSO/ART_LEG_RSO_Form.jsp",
                        "buttonIndex":1,
                        "disabled": true
                    },
                    "Delete":	{"url":"../Form_ART_LEG_RSO/ANA_LEG_RSO_Delete.jsp",
                        "target_element":document.all["ifrmWork"],
                        "buttonIndex":2,
                        "disabled": false
                    }
            };}

            //-------------------------------------------------
        </script>
        <%} else {
    if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_BASE) {%>
        <script>
            window.dialogHeight="330px";
        </script>
        <%  } else if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {%>
        <script>
            window.dialogHeight="330px";
        </script>
        <%  }
            }%>
    </body>
</html>
