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
<%@ page import="com.apconsulting.luna.ejb.MisuraPreventiva.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%
String strCOD_MIS_PET="";
String strDAT_CMP="";
String strDES_MIS_PET="";
long lCOD_AZL=Security.getAzienda();
IMisuraPreventivaHome MisuraPreventivaHome=(IMisuraPreventivaHome)PseudoContext.lookup("MisuraPreventivaBean");
IMisuraPreventiva MisuraPreventiva=null;

if((request.getParameter("ID")!=null)&&(!request.getParameter("ID").equals(null))&&(!request.getParameter("ID").equals("0")))
{
   strCOD_MIS_PET = request.getParameter("ID");
	 Long MisuraPreventiva_id=new Long(strCOD_MIS_PET);
	 MisuraPreventiva = MisuraPreventivaHome.findByPrimaryKey( new MisuraPreventivaPK(lCOD_AZL ,MisuraPreventiva_id.longValue()) );
	 strDAT_CMP=Formatter.format(MisuraPreventiva.getDAT_CMP());
	 strDES_MIS_PET=MisuraPreventiva.getDES_MIS_PET();
         strDES_MIS_PET=strDES_MIS_PET.replace('"',' ');
         
         String list_des[] = strDES_MIS_PET.split("\n");
         String des = "parent.document.all['DES_MIS_PET'].value=\"";
         for (int i = 0; i<list_des.length; i++){
             des = des + list_des[i].replaceAll("\r", "\\\\n");
             
         }
         des = des + "\"";
%>
<script>
    parent.document.all['DAT_CMP'].value="<%=strDAT_CMP%>";
    <%out.print(des);%>
</script>
<%
}else{
%>
<script>
    parent.document.all['DAT_CMP'].value='';
    parent.document.all['DES_MIS_PET'].value='';
</script>
<%}%>
