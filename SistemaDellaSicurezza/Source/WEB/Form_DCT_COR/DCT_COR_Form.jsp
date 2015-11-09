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

<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/DocentiCorso/DocentiCorsoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DocentiCorso/DocentiCorsoBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_include/ComboBox-Dipendente.jsp"%>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%
	long lCOD_DCT_COR = 0;
	long lCOD_COR = 0;
	long lCOD_DPD = 0;
	long lCOD_AZL = Security.getAzienda();
	String strNOM_DCT = "";
	String strDAT_INZ = "";
	String strDAT_FIE = "";
	String strDES_DCT = "";

	if(request.getParameter("ID_PARENT")!=null)
	{
		lCOD_COR = (new Long(request.getParameter("ID_PARENT"))).longValue();
	}

	IDocentiCorso bean = null;
	IDocentiCorsoHome home=(IDocentiCorsoHome)PseudoContext.lookup("DocentiCorsoBean");
	IDipendenteHome dHome=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");

	if(request.getParameter("ID")!=null)
	{
		lCOD_DCT_COR = (new Long(request.getParameter("ID"))).longValue();

		Long dct_cor_id=new Long(lCOD_DCT_COR);
		bean = home.findByPrimaryKey(dct_cor_id);
		lCOD_DCT_COR=dct_cor_id.longValue();
		lCOD_COR=bean.getCOD_COR();
		lCOD_DPD=bean.getCOD_DPD();
		lCOD_AZL=bean.getCOD_AZL();
		strNOM_DCT=Formatter.format(bean.getNOM_DCT());
		strDAT_INZ=Formatter.format(bean.getDAT_INZ());
		strDAT_FIE=Formatter.format(bean.getDAT_FIE());
		strDES_DCT=Formatter.format(bean.getDES_DCT());
	}
%>
<html>
<head>
<title><%=ApplicationConfigurator.LanguageManager.getString("Docenti.dei.corsi")%></title>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">
<link rel="stylesheet" href="../_styles/tabs.css">
<script language="JavaScript" src="../_scripts/tabs.js"></script>
<script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>

<script type="text/javascript" language="JavaScript">
<!--
function populate1(obj) {
	if (obj.selectedIndex != 0 ) {
		document.all["NOM_DCT"].value = obj.options(obj.selectedIndex).value1;
	} else {
		document.all["NOM_DCT"].value = "";
	}
}
//-->
</script>
    <!-- autocompose data field -->
    <script type="text/javascript" src="../_scripts/calendar/utility.js"></script>
    <!-- import the calendar script -->
    <script type="text/javascript" src="../_scripts/calendar/calendar.js"></script>
    <!-- import the language module -->
    <script type="text/javascript" src="../_scripts/calendar/lang.js"></script>
    <!-- import calendar utility function -->
    <script type="text/javascript" src="../_scripts/calendar/showCalendar.js"></script>
    <!-- style sheet for calendar -->
    <link rel="stylesheet" type="text/css" media="all" href="../_styles/calendar/skins/aqua/theme.css" title="Aqua" />
</head>

<script>
window.dialogWidth="550px";
window.dialogHeight="255px";
</script>

<body>
<form action="DCT_COR_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="hidden" value="<%=(lCOD_DCT_COR==0)?"new":"edt"%>">
<input type="hidden" name="COD_DCT_COR" value="<%=lCOD_DCT_COR%>">
<input type="hidden" name="ID" value="<%=lCOD_DCT_COR%>">
<input type="hidden" name="COD_COR" value="<%=lCOD_COR%>">
<input type="hidden" name="ID_PARENT" value="<%=lCOD_COR%>">
<input type="hidden" name="COD_AZL" value="<%=lCOD_AZL%>">
<input type="hidden" name="NOM_DCT" id="NOM_DCT" value="<%=strNOM_DCT%>">
<table width="100%">
<tr><td valign="top">
<!-- ############################ -->
<table border="0" width="100%">
    <td class="title" width="100%"><%=ApplicationConfigurator.LanguageManager.getString("Docenti.dei.corsi")%></td>
<%@ include file="../_include/ToolBar.jsp" %>      
<%
if(request.getParameter("ID_PARENT")!=null)
{
	ToolBar.strSearchUrl=ToolBar.strSearchUrl.replace('&', '|');
}
ToolBar.bShowPrint=false;
ToolBar.bShowSearch=false;
ToolBar.bShowDelete=false;
ToolBar.bShowReturn=false;
%>	
<%=ToolBar.build(2)%> 
</table>
<!-- ########################### --> 
<fieldset style="padding:5 5 5 5">		
<table border="0">
<tr>
    <td align="right" width="50%"><b><%=ApplicationConfigurator.LanguageManager.getString("Docente")%>&nbsp;</b></td>
    <td colspan="3">
        <select name="COD_DPD" style="width:400px;" onchange="populate1(this);">
            <option></option><%=BuildDipendenteComboBox_DCT_COR(dHome, lCOD_DPD, lCOD_AZL)%>		
        </select>
    </td>
    </tr>
    <tr>
        <td align="right" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
        <td colspan="3">
            <textarea name="DES_DCT" rows="4" cols="60" style="width:400px;"><%=strDES_DCT%></textarea>
        </td>
    </tr>
    <tr>
        <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Inizio(default)")%>&nbsp;</b></td>
        <td width="25%">
            <s2s:Date id="DAT_INZ" name="DAT_INZ" value="<%=strDAT_INZ%>"/>
        </td>
        <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Fine")%>&nbsp;</td>
        <td>
            <s2s:Date id="DAT_FIE" name="DAT_FIE" value="<%=strDAT_FIE%>"/>
        </td>
    </tr>
</table>
</fieldset>		
</td></tr>
</table>
</form>
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
</body>
</html>
