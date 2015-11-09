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
    Document   : STP_DUVRI_Tabs
    Created on : 30-mag-2008, 11.46.41
    Author     : Giancarlo Servadei
--%>

<%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache");        //HTTP 1.0
            response.setDateHeader("Expires", 0);            //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServDUVRI.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<html>
<body>
<script type="text/javascript" src="../_scripts/Alert.js"></script>
<script>
    var err = false;
    </script>
<div id="dContent">
    <%
            Checker c = new Checker();
            long lCOD_SRV = c.checkLong("Contratto/Servizio", request.getParameter("ID_PARENT"), true);

            if (c.isError) {
                String err = c.printErrors();
    %><script>alert("<%=err%>");</script><%
                return;
            }

            IAnaContServHome home = null;
            IAnaContServ bean = null;
            try {
                home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");
                bean = home.findByPrimaryKey(lCOD_SRV);
            } catch (Exception ex) {
                ex.printStackTrace();
                out.print(printErrAlert("divErr", "Error.showNotFound", ex));
                return;
            }
            try {
                if (bean != null) {
                    // DUVRI
                    if (request.getParameter("TAB_NAME").equals("tab1")) {
                        IContServDUVRIHome stp_duv_home = (IContServDUVRIHome) PseudoContext.lookup("ContServDUVRIBean");
                        out.println(BuildDUVRITab(stp_duv_home, lCOD_SRV));
                    } else {
                        return;
                    }
                }
            } catch (Exception ex) {
                ex.printStackTrace();
    %><%
            }
    %>
</div>
<script>
    if (!err){
        parent.tabbar.ReloadTabTable(document);
    }
    else{
        Alert.Error.showNotFound();
    }
    </script>
<%!
// DUVRI
    String BuildDUVRITab(IContServDUVRIHome home, long lCOD_SRV) {
        java.util.Collection col = home.findEx_ContServDUVRI(lCOD_SRV);
        StringBuilder jspOutputBuilder = new StringBuilder();
        jspOutputBuilder.append("<table border='0' align='left' width='755' id='ContServDUVRIHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>")
                        .append("<tr>")
                        .append("<td width='655'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Progressivo") + "</strong></td>")
                        .append("<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data") + "</strong></td>")
                        .append("</tr>")
                        .append("</table>")
                        .append("<table border='0' align='left' width='755 id='ContServDUVRI' class='dataTable' cellpadding='0' cellspacing='0'>")
                        .append("<tr style='display:none' ID='' INDEX='" + lCOD_SRV + "'>")
                        .append("<td class='dataTd'>")
                        .append("<input type='text' name='PRO_DUV' class='dataInput' readonly  value=''>")
                        .append("</td>")
                        .append("<td class='dataTd'>")
                        .append("<input type='text' name='DAT_DUV' class='dataInput' readonly  value=''>")
                        .append("</td>")
                        .append("</tr>");

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            ContServDUVRI_View obj = (ContServDUVRI_View) it.next();
            jspOutputBuilder.append("<tr INDEX='" + lCOD_SRV + "' ID='" + obj.COD_PRO_DUV + "'>")
                            .append("<td class='dataTd'>")
                            .append("<input type='text' readonly style='width: 655px;' class='inputstyle'  value=\"" + Formatter.format(obj.PRO_DUV) + "\">")
                            .append("</td>")
                            .append("<td class='dataTd'>")
                            .append("<input type='text' readonly style='width: 100px;' class='inputstyle'  value=\"" + Formatter.format(obj.DAT_DUV) + "\">")
                            .append("</td>")
                            .append("</tr>");
        }
        jspOutputBuilder.append("</table>");
        return jspOutputBuilder.toString();
    }
%>
