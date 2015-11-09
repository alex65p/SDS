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
    < file>
    < versions>	
    < version number="1.0" date="27/02/2004" author="Artur Denysenko">		
    < comments>
    < comment date="27/02/2004" author="Artur Denysenko">
    < description>Realizazija EJB dlia objecta AttivitaSegnalazione
    < /comment>		
    < /comments> 
    < /version>
    < /versions>
    < /file> 
     */
%>
<%@ page import="com.apconsulting.luna.ejb.AttivitaSegnalazione.*" %>
<%@ page import="java.sql.Date" %>
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
    IAttivitaSegnalazione bean = null;
//-----start check section--------------------------------
    Checker c = new Checker();

    long lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"), request.getParameter("COD_AZL"), true);
    long lCOD_SGZ = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Segnalazione"), request.getParameter("COD_SGZ"), true);
    long lCOD_ATI_SGZ = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Attività.segnalazione"), request.getParameter("COD_ATI_SGZ"), true);
    long lCOD_DPD = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Lavoratore"), request.getParameter("COD_DPD"), true);
    String strDES_ATI_SGZ = c.checkString(ApplicationConfigurator.LanguageManager.getString(
            ApplicationConfigurator.isModuleEnabled(MODULES.SEG_REG_MON) ? "Azione.pianificata" : "Descrizione.attività"), request.getParameter("DES_ATI_SGZ"), true);
    float fRIS = c.checkFloat(ApplicationConfigurator.LanguageManager.getString("Risorse"), request.getParameter("RIS"), false);
    Date dtDAT_ATT = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.attuazione"), request.getParameter("DAT_ATT"), false);
    String strVER_DA = c.checkString(ApplicationConfigurator.LanguageManager.getString("Verificato.da"), request.getParameter("VER_DA"), false);
    Date dtDAT_SCA = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.scadenza"), request.getParameter("DAT_SCA"), true);
    Date dtDAT_VER = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.verifica"), request.getParameter("DAT_VER"), false);

    if (c.isError) {
        String err = c.printErrors();
        out.print("<script>err=true;alert(\"" + err + "\");</script>");
        return;
    }

    IAttivitaSegnalazioneHome home = (IAttivitaSegnalazioneHome) PseudoContext.lookup("AttivitaSegnalazioneBean");

//------end check section--------------------------------
    try {
        if (request.getParameter("SBM_MODE") != null) {
            ReqMODE = request.getParameter("SBM_MODE");
            if (ReqMODE.equals("edt")) {
                bean = home.findByPrimaryKey(new Long(lCOD_ATI_SGZ));
                try {
                    bean.setDES_ATI_SGZ(strDES_ATI_SGZ);
                    bean.setDAT_SCA(dtDAT_SCA);
                } catch (Exception ex) {
                    out.print("<script>Alert.Error.showDublicate(); err=true;</script>");
                    return;
                }
                bean.setCOD_SGZ(lCOD_SGZ);
                bean.setCOD_DPD(lCOD_DPD);
                bean.setCOD_AZL(lCOD_AZL);
            } else {
                try {
                    bean = home.create(strDES_ATI_SGZ, dtDAT_SCA, lCOD_SGZ, lCOD_DPD, lCOD_AZL);
                } catch (Exception ex) {
                    out.print("<script>Alert.Error.showDublicate(); err=true;</script>");
                }
                out.print("<script>isNew=true;</script>");
            }
            if (bean != null) {
                bean.setDAT_VER(dtDAT_VER);
                bean.setRIS(fRIS);
                bean.setDAT_ATT(dtDAT_ATT);
                bean.setVER_DA(strVER_DA);
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
            parent.ToolBar.OnNew("ID=<%=bean.getCOD_ATI_SGZ()%>");
        }
        else
        {Alert.Success.showSaved(); }
    }
    else
    {
        alert(divErr.innerText);
    }
</script>
