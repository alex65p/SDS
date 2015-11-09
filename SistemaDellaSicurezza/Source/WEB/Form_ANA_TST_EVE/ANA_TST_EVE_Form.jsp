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
    <version number="1.0" date="27/02/2004" author="Yuriy Kushkarov">
	      <comments>
				  <comment date="27/02/2004" author="Yuriy Kushkarov">
				   <description>Shablon formi COR_DPD_Form.jsp</description>
				  </comment>		
        </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Testimone.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>


<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>


<html>
<head>
<title><%=ApplicationConfigurator.LanguageManager.getString("Testimoni")%></title>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">
</head>
<script>
window.dialogWidth="580px";
window.dialogHeight="270px";
</script>
<body>
<%
ITestimone Testimone;
ITestimoneHome home=(ITestimoneHome)PseudoContext.lookup("TestimoneBean");
long lCOD_TST_EVE=0;
String strCOD_TST_EVE="";
long lCOD_INO=0;
String strCOD_INO="";
String strNOM_TST_EVE="";
String strDES_TST_EVE="";
String strCTO_TST_EVE="";
if(request.getParameter("ID_PARENT")!=null)
{
  strCOD_INO=request.getParameter("ID_PARENT");
	if(request.getParameter("ID")!=null)
  {
	  strCOD_TST_EVE=request.getParameter("ID");
		lCOD_TST_EVE=new Long(strCOD_TST_EVE).longValue();
		Testimone=home.findByPrimaryKey(new Long(strCOD_TST_EVE));
		strNOM_TST_EVE=Testimone.getNOM_TST_EVE();
		strDES_TST_EVE=Testimone.getDES_TST_EVE();
		strCTO_TST_EVE=Testimone.getCTO_TST_EVE();
	}

%>
<!-- form for addind  corbean-->
<form action="ANA_TST_EVE_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="Hidden" value="<%if((strCOD_TST_EVE.equals(""))){out.print("new");}else{out.print("edt");}%>">
<input type="hidden" name="COD_INO" value="<%=strCOD_INO%>">
<input type="hidden" name="COD_TST_EVE" value="<%=strCOD_TST_EVE%>">
<table width="100%" border="0">
    <td class="title" width="100%"><%=ApplicationConfigurator.LanguageManager.getString("Testimoni")%></td>
<!-- ############################ -->  		
<%@ include file="../_include/ToolBar.jsp" %>      
<%ToolBar.bShowDelete=false;
ToolBar.bShowPrint=false;
ToolBar.bShowReturn=false;
ToolBar.bShowSearch=false;
%>	
<%=ToolBar.build(2)%> 
<!-- ########################### --> 
<tr>

  <table  width="100%">
  <td> 
      <fieldset>
          <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.testimone")%></legend>
   <table  width="100%" border="0">
   <tr>
   <td align="right" width="15%"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
	 <td><input type="text" size="50" maxlength="100" name="NOM_TST_EVE" value="<%=Formatter.format(strNOM_TST_EVE)%>"></td>
	 </tr>
	 <tr><td valign="top" align="right" ><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</b></td>
	 <td colspan="2"><textarea rows="3" cols="52" name="DES_TST_EVE"><%=Formatter.format(strDES_TST_EVE)%></textarea>
   </td></tr>
	 <tr><td valign="top" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Contatto")%>&nbsp;</td>
	 <td><input type="text" size="50" maxlength="30"  name="CTO_TST_EVE" value="<%=Formatter.format(strCTO_TST_EVE)%>">
   </td>
	 </tr>
   </table>
</fieldset>
   </td>
  </tr>  
  </table>
  
 </td>
</tr>  
</table>
</form>
<%}%>
<!-- /form for addind  corbean-->
   <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
</body>
</html>
