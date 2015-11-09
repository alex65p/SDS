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
    <version number="1.0" date="15/03/2004" author="Khomenko Juli">
          <comments>
                  <comment date="15/03/2004" author="Khomenko Juli">
                   <description>Create</description>
                  </comment>
        </comments>
    </version>
  </versions>
</file>
*/
%>
<%@ page import="com.apconsulting.luna.ejb.ProtocoleSanitare.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<html>
<head>
<title><%=ApplicationConfigurator.LanguageManager.getString("List")%></title>
  <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
    <link rel="stylesheet" href="../_styles/tabs.css">
    <script language="JavaScript" src="../_scripts/tabs.js"></script>
    <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
</head>
<body>
<form action="CRM_PRO_SAN_Set.jsp" id="frm1" method="post" target="ifrmWork">
<input type="hidden" name="LOCAL_MODE" value="caricaDbProtocolli">
<table border=0 cellpadding="0" cellspacing="0" >
<tr><td>
<!-- ############################ -->
<%@ include file="../_include/ToolBar.jsp" %>
<%
ToolBar.bShowSave=true;
ToolBar.bShowDelete=false;
ToolBar.bShowReturn=false;
ToolBar.bShowDetail=false;
ToolBar.bCanDetail=false;
ToolBar.bAlwaysShowPrint=false;
ToolBar.bCanPrint=false;
//ToolBar.strPrintUrl="ElencoRischiRepository.jsp?";
%>
<%=ToolBar.build(3)%>
<!-- ########################### -->
</td>
<td>
<fieldset>
<legend><%=ApplicationConfigurator.LanguageManager.getString("Protocolli.sanitari.presenti.nel.repository")%></legend>
<table border=0 cellpadding="0" cellspacing="0">
<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td>
    <table border='0' id='SchedeParagrafoTab' class='dataTable' cellpadding='0' cellspacing='0'>
    <tr>
      <td align='center' width='350'><strong><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</strong></td>
      <td align='center' width='350'><strong><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</strong></td>
      <td align='center' width='20'>&nbsp;</td>
    </tr>
    </table>

      <div id="div_s" style='height: 150;width: 100%; overflow-y: auto'></div>

</td></tr>
<tr><td colspan="100%">
&nbsp;&nbsp;&nbsp;<div style="background-color: #ff3333;width:100px">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div><%=ApplicationConfigurator.LanguageManager.getString("Record.già.caricati")%>
</td></tr>
</table>
</fieldset>
</td></tr>
<tr><td>
<fieldset>
<legend><%=ApplicationConfigurator.LanguageManager.getString("Condizioni.di.ricerca")%></legend>
<br> &nbsp;
&nbsp;&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;&nbsp;<input name='NOME' id='NOME' type='input' size=50 value=''>
<br> &nbsp;
</fieldset>
</td></tr></table>
</form>

<iframe name="ifrmWork"  class="ifrmWork" id="ifrmWork" src="../empty.txt"></iframe>

<script>
btn = ToolBar.Search.getButton();
btn.onclick = goSearch;

btn = ToolBar.Save.getButton();
btn.onclick = goSave;

goSearch();

function goSearch(){
    document.all["frm1"].action="CRM_PRO_SAN_Tabs.jsp";
    document.all["frm1"].submit();
}
function goSave(){
    document.all["frm1"].action="CRM_PRO_SAN_Set.jsp";
    document.all["frm1"].submit();
}
</script>
</body>
</html>
