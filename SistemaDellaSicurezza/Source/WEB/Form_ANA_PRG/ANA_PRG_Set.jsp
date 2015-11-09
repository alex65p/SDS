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
    <version number="1.0" date="06/02/2004" author="Khomenko Juliya">
      <comments>
			   <comment date="06/02/2004" author="Khomenko Juliya">
				   <description>Realizazija EJB dlia objecta Paragrafo
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
<%@ page import="com.apconsulting.luna.ejb.Paragrafo.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%!
	String ReqMODE;	// parameter of request
%>
<script>
  var err=false;
  var isNew=false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
IParagrafo bean=null;
//-----start check section--------------------------------
Checker c = new Checker();

long lCOD_PRG=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dati.paragrafo"),request.getParameter("PRG_ID"),true);
String strNOM_PRG=c.checkString(ApplicationConfigurator.LanguageManager.getString("Titolo"),request.getParameter("TITOLO"),true);
String strDES_PRG=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DESC"),false);
long lCOD_ARE=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Sezione"),request.getParameter("COD_ARE"),true);
long lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);
long lCOD_CPL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Capitolo"),request.getParameter("COD_CPL"),true);
long lPRIORITY = 0;
lPRIORITY = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Priorità"),request.getParameter("PRIORITY"),false);

if (c.isError){
	String err = c.printErrors();
	out.print("<script>alert(\""+err+"\");</script>");
	return;
}
if(lCOD_CPL==0)
{
	out.print("<script>Alert.Error.showDublicate();</script>");
	return;
}
IParagrafoHome home=(IParagrafoHome)PseudoContext.lookup("ParagrafoBean");

//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	out.print(ReqMODE);
	if(ReqMODE.equals("edt"))
	{
		bean = home.findByPrimaryKey(new Long(lCOD_PRG));
		try{
 		bean.setNOM_PRG(strNOM_PRG);
		bean.setCOD_AZL(lCOD_AZL);
		bean.setCOD_CPL(lCOD_CPL);
		bean.setCOD_ARE(lCOD_ARE);
		}catch(Exception ex){
			out.print("COD_AZL="+lCOD_AZL+" COD_CPL="+lCOD_CPL+" COD_ARE="+lCOD_ARE);
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}
	else{
		try{
				%><script>isNew=true;</script><%
		bean=home.create(  strNOM_PRG, lCOD_ARE, lCOD_AZL, lCOD_CPL);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}
	if(bean!=null){
 		bean.setDES_PRG(strDES_PRG);
		bean.setPRIORITY(lPRIORITY);
	}
}
%>
<script>  //JS peremennaja vistvliemaja v true esli bila sozdana new zapis'
 	if(!err){
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=bean.getCOD_PRG()%>");
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";
	}
</script>
