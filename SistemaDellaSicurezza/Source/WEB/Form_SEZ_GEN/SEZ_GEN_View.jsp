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

<div id="divContent">
<%
/*
<file>
  <versions>
    <version number="1.0" date="21/01/2004" author="Pogrebnoy Yura">
      <comments>
				  <comment date="21/01/2004" author="Pogrebnoy Yura">
				   <description>Chernovik vieW</description>
				 </comment>
		     <comment date="29/03/2004" author="Khomenko Juli">
			     <description>Transform View</description>
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
<%@ page import="com.apconsulting.luna.ejb.SezioneGenerale.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<%
Checker c = new Checker();
//long lCOD_SEZ_GEN = c.checkLong("COD_SEZ_GEN", request.getParameter("COD_SEZ_GEN"), false);
long lCOD_PSC = c.checkLong("COD_PSC", request.getParameter("ID_PARENT"), false);
long lCOD_PRO = c.checkLong("COD_PRO", request.getParameter("COD_PRO"), false);
                String strREV = c.checkString(ApplicationConfigurator.LanguageManager.getString("Revisione"), request.getParameter("REV"), true);                  //1
                String strOGG = c.checkString(ApplicationConfigurator.LanguageManager.getString("Oggetto"), request.getParameter("OGG"), false);                 //2
                String strCOD = c.checkString(ApplicationConfigurator.LanguageManager.getString("Codice"), request.getParameter("COD"), true);                  //3
                String strDAT_EMI = c.checkString(ApplicationConfigurator.LanguageManager.getString("Data.emissione"), request.getParameter("DAT_EMI"), false);        //4
                String strDAT_PRO = c.checkString(ApplicationConfigurator.LanguageManager.getString("Data.protocollo"), request.getParameter("DAT_PRO"), false);        //5
                String strDOC_COL = c.checkString(ApplicationConfigurator.LanguageManager.getString("Documento.collegato"), request.getParameter("ATTACHMENT_FILE"), true);                  //6
                //String strDOC_COL_CB = c.checkString("Documento collegato check box", request.getParameter("ATTACHMENT_ACTION_LINK"), false);                  //6

if (c.isError){
	String err = c.printErrors();
	out.print("<script>alert(\""+err+"\");</script>");
	return;
}


IsezioneGeneraleHome home = (IsezioneGeneraleHome) PseudoContext.lookup("SezioneGeneraleBean");
ISezioneGenerale sezionegenerale;
//
%>

	<table class="VIEW_TABLE" border=0>
	<tr class="VIEW_HEADER_TR">
                <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</td>
		<td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Codice")%>&nbsp;</td>
                <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Revisione")%>&nbsp;</td>
		<td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.emissione")%>&nbsp;</td>
                <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.protocollo")%>&nbsp;</td>
                <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Documento.collegato")%>&nbsp;</td>
	</tr>
<%
java.util.Collection col = home.findEx(lCOD_PSC,lCOD_PRO,strCOD,strREV,strDAT_EMI,strDAT_PRO,strOGG,strDOC_COL, 0);
java.util.Iterator it = col.iterator();
int i=1;
while(it.hasNext()){
	SezioneGenerale_View obj=(SezioneGenerale_View)it.next();
%>		<tr class="VIEW_TR" valign="top" INDEX="<%=obj.COD_SEZ_GEN%>" onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
		<td>&nbsp;<%=i++%>&nbsp;</td>
<%
	out.println("<td>&nbsp;" + Formatter.format(obj.COD) + "&nbsp;</td><td>&nbsp;"+
	 Formatter.format(obj.REV)+"&nbsp;</td><td>&nbsp;"+
	 Formatter.format(obj.DAT_EMI)+"&nbsp;</td><td>&nbsp;"+
	 Formatter.format(obj.DAT_PRO)+"&nbsp;</td><td>&nbsp;"+
	 Formatter.format(obj.DOC_COL)+"&nbsp;</td></tr>");
}
%>
	</table>
</div>
<script>
	function OnBeforeDelete(id, tr){
		return confirm(arraylng["MSG_0018"]);
	}
	function OnViewLoad(){
			//alert("Loaded!!")

			parent.g_Handler.setCaptionHTML(getCompleteMenuPath(SubMenuCorsi,1));

			parent.g_Handler.New.URL="/luna/WEB/Form_ANA_SEZ_GEN/ANA_SEZ_Form.jsp";
			parent.g_Handler.New.Width = "760px";
			parent.g_Handler.New.Height = "800px";
//			parent.g_Handler.New.Height = "535px";

			parent.g_Handler.Open=parent.g_Handler.New;

			parent.g_Handler.Delete.URL="/luna/WEB/Form_ANA_SEZ_GEN/ANA_SEZ_GEN_Delete.jsp"; //?ID=32233223
			parent.g_Handler.Delete.OnBefore=OnBeforeDelete;
                        parent.g_Handler.Help.URL="/luna/WEB/Form_ANA_SEZ_GEN/ANA_SEZ_GEN_Help.jsp";
	}
</script>

<script>
	parent.g_Handler.OnViewChange(divContent, OnViewLoad);
	//InitView();
</script>
