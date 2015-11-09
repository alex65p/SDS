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
    <version number="1.0" date="13/02/2004" author="Pogrebnoy Yura">
	      <comments>
				  <comment date="13/02/2004" author="Pogrebnoy Yura">
				   <description>Shablon formi SOS_CHI_LUO_FSC_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.AssociativaAgentoChimico.*" %>

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
<%!	String ReqMODE;	%>
<%
ReqMODE=request.getParameter("SBM_MODE");
IAssociativaAgentoChimico chim=null;
IAssociativaAgentoChimicoHome home=(IAssociativaAgentoChimicoHome)PseudoContext.lookup("AssociativaAgentoChimicoBean");
	Checker c = new Checker();
	long lQTA_GIA=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Quantità.in.giacenza"),request.getParameter("QTA_GIA"),true);   
	long lQTA_USO=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Quantità.in.uso"),request.getParameter("QTA_USO"),true);
	String strTPL_QTA=c.checkString(ApplicationConfigurator.LanguageManager.getString("Tipologia"),request.getParameter("TPL_QTA"),true);
	long lCOD_LUO_FSC=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Luogo.fisico"),request.getParameter("NB_NOM_LUO_FSC"),true);
 	long lCOD_SOS_CHI=c.checkLong("COD_SOS_CHI",request.getParameter("COD_SOS_CHI"),true);
	 if (c.isError){
		 String err = c.printErrors();
		 out.println("<script>alert(\""+err+"\");</script>");
		 return;
	 }
   chim=home.findByPrimaryKey(new Long(lCOD_SOS_CHI));
	 if(ReqMODE.equals("edt")){
	   try{
		   chim.editSOS_CHI_LUO_FSC(lCOD_LUO_FSC,lQTA_GIA,lQTA_USO,strTPL_QTA);
		 }catch(Exception ex){
		   out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		 }
	 }
	 if(ReqMODE.equals("new")){
	  try{
		 chim.addSOS_CHI_LUO_FSC(lCOD_LUO_FSC,lQTA_GIA,lQTA_USO,strTPL_QTA);
	  }catch(Exception ex){
		 out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
	  }
		out.print("<script>isNew=true;</script>");
	 }
%>	
<script>
<!--
 if (parent.dialogArguments){
 	if (!err){	
//		fatrso=parent.dialogArguments;
//		fatrso.ID = "< %=colint.getCOD_COL_INT()%>";
//		fatrso.INDEX="< %=lCOD_FAT_RSO%>";
//		fatrso.indirizzo="< %=colint.getIDZ_COL_INT()%>";
//		fatrso.codFATRSO="< %=lCOD_FAT_RSO%>";
		parent.returnValue="OK";
	  Alert.Success.showCreated();
		parent.ToolBar.Return.OnClick();
	}else{
		   parent.returnValue="ERROR";	
	}	
 }else{
   if(!err){
 		if(isNew){
		  Alert.Success.showCreated();
//			parent.ToolBar.OnNew("ID=< %=lCOD_SOS_CHI%>");
		}else{
	     Alert.Success.showSaved();
		}
  	parent.returnValue="OK";
//	  parent.window.close();
//   }else{
//	  Alert.Error.showCreated();
	 }
 }
//-->
</script>
