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
    <version number="1.0" date="24/01/2004" author="Khomenko Juliya">
	      <comments>
			  <comment date="24/01/2004" author="Khomenko Juliya">
				   <description>ANA_FRS_S_Form.jsp</description>
			 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server
%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/FraseS/FraseSBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/FraseS/FraseSBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuAgentiChimici,1) + "</title>");
</script>
<LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">

</head>
<body>
 
<%
	long	lCOD_FRS_S = 0;			//1 
	String	strNUM_FRS_S = "";		//2
	String	strDES_FRS_S = "";		//3
	IFraseS FraseS=null;
	IFraseSHome home=(IFraseSHome)PseudoContext.lookup("FraseSBean");

	if(request.getParameter("ID")!=null)
	{
		String strCOD_FRS_S = request.getParameter("ID");
		Long frs_s_id=new Long(strCOD_FRS_S);
		FraseS = home.findByPrimaryKey(frs_s_id);
	    lCOD_FRS_S = frs_s_id.longValue(); 				//1
		strNUM_FRS_S = FraseS.getNUM_FRS_S();			//2
		strDES_FRS_S = FraseS.getDES_FRS_S();			//3
	}	
%>

<!-- form for addind  FraseS-->
<form action="ANA_FRS_S_Set.jsp"  method="" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="Hidden" value="<%=(lCOD_FRS_S==0)?"new":"edt"%>">
<input type="hidden" name="FRS_S_ID" value="<%=lCOD_FRS_S%>">
  <table  width="100%">
  <tr><td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuAgentiChimici,1,<%=request.getParameter("ID")%>));
    </script>
  </td></tr>  
  <tr><td>
  		<table width="100%" border="0">
		<!-- ############################ -->  		
			<%@ include file="../_include/ToolBar.jsp" %>      
			<%
				ToolBar.bCanDelete=(FraseS!=null);
				ToolBar.strPrintUrl="SchedaFraseS.jsp?";
			%>		
			<%=ToolBar.build(2)%> 
		<!-- ########################### --> 
		</table>
<tr><td valign="top">
  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.frase.S")%></legend>
   <table  width="100%" border="0">
   <tr> 
   <td width="15%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Frase")%>&nbsp;</b></td>
	 <td  width="85%"><input tabindex="1" style="width:100%;" type="text" maxlength="15" name="NOME" value="<%=strNUM_FRS_S%>">
   </td></tr>
	 <tr width="15%"><td valign="top" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
	 <td width="85%"><textarea style="width:100%;" tabindex="2" rows="3" cols="87" name="DESC"><%=strDES_FRS_S%></textarea>
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
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
</body>
</html>
