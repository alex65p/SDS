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
    < version number="1.0" date="20/02/2004" author="Treskina Mary">		
      < comments>
			   < comment date="20/02/2004" author="Treskina Mary">
				   < description>zanesenie dannih v db
			   < /comment>		
      < /comments> 
    < /version>
  < /versions>
< /file> 
*/
%>


<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/DipendentePrecedenti/DipendentePrecedentiBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DipendentePrecedenti/DipendentePrecedentiBean.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
	String ReqMODE;	// parameter of request 
%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
var err=false;
var isNew=false;
</script>

<%
IDipendentePrecedenti bean=null;
//-----start check section--------------------------------
Checker c = new Checker();

long lCOD_DIT_PRC_DPD=c.checkLong("COD_DIT_PRC_DPD",request.getParameter("COD_DIT_PRC_DPD"),true);
String strDES_ATI_SVO_DIT_PRC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Attività.svolta"),request.getParameter("DES_ATI_SVO_DIT_PRC"),false);
String strRAG_SCL_DIT_PRC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Ragione.sociale"),request.getParameter("RAG_SCL_DIT_PRC"),true);
String strIDZ_DIT_PRC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Indirizzo"),request.getParameter("IDZ_DIT_PRC"),false);
String strNUM_CIC_DIT_PRC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Numero.civico"),request.getParameter("NUM_CIC_DIT_PRC"),false);
String strCIT_DIT_PRC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Città"),request.getParameter("CIT_DIT_PRC"),false);
String strPRV_DIT_PRC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Provincia"),request.getParameter("PRV_DIT_PRC"),false);
String strCAP_DIT_PRC=c.checkString(ApplicationConfigurator.LanguageManager.getString("C.a.p."),request.getParameter("CAP_DIT_PRC"),false);
String strSTA_DIT_PRC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Stato"),request.getParameter("STA_DIT_PRC"),false);
long lCOD_DPD=c.checkLong("COD Dipendente",request.getParameter("COD_DPD"),true);
long lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);

if (c.isError){
	String err = c.printErrors();
	out.print("<script>err=true;alert(\""+err+"\");</script>");
	return;
}



IDipendentePrecedentiHome home=(IDipendentePrecedentiHome)PseudoContext.lookup("DipendentePrecedentiBean");


//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
out.println("lCOD_DPD="+lCOD_DPD+"<br>lCOD_AZL="+lCOD_AZL);

	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
		bean = home.findByPrimaryKey(new Long(lCOD_DIT_PRC_DPD));
		
		try{
			bean.setRAG_SCL_DIT_PRC__COD_DPD(strRAG_SCL_DIT_PRC, lCOD_DPD);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
		bean.setCOD_AZL(lCOD_AZL);	
	}	else{
	  out.println("<script>isNew=true;</script>");
		try{
			bean=home.create(  strRAG_SCL_DIT_PRC, lCOD_DPD, lCOD_AZL);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
		
	}
	
	if(bean!=null){
 		bean.setDES_ATI_SVO_DIT_PRC(strDES_ATI_SVO_DIT_PRC);
		bean.setIDZ_DIT_PRC(strIDZ_DIT_PRC);
		bean.setNUM_CIC_DIT_PRC(strNUM_CIC_DIT_PRC);
		bean.setCIT_DIT_PRC(strCIT_DIT_PRC);
		bean.setPRV_DIT_PRC(strPRV_DIT_PRC);
		bean.setCAP_DIT_PRC(strCAP_DIT_PRC);
		bean.setSTA_DIT_PRC(strSTA_DIT_PRC);
	}
}
%>
<script>
if (!err){
	if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=bean.getCOD_DIT_PRC_DPD()%>");
		}else{
			Alert.Success.showSaved();
		}
}
</script>
