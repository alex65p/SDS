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
    < version number="1.0" date="05/02/2004" author="Alex Kyba">		
      < comments>
			   < comment date="05/02/2004" author="Alex Kyba">
				   < description>Realizazija EJB dlia objecta MisurePreventProtettive</description>
			   < /comment>		
      < /comments> 
    < /version>
  < /versions>
< /file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_include/Checker.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/ExtendedMode.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
	String ReqMODE;	// parameter of request 
%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>var err=false; var isNew=false;</script>	
<%
IMacchina bean=null;
//-----start check section--------------------------------
Checker c = new Checker();

//
long lCOD_MAC=c.checkLong("COD_MAC",request.getParameter("COD_MAC"),true);
String strIDE_MAC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Identificativo"),request.getParameter("IDE_MAC"),true);
String strDES_MAC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_MAC"),true);
String strMDL_MAC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Modello"),request.getParameter("MDL_MAC"),true);
String strDIT_CST_MAC=c.checkString("DIT_CST_MAC",request.getParameter("DIT_CST_MAC"), true);
String strFBR_MAC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Fabbrica"),request.getParameter("FBR_MAC"), true);

long lCOD_TPL_MAC=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Tipologia"),request.getParameter("COD_TPL_MAC"),true);
String strTAR_MAC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Targa"),request.getParameter("TAR_MAC"),false);
String strPPO_MAC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Proprietario"),request.getParameter("PPO_MAC"),false);
String strMRC_MAC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Marcatura"),request.getParameter("MRC_MAC"),false);
long lYEA_CST_MAC=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Anno"),request.getParameter("YEA_CST_MAC"),false);
long lPRT_MAC=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Portata"),request.getParameter("PRT_MAC"),false);
String strCAT_MAC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Catalogazione"),request.getParameter("CAT_MAC"),false);
String strPRE_MAC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Pressione"),request.getParameter("PRE_MAC"),false);
long lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);

//if (Security.isExtendedMode()){ 
	ArrayList alAziende = ExtendedMode.getAziende(c); //EXTENDED
//}

if (c.isError){
	String err = c.printErrors();
	%><script>alert("<%=err%>");</script><%
	return;
}

IMacchinaHome home=(IMacchinaHome)PseudoContext.lookup("MacchinaBean");


//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
 try{
	ReqMODE=request.getParameter("SBM_MODE");
	out.println(ReqMODE);
	
	
	if(ReqMODE.equals("edt"))
	{
		bean = home.findByPrimaryKey(new MacchinaPK(lCOD_AZL, lCOD_MAC));
		bean.store(strIDE_MAC, strDES_MAC, strMDL_MAC, strDIT_CST_MAC, strFBR_MAC, lYEA_CST_MAC, strTAR_MAC, strPPO_MAC, strMRC_MAC, lPRT_MAC,strCAT_MAC, strPRE_MAC, lCOD_TPL_MAC, alAziende);
	}
	else{
		bean=home.create(lCOD_AZL, strIDE_MAC, strDES_MAC, strMDL_MAC, strDIT_CST_MAC, strFBR_MAC, lYEA_CST_MAC, strTAR_MAC, strPPO_MAC, strMRC_MAC, lPRT_MAC, strCAT_MAC, strPRE_MAC, lCOD_TPL_MAC, alAziende);
		lCOD_MAC=bean.getCOD_MAC();
		%>
		<script>isNew=true;</script><%
	}
  }
  catch(Exception ex){
  		%>
			<div><%=ex%></div>
			<script>err=true;</script>
		<%
                    ex.printStackTrace();
  }	
}
%>
<script>
if (!err){
	if(isNew){
   		 parent.ToolBar.OnNew("ID=<%=lCOD_MAC%>");
		 Alert.Success.showCreated();
	}else
		 Alert.Success.showSaved();
}else{
		 Alert.Error.showDublicate();
}
</script>

