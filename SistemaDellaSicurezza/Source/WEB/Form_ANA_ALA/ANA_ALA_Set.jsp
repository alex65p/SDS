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
    <version number="1.0" date="16/01/2004" author="Pogrebnoy Yura">
	      <comments>
				  <comment date="16/01/2004" author="Pogrebnoy Yura">
				   <description>Shablon formi ANA_ALA_Form.jsp</description>
					<comment date="31/01/2004" author="Pogrebnoy Yura">
				   <description>Dobavlenie toolbara</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%@ page import="com.apconsulting.luna.ejb.Ala.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!	String ReqMODE;%>
<script>
 var err=false;
 var isNew = false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
IAla ala=null;
Long lCOD_ALA=null;
if(request.getParameter("SBM_MODE")!=null){
	ReqMODE=request.getParameter("SBM_MODE");
	Checker c = new Checker();
	String strNOM_ALA=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"),request.getParameter("NOM_ALA"),true);   
	String strDES_ALA=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_ALA"),false);
	  if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}
  if(ReqMODE.equals("edt"))	{
  	lCOD_ALA=new Long(c.checkLong("Ala ID",request.getParameter("COD_ALA"),true));
	  if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}
		IAlaHome home=(IAlaHome)PseudoContext.lookup("AlaBean");
		ala = home.findByPrimaryKey(lCOD_ALA);
    try{
	    ala.setNOM_ALA(strNOM_ALA);
		}catch(Exception ex){
			out.print("<script>err=true;</script>");
		}
	}
	if(ReqMODE.equals("new"))	{
		IAlaHome home=(IAlaHome)PseudoContext.lookup("AlaBean");
		try{
		  ala=home.create(strNOM_ALA);
	  }catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
		}
		out.print ("<script>isNew=true;</script>");
	}
  if (ala!=null){
		ala.setDES_ALA(strDES_ALA);
%>
<script>
<!--
/* if (parent.dialogArguments){
 	if (!err){	
		parent.returnValue="OK";
	if(isNew){
		  Alert.Success.showCreated();
			parent.ToolBar.Return.OnClick();
		}else{
	     Alert.Success.showSaved();
			 parent.ToolBar.Exit.setEnabled(false);
			 parent.ToolBar.Return.setEnabled(true);
		}
	}else{
		   parent.returnValue="ERROR";	
	}	
 }else{*/
   if(!err){
 		if(isNew){
		  Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=ala.getCOD_ALA()%>");
		}else{
	     Alert.Success.showSaved();
		}
  	parent.returnValue="OK";
//	  parent.window.close();
   }else{
	  Alert.Error.showDublicate();
	 }
// }
//-->
</script>
<%
	}
}
%>	
