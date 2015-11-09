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
    <version number="1.0" date="06/02/2004" author="Juli Khomneko">		
      <comments>
			   <comment date="06/02/2004" author="Juli Khomneko">
				   <description>Realizazija EJB dlia objecta Collegamenti
			   </comment>		
			   < comment date="10/02/2004" author="Juli khomenko">
				   < description>Dobavila View for Paragrafo
				 < /comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Collegamenti.*" %>

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
ICollegamenti bean=null;
//-----start check section--------------------------------
Checker c = new Checker();

long lCOD_COL_INT_PRG=c.checkLong("COD_COL_INT_PRG",request.getParameter("COD_COL_INT_PRG_ID"),true);
String strIDZ_COL_INT=c.checkString(ApplicationConfigurator.LanguageManager.getString("Indirizzo"),request.getParameter("INDIZZIO"),true);
String strDES_COL_INT=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DESC"),false);
long lCOD_PRG=c.checkLong("COD_PRG",request.getParameter("COD_PRG"),true);

if (c.isError){
	String err = c.printErrors();
	out.print("<script>alert(\""+err+"\");</script>");
	return;
}

ICollegamentiHome home=(ICollegamentiHome)PseudoContext.lookup("CollegamentiBean");

//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
		bean = home.findByPrimaryKey(new Long(lCOD_COL_INT_PRG));
		try{				
 		bean.setIDZ_COL_INT(strIDZ_COL_INT);
		bean.setCOD_PRG(lCOD_PRG);	
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}
	else{
		%>
		<script>isNew=true;</script>
		<%	
		try{		
		bean=home.create(  strIDZ_COL_INT, lCOD_PRG);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}		
	}
	if(bean!=null){
 		bean.setDES_COL_INT(strDES_COL_INT);
	}
}
%>
<script>  //JS peremennaja vistvliemaja v true esli bila sozdana new zapis'  

if(parent.dialogArguments)
{
	if(!err)
	{
		da = parent.dialogArguments;
		da.ID = "<%=bean.getCOD_COL_INT_PRG()%>";
		da.indirizzo = "<%=bean.getIDZ_COL_INT()%>";
		da.desc = "<%=bean.getDES_COL_INT()%>";
		da.codCol = "<%=bean.getCOD_PRG()%>";
		parent.window.returnValue="OK";
		if(isNew) {
		  Alert.Success.showCreated();
		  parent.ToolBar.OnNew("ID=<%=bean.getCOD_COL_INT_PRG()%>");
		} else {
		  Alert.Success.showSaved();
      parent.ToolBar.Exit.setEnabled(false);
      parent.ToolBar.Return.setEnabled(true);			 
		}
		
	}
	else
	{
		parent.window.returnValue="ERROR";
	}
	parent.close();
}
else
{
 	//------------------------------------------------
 	if(!err){	
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=bean.getCOD_COL_INT_PRG()%>"); 
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";	
	}	
}

</script>
