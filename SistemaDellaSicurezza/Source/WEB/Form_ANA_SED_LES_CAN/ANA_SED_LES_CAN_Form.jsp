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
    <version number="1.0" date="24/01/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="24/01/2004" author="Khomenko Juliya">
				   <description>ANA_SED_LES_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.SediLesioneCantiere.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuInfortuniCantiere,0) + "</title>");
</script>
    <script language="JavaScript" src="../_scripts/textarea.js"></script>
<LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
</head>
<body>

<%
	long	lCOD_SED_LES = 0;	//1
	String	strNOM_SED_LES = "";//2
	String	strTPL_SED_LES = "";//3
	ISediLesioneCantiere SediLesione=null;
	ISediLesioneCantiereHome home=(ISediLesioneCantiereHome)PseudoContext.lookup("SediLesioneCantiereBean");
	if(request.getParameter("ID")!=null)
	{
		String strCOD_SED_LES = request.getParameter("ID");
		Long sed_les_id=new Long(strCOD_SED_LES);
		SediLesione = home.findByPrimaryKey(sed_les_id);
	    lCOD_SED_LES = sed_les_id.longValue(); 			//1
		strNOM_SED_LES = SediLesione.getNOM_SED_LES();	//2
		strTPL_SED_LES = SediLesione.getTPL_SED_LES();	//3
	}
%>

<!-- form for addind  SediLesione-->
<form action="ANA_SED_LES_CAN_Set.jsp"  method="" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="Hidden" value="<%=(lCOD_SED_LES==0)?"new":"edt"%>">
<input type="hidden" name="SED_LES_ID" value="<%=lCOD_SED_LES%>">
<table width="100%" border="0">
<tr>
 <td valign="top">
  <table  width="100%">
  <tr><td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuInfortuniCantiere,0,<%=request.getParameter("ID")%>));
    </script>
  </td></tr>
  <tr>
	<td>
  <table width="100%">
  <!-- ############################ -->
  <%@ include file="../_include/ToolBar.jsp" %>
  <%ToolBar.bCanDelete=(SediLesione!=null);
  ToolBar.bShowPrint=false;
  ToolBar.bShowReturn=false;
  %>
  <%=ToolBar.build(2)%>
<!-- ########################### -->

  </table>
  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.sede.lesione")%></legend>
   <table  width="100%" border="0">
   <tr>
   <td align="right" ><b><%=ApplicationConfigurator.LanguageManager.getString("Nome.sede")%>&nbsp;</b></td>
	 <td ><input tabindex="1" size="85" type="text" maxlength="50" name="NOME" value="<%=strNOM_SED_LES%>">
   </td></tr>
	 <tr><td valign="top" align="right"> <b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</b></td>
	 <td>
             <s2s:textarea tabindex="2" cols="70" rows="2" maxlength="4000" name="TPL" ><%=Formatter.format(strTPL_SED_LES)%></s2s:textarea>
	 </td>
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
