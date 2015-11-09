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
            <version number="1.0" date="24/02/2004" author="Roman Chumachenko">
            <comments>
            <comment date="24/02/2004" author="Roman Chumachenko">
            <description>ANA_PSC_Tabs.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.PSC.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="ANA_PSC_Util.jsp"%>

<script>
    err = false;
</script>
<script type="text/javascript" src="../_scripts/Alert.js"></script>
<div id="dContent">
    <%
                String nameTab = new String();
                String err = new String();
                String str = new String();
                boolean isError = false;
                java.util.Collection col;
                java.util.Iterator it;
    //---------------------------------------------------------------------------------------------------
                IPSC bean = null;
                IPSCHome home = (IPSCHome) PseudoContext.lookup("PSCBean");
    //---------------------------------------------------------------------------------------------------
                Long ID = new Long(request.getParameter("ID_PARENT"));
                if (request.getParameter("ID_PARENT") != null) {

                    try {
                        bean = home.findByPrimaryKey(ID);
                    } catch (Exception ex) {
                        err = "Cannot find record with ID=" + ID.toString();
                        err += "\\n" + ex.getMessage();
                        out.print("<script>alert(\"" + err + "\");</script>");
                        ex.printStackTrace();
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
                    // if (request.getParameter("TAB_NAME").equals("tab1")) {
                    if (!isError && nameTab.equals("tab1")) {
                        out.print(BuildSezioneGeneraleTab(bean));
                    } else
                    if (!isError && nameTab.equals("tab2")) {
                        out.print(BuildSchedeSicurezzaTab(bean));
                    } else
                    if (!isError && nameTab.equals("tab3")) {
                        out.print(BuildSezioneParticolareTab(bean));
                    } else
                    if (!isError && nameTab.equals("tab4")) {
                        out.print(BuildFascicoloTab(bean));
                    }
                    //----------------------------------------
                } catch (Exception ex) {
                    err = "Impossible rebuild tab content";
                    err += "\\n" + ex.getMessage();
                    out.print("<script>alert(\"" + err + "\");</script>");
                    ex.printStackTrace();
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
