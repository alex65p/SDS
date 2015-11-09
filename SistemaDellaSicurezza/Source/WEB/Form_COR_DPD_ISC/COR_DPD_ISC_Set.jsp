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
    <version number="1.0" date="23/03/2004" author="Pogrebnoy Yura">
      <comments>
			   <comment date="23/03/2004" author="Pogrebnoy Yura">
				   <description>COR_DPD_ISC_Set.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.DipendenteCorsi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>var err = false;</script>
<%
	IDipendenteCorsiHome home = (IDipendenteCorsiHome)PseudoContext.lookup("DipendenteCorsiBean");
	String strCOD_DPD = "";
	long lCOD_DPD = 0;
	String strCOD_SCH_EGZ_COR ="";
	long lCOD_SCH_EGZ_COR = 0;
	long lCOD_AZL = Security.getAzienda();
	
	long count = new Long(request.getParameter("count")).longValue();
	if (count > 0){
	 try{
	  for (long i=1; i<count; i++){
		  strCOD_DPD = Formatter.format(request.getParameter("COD_DPD"+i));
			if ( !"".equals(strCOD_DPD) ){
			  lCOD_DPD = new Long (strCOD_DPD).longValue();
				strCOD_SCH_EGZ_COR = Formatter.format(request.getParameter("COD_SCH_EGZ_COR"+i));
				lCOD_SCH_EGZ_COR = new Long (strCOD_SCH_EGZ_COR).longValue();
				home.addCOR_DPD_ISC(lCOD_DPD, lCOD_SCH_EGZ_COR, lCOD_AZL);
			}
		}
	 }catch(Exception ex){
		 out.print("<script>Alert.Error.showDublicate();err=true;</script>");
     out.print("err= "+ex);
	 }
	}
%>
<script>
if (!err){
    Alert.Success.showSaved();
	parent.returnValue="OK";
}else{parent.returnValue="ERROR";}
</script>
