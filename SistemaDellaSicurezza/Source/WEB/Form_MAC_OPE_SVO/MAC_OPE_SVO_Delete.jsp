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
    <version number="1.0" date="10/02/2004" author="Pogrebnoy Yura">
	      <comments>
		  	<comment date="10/02/2004" author="Pogrebnoy Yura">
				<description>MAC_OPE_SVO_Delete.jsp<description>
			</comment>
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>var err=false;</script>

<%
IMacchina mac=null;
String strCOD_LUO_FSC=request.getParameter("ID_PARENT");
if(request.getParameter("ID")!=null)
{	
	String strCOD_MAC=request.getParameter("ID");
	IMacchinaHome home=(IMacchinaHome)PseudoContext.lookup("MacchinaBean");
	Long lCOD_MAC=new Long(strCOD_MAC);
	mac=home.findByPrimaryKey(new MacchinaPK(Security.getAzienda(), lCOD_MAC.longValue()) );    
	try{
		if(!strCOD_LUO_FSC.equals(""))mac.removeMAC_LUO_FSC(strCOD_LUO_FSC);
		home.remove(lCOD_MAC);
	}catch(Exception ex){
		out.print("<script>err=true;</script>");
	}
}else{
	out.print("<script>err=true;</script>");
}
%>
<script>
  	if (!err){
	  	Alert.Success.showDeleted();
		  parent.returnValue="OK";
			  parent.del_localRow();
  	}else{
	    Alert.Error.showDelete();
		  parent.returnValue="CANCEL"; 
  	}
</script>
