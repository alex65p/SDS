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
    <version number="1.0" date="19/02/2004" author="Mike Kondratyuk">		
      <comments>
			   <comment date="19/02/2004" author="Mike Kondratyuk">
				   <description>Realizazija EJB dlia objecta DipendenteConsegneDPI
			   </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteConsegneDPI/DipendenteConsegneDPIBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteConsegneDPI/DipendenteConsegneDPIBean.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%!
	String ReqMODE;	// parameter of request 
%>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
 var isNew = false;
 var err=false;
</script>

<%
IDipendenteConsegneDPI DipendenteConsegneDPI=null;
long lCOD=0;
//-----start check section--------------------------------
Checker c = new Checker();
long lCOD_CSG_DPI=c.checkLong("COD_CSG_DPI",request.getParameter("COD_CSG_DPI"),true);
long lCOD_DPD=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Lavoratore"),request.getParameter("COD_DPD"),true);
java.sql.Date dtDAT_CSG_DPI=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.consegna"),request.getParameter("DAT_CSG_DPI"),true);
String strNOM_RSP_CSG_DPI=c.checkString(ApplicationConfigurator.LanguageManager.getString("Responsabile"),request.getParameter("NOM_RSP_CSG_DPI"),true);
String strEFT_CSG_SCH_DPI=c.checkString(ApplicationConfigurator.LanguageManager.getString("Scheda.D.P.I.consegnata"),request.getParameter("EFT_CSG_SCH_DPI"),true);
long lQTA_CSG=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Quantità.consegnata.in.pezzi"),request.getParameter("QTA_CSG"),true);
String strTPL_CSG=c.checkString(ApplicationConfigurator.LanguageManager.getString("Tipo.consegna"),request.getParameter("TPL_CSG"),true);
long lCOD_LOT_DPI=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Lotto"),request.getParameter("COD_LOT_DPI"),true);
long lCOD_TPL_DPI=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Tipologia.D.P.I."),request.getParameter("COD_TPL_DPI"),true);
//long lCOD_AZL=c.checkLong("COD_AZL",request.getParameter("COD_AZL"),true);
out.println(lCOD_DPD+"COD_DPD");

//azienda--
 IAzienda azienda=null;
 IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");
long  lCOD_AZL=Security.getAzienda();
out.println(lCOD_AZL+"COD_AZL");
//---------


if (c.isError){
	String err = c.printErrors();
	out.print("<script>err=true;alert(\""+err+"\");</script>");
	return;
}
try{
IDipendenteConsegneDPIHome home=(IDipendenteConsegneDPIHome)PseudoContext.lookup("DipendenteConsegneDPIBean");
//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
	
		DipendenteConsegneDPI = home.findByPrimaryKey(new Long(lCOD_CSG_DPI));

 		DipendenteConsegneDPI.setCOD_DPD(lCOD_DPD);
		DipendenteConsegneDPI.setDAT_CSG_DPI(dtDAT_CSG_DPI);
		DipendenteConsegneDPI.setNOM_RSP_CSG_DPI(strNOM_RSP_CSG_DPI);
		DipendenteConsegneDPI.setEFT_CSG_SCH_DPI(strEFT_CSG_SCH_DPI);
		DipendenteConsegneDPI.setQTA_CSG(lQTA_CSG);
		DipendenteConsegneDPI.setTPL_CSG(strTPL_CSG);
		DipendenteConsegneDPI.setCOD_LOT_DPI(lCOD_LOT_DPI);
		DipendenteConsegneDPI.setCOD_TPL_DPI(lCOD_TPL_DPI);
		DipendenteConsegneDPI.setCOD_AZL(lCOD_AZL);	
 	}
	else{
	
		DipendenteConsegneDPI=home.create(lCOD_DPD, dtDAT_CSG_DPI, strNOM_RSP_CSG_DPI, strEFT_CSG_SCH_DPI, lQTA_CSG, strTPL_CSG, lCOD_LOT_DPI, lCOD_TPL_DPI, lCOD_AZL);
		%>
		<script>isNew=true;</script>
		<%	
		lCOD=DipendenteConsegneDPI.getCOD_CSG_DPI();
	}
	if(DipendenteConsegneDPI!=null){

	}
	else{	throw new Exception("Invalid operation");}
}
}catch(Exception ex){
%>
		<div id="divErr">
			<%=ex.getMessage()%>
		</div>
		<script>err=true;</script>
<%
}
%>
<script>
 if (!err){  
 						 if(isNew) {Alert.Success.showCreated();
						 					 parent.ToolBar.OnNew("ID=<%=lCOD%>");
						 }
						 else
						 {Alert.Success.showSaved(); }
					}
					else
					{
					alert(divErr.innerText);
					}
</script>
