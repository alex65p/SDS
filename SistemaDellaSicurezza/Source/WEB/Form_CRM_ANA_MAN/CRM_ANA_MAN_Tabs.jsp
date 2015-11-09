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
    <version number="1.0" date="15/03/2004" author="Podmasteriev Alexandr">
          <comments>
                  <comment date="15/03/2004" author="Podmasteriev Alexandr">
                   <description>Create</description>
                  </comment>
        </comments>
    </version>
  </versions>
</file>               
*/
%>
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<div id=divFile>
&nbsp
<%
String strNOM="";
String COLOR_TXT="";
String Disabl_text="";
long lCOD_AZL = Security.getAzienda();
if (request.getParameter("NOME")!=null){
   strNOM=request.getParameter("NOME");
} else {
   strNOM="";
}
strNOM+="%";
//out.print(strNOM);

    IAttivitaLavorativeHome home=(IAttivitaLavorativeHome)PseudoContext.lookup("AttivitaLavorativeBean");
    Collection col = home.getAttivitaLavorativa_CRM_MAN_View(strNOM,lCOD_AZL);
    Iterator it = col.iterator();
        long i=0;
        while(it.hasNext()){
          AttivitaLavorativa_CRM_MAN_View rst=(AttivitaLavorativa_CRM_MAN_View)it.next();
%>
	<table border='0' id='SchedeParagrafoTab' width="690" class='dataTable' cellpadding='0' cellspacing='0'>
<%	    if(rst.lFLAG!=0)
				{
				  COLOR_TXT="style='color:red;'";
					Disabl_text="disabled";
					
				}
				else
				{
				  COLOR_TXT="style='color:black;'";
					Disabl_text="";
				}
            out.print("<tr ID=\""+rst.lCOD_MAN+"\" >");
            out.print("<td class='1dataTd' width='335'><input type='text' readonly class='dataInput' size='68' "+COLOR_TXT+"  value=\""+Formatter.format(rst.strNOM_MAN)+"\"></td>");
            out.print("<td class='1dataTd' width='335'><input type='text' readonly class='dataInput' size='68' "+COLOR_TXT+"  value=\""+Formatter.format(rst.strDES_MAN)+"\"></td>");
            out.print("<td class='1dataTd' width='20'><input name='COD_MAN' id='COD_MAN"+i+"' type='checkbox' "+COLOR_TXT+"  class='checkbox' "+Disabl_text+"  value=\""+Formatter.format(rst.lCOD_MAN)+"\"></td>");
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
