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
    <version number="1.0" date="23/01/2004" author="Podmasteriev Alexandr">
	      <comments>
				  <comment date="23/01/2004" author="Podmasteriev Alexandr">
				   <description>dla dobavlenia znacheniy v tablicu RSP_CAG_PCD_ACD </description>
				 </comment>				
				  <comment date="28/02/2004" author="Alexey Kolesnik">
				   <description> Rebuild for dynamic tabbars </description>
				 </comment>		
		  </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.CategoriePreside.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
	String ReqMODE;	// parameter of request 
%>	

<script>
var err=false;
var isNew=false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
//-----start check section--------------------------------
Checker c = new Checker();
//---required fields
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	
long COD_CAG_PSD_ACD=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Categoria.del.presidio"),request.getParameter("COD_CAG_PSD_ACD"), true);
long COD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"), true);
long COD_DPD=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dipendente"),request.getParameter("COD_DPD"), true);
long oldCOD_DPD=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dipendente"),request.getParameter("oldCOD_DPD"), false);

if (c.isError){
	String err = c.printErrors();
	%><script>alert("<%=err%>");</script><%
	return;
}
//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
//=======================================================================================		
    out.println(COD_CAG_PSD_ACD);
		out.println(COD_AZL);
		out.println(COD_DPD);
  	ICategoriePresideHome dhome=(ICategoriePresideHome)PseudoContext.lookup("CategoriePresideBean");
	if(ReqMODE.equals("new"))
	{
   	try{
   			dhome.addCOD_RST(COD_DPD, COD_AZL, COD_CAG_PSD_ACD);
				%><script>isNew=true;</script><%
    }
	 	catch(Exception ex){
    			out.println("<script>Alert.Error.showDublicate();err=true;</script>");
    			return;
    }
	}

	if(ReqMODE.equals("edt"))
	{
   	try{
   			if (request.getParameter("oldCOD_DPD") != null)
				{
				 	 dhome.removeCOD_RST(oldCOD_DPD, COD_AZL, COD_CAG_PSD_ACD);
				}
				dhome.addCOD_RST(COD_DPD, COD_AZL, COD_CAG_PSD_ACD);
    }
	 	catch(Exception ex){
    			out.println("<script>Alert.Error.showDublicate();err=true;</script>");
    			return;
    }
	}
}
%>
<script>
if(!err){	
		parent.returnValue="OK";
		if (isNew)
			 {
			 	Alert.Success.showCreated();
				//parent.ToolBar.OnNew('ID=<%//=COD_DPD%>'); 
			}else{
				Alert.Success.showSaved();
			}
	}else{
		parent.returnValue="ERROR";	
}
</script>
<%
}
%>
