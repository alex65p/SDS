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
    <version number="1.0" date="30/01/2004" author="Kushkarov Yura">
	      <comments>
				  <comment date="30/01/2004" author="Kushkarov Yura">
				   <description>Shablon formi ANA_ALA_Form.jsp</description>
				 </comment>
				 <comment date="13/05/2004" author="Treskina Maria">
				   <description>izmenenie tabov na novij stil</description>
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
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.ErogazioneCorsi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>


<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
var err=false;
var isNew=false;
</script>
<%!
	String ReqMODE;	// parameter of request%>
<%
IErogazioneCorsi ErogazioneCorsi=null;
IDipendente Dipendente=null;
long lCOD_SCH_EGZ_COR;
long lCOD_DTE=0;
if(request.getParameter("SBM_MODE")!=null){
	ReqMODE=request.getParameter("SBM_MODE");
	Checker c = new Checker();
	//- checking for required fields
	long lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);
    long lCOD_DPD=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Lavoratore"),request.getParameter("COD_DPD"),true);
    lCOD_DTE=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Fornitore.personale/servizi"),request.getParameter("COD_DTE"),true);	   
    lCOD_SCH_EGZ_COR=c.checkLong("COD_SCH_EGZ_COR",request.getParameter("COD_SCH_EGZ_COR"),true);
	long lCOD_COR=c.checkLong("COD_COR",request.getParameter("COD_COR"),true);
	if (c.isError){
		String err = c.printErrors();
		out.println("<script>alert(\""+err+"\");err=true;</script>");
		return;
	}
	//out.print("lCOD_AZL="+lCOD_AZL+"<br>lCOD_DPD="+lCOD_DPD+"<br>lCOD_DTE="+lCOD_DTE+"<br>lCOD_SCH_EGZ_COR="+lCOD_SCH_EGZ_COR+"<br>lCOD_COR="+lCOD_COR); 
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new TipologieMacchine--------------------------
	// creating of object
		IErogazioneCorsiHome home=(IErogazioneCorsiHome)PseudoContext.lookup("ErogazioneCorsiBean");
		Long COD_SCH_EGZ_COR = new Long(lCOD_SCH_EGZ_COR);
		ErogazioneCorsi = home.findByPrimaryKey(COD_SCH_EGZ_COR);
		try{
        java.sql.Date dtDAT_EFT_COR=ErogazioneCorsi.getDAT_PIF_EGZ_COR();
        ErogazioneCorsi.addISC_COR_DPD(lCOD_SCH_EGZ_COR, lCOD_DPD, lCOD_AZL);
		ErogazioneCorsi.addCOR_DPD(lCOD_COR, lCOD_DPD, lCOD_AZL,dtDAT_EFT_COR);
		}catch(Exception ex){
            ex.printStackTrace();
   			out.println("<script>Alert.Error.showDublicate();err=true;</script>");
   			return;
    		}
	  %><script>isNew=true;</script><%
	}
//=======================================================================================

IDipendenteHome d_home=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
Long COD_DPD = new Long(lCOD_DPD);
Dipendente = d_home.findByPrimaryKey(COD_DPD);/**/
}
out.println("<br>request.getParameter(\"return\")="+request.getParameter("return"));
%>

<script>
 	if(!err)
	{
		<% if (request.getParameter("return")!=null){ %>
		window.close();
		<% }else{ %>
		if(isNew)
		{
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=Dipendente.getCOD_DPD()%>&ID1=<%=lCOD_DTE%>")
			}else{
			Alert.Success.showSaved();
		}
		<%} %>
		
	}//if not error
</script>
