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

<%@ page import="com.apconsulting.luna.ejb.MisuraPreventiva.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<script>
//var obj2=parent.document.all["ATTIVITA"];
//obj2.options.length=1;
//var i=0;
</script>
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server

//-----start check section--------------------------------
String strTYPE=request.getParameter("TYPE");
long lCOD_AZL=new Long(request.getParameter("AZIENDA")).longValue();
IMisuraPreventivaHome MisuraPreventivaHome=(IMisuraPreventivaHome)PseudoContext.lookup("MisuraPreventivaBean");
if("MIS_MAN".equals(strTYPE))
{
String str="<select style='width:310px' name='COD_MIS_PET_LUO_MAN' id='COD_MIS_PET_LUO_MAN'><option value='0'></option>";
	  java.util.Collection col_nr = MisuraPreventivaHome.getMisure_Preventive_MAN_ByAzienda_View(lCOD_AZL);
		java.util.Iterator it_nr = col_nr.iterator();
 		while(it_nr.hasNext()){
			Misure_Preventive_MAN_ByAzienda_View nr=(Misure_Preventive_MAN_ByAzienda_View)it_nr.next();
			str+="<option value=\""+nr.lCOD_MIS_PET+"\">"+nr.strNOM_MIS_PET+"</option>";
  	}
str+="</select>";
%>
<div id="srcDiv"><%out.print(str);%></div>
<script language="JavaScript" type="text/javascript">
  parent.document.all['MIS_PET_LUO'].innerHTML=document.all['srcDiv'].innerHTML;
</script>
<%
}
if("LUO_MIS".equals(strTYPE))
{
String str="<select style='width:310px' name='COD_MIS_PET_LUO_MAN' id='COD_MIS_PET_LUO_MAN'><option value='0'></option>";
	  java.util.Collection col_l = MisuraPreventivaHome.getMisure_Preventive_LUO_ByAzienda_View(lCOD_AZL);
		java.util.Iterator it_l = col_l.iterator();
 		while(it_l.hasNext()){
			Misure_Preventive_LUO_ByAzienda_View l=(Misure_Preventive_LUO_ByAzienda_View)it_l.next();
			str+="<option value=\""+l.lCOD_MIS_PET+"\">"+l.strNOM_MIS_PET+"</option>";
  	}
str+="</select>";
%>
<div id="srcDiv"><%out.print(str);%></div>
<script language="JavaScript" type="text/javascript">
  parent.document.all['MIS_PET_LUO'].innerHTML=document.all['srcDiv'].innerHTML;
</script>
<%
}
%>
