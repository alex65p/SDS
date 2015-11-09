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
    <version number="1.0" date="19/01/2004" author="Kushkarov Yura">
	      <comments>
				  <comment date="19/01/2004" author="Kushkarov Yura">
				   <description>Shablon formi ANA_CAG_DOC_Form.jsp</description>
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

<%@ include file="../src/com/apconsulting/luna/ejb/CategoriaDocumento/CategoriaDocumentoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/CategoriaDocumento/CategoriaDocumentoBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuDocumenti,1) + "</title>");
</script>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">

</head>
<script>
window.dialogWidth="740px";
window.dialogHeight="230px";
</script>
<body>
<%
	//boolean EdFlag=false;		//flag of editing
	//   *require Fields*
	String strCOD_CAG_DOC="";
  String strNOM_CAG_DOC="";
	//   *Not require Fields*
	String strDES_CAG_DOC="";


ICategoriaDocumento CategoriaDocumento=null;
if(request.getParameter("ID")!=null)
{
    //out.print(request.getParameter("ID"));
		strCOD_CAG_DOC = request.getParameter("ID");
	// editing of ala
	//getting of ala object
	//EdFlag=true;
		ICategoriaDocumentoHome home=(ICategoriaDocumentoHome)PseudoContext.lookup("CategoriaDocumentoBean");
		Long COD_CAG_DOC=new Long(strCOD_CAG_DOC);
		CategoriaDocumento = home.findByPrimaryKey(COD_CAG_DOC);
		// getting of object variables
		strNOM_CAG_DOC=CategoriaDocumento.getNOM_CAG_DOC();
		//---
		strDES_CAG_DOC=CategoriaDocumento.getDES_CAG_DOC();/**/
}
%>

<!-- form for addind  -->
<form action="CAG_DOC_Set.jsp?par=add"  method="POST" target="ifrmWork">
<table width="100%" border="0">
<tr>
 <td width="10" height="100%" valign="top">
 <!-- <button type="button" class="menu" >&nbsp;1&nbsp;</button><br>
 <button type="button" class="menu">&nbsp;2&nbsp;</button>
 <button type="button" class="menu">&nbsp;3&nbsp;</button><br>
 <button type="button" class="menu">&nbsp;4&nbsp;</button>
 <button type="button" class="menu">&nbsp;5&nbsp;</button><br>
 -->

 </td>
 <td valign="top">
  <table  width="100%" border="0">
  <tr><td class="title" colspan="2">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuDocumenti,1,<%=request.getParameter("ID")%>));
    </script>      
  </td></tr>

<input name="SBM_MODE" type="hidden" value="<%if(strCOD_CAG_DOC==""){out.print("new");}else{out.print("edt");}%>">
<input name="COD_CAG_DOC" type="Hidden" value="<%=strCOD_CAG_DOC%>">

  <tr>
	<td>
	<!-- ############################ -->
     <table width="100%" border="0">
 	  <%@ include file="../_include/ToolBar.jsp" %>
      <%ToolBar.bCanDelete=(CategoriaDocumento!=null);%>
	  <%=ToolBar.build(2)%>
	</table>
 <!-- ########################### -->

  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Categoria.documento")%></legend>
   <table  width="100%" border="0">
   <tr>
   <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
	 <td ><input tabindex="1" size="120" type="text" name="NOM_CAG_DOC" maxlength="50" value="<%=strNOM_CAG_DOC%>">
   </td></tr>
	 <tr><td valign="top" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
	 <td><input tabindex="2" size="120" style="height:'50'" name="DES_CAG_DOC" type="multitext" value="<%=strDES_CAG_DOC%>" ></td>
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

<iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt">none</iframe>
</body>
</html>
