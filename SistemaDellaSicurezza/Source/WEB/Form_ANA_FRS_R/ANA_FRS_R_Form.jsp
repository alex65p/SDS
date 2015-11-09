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
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/FraseR/FraseRBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/FraseR/FraseRBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>
 
<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuAgentiChimici,0) + "</title>");
</script>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">

</head>
<script>
window.dialogWidth="710px";
window.dialogHeight="340px";
</script>

<body>
 
<%
	long			  lCOD_FRS_R = 0;			    //1 
	String			strNUM_FRS_R = "";			//2
	String			strDES_FRS_R = "";			//3
	double			  lVAL_INA = 0;			      //4
	double			  lVAL_CCP = 0;			      //5
	double			  lVAL_ING = 0;			      //6
	double			  lVAL_IRR = 0;			      //7
	double			  lVAL_ESP = 0;			      //8
	double			  lVAL_UNI = 0;			      //9
	
		IFraseR FraseR=null;
		IFraseRHome home=(IFraseRHome)PseudoContext.lookup("FraseRBean");

	if(request.getParameter("ID")!=null)
	{
		String strCOD_FRS_R = request.getParameter("ID");
		//lCOD_FRS_R = request.getParameter("ID");

		Long frs_s_id=new Long(strCOD_FRS_R);
		FraseR = home.findByPrimaryKey(frs_s_id);

    lCOD_FRS_R = frs_s_id.longValue(); 						//1
		strNUM_FRS_R = FraseR.getNUM_FRS_R();					//2
		strDES_FRS_R = FraseR.getDES_FRS_R();					//3
		lVAL_INA = FraseR.getVAL_INA();								//4
		lVAL_CCP = FraseR.getVAL_CCP();								//5
		lVAL_ING = FraseR.getVAL_ING();								//6
		lVAL_IRR = FraseR.getVAL_IRR();								//7
		lVAL_ESP = FraseR.getVAL_ESP();								//8
		lVAL_UNI = FraseR.getVAL_UNI();								//9
	}	
%>



<!-- form for addind  FraseR-->
<form action="ANA_FRS_R_Set.jsp"  method="" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="Hidden" value="<%=(lCOD_FRS_R==0)?"new":"edt"%>">
<input type="hidden" name="FRS_R_ID" value="<%=lCOD_FRS_R%>">
<table width="100%" border="0">
<tr>
 </td>
 <td valign="top">
  <table  width="100%">
  <tr><td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuAgentiChimici,0,<%=request.getParameter("ID")%>));
    </script>
  </td></tr>
  <tr>
	<td> 
	<table border=0>
	<!-- ############################ -->  		
	<%@ include file="../_include/ToolBar.jsp" %>      
	<%ToolBar.bCanDelete=(FraseR!=null);
		ToolBar.strPrintUrl="SchedaFraseR.jsp?";
	%>		
	<%=ToolBar.build(2)%> 
	<!-- ########################### --> 
	</table>
	<fieldset>
	<legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.frase.R")%></legend>
	<table  width="100%" border="0">
	<tr>
   	<td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Frase")%>&nbsp;</b></td>
	 	<td colspan="3"><input tabindex="1" size="100" maxlength="15" type="text" name="NOME" value="<%=strNUM_FRS_R%>"></td>
  </tr>
	<tr>
	 	<td valign="top" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
	 	<td colspan="3"><textarea tabindex="2" style="width:99%;" rows="5" name="DESC"><%=strDES_FRS_R%></textarea>
                 </td>
  </tr>
  <tr>
   	<td align="right"><%=ApplicationConfigurator.LanguageManager.getString("INA.(inalazione)")%>&nbsp;</td>
	 	<td><input tabindex="3" size="40%" maxlength="11" type="text" name="INA" value="<%=lVAL_INA%>"></td>
	 	<td align="right" width="10%"><%=ApplicationConfigurator.LanguageManager.getString("C.C.P.(contatto.con.la.pelle)")%>&nbsp;</td>
	 	<td><input tabindex="4" size="40%" maxlength="11" type="text" name="CCP" value="<%=lVAL_CCP%>"></td>
  </tr>
	<tr>
		<td align="right"><%=ApplicationConfigurator.LanguageManager.getString("ING.(ingestione)")%>&nbsp;</td>
		<td><input tabindex="5" size="40%" maxlength="11" type="text" name="ING" value="<%=lVAL_ING%>"></td>
	 	<td align="right" width="10%"><%=ApplicationConfigurator.LanguageManager.getString("IRR.(irritazione)")%>&nbsp;</td>
	 	<td><input tabindex="6" size="40%" maxlength="11" type="text" name="IRR" value="<%=lVAL_IRR%>"></td>
  </tr>
	<tr>
		<td align="right"><%=ApplicationConfigurator.LanguageManager.getString("ESP.(esposizione.ai.rischi.chimici)")%>&nbsp;</td>
	 	<td><input tabindex="7" size="40%" maxlength="11" type="text" name="ESP" value="<%=lVAL_ESP%>"></td>
   	<td align="right" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Unico.(rischio.chimico)")%>&nbsp;</td>
	 	<td><input tabindex="7" size="40%" maxlength="11" type="text" name="UNI" value="<%=lVAL_UNI%>"></td>
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
<!-- /form for addind  FraseR-->
   <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>

</body> 
</html>
