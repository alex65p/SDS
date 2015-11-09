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
    <version number="1.0" date="24/01/2004" author="Malyuk Sergey">
	      <comments>
				  <comment date="24/01/2004" author="Malyuk Sergey">
				   <description></description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>  
//JS peremennaja vistvliemaja v true esli bila sozdana new zapis'  
var isNew = false;
var err = false; 
</script>

<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/TipologiaCorsi/TipologiaCorsiBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TipologiaCorsi/TipologiaCorsiBean.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
	String ReqMODE;	// parameter of request 
%>
<%
ITipologiaCorsi TipologiaCorsi=null;
String strCOD_TPL_COR="";
long lCOD_TPL_COR=0;
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");

		Checker c = new Checker();
		
	//- checking for required fields		
	String strNOM_TPL_COR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"),request.getParameter("nome"),true);   
	
	//- checking for not required fields		
	String strDES_TPL_COR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("descr"),false);
	
	if (c.isError)
		{
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}
//=======================================================================================
  if(ReqMODE.equals("edt"))
	{
		// editing of TipologiaCorsi--------------------
		// gettinf of object 
		strCOD_TPL_COR=request.getParameter("TPL_COR_ID");					//ID of TipologiaCorsi
		ITipologiaCorsiHome home=(ITipologiaCorsiHome)PseudoContext.lookup("TipologiaCorsiBean");
		Long tpl_cor_id=new Long(strCOD_TPL_COR);
		TipologiaCorsi = home.findByPrimaryKey(tpl_cor_id);
		try{
			TipologiaCorsi.setNOM_TPL_COR(strNOM_TPL_COR);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}

	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new TipologiaCorsi--------------------------
	// creating of object 
		ITipologiaCorsiHome home=(ITipologiaCorsiHome)PseudoContext.lookup("TipologiaCorsiBean");
		try{
			 	TipologiaCorsi=home.create(strNOM_TPL_COR);
				%><script>isNew=true;</script><%				
			 }
		catch(Exception ex)
			{
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			 return;
			}
		lCOD_TPL_COR = TipologiaCorsi.getCOD_TPL_COR();
	}
//=======================================================================================
	if (TipologiaCorsi!=null){
	//   *Not require Fields*
		TipologiaCorsi.setDES_TPL_COR(strDES_TPL_COR);
	out.print("<script>isNew=true;</script>");
	}
}
 %>
<script>
if (!err){  
	 				Alert.Success.showSaved();  
	 				if(isNew) parent.ToolBar.OnNew("ID=<%=lCOD_TPL_COR%>");
				}
</script>
