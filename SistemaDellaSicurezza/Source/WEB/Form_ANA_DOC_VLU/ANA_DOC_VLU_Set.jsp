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
<%@ page import="com.apconsulting.luna.ejb.ValutazioneRischi.*" %>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>

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
IValutazioneRischi bean=null;
//-----start check section--------------------------------
Checker c = new Checker();

long lCOD_DOC_VLU=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Valutazione.del.rischio"),request.getParameter("COD_DOC_VLU_ID"),true);
java.sql.Date dtDAT_DOC_VLU=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.documento"),request.getParameter("DAT_DOC_VLU"),true);
String strNOM_RSP_DOC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro"),request.getParameter("NOM_RSP_DOC"),false);
String strVER_DOC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Versione"),request.getParameter("VER_DOC"),true);
long lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);
long lCOD_UNI_ORG=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Unità.organizzativa"),request.getParameter("COD_UNI_ORG"),false);

if (c.isError){
	String err = c.printErrors();
	out.print("<script>alert(\""+err+"\");</script>");
	return;
}

IValutazioneRischiHome home=(IValutazioneRischiHome)PseudoContext.lookup("ValutazioneRischiBean");

//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
		bean = home.findByPrimaryKey(new Long(lCOD_DOC_VLU));
		try{		
 		bean.setDAT_DOC_VLU(dtDAT_DOC_VLU);
		bean.setVER_DOC(strVER_DOC);
		bean.setCOD_AZL(lCOD_AZL);	
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}
	else{
			try{
				%><script>isNew=true;</script><%
		bean=home.create(  dtDAT_DOC_VLU, strVER_DOC, lCOD_AZL);
				}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		    }
	}
	if(bean!=null){
 		bean.setNOM_RSP_DOC(strNOM_RSP_DOC);
		bean.setCOD_UNI_ORG(lCOD_UNI_ORG);
		
		Security.setCurrentDvrUniOrg(null);
		Security.setCurrentDvrUniOrgName(null);

		if(lCOD_UNI_ORG!=0){
			try{
				Long l=new Long(lCOD_UNI_ORG);
				IUnitaOrganizzativaHome home_uni=(IUnitaOrganizzativaHome)PseudoContext.lookup("UnitaOrganizzativaBean");
				IUnitaOrganizzativa bean_uni=home_uni.findByPrimaryKey(l);			
				Security.setCurrentDvrUniOrg(l);
				Security.setCurrentDvrUniOrgName(bean_uni.getNOM_UNI_ORG());
		
			}
			catch(Exception ex){
			}
		}
		
	}
}
%>
<script>  //JS peremennaja vistvliemaja v true esli bila sozdana new zapis'  

 	if(!err){	
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=bean.getCOD_DOC_VLU()%>");
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";	
	}	
</script>
