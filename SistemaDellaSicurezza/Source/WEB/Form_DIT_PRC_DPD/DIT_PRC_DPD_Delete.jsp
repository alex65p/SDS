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
				   <description>ydalenie dannih iz DIT_PRC_DPD</description>
				 </comment>		
				 <comment date="24/02/2004" author="Podmasteriev Alexandr">
				   <description>Vstavil drugoy kod realizacii udalenia iz taba i formi,smotri nige commenti</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/DipendentePrecedenti/DipendentePrecedentiBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DipendentePrecedenti/DipendentePrecedentiBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/MansioneDittePrecedente/MansioneDittePrecedenteBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/MansioneDittePrecedente/MansioneDittePrecedenteBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script type="text/javascript">
var err=false;
</script>

<%
Checker c = new Checker();

long ID;
long lCOD_MAN_DIT_PRD=0;
String LOCAL_MODE=request.getParameter("LOCAL_MODE");
if(LOCAL_MODE!=null){
	ID=c.checkLong("Ditte Precedente",request.getParameter("ID_PARENT"),true);
	
	if (LOCAL_MODE.equals("md"))
		 {
		 	lCOD_MAN_DIT_PRD=c.checkLong("Mansione Ditte Precedente",request.getParameter("ID"),true);
		 }
	if(LOCAL_MODE.equals("DPD"))ID=c.checkLong("Ditte Precedente",request.getParameter("ID"),true);
	}
	
else{
		ID=c.checkLong("Ditte Precedente",request.getParameter("ID"),true);
}

if (c.isError){
	out.println("<script>err=true;alert(\""+ c.printErrors()+"\");</script>");
	return;
}

IDipendentePrecedenti dipendentePrecedenti=null;
IDipendentePrecedentiHome home=(IDipendentePrecedentiHome)PseudoContext.lookup("DipendentePrecedentiBean");

IMansioneDittePrecedente mansioneDittePrecedente=null;
IMansioneDittePrecedenteHome homeMP=(IMansioneDittePrecedenteHome)PseudoContext.lookup("MansioneDittePrecedenteBean");

try{
	if(LOCAL_MODE!=null){
		if(lCOD_MAN_DIT_PRD!=0){
			homeMP.remove(new Long(lCOD_MAN_DIT_PRD));
		}
		if("DPD".equals(LOCAL_MODE)){home.remove(new Long(ID));}
		else{
			throw new Exception("Invalid operation");
		}
	}
	else{
		home.remove(new Long(ID));
	}
}
catch(Exception ex){
%>
		<div id="divErr">
			<%=ex.getMessage()%>
		</div>
		<script>//err=true; </script>
<%
}
%>
<script>
//if (err) 
//   Alert.Error.showDelete();//	alert(divErr.innerText); //commented by Podmasteriev
		
///---------------Inserted by Podmasteriev-------		

var LOCAL_MODE="<%=LOCAL_MODE%>";
if (!err){
		 
		  if (LOCAL_MODE!="null") {
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
///------------Inserted by Podmasteriev------

<%
//if(LOCAL_MODE==null){ //commented by Podmasteriev
%>
	/*	else{
		  parent.g_Handler.OnRefresh();
			Alert.Success.showDeleted();  //commented by Podmasteriev
		}
		*/
<%
//} else {  //commented by Podmasteriev
%>
	/*
		else{
			parent.del_localRow();
			Alert.Success.showDeleted(); //commented by Podmasteriev
	    }	
	  */ 
<%
//}
%>
</script>
