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
    <version number="1.0" date="23/01/2004" author="Treskina Maria">
	      <comments>
				  <comment date="23/01/2004" author="Treskina Maria">
				   <description>ydalenie iz NUM_TEL_FOR_AZL_TAB - FornitoreTelefono</description>
				  </comment>
					<comment date="18/02/2004" author="Treskina Maria">
				   <description>izmenenija vivoda soobshebnij</description>
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

<%@ include file="../src/com/apconsulting/luna/ejb/FornitoreTelefono/FornitoreTelefonoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/FornitoreTelefono/FornitoreTelefonoBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
	var err=false;
	var errDescr;
</script>
<%
IFornitoreTelefono Tel=null;
IFornitoreTelefonoHome telHome=(IFornitoreTelefonoHome)PseudoContext.lookup("FornitoreTelefonoBean");
if(request.getParameter("ID")!=null)
{	
	//
	String ID_TO_DEL=request.getParameter("ID");

	Long num_tel=new Long(ID_TO_DEL);
	try{
		telHome.remove(num_tel);
	}catch(Exception ex){
		out.print("<script>err=true; errDescr = '"+ex.getMessage()+"'</script>");
		return;
	}

}
else{
		out.print("<script>err=true; errDescr = 'Can not find ID of telephone'</script>");
}	
%>
<script>
if (err) Alert.Error.showDelete();
	//alert(divErr.innerText);
		else{
	Alert.Success.showDeleted();
	parent.g_Handler.OnRefresh();
}
</script>
