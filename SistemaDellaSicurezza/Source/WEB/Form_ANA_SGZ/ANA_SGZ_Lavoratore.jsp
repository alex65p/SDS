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
    <version number="1.0" date="20/04/2004" author="Podmasteriev Alexandr">
	      <comments>
				  <comment date="20/04/2004" author="Podmasteriev Alexandr">
				   <description>dla pergruzki inputov v ANA_SGZ_Form</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<% 
//-------------------------------------------------
			
	String strRAG_SCL_AZL = new String();
	//------------------
	long lCOD_DPD=0;
	String strNOM_DPD="";
	String strMTR_DPD="";
	String strCOG_DPD="";
	//---------------------------

//------------------------------------------------------------------
//----------------Interfaces & Beans--------------------------------
//------------------------------------------------------------------
	//------ Dipendente ---
	IDipendenteHome home=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
	IDipendente bean=null;

if(request.getParameter("ID")!=null)
{
 	// getting parameters of azienda
	try{
		Long ID = new Long(request.getParameter("ID"));
		bean=home.findByPrimaryKey(ID);
		lCOD_DPD=bean.getCOD_DPD();
		strNOM_DPD=bean.getNOM_DPD();
		strMTR_DPD = bean.getMTR_DPD();
		strCOG_DPD = bean.getCOG_DPD();
	}
	catch(Exception ex){
		out.print("<strong>"+ex.getMessage()+"</strong>");
		return;
	}
}

%>
<script>
	if (parent.document.all["COD_DPD"] && parent.document.all["strNOM_DPD"]&& parent.document.all["strCOG_DPD"] && parent.document.all["strMTR_DPD"]){
		parent.document.all["COD_DPD"].value="<%=Formatter.format(lCOD_DPD)%>";
		parent.document.all["strNOM_DPD"].value="<%= Formatter.format(strNOM_DPD) %>";
		parent.document.all["strCOG_DPD"].value="<%= Formatter.format(strCOG_DPD) %>";
		parent.document.all["strMTR_DPD"].value="<%= Formatter.format(strMTR_DPD) %>";
	}	
</script>




