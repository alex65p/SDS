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
    <version number="1.0" date="15/01/2004" author="Treskina Maria">
	  <comments>
				 <comment date="15/01/2004" author="Treskina Maria">
				   <description>Shablon formi ANA_FOR_Form.jsp</description>
				 </comment>
				 <comment date="18/02/2004" author="Treskina Maria">
				   <description>podklychenie Alert.jsp i izmenenie soobshenija ob error</description>
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
<%@ page import="com.apconsulting.luna.ejb.Fornitore.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script type="text/javascript">
var err = false;
var isNew = false;
</script>

<%!
	String ReqMODE;	// parameter of request
%>
<%
IFornitore fornitore=null;

if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");

		Checker c = new Checker();
		//- checking for required fields
		String strRAG_SOC_FOR_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Ragione.sociale"),request.getParameter("RAG_SOC"),true);
		String strCAG_FOR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Categoria"),request.getParameter("CATEGORIA"),true);
		String strIDZ_FOR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Indirizzo"),request.getParameter("INDIRIZZO"),true);
		String strCIT_FOR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Città"),request.getParameter("CITTA"),true);
		String strQLF_RSP_FOR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Qualifica.del.datore.lavoro"),request.getParameter("QUALIFICA"),true);
		String strNOM_RSP_FOR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro"),request.getParameter("DATORE_LAVORO"),true);
		long lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZIENDA"),true);
		long lCOD_STA=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Stato"),request.getParameter("STATO"),true);

		//- checking for not required fields
		String strNUM_CIC_FOR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Numero.civico"),request.getParameter("NUM_CIC"),false);
		String strPRV_FOR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Provincia"),request.getParameter("PROV"),false);
		String strCAP_FOR=c.checkString(ApplicationConfigurator.LanguageManager.getString("C.a.p."),request.getParameter("CAP"),false);
		String strIDZ_PSA_ELT_RSP=c.checkEmail(ApplicationConfigurator.LanguageManager.getString("E-mail"),request.getParameter("EMAIL"),false);
		String strSIT_INT_FOR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Sito.internet"),request.getParameter("SITO_INTERNET"),false);

	if (c.isError)
		{
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");err=true;</script>");
			return;
		}
//=======================================================================================
  if(ReqMODE.equals("edt"))
	{
		// editing of fornitore--------------------
		// gettinf of object
		IFornitoreHome home=(IFornitoreHome)PseudoContext.lookup("FornitoreBean");

		Long for_id=new Long(c.checkLong("Fornitore ID",request.getParameter("FOR_ID"),true));

		if (c.isError)
		{
			String err = c.printErrors();
			out.print("for_id="+err);
			out.println("<script>alert(\""+err+"\");err=true;</script>");
		}
		fornitore = home.findByPrimaryKey(for_id);
		//getting of parameters and set the new object variables
		try{
			fornitore.setRAG_SOC_FOR_AZL__CAG_FOR(strRAG_SOC_FOR_AZL, strCAG_FOR);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
		}

		fornitore.setIDZ_FOR(strIDZ_FOR);
		fornitore.setCIT_FOR(strCIT_FOR);
		fornitore.setQLF_RSP_FOR(strQLF_RSP_FOR);
		fornitore.setNOM_RSP_FOR(strNOM_RSP_FOR);
		fornitore.setCOD_AZL(lCOD_AZL);
		fornitore.setCOD_STA(lCOD_STA);
	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new fornitore--------------------------
	// creating of object
		IFornitoreHome home=(IFornitoreHome)PseudoContext.lookup("FornitoreBean");
		try{
			fornitore=home.create(strRAG_SOC_FOR_AZL,strCAG_FOR,strIDZ_FOR,strCIT_FOR, strQLF_RSP_FOR, strNOM_RSP_FOR,  lCOD_AZL, lCOD_STA);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
		}
		out.print ("<script>isNew=true;</script>");
	}
//=======================================================================================
  if (fornitore!=null){
	//   *Not require Fields*
		fornitore.setNUM_CIC_FOR(strNUM_CIC_FOR);
		fornitore.setPRV_FOR(strPRV_FOR);
		fornitore.setCAP_FOR(strCAP_FOR);
		fornitore.setIDZ_PSA_ELT_RSP(strIDZ_PSA_ELT_RSP);
		fornitore.setSIT_INT_FOR(strSIT_INT_FOR);
%>
<script>
if (!err){
	if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=fornitore.getCOD_FOR_AZL()%>");
		}else{
			Alert.Success.showSaved();
		}
}
</script>
<%
	}
}
%>
