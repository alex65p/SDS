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
    <version number="1.0" date="23/02/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="23/02/2004" author="Khomenko Juliya">
				   <description>Create</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Ruoli.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<div id="DivName">
    <%
            long lCOD_RUO = 0;			    //1 
            IRuoliHome home = (IRuoliHome) PseudoContext.lookup("RuoliBean");
            Checker c = new Checker();
            lCOD_RUO = c.checkLong("Ruoli ID", request.getParameter("COD_RUO"), true);

            String str = "";
            java.util.Collection col_des = home.getDES_FUZ_LNG_ByID_View(lCOD_RUO);

            str += "<table border='0' id='Ruoli'class='dataTable' cellpadding='0' cellspacing='0'>";
            str += "<tr style='display:none' ID='' INDEX='" + lCOD_RUO + "'>";
            str += "<td width='300' class='dataTd'><input type='text' name='DEZ_FUZ' class='dataInput' readonly  value=''></td>";
            str += "<td width='100' class='dataTd'><input type='text' name='' class='dataInput' readonly  value=''></td>";
            str += "<td width='100' class='dataTd'><input type='text' name='' readonly class='dataInput'  value=''></td>";
            str += "<td width='100' class='dataTd'><input type='text' name='' readonly class='dataInput'  value=''></td></tr>";

            str +=  "<tr>";
            str +=      "<td width='300'>&nbsp;- TUTTE</td>";
            str +=      "<td align='center' width='100'><input name='TUTTE' class='checkbox' type='radio' onclick=\"SelectAll('G')\"></td>";
            str +=      "<td align='center' width='100'><input name='TUTTE' class='checkbox' type='radio' onclick=\"SelectAll('L')\"></td>";
            str +=      "<td align='center' width='100'><input name='TUTTE' class='checkbox' type='radio' onclick=\"SelectAll('N')\"></td>";
            str +=  "</tr>";
            
            str += home.getRecurseFuz(lCOD_RUO, 0, 0, col_des);
            
            str += "</table>";
            out.print(str);
    %>
</div>
<script type="text/javascript">
    onload = function(){
        parent.document.all["divTab"].innerHTML=document.all["DivName"].innerHTML;
    }
</script> 
