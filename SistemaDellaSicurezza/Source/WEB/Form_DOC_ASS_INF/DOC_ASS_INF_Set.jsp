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

<%-- 
    Document   : DOC_ASS_INF_Set
    Created on : 7-mar-2011, 16.17.43
    Author     : Alessandro
--%>

<%
            /*
            <file>
            <versions>
            <version number="1.0" date="30/01/2004" author="Roman Chumachenko">
            <comments>
            <comment date="30/01/2004" author="Roman Chumachenko">
            <description>DOC_CSG_DTE_Set.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>
<%@ page import="com.apconsulting.luna.ejb.InfortuniIncidenti.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!    String ReqMODE;	// parameter of request
%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
    var err=false;
    var isNew=false;
</script>
<%
            IInfortuniIncidenti bean = null;
            IInfortuniIncidentiHome home = (IInfortuniIncidentiHome) PseudoContext.lookup("InfortuniIncidentiBean");

//-----start check section--------------------------------
            Checker c = new Checker();
//--- required fields ----
            Long COD_INO = new Long(c.checkLong("COD_INO ID", request.getParameter("COD_INO"), false));
            Long COD_DOC = new Long(c.checkLong(ApplicationConfigurator.LanguageManager.getString("Documento"), request.getParameter("COD_DOC"), true));
// String DOC_CSG_RCR=c.checkString("Tipo di documento",request.getParameter("DOC_CSG_RCR"), true);

            if (c.isError) {
                String err = c.printErrors();
%><script>alert("<%=err%>");</script><%
                        return;
                    }
//------end check section--------------------------------

                    // gettinf of object
                    bean = home.findByPrimaryKey(COD_INO);

                    if (request.getParameter("SBM_MODE") != null) {
                        ReqMODE = request.getParameter("SBM_MODE");
                        if (ReqMODE.equals("edt")) {
                            // editing --------------------
                            out.println("edt");
                            //getting of parameters and set the new object variables
                            //ditta_esterna.setDOC_CSG_RCR(COD_DOC.longValue(), DOC_CSG_RCR);
                        }
//=======================================================================================
                        if (ReqMODE.equals("new")) {
// new --------------------------
                            out.println("new");
                            // adding new binded document
                            try {
                                bean.addINO_DOC(COD_DOC.longValue());
%><script>isNew=true;</script><%
                        } catch (Exception ex) {
                            out.print("<script>Alert.Error.showDublicate();</script>");
                            return;
                        }
                    }
%>
<script>
    if(!err){
        // parent.ID ="<%=COD_DOC%>";
        parent.returnValue="OK";
        if(isNew){
            Alert.Success.showCreated();
            parent.ToolBar.Return.OnClick();
        }else{
            Alert.Success.showSaved();
            parent.ToolBar.Exit.setEnabled(false);
            parent.ToolBar.Return.setEnabled(true);
        }
    }else{
        parent.returnValue="ERROR";
    }
</script>
<%}%>

