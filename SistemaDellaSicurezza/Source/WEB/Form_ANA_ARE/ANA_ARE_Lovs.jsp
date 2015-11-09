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
%>
<%@ page import="com.apconsulting.luna.ejb.GestioniSezioni.*" %>

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
	IGestioniSezioniHome home=(IGestioniSezioniHome)PseudoContext.lookup("GestioniSezioniBean");
%>
<table border="0" class="VIEW_TABLE">
<tr class="VIEW_HEADER_TR">
		<td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</td>
                <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>&nbsp;</td>
	</tr>
<%
	java.util.Collection col = home.caricaFromRpAre();
  java.util.Iterator it = col.iterator();
	int iCount=0;
 while(it.hasNext()){
		caricaFromRpAre obj=(caricaFromRpAre)it.next();
%>		<tr	class="VIEW_TR" valign="top"	INDEX="<%=obj.COD_ARE_R%>"
        onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
<%
	out.println("<td>&nbsp;"+ ++iCount +"&nbsp;</td><td>&nbsp;"+
								 Formatter.format(obj.NOM_ARE)+"&nbsp;</td></tr>");
  }
	caption = ApplicationConfigurator.LanguageManager.getString("Elenco.sezioni");
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
