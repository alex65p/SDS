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
    <version number="1.0" date="16/01/2004" author="Kushkarov Yura">
	      <comments>
				  <comment date="16/01/2004" author="Kushkarov Yura">
				   <description>Shablon formi ANA_ORN_Form.jsp</description>
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

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/Organi/OrganiBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/Organi/OrganiBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuNormative,2) + "</title>");
</script>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">

</head>
<script>
window.dialogWidth="669px";
window.dialogHeight="200px";
</script>
<body>
<%
	//boolean EdFlag=false;		//flag of editing
	//   *require Fields*
	String strCOD_ORN="";
  String strNOM_ORN="";
	//   *Not require Fields*
	String strDES_ORN="";


IOrgani organi=null;
if( request.getParameter("ID")!=null)
{
		strCOD_ORN = request.getParameter("ID");
	// editing of Organi
	//getting of Organi object
		IOrganiHome home=(IOrganiHome)PseudoContext.lookup("OrganiBean"); 
		Long COD_ORN=new Long(strCOD_ORN);
		organi = home.findByPrimaryKey(COD_ORN);
		// getting of object variables
		strNOM_ORN=organi.getNOM_ORN();
		//--- 
		strDES_ORN=organi.getDES_ORN();
}
%>

<!-- form for addind  -->
<form action="ANA_ORN_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<table width="100%" border="0" cellspacing="">
<tr>
 <!-- <button type="button" class="menu" >&nbsp;1&nbsp;</button><br>
 <button type="button" class="menu">&nbsp;2&nbsp;</button>
 <button type="button" class="menu">&nbsp;3&nbsp;</button><br>
 <button type="button" class="menu">&nbsp;4&nbsp;</button>
 <button type="button" class="menu">&nbsp;5&nbsp;</button><br>
 -->
<tr>
<td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuNormative,2,<%=request.getParameter("ID")%>));
    </script>      
</td>
</tr>
</table>

<input name="SBM_MODE" type="Hidden" value="<%if(strCOD_ORN==""){out.print("new");}else{out.print("edt");}%>">
<input name="COD_ORN" type="Hidden" value="<%=strCOD_ORN%>">

	<!-- ############################ -->
	<table width="100%" border="0">
  		<%@ include file="../_include/ToolBar.jsp" %>
      <%ToolBar.bCanDelete=(organi!=null);%>
		<%=ToolBar.build(2)%>
		</table>
 <!-- ########################### -->
 <br>
  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.organo")%></legend>
   <table  width="100%" border="0" cellspacing="" >
   <tr>
   <td align="right" width="15%"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
   <td ><input tabindex="1" style="width:100%" type="text" maxlength="50" name="NOM_ORN" value="<%=strNOM_ORN%>"></td>
   </tr>
   <tr>
   <td align="right" width="15%"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
   <td><input tabindex="2" style="width:100%" name="DES_ORN" type="multitext" value="<%=strDES_ORN%>" ></td>
   </tr>
   </table>	 
    </fieldset>
</form>
<!-- /form for addind  -->

<iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
</body>
</html>
