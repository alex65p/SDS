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
    <version number="1.0" date="12/02/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="12/02/2004" author="Khomenko Juliya">
				   <description>Create ANA_PRG_Tabs.jsp</description>
				  </comment>		
        </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.SchedeParagrafo.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.GestioniSezioni.*" %>
<%@ page import="com.apconsulting.luna.ejb.Capitoli.*" %>
<%@ page import="com.apconsulting.luna.ejb.Paragrafo.*" %>
<%@ page import="com.apconsulting.luna.ejb.GestioneTabellare.*" %>
<%@ page import="com.apconsulting.luna.ejb.Collegamenti.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="ANA_PRG_Util.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<script>
  var err=false;
//alert('<%=request.getParameter("TAB_NAME")%>');
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<div id="dContent">
<%

Checker c = new Checker();

long lCOD_PRG=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dati.paragrafo"),request.getParameter("ID_PARENT"),true);

if (c.isError){
	String err = c.printErrors();
	out.print("<script>alert(\""+err+"\");</script>");
	return;
}

	long lCOD_AZL = Security.getAzienda();
	
	IParagrafo bean=null;
	
	String strID = (String)request.getParameter("ID_PARENT");
	IParagrafoHome home=(IParagrafoHome)PseudoContext.lookup("ParagrafoBean");
	try{
			bean = home.findByPrimaryKey(new Long(lCOD_PRG));
			lCOD_PRG = bean.getCOD_PRG();
	}catch(Exception ex){
                        ex.printStackTrace();
			out.print(printErrAlert("divErr", "Error.showNotFound",ex));
			return;
	}		
	try{
	 if(bean!=null){
	    if(request.getParameter("TAB_NAME").equals("tab1")){
         IParagrafoHome pcHome=(IParagrafoHome)PseudoContext.lookup("ParagrafoBean");
				 out.println(BuildParagrafoDocumentiTab(home, lCOD_PRG));
			}
			else if(request.getParameter("TAB_NAME").equals("tab2")){
				 ICollegamentiHome colHome=(ICollegamentiHome)PseudoContext.lookup("CollegamentiBean");
				 out.println(BuildCollegamentoInternetTab(colHome, lCOD_PRG));
	    }
			else if(request.getParameter("TAB_NAME").equals("tab3")){
				 ISchedeParagrafoHome parHome=(ISchedeParagrafoHome)PseudoContext.lookup("SchedeParagrafoBean");
				 out.println(parHome.BuildSchedeParagrafoTab(lCOD_PRG, lCOD_AZL, Security.getCurrentDvrUniOrg()==null?0:Security.getCurrentDvrUniOrg().longValue()));
	    }
			else if(request.getParameter("TAB_NAME").equals("tab4")){
				 IGestioneTabellareHome tabHome=(IGestioneTabellareHome)PseudoContext.lookup("GestioneTabellareBean");
				 out.println(BuildGestioneTabellareTab(tabHome, lCOD_PRG));
	    }
			else{
			   return;
			}
	 }
	}
	catch(Exception ex){
			ex.printStackTrace();
                        out.print(printErrAlert("divErr", "Error.alert",ex));
			return;
	}
%>
</div>
<script>
 if (!err){
    parent.tabbar.ReloadTabTable(document);
 }
</script>
