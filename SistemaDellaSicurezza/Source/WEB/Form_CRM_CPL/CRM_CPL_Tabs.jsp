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
    <version number="1.0" date="22/03/2004" author="Malyuk Sergey">
          <comments>
                  <comment date="22/03/2004" author="Malyuk Sergey">
                   <description>Create</description>
                  </comment>
        </comments>
    </version>
  </versions>
</file>               <script language="JavaScript" src="CRM_RSO_Script.js"></script>
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.Capitoli.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<div id=divFile>
&nbsp
<%
String strNOM="";
if (request.getParameter("NOME")!=null){
   strNOM=request.getParameter("NOME");
} else {
   strNOM="";
}
strNOM+="%";
//out.print(strNOM);

    ICapitoliHome home=(ICapitoliHome)PseudoContext.lookup("CapitoliBean");
    Collection col = home.getCapitoli_CRM_CPL_View(strNOM);
    Iterator it = col.iterator();
        long i=0;
        while(it.hasNext()){
          Capitoli_CRM_CPL_View rst=(Capitoli_CRM_CPL_View)it.next();
%>
	<table border='0' id='SchedeParagrafoTab' class='dataTable' cellpadding='0' cellspacing='0'>
<%
            out.print("<tr ID=\""+rst.COD_CPL+"\">");
            out.print("<td class='1dataTd' width=''><input name='NOM_CPL_R' type='text' readonly class='dataInput' size='68'  value=\""+Formatter.format(rst.NOM_CPL)+"\"></td>");
            out.print("<td class='1dataTd' width=''><input name='COD_CPL_R' id='COD_CPL_R"+i+"' type='checkbox' class='checkbox'  value=\""+Formatter.format(rst.COD_CPL)+"\"></td>");
            out.print("</tr>");
            i=i+1;
%>
	</table>
<%
        }
%></div>

<script>
 	parent.document.all['div_s'].innerHTML=document.all['divFile'].innerHTML;
</script>
