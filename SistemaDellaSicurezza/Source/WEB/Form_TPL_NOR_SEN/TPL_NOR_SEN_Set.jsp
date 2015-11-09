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
    <version number="1.0" date="22/01/2004" author="Pogrebnoy Yura">
	      <comments>
				  <comment date="22/01/2004" author="Pogrebnoy Yura">
				   <description>Shablon formi ANA_TPL_NOR_SEN_Form.jsp</description>
				 </comment>
      </comments>
    </version>
  </versions>
</file>
*/
%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/TipologieNomativeSentenze/TipologieNomativeSentenzeBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TipologieNomativeSentenze/TipologieNomativeSentenzeBean.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!	String ReqMODE;	// parameter of request%>
<script>
  var err=false;
	var isNew=false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
ITipologieNomativeSentenze tns=null;
Long lCOD_TPL_NOR_SEN=null;
String strDES_TPL_NOR_SEN="";
if(request.getParameter("SBM_MODE")!=null){
	ReqMODE=request.getParameter("SBM_MODE");
	Checker c = new Checker();
	String strNOM_TPL_NOR_SEN=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"),request.getParameter("NOM_TPL_NOR_SEN"),true);
	strDES_TPL_NOR_SEN=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_TPL_NOR_SEN"),false);
	  if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}
  if(ReqMODE.equals("edt"))
	{
		lCOD_TPL_NOR_SEN=new Long(c.checkLong("TipologieNomativeSentenze ID",request.getParameter("COD_TPL_NOR_SEN"),true));
  	if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}
		ITipologieNomativeSentenzeHome home=(ITipologieNomativeSentenzeHome)PseudoContext.lookup("TipologieNomativeSentenzeBean");
		tns = home.findByPrimaryKey(lCOD_TPL_NOR_SEN);
		try{
		  tns.setNOM_TPL_NOR_SEN(strNOM_TPL_NOR_SEN);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate(); err=true;</script>");
		}
	}
	if(ReqMODE.equals("new"))
	{
		ITipologieNomativeSentenzeHome home=(ITipologieNomativeSentenzeHome)PseudoContext.lookup("TipologieNomativeSentenzeBean");
		try{
		  tns=home.create(strNOM_TPL_NOR_SEN);
		}catch(Exception ex){
			out.print("<script>err=true; Alert.Error.showDublicate(); err=true;</script>");
		}
		out.print("<script>isNew=true;</script>");
	}
}
  if (tns!=null){
		try{
		tns.setDES_TPL_NOR_SEN(strDES_TPL_NOR_SEN);
		}catch(Exception ex){
			out.print("<script>err=true; Alert.Error.showDublicate(); err=true;</script>");
		}
%>
<script>
<!--
	if (!err){
		if(isNew){
    		Alert.Success.showCreated();
				parent.ToolBar.OnNew("ID=<% if (tns!=null) out.print(tns.getCOD_TPL_NOR_SEN()); %>");
		}else{
				Alert.Success.showSaved();
		}
		parent.returnValue="OK";
  }
//-->
</script>
<%}%>
