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
    <version number="1.0" date="22/01/2004" author="Pogrebnoy Yura">
	      <comments>
				  <comment date="22/01/2004" author="Pogrebnoy Yura">
				   <description>Shablon formi ANA_TPL_NOR_SEN_Form.jsp</description>
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

<%@ include file="../src/com/apconsulting/luna/ejb/TipologieNomativeSentenze/TipologieNomativeSentenzeBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TipologieNomativeSentenze/TipologieNomativeSentenzeBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuNormative,3) + "</title>");
</script>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">

</head>
<script>
window.dialogWidth="640px";
window.dialogHeight="250px";
</script>
<body>
<%
	//boolean EdFlag=false;		//flag of editing
	//   *require Fields*
	String strCOD_TPL_NOR_SEN="";
  String strNOM_TPL_NOR_SEN="";
	//   *Not require Fields*
	String strDES_TPL_NOR_SEN="";


ITipologieNomativeSentenze tns=null;
if( request.getParameter("ID")!=null)
{
		strCOD_TPL_NOR_SEN = request.getParameter("ID");
	// editing of tns
	//getting of tns object
		ITipologieNomativeSentenzeHome home=(ITipologieNomativeSentenzeHome)PseudoContext.lookup("TipologieNomativeSentenzeBean");
		Long COD_TPL_NOR_SEN=new Long(strCOD_TPL_NOR_SEN);
		tns = home.findByPrimaryKey(COD_TPL_NOR_SEN);
		// getting of object variables
		strNOM_TPL_NOR_SEN=Formatter.format(tns.getNOM_TPL_NOR_SEN());
		//---
		strDES_TPL_NOR_SEN=Formatter.format(tns.getDES_TPL_NOR_SEN());
}
%>

<!-- form for addind  -->
<form action="TPL_NOR_SEN_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
 <td width="10" height="100%" valign="top">
 </td>
 <td valign="top">
  <table  width="100%">
  <tr><td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuNormative,3,<%=request.getParameter("ID")%>));
    </script>      
  </td></tr>
<input name="SBM_MODE" type="Hidden" value="<%if(strCOD_TPL_NOR_SEN==""){out.print("new");}else{out.print("edt");}%>">
<input name="COD_TPL_NOR_SEN" type="Hidden" value="<%=strCOD_TPL_NOR_SEN%>">

  <tr>
	<td>
 <table width="100%">
  <%@ include file="../_include/ToolBar.jsp" %>
  <%ToolBar.bCanDelete=(tns!=null);%>
  <%=ToolBar.build(2)%>
 </table>	
  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Tipologia.normativa/sentenza")%></legend>
   <table  width="100%" border="0">
   <tr>
   <td width="15%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
	 <td ><input tabindex="1" style="width:100%;" type="text" maxlength="50" name="NOM_TPL_NOR_SEN" value="<%=strNOM_TPL_NOR_SEN%>">
   </td></tr>
	 <tr><td  align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
	 <td><textarea style="width:100%;" tabindex="2" cols="120" rows="4" name="DES_TPL_NOR_SEN"><%=strDES_TPL_NOR_SEN%></textarea></td>
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
<iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
</body>
</html>
