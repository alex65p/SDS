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
    <version number="1.0" date="28/01/2004" author="Alexey Kolesnik">		
    <comments>
    <comment date="28/01/2004" author="Alexey Kolesnik">
    <description> Realizazija Set dlia objecta RapportiniSegnalazione
    </comment>	
    <comment date="26/02/2004" author="Podmasteriev Alexandr">
    <description> Izmenil scriptovie functions v konce faila
    </comment>		
    </comments> 
    </version>
    </versions>
    </file> 
     */
%>
<%@ page import="com.apconsulting.luna.ejb.RapportiniSegnalazione.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES"%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!    String ReqMODE;	// parameter of request 
%>

<script>
    var err=false;
    var isNew = false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>

<%
    IRapportiniSegnalazione bean = null;
    IRapportiniSegnalazioneHome home = (IRapportiniSegnalazioneHome) PseudoContext.lookup("RapportiniSegnalazioneBean");
    
//-----start check section--------------------------------
    Checker c = new Checker();

    long lCOD_SGZ = c.checkLong("Segnalazione", request.getParameter("COD_SGZ"), true);
    long lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"), request.getParameter("COD_AZL"), true);
    long lCOD_DPD = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Lavoratore"), request.getParameter("COD_DPD"), true);
    String strTIT_SGZ = c.checkString(ApplicationConfigurator.LanguageManager.getString(
            ApplicationConfigurator.isModuleEnabled(MODULES.SEG_REG_MON) ? "Segnalazione" : "Titolo"), request.getParameter("TIT_SGZ"), true);
    String strSTA_SGZ = c.checkString(ApplicationConfigurator.LanguageManager.getString("Stato"), request.getParameter("STA_SGZ"), true);
    long lCOD_IMM = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Immobile"), request.getParameter("COD_IMM"), false);
    long lCOD_LUO_FSC = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Luogo.fisico"), request.getParameter("COD_LUO_FSC"), false);
    String strNOM_RIL_SGZ = c.checkString(ApplicationConfigurator.LanguageManager.getString("Rilevatore"), request.getParameter("NOM_RIL_SGZ"), true);
    String strNUM_SGZ = request.getParameter("NUM_SGZ");
// Numero (default)    
    long lNUM_SGZ = 0;
    if ((strNUM_SGZ != null) && (!strNUM_SGZ.equals(""))) {
        lNUM_SGZ = c.checkLong("Numero", strNUM_SGZ, true);
    } else {
        Collection col = home.getMax_Numero_View();
        Iterator it = col.iterator();
        while (it.hasNext()) {
            Max_Numero_View view = (Max_Numero_View) it.next();
            lNUM_SGZ = c.checkLong("Numero", Formatter.format(view.NUM_SGZ), true);
        }
        lNUM_SGZ += 1;
    }
    long lVER_SGZ = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Versione"), request.getParameter("VER_SGZ"), true);
    String strSTA_FIE_SGZ = c.checkString(ApplicationConfigurator.LanguageManager.getString("Stato.finale"), request.getParameter("STA_FIE_SGZ"), false);
// Urgente (default)
    String strURG_SGZ = c.checkString(ApplicationConfigurator.LanguageManager.getString("Urgente"), request.getParameter("URG_SGZ"), true);
    if ((request.getParameter("URG_SGZ") == null) || (request.getParameter("URG_SGZ").equals(""))) {
        strURG_SGZ = "N";
    }
// Data (default)
    String strDAT_SGZ = request.getParameter("DAT_SGZ");
    java.util.Date cdt = new java.util.Date();
    java.sql.Date dtDAT_SGZ = new java.sql.Date(cdt.getYear(), cdt.getMonth(), cdt.getDate());
    if ((strDAT_SGZ != null) && (!strDAT_SGZ.equals(""))) {
        dtDAT_SGZ = c.checkDate("Data", strDAT_SGZ, true);
    } else {
        dtDAT_SGZ = c.checkDate("Data", Formatter.format(dtDAT_SGZ), true);
    }
    java.sql.Date dtDAT_FIE = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.fine"), request.getParameter("DAT_FIE"), false);
    String strDES_SGZ = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"), request.getParameter("DES_SGZ"), true);
    String strDES_ATI_SGZ = c.checkString(ApplicationConfigurator.LanguageManager.getString("Attività"), request.getParameter("DES_ATI_SGZ"), false);

    if (c.isError) {
        String err = c.printErrors();
        out.print("<script>alert(\"" + err + "\");</script>");
        return;
    }
//------end check section--------------------------------
    
    try {
        if (request.getParameter("SBM_MODE") != null) {
            ReqMODE = request.getParameter("SBM_MODE");
            if (ReqMODE.equals("edt")) {
                bean = home.findByPrimaryKey(new Long(lCOD_SGZ));

                bean.setDES_SGZ(strDES_SGZ);
                bean.setDAT_SGZ(dtDAT_SGZ);
                bean.setNUM_SGZ(lNUM_SGZ);
                try {
                    bean.setVER_SGZ__TIT_SGZ(lVER_SGZ, strTIT_SGZ);
                } catch (Exception ex) {
                    out.print("<script>Alert.Error.showDublicate(); err=true;</script>");
                    return;
                }
                bean.setSTA_SGZ(strSTA_SGZ);
                bean.setURG_SGZ(strURG_SGZ);
                bean.setNOM_RIL_SGZ(strNOM_RIL_SGZ);
                bean.setCOD_DPD(lCOD_DPD);
                bean.setCOD_AZL(lCOD_AZL);
            } else {
                try {
                    bean = home.create(strDES_SGZ, dtDAT_SGZ, lNUM_SGZ, lVER_SGZ, strTIT_SGZ, strSTA_SGZ, strURG_SGZ, strNOM_RIL_SGZ, lCOD_DPD, lCOD_AZL);
                } catch (Exception ex) {
                    out.print("<script>Alert.Error.showDublicate(); err=true;</script>");
                }
                out.print("<script>isNew=true;</script>");
            }
            if (bean != null) {
                bean.setDES_ATI_SGZ(strDES_ATI_SGZ);
                bean.setSTA_FIE_SGZ(strSTA_FIE_SGZ);
                bean.setDAT_FIE(dtDAT_FIE);
                bean.setCOD_IMM(lCOD_IMM);
                bean.setCOD_LUO_FSC(lCOD_LUO_FSC);
            }
        }
    } catch (Exception ex) {
%>
<div id="divErr">
    <%=ex.getMessage()%>
</div>
<script>err=true;</script>
<%
    }
%>

<script>
    if (!err){  
        if(isNew) {Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=bean.getCOD_SGZ()%>");
        }
        else
        {Alert.Success.showSaved(); }
    }
    else
    {
        alert(divErr.innerText);
    }
</script>
