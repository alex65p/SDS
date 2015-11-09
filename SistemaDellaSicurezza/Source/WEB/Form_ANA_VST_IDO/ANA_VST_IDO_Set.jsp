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
    <version number="1.0" date="24/01/2004" author="Malyuk Sergey">
	      <comments>
				  <comment date="24/01/2004" author="Malyuk Sergey">
				   <description></description>
				 </comment>		
				  <comment date="27/02/2004" author="Alexey Kolesnik">
				   <description> Rebuild for dynamic tabbars </description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.GestioneVisiteIdoneita.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script>  
//JS peremennaja vistvliemaja v true esli bila sozdana new zapis'  
var isNew = false;
var err = false; 
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>

<%!	String ReqMODE;	// parameter of request %>
<%
IGestioneVisiteIdoneita GestioneVisiteIdoneita=null;
long lCOD_VST_IDO=0;

if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	//out.println(ReqMODE);

	Checker c = new Checker();
	//- checking for required fields		
	String	strNOM_VST_IDO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome.visita"),request.getParameter("NOM_VST_IDO"),true);   
	String	strFAT_PER = c.checkString(ApplicationConfigurator.LanguageManager.getString("Periodicità"),request.getParameter("FAT_PER"),true);
	long	lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);
	
	//- checking for not required fields		
	String strDES_VST_IDO = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_VST_IDO"),false);
	long lCOD_VST_IDO_RPO = c.checkLong("",request.getParameter("COD_VST_IDO_RPO"),false);
	long lPER_VST = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Periodicità.visita"),request.getParameter("PER_VST"),false);

	if (c.isError)
	{
		String err = c.printErrors();
		%><script>alert("<%=err%>");</script><%
		return;
	}
//=======================================================================================
IGestioneVisiteIdoneitaHome home=(IGestioneVisiteIdoneitaHome)PseudoContext.lookup("GestioneVisiteIdoneitaBean");
  if(ReqMODE.equals("edt"))
	{
		// editing of GestioneVisiteIdoneita--------------------
		String strCOD_VST_IDO=request.getParameter("VST_IDO_ID");	//ID of GestioneVisiteIdoneita
		Long vst_ido_id=new Long(strCOD_VST_IDO);
		GestioneVisiteIdoneita = home.findByPrimaryKey(vst_ido_id);
		GestioneVisiteIdoneita.setFAT_PER(strFAT_PER);
		try{
			GestioneVisiteIdoneita.setNOM_VST_IDO__COD_AZL(strNOM_VST_IDO, lCOD_AZL);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}

	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new GestioneVisiteIdoneita--------------------------
  		try{
			GestioneVisiteIdoneita=home.create(strFAT_PER, strNOM_VST_IDO, lCOD_AZL);
			%><script>isNew=true;</script><%
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
		lCOD_VST_IDO = GestioneVisiteIdoneita.getCOD_VST_IDO();
	}
//=======================================================================================
	if (GestioneVisiteIdoneita!=null){
		//*Not require Fields*
		GestioneVisiteIdoneita.setDES_VST_IDO(strDES_VST_IDO);
		GestioneVisiteIdoneita.setCOD_VST_IDO_RPO(lCOD_VST_IDO_RPO);
		GestioneVisiteIdoneita.setPER_VST(lPER_VST);
	}
}
%>
<script language="JavaScript" type="text/javascript">
if (!err){
    if(isNew){
  			Alert.Success.showCreated();
  			parent.ToolBar.OnNew("ID=<%=GestioneVisiteIdoneita.getCOD_VST_IDO()%>");
  	}else{
  			Alert.Success.showSaved();
  	}
}
</script>
