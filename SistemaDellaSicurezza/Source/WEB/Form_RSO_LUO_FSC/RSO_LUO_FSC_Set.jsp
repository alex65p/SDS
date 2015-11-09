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
     <version number="1.0" date="05/02/2004" author="Alexey Kolesnik">
     <comments>
     <comment date="05/02/2004" author="Alexey Kolesnik">
     <description>Realizazija EJB dlia objecta LuogoFisicoRischio</description>
     </comment>
     <comment date="29/03/2004" author="Roman Chumachenko">
     <description>New recording of PRS_MIS_PET and Corsi, Rischi, DPI</description>
     </comment>
     </comments>
     </version>
     </versions>
     </file>
     */
%>
<%@ page import="com.apconsulting.luna.ejb.MisurePreventive.*" %>
<%@ page import="com.apconsulting.luna.ejb.LuogoFisicoRischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script>var err = false;
    var isNew = false;</script>

<%!    String ReqMODE;	// parameter of request
%>

<%//-----start check section--------------------------------
    Checker c = new Checker();
    String strPRS_RSO = "S";
    String strSTA_RSO = "V";
    java.util.Date cdt = new java.util.Date();
    java.sql.Date dtDAT_INZ = new java.sql.Date(cdt.getYear(), cdt.getMonth(), cdt.getDate());
    long lCOD_RSO_LUO_FSC = c.checkLong("COD_RSO_LUO_FSC", request.getParameter("COD_RSO_LUO_FSC"), true);
    long lCOD_LUO_FSC = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Luogo.fisico"), request.getParameter("COD_LUO_FSC"), true);
    long lCOD_RSO = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Rischio"), request.getParameter("COD_RSO"), true);
    long lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"), request.getParameter("COD_AZL"), true);

    boolean ifMsr = ApplicationConfigurator.isModuleEnabled(MODULES.INVISIBLE_FIELD);
    String strNOM_RIL_RSO = "";
    java.sql.Date dtDAT_RFC_VLU_RSO = null;
    if (!ifMsr) {
        strNOM_RIL_RSO = c.checkString(ApplicationConfigurator.LanguageManager.getString("Nominativo.rilevatore"), request.getParameter("NOM_RIL_RSO"), true);
    }
    String strCLF_RSO = c.checkString(ApplicationConfigurator.LanguageManager.getString("Classificazione.rischio"), request.getParameter("CLF_RSO"), true);
    long lPRB_EVE_LES = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Probabilità.dell'evento.lesivo"), request.getParameter("PRB_EVE_LES"), true);
    long lENT_DAN = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Entità.del.danno"), request.getParameter("ENT_DAN"), true);

    long lFRQ_RIP_ATT_DAN = 0;
    long lNUM_INC_INF = 0;

    if (Security.getAziendaModalitaCalcoloRischio() == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {
        lFRQ_RIP_ATT_DAN = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Frequenza.dell'attività.a.rischio"), request.getParameter("FRQ_RIP_ATT_DAN"), true);
        lNUM_INC_INF = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Numero.di.incidenti/infortuni.(negli.ultimi.3.anni)"), request.getParameter("NUM_INC_INF"), true);
    }

    float lSTM_NUM_RSO = c.checkFloat(ApplicationConfigurator.LanguageManager.getString("Stima.numerica.del.rischio"), request.getParameter("STM_NUM_RSO"), true);
    if (!ifMsr) {
        dtDAT_RFC_VLU_RSO = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.rifacimento.valutazione.rischio"), request.getParameter("DAT_RFC_VLU_RSO"), true);
    }
    if (c.isError) {
        String err = c.printErrors();
        out.print("<script>alert(\"" + err + "\");</script>");
        return;
    }

    ILuogoFisicoRischioHome home = (ILuogoFisicoRischioHome) PseudoContext.lookup("LuogoFisicoRischioBean");
    IMisurePreventiveHome misura_home = (IMisurePreventiveHome) PseudoContext.lookup("MisurePreventiveBean");
    ILuogoFisicoRischio bean = null;
    IMisurePreventive misura_bean = null;
//------end check section--------------------------------
    if (request.getParameter("SBM_MODE") != null) {
        ReqMODE = request.getParameter("SBM_MODE");
        if (ReqMODE.equals("edt")) {
            bean = home.findByPrimaryKey(new Long(lCOD_RSO_LUO_FSC));
            try {
                bean.setCOD_LUO_FSC__COD_RSO__COD_AZL(lCOD_LUO_FSC, lCOD_RSO, lCOD_AZL);
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
            bean.setNOM_RIL_RSO(strNOM_RIL_RSO);
            bean.setCLF_RSO(strCLF_RSO);
            bean.setPRB_EVE_LES(lPRB_EVE_LES);
            bean.setENT_DAN(lENT_DAN);
            bean.setFRQ_RIP_ATT_DAN(lFRQ_RIP_ATT_DAN);
            bean.setNUM_INC_INF(lNUM_INC_INF);
            bean.setSTM_NUM_RSO(lSTM_NUM_RSO);
            if (!ifMsr) {
                bean.setDAT_RFC_VLU_RSO(dtDAT_RFC_VLU_RSO);
            }
            //---------------------
        } else {
            try {
                bean = home.create(lCOD_LUO_FSC, lCOD_RSO, lCOD_AZL, strPRS_RSO, dtDAT_INZ, strNOM_RIL_RSO, strCLF_RSO, lPRB_EVE_LES, lENT_DAN, lFRQ_RIP_ATT_DAN, lNUM_INC_INF, lSTM_NUM_RSO, dtDAT_RFC_VLU_RSO, strSTA_RSO);
                lCOD_RSO_LUO_FSC = bean.getCOD_RSO_LUO_FSC();
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
%><script>isNew = true;</script><%
        }
        if (bean != null) {
            //-- array of ids mesures---
            if (request.getParameterValues("CHK_PRS_MIS_HID") != null) {
                java.util.Date dt = new java.util.Date();
                java.sql.Date CUR_DAT = new java.sql.Date(dt.getTime());
                String[] CHK_ITEMS = request.getParameterValues("CHK_PRS_MIS_HID");
                for (int i = 0; i < CHK_ITEMS.length; i++) {
                    out.print(CHK_ITEMS[i] + "<br>");
                    Long id_misura = new Long(CHK_ITEMS[i]);
                    misura_bean = misura_home.findByPrimaryKey(id_misura);
                    misura_bean.setPRS_MIS_PET("N");
                    misura_bean.setDAT_FIE(CUR_DAT);
                }
            }
                //-----
            //++++++++++++++++++++++++++
            out.println("COD_RSO" + lCOD_RSO + " ");
            out.println("COD_LUO_FSC" + lCOD_LUO_FSC + "<br>");
            bean.addRischioAssociations(lCOD_AZL);
            out.println("AFTER COD_RSO" + lCOD_RSO + "<br>");
            //++++++++++++++++++++++++++		
        }//
    }
%>
<script>
    if (!err) {
        if (isNew) {
            Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=lCOD_RSO_LUO_FSC%>");
        }
        else {
            Alert.Success.showSaved();
        }
    }
</script>
