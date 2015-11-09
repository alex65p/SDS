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
    <version number="1.0" date="19/02/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="19/02/2004" author="Khomenko Juliya">
				   <description>Shablon formi TIT_STU_SPC_Form.jsp</description>
				  </comment>		
        </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/TitoliStudio/TitoliStudioBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TitoliStudio/TitoliStudioBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../_include/ToolBar.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
<head>
<title><%=ApplicationConfigurator.LanguageManager.getString("Titoli.di.studio")%></title>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">

</head>
<script>
window.dialogWidth="650px";
window.dialogHeight="250px";
</script>
<body>

<%
  long lCOD_TIT_STU_SPC=0;
	String strNOM_TIT_STU_SPC="";
	String strDES_TIT_STU_SPC="";
	String strTLP_TIT_STU_SPC="";
	long lCOD_DPD=new Long(request.getParameter("ID_PARENT")).longValue();;
	long lCOD_AZL=Security.getAzienda();;

	ITitoliStudio bean=null;
	ITitoliStudioHome home=(ITitoliStudioHome)PseudoContext.lookup("TitoliStudioBean");

	if(request.getParameter("ID")!=null)
	{
	String strCOD_TIT_STU_SPC = request.getParameter("ID");
	Long stu_id=new Long(strCOD_TIT_STU_SPC);
	bean = home.findByPrimaryKey(stu_id);

  lCOD_TIT_STU_SPC=bean.getCOD_TIT_STU_SPC();
	strNOM_TIT_STU_SPC=bean.getNOM_TIT_STU_SPC();
	strDES_TIT_STU_SPC=bean.getDES_TIT_STU_SPC();
	strTLP_TIT_STU_SPC=bean.getTLP_TIT_STU_SPC();
	lCOD_DPD=bean.getCOD_DPD();
	lCOD_AZL=bean.getCOD_AZL();
	}	
%>

<form action="TIT_STU_SPC_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="hidden" value="<%=(lCOD_TIT_STU_SPC==0)?"new":"edt"%>">
<input type="hidden" name="COD_TIT_STU_SPC" value="<%=lCOD_TIT_STU_SPC%>">
<input name="COD_DPD" type="hidden" value="<%=lCOD_DPD%>">
<input name="COD_AZL" type="hidden" value="<%=lCOD_AZL%>">
<table width="100%" border="0">
<tr>
 <td valign="top">
  <table  width="100%">
  <tr>
      
        <td class="title"><%=ApplicationConfigurator.LanguageManager.getString("Titoli.di.studio")%></td>
 
	<table width="100%">
	<!-- ############################ -->  		
<%ToolBar.bShowDelete=false;%>	
<%ToolBar.bShowSearch=false;%>	
<%ToolBar.bShowPrint=false;%>	
<%ToolBar.bShowReturn=false;%>	
<%=ToolBar.build(2)%> 
<!-- ########################### --> 

	</table>
  <fieldset>
      <legend><%=ApplicationConfigurator.LanguageManager.getString("Titolo.di.studio")%></legend>
   <table  width="100%" border="0">
   <tr>
       <br>
   <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Titolo.di.studio")%>&nbsp;</b></td>
	 <td ><input type="text" size="100" maxlength="50"  name="NOM_TIT_STU_SPC" value="<%=Formatter.format(strNOM_TIT_STU_SPC)%>">
   </td></tr>
	 <tr><td valign="top" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%>&nbsp;</b></td>
	 <td><input type="text" size="100" maxlength="50"  name="TLP_TIT_STU_SPC" value="<%=Formatter.format(strTLP_TIT_STU_SPC)%>">
	 </td></tr>
	 <tr><td valign="top" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</b></td>
	 <td><textarea rows="3" style="width:525" cols="102" name="DES_TIT_STU_SPC"><%=Formatter.format(strDES_TIT_STU_SPC)%></textarea>
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
 
