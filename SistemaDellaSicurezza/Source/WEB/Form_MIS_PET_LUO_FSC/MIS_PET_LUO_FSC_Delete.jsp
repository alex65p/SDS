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
    <version number="1.0" date="25/01/2004" author="Kushkarov Yura">
	      <comments>
				  <comment date="25/01/2004" author="Kushkarov Yura">
				   <description>Shablon formi SCH_INR_PSD_Delete.jsp</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.MisurePreventive.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
	var err=false;
</script>
<%
IMisurePreventive MisurePreventive=null;
if(request.getParameter("ID")!=null)
{	
  String COD_MIS_RSO_LUO_DEL=request.getParameter("ID");
	IMisurePreventiveHome home=(IMisurePreventiveHome)PseudoContext.lookup("MisurePreventiveBean");
	Long lCOD_MIS_RSO_LUO=new Long(COD_MIS_RSO_LUO_DEL);
	try{
		home.remove(lCOD_MIS_RSO_LUO);
	}catch(Exception ex){
		out.print("<script>err=true;</script>");
	}
	//
}	
%>

<script>
	if (!err)
	  {
		  Alert.Success.showDeleted();
		  parent.ToolBar.OnDelete(); 
	  }
		else
		{
		  Alert.Error.showDelete();
		}
</script>
