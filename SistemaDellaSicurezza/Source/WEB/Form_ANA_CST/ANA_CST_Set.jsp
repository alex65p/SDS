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
<%@page import="com.apconsulting.luna.ejb.AnagrConstatazioni.IAnagrConstatazioni"%>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!    String ReqMODE;	// parameter of request
%>
<script>
    var err=false;
    var isNew=false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
    IAnagrConstatazioni bean = null;

    if (request.getParameter("SBM_MODE") != null) {
        ReqMODE = request.getParameter("SBM_MODE");
        out.println(ReqMODE);

        Checker c = new Checker();

        //- checking for required fields
        long lCOD_FAT_RSO = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio"), request.getParameter("COD_FAT_RSO"), true);
        String strNOM = c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"), request.getParameter("NOM"), true);                                 //3
        String strDES = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"), request.getParameter("DES"), true);

        if (c.isError) {
            String err = c.printErrors();
            out.println("<script>alert(\"" + err + "\");</script>");
            return;
        }
        if (ReqMODE.equals("edt")) {
            Long lCOD_CST = new Long(c.checkLong("Constatazioni", request.getParameter("CST_ID"), true));
            IAnagrConstatazioniHome home = (IAnagrConstatazioniHome) PseudoContext.lookup("AnagrConstatazioniBean");
            try {
                bean = home.findByPrimaryKey(lCOD_CST);
                bean.setstrDES(strDES);
                bean.setstrNOM(strNOM);
                bean.setCOD_FAT_RSO(lCOD_FAT_RSO);
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                ex.printStackTrace();
                return;
            }
        }
        if (ReqMODE.equals("new")) {
            // creating of object
            IAnagrConstatazioniHome home = (IAnagrConstatazioniHome) PseudoContext.lookup("AnagrConstatazioniBean");
            try {
                bean = home.create(strDES, strNOM, lCOD_FAT_RSO);
%><script>isNew=true;</script><%
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                ex.printStackTrace();
                return;
            }
        }
    }
%>
<script>
    if(!err){
        if(isNew){
            Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=bean.getlCOD_CST()%>");

        }else{
            Alert.Success.showSaved();
        }
    }else{
        //Alert.Error.showCreated();
    }
</script>
