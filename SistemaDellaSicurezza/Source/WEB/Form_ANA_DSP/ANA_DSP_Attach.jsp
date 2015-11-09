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

<%@page import="com.apconsulting.luna.ejb.AnagrDisposizioni.IAnagrDisposizioniHome"%>
<%@page import="com.apconsulting.luna.ejb.AnagrDisposizioni.IAnagrDisposizioni"%>
<%@page import="com.apconsulting.luna.ejb.AnagrConstatazioni.IAnagrConstatazioniHome"%>
<%@page import="com.apconsulting.luna.ejb.AnagrConstatazioni.IAnagrConstatazioni"%>
<%
/*
<file>
  <versions>	
    <version number="1.0" date="12/02/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="12/02/2004" author="Khomenko Juliya">
				   <description>Create ANA_PRG_Attach.jsp</description>
				  </comment>		
        </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.RischioCantiere.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script>
  var err=false;
</script>
<script src="../_scripts/Alert.js"></script>
<script src="../_scripts/call_GEST_MAN.js" type="text/javascript"></script>
<%
	
	long id_attachment=0;
	IAnagrDisposizioni bean=null;
	IAnagrDisposizioniHome home=(IAnagrDisposizioniHome)PseudoContext.lookup("AnagrDisposizioniBean");
	String strID = (String)request.getParameter("ID_PARENT");
	long lCOD_DSP=0;
	java.util.ArrayList AZIENDA_ID;
	long lCOD_AZL = Security.getAzienda();
	Checker c = new Checker();
	
	if (Security.isExtendedMode()){
		AZIENDA_ID=c.checkAlLong("aziendaIDs",  request.getParameterValues("AZIENDA_ID"));
	} 
	String strSubject=(String)request.getParameter("ATTACH_SUBJECT");
	try{
		bean = home.findByPrimaryKey(new Long(strID));
		id_attachment = Long.parseLong((String)request.getParameter("ID"));
		lCOD_DSP = Long.parseLong(strID);
	}catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound",ex));
		return;
	}
	if(strSubject.equals("DSPRSO")){
		try{
			
					        IRischioCantiereHome rso_home=(IRischioCantiereHome)PseudoContext.lookup("RischioCantiereBean");
						IRischioCantiere rso_bean = rso_home.findByPrimaryKey(new RischioPK( Security.getAzienda(), id_attachment));
						bean.addCOD_RSO(id_attachment, lCOD_AZL);
					
				
		}
		catch(Exception ex){
			out.print(printErrAlert("divErr", "Error.showDublicateChild",ex));
			return;
		}
                }
        else
	   return;
                     
%>

<script>
    parent.ToolBar.Return.Do();
</script>















































