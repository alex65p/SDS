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
    <version number="1.0" date="28/01/2004" author="Podmasteriev Alexandr">
	      <comments>
				  <comment date="28/01/2004" author="Podmasteriev Alexandr">
				   <description>ydalenie iz RSP_CAG_PSD_ACD_TAB </description>
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

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
	var err=false;
	var errDescr;
</script>

<%
String LOCAL_MODE=request.getParameter("LOCAL_MODE");

Checker c = new Checker();
ICategoriePresideHome dhome=(ICategoriePresideHome)PseudoContext.lookup("CategoriePresideBean");
if(request.getParameter("ID")!=null)
{	
	//
  long ID_TO_DPD=c.checkLong("Responsabili categoria",request.getParameter("ID"), true);
  long ID_TO_ACD=c.checkLong("Responsabili categoria",request.getParameter("ID_PARENT"), true);
	long lCOD_AZL = Security.getAzienda();
	out.print(ID_TO_DPD+"-DPD<br>"+ID_TO_ACD+"-ACD<br>"+lCOD_AZL+"-AZL<br>");
	try{
  	dhome.removeCOD_RST(ID_TO_DPD, lCOD_AZL, ID_TO_ACD);
		//out.println("<script>alert(arraylng[\"MSG_0050\"]);</script>");
	}catch(Exception ex){
		out.print("<script>err=true;</script>");
		return;
	}
	//
}
else{
		out.print("<script>err=true;</script>");
}	
%>
<script>
if (err) Alert.Error.showDelete();	
	<%if(LOCAL_MODE==null){%>
	 else{		  
	 						Alert.Success.showDeleted(); 		 		  
							parent.ToolBar.OnDelete();
			 }
	<%} else {%>

		if (!err){
	 						Alert.Success.showDeleted(); 		 		  
							parent.del_localRow();
	    }	

	<%}%>
/*
	 if (parent.dialogArguments){
		if (!err)	
			parent.returnValue="OK"; 
		else
				parent.returnValue="CANCEL"; 
		parent.close();
	}	
	else{
		if (!err){
			parent.del_localRow();
			alert(arraylng["MSG_0050"]);}
		else
			alert(arraylng["MSG_0051"] + errDescr);	
	}*/
</script>
