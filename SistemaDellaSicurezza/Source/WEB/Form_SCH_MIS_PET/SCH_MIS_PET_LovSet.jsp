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
    <version number="1.0" date="03/03/2004" author="Alexey Kolesnik">		
      <comments>
								Template Created
      </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AssMisuraAttivita.*" %>
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.MisuraPreventiva.*" %>
<%@ page import="com.apconsulting.luna.ejb.MisurePreventive.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<html>
<body>
<%
long lCOD_AZL=Security.getAzienda();
if ("LOV_MIS_PET".equals(request.getParameter("LOCAL_MODE")))
{
	IMisuraPreventiva bean = null;
	IMisuraPreventivaHome MisuraHome=(IMisuraPreventivaHome)PseudoContext.lookup("MisuraPreventivaBean");
	
	IRischio Rischio_bean = null;
	IRischioHome RischioHome=(IRischioHome)PseudoContext.lookup("RischioBean");
	
	Long ID = new Long(request.getParameter("ID"));
	bean = MisuraHome.findByPrimaryKey( new MisuraPreventivaPK(lCOD_AZL, ID.longValue()) );
	long lCOD_MIS_PET = bean.getCOD_MIS_PET();
	String strNOM_MIS_PET = bean.getNOM_MIS_PET();
 	long lCOD_TPL_MIS_PET = bean.getCOD_TPL_MIS_PET();

	long lCOD_RSO = bean.getCOD_RSO();

	ID = new Long(lCOD_RSO);
	Rischio_bean = RischioHome.findByPrimaryKey(new RischioPK(Security.getAzienda(), ID.longValue()));//ID);
	String strNOM_RSO = Rischio_bean.getNOM_RSO();

	
	
%>
	<script type="text/javascript">
<!--
	parent.document.all['COD_MIS_PET'].value = "<%=Formatter.format(lCOD_MIS_PET)%>"; 
	parent.document.all['NOM_MIS_PET'].value = "<%=Formatter.format(strNOM_MIS_PET)%>"; 

	parent.document.all['COD_TPL_MIS_PET'].value = "<%=Formatter.format(lCOD_TPL_MIS_PET)%>"; 

	parent.document.all['COD_RSO'].value = "<%=Formatter.format(lCOD_RSO)%>"; 
	parent.document.all['NOM_RSO'].value = "<%=Formatter.format(strNOM_RSO)%>"; 
// -->
	</script>
<%
}

if ("LOV_MIS_PET_LUO_MAN".equals(request.getParameter("LOCAL_MODE")))
{
	if ("L".equals(request.getParameter("TYPE"))) {
    	IMisurePreventive bean = null;
    	IMisurePreventiveHome MisureHome=(IMisurePreventiveHome)PseudoContext.lookup("MisurePreventiveBean");
    	Long ID = new Long(request.getParameter("ID"));
    	bean = MisureHome.findByPrimaryKey(ID);
    	long lCOD_MIS_RSO_LUO = bean.getCOD_MIS_RSO_LUO();
    	long lCOD_LUO_FSC = bean.getCOD_LUO_FSC();
    	IAnagrLuoghiFisici Anagr_bean = null;
    	IAnagrLuoghiFisiciHome AnagrLuoghiHome=(IAnagrLuoghiFisiciHome)PseudoContext.lookup("AnagrLuoghiFisiciBean");
    	Anagr_bean = AnagrLuoghiHome.findByPrimaryKey(new Long(lCOD_LUO_FSC));
    	String strNOM_LUO_FSC = Anagr_bean.getNOM_LUO_FSC();
%>
      <script type="text/javascript">
      <!--
		parent.document.all['COD_MIS_PET_LUO_MAN'].value = "<%=Formatter.format(lCOD_MIS_RSO_LUO)%>"; 
      	parent.document.all['NOM_MIS_PET_LUO_MAN'].value = "<%=Formatter.format(strNOM_LUO_FSC)%>"; 
      // -->
      </script>
<%
	} else {
    	IAssMisuraAttivita bean = null;
    	IAssMisuraAttivitaHome AssMisuraHome=(IAssMisuraAttivitaHome)PseudoContext.lookup("AssMisuraAttivitaBean");
    
    	Long ID = new Long(request.getParameter("ID"));
    	bean = AssMisuraHome.findByPrimaryKey(ID);
    
    	long lCOD_MIS_PET_MAN = bean.getCOD_MIS_PET_MAN();
    	long lCOD_MIS_PET = bean.getCOD_MIS_PET();

    	IMisuraPreventiva Mis_bean = null;
    	IMisuraPreventivaHome MisuraHome=(IMisuraPreventivaHome)PseudoContext.lookup("MisuraPreventivaBean");
    	Mis_bean = MisuraHome.findByPrimaryKey(new MisuraPreventivaPK(lCOD_AZL, lCOD_MIS_PET));
			String strNOM_MIS_PET = Mis_bean.getNOM_MIS_PET();
%>
      	<script type="text/javascript">
      <!--
				parent.document.all['COD_MIS_PET_LUO_MAN'].value = "<%=Formatter.format(lCOD_MIS_PET_MAN)%>"; 
      	parent.document.all['NOM_MIS_PET_LUO_MAN'].value = "<%=Formatter.format(strNOM_MIS_PET)%>"; 
      // -->
      	</script>
<%
	}
}

if ("LOV_RSO".equals(request.getParameter("LOCAL_MODE")))
{
	IRischio bean = null;
	IRischioHome RischioHome=(IRischioHome)PseudoContext.lookup("RischioBean");
	
	Long ID = new Long(request.getParameter("ID"));
	bean = RischioHome.findByPrimaryKey(new RischioPK(Security.getAzienda(), ID.longValue()));
	long lCOD_RSO = bean.getCOD_RSO();
	String strNOM_RSO = bean.getNOM_RSO();

%>
	<script type="text/javascript">
<!--
	parent.document.all['COD_RSO'].value = "<%=Formatter.format(lCOD_RSO)%>"; 
	parent.document.all['NOM_RSO'].value = "<%=Formatter.format(strNOM_RSO)%>"; 
// -->
	</script>
<%
}

%>

