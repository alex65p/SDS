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
    <version number="1.0" date="09/02/2004" author="Malyuk Sergey">		
      <comments>
			   <comment date="09/02/2004" author="Malyuk Sergey">
				   <description>Realizazija EJB dlia objecta CartelleSanitarie
			   </comment>
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.CartelleSanitarie.*" %>

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
//-----start check section--------------------------------
Checker c = new Checker();
Long lCOD_CTL_SAN=new Long(request.getParameter("COD_CTL_SAN"));
Long lCOD_AZL=new Long(request.getParameter("COD_AZL"));
Long lCOD_DPD=new Long(request.getParameter("COD_DPD"));
long lCOD_VST_IDO=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Nome"),request.getParameter("COD_VST_IDO"),true);

java.sql.Date dtDAT_PIF_VST=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificazione.visita"),request.getParameter("DAT_PIF_VST"),true);;
java.sql.Date dtDAT_EFT_VST=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.svolgimento.visita"),request.getParameter("DAT_EFT_VST"),false);
String strIDO_VST=c.checkString(ApplicationConfigurator.LanguageManager.getString("Idoneità"),request.getParameter("IDO_VST"),false);
String strTPL_ACR_VLU_MED=c.checkString(ApplicationConfigurator.LanguageManager.getString("Tipo.di.accertamento.effettuato"),request.getParameter("TPL_ACR_VLU_MED"),false);
String strTPL_ACR_VLU_RSO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Tipo.di.accertamento.della.valutazione.del.rischio"),request.getParameter("TPL_ACR_VLU_RSO"),true);
String strTPL_ACR_EFT=c.checkString("TPL_ACR_EFT",request.getParameter("TPL_ACR_EFT"),true);
String strNOT_VST_IDO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Note"),request.getParameter("NOT_VST_IDO"),false);

if (request.getParameter("DAT_PIF_VST")==null)
	 {dtDAT_PIF_VST=null;}

if (c.isError)
	 {
	  String err = c.printErrors();
	  out.print("<script>alert(\""+err+"\");</script>");
	  return;
	 }
ICartelleSanitarie bean=null;
ICartelleSanitarieHome home=(ICartelleSanitarieHome)PseudoContext.lookup("CartelleSanitarieBean");
bean = home.findByPrimaryKey(lCOD_CTL_SAN);
if (dtDAT_EFT_VST!=null)
	 {
         /*
    if (dtDAT_PIF_VST.compareTo(dtDAT_EFT_VST)!=-1)
            {
            out.print("<script>alert(arraylng[\"MSG_0087\"]);</script>");
            return;
            }
            */
	 }
//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	out.print(ReqMODE);
	if(ReqMODE.equals("edt"))
	{
	try
		{
	long oldCOD_VST_IDO=c.checkLong("COD_VST_IDO",request.getParameter("oldCOD_VST_IDO"),false);
    java.sql.Date oldDAT_PIF_VST=c.checkDate("DAT_PIF_VST",request.getParameter("oldDAT_PIF_VST"),false);

	bean.editCOD_VST_IDO(oldCOD_VST_IDO,lCOD_VST_IDO,dtDAT_PIF_VST,dtDAT_EFT_VST,strTPL_ACR_VLU_RSO,strTPL_ACR_VLU_MED,strTPL_ACR_EFT,strIDO_VST,strNOT_VST_IDO,oldDAT_PIF_VST);
//	bean.addCOD_VST_IDO(lCOD_VST_IDO,dtDAT_PIF_VST,dtDAT_EFT_VST,strTPL_ACR_VLU_RSO,strTPL_ACR_VLU_MED,strTPL_ACR_EFT,strIDO_VST,strNOT_VST_IDO);	
	//bean.removeCOD_VST_IDO(oldCOD_VST_IDO);
	}catch(Exception ex){
						out.print("<script>err=true;</script>");
						}
	}
	else
	{
	%><script>isNew=true;</script><%
		try
		{
		bean.addCOD_VST_IDO(lCOD_VST_IDO,dtDAT_PIF_VST,dtDAT_EFT_VST,strTPL_ACR_VLU_RSO,strTPL_ACR_VLU_MED,strTPL_ACR_EFT,strIDO_VST,strNOT_VST_IDO);
		}catch(Exception ex){
						out.print("<script>err=true;</script>");
						}
	}
}
%>
<script>
if (!err)
	 {	
		if (isNew)
			 {
			 	Alert.Success.showCreated();
				parent.ToolBar.OnNew('ID=<%=lCOD_VST_IDO%>'); 
			 }else
			 {
				Alert.Success.showSaved();
			 }
	}else
	{
 	 Alert.Error.showDublicate();
	}	
</script> 
