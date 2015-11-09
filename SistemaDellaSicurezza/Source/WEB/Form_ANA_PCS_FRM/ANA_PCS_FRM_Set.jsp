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
    <version number="1.0" date="25/01/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="25/01/2004" author="Khomenko Juliya">
				   <description>Shablon formi ANA_PCS_FRM_Set.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.PercorsiFormativi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script>
  var err=false;
  var isNew=false;  
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>

<%!
	String ReqMODE;	// parameter of request 
  long lCOD_AZL;
%>
<%
IPercorsiFormativi PercorsiFormativi=null;

if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	//out.println(ReqMODE);

		Checker c = new Checker();
		
	//- checking for required fields		
	long lCOD_PCS_FRM=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dati.percorso.formativo"),request.getParameter("PCS_FRM_ID"),true);
	String strNOM_PCS_FRM=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"),request.getParameter("NOME"),true);   
	lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);
	//- checking for not required fields		
	String strDES_PCS_FRM=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DESC"),false);
	
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
		String strCOD_PCS_FRM=request.getParameter("PCS_FRM_ID");					//ID of attivitaLavorative
		IPercorsiFormativiHome home=(IPercorsiFormativiHome)PseudoContext.lookup("PercorsiFormativiBean");
		Long pcs_frm_id=new Long(strCOD_PCS_FRM);
		PercorsiFormativi = home.findByPrimaryKey(pcs_frm_id);
 
		try{
			PercorsiFormativi.setNOM_PCS_FRM(strNOM_PCS_FRM);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}	
//=======================================================================================
	if(ReqMODE.equals("new"))
  {
	// new PercorsiFormativi--------------------------
	// creating of object 
		IPercorsiFormativiHome home=(IPercorsiFormativiHome)PseudoContext.lookup("PercorsiFormativiBean");
		try{
				%><script>isNew=true;</script><%
		PercorsiFormativi=home.create(strNOM_PCS_FRM, lCOD_AZL);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}
//=======================================================================================
  if (PercorsiFormativi!=null){
	//   *Not require Fields*
		PercorsiFormativi.setDES_PCS_FRM(strDES_PCS_FRM);
	}
}
%>	
<script>  //JS peremennaja vistvliemaja v true esli bila sozdana new zapis'  

 	if(!err){	
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=PercorsiFormativi.getCOD_PCS_FRM()%>");
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";	
	}	
</script>
