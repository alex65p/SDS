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

<%@page import="s2s.utils.text.StringManager"%>
<%
    /*
    <file>
    <versions>	
    <version number="1.0" date="10/02/2004" author="Kushkarov Jura">
    <comments>
    <comment date="10/02/2004" author="Kushkarov Jura">
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

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<script language="JavaScript" src="../_scripts/Alert.js"></script>

<script>
    var err=false;
    var isNew=false;
</script>

<%!  String str = "";%>

<%
    ISchedeParagrafoHome home = (ISchedeParagrafoHome) PseudoContext.lookup("SchedeParagrafoBean");
    ISchedeParagrafo SchedeParagrafo = null;
    String ReqMODE = "";
    String TYPE_SCH = "";
    String strPRG_ID = "";
    long lCOD_PRG = 0;
    String strCOD_PAR = "";
    long lCOD_PAR = 0;
    if (request.getParameter("SBM_MODE") != null) {
        out.print(request.getParameter("SBM_MODE"));
        ReqMODE = request.getParameter("SBM_MODE");
        TYPE_SCH = request.getParameter("TYPE");
        strPRG_ID = request.getParameter("ID_PRG");
        lCOD_PRG = new Long(strPRG_ID).longValue();

        //Added by Malyuk Sergey
        if (TipoParagrafo.ANAGRAFICA_AZIENDA.getType().equals(TYPE_SCH) ||
            TipoParagrafo.VALUTAZIONE_RISCHIO.getType().equals(TYPE_SCH)||
            TipoParagrafo.SCHEDA_RISCHI.getType().equals(TYPE_SCH)) {
            if (!home.existSchedeParagrafo_ByPRG_View(Long.parseLong(strPRG_ID), TYPE_SCH)) {
                if (ReqMODE.equals("edt")) {
                    try {
                        Long COD_SCH_PRG = new Long(request.getParameter("COD_SCH_PRG"));
                        SchedeParagrafo = home.findByPrimaryKey(COD_SCH_PRG);
                    } catch (Exception ex) {
                        out.print(request.getParameter("COD_SCH_PRG"));
                    }
                    SchedeParagrafo.setCOD_MAC(0);
                    SchedeParagrafo.setCOD_UNI_ORG(0);
                    SchedeParagrafo.setCOD_UNI_SIC(0);
                    SchedeParagrafo.setCOD_SOS_CHI(0);
                    SchedeParagrafo.setCOD_MAN(0);
                    SchedeParagrafo.setCOD_LUO_FSC(0);
                    SchedeParagrafo.setCOD_FAT_RSO(0);
                    SchedeParagrafo.setCOD_IMM_3LV(0);
                    SchedeParagrafo.setCOD_PNO(0);
                    SchedeParagrafo.setCOD_MIS_PET(0);
                    SchedeParagrafo.setCOD_RSO(0);
                    SchedeParagrafo.setCOD_AZL(0);
                    SchedeParagrafo.setTPL_SCH(TYPE_SCH);
                    SchedeParagrafo.setCOD_PRG(lCOD_PRG);
                }
                if (ReqMODE.equals("new")) {
                    try {
                        SchedeParagrafo = home.create(lCOD_PRG, TYPE_SCH);
                        SchedeParagrafo.setCOD_UNI_ORG_FK(Security.getCurrentDvrUniOrg() == null ? 0 : Security.getCurrentDvrUniOrg().longValue());
                    } catch (Exception ex) {
                        out.println("<script>parent.alert(arraylng[\"MSG_0053\"]);err=true;</script>");
                    }
                }
            } else {
                out.println("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
        } else {
            //Added by Malyuk Sergey
            if (ReqMODE.equals("edt")) {
                if (request.getParameter("COD_PAR") != null) {
                    strCOD_PAR = request.getParameter("COD_PAR");
                    lCOD_PAR = new Long(strCOD_PAR).longValue();
                    try {
                        Long COD_SCH_PRG = new Long(request.getParameter("COD_SCH_PRG"));
                        SchedeParagrafo = home.findByPrimaryKey(COD_SCH_PRG);
                        // Se stò in modifica di una scheda paragrafo di tipologia "Descrizione"
                        // aggiorno il livello di indentazione con quello eventualmente impostato dall'utente.
                        // Inizio
                        String strInd = request.getParameter("Indentazione"+lCOD_PAR);
                        byte bInd = StringManager.isNotEmpty(strInd)?Byte.parseByte(strInd):0;
                        
                        if (TipoParagrafo.checkBloccoDescrizioni(TYPE_SCH)){
                            SchedeParagrafo.setSTL_IND(bInd);
                        }
                        // Se stò in modifica di una scheda paragrafo di tipologia "Descrizione"
                        // aggiorno il livello di indentazione con quello eventualmente impostato dall'utente.
                        // Fine
                    } catch (Exception ex) {
                        out.print(request.getParameter("COD_SCH_PRG"));
                    }
                    try {
                        SchedeParagrafo.setCOD_UNI_ORG_FK(Security.getCurrentDvrUniOrg() == null ? 0 : Security.getCurrentDvrUniOrg().longValue());
                        if (TYPE_SCH.equals(TipoParagrafo.MACCHINA_ATTREZZATURA.getType()) || 
                            TYPE_SCH.equals(TipoParagrafo.DESCRIZIONI_MACCHINA_ATTREZZATURA.getType())) {
                            SchedeParagrafo.setCOD_MAC(lCOD_PAR);
                            SchedeParagrafo.setCOD_UNI_ORG(0);
                            SchedeParagrafo.setCOD_UNI_SIC(0);
                            SchedeParagrafo.setCOD_SOS_CHI(0);
                            SchedeParagrafo.setCOD_MAN(0);
                            SchedeParagrafo.setCOD_LUO_FSC(0);
                            SchedeParagrafo.setCOD_FAT_RSO(0);
                            SchedeParagrafo.setCOD_IMM_3LV(0);
                            SchedeParagrafo.setCOD_PNO(0);
                            SchedeParagrafo.setCOD_MIS_PET(0);
                            SchedeParagrafo.setCOD_RSO(0);
                            SchedeParagrafo.setCOD_AZL(0);
                        }
                        if (TYPE_SCH.equals(TipoParagrafo.UNITA_ORGANIZZATIVA.getType()) || 
                            TYPE_SCH.equals(TipoParagrafo.DESCRIZIONI_UNITA_ORGANIZZATIVA.getType())) {
                            SchedeParagrafo.setCOD_MAC(0);
                            SchedeParagrafo.setCOD_UNI_ORG(lCOD_PAR);
                            SchedeParagrafo.setCOD_UNI_SIC(0);
                            SchedeParagrafo.setCOD_SOS_CHI(0);
                            SchedeParagrafo.setCOD_MAN(0);
                            SchedeParagrafo.setCOD_LUO_FSC(0);
                            SchedeParagrafo.setCOD_FAT_RSO(0);
                            SchedeParagrafo.setCOD_IMM_3LV(0);
                            SchedeParagrafo.setCOD_PNO(0);
                            SchedeParagrafo.setCOD_MIS_PET(0);
                            SchedeParagrafo.setCOD_RSO(0);
                            SchedeParagrafo.setCOD_AZL(0);
                        }
                        if (TYPE_SCH.equals(TipoParagrafo.UNITA_SICUREZZA.getType()) || 
                            TYPE_SCH.equals(TipoParagrafo.DESCRIZIONI_UNITA_SICUREZZA.getType())) {
                            SchedeParagrafo.setCOD_MAC(0);
                            SchedeParagrafo.setCOD_UNI_ORG(0);
                            SchedeParagrafo.setCOD_UNI_SIC(lCOD_PAR);
                            SchedeParagrafo.setCOD_SOS_CHI(0);
                            SchedeParagrafo.setCOD_MAN(0);
                            SchedeParagrafo.setCOD_LUO_FSC(0);
                            SchedeParagrafo.setCOD_FAT_RSO(0);
                            SchedeParagrafo.setCOD_IMM_3LV(0);
                            SchedeParagrafo.setCOD_PNO(0);
                            SchedeParagrafo.setCOD_MIS_PET(0);
                            SchedeParagrafo.setCOD_RSO(0);
                            SchedeParagrafo.setCOD_AZL(0);
                        }
                        if (TYPE_SCH.equals(TipoParagrafo.SOSTANZA_CHIMICA.getType())) {
                            SchedeParagrafo.setCOD_MAC(0);
                            SchedeParagrafo.setCOD_UNI_ORG(0);
                            SchedeParagrafo.setCOD_UNI_SIC(0);
                            SchedeParagrafo.setCOD_SOS_CHI(lCOD_PAR);
                            SchedeParagrafo.setCOD_MAN(0);
                            SchedeParagrafo.setCOD_LUO_FSC(0);
                            SchedeParagrafo.setCOD_FAT_RSO(0);
                            SchedeParagrafo.setCOD_IMM_3LV(0);
                            SchedeParagrafo.setCOD_PNO(0);
                            SchedeParagrafo.setCOD_MIS_PET(0);
                            SchedeParagrafo.setCOD_RSO(0);
                            SchedeParagrafo.setCOD_AZL(0);
                        }
                        if (TYPE_SCH.equals(TipoParagrafo.ATTIVITA_LAVORATIVA.getType()) || 
                            TYPE_SCH.equals(TipoParagrafo.DESCRIZIONI_ATTIVITA_LAVORATIVA.getType())) {
                            SchedeParagrafo.setCOD_MAC(0);
                            SchedeParagrafo.setCOD_UNI_ORG(0);
                            SchedeParagrafo.setCOD_UNI_SIC(0);
                            SchedeParagrafo.setCOD_SOS_CHI(0);
                            SchedeParagrafo.setCOD_MAN(lCOD_PAR);
                            SchedeParagrafo.setCOD_LUO_FSC(0);
                            SchedeParagrafo.setCOD_FAT_RSO(0);
                            SchedeParagrafo.setCOD_IMM_3LV(0);
                            SchedeParagrafo.setCOD_PNO(0);
                            SchedeParagrafo.setCOD_MIS_PET(0);
                            SchedeParagrafo.setCOD_RSO(0);
                            SchedeParagrafo.setCOD_AZL(0);
                        }
                        if (TYPE_SCH.equals(TipoParagrafo.LUOGO_FISICO.getType()) || 
                            TYPE_SCH.equals(TipoParagrafo.DESCRIZIONI_LUOGO_FISICO.getType())) {
                            SchedeParagrafo.setCOD_MAC(0);
                            SchedeParagrafo.setCOD_UNI_ORG(0);
                            SchedeParagrafo.setCOD_UNI_SIC(0);
                            SchedeParagrafo.setCOD_SOS_CHI(0);
                            SchedeParagrafo.setCOD_MAN(0);
                            SchedeParagrafo.setCOD_LUO_FSC(lCOD_PAR);
                            SchedeParagrafo.setCOD_FAT_RSO(0);
                            SchedeParagrafo.setCOD_IMM_3LV(0);
                            SchedeParagrafo.setCOD_PNO(0);
                            SchedeParagrafo.setCOD_MIS_PET(0);
                            SchedeParagrafo.setCOD_RSO(0);
                            SchedeParagrafo.setCOD_AZL(0);
                        }
                        if (TYPE_SCH.equals(TipoParagrafo.FATTORE_DI_RISCHIO.getType())) {
                            SchedeParagrafo.setCOD_MAC(0);
                            SchedeParagrafo.setCOD_UNI_ORG(0);
                            SchedeParagrafo.setCOD_UNI_SIC(0);
                            SchedeParagrafo.setCOD_SOS_CHI(0);
                            SchedeParagrafo.setCOD_MAN(0);
                            SchedeParagrafo.setCOD_LUO_FSC(0);
                            SchedeParagrafo.setCOD_FAT_RSO(lCOD_PAR);
                            SchedeParagrafo.setCOD_IMM_3LV(0);
                            SchedeParagrafo.setCOD_PNO(0);
                            SchedeParagrafo.setCOD_MIS_PET(0);
                            SchedeParagrafo.setCOD_RSO(0);
                            SchedeParagrafo.setCOD_AZL(0);
                        }
                        if (TYPE_SCH.equals(TipoParagrafo.DESCRIZIONI_IMMOBILI.getType())) {
                            SchedeParagrafo.setCOD_MAC(0);
                            SchedeParagrafo.setCOD_UNI_ORG(0);
                            SchedeParagrafo.setCOD_UNI_SIC(0);
                            SchedeParagrafo.setCOD_SOS_CHI(0);
                            SchedeParagrafo.setCOD_MAN(0);
                            SchedeParagrafo.setCOD_LUO_FSC(0);
                            SchedeParagrafo.setCOD_FAT_RSO(0);
                            SchedeParagrafo.setCOD_IMM_3LV(lCOD_PAR);
                            SchedeParagrafo.setCOD_PNO(0);
                            SchedeParagrafo.setCOD_MIS_PET(0);
                            SchedeParagrafo.setCOD_RSO(0);
                            SchedeParagrafo.setCOD_AZL(0);
                        }
                        if (TYPE_SCH.equals(TipoParagrafo.DESCRIZIONI_PIANI.getType())) {
                            SchedeParagrafo.setCOD_MAC(0);
                            SchedeParagrafo.setCOD_UNI_ORG(0);
                            SchedeParagrafo.setCOD_UNI_SIC(0);
                            SchedeParagrafo.setCOD_SOS_CHI(0);
                            SchedeParagrafo.setCOD_MAN(0);
                            SchedeParagrafo.setCOD_LUO_FSC(0);
                            SchedeParagrafo.setCOD_FAT_RSO(0);
                            SchedeParagrafo.setCOD_IMM_3LV(0);
                            SchedeParagrafo.setCOD_PNO(lCOD_PAR);
                            SchedeParagrafo.setCOD_MIS_PET(0);
                            SchedeParagrafo.setCOD_RSO(0);
                            SchedeParagrafo.setCOD_AZL(0);
                        }
                        if (TYPE_SCH.equals(TipoParagrafo.DESCRIZIONI_MISURA_PP.getType())) {
                            SchedeParagrafo.setCOD_MAC(0);
                            SchedeParagrafo.setCOD_UNI_ORG(0);
                            SchedeParagrafo.setCOD_UNI_SIC(0);
                            SchedeParagrafo.setCOD_SOS_CHI(0);
                            SchedeParagrafo.setCOD_MAN(0);
                            SchedeParagrafo.setCOD_LUO_FSC(0);
                            SchedeParagrafo.setCOD_FAT_RSO(0);
                            SchedeParagrafo.setCOD_IMM_3LV(0);
                            SchedeParagrafo.setCOD_PNO(0);
                            SchedeParagrafo.setCOD_MIS_PET(lCOD_PAR);
                            SchedeParagrafo.setCOD_RSO(0);
                            SchedeParagrafo.setCOD_AZL(0);
                        }
                        if (TYPE_SCH.equals(TipoParagrafo.DESCRIZIONI_RISCHI.getType())) {
                            SchedeParagrafo.setCOD_MAC(0);
                            SchedeParagrafo.setCOD_UNI_ORG(0);
                            SchedeParagrafo.setCOD_UNI_SIC(0);
                            SchedeParagrafo.setCOD_SOS_CHI(0);
                            SchedeParagrafo.setCOD_MAN(0);
                            SchedeParagrafo.setCOD_LUO_FSC(0);
                            SchedeParagrafo.setCOD_FAT_RSO(0);
                            SchedeParagrafo.setCOD_IMM_3LV(0);
                            SchedeParagrafo.setCOD_PNO(0);
                            SchedeParagrafo.setCOD_MIS_PET(0);
                            SchedeParagrafo.setCOD_RSO(lCOD_PAR);
                            SchedeParagrafo.setCOD_AZL(Security.getAzienda());
                        }
                        SchedeParagrafo.setTPL_SCH(TYPE_SCH);
                        SchedeParagrafo.setCOD_PRG(lCOD_PRG);
                    } catch (Exception ex) {
                        out.print(lCOD_PAR + "--" + TYPE_SCH + "--" + lCOD_PRG);
                    }
                } else {
                    Long COD_SCH_PRG = new Long(request.getParameter("COD_SCH_PRG"));
                    try {
                        home.remove(COD_SCH_PRG);
                    } catch (Exception ex) {
                        out.print("<script>err=true;</script>");
                    }
                }
            } else {
                if (!request.getParameter("IDS").equals(",")) {
                    str = (String) request.getParameter("IDS");
                    str = str.substring(1);
                    int oldPos = 0;
                    int pos = 1;
                    while (oldPos < str.length()) {
                        pos = str.indexOf(",", oldPos);
                        strCOD_PAR = str.substring(oldPos, pos);
                        lCOD_PAR = new Long(strCOD_PAR).longValue();
                        if (ReqMODE.equals("new")) {
                            out.print(TYPE_SCH);
                            try {
                                SchedeParagrafo = home.create(lCOD_PRG, TYPE_SCH);
                                SchedeParagrafo.setCOD_UNI_ORG_FK(Security.getCurrentDvrUniOrg() == null ? 0 : Security.getCurrentDvrUniOrg().longValue());
                                // Se stò inserendo una o piu schede paragrafo di tipologia "Descrizione"
                                // inserisco anche, per ognuna di esse, il livello di indentazione eventualmente impostato dall'utente.
                                // Inizio
                                String strInd = request.getParameter("Indentazione"+lCOD_PAR);
                                byte bInd = StringManager.isNotEmpty(strInd)?Byte.parseByte(strInd):0;

                                if (TipoParagrafo.checkBloccoDescrizioni(TYPE_SCH)){
                                    SchedeParagrafo.setSTL_IND(bInd);
                                }
                                // Se stò inserendo una o piu schede paragrafo di tipologia "Descrizione"
                                // inserisco anche, per ognuna di esse, il livello di indentazione eventualmente impostato dall'utente.
                                // Fine
                            } catch (Exception ex) {
                                out.println("<script>parent.alert(arraylng[\"MSG_0053\"]);err=true;</script>");
                            }
                        }
                        if (SchedeParagrafo != null) {
                            //   *Not require Fields*
                            if (TYPE_SCH.equals(TipoParagrafo.MACCHINA_ATTREZZATURA.getType()) || 
                                TYPE_SCH.equals(TipoParagrafo.DESCRIZIONI_MACCHINA_ATTREZZATURA.getType())) {
                                SchedeParagrafo.setCOD_MAC(lCOD_PAR);
                                SchedeParagrafo.setCOD_UNI_ORG(0);
                                SchedeParagrafo.setCOD_UNI_SIC(0);
                                SchedeParagrafo.setCOD_SOS_CHI(0);
                                SchedeParagrafo.setCOD_MAN(0);
                                SchedeParagrafo.setCOD_LUO_FSC(0);
                                SchedeParagrafo.setCOD_FAT_RSO(0);
                                SchedeParagrafo.setCOD_IMM_3LV(0);
                                SchedeParagrafo.setCOD_PNO(0);
                                SchedeParagrafo.setCOD_MIS_PET(0);
                                SchedeParagrafo.setCOD_RSO(0);
                                SchedeParagrafo.setCOD_AZL(0);
                            }
                            if (TYPE_SCH.equals(TipoParagrafo.UNITA_ORGANIZZATIVA.getType()) || 
                                TYPE_SCH.equals(TipoParagrafo.DESCRIZIONI_UNITA_ORGANIZZATIVA.getType())) {
                                SchedeParagrafo.setCOD_MAC(0);
                                SchedeParagrafo.setCOD_UNI_ORG(lCOD_PAR);
                                SchedeParagrafo.setCOD_UNI_SIC(0);
                                SchedeParagrafo.setCOD_SOS_CHI(0);
                                SchedeParagrafo.setCOD_MAN(0);
                                SchedeParagrafo.setCOD_LUO_FSC(0);
                                SchedeParagrafo.setCOD_FAT_RSO(0);
                                SchedeParagrafo.setCOD_IMM_3LV(0);
                                SchedeParagrafo.setCOD_PNO(0);
                                SchedeParagrafo.setCOD_MIS_PET(0);
                                SchedeParagrafo.setCOD_RSO(0);
                                SchedeParagrafo.setCOD_AZL(0);
                            }
                            if (TYPE_SCH.equals(TipoParagrafo.UNITA_SICUREZZA.getType()) || 
                                TYPE_SCH.equals(TipoParagrafo.DESCRIZIONI_UNITA_SICUREZZA.getType())) {
                                SchedeParagrafo.setCOD_MAC(0);
                                SchedeParagrafo.setCOD_UNI_ORG(0);
                                SchedeParagrafo.setCOD_UNI_SIC(lCOD_PAR);
                                SchedeParagrafo.setCOD_SOS_CHI(0);
                                SchedeParagrafo.setCOD_MAN(0);
                                SchedeParagrafo.setCOD_LUO_FSC(0);
                                SchedeParagrafo.setCOD_FAT_RSO(0);
                                SchedeParagrafo.setCOD_IMM_3LV(0);
                                SchedeParagrafo.setCOD_PNO(0);
                                SchedeParagrafo.setCOD_MIS_PET(0);
                                SchedeParagrafo.setCOD_RSO(0);
                                SchedeParagrafo.setCOD_AZL(0);
                            }
                            if (TYPE_SCH.equals(TipoParagrafo.SOSTANZA_CHIMICA.getType())) {
                                SchedeParagrafo.setCOD_MAC(0);
                                SchedeParagrafo.setCOD_UNI_ORG(0);
                                SchedeParagrafo.setCOD_UNI_SIC(0);
                                SchedeParagrafo.setCOD_SOS_CHI(lCOD_PAR);
                                SchedeParagrafo.setCOD_MAN(0);
                                SchedeParagrafo.setCOD_LUO_FSC(0);
                                SchedeParagrafo.setCOD_FAT_RSO(0);
                                SchedeParagrafo.setCOD_IMM_3LV(0);
                                SchedeParagrafo.setCOD_PNO(0);
                                SchedeParagrafo.setCOD_MIS_PET(0);
                                SchedeParagrafo.setCOD_RSO(0);
                                SchedeParagrafo.setCOD_AZL(0);
                            }
                            if (TYPE_SCH.equals(TipoParagrafo.ATTIVITA_LAVORATIVA.getType()) || 
                                TYPE_SCH.equals(TipoParagrafo.DESCRIZIONI_ATTIVITA_LAVORATIVA.getType())) {
                                SchedeParagrafo.setCOD_MAC(0);
                                SchedeParagrafo.setCOD_UNI_ORG(0);
                                SchedeParagrafo.setCOD_UNI_SIC(0);
                                SchedeParagrafo.setCOD_SOS_CHI(0);
                                SchedeParagrafo.setCOD_MAN(lCOD_PAR);
                                SchedeParagrafo.setCOD_LUO_FSC(0);
                                SchedeParagrafo.setCOD_FAT_RSO(0);
                                SchedeParagrafo.setCOD_IMM_3LV(0);
                                SchedeParagrafo.setCOD_PNO(0);
                                SchedeParagrafo.setCOD_MIS_PET(0);
                                SchedeParagrafo.setCOD_RSO(0);
                                SchedeParagrafo.setCOD_AZL(0);
                            }
                            if (TYPE_SCH.equals(TipoParagrafo.LUOGO_FISICO.getType()) || 
                                TYPE_SCH.equals(TipoParagrafo.DESCRIZIONI_LUOGO_FISICO.getType())) {
                                SchedeParagrafo.setCOD_MAC(0);
                                SchedeParagrafo.setCOD_UNI_ORG(0);
                                SchedeParagrafo.setCOD_UNI_SIC(0);
                                SchedeParagrafo.setCOD_SOS_CHI(0);
                                SchedeParagrafo.setCOD_MAN(0);
                                SchedeParagrafo.setCOD_LUO_FSC(lCOD_PAR);
                                SchedeParagrafo.setCOD_FAT_RSO(0);
                                SchedeParagrafo.setCOD_IMM_3LV(0);
                                SchedeParagrafo.setCOD_PNO(0);
                                SchedeParagrafo.setCOD_MIS_PET(0);
                                SchedeParagrafo.setCOD_RSO(0);
                                SchedeParagrafo.setCOD_AZL(0);
                            }
                            if (TYPE_SCH.equals(TipoParagrafo.FATTORE_DI_RISCHIO.getType())) {
                                SchedeParagrafo.setCOD_MAC(0);
                                SchedeParagrafo.setCOD_UNI_ORG(0);
                                SchedeParagrafo.setCOD_UNI_SIC(0);
                                SchedeParagrafo.setCOD_SOS_CHI(0);
                                SchedeParagrafo.setCOD_MAN(0);
                                SchedeParagrafo.setCOD_LUO_FSC(0);
                                SchedeParagrafo.setCOD_FAT_RSO(lCOD_PAR);
                                SchedeParagrafo.setCOD_IMM_3LV(0);
                                SchedeParagrafo.setCOD_PNO(0);
                                SchedeParagrafo.setCOD_MIS_PET(0);
                                SchedeParagrafo.setCOD_RSO(0);
                                SchedeParagrafo.setCOD_AZL(0);
                            }
                            if (TYPE_SCH.equals(TipoParagrafo.DESCRIZIONI_IMMOBILI.getType())) {
                                SchedeParagrafo.setCOD_MAC(0);
                                SchedeParagrafo.setCOD_UNI_ORG(0);
                                SchedeParagrafo.setCOD_UNI_SIC(0);
                                SchedeParagrafo.setCOD_SOS_CHI(0);
                                SchedeParagrafo.setCOD_MAN(0);
                                SchedeParagrafo.setCOD_LUO_FSC(0);
                                SchedeParagrafo.setCOD_FAT_RSO(0);
                                SchedeParagrafo.setCOD_IMM_3LV(lCOD_PAR);
                                SchedeParagrafo.setCOD_PNO(0);
                                SchedeParagrafo.setCOD_MIS_PET(0);
                                SchedeParagrafo.setCOD_RSO(0);
                                SchedeParagrafo.setCOD_AZL(0);
                            }
                            if (TYPE_SCH.equals(TipoParagrafo.DESCRIZIONI_PIANI.getType())) {
                                SchedeParagrafo.setCOD_MAC(0);
                                SchedeParagrafo.setCOD_UNI_ORG(0);
                                SchedeParagrafo.setCOD_UNI_SIC(0);
                                SchedeParagrafo.setCOD_SOS_CHI(0);
                                SchedeParagrafo.setCOD_MAN(0);
                                SchedeParagrafo.setCOD_LUO_FSC(0);
                                SchedeParagrafo.setCOD_FAT_RSO(0);
                                SchedeParagrafo.setCOD_IMM_3LV(0);
                                SchedeParagrafo.setCOD_PNO(lCOD_PAR);
                                SchedeParagrafo.setCOD_MIS_PET(0);
                                SchedeParagrafo.setCOD_RSO(0);
                                SchedeParagrafo.setCOD_AZL(0);
                            }
                            if (TYPE_SCH.equals(TipoParagrafo.DESCRIZIONI_MISURA_PP.getType())) {
                                SchedeParagrafo.setCOD_MAC(0);
                                SchedeParagrafo.setCOD_UNI_ORG(0);
                                SchedeParagrafo.setCOD_UNI_SIC(0);
                                SchedeParagrafo.setCOD_SOS_CHI(0);
                                SchedeParagrafo.setCOD_MAN(0);
                                SchedeParagrafo.setCOD_LUO_FSC(0);
                                SchedeParagrafo.setCOD_FAT_RSO(0);
                                SchedeParagrafo.setCOD_IMM_3LV(0);
                                SchedeParagrafo.setCOD_PNO(0);
                                SchedeParagrafo.setCOD_MIS_PET(lCOD_PAR);
                                SchedeParagrafo.setCOD_RSO(0);
                                SchedeParagrafo.setCOD_AZL(0);
                            }
                            if (TYPE_SCH.equals(TipoParagrafo.DESCRIZIONI_RISCHI.getType())) {
                                SchedeParagrafo.setCOD_MAC(0);
                                SchedeParagrafo.setCOD_UNI_ORG(0);
                                SchedeParagrafo.setCOD_UNI_SIC(0);
                                SchedeParagrafo.setCOD_SOS_CHI(0);
                                SchedeParagrafo.setCOD_MAN(0);
                                SchedeParagrafo.setCOD_LUO_FSC(0);
                                SchedeParagrafo.setCOD_FAT_RSO(0);
                                SchedeParagrafo.setCOD_IMM_3LV(0);
                                SchedeParagrafo.setCOD_PNO(0);
                                SchedeParagrafo.setCOD_MIS_PET(0);
                                SchedeParagrafo.setCOD_RSO(lCOD_PAR);
                                SchedeParagrafo.setCOD_AZL(Security.getAzienda());
                            }
                        }
                        oldPos = pos + 1;
                    }
                } else {
                    out.print("<script>parent.alert(arraylng[\"MSG_0052\"]);err=true;</script>");
                }
            }
        }
    }
%>
<script>
    if(!err){	
        parent.returnValue="OK";
        if(isNew){
            Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=SchedeParagrafo!=null?SchedeParagrafo.getCOD_SCH_PRG():""%>");            
        }else{
            Alert.Success.showSaved();
        }
    }else{
        parent.returnValue="ERROR";	
    }	
</script>
