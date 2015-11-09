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
            <version number="1.0" date="14/01/2004" author="Alexander Kyba">
            <comments>
            <comment date="14/01/2004" author="Alexander Kyba">
            <description>Shablon formi NUM_TEL_Delete.jsp</description>
            </comment>
            <comment date="31/01/2004" author="Roman Chumachenko">
            <description>Rebiuld for new UI (TabBar)</description>
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

<%@ page import="com.apconsulting.luna.ejb.GiorniLavorati.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
    var err=false;
</script>
<%
            IGiorniLavorati bean = null;
            IGiorniLavoratiHome Home = (IGiorniLavoratiHome) PseudoContext.lookup("GiorniLavoratiBean");
            if (request.getParameter("ID") != null) {
                //
                Long ID = new Long(request.getParameter("ID"));
                try {
                    Home.remove(new GiorniLavoratiPK(Security.getAzienda(), ID));
                } catch (Exception ex) {
                    ex.printStackTrace();
                    out.print("<script>Alert.Error.showDelete();</script>");
                    return;
                }
            } else {
                out.print("<script>err=true;</script>");
            }
%>
<script>
    if (parent.dialogArguments){
        if (!err){
            Alert.Success.showDeleted();
            parent.returnValue="OK";
        }}else
        if (!err) {
    <%if (request.getParameter("LOCAL_MODE") != null) {%>
                parent.del_localRow();
                parent.tabbar.tabs[5].tabObj.Refresh();
                Alert.Success.showDeleted();
    <%} else {%>
                Alert.Success.showDeleted();
                parent.g_Handler.OnRefresh();
    <%}%>
            } else {
            Alert.Error.showDelete();
        }
</script>

