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
     <version number="1.0" date="24/01/2004" author="Malyuk Sergey">
     <comments>
     <comment date="24/01/2004" author="Malyuk Sergey">
     <description></description>
     </comment>		
     <comment date="26/02/2004" author="Alexey Kolesnik">
     <description> Rebuild for dynamic tabbars </description>
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
<%@ page import="com.apconsulting.luna.ejb.ProtocoleSanitare.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/ExtendedMode.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
    var err = false;
</script>

<%
    Checker c = new Checker();
    long ID;
    long lCOD_DOC = 0;
    long lCOD_VST_IDO = 0;
    long lCOD_VST_MED = 0;
    long lCOD_AZL = Security.getAzienda();
    IProtocoleSanitareHome home = (IProtocoleSanitareHome) PseudoContext.lookup("ProtocoleSanitareBean");
    ArrayList alAziende = null;

    String LOCAL_MODE = request.getParameter("LOCAL_MODE");
    if (LOCAL_MODE != null) {
        ID = c.checkLong("PROTOCOLLE SANITARE", request.getParameter("ID_PARENT"), true);

        if (LOCAL_MODE.equals("doc")) {
            lCOD_DOC = c.checkLong("Documento", request.getParameter("ID"), true);
        }
        if (LOCAL_MODE.equals("ido")) {
            lCOD_VST_IDO = c.checkLong("Idoneta", request.getParameter("ID"), true);
        }
        if (LOCAL_MODE.equals("med")) {
            lCOD_VST_MED = c.checkLong("Mediche", request.getParameter("ID"), true);
        }
    } else {
        ID = c.checkLong("PROTOCOLLE SANITARE", request.getParameter("ID"), true);
        alAziende = ExtendedMode.getAziende(c); //EXTENDED
    }
    if (c.isError) {
        out.println("<script>err=true;alert(\"" + c.printErrors() + "\");</script>");
        return;
    }

    try {
        if (LOCAL_MODE != null) {
            IProtocoleSanitare bean = home.findByPrimaryKey(new ProtocoleSanitarePK(lCOD_AZL, new Long(ID).longValue()));
            if (lCOD_DOC != 0) {
                try {
                    bean.removeDocumento(lCOD_DOC);
                } catch (Exception ex) {
                    throw new Exception("Non è possibile elliminare documento associa!");
                }
            } else if (lCOD_VST_IDO != 0) {
                try {
                    bean.removeIdoneta(lCOD_VST_IDO);
                } catch (Exception ex) {
                    throw new Exception("Non è possibile elliminare idoneta associa!");
                }
            } else if (lCOD_VST_MED != 0) {
                try {
                    bean.removeMediche(lCOD_VST_MED);
                } catch (Exception ex) {
                    throw new Exception("Non è possibile elliminare mediche associa!");
                }
            } else {
                throw new Exception("Non è possibile elliminare associa");
            }
        } else {
            try {
                home.remove(new ProtocoleSanitarePK(lCOD_AZL, ID), alAziende);
            } catch (Exception ex) {
                throw ex;
            }
        }
    } catch (Exception ex) {
        manageException(request, out, ex);
%>
<div id="divErr"><%=ex.getMessage()%></div>
<script>err = true;</script>
<%}%>

<script>
    if (err)
        Alert.Error.showDelete();
    <%if (LOCAL_MODE == null) {%>
    else{
        Alert.Success.showDeleted();
        parent.ToolBar.OnDelete();
    }
    <%} else {%>
    if (!err) {
        Alert.Success.showDeleted();
        parent.del_localRow();
    }
    <%}%>
</script>
