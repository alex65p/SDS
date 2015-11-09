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
    <version number="1.0" date="12/03/2004" author="Alexey Kolesnik">		
      <comments>
								Template Created
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<html>
<body>
<%
if ("LOV_RSO".equals(request.getParameter("LOCAL_MODE")))
{
	IRischio bean = null;
	IRischioHome RischioHome=(IRischioHome)PseudoContext.lookup("RischioBean");
	
        short sMOD_CLC_RSO = Security.getAziendaModalitaCalcoloRischio();
        Long ID = new Long(request.getParameter("ID"));
	bean = RischioHome.findByPrimaryKey(new RischioPK(Security.getAzienda(), ID.longValue()));
	long lCOD_RSO = bean.getCOD_RSO();
	String strNOM_RSO = bean.getNOM_RSO();
	String strNOM_RIL_RSO = bean.getNOM_RIL_RSO();
	String strCLF_RSO = bean.getCLF_RSO();
	java.sql.Date dtDAT_RFC_VLU_RSO = bean.getDAT_RIL();
	long lENT_DAN = bean.getENT_DAN();
        long lFRQ_RIP_ATT_DAN = bean.getFRQ_RIP_ATT_DAN();
        long lNUM_INC_INF = bean.getNUM_INC_INF();
        long lPRB_EVE_LES = bean.getPRB_EVE_LES();
	float lSTM_NUM_RSO = bean.getSTM_NUM_RSO();
	int intRFC_VLU_RSO_MES=(int)bean.getRFC_VLU_RSO_MES();
	//---
	java.util.Date dt=new java.util.Date();
	java.sql.Date CUR_DAT=new java.sql.Date( dt.getTime() );
	long lCUR_DATE=CUR_DAT.getTime();
	java.sql.Date SUM_DAT=new java.sql.Date(0L);
	java.sql.Date S_DAT=new java.sql.Date(lCUR_DATE);
	S_DAT.setMonth( CUR_DAT.getMonth() + intRFC_VLU_RSO_MES);
	out.print("S_DAT:"+S_DAT+" mes:"+intRFC_VLU_RSO_MES);
	%>
	<script type="text/javascript">
<!--
  parent.document.all["COD_RSO"].value = "<%=Formatter.format(lCOD_RSO)%>";
  parent.document.all["NOM_RSO"].value = "<%=Formatter.format(strNOM_RSO)%>";
  parent.document.all["NOM_RIL_RSO"].value = "<%=Formatter.format(strNOM_RIL_RSO)%>";
  parent.document.all["CLF_RSO"].value = "<%=Formatter.format(strCLF_RSO)%>";
  parent.document.all["DAT_RFC_VLU_RSO"].value = "<%=Formatter.format(S_DAT)%>";
  parent.document.all["ENT_DAN"].value = "<%=Formatter.format(lENT_DAN)%>";
  <% if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED){%>
    parent.document.all["FRQ_RIP_ATT_DAN"].value = "<%=Formatter.format(lFRQ_RIP_ATT_DAN)%>";
    parent.document.all["NUM_INC_INF"].value = "<%=Formatter.format(lNUM_INC_INF)%>";
  <%}%>
  parent.document.all["PRB_EVE_LES"].value = "<%=Formatter.format(lPRB_EVE_LES)%>";
  parent.document.all["STM_NUM_RSO"].value = "<%=Formatter.format(lSTM_NUM_RSO)%>";
// -->
  </script>
<%}%>

