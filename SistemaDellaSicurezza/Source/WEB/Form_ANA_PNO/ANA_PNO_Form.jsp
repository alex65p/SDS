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
    <version number="1.0" date="15/01/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="15/01/2004" author="Khomenko Juliya">
				   <description>Shablon formi ANA_PNO_Form.jsp</description>
				  </comment>		
      		<comment date="31/01/2004" author="Khomenko Juliya">
				   <description>Vnesla toolbar</description>
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
<%@ page import="com.apconsulting.luna.ejb.Piano.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
<head>
<script>
document.write("<title>" + getCompleteMenuPath(SubMenuDistribuzioneTerritorialie,4) + "</title>");
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
	long			  lCOD_PNO = 0;			    //1 
	String			strNOM_PNO = "";			//2
	String			strDES_PNO = "";			//3

		IPiano Piano=null;
		IPianoHome home=(IPianoHome)PseudoContext.lookup("PianoBean");

	if(request.getParameter("ID")!=null)
	{
		String strCOD_PNO = request.getParameter("ID");
		Long pno_id=new Long(strCOD_PNO);
		Piano = home.findByPrimaryKey(pno_id);

    lCOD_PNO = pno_id.longValue(); 						//1
		strNOM_PNO = Piano.getNOM_PNO();					//2
		strDES_PNO = Piano.getDES_PNO();					//3 - Nullable
	}	
%>



<!-- form for addind  piano-->
<form action="ANA_PNO_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="Hidden" value="<%=(lCOD_PNO==0)?"new":"edt"%>">
<input type="hidden" name="PNO_ID" value="<%=lCOD_PNO%>">



<table width="100%" border="0">



<tr>
 <td valign="top">
  <table  width="100%">
  <tr><td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuDistribuzioneTerritorialie,4,<%=request.getParameter("ID")%>));
    </script>
  </td></tr>
  <tr>
	<td>

<!-- ############################ --> 	
<table width="100%" border="0">		
<%@ include file="../_include/ToolBar.jsp" %>      
<%ToolBar.bCanDelete=(Piano!=null);
ToolBar.bShowPrint=false;
ToolBar.bShowReturn=false;
%>	
<%=ToolBar.build(2)%> 
</table> 
<!-- ########################### -->
  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.piano")%></legend>
   <table  width="100%" border="0">
   <tr>
   <td width="15%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
	 <td width="85%" ><input tabindex="1" style="width:100%;" maxlength="50" type="text" name="NOME" value="<%=strNOM_PNO%>">
   </td></tr>
	 <tr><td valign="top" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
	 <td><textarea style="width:100%;" tabindex="2" rows="5" cols="87" name="DESC"><%=strDES_PNO%></textarea>
	 </td>
	 </tr>
   </td></tr>
   </table>	 
	 </fieldset></td></tr>
  </table>
 </td>
</tr>  
</table>
</form>
<!-- /form for addind  piano-->
   <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>

</body>
</html>
