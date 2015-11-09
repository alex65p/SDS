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
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/MansioneDittePrecedente/MansioneDittePrecedenteBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/MansioneDittePrecedente/MansioneDittePrecedenteBean.jsp" %>

<%
  long lCOD_MAN_DIT_PRC=0;
	String strNOM_MAN_DIT_PRC="";
	String strDES_MAN_DIT_PRC="";
	long lCOD_DIT_PRC_DPD=new Long(request.getParameter("ID_PARENT")).longValue();
	long lCOD_DPD=new Long(request.getParameter("COD_DPD")).longValue();
	long lCOD_AZL=Security.getAzienda();
	
IMansioneDittePrecedente bean=null;
IMansioneDittePrecedenteHome home=(IMansioneDittePrecedenteHome)PseudoContext.lookup("MansioneDittePrecedenteBean");

if(request.getParameter("ID")!=null)
	{
		String strCOD_MAN_DIT_PRC = request.getParameter("ID");

		Long cod_id=new Long(strCOD_MAN_DIT_PRC);
		bean = home.findByPrimaryKey(cod_id);
		
		lCOD_MAN_DIT_PRC=bean.getCOD_MAN_DIT_PRC();
		strNOM_MAN_DIT_PRC=bean.getNOM_MAN_DIT_PRC();
		strDES_MAN_DIT_PRC=bean.getDES_MAN_DIT_PRC();
		lCOD_DIT_PRC_DPD=bean.getCOD_DIT_PRC_DPD();
		lCOD_DPD=bean.getCOD_DPD();
		lCOD_AZL=bean.getCOD_AZL();
}
%>

<html>
<head>
<title><%=ApplicationConfigurator.LanguageManager.getString("Attività.lavorative.precedenti")%></title>
<link rel="stylesheet" href="../_styles/style.css">
</head>

<script>
window.dialogWidth="400px";
window.dialogHeight="240px";
</script>

<body style="margin:0 0 0 0;">
<form action="MAN_DIT_PRC_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<table border=0 width="100%">
  <tr><td class="title"><%=ApplicationConfigurator.LanguageManager.getString("Attività.lavorative.precedenti")%></td></tr>
    <tr valign="top">
	  <td>
<input name="SBM_MODE" type="hidden" value="<%if(lCOD_MAN_DIT_PRC!=0){out.print("edt");}else{out.print("new");}%>">
<input name="COD_MAN_DIT_PRC" id="COD_MAN_DIT_PRC" type="hidden" value="<%=lCOD_MAN_DIT_PRC%>">
<input name="COD_AZL" type="hidden" value="<%=lCOD_AZL%>">
<input name="COD_DIT_PRC_DPD" type="hidden" value="<%=lCOD_DIT_PRC_DPD%>">
<input name="COD_DPD" type="hidden" value="<%=lCOD_DPD%>">

<!-- ############################ -->  		
<table border=0>
<%@ include file="../_include/ToolBar.jsp" %> 
<%
ToolBar.bCanDelete=(bean!=null);
ToolBar.bShowNew=false;
ToolBar.bShowSearch=false;
ToolBar.bShowPrint=false;
ToolBar.bShowReturn=false;//podmaster at 14/04/2004
%>	
<%=ToolBar.build(2)%> 
</table>
<!-- ########################### -->

<fieldset>		
<table border="0" width="100%">
	<tr valign="top">
		<td width="10%">
                    <b><%=ApplicationConfigurator.LanguageManager.getString("Mansione")%>&nbsp;</b>
                </td>
		<td width="90%">
                    <input type="text" size="55" name="NOM_MAN_DIT_PRC" value="<%=strNOM_MAN_DIT_PRC%>">    
                </td>
	</tr>
	<tr valign="top">
		<td width="10%"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
		<td width="90%">
                    <textarea rows="5" cols="45" name="DES_MAN_DIT_PRC"><%=strDES_MAN_DIT_PRC%></textarea>
                </td>
	</tr>
</table>	
</fieldset>
		</td>
	</tr>
</table>
</form>
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
<script>
	//---------------
	ToolBar.Return.setEnabled(false);
</script>
</body>
</html>
