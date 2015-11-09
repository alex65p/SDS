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
    <version number="1.0" date="22/01/2004" author="Mike Kondratyuk">
	      <comments>
				  <comment date="22/01/2004" author="Mike Kondratyuk">
				   <description>Shablon formi ANA_TPL_UNI_ORG_Set.jsp</description>
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

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/TipologieUnitaOrganizzativa/TipologieUnitaOrganizzativaBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TipologieUnitaOrganizzativa/TipologieUnitaOrganizzativaBean.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<script>
  var err=false;
  var isNew=false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%!
	String ReqMODE;	// parameter of request
%>
<%
ITipologieUnitaOrganizzativa TipologieUnitaOrganizzativa=null;

if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	//out.println(ReqMODE);

		Checker c = new Checker();

	//- checking for required fields
	long lCOD_TPL_UNI_ORG=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dati.tipologia.unità.organizzativa"),request.getParameter("TPL_UNI_ORG_ID"),true);
	String strNOM_TPL_UNI_ORG=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"),request.getParameter("NOME"),true);

	//- checking for not required fields
	String strDES_TPL_UNI_ORG=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DESC"),false);

	if (c.isError)
		{
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}

//=======================================================================================
if(ReqMODE.equals("edt"))
	{
		// editing of attivitaLavorative--------------------
		// gettinf of object
		String strCOD_TPL_UNI_ORG=request.getParameter("TPL_UNI_ORG_ID");					//ID of attivitaLavorative
		ITipologieUnitaOrganizzativaHome home=(ITipologieUnitaOrganizzativaHome)PseudoContext.lookup("TipologieUnitaOrganizzativaBean");
		Long tpl_uni_org_id=new Long(strCOD_TPL_UNI_ORG);
		TipologieUnitaOrganizzativa = home.findByPrimaryKey(tpl_uni_org_id);

		try{
			TipologieUnitaOrganizzativa.setNOM_TPL_UNI_ORG(strNOM_TPL_UNI_ORG);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}
//=======================================================================================
	if(ReqMODE.equals("new"))
  {
  out.print("<script>isNew=true;</script>");
	// new TipologieUnitaOrganizzativa--------------------------
	// creating of object
		ITipologieUnitaOrganizzativaHome home=(ITipologieUnitaOrganizzativaHome)PseudoContext.lookup("TipologieUnitaOrganizzativaBean");
		try{
			TipologieUnitaOrganizzativa=home.create(strNOM_TPL_UNI_ORG);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}
//=======================================================================================
  if (TipologieUnitaOrganizzativa!=null){
	//   *Not require Fields*
		TipologieUnitaOrganizzativa.setDES_TPL_UNI_ORG(strDES_TPL_UNI_ORG);
	}
}
%>
<script>
 	if(!err){
		parent.returnValue="OK";
		if(isNew){
			parent.ToolBar.OnNew("ID=<%=TipologieUnitaOrganizzativa.getCOD_TPL_UNI_ORG()%>");
			Alert.Success.showCreated();
			//parent.ToolBar.Return.OnClick();
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";
	}
</script>
