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
    <version number="1.0" date="20/2/2004" author="Podmasteriev Alexandr">
	  <comments>
				 <comment date="20/2/2004" author="Podmasteriev Alexandr">
				   <description>Zanesenie v tablicu</description>
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


<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteLingueStraniere/DipendenteLingueStraniereBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteLingueStraniere/DipendenteLingueStraniereBean.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%!
	String ReqMODE;	// parameter of request 
%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
 var isNew = false;
 var err=false;
</script>
<%
IDipendenteLingueStraniere DipendenteLingueStraniere=null;
long lCOD=0;
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");

		Checker c = new Checker();
		//- checking for required fields
		String strNOM_LNG_STR_DPD=c.checkString(ApplicationConfigurator.LanguageManager.getString("Lingua.straniera"),request.getParameter("NOM_LNG_STR_DPD"),true);
		String strLIV_CSC_LNG_STR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Livello.di.conoscenza"),request.getParameter("LIV_CSC_LNG_STR"),true);
		long lCOD_DPD=c.checkLong("",request.getParameter("COD_DPD"),true);
		long lCOD_AZL=Security.getAzienda();
		if (c.isError)
		{
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}
//=======================================================================================
  if(ReqMODE.equals("edt"))
	{
  	// editing of DipendenteLingueStraniere--------------------
		// gettinf of object 
		IDipendenteLingueStraniereHome home=(IDipendenteLingueStraniereHome)PseudoContext.lookup("DipendenteLingueStraniereBean");
		
		Long LNG_ID=new Long(c.checkLong("DipendenteLingueStraniere ID",request.getParameter("COD_LNG_STR_DPD"),true));

		if (c.isError)
		{
			String err = c.printErrors();
			out.print("for_id="+err);
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}
		DipendenteLingueStraniere = home.findByPrimaryKey(LNG_ID);
		//getting of parameters and set the new object variables
		
			DipendenteLingueStraniere.setCOD_AZL(lCOD_AZL);
			DipendenteLingueStraniere.setLIV_CSC_LNG_STR(strLIV_CSC_LNG_STR);
		try{
			DipendenteLingueStraniere.setNOM_LNG_STR_DPD(strNOM_LNG_STR_DPD);
			DipendenteLingueStraniere.setCOD_DPD(lCOD_DPD);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new DipendenteLingueStraniere--------------------------
	// creating of object 
		IDipendenteLingueStraniereHome home=(IDipendenteLingueStraniereHome)PseudoContext.lookup("DipendenteLingueStraniereBean");
	  out.print("<script>isNew=true;</script>");
		try{
		DipendenteLingueStraniere=home.create(strNOM_LNG_STR_DPD,strLIV_CSC_LNG_STR,lCOD_DPD,lCOD_AZL);
		}
		catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	lCOD=DipendenteLingueStraniere.getCOD_LNG_STR_DPD();
	
	}
//=======================================================================================
}
%>
<script>
 //JS peremennaja vistvliemaja v true esli bila sozdana new zapis'  
 if (!err){  
 						 if(isNew) {Alert.Success.showCreated();
						 					 parent.ToolBar.OnNew("ID=<%=lCOD%>");
						 }
						 else
						 {Alert.Success.showSaved(); }
					}

 /*parent.window.returnValue="OK";
 parent.window.close();*/
</script>
