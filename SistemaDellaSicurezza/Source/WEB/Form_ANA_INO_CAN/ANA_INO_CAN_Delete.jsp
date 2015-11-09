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
    <version number="1.0" date="28/02/2004" author="Mike Kondratyuk">
	      <comments>
				  <comment date="28/02/2004" author="Mike Kondratyuk">
				   <description>Shablon formi ANA_INO_Delete.jsp</description>
				 </comment>
      </comments>
    </version>
  </versions>
</file>
*/
%>
<%@ page import="com.apconsulting.luna.ejb.InfortuniIncidentiCantiere.*" %>
<%@ page import="com.apconsulting.luna.ejb.Testimone.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>


<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script type="text/javascript">
var err=false;
</script>
<%
long ID=0;
long lCOD_TST_EVE=0;
long lCOD_DOC = 0;
IInfortuniIncidentiCantiere bean = null;
IInfortuniIncidentiCantiereHome iHome=(IInfortuniIncidentiCantiereHome)PseudoContext.lookup("InfortuniIncidentiCantiereBean");
ITestimoneHome tHome=(ITestimoneHome)PseudoContext.lookup("TestimoneBean");

Checker c = new Checker();

String LOCAL_MODE=request.getParameter("LOCAL_MODE");
if(LOCAL_MODE!=null){
	ID=c.checkLong("Dipendente",request.getParameter("ID_PARENT"),true);

	if(LOCAL_MODE.equals("TST_EVE"))
		lCOD_TST_EVE=c.checkLong("Testimoni",request.getParameter("ID"),true);
        if(LOCAL_MODE.equals("DOCUMENTO"))
            lCOD_DOC = c.checkLong("Documento", request.getParameter("ID"), true);
	}

else{
	ID=c.checkLong("Dipendente",request.getParameter("ID"),true);
}
if (c.isError){
	out.println("<script>err=true;alert(\""+ c.printErrors()+"\");</script>");
	return;
}
try{
	if(LOCAL_MODE!=null){
		if(lCOD_TST_EVE!=0){
			tHome.remove(new Long(lCOD_TST_EVE));
		}else if(lCOD_DOC != 0) {
                     bean = iHome.findByPrimaryKey(ID);
                        bean.removeINO_DOC(lCOD_DOC);
            }
		else{
			throw new Exception("Invalid operation");
		}
	}
	else{
		iHome.remove(new Long(ID));
	}
}
catch(Exception ex){
%>
		<script>err=true;</script>
<%
}
%>
<script>
	if (err)
   	Alert.Error.showDelete();

<%
if(LOCAL_MODE==null){
%>
		else{
		  Alert.Success.showDeleted();
		  parent.g_Handler.OnRefresh();
		}
<%
} else {
%>
		else{
			parent.del_localRow();
			Alert.Success.showDeleted();
	    }

<%
}
%>
</script>

