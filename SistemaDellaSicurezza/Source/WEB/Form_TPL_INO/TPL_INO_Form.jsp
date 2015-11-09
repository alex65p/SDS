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
    <version number="1.0" date="24/01/2004" author="Podmasteriev Alexandr">
	      <comments>
				  <comment date="24/01/2004" author="Podmasteriev Alexandr">
				   <description>Shablon formi TPL_INO_Form.jsp</description>
				 </comment>		
				 <comments>
				  <comment date="21/01/2004" author="Podmasteriev Alexandr">
				   <description>polychenie dannih TPL_INO_Form.jsp</description>
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

<%@ include file="../src/com/apconsulting/luna/ejb/TipologieAccertamenti/TipologieAccertamentiBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TipologieAccertamenti/TipologieAccertamentiBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuInfortuni,5) + "</title>");
</script>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">

</head>
<body>

<%
	String 	strCOD_TPL_INO="";			    //1 
	String 	strNOM_TPL_INO="";

ITipologieAccertamenti TipologieAccertamenti=null;
if(request.getParameter("ID")!=null)
{
		
		strCOD_TPL_INO = request.getParameter("ID");
	
	//getting of TipologieAccertamenti object
		ITipologieAccertamentiHome home=(ITipologieAccertamentiHome)PseudoContext.lookup("TipologieAccertamentiBean"); 
		Long cpl_id=new Long(strCOD_TPL_INO);
		TipologieAccertamenti = home.findByPrimaryKey(cpl_id);
		
		// getting of object variables
		strNOM_TPL_INO=TipologieAccertamenti.getNOM_TPL_INO();
}	
%>



<!-- form for addind  Utenzei-->
<form action="TPL_INO_Set.jsp"  method="POST" target="ifrmWork">
<input name="SBM_MODE" type="Hidden" value="<%=(strCOD_TPL_INO=="")?"new":"edt"%>">
<input type="hidden" name="CPL_ID" value="<%=strCOD_TPL_INO%>">
<table width="100%" border="0">
<tr>
 <td width="10" height="100%" valign="top">
 </td>
 <td valign="top">
  <table  width="100%">
  <tr><td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuInfortuni,5,<%=request.getParameter("ID")%>));
    </script>      
  </td></tr>
  <tr>
	<td>
	<table width="100%">
    <!-- ############################ -->
    <%@include file="../_include/ToolBar.jsp" %>
    <%ToolBar.bCanDelete=(TipologieAccertamenti!=null);%>	
    <%=ToolBar.build(2)%> 
    <!-- ########################### -->	
	</table>
   <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Tipologia.accertamento")%></legend>
   <table  width="100%" border="0">
	 <tr><td colspan="100">
   <table  width="100%" border="0">
     <tr>
		 		 <td align="left" valign="top"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</b></td>
	   		 <td  colspan="2" width="550px">
				 <textarea tabindex="1" name="NOM_TPL_INO" cols="85" rows="3" style="width:'450px'"><%=strNOM_TPL_INO%></textarea>
				 </td>
		 </tr>
	 </table>
   </td></tr> 
   </table>	  
	 </fieldset> 
	 </td></tr>
  </table>
 </td>
</tr>
</table>
</form>
<!-- /form for addind  Utenzei-->
   <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>

</body>
</html>
