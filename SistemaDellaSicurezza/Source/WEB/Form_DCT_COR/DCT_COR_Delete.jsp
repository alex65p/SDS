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
    <version number="1.0" date="26/02/2004" author="Mike Kondratyuk">
	      <comments>
				  <comment date="26/02/2004" author="Mike Kondratyuk">
				   <description>Shablon formi DCT_COR_Delete.jsp</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/DocentiCorso/DocentiCorsoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DocentiCorso/DocentiCorsoBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script type="text/javascript">
var err=false;
</script>
<%
long ID=0;

IDocentiCorso bean=null;
IDocentiCorsoHome home=(IDocentiCorsoHome)PseudoContext.lookup("DocentiCorsoBean");

Checker c = new Checker();

ID=c.checkLong("Docente Corsi",request.getParameter("ID"),true);

if (c.isError){
	out.println("<script>err=true;alert(\""+ c.printErrors()+"\");</script>");
	return;
}

try{
	home.remove(new Long(ID));
}
catch(Exception ex){
%>
		<div id="divErr">
			<%=ex.getMessage()%>
		</div>
		<script>err=true;</script>
<%
}
%>
<script>
	if (err) Alert.Error.showDelete();//alert(divErr.innerText);
	else{
		parent.del_localRow();
		Alert.Success.showDeleted();
   }	
</script>

