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

<%@ page import="com.apconsulting.luna.ejb.GestioneVisiteMediche.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
var err=false;
</script>

<%
IGestioneVisiteMediche GestioneVisiteMediche=null;
Checker c = new Checker();

  String	strNOM_VST_MED=c.checkString("Nome",request.getParameter("NOME"),true);   
	String	strFROM = c.checkString("Periodicita",request.getParameter("FROM"),true);
	long	  lCOD_AZL = c.checkLong("COD_AZL",request.getParameter("AZIENDA"),true);
  
	if (c.isError)
	{
		String err = c.printErrors();
		out.println("<script>alert(\""+err+"\");</script>");
		return;
	}
	
	if ("right".equals(strFROM))
	{
	  IGestioneVisiteMedicheHome home=(IGestioneVisiteMedicheHome)PseudoContext.lookup("GestioneVisiteMedicheBean");
		try{
		boolean result=home.caricaRpVisMed(lCOD_AZL, strNOM_VST_MED);
		}catch(Exception ex){
			out.print("<script>err=true;</script>");
			return;
		}
	}
%>
<script>
  if(err) Alert.Error.showRepositoryExport();
	else Alert.Success.showRepositoryExport();
</script>
