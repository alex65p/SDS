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
            <version number="1.0" date="19/01/2004" author="Alexey Kolesnik">
            <comments>
            <comment date="19/01/2004" author="Alexey Kolesnik">
            <description>Shablon formi ANA_LUO_FSC_Set.jsp</description>
            </comment>
            <comment date="22/01/2004" author="Mike Kondratyuk">
            <description>Dobavlen kod dlya tabika s formy ANA_SIT_AZL_Form.jsp</description>
            </comment>
            <comment date="31/01/2004" author="Alexey Kolesnik">
            <description> Added new toolbar </description>
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */
%>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/ExtendedMode.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<script type="text/javascript">
    var err=false;
    var isNew = false;
</script>
<script  type="text/javascript" src="../_scripts/Alert.js"></script>
<%
            boolean LUOGHI_FISICI_3_LIVELLI =
                ApplicationConfigurator.isModuleEnabled(MODULES.LUOGHI_FISICI_3_LIVELLI);

            long lCOD_LUO_FSC = 0;
            IAnagrLuoghiFisici AnagrLuoghiFisici = null;
            if (request.getParameter("SBM_MODE") != null) {
                Checker c = new Checker();
                String ReqMODE = request.getParameter("SBM_MODE");
                lCOD_LUO_FSC = c.checkLong("LUO ID", request.getParameter("COD_LUO_FSC"), true);
                long lCOD_SIT_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Sito.aziendale"), request.getParameter("COD_SIT_AZL"), !LUOGHI_FISICI_3_LIVELLI);
                long lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"), request.getParameter("COD_AZL"), true);//2 - Nullable
                long lCOD_IMM_3LV = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Immobile"), request.getParameter("COD_IMM_3LV"), LUOGHI_FISICI_3_LIVELLI);//6 - Nullable
                if (Formatter.format(lCOD_IMM_3LV) == "") {
                    lCOD_IMM_3LV = 0;
                }
                String strNOM_LUO_FSC = c.checkString(ApplicationConfigurator.LanguageManager.getString("Luogo.fisico"), request.getParameter("strNOM_LUO_FSC"), true);//4
                long lCOD_IMO = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Immobile"), request.getParameter("COD_IMO"), false);//6 - Nullable
                if (Formatter.format(lCOD_IMO) == "") {
                    lCOD_IMO = 0;
                }
                long lCOD_PNO = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Piano"), request.getParameter("COD_PNO"), false);//7 - Nullable
                if (Formatter.format(lCOD_PNO) == "") {
                    lCOD_PNO = 0;
                }
                long lCOD_ALA = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Ala"), request.getParameter("COD_ALA"), false);//5 - Nullable
                if (Formatter.format(lCOD_ALA) == "") {
                    lCOD_ALA = 0;
                }
                String strDES_LUO_FSC = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"), request.getParameter("strDES_LUO_FSC"), false);//8 - Nullable
                String strQLF_RSP_LUO_FSC = c.checkString(ApplicationConfigurator.LanguageManager.getString("Qualifica"), request.getParameter("strQLF_RSP_LUO_FSC"), false);//9 - Nullable
                String strNOM_RSP_LUO_FSC = c.checkString(ApplicationConfigurator.LanguageManager.getString("Preposto"), request.getParameter("strNOM_RSP_LUO_FSC"), false);//10 - Nullable
                String strIDZ_PSA_ELT_RSP_LUO_FSC = c.checkEmail(ApplicationConfigurator.LanguageManager.getString("E-mail"), request.getParameter("strIDZ_PSA_ELT_RSP_LUO_FSC"), false);//11 - Nullable

                //flag impianto
                String strFLG_IMP = c.checkString(ApplicationConfigurator.LanguageManager.getString("Impianto"), request.getParameter("FLG_IMP"), false);
                strFLG_IMP = strFLG_IMP.equals("") ? "N" : "S";
                //fine

                out.println(lCOD_SIT_AZL);
                if (c.isError) {
                    String err = c.printErrors();
                    out.println("<script>alert(\"" + err + "\");</script>");
                    return;
                }

                ArrayList alAziende =
                        ApplicationConfigurator.isModuleEnabled(MODULES.PROP_LUO_FIS)
                        ? ExtendedMode.getAziende(c) : null;
                
                IAnagrLuoghiFisiciHome home = (IAnagrLuoghiFisiciHome) PseudoContext.lookup("AnagrLuoghiFisiciBean");
                if (ReqMODE.equals("new")) {
                    try {
                        out.println("new");
                        //try{
                        AnagrLuoghiFisici = home.createExtended(lCOD_SIT_AZL, lCOD_AZL, strNOM_LUO_FSC,
                                lCOD_ALA, lCOD_IMO, lCOD_IMM_3LV, lCOD_PNO, strDES_LUO_FSC,
                                strQLF_RSP_LUO_FSC, strNOM_RSP_LUO_FSC,
                                strIDZ_PSA_ELT_RSP_LUO_FSC, alAziende); //EXTENDED);
                                lCOD_LUO_FSC=AnagrLuoghiFisici.getCOD_LUO_FSC();
                        out.print("<script>isNew=true;</script>");
                    } catch (Exception ex) {
                        ex.printStackTrace();
                        out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                        return;
                    }
                } else if (ReqMODE.equals("edt")) {
                    // editing of AnagrLuoghiFisici--------------------
                    // gettinf of object
                    AnagrLuoghiFisici = home.findByPrimaryKey(lCOD_LUO_FSC);
                    try {
                        AnagrLuoghiFisici.store(lCOD_SIT_AZL,
                                lCOD_AZL,
                                strNOM_LUO_FSC,
                                lCOD_IMO,
                                lCOD_IMM_3LV,
                                lCOD_PNO,
                                lCOD_ALA,
                                strDES_LUO_FSC,
                                strNOM_RSP_LUO_FSC,
                                strQLF_RSP_LUO_FSC,
                                strIDZ_PSA_ELT_RSP_LUO_FSC,
                                strFLG_IMP,
                                alAziende);
                    } catch (Exception ex) {
                        ex.printStackTrace();
                        out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                        return;
                    }
                }
            }
%>
<script type="text/javascript">
if (!err){
	if(isNew){
   		 parent.ToolBar.OnNew("ID=<%=lCOD_LUO_FSC%>");
		 Alert.Success.showCreated();
	}
	else
		 Alert.Success.showSaved();
}
</script>
