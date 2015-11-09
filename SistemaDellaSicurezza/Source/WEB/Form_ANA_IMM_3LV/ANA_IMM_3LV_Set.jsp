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
            <version number="1.0" date="07/04/2011" author="Dario Massaroni">
            <comments>
            <comment date="07/04/2011" author="Dario Massaroni">
            <description>ANA_IMM_3LV_Set.jsp</description>
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */
%>
<%@ page import="com.apconsulting.luna.ejb.Immobili3lv.*" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<script type="text/javascript">
    var err=false;
    var isNew = false;
</script>
<script type="text/javascript" src="../_scripts/Alert.js"></script>
<%
            long lCOD_IMM = 0;
            IImmobili3lvHome home = (IImmobili3lvHome) PseudoContext.lookup("Immobili3lvBean");
            IImmobili3lv bean = null;

            if (request.getParameter("SBM_MODE") != null) {
                Checker c = new Checker();
                String ReqMODE = request.getParameter("SBM_MODE");

                // Campi obbligatori
                long lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"), request.getParameter("COD_AZL"), true);
                lCOD_IMM = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Immobile"), request.getParameter("COD_IMM"), true);
                long lCOD_SIT_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Sito.aziendale"), request.getParameter("COD_SIT_AZL"), true);
                String strNOM_IMM = c.checkString(ApplicationConfigurator.LanguageManager.getString("Immobile"), request.getParameter("strNOM_IMM"), true);

                // Campi opzionali
                String strDES_IMM = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"), request.getParameter("strDES_IMM"), false);
                String strIND_IMM = c.checkString(ApplicationConfigurator.LanguageManager.getString("Indirizzo"), request.getParameter("strIND_IMM"), false);
                String strNUM_CIV_IMM = c.checkString(ApplicationConfigurator.LanguageManager.getString("Numero.civico"), request.getParameter("strNUM_CIV_IMM"), false);
                String strCIT_IMM = c.checkString(ApplicationConfigurator.LanguageManager.getString("Città"), request.getParameter("strCIT_IMM"), false);
                String strPRO_IMM = c.checkString(ApplicationConfigurator.LanguageManager.getString("Provincia"), request.getParameter("strPRO_IMM"), false);
                String strCAP_IMM = c.checkString(ApplicationConfigurator.LanguageManager.getString("C.a.p."), request.getParameter("strCAP_IMM"), false);

                if (c.isError) {
                    String err = c.printErrors();
                    out.println("<script>alert(\"" + err + "\");</script>");
                    return;
                }

                try {
                    if (ReqMODE.equals("new")) {
                        // creating of object
                        bean = home.create(lCOD_AZL, lCOD_SIT_AZL, strNOM_IMM);
                        lCOD_IMM = bean.getCOD_IMM();
                        out.print("<script>isNew=true;</script>");
                    } else {
                        bean = home.findByPrimaryKey(lCOD_IMM);
                    }
                    bean.setCOD_SIT_AZL(lCOD_SIT_AZL);
                    bean.setNOM_IMM(strNOM_IMM);
                    bean.setDES_IMM(strDES_IMM);
                    bean.setIND_IMM(strIND_IMM);
                    bean.setNUM_CIV_IMM(strNUM_CIV_IMM);
                    bean.setCIT_IMM(strCIT_IMM);
                    bean.setPRO_IMM(strPRO_IMM);
                    bean.setCAP_IMM(strCAP_IMM);
                } catch (Exception ex) {
                    ex.printStackTrace();
                    out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                    return;
                }

            }
%>
<script type="text/javascript">
    if (!err){
        if(isNew){
            parent.ToolBar.OnNew("ID=<%=lCOD_IMM%>");
            Alert.Success.showCreated();
        }
        else
            Alert.Success.showSaved();
    }
</script>
