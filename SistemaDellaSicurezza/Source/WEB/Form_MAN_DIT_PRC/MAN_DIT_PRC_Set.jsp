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
    <version number="1.0" date="23/02/2004" author="Artur Denysenko">		
      <comments>
			   <comment date="23/02/2004" author="Artur Denysenko">
				   <description>Realizazija EJB dlia objecta MansioneDittePrecedente
			   </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>


<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<script src="../_scripts/Alert.js"></script>

<%@ include file="../src/com/apconsulting/luna/ejb/MansioneDittePrecedente/MansioneDittePrecedenteBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/MansioneDittePrecedente/MansioneDittePrecedenteBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%!
	String ReqMODE;	// parameter of request 
%>

<script>
var err=false;
var isNew=false;
</script>

<%
IMansioneDittePrecedente bean=null;
//-----start check section--------------------------------
Checker c = new Checker();

long lCOD_MAN_DIT_PRC=c.checkLong("COD Mansione Ditte Precedente",request.getParameter("COD_MAN_DIT_PRC"),true);
String strNOM_MAN_DIT_PRC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Mansione"),request.getParameter("NOM_MAN_DIT_PRC"),true);
String strDES_MAN_DIT_PRC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_MAN_DIT_PRC"),false);
long lCOD_DIT_PRC_DPD=c.checkLong("COD Ditte Precedente",request.getParameter("COD_DIT_PRC_DPD"),true);
long lCOD_DPD=c.checkLong("COD Dipendente",request.getParameter("COD_DPD"),true);
long lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);

if (c.isError){
	String err = c.printErrors();
	out.print("<script>err=true;alert(\""+err+"\");</script>");
	return;
}

IMansioneDittePrecedenteHome home=(IMansioneDittePrecedenteHome)PseudoContext.lookup("MansioneDittePrecedenteBean");

//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
		bean = home.findByPrimaryKey(new Long(lCOD_MAN_DIT_PRC));
		
		try{
		  bean.setNOM_MAN_DIT_PRC__COD_DIT_PRC_DPD__COD_DPD(strNOM_MAN_DIT_PRC, lCOD_DIT_PRC_DPD, lCOD_DPD);
		}
		catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
		bean.setCOD_AZL(lCOD_AZL);	
	}
	else{
	  out.print("<script>isNew=true;</script>");
		try{
			bean=home.create(  strNOM_MAN_DIT_PRC, lCOD_DIT_PRC_DPD, lCOD_DPD, lCOD_AZL);
		}
		catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}
	if(bean!=null){
 		bean.setDES_MAN_DIT_PRC(strDES_MAN_DIT_PRC);
	}
}
%>
<script>
if (!err){
	if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=bean.getCOD_MAN_DIT_PRC()%>");
		}else{
			Alert.Success.showSaved();
		}
}
</script>
