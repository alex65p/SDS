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
    <version number="1.0" date="17/02/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="17/02/2004" author="Khomenko Juliya">
				   <description>Create ANA_ATI_MNT_MAC_Tabs.jsp</description>
				  </comment>		
        </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>
<%@ page import="com.apconsulting.luna.ejb.AttivaManutenzione.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="ANA_ATI_MNT_MAC_Util.jsp" %>
<script>
  var err=false;
//alert('<%=request.getParameter("TAB_NAME")%>');
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<div id="dContent">
<%
	long lCOD_MAC=0;
	long lCOD_MNT_MAC=0;

	IAttivaManutenzione bean=null;
	
	String strID = (String)request.getParameter("ID_PARENT");
	IAttivaManutenzioneHome home=(IAttivaManutenzioneHome)PseudoContext.lookup("AttivaManutenzioneBean");
	try{
			bean = home.findByPrimaryKey(new Long(strID));
			lCOD_MAC = bean.getCOD_MAC();
			lCOD_MNT_MAC = bean.getCOD_MNT_MAC();
			
	}catch(Exception ex){
			ex.printStackTrace();
                        out.print(printErrAlert("divErr", "Error.showNotFound",ex));
			return;
	}		
	try{
	 if(bean!=null){
	    if(request.getParameter("TAB_NAME").equals("tab1")){
				 out.println(BuildResTab(home,lCOD_MAC, lCOD_MNT_MAC));
			}
			else{
			   return;
			}
	 }
	}
	catch(Exception ex){
                        ex.printStackTrace();
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
