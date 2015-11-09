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
    <version number="1.0" date="24/01/2004" author="Kushkarov Yura">
	      <comments>
				  <comment date="24/01/2004" author="Kushkarov Yura">
				   <description>Shablon formi NAT_LES_Form.jsp</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.TipologiaDPI.*" %>
<%@ page import="com.apconsulting.luna.ejb.LottiDPI.*" %>
<%@ page import="com.apconsulting.luna.ejb.Fornitore.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%
String           strCOD_LOT_DPI="";
String         	 strRAG_SOC_FOR_AZL="";            //10
	String         strDAT_CSG_LOT="";
	long           strQTA_FRT=0;
	long           strQTA_AST=0;
	long           strQTA_DSP=0;
	long           COD_TPL_DPI=0;
String					 strNOM_TPL_DPI="";
	
ILottiDPIHome LottiDPIHome=(ILottiDPIHome)PseudoContext.lookup("LottiDPIBean");
ILottiDPI LottiDPI;

ITipologiaDPIHome TipologiaDPIHome=(ITipologiaDPIHome)PseudoContext.lookup("TipologiaDPIBean");
ITipologiaDPI TipologiaDPI;

IFornitoreHome FornitoreHome=(IFornitoreHome)PseudoContext.lookup("FornitoreBean");
IFornitore Fornitore;

if((request.getParameter("ID")!=null)&&(!request.getParameter("ID").equals(null))&&(!request.getParameter("ID").equals("0")))
{
   strCOD_LOT_DPI = request.getParameter("ID");
	 Long LottiDPI_id=new Long(strCOD_LOT_DPI);
	 
	 LottiDPI = LottiDPIHome.findByPrimaryKey(LottiDPI_id);
	 Long Fornitore_id=new Long(LottiDPI.getCOD_FOR_AZL());
	 Fornitore = FornitoreHome.findByPrimaryKey(Fornitore_id);
	 strRAG_SOC_FOR_AZL=Fornitore.getRAG_SOC_FOR_AZL();
		strDAT_CSG_LOT=Formatter.format(LottiDPI.getDAT_CSG_LOT());
		strQTA_FRT=LottiDPI.getQTA_FRT();
		strQTA_AST=LottiDPI.getQTA_AST();
		strQTA_DSP=LottiDPI.getQTA_DSP();
		COD_TPL_DPI=LottiDPI.getCOD_TPL_DPI();
	 Long TipologiaDPI_id=new Long(COD_TPL_DPI);
	 TipologiaDPI = TipologiaDPIHome.findByPrimaryKey(TipologiaDPI_id);
	 strNOM_TPL_DPI=TipologiaDPI.getNOM_TPL_DPI();
	// out.print(strNOM_TPL_DPI);
%>
<script>
//alert(<%=strNOM_TPL_DPI%>);
  parent.document.all['COD_TPL_DPI'].value='<%=COD_TPL_DPI%>';
	parent.document.all['RAG_SOC_FOR_AZL'].value='<%=strRAG_SOC_FOR_AZL%>';
	parent.document.all['NOM_TPL_DPI'].value='<%=strNOM_TPL_DPI%>';
	parent.document.all['DAT_CSG_LOT'].value='<%=strDAT_CSG_LOT%>';
	parent.document.all['QTA_FRT'].value='<%=strQTA_FRT%>';
	parent.document.all['QTA_AST'].value='<%=strQTA_AST%>';
	parent.document.all['QTA_DSP'].value='<%=strQTA_DSP%>';
</script>
<%
}
else
{
%>
<script>
//alert(<%=strNOM_TPL_DPI%>);
  parent.document.all['COD_TPL_DPI'].value='';
	parent.document.all['RAG_SOC_FOR_AZL'].value='';
	parent.document.all['NOM_TPL_DPI'].value='';
	parent.document.all['DAT_CSG_LOT'].value='';
	parent.document.all['QTA_FRT'].value='';
	parent.document.all['QTA_AST'].value='';
	parent.document.all['QTA_DSP'].value='';
</script>
<%}%>
