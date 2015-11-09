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

<%@ page import="com.apconsulting.luna.ejb.GestioniSezioni.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%
	IGestioniSezioni bean = null;
	IGestioniSezioniHome home = (IGestioniSezioniHome)PseudoContext.lookup("GestioniSezioniBean");
	
	Long ID = new Long(request.getParameter("ID"));
	long COD_ARE_R=ID.longValue();
	//bean = home.findByPrimaryKey(ID);
	java.util.Collection col = home.getNameFromRep(COD_ARE_R);
  java.util.Iterator it = col.iterator();
	//it.hasNext();
	NameFromRep obj=(NameFromRep)it.next();
	String	strNOM_ARE = obj.NOM_ARE;
%>
	<script type="text/javascript">
<!--
	parent.document.all['COD_ARE_R'].value = "<%=Formatter.format(request.getParameter("ID"))%>"; 
	parent.document.all['NOM_ARE'].value = "<%=Formatter.format(strNOM_ARE)%>";
// -->
	</script>

