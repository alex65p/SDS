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
    <version number="1.0" date="09/02/2004" author="Kushkarov Jura">
    <comments>
    <comment date="09/02/2004" author="Kushkarov Jura">
    <description>Shablon formi ANA_SCH_PRG_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.SchedeParagrafo.*" %>
<%@ page import="com.apconsulting.luna.ejb.Paragrafo.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/ToolBar.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
    <head> 
        <title><%=ApplicationConfigurator.LanguageManager.getString("Schede.dei.paragrafi")%></title>
        <link rel="stylesheet" href="../_styles/index.css" type="text/css">
        <link rel="stylesheet" href="../_styles/style.css" type="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css" type="text/css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <script language="JavaScript" src="ANA_SCH_PRG_Script.js"></script>
    </head>
    <body>
        <%
            String strCOD_PRG = "";
            String strNOM_PRG = "";
            long lCOD_PRG = 0;
            long lCOD_SCH_PRG = 0;
            String strCOD_SCH_PRG = "";
            String strTPL_SCH = "";
            String MR = "";
            String UR = "";
            String SR = "";
            String CR = "";
            String AR = "";
            String LR = "";
            String FR = "";
            String DR = "";
            String BR = "";
            String VR = "";
            String RR = "";
            // Blocco del radio "Descrizioni" - INIZIO
            String BAR = "";
            String BIR = "";
            String BPR = "";
            String BLR = "";
            String BMR = "";
            String BRR = "";
            String BNR = "";
            String BUR = "";
            String BSR = "";
            // Blocco del radio "Descrizioni" - FINE
            IParagrafoHome home = (IParagrafoHome) PseudoContext.lookup("ParagrafoBean");
            IParagrafo Paragrafo = null;
            ISchedeParagrafoHome Shome = (ISchedeParagrafoHome) PseudoContext.lookup("SchedeParagrafoBean");
            ISchedeParagrafo SchedeParagrafo = null;

            if ((request.getParameter("ID_PARENT") != null) && (!request.getParameter("ID_PARENT").equals("null"))) {
                strCOD_PRG = request.getParameter("ID_PARENT");
                Long COD_PRG = new Long(strCOD_PRG);
                lCOD_PRG = new Long(strCOD_PRG).longValue();

                // getting of object variables
                Paragrafo = home.findByPrimaryKey(COD_PRG);

                // getting of object variables
                strNOM_PRG = Paragrafo.getNOM_PRG();
                if ((request.getParameter("ID") != null) && (!request.getParameter("ID").equals("null"))) {
                    strCOD_SCH_PRG = request.getParameter("ID");
                    Long COD_SCH_PRG = new Long(strCOD_SCH_PRG);
                    lCOD_SCH_PRG = new Long(strCOD_SCH_PRG).longValue();
                    try {
                        SchedeParagrafo = Shome.findByPrimaryKey(COD_SCH_PRG);
                        strTPL_SCH = SchedeParagrafo.getTPL_SCH();
                        if (strTPL_SCH.equals(TipoParagrafo.MACCHINA_ATTREZZATURA.getType())) {
                            MR = "checked";
                        } else
                        if (strTPL_SCH.equals(TipoParagrafo.UNITA_ORGANIZZATIVA.getType())) {
                            UR = "checked";
                        } else
                        if (strTPL_SCH.equals(TipoParagrafo.UNITA_SICUREZZA.getType())) {
                            SR = "checked";
                        } else
                        if (strTPL_SCH.equals(TipoParagrafo.SOSTANZA_CHIMICA.getType())) {
                            CR = "checked";
                        } else
                        if (strTPL_SCH.equals(TipoParagrafo.ATTIVITA_LAVORATIVA.getType())) {
                            AR = "checked";
                        } else
                        if (strTPL_SCH.equals(TipoParagrafo.LUOGO_FISICO.getType())) {
                            LR = "checked";
                        } else
                        if (strTPL_SCH.equals(TipoParagrafo.FATTORE_DI_RISCHIO.getType())) {
                            FR = "checked";
                        } else
                        if (strTPL_SCH.equals(TipoParagrafo.ANAGRAFICA_AZIENDA.getType())) {
                            DR = "checked";
                        } else
                        if (strTPL_SCH.equals(TipoParagrafo.VALUTAZIONE_RISCHIO.getType())) {
                            VR = "checked";
                        } else
                        if (strTPL_SCH.equals(TipoParagrafo.SCHEDA_RISCHI.getType())) {
                            RR = "checked";
                        } else
                        // Blocco del radio "Descrizioni" - INIZIO
                        if (strTPL_SCH.equals(TipoParagrafo.DESCRIZIONI_ATTIVITA_LAVORATIVA.getType())) {
                            BAR = "checked";
                        } else
                        if (strTPL_SCH.equals(TipoParagrafo.DESCRIZIONI_IMMOBILI.getType())) {
                            BIR = "checked";
                        } else
                        if (strTPL_SCH.equals(TipoParagrafo.DESCRIZIONI_MISURA_PP.getType())) {
                            BPR = "checked";
                        } else
                        if (strTPL_SCH.equals(TipoParagrafo.DESCRIZIONI_LUOGO_FISICO.getType())) {
                            BLR = "checked";
                        } else
                        if (strTPL_SCH.equals(TipoParagrafo.DESCRIZIONI_MACCHINA_ATTREZZATURA.getType())) {
                            BMR = "checked";
                        } else
                        if (strTPL_SCH.equals(TipoParagrafo.DESCRIZIONI_RISCHI.getType())) {
                            BRR = "checked";
                        } else
                        if (strTPL_SCH.equals(TipoParagrafo.DESCRIZIONI_PIANI.getType())) {
                            BNR = "checked";
                        } else
                        if (strTPL_SCH.equals(TipoParagrafo.DESCRIZIONI_UNITA_ORGANIZZATIVA.getType())) {
                            BUR = "checked";
                        } else
                        if (strTPL_SCH.equals(TipoParagrafo.DESCRIZIONI_UNITA_SICUREZZA.getType())) {
                            BSR = "checked";
                        }
                        // Blocco del radio "Descrizioni" - FINE
                    } catch (Exception ex) {
                        out.println("<script>alert(\"" + COD_SCH_PRG + "\");</script>");
                    }
                }
            }
        %>
        <!-- form for addind  SchedeParagrafi-->
        <form action=""  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value="<%=(lCOD_SCH_PRG == 0) ? "new" : "edt"%>">
            <input type="hidden" name="COD_PRG" id="COD_PRG" value="<%=lCOD_PRG%>">
            <input type="hidden" name="COD_SCH_PRG" value="<%=lCOD_SCH_PRG%>">
            <input type="hidden" name="type" id="type" value="<%=strTPL_SCH%>">
            <table width="100%" border="0">
                <tr>
                    <td valign="top">
                        <table  width="100%" border="0">
                            <tr>
                                <td class="title"><%=ApplicationConfigurator.LanguageManager.getString("Schede.dei.paragrafi")%></td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="100">
                                        <%
                                            ToolBar.bShowDelete = false;
                                            ToolBar.bShowPrint = false;
                                            ToolBar.bShowReturn = false;
                                            ToolBar.bShowSave = false;
                                        %>	
                                        <%=ToolBar.build(2)%> 
                                    </table>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Scheda.dei.paragrafi")%></legend>
                                        <table width="100%" border="0">
                                            <tr>
                                                <td align="right" width="40%"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome.scheda.paragrafi")%></b></td>
                                                <td colspan="2" align="left"><input name="NOM_PRG" size="100" readonly value="<%=strNOM_PRG%>"></td>
                                            </tr>
                                            <tr> 
                                                <td align="right" id="type_des_M"><%=TipoParagrafo.MACCHINA_ATTREZZATURA.getFormLabel()%>&nbsp;</td>
                                                <td align="left" width="10%"><input <%=MR%> class="checkbox" value="<%=TipoParagrafo.MACCHINA_ATTREZZATURA.getType()%>" name="type_is" id="type_is" type="radio" onclick="radioClick(this.value);"></td>
                                                <!-- Blocco del radio "Descrizioni" - INIZIO -->
                                                <td rowspan="100%" style="display: none; vertical-align: top;" id="td_descrizioni">
                                                    <fieldset style="width: 50%;">
                                                        <table width="100%" border="0" cellpadding="0" cellspacing="1">
                                                            <tr class="VIEW_HEADER_TR">
                                                                <td colspan="2">
                                                                    <%=TipoParagrafo.DESCRIZIONI.getFormLabel().toUpperCase()%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right" id="type_des_BM"><%=TipoParagrafo.DESCRIZIONI_MACCHINA_ATTREZZATURA.getFormLabel()%>&nbsp;</td>
                                                                <td align="left"><input <%=BMR%> class="checkbox" value="<%=TipoParagrafo.DESCRIZIONI_MACCHINA_ATTREZZATURA.getType()%>" name="type_is" id="type_is" type="radio" onclick="radioClick(this.value);"></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right" id="type_des_BU"><%=TipoParagrafo.DESCRIZIONI_UNITA_ORGANIZZATIVA.getFormLabel()%>&nbsp;</td>
                                                                <td align="left"><input <%=BUR%> class="checkbox" value="<%=TipoParagrafo.DESCRIZIONI_UNITA_ORGANIZZATIVA.getType()%>" name="type_is" id="type_is" type="radio" onclick="radioClick(this.value);"></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right" id="type_des_BS"><%=TipoParagrafo.DESCRIZIONI_UNITA_SICUREZZA.getFormLabel()%>&nbsp;</td>
                                                                <td align="left"><input <%=BSR%> class="checkbox" value="<%=TipoParagrafo.DESCRIZIONI_UNITA_SICUREZZA.getType()%>" name="type_is" id="type_is" type="radio" onclick="radioClick(this.value);"></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right" id="type_des_BA"><%=TipoParagrafo.DESCRIZIONI_ATTIVITA_LAVORATIVA.getFormLabel()%>&nbsp;</td>
                                                                <td align="left"><input <%=BAR%> class="checkbox" value="<%=TipoParagrafo.DESCRIZIONI_ATTIVITA_LAVORATIVA.getType()%>" name="type_is" id="type_is" type="radio" onclick="radioClick(this.value);"></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right"  id="type_des_BL"><%=TipoParagrafo.DESCRIZIONI_LUOGO_FISICO.getFormLabel()%>&nbsp;</td>
                                                                <td align="left"><input <%=BLR%> class="checkbox" value="<%=TipoParagrafo.DESCRIZIONI_LUOGO_FISICO.getType()%>" name="type_is" id="type_is" type="radio" onclick="radioClick(this.value);"></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right" id="type_des_BI"><%=TipoParagrafo.DESCRIZIONI_IMMOBILI.getFormLabel()%>&nbsp;</td>
                                                                <td align="left"><input <%=BIR%> class="checkbox" value="<%=TipoParagrafo.DESCRIZIONI_IMMOBILI.getType()%>" name="type_is" id="type_is" type="radio" onclick="radioClick(this.value);"></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right" id="type_des_BN"><%=TipoParagrafo.DESCRIZIONI_PIANI.getFormLabel()%>&nbsp;</td>
                                                                <td align="left"><input <%=BNR%> class="checkbox" value="<%=TipoParagrafo.DESCRIZIONI_PIANI.getType()%>" name="type_is" id="type_is" type="radio" onclick="radioClick(this.value);"></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right" id="type_des_BR"><%=TipoParagrafo.DESCRIZIONI_RISCHI.getFormLabel()%>&nbsp;</td>
                                                                <td align="left"><input <%=BRR%> class="checkbox" value="<%=TipoParagrafo.DESCRIZIONI_RISCHI.getType()%>" name="type_is" id="type_is" type="radio" onclick="radioClick(this.value);"></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right" id="type_des_BP"><%=TipoParagrafo.DESCRIZIONI_MISURA_PP.getFormLabel()%>&nbsp;</td>
                                                                <td align="left"><input <%=BPR%> class="checkbox" value="<%=TipoParagrafo.DESCRIZIONI_MISURA_PP.getType()%>" name="type_is" id="type_is" type="radio" onclick="radioClick(this.value);"></td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                                <%
                                                    if (ApplicationConfigurator.isModuleEnabled(MODULES.DVR_LINK_PARAGRAFO_DESCRIZIONI) &&
                                                        Shome.checkBloccoDescrizioni(strTPL_SCH)){
                                                            BR = "checked";
                                                            out.println(
                                                                    "<script type=\"text/javascript\">"
                                                                        + "visualizzaBloccoDescrizioni(true);"
                                                                    + "</script>");
                                                    }
                                                %>
                                                <!-- Blocco del radio "Descrizioni" - FINE -->
                                            </tr>
                                            <tr>
                                                <td align="right" id="type_des_U"><%=TipoParagrafo.UNITA_ORGANIZZATIVA.getFormLabel()%>&nbsp;</td>
                                                <td align="left"><input <%=UR%> class="checkbox" value="<%=TipoParagrafo.UNITA_ORGANIZZATIVA.getType()%>" name="type_is" id="type_is" type="radio" onclick="radioClick(this.value);"></td>
                                            </tr>
                                            <tr>
                                                <td align="right" id="type_des_S"><%=TipoParagrafo.UNITA_SICUREZZA.getFormLabel()%>&nbsp;</td>
                                                <td align="left"><input <%=SR%> class="checkbox" value="<%=TipoParagrafo.UNITA_SICUREZZA.getType()%>" name="type_is" id="type_is" type="radio" onclick="radioClick(this.value);"></td>
                                            </tr>
                                            <tr>
                                                <td align="right" id="type_des_C"><%=TipoParagrafo.SOSTANZA_CHIMICA.getFormLabel()%>&nbsp;</td>
                                                <td align="left"><input <%=CR%> class="checkbox" value="<%=TipoParagrafo.SOSTANZA_CHIMICA.getType()%>" name="type_is" id="type_is" type="radio" onclick="radioClick(this.value);"></td>
                                            </tr>
                                            <tr>
                                                <td align="right" id="type_des_A"><%=TipoParagrafo.ATTIVITA_LAVORATIVA.getFormLabel()%>&nbsp;</td>
                                                <td align="left"><input <%=AR%> class="checkbox" value="<%=TipoParagrafo.ATTIVITA_LAVORATIVA.getType()%>" name="type_is" id="type_is" type="radio" onclick="radioClick(this.value);"></td>
                                            </tr>
                                            <tr>
                                                <td align="right"  id="type_des_L"><%=TipoParagrafo.LUOGO_FISICO.getFormLabel()%>&nbsp;</td>
                                                <td align="left"><input <%=LR%> class="checkbox" value="<%=TipoParagrafo.LUOGO_FISICO.getType()%>" name="type_is" id="type_is" type="radio" onclick="radioClick(this.value);"></td>
                                            </tr>
                                            <tr>
                                                <td align="right" id="type_des_F"><%=TipoParagrafo.FATTORE_DI_RISCHIO.getFormLabel()%>&nbsp;</td>
                                                <td align="left"><input <%=FR%> class="checkbox" value="<%=TipoParagrafo.FATTORE_DI_RISCHIO.getType()%>" name="type_is" id="type_is" type="radio" onclick="radioClick(this.value);"></td>
                                            </tr>
                                            <tr>
                                                <td align="right" id="type_des_D"><%=TipoParagrafo.ANAGRAFICA_AZIENDA.getFormLabel()%>&nbsp;</td>
                                                <td align="left"><input <%=DR%> class="checkbox" value="<%=TipoParagrafo.ANAGRAFICA_AZIENDA.getType()%>" name="type_is" id="type_is" type="radio" onclick="radioClick(this.value);"></td>
                                            </tr>
                                            <tr style="display: <%=ApplicationConfigurator.isModuleEnabled(MODULES.DVR_LINK_PARAGRAFO_DESCRIZIONI)?"block":"none"%>">
                                                <td align="right" id="type_des_B"><%=TipoParagrafo.DESCRIZIONI.getFormLabel()%>&nbsp;</td>
                                                <td align="left"><input <%=BR%> class="checkbox" value="<%=TipoParagrafo.DESCRIZIONI.getType()%>" name="type_is_B" id="type_is_B" type="radio" onclick="radioClick(this.value);"></td>
                                            </tr>
                                            <tr style="display: <%=ApplicationConfigurator.isModuleEnabled(MODULES.DVR_SCHEDA_VALUTAZIONE_RISCHIO)?"block":"none"%>">
                                                <td align="right" id="type_des_V"><%=TipoParagrafo.VALUTAZIONE_RISCHIO.getFormLabel()%>&nbsp;</td>
                                                <td align="left"><input <%=VR%> class="checkbox" value="<%=TipoParagrafo.VALUTAZIONE_RISCHIO.getType()%>" name="type_is" id="type_is" type="radio" onclick="radioClick(this.value);"></td>
                                            </tr>
                                            <tr style="display: <%=ApplicationConfigurator.isModuleEnabled(MODULES.DVR_SCHEDA_RISCHI)?"block":"none"%>">
                                                <td align="right" id="type_des_R"><%=TipoParagrafo.SCHEDA_RISCHI.getFormLabel()%>&nbsp;</td>
                                                <td align="left"><input <%=RR%> class="checkbox" value="<%=TipoParagrafo.SCHEDA_RISCHI.getType()%>" name="type_is" id="type_is" type="radio" onclick="radioClick(this.value);"></td>
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
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
        <script>
            btn = ToolBar.Search.getButton();
            btn.onclick = OpenTabForm; 
        </script>
    </body>
</html>
