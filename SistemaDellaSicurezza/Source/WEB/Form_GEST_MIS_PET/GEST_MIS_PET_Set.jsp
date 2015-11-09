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
    <version number="1.0" date="01/03/2004" author="Roman Chumachenko">
	      <comments>
				  <comment date="01/03/2004" author="Roman Chumachenko">
				   <description>GEST_MIS_PET_Set.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.AssRischioAttivita.*" %>
<%@ page import="com.apconsulting.luna.ejb.LuogoFisicoRischio.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
	String ReqMODE;	// parameter of request 
%>	
<script src="../_scripts/Alert.js"></script>
<script>
	var err=false;
</script>
<%
if(request.getParameterValues("CHK_ITEM")!=null)
{
	//-- array of ids ---
	String[] CHK_ITEMS=request.getParameterValues("CHK_ITEM");
	for(int i=0; i<CHK_ITEMS.length; i++){
		out.print( "<br>"+CHK_ITEMS[i] );
	}
	//if(true)return;
	//------------------------------------------
	if(request.getParameter("SBM_MODE")!=null)
	{
	ReqMODE=request.getParameter("SBM_MODE");
	//---------------------------------------
	if(ReqMODE.equals("MESURE"))
	{
		Long COD_RSO_MAN=new Long( request.getParameter("COD_RSO_MAN") );
		out.println("COD_RSO_MAN:"+COD_RSO_MAN);
		IAssRischioAttivita bean=null;
		IAssRischioAttivitaHome home=(IAssRischioAttivitaHome)PseudoContext.lookup("AssRischioAttivitaBean");
		bean=home.findByPrimaryKey(COD_RSO_MAN);
		out.println("MESURE MAN");
		try{
			String res=bean.addExMesurePreventive(CHK_ITEMS);
			out.println("MESURE PREVENTIVE ARE ADDED OK<br>");
			out.println("AREN'T ADDED:"+res);
		}catch(Exception ex){
			out.println("<script>Alert.Error.showSaved();</script>");
			return;
		}	
	}
	//---------------------------------------
	if(ReqMODE.equals("LUOGO"))
	{
	    Long COD_RSO_LUO_FSC=new Long( request.getParameter("COD_RSO_LUO_FSC") );
		out.println("COD_RSO_LUO_FSC:"+COD_RSO_LUO_FSC);
		
		ILuogoFisicoRischio bean=null;
		ILuogoFisicoRischioHome home=(ILuogoFisicoRischioHome)PseudoContext.lookup("LuogoFisicoRischioBean");
		bean=home.findByPrimaryKey(COD_RSO_LUO_FSC);
		out.println("MESURE LUO");
		try{
			String res=bean.addExMesurePreventive(CHK_ITEMS);
			out.println("MISURE PREVENTIVE ARE ADDED<br>");
			out.println("AREN'T ADDED:"+res);
		}catch(Exception ex){
			out.println("<script>Alert.Error.showSaved();</script>");
			return;
		}
	}
	//---------------------------------------
}// end of main block
//=====================================================================
%>
<script>
 	if(!err){	
		Alert.Success.showSaved();
		parent.returnValue="OK";
		parent.ToolBar.Return.Do();
	}else{
		parent.returnValue="ERROR";	
	}	
</script>
<%}%>
