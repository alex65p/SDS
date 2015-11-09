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
    <version number="1.0" date="24/01/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="24/01/2004" author="Khomenko Juliya">
				   <description>Shablon formi ANA_FRS_R_Set.jsp</description>
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

<%@ include file="../src/com/apconsulting/luna/ejb/FraseR/FraseRBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/FraseR/FraseRBean.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
 <%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
 
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
  var err=false;
  var isNew=false;  
</script>



<%!
	String ReqMODE;	// parameter of request 
%>
<%
IFraseR FraseR=null;

if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	//out.println(ReqMODE);

		Checker c = new Checker();
		
	//- checking for required fields		
	long lCOD_FRS_R=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dati.frase.R"),request.getParameter("FRS_R_ID"),true);
	String strNUM_FRS_R=c.checkString(ApplicationConfigurator.LanguageManager.getString("Frase"),request.getParameter("NOME"),true);   
	String strDES_FRS_R=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DESC"),true);	
	//- checking for not required fields		
	double lVAL_INA=c.checkDouble(ApplicationConfigurator.LanguageManager.getString("INA.(inalazione)"),request.getParameter("INA"),false);
	double lVAL_CCP=c.checkDouble(ApplicationConfigurator.LanguageManager.getString("C.C.P.(contatto.con.la.pelle)"),request.getParameter("CCP"),false);
	double lVAL_ING=c.checkDouble(ApplicationConfigurator.LanguageManager.getString("ING.(ingestione)"),request.getParameter("ING"),false);
	double lVAL_IRR=c.checkDouble(ApplicationConfigurator.LanguageManager.getString("IRR.(irritazione)"),request.getParameter("IRR"),false);
	double lVAL_ESP=c.checkDouble(ApplicationConfigurator.LanguageManager.getString("ESP.(esposizione.ai.rischi.chimici)"),request.getParameter("ESP"),false);
	double lVAL_UNI=c.checkDouble(ApplicationConfigurator.LanguageManager.getString("Unico.(rischio.chimico)"),request.getParameter("UNI"),false);
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
		String strCOD_FRS_R=request.getParameter("FRS_R_ID");					//ID of attivitaLavorative
		IFraseRHome home=(IFraseRHome)PseudoContext.lookup("FraseRBean");
		Long frs_r_id=new Long(strCOD_FRS_R);
		FraseR = home.findByPrimaryKey(frs_r_id);
 
		try{
			FraseR.setNUM_FRS_R(strNUM_FRS_R);
			FraseR.setDES_FRS_R(strDES_FRS_R);			
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}	
//=======================================================================================
	if(ReqMODE.equals("new"))
  {
	// new FraseR--------------------------
	// creating of object 
		IFraseRHome home=(IFraseRHome)PseudoContext.lookup("FraseRBean");
		try{
				%><script>isNew=true;</script><%
			FraseR=home.create(strNUM_FRS_R, strDES_FRS_R);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}
//=======================================================================================
  if (FraseR!=null){
	//   *Not require Fields*
 		FraseR.setVAL_INA(lVAL_INA);
		FraseR.setVAL_CCP(lVAL_CCP);
		FraseR.setVAL_ING(lVAL_ING);
		FraseR.setVAL_IRR(lVAL_IRR);
		FraseR.setVAL_ESP(lVAL_ESP);
		FraseR.setVAL_UNI(lVAL_UNI);
	}
}
%>	
<script>  //JS peremennaja vistvliemaja v true esli bila sozdana new zapis'  

 	if(!err){	
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=FraseR.getCOD_FRS_R()%>");
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";	
	}	
</script>
