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
				   <description>Shablon formi ANA_NON_CFO_Form.jsp</description>
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

<%@ include file="../src/com/apconsulting/luna/ejb/Sottosettori/SottosettoriBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/Sottosettori/SottosettoriBean.jsp" %>


<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuNormative,1) + "</title>");
</script>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">

</head>
<script>
window.dialogWidth="720px";
window.dialogHeight="360px";
</script>
<body>

<%
	long			  lCOD_SOT_SET = 0;			    //1 
	String			strNOM_SOT_SET = "";			//2
	String			strDES_SOT_SET = "";			//3

		ISottosettori Sottosettori=null;
		ISottosettoriHome home=(ISottosettoriHome)PseudoContext.lookup("SottosettoriBean");

	if(request.getParameter("ID")!=null)
	{
		String strCOD_SOT_SET = request.getParameter("ID");
		//lCOD_SOT_SET = request.getParameter("ID");

		Long sot_set_id=new Long(strCOD_SOT_SET);
		Sottosettori = home.findByPrimaryKey(sot_set_id);

    lCOD_SOT_SET = sot_set_id.longValue(); 						//1
		strNOM_SOT_SET = Sottosettori.getNOM_SOT_SET();					//2
		strDES_SOT_SET = Sottosettori.getDES_SOT_SET();					//3 - Nullable
	}	
%>


<!-- form for addind  piano-->
<form action="ANA_SOT_SET_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="Hidden" value="<%=(lCOD_SOT_SET==0)?"new":"edt"%>">
<input type="hidden" name="SOT_SET_ID" value="<%=lCOD_SOT_SET%>">
<table width="100%" border="0" cellpadding="10" cellspacing="0">
<tr>

 <td valign="top">
  <table  width="100%">
  <tr><td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuNormative,1,<%=request.getParameter("ID")%>));
    </script>      
  </td></tr>
  <tr>
	<td>
	<!-- ############################ -->
	<table width="100%" border="0">
    <%@ include file="../_include/ToolBar.jsp" %>      
    <%ToolBar.bCanDelete=(Sottosettori!=null);
    ToolBar.bShowPrint=false;
    ToolBar.bShowReturn=false;
    %>		
    <%=ToolBar.build(2)%> 
	</table>
<!-- ########################### --> 	
  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.sottosettore")%></legend>
   <table  width="100%" border="0" cellpadding="0" cellspacing="10">
   <tr><td align="right" width="15%"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
	 <td ><input tabindex="1" style="width:100%;" maxlength="50" type="text" name="NOME" value="<%=strNOM_SOT_SET%>">
	 </td></tr>
	 <tr><td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
	 <td><textarea tabindex="2" rows="10" cols="50" name="DESC"><%=strDES_SOT_SET%></textarea>
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
