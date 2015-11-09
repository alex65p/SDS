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

<%@ include file="src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="_include/Checker.jsp" %>
<%@ include file="_include/Global.jsp" %>

<%@ include file="_include/ComboBuilder.jsp" %>

<%
String[] modules = request.getParameterValues("MODULE");

ISecurityHome home=Security.getSecurityHome();
SecurityModule module= new SecurityModule();

for(int i=0;i<modules.length;i++){
	module.strName= modules[i];
	module.strPermission=request.getParameter(modules[i]+"_Permission");
	module.bRequireCreate=request.getParameter(modules[i]+"_RequireCreate")!=null;
	module.bRequireSave=request.getParameter(modules[i]+"_RequireSave")!=null;
	module.bRequireList=request.getParameter(modules[i]+"_RequireList")!=null;
	//module.bRequireSearch=request.getParameter(modules[i]+"_RequireSearch")!=null;
	module.bRequireDelete=request.getParameter(modules[i]+"_RequireDelete")!=null;
	module.bRequireAssociateCreate=request.getParameter(modules[i]+"_RequireAssociateCreate")!=null;
	module.bRequireAssociateDelete=request.getParameter(modules[i]+"_RequireAssociateDelete")!=null;
	module.bRequirePrint=request.getParameter(modules[i]+"_RequirePrint")!=null;
	module.bRequirePrint2=request.getParameter(modules[i]+"_RequirePrint2")!=null;
	//module.bRequireReturn=request.getParameter(modules[i]+"_RequireReturn")!=null;
	module.bRequireDetalize=request.getParameter(modules[i]+"_RequireDetalize")!=null;
	module.strRequest=(String)request.getParameter(modules[i]+"_Request");
	
	try{
		home.setSecurityModule(module);
	}
	catch(Exception ex){
		out.println(ex.getMessage());
		ex.printStackTrace();
	}
}
%>
<script>alert("saved")</script>



