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
    <version number="1.0" date="11/02/2004" author="Roman Chumachenko">
	   <comments>
		  <comment date="11/02/2004" author="Roman Chumachenko">
			<description>ANA_OPE_SVO_AttachDel.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.OperazioneSvolta.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp"%>

<script src="../_scripts/call_GEST_MAN.js"></script>
<script src="../_scripts/Alert.js"></script>

<%	
	Checker c = new Checker();
	long lCOD_AZL = Security.getAzienda();
	//
	long id_attachment=0;						// cod_rso, cod_mac, cod_sos_chi
	long lCOD_OPE_SVO=0;						// cod_ope_svo
	lCOD_OPE_SVO = c.checkLong("ID Operaziona Svolta", (String)request.getParameter("ID_PARENT"), true);
	id_attachment=c.checkLong("ID Attachment" ,(String)request.getParameter("ID"), true);
	//
	java.util.ArrayList AZIENDA_ID_LIST =null;	// List od COD_AZL
	if(Security.isExtendedMode())
	{
		AZIENDA_ID_LIST=c.checkAlLong("AziendaIDs", request.getParameterValues("AZIENDA_ID"));
	}
	//
	if (c.isError){
		String err = c.printErrors();
		%><script>alert("<%=err%>");</script><%
		return;
	}
	//
	IOperazioneSvolta bean=null;
	IAttivitaLavorativeHome att_home=(IAttivitaLavorativeHome)PseudoContext.lookup("AttivitaLavorativeBean");
	try{
		IOperazioneSvoltaHome home=(IOperazioneSvoltaHome)PseudoContext.lookup("OperazioneSvoltaBean");
		Long id=new Long(lCOD_OPE_SVO);
		bean = home.findByPrimaryKey(id);
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}
//-------------------------------------------------------------------------
	String strSubject=(String)request.getParameter("ATTACH_SUBJECT");
	try{
		if ("DOCUMENT".equals(strSubject)){
			bean.removeDocument(id_attachment);
		}
		//-----------------------------------------------------------------
		if ("RISC".equals(strSubject)){
			out.println("lCOD_RSO (id_attachment):"+id_attachment+"<br>");
			out.println("lCOD_OPE_SVO (lCOD_OPE_SVO):"+lCOD_OPE_SVO+"<br>");
			out.println("lCOD_AZL (lCOD_AZL):"+lCOD_AZL+"<br>");
			out.println("----------------------------------------<br>");
			//---------------------------------------------------
			String res = att_home.EXdeleteAssociationOfRiscFromOperazionaSvolta(
				lCOD_OPE_SVO, id_attachment, lCOD_AZL, AZIENDA_ID_LIST);
			out.print("RESULT:"+res);
			if(res.indexOf("...FAILED")!=-1){
				throw new Exception();
			}
			//
		}
		//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		if ("MACCHINA".equals(strSubject)){
			//bean.removeMacchina(id_attachment);
			out.println("lCOD_MAC (id_attachment):"+id_attachment+"<br>");
			out.println("lCOD_OPE_SVO (lCOD_OPE_SVO):"+lCOD_OPE_SVO+"<br>");
			out.println("lCOD_AZL (lCOD_AZL):"+lCOD_AZL+"<br>");
			out.println("----------------------------------------<br>");
			//---------------------------------------------------
			String res = att_home.EXdeleteAssociationOfMacchinaFromOperazionaSvolta(
				lCOD_OPE_SVO, id_attachment, lCOD_AZL, AZIENDA_ID_LIST);
			out.print("RESULT:"+res);
			if(res.indexOf("...FAILED")!=-1){
				throw new Exception();
			}
			//
		}
		if ("AGENTI".equals(strSubject)){
			//bean.removeAgenteChimico(id_attachment,lCOD_AZL);
			out.println("lCOD_SOS_CHI (id_attachment):"+id_attachment+"<br>");
			out.println("lCOD_OPE_SVO (lCOD_OPE_SVO):"+lCOD_OPE_SVO+"<br>");
			out.println("lCOD_AZL (lCOD_AZL):"+lCOD_AZL+"<br>");
			out.println("----------------------------------------<br>");
			//---------------------------------------------------
			String res = att_home.EXdeleteAssociationOfAgenteFromOperazionaSvolta(
				lCOD_OPE_SVO, id_attachment, lCOD_AZL, AZIENDA_ID_LIST);
			out.print("RESULT:"+res);
			if(res.indexOf("...FAILED")!=-1){
				throw new Exception();
			}
			//
		}
//-------------------------------------------------------------------------
	}catch(Exception ex){
		out.print("<script>Alert.Error.showDelete();</script>");
		return;
	}
%>
<script>
 parent.del_localRow();
 Alert.Success.showDeleted();
</script>

