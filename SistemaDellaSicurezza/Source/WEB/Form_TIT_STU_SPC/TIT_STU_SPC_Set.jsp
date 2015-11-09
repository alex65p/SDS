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
    <version number="1.0" date="15/01/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="15/01/2004" author="Khomenko Juliya">
				   <description>Shablon formi ANA_PNO_Set.jsp</description>
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

<script>
  var err=false;
  var isNew=false;  
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/TitoliStudio/TitoliStudioBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TitoliStudio/TitoliStudioBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%
	String ReqMODE;	// parameter of request 
  ITitoliStudio bean=null;

//-----start check section--------------------------------
Checker c = new Checker();

long lCOD_TIT_STU_SPC=c.checkLong("COD_TIT_STU_SPC",request.getParameter("COD_TIT_STU_SPC"),true);
String strNOM_TIT_STU_SPC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Titolo.di.studio"),request.getParameter("NOM_TIT_STU_SPC"),true);
String strDES_TIT_STU_SPC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_TIT_STU_SPC"),true);
String strTLP_TIT_STU_SPC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Tipologia"),request.getParameter("TLP_TIT_STU_SPC"),true);
long lCOD_DPD=c.checkLong("COD_DPD",request.getParameter("COD_DPD"),true);
long lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);
//out.print("<script>err=true;alert(\""+lCOD_TIT_STU_SPC+"\");</script>");
if (c.isError){
	String err = c.printErrors();
	out.print("<script>err=true;alert(\""+err+"\");</script>");
	return;
}

ITitoliStudioHome home=(ITitoliStudioHome)PseudoContext.lookup("TitoliStudioBean");

//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
	try{		
    bean = home.findByPrimaryKey(new Long(lCOD_TIT_STU_SPC));
 		bean.setNOM_TIT_STU_SPC(strNOM_TIT_STU_SPC);
		bean.setDES_TIT_STU_SPC(strDES_TIT_STU_SPC);
		bean.setTLP_TIT_STU_SPC(strTLP_TIT_STU_SPC);
		bean.setCOD_DPD(lCOD_DPD);
		bean.setCOD_AZL(lCOD_AZL);	
	}catch(Exception ex){
		out.print("<script>Alert.Error.showDublicate();err=true;</script>");
	  return;
	}
	}
	else{
		try{
				%><script>isNew=true;</script><%
		  bean=home.create(strNOM_TIT_STU_SPC, strDES_TIT_STU_SPC, strTLP_TIT_STU_SPC, lCOD_DPD, lCOD_AZL);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}
	if(bean!=null){
	}
}
%>
<script>  //JS peremennaja vistvliemaja v true esli bila sozdana new zapis'  

 	if(!err){
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=bean.getCOD_TIT_STU_SPC()%>");
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";	
	}	
</script>
