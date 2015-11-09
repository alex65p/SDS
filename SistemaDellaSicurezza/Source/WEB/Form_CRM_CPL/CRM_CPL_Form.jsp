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
    <version number="1.0" date="22/03/2004" author="Malyuk Sergey">
          <comments>
                  <comment date="22/03/2004" author="Malyuk Sergey">
                   <description>Create</description>
                  </comment>
        </comments>
    </version>
  </versions>
</file>               <script language="JavaScript" src="CRM_RSO_Script.js"></script>
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.Capitoli.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/ToolBar.jsp" %>

<html>
<head>
<title><%=ApplicationConfigurator.LanguageManager.getString("List")%></title>
  <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
    <link rel="stylesheet" href="../_styles/tabs.css">
    <script language="JavaScript" src="../_scripts/tabs.js"></script>
    <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
</head>
<body>
<form action="CRM_CPL_Set.jsp" id="frm1" method="post" target="ifrmWork">
<!-- ############################ -->
<table width="100%" border="0">
<%
ToolBar.bShowSave=true;
ToolBar.bShowDelete=false;
ToolBar.bShowReturn=false;
ToolBar.bShowDetail=false;
ToolBar.bCanDetail=true;
ToolBar.bAlwaysShowPrint=false;
ToolBar.bCanPrint=false;
//ToolBar.strPrintUrl="ElencoRischiRepository.jsp?";
%>
<%=ToolBar.build(3)%>
</table>
<!-- ########################### -->

<fieldset>
<legend><%=ApplicationConfigurator.LanguageManager.getString("Capitoli.presenti.nel.repository")%></legend>
    <table border='0' id='SchedeParagrafoTab' class='dataTable' cellpadding='0' cellspacing='0'>
    <tr>
      <td align='center' width="100%"><strong><%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>&nbsp;</strong></td>
    </tr>
    </table>
      <div id="div_s" style='height: 150%;width: 100%; overflow: auto'></div>
<fieldset>
<legend><%=ApplicationConfigurator.LanguageManager.getString("Condizioni.di.ricerca")%></legend>
<table width="100%" border="0">
<tr>
<td><input name='NOME' id='NOME' type='input' size=50 value=''></td>
</tr>
</table>
</fieldset>
</form>

<iframe name="ifrmWork"  class="ifrmWork" id="ifrmWork" src="../empty.txt"></iframe>

<script>
btn = ToolBar.Search.getButton();
btn.onclick = goSearch;

btn = ToolBar.Save.getButton();
btn.onclick = goSave;

goSearch();

function goSearch(){
    document.all["frm1"].action="CRM_CPL_Tabs.jsp";
    document.all["frm1"].submit();
}
function goSave(){
    document.all["frm1"].action="CRM_CPL_Set.jsp";
    document.all["frm1"].submit();

}
</script>
</body>
</html>
