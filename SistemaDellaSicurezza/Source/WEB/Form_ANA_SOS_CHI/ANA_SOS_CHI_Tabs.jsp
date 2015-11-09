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
    <version number="1.0" date="26/01/2004" author="Artur Denysenko">		
      <comments>
			   <comment date="26/01/2004" author="Artur Denysenko">
				RischioFattore
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
<%@ page import="com.apconsulting.luna.ejb.AssociativaAgentoChimico.*" %>
<%@ page import="com.apconsulting.luna.ejb.Simbolo.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/ClassificazioneAgentiChimici/ClassificazioneAgentiChimiciBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/ClassificazioneAgentiChimici/ClassificazioneAgentiChimiciBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/StatoFisico/StatoFisicoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/StatoFisico/StatoFisicoBean.jsp" %>

<%@ include file="ANA_SOS_CHI_Util.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
	var err = false;
</script>
<div id="dContent">
<%
	long lCOD_SOS_CHI = 0;
	IAssociativaAgentoChimico bean=null;
	IAssociativaAgentoChimicoHome home=(IAssociativaAgentoChimicoHome)PseudoContext.lookup("AssociativaAgentoChimicoBean");
	String strID = (String)request.getParameter("ID_PARENT");
	try{
		bean = home.findByPrimaryKey(new Long(strID));
		lCOD_SOS_CHI = bean.getCOD_SOS_CHI();
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}

try{
	if (bean!=null){	
		
		if(request.getParameter("TAB_NAME").equals("tab1")){
			out.println(BuildRischiTab(home, lCOD_SOS_CHI));
		}
		
		else if(request.getParameter("TAB_NAME").equals("tab2")){
			out.println(BuildLuoghiFisiciTab(home, lCOD_SOS_CHI));
		}
		
		else if(request.getParameter("TAB_NAME").equals("tab3")){
			out.println(BuildFrasiRTab(home, lCOD_SOS_CHI));
		}
		
		else if(request.getParameter("TAB_NAME").equals("tab4")){
			out.println(BuildFrasiSTab(home, lCOD_SOS_CHI));
		}
		
		else if(request.getParameter("TAB_NAME").equals("tab5")){
			out.println(BuildDocumentiTab(home, lCOD_SOS_CHI));
		}
		
		else if(request.getParameter("TAB_NAME").equals("tab6")){
			out.println(BuildNormSentTab(home, lCOD_SOS_CHI));
		}

		else{
			return;
		}
	}
}
catch(Exception ex){
	out.print(printErrAlert("divErr", "Error.alert", ex));
	return;
}
%>
 </div>
 
 <script>
 if (!err){
	  parent.tabbar.ReloadTabTable(document);
 }	
 </script>
