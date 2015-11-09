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
    <version number="1.0" date="24/01/2004" author="Kushkarov Yura">
	      <comments>
				  <comment date="24/01/2004" author="Kushkarov Yura">
				   <description>Shablon formi ANA_ALA_Form.jsp</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<script>
 var err = false;
 var isNew = false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>

<%@ page import="com.apconsulting.luna.ejb.NaturaLesione.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!	String ReqMODE;	// parameter of request%>

<%INaturaLesione NaturaLesione=null;
long THIS_ID=0;
try{
if(request.getParameter("SBM_MODE")!=null){
	ReqMODE=request.getParameter("SBM_MODE");
	out.print(ReqMODE);
	Checker c = new Checker();
	//- checking for required fields
	String strNOM_NAT_LES=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"),request.getParameter("NOM_NAT_LES"),true);   

	  if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");err=true;</script>");
			return;
		}

//=======================================================================================
  if(ReqMODE.equals("edt"))
	{
		// editing of NaturaLesione--------------------
		// gettinf of object 
		Long lCOD_NAT_LES=new Long(c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dati.natura.lesione"),request.getParameter("COD_NAT_LES"),true));
  	if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");err=true;</script>");
			return;
		}

		INaturaLesioneHome home=(INaturaLesioneHome)PseudoContext.lookup("NaturaLesioneBean");
		NaturaLesione = home.findByPrimaryKey(lCOD_NAT_LES);
		//getting of parameters and set the new object variables
		NaturaLesione.setNOM_NAT_LES(strNOM_NAT_LES);
		THIS_ID=NaturaLesione.getCOD_NAT_LES();
	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new NaturaLesione--------------------------
	// creating of object 
		INaturaLesioneHome home=(INaturaLesioneHome)PseudoContext.lookup("NaturaLesioneBean");
		NaturaLesione=home.create(strNOM_NAT_LES);
		THIS_ID=NaturaLesione.getCOD_NAT_LES();
		%>
		<script>isNew=true;</script>
		<%
	}
//=======================================================================================
}
}
catch(Exception ex)
{
%>
		<script>
		err=true;
		</script>
<%
}
%>	
<script>
if (err) Alert.Error.showDublicate();
 if(!err){	
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=THIS_ID%>"); 
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";	
	}	
</script>
