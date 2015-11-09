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

response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<%@ page import="com.apconsulting.luna.ejb.CauseInfortuni.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuInfortuniCantiere,1) + "</title>");
</script>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">

</head>
<body style="margin:0 0 0 0;">

<%
	String 	strNOM_TPL_FRM_INO="";			    //1
	String 	strTIP_TPL_FRM_INO="";
  String  strCOD_TPL_FRM_INO="";

ICauseInfortuni CausaInfortunio=null;
if(request.getParameter("ID")!=null)
{
		strCOD_TPL_FRM_INO = request.getParameter("ID");
	//getting of TipologieFormeDinfortunio object
		ICauseInfortuniHome home=(ICauseInfortuniHome)PseudoContext.lookup("CauseInfortuniBean");
		Long utn_id=new Long(strCOD_TPL_FRM_INO);
		CausaInfortunio = home.findByPrimaryKey(utn_id);

		// getting of object variables
		strNOM_TPL_FRM_INO=CausaInfortunio.getNOM_TPL_FRM_INO();
		strTIP_TPL_FRM_INO=CausaInfortunio.getTIP_TPL_FRM_INO();

}
%>



<!-- form for addind  Utenzei-->
<form action="CAU_INF_CAN_Set.jsp"  method="POST" target="ifrmWork">
<input name="SBM_MODE" type="Hidden" value="<%=(strCOD_TPL_FRM_INO=="")?"new":"edt"%>">
<input type="hidden" name="UTN_ID" value="<%=strCOD_TPL_FRM_INO%>">
<table width="100%" border="0" align="left">
<tr>
 <td width="10" height="100%" valign="top">
 </td>
 <td valign="top">
  <table  width="100%">
  <tr><td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuInfortuniCantiere,1,<%=request.getParameter("ID")%>));
    </script>
  </td></tr>
  <tr>
	<td>
	<table width="100%">
    <!-- ############################ -->
    <%@ include file="../_include/ToolBar.jsp" %>
    <%ToolBar.bCanDelete=(CausaInfortunio!=null);%>
    <%=ToolBar.build(2)%>
    <!-- ########################### -->
	</table>
   <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%></legend>
   <table  width="100%" border="0" align="left">
	 <tr>
   <td align="right" width="20%" ><b><%=ApplicationConfigurator.LanguageManager.getString("Tipo.di.infortunio")%>&nbsp;</b></td>
	 <td  width="80%"><input tabindex="1" size="85" type="text" maxlength="15" name="TIP" value="<%=strTIP_TPL_FRM_INO%>"></td>
	 </tr>
	 <tr>
	 <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</b></td>
	 <td  ><nobr> <input  tabindex="2" size="85" maxlength="150" type="text" name="NOM" value="<%=strNOM_TPL_FRM_INO%>"></nobr></td>
	 </tr>
   <tr>
    </fieldset>
	 </td>
	 </tr>
  </table>
 </td>
</tr>
<!--<tr>
   <td colspan="100%" align="center">
	 <input  type="Submit" value=" save ">
	 <input type="button" value=" Cancel " onclick="window.returnValue='CANCEL';window.close();">
	 </td>
 </tr>
-->
</table>
</form>
<!-- /form for addind  Utenzei-->
   <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>

</body>
</html>

