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
    <version number="1.0" date="30/01/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="30/01/2004" author="Khomenko Juliya">
				   <description></description>
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
<%@ page import="com.apconsulting.luna.ejb.Presidi.*" %>
<%@ page import="com.apconsulting.luna.ejb.SchedeInterventoPSD.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

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
IPresidi bean=null;
ISchedeInterventoPSD PSDbean=null;
//-----start check section--------------------------------
Checker c = new Checker();

long lCOD_PSD_ACD=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dati.presidio"),request.getParameter("PSD_ACD_ID"),true);
long lCOD_CAG_PSD_ACD=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Categoria"),request.getParameter("CATEGORIA"),true);
String strIDE_PSD_ACD=c.checkString(ApplicationConfigurator.LanguageManager.getString("Identificatore"),request.getParameter("IDENTIFICATORE"),true);
java.sql.Date dtDAT_ULT_CTL=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.ultimo.controllo"),request.getParameter("DATA"),false);
String strESI_ULT_CTL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Esito.ultimo.controllo"),request.getParameter("ESITO"),false);
long lCOD_LUO_FSC=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Luogo.fisico"),request.getParameter("LUOGO"),true);
String strSTA_PSD_ACD=c.checkString(ApplicationConfigurator.LanguageManager.getString("Stato"),request.getParameter("STATO"),true);
java.util.Date cdt=new java.util.Date();
java.sql.Date dtDAT_INZ = new java.sql.Date(cdt.getYear(),cdt.getMonth(),cdt.getDate());
if (c.isError){
	String err = c.printErrors();
	out.print("<script>alert(\""+err+"\");</script>");
	return;
}

IPresidiHome home=(IPresidiHome)PseudoContext.lookup("PresidiBean");

ISchedeInterventoPSDHome PSDhome=(ISchedeInterventoPSDHome)PseudoContext.lookup("SchedeInterventoPSDBean");

//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
		bean = home.findByPrimaryKey(new Long(lCOD_PSD_ACD));
		try{	
 		bean.setCOD_CAG_PSD_ACD(lCOD_CAG_PSD_ACD);
		bean.setIDE_PSD_ACD(strIDE_PSD_ACD);
		bean.setCOD_LUO_FSC(lCOD_LUO_FSC);
		bean.setSTA_PSD_ACD(strSTA_PSD_ACD);	
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}		
	}
	else{	
			try{
				%><script>isNew=true;</script><%
		bean=home.create(  lCOD_CAG_PSD_ACD, strIDE_PSD_ACD, lCOD_LUO_FSC, strSTA_PSD_ACD);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
		String strM="M";
		String strS="S";
		out.print("<script>parent.alert(arraylng[\"MSG_0046\"]);</script>");
		PSDbean=PSDhome.create(bean.getCOD_PSD_ACD(),strM,dtDAT_INZ);
		PSDbean=PSDhome.create(bean.getCOD_PSD_ACD(),strS,dtDAT_INZ);
	}
	if(bean!=null){
 		bean.setDAT_ULT_CTL(dtDAT_ULT_CTL);
		bean.setESI_ULT_CTL(strESI_ULT_CTL);
	}
}
%>
<script>  //JS peremennaja vistvliemaja v true esli bila sozdana new zapis'  

 	if(!err){	
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=bean.getCOD_PSD_ACD()%>");
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";	
	}	
</script>
