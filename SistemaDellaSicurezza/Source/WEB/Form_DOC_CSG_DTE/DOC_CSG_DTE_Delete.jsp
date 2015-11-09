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
    <version number="1.0" date="30/01/2004" author="Roman Chumachenko">
	      <comments>
				  <comment date="30/01/2004" author="Roman Chumachenko">
				   <description>DOC_CSG_DTE_Delete.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.DittaEsterna.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
	var err=false;
</script>
<%
IDittaEsterna ditta_esterna=null;
IDittaEsternaHome deHome=(IDittaEsternaHome)PseudoContext.lookup("DittaEsternaBean");
if( (request.getParameter("ID")!=null)&&(request.getParameter("ID_PARENT")!=null) )
{	
	//
	String strCOD_DTE=request.getParameter("ID_PARENT");
	String strCOD_DOC=request.getParameter("ID");
		out.print("COD_DTE:"+strCOD_DTE+"<br>");
		out.print("COD_DOC:"+strCOD_DOC+"<br>");
	Long COD_DTE=new Long(strCOD_DTE);
	Long COD_DOC=new Long(strCOD_DOC);
	try{
		ditta_esterna=deHome.findByPrimaryKey(COD_DTE);
		ditta_esterna.removeDocument(COD_DOC.longValue());
		out.print("Deleting ok");
	}catch(Exception ex){
		out.print("<script>Alert.Error.showDelete();</script>");
		return;
	}
}else{
	out.print("<script>err=true;</script>");
}
%>
<script>
	 if (parent.dialogArguments){
		if (!err){	
			parent.returnValue="OK"; 
			Alert.Success.showDeleted();
		}else{
			parent.returnValue="CANCEL"; 
		}
		parent.close();
			
	}	
	else{
		if (!err){
			parent.del_localRow();
			Alert.Success.showDeleted();
		}else{
			Alert.Error.showDelete();	
		}	
	}
</script>
