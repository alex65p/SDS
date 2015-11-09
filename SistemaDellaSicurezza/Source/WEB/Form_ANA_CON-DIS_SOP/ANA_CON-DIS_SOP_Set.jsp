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

<%@page import="com.apconsulting.luna.ejb.AnagrConstatazioni.IAnagrConstatazioniHome"%>
<%@page import="com.apconsulting.luna.ejb.AnagrConstatazioni.AnagrConstatazioniBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Sopraluogo.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp"%>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!    String ReqMODE;	// parameter of request 
%>	

<%
//-----start check section--------------------------------
    ReqMODE = request.getParameter("SBM_MODE");
    Checker c = new Checker();

    // Campi obbligatori
    long lCOD_SOP = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Sopralluogo"), request.getParameter("COD_SOP"), true);
    long lCOD_CST = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Constatazioni"), request.getParameter("lista_constatazioni"), ReqMODE.equals("new")?true:false);

    // Campi opzionali
    String sCOD_SOP_CST = c.checkString("Sopralluogo-Constatazione", request.getParameter("ID_PARENT"), false);
    String sDIS_GEN = c.checkString(ApplicationConfigurator.LanguageManager.getString("Disposizione.generata"), request.getParameter("text_gendis"), false);
    long lCON_DIS_COD_DOC = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Attivita"), request.getParameter("CON_DIS_COD_DOC"), false);
    long lCON_DIS_COD_DTE = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Ditta"), request.getParameter("CON_DIS_COD_DTE"), (lCON_DIS_COD_DOC>0));
    String sCON_DIS_DES_LIB = c.checkString(ApplicationConfigurator.LanguageManager.getString("Campo.a.testo.libero"), request.getParameter("CON_DIS_DES_LIB"), false);
            
    Long lCOD_SOP_CST = null;
    if ((!sCOD_SOP_CST.equals("null")) && (!sCOD_SOP_CST.equals("0"))) {
        lCOD_SOP_CST = new Long(sCOD_SOP_CST);
    }

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
//------end check section--------------------------------
    if (ReqMODE != null) {
        ISopraluogoHome home = (ISopraluogoHome) PseudoContext.lookup("SopraluogoBean");
        
        long lCOD_AZL = Security.getAzienda();
        try {
            if (ReqMODE.equals("new")) {
                // INSERISCO UNA CONSTATAZIONE
                    out.println("<script>isNew=true;</script>");
                    lCOD_SOP_CST = home.addSOP_CST(
                            null, lCOD_SOP, lCOD_CST, 
                            lCON_DIS_COD_DTE, lCON_DIS_COD_DOC, lCOD_AZL,
                            sCON_DIS_DES_LIB, sDIS_GEN);
            } else if (ReqMODE.equals("edt")) {
                // MODIFICO UNA CONSTATAZIONE
                home.addSOP_CST(
                        lCOD_SOP_CST, lCOD_SOP, Long.parseLong(request.getParameter("COD_CST")), 
                        lCON_DIS_COD_DTE, lCON_DIS_COD_DOC, lCOD_AZL, 
                        sCON_DIS_DES_LIB, sDIS_GEN);
            }
        } catch (Exception ex) {
            out.println("<script>Alert.Error.showDublicate();</script>");
            return;
        }            
    }
%>
<script>
    if(!err){	
        parent.returnValue="OK";
        if(isNew){
            Alert.Success.showCreated();
        }else{
            Alert.Success.showSaved();
        }
        parent.ToolBar.OnNew("ID=<%=lCOD_SOP_CST%>");        
    }else{
        parent.returnValue="ERROR";	
    }	
</script>
