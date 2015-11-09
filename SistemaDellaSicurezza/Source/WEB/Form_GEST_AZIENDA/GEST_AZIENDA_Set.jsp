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
    <version number="1.0" date="01/04/2004" author="Roman Chumachenko">
	      <comments>
				  <comment date="01/04/2004" author="Roman Chumachenko">
				   <description>GEST_AZIENDA_Set.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.OperazioneSvolta.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script>
	var bAdded=false;
	var bDeleted=false;
</script>

<%
long COD_OPE_SVO=0;
long COD_RSO =0;
long COD_MAN=0;
String[] CHK_ITEMS=null;
String DEL=(String)request.getParameter("DEL");
//-------------------------------------------------------------------------
if(request.getParameterValues("CHK_ITEM")!=null){
	CHK_ITEMS=request.getParameterValues("CHK_ITEM");
	for(int i=0; i<CHK_ITEMS.length; i++)
	{
		out.print( "<br>"+CHK_ITEMS[i] );
	}
}
//-------------------------------------------------------------------------
COD_OPE_SVO=Long.parseLong( request.getParameter("COD_OPE_SVO") );
COD_MAN=Long.parseLong( request.getParameter("COD_MAN") );
//++++++++++++++++++++++++++++++++++++++++++
out.println("<br>COD_OPE_SVO:"+COD_OPE_SVO);
out.println("<br>COD_MAN:"+COD_MAN);
//------------------------------------------
if(request.getParameter("COD_RSO")!=null)
{
 COD_RSO=Long.parseLong( request.getParameter("COD_RSO") );
 out.println("<br>COD_RSO:"+COD_RSO);
 if(request.getParameterValues("CHK_ITEM")!=null)
 {
    IAttivitaLavorativeHome at_home=(IAttivitaLavorativeHome)PseudoContext.lookup("AttivitaLavorativeBean");
	IAttivitaLavorative at_bean = null;
	Long id = null;
	long COD_AZL=Security.getAzienda();
	int n=1;
	for(int i=0; i<CHK_ITEMS.length; i++)
	{
		id = new  Long(CHK_ITEMS[i]);
		at_bean = at_home.findByPrimaryKey( new AttivitaLavorativePK(COD_AZL, id.longValue()) );
		out.println( "<br>"+at_bean.getNOM_MAN() );
		try{
			if(DEL.equals("0")){
				at_bean.addXRischioAssociations(COD_RSO, COD_AZL);
				%><script>var bAdded=true;</script><%
			}
			if(DEL.equals("1")){
				at_bean.deleteXRischioAssociations(COD_RSO, COD_AZL);
				%><script>var bDeleted=true;</script><%
			}
		}
		catch(Exception ex1){
			out.print(ex1.toString());
			if(DEL.equals("0")){
				out.print("<script>alert('Non e possibile salvare associazione "+n+"');</script>");
			}
			if(DEL.equals("1")){
				out.print("<script>alert('Non e possibile eliminare associazione "+n+"');</script>");
			}
			
			
			return;
		}
		n++;
	}//for
 }//if array
}//if COD_RSO
//=====================================================================
%>
<script>
if(bAdded){
 Alert.Success.showSaved();
} 
if(bDeleted){
 Alert.Success.showDeleted();
} 
parent.returnValue="OK";
parent.ToolBar.Return.Do();
</script>

