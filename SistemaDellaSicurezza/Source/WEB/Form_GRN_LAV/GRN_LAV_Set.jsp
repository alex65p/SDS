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
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.GiorniLavorati.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%!
        String ReqMODE;	// parameter of request
%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
    var err=false;
    var isNew=false;
</script>
<%
            IGiorniLavorati bean = null;
            IGiorniLavoratiHome home = (IGiorniLavoratiHome) PseudoContext.lookup("GiorniLavoratiBean");
//-----start check section--------------------------------
            Checker c = new Checker();
//---required fields
            Long lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"), request.getParameter("COD_AZL"), false);
            Long lANNO = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Anno"), request.getParameter("ANNO"), true);
            //Long lGRN_LAV = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Giorni.Lavorati"), request.getParameter("GRN_LAV"), true);
            long lGRN_LAV = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Giorni.Lavorati"), request.getParameter("GRN_LAV"), true);
            Long lANNOID = c.checkLong("", request.getParameter("ANNOID"), false);

            if (c.isError) {
                String err = c.printErrors();
%><script>alert("<%=err%>");</script><%
                return;
            }
//------end check section--------------------------------
            if (request.getParameter("SBM_MODE") != null) {
                try {
                    ReqMODE = request.getParameter("SBM_MODE");
                    if (ReqMODE.equals("edt")) {
                        bean = home.findByPrimaryKey(new GiorniLavoratiPK(lCOD_AZL, lANNO));
                        try {
                            bean.setANNOID(lANNOID);
                            bean.setANNO(lANNO);
                            bean.setANNOID(lANNO);
                            bean.setGRN_LAV(lGRN_LAV);
                            //out.print("Saving OK <br>");
                        } catch (Exception ex) {
                            ex.printStackTrace(System.err);
                            out.print("<script>Alert.Error.showDublicate();</script>");
                            return;
                        }
                    }
                    if (ReqMODE.equals("new")) {
                        // new azienda--------------------------
                        // creating of object
                        try {
                            bean = home.create(lANNO, lGRN_LAV, lCOD_AZL);
                            lANNO = bean.getANNO();
%><script>isNew=true;</script><%
                        } catch (Exception ex) {
                            out.println("<script>Alert.Error.showDublicate();</script>");
                            return;
                        }
                    }

                } catch (Exception ex) {
                    ex.printStackTrace();
                    out.print("Error:" + ex.toString());
                }
                if (bean != null) {
                }
            }
%>
<script>
    if (!err){
        if(isNew){
            Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=lANNO%>");
        }else
            Alert.Success.showSaved();
        parent.ToolBar.OnNew("ID=<%=lANNO%>");
    }else{
        Alert.Error.showDublicate();
    }
</script>

