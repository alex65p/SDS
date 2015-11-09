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
    Checker c = new Checker();

    long lCOD_SOP = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Sopralluogo"), request.getParameter("COD_SOP"), false);
    Long lCOD_PRO = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Procedimento"), request.getParameter("procedimento"), true);
    Long lCOD_CAN = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Cantiere"), request.getParameter("cantiere"), true);
    Long lCOD_OPE = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Opera"), request.getParameter("opera"), false);
    String sNUM_SOP = c.checkString(ApplicationConfigurator.LanguageManager.getString("Numero.sopralluogo"), request.getParameter("NUM_SOP"), true);
    String sDAT_SOP = c.checkString(ApplicationConfigurator.LanguageManager.getString("Data"), request.getParameter("DAT_SOP"), true);

    if (c.isError) {
        String err = c.printErrors();
        out.println("<script>alert(\"" + err + "\");</script>");
        return;
    }

    String sORA_INI = request.getParameter("ORA_INI");
    String sMIN_INI = request.getParameter("MIN_INI");
    String sORA_FIN = request.getParameter("ORA_FIN");
    String sMIN_FIN = request.getParameter("MIN_FIN");

    Long lORA_INI = null;
    if (sORA_INI != "") {
        lORA_INI = Long.parseLong(sORA_INI);
        if ((lORA_INI > 24) || (lORA_INI < 0)) {
            out.println("<script>alert(\"Il formato dell'ora di inizio non è corretto.\");</script>");
            return;
        }
    }
    Long lMIN_INI = null;
    if (sMIN_INI != "") {
        lMIN_INI = Long.parseLong(sMIN_INI);
        if ((lMIN_INI > 59) || (lMIN_INI < 0)) {
            out.println("<script>alert(\"Il formato dei minuti dell'ora di inizio non è corretto.\");</script>");
            return;
        }
    }
    Long lORA_FIN = null;
    if (sORA_FIN != "") {
        lORA_FIN = Long.parseLong(sORA_FIN);
        if ((lORA_FIN > 24) || (lORA_FIN < 0)) {
            out.println("<script>alert(\"Il formato dell'ora di fine non è corretto.\");</script>");
            return;
        }
    }
    Long lMIN_FIN = null;
    if (sMIN_FIN != "") {
        lMIN_FIN = Long.parseLong(sMIN_FIN);
        if ((lMIN_FIN > 59) || (lMIN_FIN < 0)) {
            out.println("<script>alert(\"Il formato dei minuti dell'ora di fine non è corretto.\");</script>");
            return;
        }
    }
    java.sql.Date dDAT_SOP = null;
    if (!sDAT_SOP.equals("")) {
        java.util.Date d1 = new SimpleDateFormat("dd/MM/yyyy").parse(sDAT_SOP);
        java.sql.Date d2 = new java.sql.Date(d1.getTime());
        java.sql.Date d3 = java.sql.Date.valueOf(d2.toString());
        dDAT_SOP = java.sql.Date.valueOf(d2.toString());;
    }

    java.sql.Time tORA_INI = null;
    String sORA_SOP_INI = "";
    if (!sORA_INI.equals("") && !sMIN_INI.equals("")) {
        sORA_SOP_INI = sORA_INI + ":" + sMIN_INI + ":00";
        tORA_INI = java.sql.Time.valueOf(sORA_SOP_INI);
    }

    java.sql.Time tORA_FIN = null;
    String sORA_SOP_FIN = "";
    if (!sORA_FIN.equals("") && !sMIN_FIN.equals("")) {
        sORA_SOP_FIN = sORA_FIN + ":" + sMIN_FIN + ":00";
        tORA_FIN = java.sql.Time.valueOf(sORA_SOP_FIN);
    }

    if ((tORA_INI != null) && (tORA_FIN != null)) {
        if (tORA_INI.compareTo(tORA_FIN) > 0) {
            out.println("<script>alert(\"L'ora di fine deve essere successiva all'ora di inizio.\");</script>");
            return;
        }
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
    ISopraluogo sopraluogo = null;
    if (request.getParameter("SBM_MODE") != null) {
        ReqMODE = request.getParameter("SBM_MODE");
        if (ReqMODE.equals("edt")) {
            try {
                // editing of azienda--------------------
                // gettinf of object 
                ISopraluogoHome home = (ISopraluogoHome) PseudoContext.lookup("SopraluogoBean");

                Boolean bol = null;
                Integer irc = home.chkPOC_SOP(lCOD_PRO, lCOD_OPE, lCOD_CAN);
                if (irc == 1) {
                    bol = home.chkNUM_SOP(sNUM_SOP, dDAT_SOP);
                    if (bol == false) {
                        out.println("<script>alert(\"Data non congruente con numero del sopralluogo.\");</script>");
                        return;
                    }
                } else {
                    out.println("<script>alert(\"La relazione tra Procedimento - Cantiere - Opera non è corretta.\");</script>");
                    return;
                }
                sopraluogo = home.findByPrimaryKey(lCOD_SOP);

                sopraluogo.setNUM_SOP(sNUM_SOP);
                sopraluogo.setDAT_SOP(dDAT_SOP);

                sopraluogo.setORA_INI(tORA_INI);
                sopraluogo.setORA_FIN(tORA_FIN);

                sopraluogo.setCOD_PRO_CAN_OPE(lCOD_PRO,lCOD_CAN,lCOD_OPE);            
            } catch (Exception ex) {
                ex.printStackTrace();
                out.println("<script>Alert.Error.showDublicate();</script>");
                return;
            }
        }
        if (ReqMODE.equals("new")) {
            if (Security.isUser()) {
                return;
            }
            try {
%><script>isNew=true;</script><%
                ISopraluogoHome home = (ISopraluogoHome) PseudoContext.lookup("SopraluogoBean");
                Long lCOD_AZL = Security.getAzienda();

                Boolean bol = null;
                Integer irc = home.chkPOC_SOP(lCOD_PRO, lCOD_OPE, lCOD_CAN);
                if (irc == 1) {
                    bol = home.chkNUM_SOP(sNUM_SOP, dDAT_SOP);
                    if (bol == true) {
                        sopraluogo = home.create(lCOD_AZL, lCOD_PRO, lCOD_OPE, lCOD_CAN, dDAT_SOP, sNUM_SOP, tORA_INI, tORA_FIN);
                    } else {
                        out.println("<script>alert(\"Data non congruente con numero del sopralluogo.\");</script>");
                        return;
                    }
                } else {
                    out.println("<script>alert(\"La relazione tra Procedimento - Cantiere - Opera non è corretta.\");</script>");
                    return;
                }
            } catch (Exception ex) {
                ex.printStackTrace();
                out.println("<script>Alert.Error.showDublicate();</script>");
                return;
            }
        }
    }
    out.print("Saving ok");
%>
<script>
    if(parent.dialogArguments){
        if(!err){	
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
                parent.ToolBar.OnNew("ID=<%=sopraluogo.getCOD_SOP()%>");
            }else{
                Alert.Success.showSaved();
            }
        }else{
            parent.returnValue="ERROR";	
        }	
    }//---------------------------------------------------	
</script>
