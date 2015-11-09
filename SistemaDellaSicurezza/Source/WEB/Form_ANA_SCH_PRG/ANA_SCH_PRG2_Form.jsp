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
    <description>Shablon formi ANA_SCH_SCH_PRG_Form.jsp</description>
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

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
    <head> 
        <title><%=ApplicationConfigurator.LanguageManager.getString("Ricerca")%></title>
        <link rel="stylesheet" href="../_styles/style.css" type="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <link rel="stylesheet" href="../_styles/index.css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <script language="JavaScript" src="ANA_SCH_PRG_Script.js"></script>
        <script>var mode="add";</script>

        <script>
            window.dialogWidth="650px";
            window.dialogHeight="400px";
        </script>
    </head>
    <body>
        <%
            java.util.Collection col = null;
            long CK_VAL = 0;
            String IS_CHECK = "";
            String TYPE_OF = "";
            long AZL_ID = Security.getAzienda();
            ISchedeParagrafoHome home = (ISchedeParagrafoHome) PseudoContext.lookup("SchedeParagrafoBean");
            long COD_PAR = 0;
            String NOM_PAR = "";
            String NOM_PAR_2 = "";
            byte STL_IND = 0;
            long COD_PRG = 0;
            String strPRG = "";
            long lCOD_SCH_PRG = 0;
            String strCOD_SCH_PRG = "";
            if (!request.getParameter("ID_SCH").equals("0")) {
                strCOD_SCH_PRG = request.getParameter("ID_SCH");
                lCOD_SCH_PRG = new Long(strCOD_SCH_PRG).longValue();
        %>
        <script>
            mode="edt";
        </script>
        <%
            }
        %>
        <table width="100%" border="0">
            <tr>
                <td class="title">
                    <%=ApplicationConfigurator.LanguageManager.getString("Schede.dei.paragrafi")%>&nbsp;>&nbsp;<%=request.getParameter("TYPEDES")%>&nbsp;-&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Gestione")%>
                </td>
            </tr>
            <form action="ANA_SCH_PRG2_Set.jsp" method="post" target="ifrmWork">
                <tr>
                    <td>
                        <table border="0" cellpadding="0" cellspacing="0">
                            <%
                                if (!request.getParameter("ID_SCH").equals("0")) {
                                    out.print("<input type='hidden' value='" + strCOD_SCH_PRG + "' name='COD_SCH_PRG'>");
                                }
                            %>
                            <input type="hidden" size=100 name="IDS" id="IDS" value=",">
                            <input name="SBM_MODE" type="hidden" value="<%=(lCOD_SCH_PRG == 0) ? "new" : "edt"%>"> 
                            <input name="id_bef" type="hidden" id="id_bef"> 
                            <tr><td>&nbsp;</td></tr>
                            <%@ include file="../_include/ToolBar.jsp" %>      
                            <%ToolBar.bShowDelete = false;
                                ToolBar.bShowPrint = false;
                                ToolBar.bShowSearch = false;
                                ToolBar.bShowReturn = false;
                            %>	
                            <%=ToolBar.build(2)%> 
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table border="0" width="100%">
                            <tr class="VIEW_HEADER_TR">
                                <td style="width: 15%">
                                    <%=ApplicationConfigurator.LanguageManager.getString("Seleziona").toUpperCase()%>
                                </td>
                                <td style="width: 80%">
                                    <%=ApplicationConfigurator.LanguageManager.getString("Nominativo").toUpperCase()%>
                                </td>
                                <%
                                    if ((request.getParameter("TYPE") != null) && (request.getParameter("ID_PRG") != null)) {
                                        TYPE_OF = request.getParameter("TYPE");
                                    }
                                %>
                                <td style="width: 5%; display: <%=(TipoParagrafo.checkBloccoDescrizioni(TYPE_OF) ?"block":"none")%>">
                                    <%=ApplicationConfigurator.LanguageManager.getString("Ind").toUpperCase()%>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" colspan="3">
                                    <div style="overflow:auto;width:100%;height:240px">
                                        <table border="0" width="100%" cellpadding="0">
                                        <%
                                            if ((request.getParameter("TYPE") != null) && (request.getParameter("ID_PRG") != null)) {
                                                TYPE_OF = request.getParameter("TYPE");
                                                out.print("<input type='hidden' name='TYPE' id='TYPE' value='" + TYPE_OF + "'>");
                                                strPRG = request.getParameter("ID_PRG");
                                                out.print("<input type='hidden' name='ID_PRG' id='ID_PRG' value='" + strPRG + "'>");
                                                COD_PRG = new Long(strPRG).longValue();
                                                
                                                if (TYPE_OF.equals(TipoParagrafo.MACCHINA_ATTREZZATURA.getType()) || 
                                                    TYPE_OF.equals(TipoParagrafo.DESCRIZIONI_MACCHINA_ATTREZZATURA.getType())) {
                                                    col = home.getSchedeParagrafo_MAC_View(AZL_ID);
                                                }
                                                if (TYPE_OF.equals(TipoParagrafo.UNITA_ORGANIZZATIVA.getType()) || 
                                                    TYPE_OF.equals(TipoParagrafo.DESCRIZIONI_UNITA_ORGANIZZATIVA.getType())) {
                                                    col = home.getSchedeParagrafo_UNI_ORG_View(AZL_ID);
                                                }
                                                if (TYPE_OF.equals(TipoParagrafo.UNITA_SICUREZZA.getType()) || 
                                                    TYPE_OF.equals(TipoParagrafo.DESCRIZIONI_UNITA_SICUREZZA.getType())) {
                                                    col = home.getSchedeParagrafo_UNI_SIC_View(AZL_ID);
                                                }
                                                if (TYPE_OF.equals(TipoParagrafo.SOSTANZA_CHIMICA.getType())) {
                                                    col = home.getSchedeParagrafo_SOS_CHI_View(AZL_ID);
                                                }
                                                if (TYPE_OF.equals(TipoParagrafo.ATTIVITA_LAVORATIVA.getType()) || 
                                                    TYPE_OF.equals(TipoParagrafo.DESCRIZIONI_ATTIVITA_LAVORATIVA.getType())) {
                                                    col = home.getSchedeParagrafo_MAN_ViewU(AZL_ID, Security.getCurrentDvrUniOrg() == null ? 0 : Security.getCurrentDvrUniOrg().longValue());
                                                }
                                                if (TYPE_OF.equals(TipoParagrafo.LUOGO_FISICO.getType()) || 
                                                    TYPE_OF.equals(TipoParagrafo.DESCRIZIONI_LUOGO_FISICO.getType())) {
                                                    col = home.getSchedeParagrafo_LUO_FSC_ViewU(AZL_ID, Security.getCurrentDvrUniOrg() == null ? 0 : Security.getCurrentDvrUniOrg().longValue());
                                                }
                                                if (TYPE_OF.equals(TipoParagrafo.FATTORE_DI_RISCHIO.getType())) {
                                                    col = home.getSchedeParagrafo_FAT_RSO_View(AZL_ID);
                                                }
                                                if (TYPE_OF.equals(TipoParagrafo.DESCRIZIONI_IMMOBILI.getType())) {
                                                    col = home.getSchedeParagrafo_IMM_3LV_View(AZL_ID);
                                                }
                                                if (TYPE_OF.equals(TipoParagrafo.DESCRIZIONI_PIANI.getType())) {
                                                    col = home.getSchedeParagrafo_PNO_View(AZL_ID);
                                                }
                                                if (TYPE_OF.equals(TipoParagrafo.DESCRIZIONI_MISURA_PP.getType())) {
                                                    col = home.getSchedeParagrafo_MIS_PET_View(AZL_ID);
                                                }
                                                if (TYPE_OF.equals(TipoParagrafo.DESCRIZIONI_RISCHI.getType())) {
                                                    col = home.getSchedeParagrafo_RSO_View(AZL_ID);
                                                }
                                                if (!(TipoParagrafo.ANAGRAFICA_AZIENDA.getType().equals(TYPE_OF) ||
                                                      TipoParagrafo.VALUTAZIONE_RISCHIO.getType().equals(TYPE_OF)||
                                                      TipoParagrafo.SCHEDA_RISCHI.getType().equals(TYPE_OF))) {
                                                    java.util.Iterator it = col.iterator();
                                                    java.util.Collection colprg = home.getSchedeParagrafo_ByPRG_View(COD_PRG, TYPE_OF);
                                                    long i = 0;

                                                    while (it.hasNext()) {
                                                        IS_CHECK = "";
                                                        CK_VAL = 0;
                                                        
                                                        if (TYPE_OF.equals(TipoParagrafo.MACCHINA_ATTREZZATURA.getType()) || 
                                                            TYPE_OF.equals(TipoParagrafo.DESCRIZIONI_MACCHINA_ATTREZZATURA.getType())) {
                                                            SchedeParagrafo_MAC_View rst = (SchedeParagrafo_MAC_View) it.next();
                                                            COD_PAR = rst.COD_MAC;
                                                            NOM_PAR = rst.DES_MAC;
                                                            java.util.Iterator itprg = colprg.iterator();
                                                            while (itprg.hasNext()) {
                                                                SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                                                                if (lCOD_SCH_PRG != 0) {
                                                                    if ((lCOD_SCH_PRG == rstprg.COD_SCH_PRG) && (COD_PAR == rstprg.COD_MAC)) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                        STL_IND = rstprg.STL_IND;
                                                                    }
                                                                } else {
                                                                    if (COD_PAR == rstprg.COD_MAC) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                        STL_IND = rstprg.STL_IND;
                                                                        COD_PAR = 0;
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        if (TYPE_OF.equals(TipoParagrafo.UNITA_ORGANIZZATIVA.getType()) || 
                                                            TYPE_OF.equals(TipoParagrafo.DESCRIZIONI_UNITA_ORGANIZZATIVA.getType())) {
                                                            SchedeParagrafo_UNI_ORG_View rst = (SchedeParagrafo_UNI_ORG_View) it.next();
                                                            COD_PAR = rst.COD_UNI_ORG;
                                                            NOM_PAR = rst.NOM_UNI_ORG;
                                                            java.util.Iterator itprg = colprg.iterator();
                                                            while (itprg.hasNext()) {
                                                                SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                                                                if (lCOD_SCH_PRG != 0) {
                                                                    if ((lCOD_SCH_PRG == rstprg.COD_SCH_PRG) && (COD_PAR == rstprg.COD_UNI_ORG)) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                        STL_IND = rstprg.STL_IND;
                                                                    }
                                                                } else {
                                                                    if (COD_PAR == rstprg.COD_UNI_ORG) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                        STL_IND = rstprg.STL_IND;
                                                                        COD_PAR = 0;
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        if (TYPE_OF.equals(TipoParagrafo.UNITA_SICUREZZA.getType()) || 
                                                            TYPE_OF.equals(TipoParagrafo.DESCRIZIONI_UNITA_SICUREZZA.getType())) {
                                                            SchedeParagrafo_UNI_SIC_View rst = (SchedeParagrafo_UNI_SIC_View) it.next();
                                                            COD_PAR = rst.COD_UNI_SIC;
                                                            NOM_PAR = rst.NOM_UNI_SIC;
                                                            java.util.Iterator itprg = colprg.iterator();
                                                            while (itprg.hasNext()) {
                                                                SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                                                                if (lCOD_SCH_PRG != 0) {
                                                                    if ((lCOD_SCH_PRG == rstprg.COD_SCH_PRG) && (COD_PAR == rstprg.COD_UNI_SIC)) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                        STL_IND = rstprg.STL_IND;
                                                                    }
                                                                } else {
                                                                    if (COD_PAR == rstprg.COD_UNI_SIC) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                        STL_IND = rstprg.STL_IND;
                                                                        COD_PAR = 0;
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        if (TYPE_OF.equals(TipoParagrafo.SOSTANZA_CHIMICA.getType())) {
                                                            SchedeParagrafo_SOS_CHI_View rst = (SchedeParagrafo_SOS_CHI_View) it.next();
                                                            COD_PAR = rst.COD_SOS_CHI;
                                                            NOM_PAR = rst.NOM_COM_SOS;
                                                            java.util.Iterator itprg = colprg.iterator();
                                                            while (itprg.hasNext()) {
                                                                SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                                                                if (lCOD_SCH_PRG != 0) {
                                                                    if ((lCOD_SCH_PRG == rstprg.COD_SCH_PRG) && (COD_PAR == rstprg.COD_SOS_CHI)) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                    }
                                                                } else {
                                                                    if (COD_PAR == rstprg.COD_SOS_CHI) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                        COD_PAR = 0;
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        if (TYPE_OF.equals(TipoParagrafo.ATTIVITA_LAVORATIVA.getType()) || 
                                                            TYPE_OF.equals(TipoParagrafo.DESCRIZIONI_ATTIVITA_LAVORATIVA.getType())) {
                                                            SchedeParagrafo_MAN_View rst = (SchedeParagrafo_MAN_View) it.next();
                                                            COD_PAR = rst.COD_MAN;
                                                            NOM_PAR = rst.NOM_MAN;
                                                            java.util.Iterator itprg = colprg.iterator();
                                                            while (itprg.hasNext()) {
                                                                SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                                                                if (lCOD_SCH_PRG != 0) {
                                                                    if ((lCOD_SCH_PRG == rstprg.COD_SCH_PRG) && (COD_PAR == rstprg.COD_MAN)) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                        STL_IND = rstprg.STL_IND;
                                                                    }
                                                                } else {
                                                                    if (COD_PAR == rstprg.COD_MAN) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                        STL_IND = rstprg.STL_IND;
                                                                        COD_PAR = 0;
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        if (TYPE_OF.equals(TipoParagrafo.LUOGO_FISICO.getType()) || 
                                                            TYPE_OF.equals(TipoParagrafo.DESCRIZIONI_LUOGO_FISICO.getType())) {
                                                            SchedeParagrafo_LUO_FSC_View rst = (SchedeParagrafo_LUO_FSC_View) it.next();
                                                            COD_PAR = rst.COD_LUO_FSC;
                                                            NOM_PAR = rst.NOM_LUO_FSC;
                                                            java.util.Iterator itprg = colprg.iterator();
                                                            while (itprg.hasNext()) {
                                                                SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                                                                if (lCOD_SCH_PRG != 0) {
                                                                    if ((lCOD_SCH_PRG == rstprg.COD_SCH_PRG) && (COD_PAR == rstprg.COD_LUO_FSC)) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                        STL_IND = rstprg.STL_IND;
                                                                    }
                                                                } else {
                                                                    if (COD_PAR == rstprg.COD_LUO_FSC) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                        STL_IND = rstprg.STL_IND;
                                                                        COD_PAR = 0;
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        if (TYPE_OF.equals(TipoParagrafo.FATTORE_DI_RISCHIO.getType())) {
                                                            SchedeParagrafo_FAT_RSO_View rst = (SchedeParagrafo_FAT_RSO_View) it.next();
                                                            COD_PAR = rst.COD_FAT_RSO;
                                                            NOM_PAR = rst.NOM_FAT_RSO;
                                                            java.util.Iterator itprg = colprg.iterator();
                                                            while (itprg.hasNext()) {
                                                                SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                                                                if (lCOD_SCH_PRG != 0) {
                                                                    if ((lCOD_SCH_PRG == rstprg.COD_SCH_PRG) && (COD_PAR == rstprg.COD_FAT_RSO)) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                    }
                                                                } else {
                                                                    if (COD_PAR == rstprg.COD_FAT_RSO) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                        COD_PAR = 0;
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        if (TYPE_OF.equals(TipoParagrafo.DESCRIZIONI_IMMOBILI.getType())) {
                                                            SchedeParagrafo_IMM_3LV_View rst = (SchedeParagrafo_IMM_3LV_View) it.next();
                                                            COD_PAR = rst.COD_IMM;
                                                            NOM_PAR = rst.NOM_IMM;
                                                            java.util.Iterator itprg = colprg.iterator();
                                                            while (itprg.hasNext()) {
                                                                SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                                                                if (lCOD_SCH_PRG != 0) {
                                                                    if ((lCOD_SCH_PRG == rstprg.COD_SCH_PRG) && (COD_PAR == rstprg.COD_IMM_3LV)) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                        STL_IND = rstprg.STL_IND;
                                                                    }
                                                                } else {
                                                                    if (COD_PAR == rstprg.COD_IMM_3LV) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                        STL_IND = rstprg.STL_IND;
                                                                        COD_PAR = 0;
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        if (TYPE_OF.equals(TipoParagrafo.DESCRIZIONI_PIANI.getType())) {
                                                            SchedeParagrafo_PNO_View rst = (SchedeParagrafo_PNO_View) it.next();
                                                            COD_PAR = rst.COD_PNO;
                                                            NOM_PAR = rst.NOM_PNO;
                                                            java.util.Iterator itprg = colprg.iterator();
                                                            while (itprg.hasNext()) {
                                                                SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                                                                if (lCOD_SCH_PRG != 0) {
                                                                    if ((lCOD_SCH_PRG == rstprg.COD_SCH_PRG) && (COD_PAR == rstprg.COD_PNO)) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                        STL_IND = rstprg.STL_IND;
                                                                    }
                                                                } else {
                                                                    if (COD_PAR == rstprg.COD_PNO) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                        STL_IND = rstprg.STL_IND;
                                                                        COD_PAR = 0;
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        if (TYPE_OF.equals(TipoParagrafo.DESCRIZIONI_MISURA_PP.getType())) {
                                                            SchedeParagrafo_MIS_PET_View rst = (SchedeParagrafo_MIS_PET_View) it.next();
                                                            COD_PAR = rst.COD_MIS_PET;
                                                            NOM_PAR = rst.NOM_MIS_PET;
                                                            java.util.Iterator itprg = colprg.iterator();
                                                            while (itprg.hasNext()) {
                                                                SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                                                                if (lCOD_SCH_PRG != 0) {
                                                                    if ((lCOD_SCH_PRG == rstprg.COD_SCH_PRG) && (COD_PAR == rstprg.COD_MIS_PET)) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                        STL_IND = rstprg.STL_IND;
                                                                    }
                                                                } else {
                                                                    if (COD_PAR == rstprg.COD_MIS_PET) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                        STL_IND = rstprg.STL_IND;
                                                                        COD_PAR = 0;
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        if (TYPE_OF.equals(TipoParagrafo.DESCRIZIONI_RISCHI.getType())) {
                                                            SchedeParagrafo_RSO_View rst = (SchedeParagrafo_RSO_View) it.next();
                                                            COD_PAR = rst.COD_RSO;
                                                            NOM_PAR = rst.NOM_RSO;
                                                            NOM_PAR_2 = rst.NOM_FAT_RSO;
                                                            java.util.Iterator itprg = colprg.iterator();
                                                            while (itprg.hasNext()) {
                                                                SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                                                                if (lCOD_SCH_PRG != 0) {
                                                                    if ((lCOD_SCH_PRG == rstprg.COD_SCH_PRG) && (COD_PAR == rstprg.COD_RSO)) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                        STL_IND = rstprg.STL_IND;
                                                                    }
                                                                } else {
                                                                    if (COD_PAR == rstprg.COD_RSO) {
                                                                        IS_CHECK = "checked";
                                                                        CK_VAL = rstprg.COD_SCH_PRG;
                                                                        STL_IND = rstprg.STL_IND;
                                                                        COD_PAR = 0;
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        if ((lCOD_SCH_PRG != 0) && (IS_CHECK.equals("checked"))) {
                                        %><script>document.all['id_bef'].value='COD_PAR'+<%=i%>;
                                            document.all['IDS'].value=document.all['IDS'].value+<%=COD_PAR%>+",";
                                        </script><%
                                                        }
                                                        boolean rischi_descr = 
                                                                TYPE_OF.equals(TipoParagrafo.DESCRIZIONI_RISCHI.getType());
                                                        out.print(
                                                                "<tr ID='" + CK_VAL + "'>"
                                                                    + "<td class='1dataTd' style='width: 15%'>"
                                                                        + "<input name='COD_PAR' id='COD_PAR" + i + "' " + IS_CHECK + " type='checkbox' class='checkbox'  value='" + Formatter.format(COD_PAR) + "' onclick='setChecked(this.value,mode,this.id);'>"
                                                                    + "</td>"
                                                                    + "<td class='1dataTd' style='width: 80%'>"
                                                                        + "<input name='NOM_PAR' type='text' readonly class='dataInput' style='width: " + (rischi_descr?"50%;":"100%;") + "' value=\"" + Formatter.format(NOM_PAR) + "\">"
                                                                        + (rischi_descr?"<input name='NOM_PAR_2' type='text' readonly class='dataInput' style='width: 49%;' value=\"" + Formatter.format(NOM_PAR_2) + "\">":"")
                                                                    + "</td>"
                                                                    + "<td class='1dataTd' style='width: 5%; display: "+ (TipoParagrafo.checkBloccoDescrizioni(TYPE_OF) ?"block":"none") + "'>"
                                                                        + "<input name='Indentazione"+COD_PAR+"' size='1' maxlength='1' value='"+(IS_CHECK.equals("checked")?STL_IND:"")+"'>"
                                                                    + "</td>"
                                                                + "</tr>");
                                                        i = i + 1;
                                                    }
                                                    out.print("</table>");
                                                }
                                            }
                                        %></div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </form>
        </table>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" id="ifrmWork"></iframe>
    </body>
</html>
