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
    <version number="1.0" date="06/02/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="06/02/2004" author="Khomenko Juliya">
				   <description>Shablon formi ANA_COL_INT_Form.jsp</description>
				  </comment>		
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

<%@ include file="../_include/ToolBar.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
<head>
<title><%=ApplicationConfigurator.LanguageManager.getString("Collegamenti.internet")%></title>
  <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
	<link rel="stylesheet" href="../_styles/tabs.css">
	<script language="JavaScript" src="../_scripts/tabs.js"></script>
	<script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>

</head>

<script>
window.dialogWidth="720px";
window.dialogHeight="250px";
</script>

<body>
<%
	long			  lCOD_COL_INT_PRG = 0;			//1 
	String			strIDZ_COL_INT = "";			//2
	String			strDES_COL_INT = "";			//3
	long			  lCOD_PRG = 0;			    		//4 
	
		ICollegamenti Collegamenti=null;
		ICollegamentiHome home=(ICollegamentiHome)PseudoContext.lookup("CollegamentiBean");

	if(request.getParameter("ID")!=null)
	{
		String strCOD_COL_INT_PRG = request.getParameter("ID");

		Long cod_id=new Long(strCOD_COL_INT_PRG);
		Collegamenti = home.findByPrimaryKey(cod_id);

    lCOD_COL_INT_PRG = cod_id.longValue(); 						//1
		strIDZ_COL_INT = Collegamenti.getIDZ_COL_INT();		//2
		strDES_COL_INT = Collegamenti.getDES_COL_INT();		//3
    
	}	
    lCOD_PRG = new Long (request.getParameter("ID_PARENT")).longValue();  //4
%>

<!-- form for addind  Collegamenti-->
<form action="COL_INT_PRG_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="hidden" value="<%=(lCOD_COL_INT_PRG==0)?"new":"edt"%>">
<input type="hidden" name="COD_COL_INT_PRG_ID" value="<%=lCOD_COL_INT_PRG%>">
<input type="hidden" name="COD_PRG" value="<%=lCOD_PRG%>">

<table width="100%" border="0">
    <td class="title"><%=ApplicationConfigurator.LanguageManager.getString("Collegamenti.internet")%></td>
<tr>
 <td valign="top">
  <table  width="100%">
  <tr><td class="title"></td></tr>
  <tr>
	<td>
	<table width="100"> 
	<!-- ############################ -->  		
<%ToolBar.bCanDelete=(Collegamenti!=null);
ToolBar.bShowPrint=false;
ToolBar.bShowReturn=false;
ToolBar.bShowDelete=false;
ToolBar.bShowSearch=false;
%>	
<%=ToolBar.build(2)%> 
<!-- ########################### --> 

	</table>
  <fieldset>
      <legend><%=ApplicationConfigurator.LanguageManager.getString("Collegamento.internet")%></legend>
   <table  width="100%" border="0">
   <tr>
   <td align="right" width="10%"><b><%=ApplicationConfigurator.LanguageManager.getString("Indirizzo")%>&nbsp;</b></td>
	 <td ><input size="100" maxlength="100" type="text" id="INDIZZIO" name="INDIZZIO" value="<%=strIDZ_COL_INT%>">
   </td></tr>
	 <tr>
	   <td valign="top" align="left"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
	   <td><textarea rows="5" cols="107" name="DESC" size="width='90%'"><%=strDES_COL_INT%></textarea>
   </td></tr>
   </table>	 
	 </fieldset>
	</td></tr>
  </table>
 </td>
</tr>  
</table>
</form>
<!-- /form for addind  Collegamenti-->
   <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>

</body>
</html>
 
