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
    <version number="1.0" date="14/12/2004" author="Roman Chumachenko">
	      <comments>
				  <comment date="14/12/2004" author="Roman Chumachenko">
				   <description>Shablon formi ANA_AZL_Delete.jsp</description>
				 </comment>
				 <comment date="31/01/2004" author="Roman Chumachenko">
					<description>Rebiuld for new UI (TabBar)</description>
				</comment>
				<comment date="22/06/2004" author="Treskina Maria">
					<description>Ydalenie aziendi + svazi s konsultantom</description>
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
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.Consulente.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%
	if(Security.isUser()) return;
%>
<!-- language="JavaScript" src="../_scripts/Alert.js" -->
<script >
<%@ include file="../_scripts/Alert.js" %>
</script>

<script>
	var err=false;
</script>
<%
long azl_id=0;
long cod_azl=Security.getAzienda();
out.print("");
if(request.getParameter("ID")!=null)
{	
	//
	String ID_TO_DEL=request.getParameter("ID");
	String strCOD_COU="";
	long lCOD_COU=0;
	IAziendaHome home=(IAziendaHome)PseudoContext.lookup("AziendaBean");
	azl_id=new Long(ID_TO_DEL).longValue();
	//IAzienda azienda = home.findByPrimaryKey(azl_id);
	//out.print(azl_id+"=="+Security.getAzienda());
	//if (azl_id==Security.getAzienda()) out.print("<BR>***********************<BR>");
	if (Security.isConsultant()){
				strCOD_COU = Security.getUserPrincipal().getName();

				IConsultantHome home_consultant=(IConsultantHome)PseudoContext.lookup("ConsultantBean");
				IConsultant  bean_consultant = home_consultant.findByPrimaryKey(strCOD_COU);
				lCOD_COU=bean_consultant.getCOD_COU();
				///bean_consultant.addCOD_AZL( bean.getCOD_AZL() );
			}
	//out.print ("strCOD_COU="+strCOD_COU+"<br>lCOD_COU="+lCOD_COU);
	try{
		home.deleteAzienda(azl_id, lCOD_COU);
		if (azl_id==cod_azl) session.invalidate(); 
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
			if(parent.ToolBar != null){
				 parent.ToolBar.OnDelete();
			}
			<% if (azl_id==cod_azl) {%>
					if (opener) window.parent.location.reload();
						else {
							window.parent.location.reload();
							window.returnValue='DELETE';
							window.close();
						}
			<%
				}
						else out.print("parent.g_Handler.OnRefresh();");
			%> 
		}else{
			Alert.Error.showDelete();	
		}	
	}
</script>
