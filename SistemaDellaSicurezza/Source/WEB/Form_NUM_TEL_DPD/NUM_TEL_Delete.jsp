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
    <version number="1.0" date="14/01/2004" author="Alexander Kyba">
	      <comments>
				  <comment date="14/01/2004" author="Alexander Kyba">
				   <description>Shablon formi NUM_TEL_Delete.jsp</description>
				 </comment>
				 <comment date="31/01/2004" author="Roman Chumachenko">
					<description>Rebiuld for new UI (TabBar)</description>
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

<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteTelefono/DipendenteTelefonoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteTelefono/DipendenteTelefonoBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
	var err=false;
</script>
<%
IDipendenteTelefono Tel=null;
IDipendenteTelefonoHome telHome=(IDipendenteTelefonoHome)PseudoContext.lookup("DipendenteTelefonoBean");
if(request.getParameter("ID")!=null)
{	
	//
	String ID_TO_DEL=request.getParameter("ID");
	Long num_tel=new Long(ID_TO_DEL);
	try{
		telHome.remove(num_tel);
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
			  Alert.Success.showDeleted();
			parent.returnValue="OK"; 
		}else{
			parent.returnValue="CANCEL"; 
		}
		parent.close();
	}	
	else{
		if (!err){
			  Alert.Success.showDeleted();
			parent.del_localRow();
		}else{
			Alert.Error.showDelete();
		}	
	}
</script>
