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
    Document   : ANA_CON_Tabs
    Created on : 23-mar-2011, 14.21.04
    Author     : Alessandro
--%>

<%
            /*
            <file>
            <versions>
            <version number="1.0" date="24/02/2004" author="Roman Chumachenko">
            <comments>
            <comment date="24/02/2004" author="Roman Chumachenko">
            <description>ANA_CON_Tabs.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.DittaEsterna.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>


<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="ANA_CON_Util.jsp"%>

<script>
    err = false;
</script>
<div id="dContent">
    <%
                String nameTab = new String();
                String err = new String();
                String str = new String();
                boolean isError = false;
                java.util.Collection col;
                java.util.Iterator it;
    //---------------------------------------------------------------------------------------------------
    //IDittaEsterna bean=null;
    //IDittaEsternaHome home=(IDittaEsternaHome)PseudoContext.lookup("DittaEsternaBean");
    //---------------------------------------------------------------------------------------------------
                if (request.getParameter("ID_PARENT") != null) {
                    //Long ID = new Long(request.getParameter("ID_PARENT"));
                    try {
                        //	bean=home.findByPrimaryKey(ID);
                    } catch (Exception ex) {
                        err = "Cannot find record with ID=" + ID.toString();
                        err += "\\n" + ex.getMessage();
                        out.print("<script>alert(\"" + err + "\");</script>");
                        return;
                    }
                }
    //-----------------------------------------------------------------------------------------------
                if (request.getParameter("TAB_NAME") != null) {
                    nameTab = request.getParameter("TAB_NAME");
                } else {
                    err = "Parameter TAB_NAME not defined";
                    out.print("<script>err = true</script>");
                }
                //-----------Tabs reloaddefinitions----------
                try {
                    //--------------------------------------
                    if (!isError && nameTab.equals("tab1")) {
                        out.print(BuildRischiRilevatiTab());
                    }
                    //----------------------------------------
                } catch (Exception ex) {
                    err = "Impossible rebuild tab content";
                    err += "\\n" + ex.getMessage();
                    out.print("<script>alert(\"" + err + "\");</script>");
                    return;
                }
    %>
</div>
<script>
    if (!err){
        parent.tabbar.ReloadTabTable(document);
    }
</script>
</body>
</html>
