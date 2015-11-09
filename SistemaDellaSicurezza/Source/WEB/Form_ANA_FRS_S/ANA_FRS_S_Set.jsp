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
				   <description>Shablon formi ANA_FRS_S_Set.jsp</description>
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
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
  var err=false;
  var isNew=false;  
</script>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/FraseS/FraseSBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/FraseS/FraseSBean.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
	String ReqMODE;	// parameter of request 
%>
<%
IFraseS FraseS=null;

if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	//out.println(ReqMODE);

		Checker c = new Checker();
		
	//- checking for required fields		
	long lCOD_FRS_S=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dati.frase.S"),request.getParameter("FRS_S_ID"),true);
	String strNUM_FRS_S=c.checkString(ApplicationConfigurator.LanguageManager.getString("Frase"),request.getParameter("NOME"),true);   
	String strDES_FRS_S=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DESC"),true);	
	//- checking for not required fields		
	
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
		String strCOD_FRS_S=request.getParameter("FRS_S_ID");					//ID of attivitaLavorative
		IFraseSHome home=(IFraseSHome)PseudoContext.lookup("FraseSBean");
		Long frs_s_id=new Long(strCOD_FRS_S);
		FraseS = home.findByPrimaryKey(frs_s_id);
 
		try{
			FraseS.setNUM_FRS_S(strNUM_FRS_S);
			FraseS.setDES_FRS_S(strDES_FRS_S);			
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}	
//=======================================================================================
	if(ReqMODE.equals("new"))
  {
	// new FraseS--------------------------
	// creating of object 
		IFraseSHome home=(IFraseSHome)PseudoContext.lookup("FraseSBean");
		try{
				%><script>isNew=true;</script><%
			FraseS=home.create(strNUM_FRS_S, strDES_FRS_S);
		}catch(Exception ex){
  		out.print("<script>Alert.Error.showDublicate();err=true;</script>");
		return;
		}
	}
//=======================================================================================
  if (FraseS!=null){
	//   *Not require Fields*
// 		FraseS.setDES_FRS_S(strDES_FRS_S);
	}
}
%>	
<script>  //JS peremennaja vistvliemaja v true esli bila sozdana new zapis'  

 	if(!err){	
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=FraseS.getCOD_FRS_S()%>");
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";	
	}	
</script>
