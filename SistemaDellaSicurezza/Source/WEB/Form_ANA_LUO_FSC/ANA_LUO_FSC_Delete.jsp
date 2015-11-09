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
     <version number="1.0" date="19/01/2004" author="Alexey Kolesnik">
     <comments>
     <comment date="19/01/2004" author="Alexey Kolesnik">
     <description>Shablon formi ANA_LUO_FSC_Delete.jsp</description>
     </comment>
     <comment date="22/01/2004" author="Mike Kondratyuk">
     <description>Dobavlen kod dlya tabika s formy ANA_SIT_AZL_Form.jsp</description>
     </comment>
     <comment date="31/01/2004" author="Alexey Kolesnik">
     <description> Added new toolbar </description>
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
<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/ExtendedMode.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script type="text/javascript">
    var err=false;
    var errDescr;
</script>
<script type="text/javascript" src="../_scripts/Alert.js"></script>
<%
    Checker c = new Checker();
    long ID;
    long lCOD_DOC = 0;
    long lCOD_MAC = 0;
    ArrayList alAziende = null;
    IAnagrLuoghiFisiciHome home = (IAnagrLuoghiFisiciHome) PseudoContext.lookup("AnagrLuoghiFisiciBean");
    IAnagrLuoghiFisici bean = null;

    String LOCAL_MODE = request.getParameter("LOCAL_MODE");

    if (LOCAL_MODE != null) {
	ID = c.checkLong("Luogo Fisico", request.getParameter("ID_PARENT"), true);
	if (LOCAL_MODE.equals("doc")) {
	    lCOD_DOC = c.checkLong("Documento", request.getParameter("ID"), true);
	}
	if (LOCAL_MODE.equals("mac")) {
	    lCOD_MAC = c.checkLong(
		    ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
		    ? "Macchine.attrezzature.impianti"
		    : "Macchine/Attrezzature", request.getParameter("ID"), true);
	}
	if (LOCAL_MODE.equals("LUO")) {
	    ID = c.checkLong("Luogo Fisico", request.getParameter("ID"), true);
	}
    } else {
	ID = c.checkLong("Luogo Fisico", request.getParameter("ID"), true);
	alAziende = ExtendedMode.getAziende(c); //EXTENDED
    }

    if (c.isError) {
	out.println("<script>err=true;alert(\"" + c.printErrors() + "\");</script>");
	return;
    }

    try {
	if (LOCAL_MODE != null) {
	    bean = home.findByPrimaryKey(new Long(ID));
	    if (lCOD_DOC != 0) {
		try {
		    bean.removeDocumento(lCOD_DOC);
		} catch (Exception ex) {
		    throw new Exception("Non è possibile eliminare il documento associato");
		}
	    } else if (lCOD_MAC != 0) {
		out.print("lCOD_MAC: " + lCOD_MAC + "<br>");
		long lCOD_AZL = Security.getAzienda();
		bean.removeMacchine(lCOD_MAC, lCOD_AZL);
	    } else {
		if (LOCAL_MODE.equals("LUO")) {
		    try {
			home.removeExtended(new Long(ID), alAziende);
		    } catch (Exception ex) {
			throw new Exception("Non è possibile eliminare la riga");
		    }
		} else {
		    throw new Exception("Non è possibile eliminare l'associazione");
		}
	    }
	} else {
	    //-- LOCAL MODE --
	    try {
 		home.removeExtended(new Long(ID), alAziende);
	    } catch (Exception ex) {
		manageException(request, out, ex);
	    }
	}
    } catch (Exception ex) {
%>
<div id="divErr"><%=ex.toString()%></div>
<script type="text/javascript">err=true;</script>
<%
	ex.printStackTrace();
    }
%>
<script type="text/javascript">
    if (err) Alert.Error.showDelete();
    <%if (LOCAL_MODE == null) {%>
        if (!err){
            Alert.Success.showDeleted();
            if(parent.ToolBar != null){
                parent.ToolBar.OnDelete();
            }
            parent.g_Handler.OnRefresh();
        }
    <%} else {%>
        if (!err){
            parent.del_localRow();
            Alert.Success.showDeleted();
        }
    <%}%>
</script>
