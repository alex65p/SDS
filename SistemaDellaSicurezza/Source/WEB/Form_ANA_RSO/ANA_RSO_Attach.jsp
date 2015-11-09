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
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.OperazioneSvolta.*" %>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/ExtendedMode.jsp"%>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../Form_ANA_MAN/ANA_MAN_Mail.jsp"%>

<script src="../_scripts/Alert.js"></script>
<script src="../_scripts/call_GEST_MAN.js"></script>

<%

Checker c = new Checker();
ArrayList alAziende = ExtendedMode.getAziende(c); //EXTENDED

if (c.isError){
	String err = c.printErrors();
	%><script>alert("<%=err%>");</script><%
	return;
}

	long id_attachment=0;
	
	IRischio bean=null;
	String strID = (String)request.getParameter("ID_PARENT");
	try{
		IRischioHome home=(IRischioHome)PseudoContext.lookup("RischioBean");                
		id_attachment=Long.parseLong((String)request.getParameter("ID"));
		bean = home.findByPrimaryKey(new RischioPK( Security.getAzienda(), (Long.parseLong(strID))));
		
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
                ex.printStackTrace();
                return;
	}

	String strSubject=(String)request.getParameter("ATTACH_SUBJECT");
	int iAnsw;
	try{
		if ("CORSO".equals(strSubject)){
			iAnsw=bean.addCorso(id_attachment, alAziende);
			if(iAnsw!=0){
				%>
				<script>
					showGestMan(<%= id_attachment%>, "cor",<%= strID %> );
				</script>
				<%
			}
		}
		else if ("NORMATIVA".equals(strSubject)){
			bean.addNormativaSentenza(id_attachment);
		}
		else if ("DPI".equals(strSubject)){
			iAnsw=bean.addDpi(id_attachment, alAziende);
			if(iAnsw!=0){
				%>
				<script>
					showGestMan(<%= id_attachment%>, "dpi",<%= strID %> );
				</script>
				<%
			}
		}
		else if ("PROSAN".equals(strSubject)){
			iAnsw=bean.addProtocolloSanitario(id_attachment, alAziende);
			if(iAnsw!=0){
				%>
				<script>
					showGestMan(<%= id_attachment%>, "pro_san",<%= strID %> );
				</script>
				<%
			}
		}
		else if ("MISPET".equals(strSubject)){
			iAnsw=bean.addMisuraPp(id_attachment, alAziende);
			if(iAnsw!=0){
				%>
				<script>
					showGestMan(<%= id_attachment%>, "mis_pet",<%= strID %> );
				</script>
				<%
			}
		}
		else if ("DOCUMENT".equals(strSubject)){
			bean.addDocumento(id_attachment);
		}
		else{
			return;
		}
	}
	catch(Exception ex){
		ex.printStackTrace();
		out.print(printErrAlert("divErr", "Error.showDublicateChild", ex));
		return;
	}
%>
<script>
	parent.ToolBar.Return.Do();
</script>
