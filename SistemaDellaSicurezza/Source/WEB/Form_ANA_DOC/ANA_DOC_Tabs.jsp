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
    <version number="1.0" date="26/01/2004" author="Artur Denysenko">		
      <comments>
			   <comment date="26/01/2004" author="Artur Denysenko">
				RischioFattore
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
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script>var err=false;</script>
<div id="dContent">
<%
	long lCOD_BEAN=0;
	IAnagrDocumento bean=null;
	String strID = (String)request.getParameter("ID_PARENT");
	String tabName= new String();
	try{
		IAnagrDocumentoHome home=(IAnagrDocumentoHome)PseudoContext.lookup("AnagrDocumentoBean");
		Long id=new Long(strID);
		bean = home.findByPrimaryKey(id);
		lCOD_BEAN=id.longValue();
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}
try{
	if (bean!=null){	
		if(request.getParameter("TAB_NAME").equals("tab1")){
			out.println(BuildDestinatariTab(bean.getDestinatarioDocumentoView(), lCOD_BEAN));
			//return;
		}
	}else {
		return;
	}
}
catch(Exception ex){
	out.print(printErrAlert("divErr", "Error.alert", ex));
	//return;
	%>
	<script>err=true;</script>
	<%
}
%>
 </div>
 <script>
 if (!err){
	  parent.tabbar.ReloadTabTable(document);
 }
 else{
 	Alert.Error.showNotFound();
 }
 </script>
 
 
<%!		
String BuildDestinatariTab(Collection col, long lCOD_DOC)
{
	StringBuffer str = new StringBuffer();					
	str.append("<table border='0' align='left' width='946' id='RischioCorsiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>");
		str.append("<tr>");
			str.append("<td width='746'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Destinatario") + "</strong>");
			str.append("<input type='hidden' name='COD_LST_DSI_DOC' value=''></td>");
			str.append("<td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.consegna") + "</strong></td>");
		str.append("</tr>");	
	str.append("</table>");
	
	str.append("<table border='0' align='left' width='946' id='RischioCorsi' class='dataTable' cellpadding='0' cellspacing='0'>");
		str.append("<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_DOC)+"'>");
				str.append("<td class='dataTd'><input type='text' readonly class='inputstyle'></td>");
				str.append("<td class='dataTd'><input type='text' readonly class='inputstyle'></td>");
		str.append("</tr>");	
		
			java.util.Iterator it = col.iterator();
	 		while(it.hasNext()){
				DestinatarioDocumento_Destinatario_Consegna_View v=(DestinatarioDocumento_Destinatario_Consegna_View)it.next();
		    	str.append("<tr INDEX='"+Formatter.format(lCOD_DOC)+"' ID='"+v.lCOD_LST_DSI_DOC+"'>");
					str.append("<td class='dataTd'><input type='hidden' name='COD_LST_DSI_DOC' value='"+Formatter.format(v.lCOD_LST_DSI_DOC)+"'>");
					str.append("<input type='text' readonly style='width: 746px;' class='inputstyle' value='"+Formatter.format(v.strNOM_DSI_ESR)+"'></td>");
					str.append("<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value='"+Formatter.format(v.dtDAT_CSG_DOC_DSI)+"'></td>");
				str.append("</tr>");
			}
		str.append("</table>");
	return str.toString();
} 
%>
