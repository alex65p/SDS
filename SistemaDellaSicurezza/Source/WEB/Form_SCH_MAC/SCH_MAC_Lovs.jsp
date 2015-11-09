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
    <version number="1.0" date="06/03/2004" author="Pogrebnoy Yura">		
      <comments>

      </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
<body>
<div id="divContent">
<%
	String caption = "";
	IMacchinaHome MacchinaHome=(IMacchinaHome)PseudoContext.lookup("MacchinaBean");
%>
<table border="0" class="VIEW_TABLE">
<%
if ( "LOV_MAC".equals(request.getParameter("LOCAL_MODE")) ){
  String strNOM_MAC = request.getParameter("NOM_MAC");
	String strDES_MAC = request.getParameter("DES_MAC");
	long COD_AZL      = new Long (request.getParameter("COD_AZL")).longValue();
	String str="";
	str=str+"<tr class=\"VIEW_HEADER_TR\">";
	str=str+" <td width=\"45%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Identificativo") + "</strong></td>";
	str=str+" <td width=\"55%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td>";
	str=str+"</tr>";

	java.util.Collection col = MacchinaHome.getMacchina_LOV_View(COD_AZL, strNOM_MAC, strDES_MAC);
	
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Macchina_LOV_View obj=(Macchina_LOV_View)it.next();
		str += "<tr valign='top' class=\"VIEW_TR\" INDEX=\""+obj.lCOD_MAC+"\" onclick=\"g_Handler.OnRowClick(this)\" ondblclick=\"g_Handler.OnRowDblClick(this)\">";	
		str += "<td width=\"45%\">&nbsp;"+Formatter.format(obj.strIDE_MAC)+"</td>";
		str += "<td width=\"55%\">&nbsp;"+Formatter.format(obj.strDES_MAC)+"</td>";
		str += "</tr>";
  }
	out.print(str);
	caption = ApplicationConfigurator.LanguageManager.getString(
                ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                    ?"Elenco.macchine.attrezzature.impianti"
                    :"Elenco.macchine/attrezzature"
                );
}
%>
</table>
</div>
<script>
	function OnViewLoad(){
		parent.g_Handler.setCaptionHTML("<%=caption%>");
	}
</script>
<script>
	parent.g_Handler.OnViewChange(divContent, OnViewLoad);
</script>
</body>
</html>

