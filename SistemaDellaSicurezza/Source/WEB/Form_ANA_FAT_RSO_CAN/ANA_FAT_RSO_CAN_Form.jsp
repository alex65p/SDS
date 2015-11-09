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

<%@page import="com.apconsulting.luna.ejb.FattoriRischioCantiere.IFattoriRischioCantiereHome"%>
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server
%>

<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>
<%@ page import="com.apconsulting.luna.ejb.IndirizzoPostaElettronica.*" %>
<%@ page import="com.apconsulting.luna.ejb.CollegamentoInternet.*" %>
<%@ page import="com.apconsulting.luna.ejb.CategorieFattoreRischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.FattoriRischioCantiere.*" %>
<%@ page import="com.apconsulting.luna.ejb.NormativeSentenze.*" %>


<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<!--%@ include file="ANA_FAT_RSO_Util.jsp" %-->
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuRischiCantiere,0) + "</title>");
</script>
  <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
	<link rel="stylesheet" href="../_styles/tabs.css">
	<script language="JavaScript" src="../_scripts/tabs.js"></script>
	<script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>

</head>
<script>
//alert(window.dialogWidth+" x "+window.dialogHeight);
window.dialogWidth="780px";
window.dialogHeight="260px";
</script>
<body>
<%
	//   *require Fields*
	String strCOD_FAT_RSO="";
	String strNOM_FAT_RSO="";
  	String strNUM_FAT_RSO="";
	//   *Not require Fields*
  	String strDES_FAT_RSO="";
	//--CAG_FAT_RSO_TAB fields
  	String strCOD_CAG_FAT_RSO="";
	String strNOM_CAG_FAT_RSO="";
	//--ANA_NOR_SEN_TAB fields
	String strCOD_NOR_SEN="";
	String strTIT_NOR_SEN="";
	String strDAT_NOR_SEN="";
	//--vse

IFattoriRischioCantiere fr=null;
INormativeSentenze norsen=null;
INormativeSentenzeHome nhome=(INormativeSentenzeHome)PseudoContext.lookup("NormativeSentenzeBean");
IAnagrDocumento anadoc=null;
IAnagrDocumentoHome dhome=(IAnagrDocumentoHome)PseudoContext.lookup("AnagrDocumentoBean");

if( request.getParameter("ID")!=null){
		strCOD_FAT_RSO = request.getParameter("ID");
		IFattoriRischioCantiereHome home=(IFattoriRischioCantiereHome)PseudoContext.lookup("FattoriRischioCantiereBean");
		Long lCOD_FAT_RSO=new Long(strCOD_FAT_RSO);
		fr = home.findByPrimaryKey(lCOD_FAT_RSO);
		// getting of object variables
		strNOM_FAT_RSO=Formatter.format(fr.getNOM_FAT_RSO());
		strNUM_FAT_RSO=Formatter.format(fr.getNUM_FAT_RSO());
		strCOD_CAG_FAT_RSO=Formatter.format(fr.getCOD_CAG_FAT_RSO());
		strDES_FAT_RSO=Formatter.format(fr.getDES_FAT_RSO());
		strCOD_NOR_SEN=Formatter.format(fr.getCOD_NOR_SEN());
		//out.print("strCOD_NOR_SEN: "+strCOD_NOR_SEN);
		//if (true) return;
		//---ANA_NOR_SEN_TAB
		if (!strCOD_NOR_SEN.equals("0")){
			Long lCOD_NOR_SEN=new Long(strCOD_NOR_SEN);
			norsen = nhome.findByPrimaryKey(lCOD_NOR_SEN);
			strTIT_NOR_SEN=Formatter.format(norsen.getTIT_NOR_SEN());
			strDAT_NOR_SEN=Formatter.format(norsen.getDAT_NOR_SEN());
		}
}
%>

<!-- form for addind  FattoriRischo-->
<form action="ANA_FAT_RSO_CAN_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="Hidden" value="<%=(strCOD_FAT_RSO.equals(""))?"new":"edt"%>">
<input type="hidden" name="COD_FAT_RSO" value="<%=strCOD_FAT_RSO%>">
  <table  width="100%" border="0" >
  <tr><td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuRischiCantiere,0,<%=request.getParameter("ID")%>));
    </script>
  </td></tr>
  <tr><td>
 			<table width="100%" border="0">
 				 <%@ include file="../_include/ToolBar.jsp" %>
 	 			 <%
  					ToolBar.bCanDelete=(fr!=null);
                                        ToolBar.bShowPrint=false;
  					ToolBar.strPrintUrl="SchedaFattoreRischio.jsp?";
  				 %>
  				 <%=ToolBar.build(2)%>
			</table>
  <tr><td valign="top">
  <fieldset>
  <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.anagrafica.fattore.di.rischio")%></legend>
	    <table width="100%" align="center" cellspacing="3">
          <tr>
            <td align="right" width="15%"> <div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome.fattore.di.rischio")%>&nbsp;</b></div></td>
            <td >
<input tabindex="1" style="width:100%;" type="text" name="NOM_FAT_RSO" maxlength="50" value="<%=strNOM_FAT_RSO%>">
            </td>
          </tr>
          <tr>
            <td align="right" width="15%" valign="top">
                <div align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</div></td>
            <td colspan="4"><textarea style="width:100%;" tabindex="6" rows="5" cols="100" name="DES_FAT_RSO"><%=strDES_FAT_RSO%></textarea></td>
          </tr>
        </table>
	</fieldset>
	</td></tr>
	
  <tr><td colspan="100%" align="center"><div id="dContainer" class="mainTabContainer" style="width:750px"></div></td></tr>
  </table>

</form>
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
</body>
</html>
