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
<%@ page import="com.apconsulting.luna.ejb.ArtLegge.*" %>
<%@ page import="com.apconsulting.luna.ejb.RischioCantiere.*" %>

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
            IArtLegge bean = null;
            IArtLeggeHome home = (IArtLeggeHome) PseudoContext.lookup("ArtLeggeBean");
            IRischioCantiere bean_rso = null;
            IRischioCantiereHome home_rso = (IRischioCantiereHome) PseudoContext.lookup("RischioCantiereBean");


            Checker c = new Checker();
            Long COD_RSO = new Long(c.checkLong("COD_RSO", request.getParameter("COD_RSO"), false));
            Long COD_ARL = new Long(c.checkLong("COD_ARL", request.getParameter("COD_ART"), false));
            if (c.isError) {
                String err = c.printErrors();
%><script>alert("<%=err%>");</script><%
                return;
            }
//------end check section--------------------------------
String r = request.getParameter("ID_PARENT");
                    home_rso = (IRischioCantiereHome) PseudoContext.lookup("RischioCantiereBean");
                    Long ID = new Long(request.getParameter("ID_PARENT"));
	            bean_rso = home_rso.findByPrimaryKey(new RischioPK(Security.getAzienda(), ID.longValue()));

            if (request.getParameter("SBM_MODE") != null) {
                ReqMODE = request.getParameter("SBM_MODE");
                if (ReqMODE.equals("edt")) {
                    try {
                        System.out.println(COD_ARL.longValue());
                        bean_rso.addART_LEG(COD_ARL.longValue());
%><script>isNew=true;</script><%
                            } catch (Exception ex) {
                                ex.printStackTrace();
                                 out.print("<script>Alert.Error.showDublicate();</script>");
                                return;
                            }
                        }
//=======================================================================================
                        if (ReqMODE.equals("new")) {
// new --------------------------
                            out.println("new");
                            // adding new binded document
                            try {
                                bean_rso.addART_LEG(COD_ARL.longValue());
%><script>isNew=true;</script><%
                            } catch (Exception ex) {
                                out.print("<script>Alert.Error.showDublicate();</script>");
                                return;
                            }
                        }

%>
<script>
    if(!err){
        // parent.ID ="<%=COD_ARL%>";
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
