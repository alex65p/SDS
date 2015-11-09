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
    <version number="1.0" date="29/01/2004" author="Pogrebnoy Yura">
	      <comments>
				  <comment date="29/01/2004" author="Pogrebnoy Yura">
				   <description>Shablon formi COL_INT_Form.jsp</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.CollegamentoInternet.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
<head>
<title><%=ApplicationConfigurator.LanguageManager.getString("Collegamenti.internet")%></title>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">

</head>
<script>
window.dialogWidth="650px";
window.dialogHeight="250px";
</script>
<body>
<%
	//   *require Fields*
	String strCOD_COL_INT="";
  String strIDZ_COL_INT="";
	String strCOD_FAT_RSO="";
	//   *Not require Fields*
	String strDES_COL_INT="";
  String strID_PARENT = ""; // ANA_FAT_RSO_TAB.COM_FAT_RSO
	strID_PARENT = request.getParameter("ID_PARENT");

ICollegamentoInternet colint=null;
if( request.getParameter("ID")!=null)
{
		strCOD_COL_INT = request.getParameter("ID");
	// editing of colint
	//getting of colint object
		ICollegamentoInternetHome home=(ICollegamentoInternetHome)PseudoContext.lookup("CollegamentoInternetBean"); 
		Long COD_COL_INT=new Long(strCOD_COL_INT);
		colint = home.findByPrimaryKey(COD_COL_INT);
		// getting of object variables
		strIDZ_COL_INT=Formatter.format(colint.getIDZ_COL_INT());
		//--- 
		strDES_COL_INT=Formatter.format(colint.getDES_COL_INT());
}
%>
<!-- form for addind  -->
<form action="COL_INT_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="ID_PARENT" type="Hidden" value="<%=strID_PARENT%>">
<table width="100%" border="0">
<tr>
 <td width="10" valign="top">
 </td>
 <td valign="top">
  <table  width="100%">
  <tr><td class="title" colspan="100%"><%=ApplicationConfigurator.LanguageManager.getString("Collegamenti.internet")%></td></tr>
<input name="SBM_MODE" type="Hidden" value="<%if(strCOD_COL_INT.equals("")){out.print("new");}else{out.print("edt");}%>">
<input name="COD_COL_INT" type="Hidden" value="<%=strCOD_COL_INT%>">
  <tr>
	<td valign="top">
<!--  *************************** -->
 <table width="100%" border="0">
   <%@ include file="../_include/ToolBar.jsp" %>
   <%ToolBar.bCanDelete=(colint!=null);
     ToolBar.bShowNew=false;
     ToolBar.bShowSearch=false;
     ToolBar.bShowDelete=false;
     ToolBar.bShowPrint=false;%>
   <%=ToolBar.build(2)%>
   </table>
<!--    **************************** -->	
  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Collegamento.internet")%></legend>
   <table  width="100%" border="0">
   <tr>
   <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Indirizzo")%>&nbsp;</b></td>
	 <td><input size="100%" type="text" maxlength="100" name="IDZ_COL_INT" value="<%=strIDZ_COL_INT%>">
   </td></tr>
	 <tr><td valign="top" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
	 <td><input size="100%" style="height:'50'" name="DES_COL_INT" type="multitext" value="<%=strDES_COL_INT%>"></td>
	 </tr>
   </td></tr>
   </table>	 
	 </fieldset></td></tr>
  </table>
 </td>
</tr>
</table>
</form>
<!-- /form for addind  -->
<script>
//disable return, esli forma vizvana is taba ANA_FAT_RSO_Form
if(parent.dialogArguments){
  ToolBar.Return.setEnabled(false);
}
</script>
<iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
</body>
</html>
