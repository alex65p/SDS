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
    <version number="1.0" date="27/02/2004" author="Yuriy Kushkarov">		
      <comments>
			   <comment date="27/02/2004" author="Yuriy Kushkarov">
				   <description>Realizazija EJB dlia objecta Testimone
			   </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Testimone.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

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
ITestimone bean=null;
//-----start check section--------------------------------
Checker c = new Checker();

long lCOD_TST_EVE=c.checkLong("COD_TST_EVE",request.getParameter("COD_TST_EVE"),false);
String strNOM_TST_EVE=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"),request.getParameter("NOM_TST_EVE"),true);
String strDES_TST_EVE=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_TST_EVE"),true);
String strCTO_TST_EVE=c.checkString(ApplicationConfigurator.LanguageManager.getString("Contatto"),request.getParameter("CTO_TST_EVE"),false);
long lCOD_INO=c.checkLong("COD_INO",request.getParameter("COD_INO"),true);

if (c.isError){
	String err = c.printErrors();
	out.print("<script>err=true;alert(\""+err+"\");</script>");
	return;
}

ITestimoneHome home=(ITestimoneHome)PseudoContext.lookup("TestimoneBean");

//------end check section--------------------------------
try{
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
		bean = home.findByPrimaryKey(new Long(lCOD_TST_EVE));
		bean.setNOM_TST_EVE(strNOM_TST_EVE);
		bean.setDES_TST_EVE(strDES_TST_EVE);
		bean.setCOD_INO(lCOD_INO);	
	}
	else{
		bean=home.create(  strNOM_TST_EVE, strDES_TST_EVE, lCOD_INO);
		%>
		<script>isNew=true;</script>
		<%	
	}
	if(bean!=null){
 		bean.setCTO_TST_EVE(strCTO_TST_EVE);}
		else{	throw new Exception("Invalid operation");}
	}
}
catch(Exception ex)
        
{
    ex.printStackTrace();
%>
		<div id="divErr">
			<%=ex.getMessage()%>
		</div>
		<script>
		//err=true;
		</script>
<%
}
%>
<script>
if (err) alert(divErr.innerText);
 if(!err){	
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=bean.getCOD_TST_EVE()%>"); 
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";	
	}	
</script>
