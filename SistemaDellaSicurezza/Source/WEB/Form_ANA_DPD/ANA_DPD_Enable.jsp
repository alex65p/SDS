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

<%   //Questa jsp è stata aggiunta per gestire la riabilitazione di un dipendente cessato solo per MSR
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

  /*  if (LOCAL_MODE != null) {
	ID = c.checkLong("Dipendente", request.getParameter("ID_PARENT"), true);
	if (LOCAL_MODE.equals("PCS_FRM")) {
	    lCOD_PCS_FRM = c.checkLong("Numero telefono", request.getParameter("ID"), true);
	}
	if (LOCAL_MODE.equals("COR_DPD")) {
	    lCOD_COR_DPD = c.checkLong("ID Corso", request.getParameter("ID"), true);
	}
	/ *	if(LOCAL_MODE.equals("ac"))
	 lCOD_SOS_CHI=c.checkLong("Agento chimici",request.getParameter("ID"),true);
	 if(LOCAL_MODE.equals("m"))
	 lCOD_MAC=c.checkLong("Macchina",request.getParameter("ID"),true);* /
    } else {*/
	ID = c.checkLong("Dipendente", request.getParameter("COD_DPD"), true);
        home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
        Long COD_DPD = new Long(ID);
        IDipendente Dipendente  = home.findByPrimaryKey(COD_DPD);
   // }
    if (c.isError) {
	out.println("<script>err=true;alert(\"" + c.printErrors() + "\");</script>");
	return;
    }
    try {
	if (LOCAL_MODE != null) {
	    bean = home.findByPrimaryKey(new Long(ID));

	    
	} else {
            //funzione che mette a null la colonna data_cessazione in base al codice_dipendente
	    home.enable(new Long(ID));
        %>    <script>bRefresh=true;</script><%
	}
    } catch (Exception ex) {
	manageException(request, out, ex); 
%>
<script>err=true;</script>
<%    }
%>
<script>
    if (err) 
	Alert.Error.showEnable();
</script>
<script type="text/javascript">
    if (!err){
         
            Alert.Success.showEnable();
            if (bRefresh) parent.ToolBar.OnNew("ID=<%=Dipendente.getCOD_DPD()%>");
         
    } //una volta riabilitato, viene richiamata la pagina di gestione del dipendente
     ifrmWork.document.location.href=tb_url_Edit;
</script>


