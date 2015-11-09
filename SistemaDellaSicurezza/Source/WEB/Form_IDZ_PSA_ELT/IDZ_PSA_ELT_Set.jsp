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
    < version number="1.0" date="29/01/2004" author="Artur Denysenko">		
      < comments>
			   < comment date="29/01/2004" author="Artur Denysenko">
				   < description>Realizazija EJB dlia objecta IndirizzoPostaElettronica
			   < /comment>		
      < /comments> 
    < /version>
  < /versions>
< /file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.IndirizzoPostaElettronica.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
	String ReqMODE;	// parameter of request 
%>
<script language="JavaScript" type="text/javascript">
<!--
		var err=false;
		var isNew = false;
//-->
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
IIndirizzoPostaElettronica bean=null;
IIndirizzoPostaElettronicaHome home=(IIndirizzoPostaElettronicaHome)PseudoContext.lookup("IndirizzoPostaElettronicaBean");
	long lCOD_FAT_RSO = 0;
	String strDES_IDZ_PSA_ELT="";
	String strCOD_FAT_RSO = request.getParameter("ID_PARENT");
	if (strCOD_FAT_RSO!=null && !strCOD_FAT_RSO.equals("") && !strCOD_FAT_RSO.equals("null")){
		lCOD_FAT_RSO = new Long (request.getParameter("ID_PARENT")).longValue();
	}

if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	Checker c = new Checker();

  String strIDZ_PSA_ELT=c.checkString(ApplicationConfigurator.LanguageManager.getString("Indirizzo"),request.getParameter("IDZ_PSA_ELT"),true);
  strDES_IDZ_PSA_ELT=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_IDZ_PSA_ELT"),false);
  if (c.isError){
	  String err = c.printErrors();
	  out.print("<script>alert(\""+err+"\");</script>");
	  return;
  }

	if(ReqMODE.equals("edt")){
	  long lCOD_IDZ_PSA_ELT=c.checkLong("COD_IDZ_PSA_ELT",request.getParameter("COD_IDZ_PSA_ELT"),true);
		if (c.isError){
	    String err = c.printErrors();
	    out.print("<script>alert(\""+err+"\");< /script>");
	    return;
    }
		
		bean = home.findByPrimaryKey(new Long(lCOD_IDZ_PSA_ELT));
 		try{
		  bean.setIDZ_PSA_ELT(strIDZ_PSA_ELT);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}
	else{
	  try{
		  bean=home.create(strIDZ_PSA_ELT,lCOD_FAT_RSO);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
		out.print ("<script>isNew=true;</script>");
	}
	
}
if(bean!=null){
 		bean.setDES_IDZ_PSA_ELT(strDES_IDZ_PSA_ELT);
%>
<script language="JavaScript" type="text/javascript">
<!--
 if (parent.dialogArguments){
 	if (!err){	
		fatrso=parent.dialogArguments;
		fatrso.ID = "<%=bean.getCOD_IDZ_PSA_ELT()%>";
		fatrso.INDEX="<%=lCOD_FAT_RSO%>";
		fatrso.indirizzo="<%=bean.getIDZ_PSA_ELT()%>";
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
			parent.ToolBar.OnNew("ID=<%=bean.getCOD_IDZ_PSA_ELT()%>");
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
<%}%>
