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
    <version number="1.0" date="19/01/2004" author="Kushkarov Yura">
	      <comments>
				  <comment date="19/01/2004" author="Kushkarov Yura">
				   <description>Shablon formi ANA_FUZ_AZL_Form.jsp</description>
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
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>
<%@ page import="com.apconsulting.luna.ejb.FunzioniAziendali.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script language="JavaScript" src="../_scripts/textarea.js"></script>
<script>
document.write("<title>" + getCompleteMenuPath(SubMenuOrganizzazione,2) + "</title>");
</script>
<script>
window.dialogWidth="560px";
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
	String strCOD_FUZ_AZL="";
  String strNOM_FUZ_AZL="";
	//   *Not require Fields*
	String strDES_FUZ_AZL="";


IFunzioniAziendali funzioniAziendali = null;
if(request.getParameter("ID")!=null)
{
    //out.print(request.getParameter("ID"));
		strCOD_FUZ_AZL = request.getParameter("ID");
	// editing of ala
	//getting of ala object
	//EdFlag=true;
		IFunzioniAziendaliHome home=(IFunzioniAziendaliHome)PseudoContext.lookup("FunzioniAziendaliBean"); 
		Long COD_FUZ_AZL=new Long(strCOD_FUZ_AZL);
		funzioniAziendali = home.findByPrimaryKey(COD_FUZ_AZL);
		// getting of object variables
		strNOM_FUZ_AZL=funzioniAziendali.getNOM_FUZ_AZL();
		//--- 
		strDES_FUZ_AZL=funzioniAziendali.getDES_FUZ_AZL();/**/
}
%>

<!-- form for addind  -->
<form action="ANA_FUZ_AZL_Set.jsp?par=add"  method="POST" target="ifrmWork">
  <table  width="100%">
  <tr><td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuOrganizzazione,2,<%=request.getParameter("ID")%>));
    </script>
  </td></tr>
  <tr><td></td>
  		<table width="100%" border="0">
 			<!-- ############################ -->
  			<%@ include file="../_include/ToolBar.jsp" %>
      		<%
                ToolBar.bCanDelete=(funzioniAziendali!=null);
                ToolBar.bShowSave = !ApplicationConfigurator.isModuleEnabled(MODULES.GEST_DPD_EXT);
            %>
			<%=ToolBar.build(2)%>
 			<!-- ########################### -->
		</table>

	<input name="SBM_MODE" type="hidden" value="<%if(strCOD_FUZ_AZL==""){out.print("new");}else{out.print("edt");}%>">
	<input name="COD_FUZ_AZL" type="hidden" value="<%=strCOD_FUZ_AZL%>">
<table width="100%" cellspacing="2">
  <tr>
	<td>
  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.ruolo.aziendale")%></legend>
   <table  width="100%" border="0">
   <tr>
   <td width="15%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
	 <td ><input tabindex="1"  style="width:100%;" type="text" maxlength="30" name="NOM_FUZ_AZL" value="<%=strNOM_FUZ_AZL%>">
   </td></tr>
	 <tr><td valign="top" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
	 <td>
         <s2s:textarea maxlength="350" cols="1" rows="5" tabindex="2" style="height:50" style="width:100%;" name="DES_FUZ_AZL"><%=strDES_FUZ_AZL%></s2s:textarea>
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
<!-- /form for addind  -->

<iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
</body>
</html>
