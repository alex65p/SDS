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
    <version number="1.0" date="17/02/2004" author="Alexey Kolesnik">
	      <comments>
				 <comment date="17/02/2004" author="Alexey Kolesnik">
				   <description>RSO_LUO_FSC_Delete.jsp</description>
				 </comment>
				 <comment date="29/03/2004" author="Roman Chumachenko">
				   <description>Deleting of Rischio Assotiations</description>
				 </comment>
      </comments>
    </version>
  </versions>
</file>
*/

response.setHeader("Cache-Control","no-cache");	//HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server

%>
<%@ page import="com.apconsulting.luna.ejb.LuogoFisicoRischio.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp"%>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
	var err=false;
	var errDescr;
</script>

<%
Checker c = new Checker();
long lCOD_AZL=Security.getAzienda();
long ID=0;
long lCOD_MIS_RSO_LUO = 0;
String LOCAL_MODE=request.getParameter("LOCAL_MODE");
//out.print(request.getParameter("ID_PARENT")); 	//ID eto cod_mis_rso_luo

if(LOCAL_MODE!=null)
{
	ID=c.checkLong("Rischio",request.getParameter("ID_PARENT"),true);
	if(LOCAL_MODE.equals("mis"))
	{
		lCOD_MIS_RSO_LUO=c.checkLong("Misure",request.getParameter("ID"),true);
	}
	if(LOCAL_MODE.equals("ris"))
	{
		ID=c.checkLong("Rischio",request.getParameter("ID"),true);
		//out.print("ID RISCHIO:"+ID+"<br>");
	}
}
if (c.isError){
	out.println("<script>err=true;alert(\""+ c.printErrors()+"\");</script>");
	return;
}
//ILuogoFisicoRischio bean=null;
ILuogoFisicoRischioHome home=(ILuogoFisicoRischioHome)PseudoContext.lookup("LuogoFisicoRischioBean");
ILuogoFisicoRischio bean=null;
out.println("LOCAL_MODE:"+LOCAL_MODE+"<br>");
//if(true)return;

try{
	if(LOCAL_MODE!=null){
		if(lCOD_MIS_RSO_LUO!=0)
		{
			out.println("removeMisure<br>");
			bean=home.findByPrimaryKey(new Long(ID));
			bean.removeMisure(lCOD_MIS_RSO_LUO);
		}
		//--------------------------
		if(LOCAL_MODE.equals("ris"))
		{
			//<comment date="29/03/2004" author="Roman Chumachenko">
			Long id_bean=new Long(ID);
			bean=home.findByPrimaryKey(id_bean);
			out.println("Luogo Fisico ID: "+bean.getCOD_RSO_LUO_FSC()+" RISC ID"+bean.getCOD_RSO()+"<br>");
			bean.deleteRischioAssociations(lCOD_AZL);
			//</comment>
			home.remove(id_bean);
			//------------------------
		}
	}//if
}catch(Exception ex){
%>
		<div id="divErr">
			<%=ex.getMessage()%>
		</div>
		<script>err=true;</script>
<%}%>
<script>
	<%if(LOCAL_MODE!=null){%>
		if (!err)
		{
			parent.del_localRow();
			Alert.Success.showDeleted();
		}else
		{
			Alert.Error.showDelete();
		}	
	<%} else {%>
		if (!err){
			Alert.Success.showDeleted();
			parent.ToolBar.OnDelete();
		}else{
			Alert.Error.showDelete();
		}
	<%}%>
</script>
