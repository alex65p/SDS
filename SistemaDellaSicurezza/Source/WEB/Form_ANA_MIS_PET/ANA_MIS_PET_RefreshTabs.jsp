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

<% /*
<file>
  <versions>	
    <version number="1.0" date="09/02/2004" author="Alex Kyba">
	      <comments>
				  <comment date="09/02/2004" author="Alex Kyba">
					   <description>Kod dlia refresha tabov</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.MisuraPreventiva.*" %>
<%@ page import="com.apconsulting.luna.ejb.TipologiaMisurePreventive.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="ANA_MIS_PET_Util.jsp"%>
<script>
	err = false;
</script>
<div id="dContent">
<%
long lCOD_AZL=Security.getAzienda();
String nameTab=new String();
String err= new String();
String str = new String();
boolean isError = false;
java.util.Collection  col;
java.util.Iterator it;
Long ID;

IMisuraPreventiva bean=null;
IMisuraPreventivaHome home=(IMisuraPreventivaHome)PseudoContext.lookup("MisuraPreventivaBean");

if (request.getParameter("ID_PARENT")!=null){
	ID = new Long(request.getParameter("ID_PARENT"));
	try{
		bean = home.findByPrimaryKey( new MisuraPreventivaPK(lCOD_AZL, ID.longValue()) );
	}
	catch(Exception ex){
		err= "Cannot find record with ID="+ID.toString();
		err+="\\n"+ex.getMessage();
		%><script>alert("<%=err%>");</script><%
		return;
	}
}
	
if  (request.getParameter("TAB_NAME")!=null){
	nameTab = request.getParameter("TAB_NAME");
}
else{
	err = "Parameter TAB_NAME not defined";
	out.print("<script>err = true</script>");
}
try{
	if (!isError && nameTab.equals("tab1")){
		str=BuildAnagraficaDocumentiTab(bean);
		out.print(str);
	}
	if (!isError && nameTab.equals("tab2")){
		str=BuildNormativeSentenzeView(bean);
		out.print(str);
	}
}	
catch(Exception ex){
		err= "Impossible rebuild tab content";
		err+="\\n"+ex.getMessage();
		%><script>alert("<%=err%>");</script><%
		return;
	}	
 %>
</div>
<script>
 if (!err){
	 parent.tabbar.ReloadTabTable(document);
}	 
</script>
