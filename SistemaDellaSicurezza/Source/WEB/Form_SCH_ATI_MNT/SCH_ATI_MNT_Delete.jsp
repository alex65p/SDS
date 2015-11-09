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
    <version number="1.0" date="25/01/2004" author="Podmasteriev Alexandr">
	      <comments>
				  <comment date="25/01/2004" author="Podmasteriev Alexandr">
				   <description>Shablon formi CAG_PSD_ACD_Delete.jsp</description>
				 </comment>		
				  <comment date="16/02/2004" author="Khomenko Juli">
				   <description>Izmenenie faila dlya realizacii s tabom</description>
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
<%@ page import="com.apconsulting.luna.ejb.SchedaAttivitaSegnalazione.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
var err=false;
</script>
<%
long ID = 0;
long ID_PARENT = 0;
String LOCAL_MODE=request.getParameter("LOCAL_MODE");
Checker c = new Checker();

//ID =new Long(request.getParameter("ID")).longValue();

ISchedaAttivitaSegnalazione bean=null;
ISchedaAttivitaSegnalazioneHome home=(ISchedaAttivitaSegnalazioneHome)PseudoContext.lookup("SchedaAttivitaSegnalazioneBean");

if(LOCAL_MODE!=null){
	ID_PARENT = c.checkLong("SchedaAttivitaSegnalazione",request.getParameter("ID_PARENT"),true);

	if(LOCAL_MODE.equals("DOC")){
		ID =c.checkLong("Schede Documenti",request.getParameter("ID"),true);
	 }
	if(LOCAL_MODE.equals("MAC")){
		ID =c.checkLong("Attiva Manutenzione",request.getParameter("ID"),true);
//		out.println("<script>alert(\""+ID+"\");</script>");
   }

}
else{
	ID =c.checkLong("SchedaAttivitaSegnalazione",request.getParameter("ID"), true);
}

if (c.isError){
	out.println("<script>err=true;alert(\""+ c.printErrors()+"\");</script>");
	return;
}
out.print("ID"+ID);
out.print("ID_PARENT"+ID_PARENT);
out.print("LM"+LOCAL_MODE);

try{
	if(LOCAL_MODE!=null){
		if(LOCAL_MODE.equals("DOC")){
      bean=home.findByPrimaryKey(new Long(ID_PARENT));
			bean.removeCOD_DOC(ID);
   	}
		else{
		home.remove(new Long(ID));
   	}
	}
	else{
		home.remove(new Long(ID));
	}
}
catch(Exception ex){

%>
		<script>err=true;</script>
<%
}
%>

<script>
if (err) Alert.Error.showDelete();

<%
if(LOCAL_MODE==null){
%>
		else{
		  Alert.Success.showDeleted();
		  parent.g_Handler.OnRefresh();
		}
<%
} else if(LOCAL_MODE=="MAC"){
%>
		else{
		  Alert.Success.showDeleted();
		  //parent.g_Handler.OnRefresh();
	  }	
<%
} else {
%>
		else{
			parent.del_localRow();
		  Alert.Success.showDeleted();			
	  }	
<%
}
%>

</script>

	
	
