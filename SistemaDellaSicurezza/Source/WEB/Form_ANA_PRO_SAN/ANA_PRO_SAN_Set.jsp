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
    <version number="1.0" date="24/01/2004" author="Malyuk Sergey">
	      <comments>
				  <comment date="24/01/2004" author="Malyuk Sergey">
				   <description>ANA_PRO_SAN_Set.jsp</description>
				 </comment>
				 <comment date="01/04/2004" author="Roman Chumachenko">
				   <description>Modification for multiazienda mode</description>
				 </comment>
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.ProtocoleSanitare.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/ExtendedMode.jsp"%>

<script>  
	//JS peremennaja vistvliemaja v true esli bila sozdana new zapis'  
	var isNew = false;
	var err = false; 
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%! String ReqMODE;	//parameter of request %>

<%
long lCOD_PRO_SAN=0;
long lCOD_AZL=Security.getAzienda() ;
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	Checker c = new Checker();
	//- checking for required fields		
	String	strNOM_PRO_SAN=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"),request.getParameter("NOM_PRO_SAN"),true);
	String strDES_PRO_SAN = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_PRO_SAN"),false);
	long lCOD_PRO_SAN_RPO=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Protocollo.sanitario"),request.getParameter("COD_PRO_SAN_RPO"),false);
	//if (Security.isExtendedMode()){ 
	java.util.ArrayList alAziende = ExtendedMode.getAziende(c); //EXTENDED
	//}
	if (c.isError){
		String err = c.printErrors();
		%><script>alert("<%=err%>");</script><%
		return;
	}
IProtocoleSanitareHome home=(IProtocoleSanitareHome)PseudoContext.lookup("ProtocoleSanitareBean");
IProtocoleSanitare ProtocoleSanitare=null;
//=======================================================================================
  if(ReqMODE.equals("edt"))
	{
		// editing of ProtocoleSanitare--------------------
		String strCOD_PRO_SAN=request.getParameter("PRO_SAN_ID");//ID of ProtocoleSanitare
		long pro_san_id=new Long(strCOD_PRO_SAN).longValue();
		ProtocoleSanitare = home.findByPrimaryKey(new ProtocoleSanitarePK( lCOD_AZL, pro_san_id));
		try{
			ProtocoleSanitare.store(strNOM_PRO_SAN, strDES_PRO_SAN, lCOD_PRO_SAN_RPO, alAziende);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new ProtocoleSanitare--------------------------
	// creating of object
		try{
			 	ProtocoleSanitare=home.create(strNOM_PRO_SAN,strDES_PRO_SAN, lCOD_AZL, alAziende);
				%><script>isNew=true;</script><%	
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
		lCOD_PRO_SAN = ProtocoleSanitare.getCOD_PRO_SAN();		
	}
//=======================================================================================

}// ReqMODE
%>
<script>
if (!err){  
	 Alert.Success.showSaved();  
	 if(isNew) 
	 	parent.ToolBar.OnNew("ID=<%=lCOD_PRO_SAN%>");
}
</script>
