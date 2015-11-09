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

%>
<%@ page import="com.apconsulting.luna.ejb.FattoriRischioCantiere.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script>var err=false;</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
Checker c = new Checker();
long lCOD_DOC=0;
long ID=0;
String LOCAL_MODE=request.getParameter("LOCAL_MODE");
if(LOCAL_MODE!=null){
 ID=c.checkLong("Fattore Rischio",request.getParameter("ID_PARENT"),true);
 if(LOCAL_MODE.equals("doc"))
	lCOD_DOC=c.checkLong("Documento",request.getParameter("ID"),true);
}
else{
	ID=c.checkLong("Fattore Rischio",request.getParameter("ID"),true);
}
if (c.isError){
	out.println("<script>err=true;alert(\""+ c.printErrors()+"\");</script>");
	return;
}

IFattoriRischioCantiere fr=null;
IFattoriRischioCantiereHome home=(IFattoriRischioCantiereHome)PseudoContext.lookup("FattoriRischioCantiereBean");
try{
	if(LOCAL_MODE!=null){
		fr=home.findByPrimaryKey(new Long(ID));

		if(lCOD_DOC!=0){
			fr.removeDOC_FAT_RSO(lCOD_DOC);
		}
		else{
			throw new Exception("Invalid operation");
		}
	}
	else{
		home.remove(new Long(ID));
	}
}
catch(Exception ex){
%>
	<script>err=true;</script>
<%}%>

<script>
	if (err) Alert.Error.showDelete();
	<%if(LOCAL_MODE==null){%>
		else{
		 Alert.Success.showDeleted();
		  parent.g_Handler.OnRefresh();
		}
	<%} else {%>
		if (!err)
			 {
			 	Alert.Success.showDeleted();
			 	parent.del_localRow();
			 }
	<%}%>
</script>

