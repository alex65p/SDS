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
    <version number="1.0" date="30/01/2004" author="Pogrebnoy Yura">
	      <comments>
				  <comment date="30/01/2004" author="Pogrebnoy Yura">
				   <description>Shablon formi COL_INT_Form.jsp</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.CollegamentoInternet.*" %>
<%@ page import="com.apconsulting.luna.ejb.RischioFattore.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!	String ReqMODE;%>
<script language="JavaScript" type="text/javascript">
		var err=false;
		var isNew = false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%ICollegamentoInternet colint=null;
	ICollegamentoInternetHome home=(ICollegamentoInternetHome)PseudoContext.lookup("CollegamentoInternetBean");
	long lCOD_FAT_RSO = 0;
	String strCOD_FAT_RSO = request.getParameter("ID_PARENT");
	String strDES_COL_INT="";
	
	if (strCOD_FAT_RSO!=null && !strCOD_FAT_RSO.equals("") && !strCOD_FAT_RSO.equals("null")){
		lCOD_FAT_RSO = new Long (request.getParameter("ID_PARENT")).longValue();
	}

if(request.getParameter("SBM_MODE")!=null){
	ReqMODE=request.getParameter("SBM_MODE");
	Checker c = new Checker();
	String strIDZ_COL_INT=c.checkString(ApplicationConfigurator.LanguageManager.getString("Indirizzo"),request.getParameter("IDZ_COL_INT"),true);   
	strDES_COL_INT=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_COL_INT"),false);
	  if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}

  if(ReqMODE.equals("edt"))	{
		Long lCOD_COL_INT=new Long(c.checkLong("Collegamento ID",request.getParameter("COD_COL_INT"),true));
  	if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}
		try{
  		colint = home.findByPrimaryKey(lCOD_COL_INT);
		  colint.setIDZ_COL_INT(strIDZ_COL_INT);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
            return;
		}
	}
	if(ReqMODE.equals("new"))	{
		try{
//		  out.print("<script>alert('"+strIDZ_COL_INT+"' _ '"+lCOD_FAT_RSO+"');</script>");
//out.print("<script>alert('"+strIDZ_COL_INT+" _ "+lCOD_FAT_RSO+"');</script>");
		  colint=home.create(strIDZ_COL_INT,lCOD_FAT_RSO);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
		out.print ("<script>isNew=true;</script>");
	}
}
  if (colint!=null){
		colint.setDES_COL_INT(strDES_COL_INT);
%>	
<script language="JavaScript" type="text/javascript">
<!--
 if (parent.dialogArguments){
 	if (!err){	
		fatrso=parent.dialogArguments;
		fatrso.ID = "<%=colint.getCOD_COL_INT()%>";
		fatrso.INDEX="<%=lCOD_FAT_RSO%>";
		fatrso.indirizzo="<%=colint.getIDZ_COL_INT()%>";
		fatrso.codFATRSO="<%=lCOD_FAT_RSO%>";
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
 }else{
	if(!err){
 		if(isNew){
		  Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=colint.getCOD_COL_INT()%>");
		}else{
	     Alert.Success.showSaved();
		}
  	parent.returnValue="OK";
//	  parent.window.close();
   }else{
	  // Alert.Error.showCreated();
	 }
 }
//-->
</script>
<% } %>
