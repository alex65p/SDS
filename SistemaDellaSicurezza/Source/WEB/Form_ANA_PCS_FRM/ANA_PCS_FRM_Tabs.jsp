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
    <version number="1.0" date="13/02/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="13/02/2004" author="Khomenko Juliya">
				   <description>Create SCH_ATI_MNT_Tabs.jsp</description>
				  </comment>		
        </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.PercorsiFormativi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="ANA_PCS_FRM_Util.jsp" %>
<script>
  var err=false;
//alert('<%=request.getParameter("TAB_NAME")%>');
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<div id="dContent">
<%
	long lCOD_PCS_FRM = 0;
	long lCOD_AZL = Security.getAzienda();	
	IPercorsiFormativi bean=null;
	IPercorsiFormativiHome home=(IPercorsiFormativiHome)PseudoContext.lookup("PercorsiFormativiBean");
	String strID = (String)request.getParameter("ID_PARENT");

	try{
			bean = home.findByPrimaryKey(new Long(strID));
			lCOD_PCS_FRM = bean.getCOD_PCS_FRM();
	}catch(Exception ex){
			out.print(printErrAlert("divErr", "Error.showNotFound",ex));
			return;
	}		
	try{
	 if(bean!=null){
	    if(request.getParameter("TAB_NAME").equals("tab1")){
				 out.println(PercorsiFormativiCorsiTab(home, strID));
			}
			else{
			   return;
			}
	 }
	}
	catch(Exception ex){
			out.print(printErrAlert("divErr", "Error.alert",ex));
			return;
	}
%>
</div>
<script>
 if (!err){
    parent.tabbar.ReloadTabTable(document);
 }
</script>
