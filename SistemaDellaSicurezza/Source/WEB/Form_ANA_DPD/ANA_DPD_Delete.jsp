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
     <version number="1.0" date="14/01/2004" author="Mike Kondratyuk">
     <comments>
     <comment date="14/01/2004" author="Mike Kondratyuk">
     <description>Shablon formi ANA_DPD_Delete.jsp</description>
     </comment>		
     </comments> 
     </version>
     </versions>
     </file> 
     */
%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script type="text/javascript">
    var err=false;
</script>
<%
    long ID = 0;
    long lCOD_PCS_FRM = 0, lCOD_COR_DPD = 0/*, lCOD_LOT_DPI=0, lCOD_SOS_CHI=0, lCOD_MAC=0*/;
    IDipendente bean = null;
    IDipendenteHome home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");

    Checker c = new Checker();
//java.sql.Date dtDAT_EFT_COR=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.corso"),request.getParameter("DAT_EFT_COR"),true);

    String LOCAL_MODE = request.getParameter("LOCAL_MODE");

    if (LOCAL_MODE != null) {
	ID = c.checkLong("Dipendente", request.getParameter("ID_PARENT"), true);
	if (LOCAL_MODE.equals("PCS_FRM")) {
	    lCOD_PCS_FRM = c.checkLong("Numero telefono", request.getParameter("ID"), true);
	}
	if (LOCAL_MODE.equals("COR_DPD")) {
	    lCOD_COR_DPD = c.checkLong("ID Corso", request.getParameter("ID"), true);
	}
	/*	if(LOCAL_MODE.equals("ac"))
	 lCOD_SOS_CHI=c.checkLong("Agento chimici",request.getParameter("ID"),true);
	 if(LOCAL_MODE.equals("m"))
	 lCOD_MAC=c.checkLong("Macchina",request.getParameter("ID"),true);*/
    } else {
	ID = c.checkLong("Dipendente", request.getParameter("ID"), true);
    }
    if (c.isError) {
	out.println("<script>err=true;alert(\"" + c.printErrors() + "\");</script>");
	return;
    }
    try {
	if (LOCAL_MODE != null) {
	    bean = home.findByPrimaryKey(new Long(ID));

	    if (lCOD_PCS_FRM != 0) {
		bean.removeCOD_PCS_FRM(lCOD_PCS_FRM);
	    } else if (lCOD_COR_DPD != 0) {
		java.sql.Date dtDAT_EFT_COR = java.sql.Date.valueOf(request.getParameter("dat_eft_cor"));
		bean.removeCOR_DPD(lCOD_COR_DPD, dtDAT_EFT_COR);
	    } /*		else if(lCOD_SOS_CHI!=0){
	     fornitore.removeCOD_SOS_CHI(lCOD_SOS_CHI);
	     }
	     else if(lCOD_MAC!=0){
	     fornitore.removeCOD_MAC(lCOD_MAC);
	     }
	     */ else {
		throw new Exception("Invalid operation");
	    }
	} else {
	    home.remove(new Long(ID));
	}
    } catch (Exception ex) {
	manageException(request, out, ex); 
%>
<script>err=true;</script>
<%    }
%>
<script>
    if (err) 
	Alert.Error.showDelete();

    <%
    if (LOCAL_MODE == null) {
    %>
	else{
	    Alert.Success.showDeleted();
	    parent.g_Handler.OnRefresh();
	}
    <%} else {
    %>
	else{
	    parent.del_localRow();
	    Alert.Success.showDeleted();
	}	
	   
    <%    }
    %>
</script>

