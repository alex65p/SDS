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
< file>
  < versions>	
    < version number="1.0" date="26/01/2004" author="Artur Denysenko">		
      < comments>
			   <comment date="26/01/2004" author="Artur Denysenko">
				   < description>Realizazija EJB dlia objecta FattoriRischio
				 <comment date="26/01/2004" author="Pogrebnoy Yura">
				   < description>Popolzovalsya EJBun v.1.0
			   < /comment>		
      < /comments> 
    < /version>
  < /versions>
< /file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.RischioFattore.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!	String ReqMODE;%>
<script>
 var err=false;
 var isNew = false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
IRischioFattore bean=null;
long lCOD_FAT_RSO=0;
//-----start check section--------------------------------
Checker c = new Checker();
String strNOM_FAT_RSO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome.fattore.di.rischio"),request.getParameter("NOM_FAT_RSO"),true);
String strDES_FAT_RSO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_FAT_RSO"),false);
long lNUM_FAT_RSO=c.checkLong(ApplicationConfigurator.LanguageManager.getString("N.Fatt.Rischio"),request.getParameter("NUM_FAT_RSO"),true);
long lCOD_CAG_FAT_RSO=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Nome.categoria"),request.getParameter("NOM_CAG_FAT_RSO"),true);
long lCOD_NOR_SEN=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dati.normativa.di.riferimento"),request.getParameter("COD_NOR_SEN"),false);
if (c.isError){
	String err = c.printErrors();
	out.print("<script>alert(\""+err+"\");</script>");
	return;
}

IRischioFattoreHome home=(IRischioFattoreHome)PseudoContext.lookup("RischioFattoreBean");
if(request.getParameter("SBM_MODE")!=null){
	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))	{
 	 lCOD_FAT_RSO=c.checkLong("COD_FAT_RSO",request.getParameter("COD_FAT_RSO"),true);
	 if (c.isError){
	  String err = c.printErrors();
	  out.print("<script>alert(\""+err+"\");</script>");
	  return;
   }
		bean = home.findByPrimaryKey(new Long(lCOD_FAT_RSO));
		try{
			bean.setNOM_FAT_RSO(strNOM_FAT_RSO);
		  bean.setCOD_CAG_FAT_RSO(lCOD_CAG_FAT_RSO);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
 		
		bean.setNUM_FAT_RSO(lNUM_FAT_RSO);

	}
	if(ReqMODE.equals("new")){
	 try{
		 bean=home.create(strNOM_FAT_RSO,lNUM_FAT_RSO,lCOD_CAG_FAT_RSO);
	 }catch(Exception ex){
		 out.print("<script>Alert.Error.showDublicate();err=true;</script>");
		 return;
	 }
		out.print ("<script>isNew=true;</script>");
	}
	if(bean!=null){
 		bean.setDES_FAT_RSO(strDES_FAT_RSO);
		bean.setCOD_NOR_SEN(lCOD_NOR_SEN);
	}
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
			parent.ToolBar.OnNew("ID=<%=bean.getCOD_FAT_RSO()%>");
		}else{
	     Alert.Success.showSaved();
		}
  	parent.returnValue="OK";
//	  parent.window.close();
   }else{
//	  Alert.Error.showCreated();
	 }
 }
//-->
</script>
