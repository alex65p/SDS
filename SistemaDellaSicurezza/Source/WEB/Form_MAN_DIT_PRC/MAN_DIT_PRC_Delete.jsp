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
    <version number="1.0" date="24/02/2004" author="Treskina Maria">
	      <comments>
				  <comment date="24/02/2004" author="Treskina Maria">
				   <description>ydalenie iz MAN_DIT_PRC - MansioneDittePrecedente</description>
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

<%@ include file="../src/com/apconsulting/luna/ejb/MansioneDittePrecedente/MansioneDittePrecedenteBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/MansioneDittePrecedente/MansioneDittePrecedenteBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script>
	var err=false;
	var errDescr;
	var tab=false;
</script>
<%
IMansioneDittePrecedente MD=null;
IMansioneDittePrecedenteHome mdHome=(IMansioneDittePrecedenteHome)PseudoContext.lookup("MansioneDittePrecedenteBean");

if (request.getParameter("TAB")!="") out.print("<script>tab=true;</script>");
String IDD=request.getParameter("LOCAL_MODE");//Add by Podmasteriev
if(request.getParameter("ID")!=null)
{	
	//
	String ID_TO_DEL=request.getParameter("ID");

	Long md_id=new Long(ID_TO_DEL);
	try{
		mdHome.remove(md_id);
	}catch(Exception ex){
		out.print("<script>err=true; errDescr = '"+ex.getMessage()+"'</script>");
		return;
	}

}
else{
//		out.print("<script>err=true; errDescr = 'Can not find ID of mansione dite precedente'</script>");
}	
%>


<script>
var IDD="<%=IDD%>";	
		if (!err){
		  if (IDD!="null") 
				 {
				  parent.del_localRow();
				 }
			else{
			    parent.g_Handler.OnRefresh();	
					}		
			Alert.Success.showDeleted();
			}
		else{
 			Alert.Error.showDelete();
 	}
/*if (err)   //commented by Podmasteriev
	 {  
	 	Alert.Error.showDelete();//alert(divErr.innerText);
	 }
		else{
	Alert.Success.showDeleted();
	parent.g_Handler.OnRefresh();
}*/
</script>
