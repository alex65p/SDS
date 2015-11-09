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
    <version number="1.0" date="19/01/2004" author="Pogrebnoy Yura">
	      <comments>
				  <comment date="19/01/2004" author="Pogrebnoy Yura">
				   <description>Shablon formi ANA_IMO_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.Immobili.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
document.write("<title>" + getCompleteMenuPath(SubMenuDistribuzioneTerritorialie,2) + "</title>");
</script>
<script>
window.dialogWidth="730px";
window.dialogHeight="250px";
</script>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">

</head>
<body>
<%
	//boolean EdFlag=false;		//flag of editing
	//   *require Fields*
	String strCOD_IMO="";
  String strNOM_IMO="";
	//   *Not require Fields*
	String strDES_IMO="";


IImmobili imo=null;
if( request.getParameter("ID")!=null)
{
		strCOD_IMO = request.getParameter("ID");
		IImmobiliHome home=(IImmobiliHome)PseudoContext.lookup("ImmobiliBean"); 
		Long COD_IMO=new Long(strCOD_IMO);
		imo = home.findByPrimaryKey(COD_IMO);
		strNOM_IMO=imo.getNOM_IMO();
		strDES_IMO=imo.getDES_IMO();
}
%>

<!-- form for addind  -->
<form action="ANA_IMO_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
        <table width="100%" border="0">
            <tr><td class="title">
                    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuDistribuzioneTerritorialie,2,<%=request.getParameter("ID")%>));
                    </script>
            </td></tr>
        </table>
	<input name="SBM_MODE" type="Hidden" value="<%if(strCOD_IMO==""){out.print("new");}else{out.print("edt");}%>">
	<input name="COD_IMO" type="Hidden" value="<%=strCOD_IMO%>">
	<table>
		<tr>
			<td>
				<%@ include file="../_include/ToolBar.jsp" %>
				<%	
					ToolBar.bCanDelete=(imo!=null);
					ToolBar.bShowPrint=false;
				%>
				<%=ToolBar.build(2)%>
	</table>
<table cellspacing="2">
        <tr>	
	<td>
  	<fieldset>
		<legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.immobile")%></legend>
   		<table  width="100%" border="0">
   		<tr>
   			<td align="right"><div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></div></td>
	 		<td><input tabindex="1" size="122%" type="text" maxlength="50" name="NOM_IMO" value="<%=strNOM_IMO%>"></td>
		</tr>
	 	<tr>
			<td valign="top" align="right"> <div align="left"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</div></td>
	 		<td><textarea tabindex="2" cols="100%" rows="4" name="DES_IMO"><%=strDES_IMO%></textarea></td>
	 	</tr>
   		</table>	 
	 </fieldset>
	 </td>
</tr>
</table>

</form>
<!-- /form for addind  -->

<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
</body>
</html>
