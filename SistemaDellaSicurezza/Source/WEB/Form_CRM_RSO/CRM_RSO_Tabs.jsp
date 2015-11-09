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
    <version number="1.0" date="15/03/2004" author="Khomenko Juli">
          <comments>
                  <comment date="15/03/2004" author="Khomenko Juli">
                   <description>Create</description>
                  </comment>
        </comments>
    </version>
  </versions>
</file>               <script language="JavaScript" src="CRM_RSO_Script.js"></script>
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<div id=divFile>
<%
String strNOM="";
if (request.getParameter("NOME")!=null){
   strNOM=request.getParameter("NOME");
} else {
   strNOM="";
}
strNOM+="%";
//out.print(strNOM);

    IRischioHome home=(IRischioHome)PseudoContext.lookup("RischioBean");
    Collection col = home.getRischio_CRM_RSO_View(strNOM, Security.getAzienda());
    Iterator it = col.iterator();
        long i=0;
%>
	<table border='0' id='SchedeParagrafoTab' class='dataTable' cellpadding='0' cellspacing='0'>
<%
        while(it.hasNext()){
		  String color = "";
		  String disabled = "";
          Rischio_CRM_RSO_View rst=(Rischio_CRM_RSO_View)it.next();
          if(rst.lIS_RED == 1){
          	color = " style=\"color:red\"";
          	disabled = "disabled";
          }
            out.print("<tr ID=\""+rst.lCOD_RSO+"\">");
            out.print("<td class='1dataTd' width=''><input type='text' readonly class='dataInput' size='68'  value=\""+Formatter.format(rst.strNOM_RSO)+"\""+color+"></td>");
            out.print("<td class='1dataTd' width=''><input type='text' readonly class='dataInput' size='68'  value=\""+Formatter.format(rst.strDES_RSO)+"\""+color+"></td>");
            out.print("<td class='1dataTd' width=''><input name='COD_RSO' id='COD_RSO"+i+"' type='checkbox' class='checkbox'  value=\""+Formatter.format(rst.lCOD_RSO)+"\""+disabled+"></td>");
            out.print("</tr>");
            i=i+1;
        }
%>
	</table>
</div>

<script>
  parent.document.all['div_s'].innerHTML=document.all['divFile'].innerHTML;
</script>
