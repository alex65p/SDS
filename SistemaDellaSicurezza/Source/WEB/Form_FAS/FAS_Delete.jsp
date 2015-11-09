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

<%@ page import="com.apconsulting.luna.ejb.Fascicolo.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
	var err=false;
</script>
<%

Checker c = new Checker();
            long ID;
            IFascicoloHome fasHome=(IFascicoloHome)PseudoContext.lookup("FascicoloBean");

            String LOCAL_MODE = request.getParameter("LOCAL_MODE");
            ID = c.checkLong("", request.getParameter("ID"), true);
            if (c.isError) {
                out.println("<script>alert(\"" + c.printErrors() + "\");</script>");
                return;
            }

            try {
                fasHome.remove(ID);
            } catch (Exception ex) {
                out.println("<script>err=true;</script>");
            }
%>
<script>
	if (err) Alert.Error.showDelete();

	<%if(LOCAL_MODE==null){%>
		//else parent.g_Handler.OnRefresh();
		else{
		  Alert.Success.showDeleted();
		  parent.g_Handler.OnRefresh();
		  //parent.ToolBar.OnDelete();
		}
	<%} else {%>

		if (!err){
			parent.del_localRow();
			Alert.Success.showDeleted();
	    }

	<%}%>
</script>
