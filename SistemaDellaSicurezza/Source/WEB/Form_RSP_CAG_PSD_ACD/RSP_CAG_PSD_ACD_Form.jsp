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
				   <description>Forma dla dobavlenia znacheniy v tabe Responsabili Categoria v forme CAG_PCD_ACD</description>
				 </comment>		
				  <comment date="28/02/2004" author="Alexey Kolesnik">
				   <description> Rebuild for dynamic tabbars </description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.CategoriePreside.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_include/ToolBar.jsp" %>
<%@ include file="../_include/ComboBox-Dipendente.jsp" %>

<html>
<head><title><%=ApplicationConfigurator.LanguageManager.getString("Responsabili.delle.categorie")%></title></head>
<link rel="stylesheet" href="../_styles/style.css">
<body>
<script>
window.dialogWidth="490px";
window.dialogHeight="270px";
</script>

<%
long lCOD_DPD = 0;
//new
	String strCOD_CAG_PSD_ACD=(String)request.getParameter("ID_PARENT");
 if(request.getParameter("ID")!=null)
 {
 			lCOD_DPD = new Long(request.getParameter("ID")).longValue();
 }
	long lCOD_AZL = Security.getAzienda();
	String	strRAG_SCL_AZL="";
	String strNOM_CAG_PSD_ACD=""; //nom_cag_psd_acd
// geting categoria preside	
  ICategoriePreside CategoriePreside=null;
	ICategoriePresideHome home=(ICategoriePresideHome)PseudoContext.lookup("CategoriePresideBean"); 
	Long for_id=new Long(strCOD_CAG_PSD_ACD);
	CategoriePreside = home.findByPrimaryKey(for_id);
	// getting of object variables
	strNOM_CAG_PSD_ACD=CategoriePreside.getNOM_CAG_PSD_ACD();//good
	// Get Aziende/Ente
	IAzienda azienda;
	IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");
	Long azl_id=new Long(lCOD_AZL);
	azienda = AziendaHome.findByPrimaryKey(azl_id);
	strRAG_SCL_AZL= azienda.getRAG_SCL_AZL();
%>

<form action="RSP_CAG_PSD_ACD_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="Hidden" value="<%=(lCOD_DPD==0)?"new":"edt"%>">
<table width="100%" style="font-size:20;font-family:Verdana;" border="0">
  <tr>
        <td class="title" width="100%"><%=ApplicationConfigurator.LanguageManager.getString("Responsabili.delle.categorie")%></TD> 
	<table width="100">
	<!-- ############################ -->
<%ToolBar.bCanDelete=(lCOD_DPD!=0);%>
<%//ToolBar.bShowNew=false;%>
<%ToolBar.bShowSearch=false;%>
<%ToolBar.bShowPrint=false;%>
<%ToolBar.bShowReturn=false;%>
<%=ToolBar.build(3)%> 
<!-- ########################### -->

	</table>
                <table width="100%"> <tr><td>
                            <fieldset style="font-size:15;font-family:Verdana; padding:10 10 10 10">
                                <legend><%=ApplicationConfigurator.LanguageManager.getString("Responsabile.di.categoria")%></legend>
                                <table width="100%" border="0" style="font-size:12;font-family:Verdana;" cellpadding="0" cellspacing="1">
                                    <tr>
                                        <td></td>
                                        <td><input name="SBM_MODE" type="hidden" value="new"></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>	
                                            <input name="COD_CAG_PSD_ACD" id="COD_CAG_PSD_ACD" type="hidden" value="<%=strCOD_CAG_PSD_ACD%>">
                                            <input name="COD_AZL" type="hidden" value="<%=lCOD_AZL%>">
                                        </td>
                                    </tr>
                                    <tr>
                                    <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Categoria.del.presidio")%>&nbsp;</b></td>
                                    <td colspan="2"><input size="50" type="text" readonly id="" name="" maxlength="30" value="<%=strNOM_CAG_PSD_ACD%>"></td>
                                    <tr>
                                        <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
                                        <td ><input size="50" id="" readonly type="text" name="" maxlength="15" value="<%=strRAG_SCL_AZL%>"></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="100%">
                                            <fieldset>
                                                <legend><%=ApplicationConfigurator.LanguageManager.getString("Categoria.presidio")%></legend>
                                                <table border="0" cellpadding="0" cellspacing="2" width="100%">
                                                    <tr>
                                                        <td align="right" width="29%"><b><%=ApplicationConfigurator.LanguageManager.getString("Dipendente")%>&nbsp;</b></td>
                                                        <td>
                                                            <input type="hidden" name="oldCOD_DPD" value="<%=lCOD_DPD%>" />
                                                            
                                                            <select name="COD_DPD" style="width:250;">
                                                                <option value=''>  </option>
                                                                <% 
                                                                IDipendenteHome d_home=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
                                                                out.print(BuildDipendenteComboBox(d_home, lCOD_DPD, lCOD_AZL));
                                                                %>
                                                            </select>&nbsp;&nbsp;
                                                        </td>
                                                    </tr>
                                                </table>	  
                                            </fieldset>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                    </td></tr>
                </table>
		</td> 
 </tr>
</table>
</form>
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
</body>
</html>
