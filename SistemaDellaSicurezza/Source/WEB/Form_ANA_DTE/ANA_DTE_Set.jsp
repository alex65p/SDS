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
            <version number="1.0" date="26/12/2004" author="Roman Chumachenko">
            <comments>
            <comment date="26/12/2004" author="Roman Chumachenko">
            <description>Shablon formi ANA_DTE_Set.jsp</description>
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
<%@ page import="java.util.*"%>
<%@ page import="com.apconsulting.luna.ejb.DittaEsterna.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
    String ReqMODE;	// parameter of request 
%>

<%
            IDittaEsterna bean = null;
//-----start check section--------------------------------
            Checker c = new Checker();

            long lCOD_DTE = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dati.fornitore.personale/servizi"), request.getParameter("COD_DTE"), false);
            long lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dati.azienda/ente"), request.getParameter("COD_AZL"), true);
            String strRAG_SCL_DTE = c.checkString(ApplicationConfigurator.LanguageManager.getString("Ragione.sociale"), request.getParameter("RAG_SCL_DTE"), true);
            String strCAG_DTE = c.checkString(ApplicationConfigurator.LanguageManager.getString("Categoria"), request.getParameter("CAG_DTE"), true);
            String strIDZ_DTE = c.checkString(ApplicationConfigurator.LanguageManager.getString("Indirizzo"), request.getParameter("IDZ_DTE"), true);
            String strNUM_CIC_DTE = c.checkString(ApplicationConfigurator.LanguageManager.getString("Numero.civico"), request.getParameter("NUM_CIC_DTE"), false);
            String strCIT_DTE = c.checkString(ApplicationConfigurator.LanguageManager.getString("Città"), request.getParameter("CIT_DTE"), true);
            String strPRV_DTE = c.checkString(ApplicationConfigurator.LanguageManager.getString("Provincia"), request.getParameter("PRV_DTE"), false);
            String strCAP_DTE = c.checkString(ApplicationConfigurator.LanguageManager.getString("C.a.p."), request.getParameter("CAP_DTE"), false);

            String strNOM_RSP_DTE = c.checkString(ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro"), request.getParameter("NOM_RSP_DTE"), true);
            String strNOM_RSP_SPP_DTE = c.checkString(ApplicationConfigurator.LanguageManager.getString("Responsabile.S.P.P."), request.getParameter("NOM_RSP_SPP_DTE"), true);

            String strQLF_RSP_DTE = c.checkString(ApplicationConfigurator.LanguageManager.getString("Qualifica.resp.S.P.P."), request.getParameter("QLF_RSP_DTE"), true);

// no this field in source ?
            String strIDZ_PSA_ELT_RSP = c.checkString("IDZ_PSA_ELT_RSP", request.getParameter("IDZ_PSA_ELT_RSP"), false);

            java.sql.Date dtDAT_INZ_LAV = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.inizio.lavori"), request.getParameter("DAT_INZ_LAV"), false);
            java.sql.Date dtDAT_FIE_LAV = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.fine.lavori"), request.getParameter("DAT_FIE_LAV"), false);
            long lCOD_STA = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Stato"), request.getParameter("COD_STA"), true);
// -- getting of current date
            java.util.Date cdt = new java.util.Date();
            java.sql.Date dtDAT_CAT_DTE = new java.sql.Date(cdt.getYear(), cdt.getMonth(), cdt.getDate());

            if (c.isError) {
                String err = c.printErrors();
%><script>alert("<%=err%>");</script><%
                return;
            }
%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
    var err=false;
    var isNew=false;  
    </script>
<%
            IDittaEsternaHome home = (IDittaEsternaHome) PseudoContext.lookup("DittaEsternaBean");
//------end check section--------------------------------

            if (request.getParameter("SBM_MODE") != null) {
                ReqMODE = request.getParameter("SBM_MODE");
                if (ReqMODE.equals("edt")) {
                    bean = home.findByPrimaryKey(new Long(lCOD_DTE));
                    try {
                        bean.setCOD_AZL__RAG_SCL_DTE(lCOD_AZL, strRAG_SCL_DTE);
                    } catch (Exception ex) {
                        out.print("<script>Alert.Error.showDublicate();</script>");
                        return;
                    }
                    bean.setCAG_DTE(strCAG_DTE);
                    bean.setIDZ_DTE(strIDZ_DTE);
                    bean.setCIT_DTE(strCIT_DTE);
                    bean.setQLF_RSP_DTE(strQLF_RSP_DTE);
                    bean.setNOM_RSP_DTE(strNOM_RSP_DTE);
                    bean.setNOM_RSP_SPP_DTE(strNOM_RSP_SPP_DTE);
                    bean.setCOD_STA(lCOD_STA);
                    bean.setDAT_CAT_DTE(dtDAT_CAT_DTE);
                } else {
                    try {
%><script>isNew=true;</script><%
                        bean = home.create(lCOD_AZL, strRAG_SCL_DTE, strCAG_DTE, strIDZ_DTE, strCIT_DTE, strQLF_RSP_DTE, strNOM_RSP_DTE, strNOM_RSP_SPP_DTE, dtDAT_CAT_DTE, lCOD_STA);

                    } catch (Exception ex) {
                        out.print("<script>Alert.Error.showDublicate();</script>");
                        return;
                    }
                }
                if (bean != null) {
                    bean.setNUM_CIC_DTE(strNUM_CIC_DTE);
                    bean.setPRV_DTE(strPRV_DTE);
                    bean.setCAP_DTE(strCAP_DTE);
                    bean.setIDZ_PSA_ELT_RSP(strIDZ_PSA_ELT_RSP);
                    bean.setDAT_INZ_LAV(dtDAT_INZ_LAV);
                    bean.setDAT_FIE_LAV(dtDAT_FIE_LAV);
                }
            }
            out.print("Saving ok");
%>
<script>
    if(parent.dialogArguments){
        if(!err){	
            //da=parent.dialogArguments;
            //da.ID = "<%//= Tel.getCOD_NUM_TEL_DTE() %>";
            //da.COD_DTE = "<%//= Tel.getCOD_DTE() %>";
            parent.returnValue="OK";
            if(isNew){
                Alert.Success.showCreated();
                parent.ToolBar.Return.OnClick();
            }else{
            Alert.Success.showSaved();
        }
    }else{
    parent.returnValue="ERROR";	
}	
}else{
//------------------------------------------------
if(!err){	
    parent.returnValue="OK";
    if(isNew){
        Alert.Success.showCreated();
        //parent.ToolBar.Return.OnClick();
        parent.ToolBar.OnNew("ID=<%=bean.getCOD_DTE()%>");
        }else{
        Alert.Success.showSaved();
    }
}else{
parent.returnValue="ERROR";	
}	
}//---------------------------------------------------	
</script>
