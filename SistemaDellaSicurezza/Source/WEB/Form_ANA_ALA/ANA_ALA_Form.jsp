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
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Ala.*" %> 

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
document.write("<title>" + getCompleteMenuPath(SubMenuDistribuzioneTerritorialie,3) + "</title>");
</script>
<LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
</head>
<body style="margin:0 0 0 0;">  
<%
  String strCOD_ALA="";
  String strNOM_ALA="";
  String strDES_ALA="";
  IAla ala=null;
  if(request.getParameter("ID")!=null)
  {
	strCOD_ALA = request.getParameter("ID");
	IAlaHome home=(IAlaHome)PseudoContext.lookup("AlaBean"); 
	Long COD_ALA=new Long(strCOD_ALA);
	ala = home.findByPrimaryKey(COD_ALA);
	strNOM_ALA=Formatter.format(ala.getNOM_ALA());
	strDES_ALA=Formatter.format(ala.getDES_ALA());
  }
%>
<!-- form for addind  -->
<form action="ANA_ALA_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<table width="100%" border="0">
<tr>
 <td width="10" height="100%" valign="top">

 </td>
 <td valign="top">
  <table  width="100%">
  <tr><td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuDistribuzioneTerritorialie,3,<%=request.getParameter("ID")%>));
    </script>
  </td></tr>
  <input name="SBM_MODE" type="Hidden" value="<%if(strCOD_ALA==""){out.print("new");}else{out.print("edt");}%>">
  <input name="COD_ALA" type="Hidden" value="<%=strCOD_ALA%>">
  <tr>
	<td>
	<table width"100">
	<%@ include file="../_include/ToolBar.jsp" %>
    <%
        ToolBar.bCanDelete=(ala!=null);
        ToolBar.bShowPrint=false;
    %>
    <%=ToolBar.build(2)%>
	</table>
  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.ala")%></legend>
   <table  width="100%" border="0">
   <tr>
   <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
	 <td ><input tabindex="1" size="115%" type="text" maxlength="50" name="NOM_ALA" value="<%=strNOM_ALA%>">
   </td></tr>
	 <tr><td valign="top" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
	 <td><textarea tabindex="2" cols="120" rows="4" name="DES_ALA"><%=strDES_ALA%></textarea></td>
	 </tr>
   </td></tr>
   </table>	 
	 </fieldset></td></tr>
  </table>
 </td>
</tr>
</table>
</form>
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
</body>
</html>
