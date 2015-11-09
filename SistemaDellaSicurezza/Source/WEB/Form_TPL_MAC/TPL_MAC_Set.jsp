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
    <version number="1.0" date="16/01/2004" author="Pogrebnoy Yura">
	      <comments>
				  <comment date="16/01/2004" author="Pogrebnoy Yura">
				   <description>Shablon formi ANA_ALA_Form.jsp</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.TipologieMacchine.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
 var err = false;
 var isNew = false;
</script>
<%!	String ReqMODE;	// parameter of request%>

<%ITipologieMacchine TipologieMacchine=null;
long COD_TPL_MAC=0;
if(request.getParameter("SBM_MODE")!=null){
	ReqMODE=request.getParameter("SBM_MODE");
	Checker c = new Checker();
	//- checking for required fields
	String strDES_TPL_MAC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_TPL_MAC"),true);   

	  if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");err=true;</script>");
			return;
		}

//=======================================================================================
  if(ReqMODE.equals("edt"))
	{
		// editing of TipologieMacchine--------------------
		// gettinf of object 
		Long lCOD_TPL_MAC=new Long(c.checkLong("TipologieMacchine ID",request.getParameter("COD_TPL_MAC"),true));
  	if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");err=true;</script>");
			return;
		}

		ITipologieMacchineHome home=(ITipologieMacchineHome)PseudoContext.lookup("TipologieMacchineBean");
		TipologieMacchine = home.findByPrimaryKey(lCOD_TPL_MAC);
		//getting of parameters and set the new object variables
		TipologieMacchine.setDES_TPL_MAC(strDES_TPL_MAC);
		COD_TPL_MAC=TipologieMacchine.getCOD_TPL_MAC();
	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new TipologieMacchine--------------------------
	// creating of object 
		ITipologieMacchineHome home=(ITipologieMacchineHome)PseudoContext.lookup("TipologieMacchineBean");
		TipologieMacchine=home.create(strDES_TPL_MAC);
		COD_TPL_MAC=TipologieMacchine.getCOD_TPL_MAC();
		%><script>isNew=true;</script><%
	}
//=======================================================================================
}
%>	
<script>
if (!err){
if(isNew){
			Alert.Success.showCreated();
		}else{
			Alert.Success.showSaved();}
  if(isNew) parent.ToolBar.OnNew("ID=<%=COD_TPL_MAC%>"); 
}
</script>
