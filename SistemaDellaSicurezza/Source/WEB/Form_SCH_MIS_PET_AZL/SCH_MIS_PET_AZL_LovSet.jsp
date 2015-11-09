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
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AssRischioAttivita.*" %>
<%@ page import="com.apconsulting.luna.ejb.AssMisuraAttivita.*" %>
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.MisurePreventive.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="com.apconsulting.luna.ejb.LuogoFisicoRischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.TipologiaMisurePreventive.*" %>
<%@ page import="com.apconsulting.luna.ejb.MisurePreventProtettiveAz.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%
//--------------------------------------------------------------------------------------

long lCOD_AZL=Security.getAzienda();
if ("LOV_MIS_PET".equals(request.getParameter("LOCAL_MODE")))
{
	IMisurePreventProtettiveAz bean=null;
	IMisurePreventProtettiveAzHome home=(IMisurePreventProtettiveAzHome)PseudoContext.lookup("MisurePreventProtettiveAzBean");

	IRischio rso=null;
	IRischioHome rsoHome=(IRischioHome)PseudoContext.lookup("RischioBean");

	IAssRischioAttivita rsoMan=null;
	IAssRischioAttivitaHome rsoManHome=(IAssRischioAttivitaHome)PseudoContext.lookup("AssRischioAttivitaBean");

	ILuogoFisicoRischio rsoLuoFsc=null;
	ILuogoFisicoRischioHome rsoLuoFscHome=(ILuogoFisicoRischioHome)PseudoContext.lookup("LuogoFisicoRischioBean");
	
	ITipologiaMisurePreventive tplMP=null;
	ITipologiaMisurePreventiveHome tplMPHome=(ITipologiaMisurePreventiveHome)PseudoContext.lookup("TipologiaMisurePreventiveBean");

	Long ID = new Long(request.getParameter("ID"));
	bean = home.findByPrimaryKey(ID);
	String	strNOM_MIS_PET = bean.getNOM_MIS_PET();
  	long	lCOD_TPL_MIS_PET = bean.getCOD_TPL_MIS_PET();
	
	ID = new Long(lCOD_TPL_MIS_PET);
	tplMP = tplMPHome.findByPrimaryKey(ID);
	String	strDES_TPL_MIS_PET = tplMP.getDES_TPL_MIS_PET();
	
	long	lCOD_RSO;
	if ("M".equals(request.getParameter("APL_A")))
	{
		long	lCOD_RSO_MAN = bean.getCOD_RSO_MAN();

		ID = new Long(lCOD_RSO_MAN);
		rsoMan = rsoManHome.findByPrimaryKey(ID);
		lCOD_RSO = rsoMan.getCOD_RSO();
	}
	else
	{
		long	lCOD_RSO_LUO_FSC = bean.getCOD_RSO_LUO_FSC();

		ID = new Long(lCOD_RSO_LUO_FSC);
		rsoLuoFsc = rsoLuoFscHome.findByPrimaryKey(ID);
		lCOD_RSO = rsoLuoFsc.getCOD_RSO();
	}
	
	ID = new Long(lCOD_RSO);
	rso = rsoHome.findByPrimaryKey(new RischioPK(Security.getAzienda(), ID.longValue()));
	String	strNOM_RSO = rso.getNOM_RSO();
%>
	<script type="text/javascript">
<!--
	parent.document.all['NB_COD_MIS_PET'].value = "<%=Formatter.format(request.getParameter("ID"))%>"; 
	parent.document.all['NB_NOM_MIS_PET'].value = "<%=Formatter.format(strNOM_MIS_PET)%>"; 

	parent.document.all['NB_DES_TPL_MIS_PET'].value = "<%=Formatter.format(strDES_TPL_MIS_PET)%>"; 

	parent.document.all['NB_COD_RSO'].value = "<%=Formatter.format(lCOD_RSO)%>"; 
	parent.document.all['NB_NOM_RSO'].value = "<%=Formatter.format(strNOM_RSO)%>"; 
// -->
	</script>
<%
}
if ("LOV_MIS_PET_MAN".equals(request.getParameter("LOCAL_MODE")))
{
	IAttivitaLavorative man=null;
	IAttivitaLavorativeHome manHome=(IAttivitaLavorativeHome)PseudoContext.lookup("AttivitaLavorativeBean");

	Long ID = new Long(request.getParameter("ID"));
	man = manHome.findByPrimaryKey( new AttivitaLavorativePK(lCOD_AZL, ID.longValue()) );
	String	strNOM_MAN = man.getNOM_MAN();
%>
	<script type="text/javascript">
<!--
	parent.document.all['NB_COD_MIS_PET_LUO_MAN'].value = "<%=Formatter.format(request.getParameter("ID"))%>"; 
	parent.document.all['NB_NOM_MIS_PET_LUO_MAN'].value = "<%=Formatter.format(strNOM_MAN)%>"; 
// -->
	</script>
<%
}
if ("LOV_MIS_PET_LUO_FSC".equals(request.getParameter("LOCAL_MODE")))
{
	IAnagrLuoghiFisici luoFsc=null;
	IAnagrLuoghiFisiciHome luoFscHome=(IAnagrLuoghiFisiciHome)PseudoContext.lookup("AnagrLuoghiFisiciBean");

	Long ID = new Long(request.getParameter("ID"));
	luoFsc = luoFscHome.findByPrimaryKey(ID);
	String	strNOM_LUO_FSC = luoFsc.getNOM_LUO_FSC();
%>
	<script type="text/javascript">
<!--
	parent.document.all['NB_COD_MIS_PET_LUO_MAN'].value = "<%=Formatter.format(request.getParameter("ID"))%>"; 
	parent.document.all['NB_NOM_MIS_PET_LUO_MAN'].value = "<%=Formatter.format(strNOM_LUO_FSC)%>"; 
// -->
	</script>
<%
}
if ("LOV_NOM_RSO".equals(request.getParameter("LOCAL_MODE")))
{
	IRischio bean = null;
	IRischioHome home = (IRischioHome)PseudoContext.lookup("RischioBean");

	Long ID = new Long(request.getParameter("ID"));
	bean = home.findByPrimaryKey(new RischioPK(Security.getAzienda(), ID.longValue()));
	String	strNOM_RSO = bean.getNOM_RSO();
%>
	<script type="text/javascript">
<!--
	parent.document.all['NB_COD_RSO'].value = "<%=Formatter.format(request.getParameter("ID"))%>"; 
	parent.document.all['NB_NOM_RSO'].value = "<%=Formatter.format(strNOM_RSO)%>"; 
// -->
	</script>
<%
}
%>
