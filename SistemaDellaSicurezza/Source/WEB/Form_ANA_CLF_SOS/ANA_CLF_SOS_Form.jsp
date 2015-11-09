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
    <version number="1.0" date="23/01/2004" author="Kushkarov Yura">
	      <comments>
				  <comment date="23/01/2004" author="Kushkarov Yura">
				   <description>Shablon formi CLF_SOS_Form.jsp</description>
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

<%@ include file="../src/com/apconsulting/luna/ejb/ClassificazioneAgentiChimici/ClassificazioneAgentiChimiciBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/ClassificazioneAgentiChimici/ClassificazioneAgentiChimiciBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuAgentiChimici,2) + "</title>");
</script> 
<script>
window.dialogWidth="630px";
 window.dialogHeight="220px";
</script>

<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">

</head>
<body>
<%
	//boolean EdFlag=false;		//flag of editing
	//   *require Fields*
	String strCOD_CLF_SOS="";
  //String strNOM_CLF_SOS="";
	String strDES_CLF_SOS="";


IClassificazioneAgentiChimici ClassificazioneAgentiChimici=null;
if( request.getParameter("ID")!=null)
{
		strCOD_CLF_SOS = request.getParameter("ID");
	// editing of ala
	//getting of ala object
		IClassificazioneAgentiChimiciHome home=(IClassificazioneAgentiChimiciHome)PseudoContext.lookup("ClassificazioneAgentiChimiciBean"); 
		Long COD_CLF_SOS=new Long(strCOD_CLF_SOS);
		ClassificazioneAgentiChimici = home.findByPrimaryKey(COD_CLF_SOS);
		// getting of object variables
		strDES_CLF_SOS=ClassificazioneAgentiChimici.getDES_CLF_SOS();
		//---		
}
%>

<!-- form for addind  -->
<form action="ANA_CLF_SOS_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<table width="100%" border="0">

<tr>
 <td width="10" height="100%" valign="top">
 <!-- <button type="button" class="menu" >&nbsp;1&nbsp;</button><br>
 <button type="button" class="menu">&nbsp;2&nbsp;</button>
 <button type="button" class="menu">&nbsp;3&nbsp;</button><br>
 <button type="button" class="menu">&nbsp;4&nbsp;</button>
 <button type="button" class="menu">&nbsp;5&nbsp;</button><br>
 -->


  <table  width="100%">
  <tr><td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuAgentiChimici,2,<%=request.getParameter("ID")%>));
    </script>


  </td></tr>

<input name="SBM_MODE" type="Hidden" value="<%if(strCOD_CLF_SOS==""){out.print("new");}else{out.print("edt");}%>">
<input name="COD_CLF_SOS" type="Hidden" value="<%=strCOD_CLF_SOS%>">

  <tr>
	<td>
<!-- ############################ -->
<table width="100%" border="0">
  		<%@ include file="../_include/ToolBar.jsp" %>
      <%ToolBar.bCanDelete=(ClassificazioneAgentiChimici!=null);%>
		<%=ToolBar.build(2)%>
</table>
 <!-- ########################### -->
  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Classificazione.agente.chimico")%></legend>
   <table  width="100%" border="0">
	 <tr><td valign="top" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</b></td>
	 <td><input tabindex="1" maxlength="50" size="100" style="height:'50'" name="DES_CLF_SOS" type="text" value="<%=strDES_CLF_SOS%>"></td>
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

<iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
</body>
</html>
