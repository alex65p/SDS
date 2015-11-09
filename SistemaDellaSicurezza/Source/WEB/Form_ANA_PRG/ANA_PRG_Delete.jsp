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
     <version number="1.0" date="09/02/2004" author="Khomenko Juliya">
     <comments>
     <comment date="09/02/2004" author="Khomenko Juliya">
     <description>Shablon formi ANA_PRG_Delete.jsp</description>
     </comment>		
     </comments> 
     </version>
     </versions>
     </file> 
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Paragrafo.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
    var err = false;
</script>

<%
    Checker c = new Checker();
    long ID = c.checkLong("Paragrafo", request.getParameter("ID"), true);
    long ID_PARENT = c.checkLong("Paragrafo", request.getParameter("ID_PARENT"), false);
    String LOCAL_MODE = request.getParameter("LOCAL_MODE");

    IParagrafoHome home = (IParagrafoHome) PseudoContext.lookup("ParagrafoBean");
    if (LOCAL_MODE != null) {
        if (LOCAL_MODE.equals("DOC")) {
            ID = c.checkLong("Documenti", request.getParameter("ID"), true);
        }
    }
    if (c.isError) {
        out.println("<script>err=true;alert(\"" + c.printErrors() + "\");</script>");
        return;
    }
    try {
        if (LOCAL_MODE != null) {
            IParagrafo bean = home.findByPrimaryKey(ID_PARENT);
            if (LOCAL_MODE.equals("DOC")) {
                bean.removeCOD_DOC(ID);
            }
        } else {
            home.remove(new Long(ID));
        }
    } catch (Exception ex) {
        manageException(request, out, ex);
%>
<div id="divErr">
    <%=ex.getMessage()%>
</div>
<script>err = true;</script>
<%
    }
%>
<script>
    var deletePrg = <%=(LOCAL_MODE == null && request.getParameter("deleteFromAreaTab") == null)%>
    // Errore nella cancellazione di un paragrafo o di un record dei tab a questo collegati
    if (err)
        Alert.Error.showDelete();
    // Cancellazione andata a buon fine...
    else {
        // ... di un paragrafo
        if (deletePrg) {
            Alert.Success.showDeleted();
            parent.g_Handler.OnRefresh();
            // ... di un record dei tab a questo collegati
        } else {
            Alert.Success.showDeleted();
            parent.del_localRow();
        }
    }
</script>


