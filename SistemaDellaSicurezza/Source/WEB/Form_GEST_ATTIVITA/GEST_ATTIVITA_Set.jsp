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
    <version number="1.0" date="16/03/2004" author="Roman Chumachenko">
	      <comments>
				  <comment date="16/03/2004" author="Roman Chumachenko">
				   <description>GEST_ATTIVITA_Set.jsp</description>
				 </comment>
		  </comments> 
    </version>
  </versions>
</file> 
*/

response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server

%>
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.OperazioneSvolta.*" %>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../Form_ANA_MAN/ANA_MAN_Mail.jsp"%>

<script src="../_scripts/Alert.js"></script>
<script>
	var bAdded=false;
	var bDeleted=false;
</script>

<%
long COD_OPE_SVO=0;
long COD_RSO=0;
long COD_MAN=0;
long COD_AZL=0;
java.util.ArrayList ATTIVITA_ID_LIST=null;
java.util.ArrayList AZIENDA_ID_LIST =null;
//
Checker c = new Checker();
//------------------------
ATTIVITA_ID_LIST=c.checkAlLong("AttivitaIDs", request.getParameterValues("CHK_ITEM"));
if(Security.isExtendedMode())
{
	AZIENDA_ID_LIST=c.checkAlLong("AziendaIDs"  , request.getParameterValues("AZIENDA_ID"));
}
out.print("<br>"+ATTIVITA_ID_LIST);
//----------------------------------------------------------------
COD_OPE_SVO=Long.parseLong( request.getParameter("COD_OPE_SVO") );
COD_MAN=Long.parseLong( request.getParameter("COD_MAN") );
COD_AZL=Security.getAzienda();
//++++++++++++++++++++++++++++++++++++++++++
out.println("<br>COD_OPE_SVO:"+COD_OPE_SVO);
out.println("<br>COD_MAN:"+COD_MAN);
out.println("<br>COD_AZL:"+COD_AZL);
//------------------------------------------
//if(true) return;
if(request.getParameter("COD_RSO")!=null)
{
 COD_RSO=Long.parseLong( request.getParameter("COD_RSO") );
 out.println("<br>COD_RSO:"+COD_RSO);
 IAttivitaLavorativeHome att_home=(IAttivitaLavorativeHome)PseudoContext.lookup("AttivitaLavorativeBean");
	try{
		out.print("<br>Adding:<br>");
		//at_bean.addXRischioAssociations(COD_RSO, COD_AZL);
		String res = att_home.EXaddAssociationOfRiscToOperazionaSvolta(
			COD_OPE_SVO, COD_MAN, COD_AZL, COD_RSO, ATTIVITA_ID_LIST, AZIENDA_ID_LIST);
		out.print("RESULT:"+res);
                
                String SendedMail =SendMail4AddedRSO_ANA_OPE_SVO(ATTIVITA_ID_LIST,COD_RSO);
                if (!SendedMail.trim().equals("")){
                    out.println("<script>alert('" + SendedMail + "')</script>");                                               
                }
                
		if(res.indexOf("...FAILED")!=-1){
			throw new Exception();
		}
	}catch(Exception ex1){
		out.print("<script>alert(arraylng[\"MSG_0069\"]);</script>");
		return;
	}
}//if COD_RSO
//=====================================================================
%>
<script>
 Alert.Success.showSaved();
 parent.returnValue="OK";
 parent.ToolBar.Return.Do();
</script>

