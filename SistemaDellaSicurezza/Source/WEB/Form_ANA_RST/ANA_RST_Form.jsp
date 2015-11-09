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
    <version number="1.0" date="22/01/2004" author="Pogrebnoy Yura">
	      <comments>
				  <comment date="22/01/2004" author="Pogrebnoy Yura">
				   <description>Shablon formi ANA_RST_Form.jsp</description>
				 </comment>		
				  <comment date="24/01/2004" author="Alexey Kolesnik">
				   <description> added elements to work as TAB element on Anagrafica Domande form </description>
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

<%@ include file="../src/com/apconsulting/luna/ejb/Risposta/RispostaBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/Risposta/RispostaBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuTestVerifica,2) + "</title>");
</script>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">

</head>
<script>
window.dialogWidth="550px";
window.dialogHeight="290px";
</script>

<body>
<%
	//boolean EdFlag=false;		//flag of editing
	//   *require Fields*
	String strCOD_RST="";
  String strNOM_RST="";
	//   *Not require Fields*
	String strDES_RST="";
	String strID_PARENT = ""; // ANA_DMD_TAB.COM_DMD
	strID_PARENT = Formatter.format(request.getParameter("ID_PARENT")); // ANA_DMD_TAB.COM_DMD


IRisposta ala=null;
if( request.getParameter("ID")!=null)
{
		strCOD_RST = request.getParameter("ID");
	// editing of risposta
	//getting of risposta object
		IRispostaHome home=(IRispostaHome)PseudoContext.lookup("RispostaBean"); 
		Long COD_RST=new Long(strCOD_RST);
		ala = home.findByPrimaryKey(COD_RST);
		// getting of object variables
		strNOM_RST=Formatter.format(ala.getNOM_RST());
		//--- 
		strDES_RST=Formatter.format(ala.getDES_RST());
}
%>

<!-- form for addind  -->
<form action="ANA_RST_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="ID_PARENT" type="Hidden" value="<%=strID_PARENT%>">
<table width="100%" border="0">
<tr>
 <td width="10" height="100%" valign="top">

</td>
 <td valign="top">
  <table  width="100%">
  <tr><td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuTestVerifica,2,<%=request.getParameter("ID")%>));
    </script>
  </td></tr>

<input name="SBM_MODE" type="Hidden" value="<%if("".equals(strCOD_RST)){out.print("new");}else{out.print("edt");}%>">
<input name="COD_RST" type="Hidden" value="<%=strCOD_RST%>">

  <tr>
	<td>
<!-- ********************************** -->
<table width="100%" border="0"> 
<%@ include file="../_include/ToolBar.jsp" %>      
<%ToolBar.bCanDelete=(ala!=null);%>		
<%=ToolBar.build(3)%>
</table>
<!-- ***************************** -->
<br>
  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.risposta")%></legend>
   <table  width="100%" border="0">
   <tr>
   <td align="right" width="15%"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
	 <td width="85%"><input tabindex="1" style="width:100%;" type="text" maxlength="70" name="NOM_RST" value="<%=strNOM_RST%>">
   </td></tr>
	 <tr><td width="15%"  align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
	 <td width="85%"><textarea style="width:100%;" tabindex="2" cols="120" rows="4" name="DES_RST"><%=strDES_RST%></textarea></td>
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
