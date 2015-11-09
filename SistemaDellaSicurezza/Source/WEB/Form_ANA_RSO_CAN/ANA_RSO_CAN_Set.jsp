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
            <version number="1.0" date="28/01/2004" author="Artur Denysenko">
            <comments>
            <comment date="28/01/2004" author="Artur Denysenko">
            <description>ANA_RSO_Set.jsp</description>
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */

            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
            response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.RischioCantiere.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/ExtendedMode.jsp"%>

<script src="../_scripts/Alert.js"></script>
<html>
<body>
<script>var err=false; var isNew=false;</script>
<%!
    String ReqMODE;	// parameter of request
%>
<%
    Checker c = new Checker();
    IRischioCantiere bean = null;

    //-----start check section--------------------------------

    long lCOD_AZL = Security.getAzienda();
    long lCOD_RSO = c.checkLong("Rischio", request.getParameter("COD_RSO"), true);
    String strNOM_RSO = c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome.rischio"), request.getParameter("NOM_RSO"), true);
    String strDES_RSO = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione.rischio"), request.getParameter("DES_RSO"), false);
    java.sql.Date dtDAT_RIL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.rilevazione"), request.getParameter("DAT_RIL"), false);
    String strNOM_RIL_RSO = c.checkString(ApplicationConfigurator.LanguageManager.getString("Nominativo.rilevatore"), request.getParameter("NOM_RIL_RSO"), false);
    String strCLF_RSO = request.getParameter("CLF_RSO") + request.getParameter("CLF_RSO_TEXT");

    strCLF_RSO = c.checkString("Classificazione Rischio", strCLF_RSO, false);

    strCLF_RSO = c.checkString(ApplicationConfigurator.LanguageManager.getString("Classificazione.rischio"), request.getParameter("CLF_RSO"), false);
    String strCLF_RSO_TEXT = c.checkString("Classificazione Rischio", request.getParameter("CLF_RSO_TEXT"), false);//

    if (!strCLF_RSO.equals(strCLF_RSO_TEXT) && !strCLF_RSO_TEXT.equals("")) {
        strCLF_RSO = strCLF_RSO_TEXT;

    }

    long lPRB_EVE_LES = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Probabilità.evento.lesivo"), request.getParameter("PRB_EVE_LES"), false);
    long lENT_DAN = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Entità.danno"), request.getParameter("ENT_DAN"), false);

    long lFRQ_RIP_ATT_DAN = 0;
    long lNUM_INC_INF = 0;

    if (Security.getAziendaModalitaCalcoloRischio() == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {
        lFRQ_RIP_ATT_DAN = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Frequenza.dell'attività.a.rischio"), request.getParameter("FRQ_RIP_ATT_DAN"), false);
        lNUM_INC_INF = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Numero.di.incidenti/infortuni.(negli.ultimi.3.anni)"), request.getParameter("NUM_INC_INF"), false);
    }

    float lSTM_NUM_RSO = c.checkFloat(ApplicationConfigurator.LanguageManager.getString("Stima.numerica.del.rischio"), request.getParameter("STM_NUM_RSO"), false);
    long lRFC_VLU_RSO_MES = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Rifacimento.valutazione.(in.mesi)"), request.getParameter("RFC_VLU_RSO_MES"), false);
    long lCOD_FAT_RSO = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio"), request.getParameter("COD_FAT_RSO"), true);
    long lCOD_RSO_RPO = 0;//c.checkLong("Rischio per",request.getParameter("COD_RSO_RPO"),false);

    if (c.isError) {
        String err = c.printErrors();
%>
<script>alert("<%=err%>");</script>
<%
        return;
    }
    ArrayList alAziende = ExtendedMode.getAziende(c); //EXTENDED

    IRischioCantiereHome home = (IRischioCantiereHome) PseudoContext.lookup("RischioCantiereBean");

    //------end check section--------------------------------

    if (request.getParameter("SBM_MODE") != null) {
        ReqMODE = request.getParameter("SBM_MODE");
        try {
            if (ReqMODE.equals("edt")) {
                bean = home.findByPrimaryKey(new RischioPK(Security.getAzienda(), lCOD_RSO));
                bean.store(strNOM_RSO, strDES_RSO, dtDAT_RIL, strNOM_RIL_RSO, strCLF_RSO, lPRB_EVE_LES,
                        lENT_DAN, lFRQ_RIP_ATT_DAN, lNUM_INC_INF, lSTM_NUM_RSO, lRFC_VLU_RSO_MES, lCOD_FAT_RSO, alAziende);
            } else {
                bean = home.create(lCOD_AZL, strNOM_RSO, strDES_RSO, dtDAT_RIL, strNOM_RIL_RSO, strCLF_RSO, lPRB_EVE_LES, lENT_DAN,
                        lFRQ_RIP_ATT_DAN, lNUM_INC_INF, lSTM_NUM_RSO, lRFC_VLU_RSO_MES, lCOD_FAT_RSO, lCOD_RSO_RPO, alAziende);
                lCOD_RSO = bean.getCOD_RSO();
%>
<script>
    isNew=true;
</script>
<%
            }
        } catch (Exception ex) {
            ex.printStackTrace();
%>
<script>err=true;</script>
<%
        }
    }
%>
<script>
    if (!err){
        if(isNew){
            Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=lCOD_RSO%>");
            }
            else{
                Alert.Success.showSaved();
            }
        }
        else{
            Alert.Error.showDublicate();
        }
        </script>
