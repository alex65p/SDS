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
    <version number="1.0" date="24/01/2004" author="Mike Kondratyuk">
	      <comments>
				  <comment date="05/02/2004" author="Malyuk Sergey">
				   <description>added for tabs in ana_pro_san_tab</description>
				 </comment>		
				  <comment date="27/02/2004" author="Alexey Kolesnik">
				   <description>Rebuild for dynamic tabbars</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%> 	
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.GestioneVisiteMediche.*" %>
<%@ page import="com.apconsulting.luna.ejb.ProtocoleSanitare.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%! String ReqMODE;	// parameter of request %>
<script>
  var err=false;
  var isNew=false;  
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
IGestioneVisiteMediche GestioneVisiteMediche=null;
long lCOD_VST_MED=0;
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	Checker c = new Checker();
	//- checking for required fields		
	String	strNOM_VST_MED=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome.visita"),request.getParameter("NOM_VST_MED"),true);   
	String	strFAT_PER = c.checkString(ApplicationConfigurator.LanguageManager.getString("Periodicità"),request.getParameter("FAT_PER"),true);
	long	lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);
	//- checking for not required fields		
	String strDES_VST_MED = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_VST_MED"),false);
	long lCOD_VST_MED_RPO = c.checkLong("",request.getParameter("COD_VST_MED_RPO"),false);
	long lPER_VST = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Periodicità.visita"),request.getParameter("PER_VST"),false);
	if (c.isError)
	{
		String err = c.printErrors();
		%><script>alert("<%=err%>");</script><%
		return;
	}
//=======================================================================================
  if(ReqMODE.equals("edt"))
	{
		// editing of GestioneVisiteMediche--------------------
		// gettinf of object 
		String strCOD_VST_MED=request.getParameter("VST_MED_ID");					//ID of GestioneVisiteMediche
		IGestioneVisiteMedicheHome home=(IGestioneVisiteMedicheHome)PseudoContext.lookup("GestioneVisiteMedicheBean");
		Long tpl_cor_id=new Long(strCOD_VST_MED);
		GestioneVisiteMediche = home.findByPrimaryKey(tpl_cor_id);
		GestioneVisiteMediche.setFAT_PER(strFAT_PER);
		try{
			GestioneVisiteMediche.setNOM_VST_MED__COD_AZL(strNOM_VST_MED, lCOD_AZL);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}

	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new GestioneVisiteMediche--------------------------
	// creating of object 
		IGestioneVisiteMedicheHome home=(IGestioneVisiteMedicheHome)PseudoContext.lookup("GestioneVisiteMedicheBean");
		try{
			GestioneVisiteMediche=home.create(strFAT_PER, strNOM_VST_MED, lCOD_AZL);
			%><script>isNew=true;</script><%
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
		lCOD_VST_MED = GestioneVisiteMediche.getCOD_VST_MED();
	}
//=======================================================================================
	if (GestioneVisiteMediche!=null){
		//*Not require Fields*
		GestioneVisiteMediche.setDES_VST_MED(strDES_VST_MED);
		GestioneVisiteMediche.setCOD_VST_MED_RPO(lCOD_VST_MED_RPO);
		GestioneVisiteMediche.setPER_VST(lPER_VST);
	}
}
%>
<script language="JavaScript" type="text/javascript">
if (!err){
    if(isNew){
  		Alert.Success.showCreated();
  		parent.ToolBar.OnNew("ID=<%=GestioneVisiteMediche.getCOD_VST_MED()%>");
  	}else{
  		Alert.Success.showSaved();
  	}
}
</script>
