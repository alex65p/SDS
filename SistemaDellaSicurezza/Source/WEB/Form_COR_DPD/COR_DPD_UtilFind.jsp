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
    <version number="1.0" date="23/02/2004" author="Kushkarov Yura">
	      <comments>
				  <comment date="23/02/2004" author="Kushkarov Yura">
				   <description>Shablon formi NAT_LES_Form.jsp</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Corsi.*" %>
<%@ page import="s2s.utils.text.StringManager"%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%
String strCOD_COR="";
String strDES_COR="";
ICorsiHome CorsiHome=(ICorsiHome)PseudoContext.lookup("CorsiBean");
ICorsi Corsi;
String ID = request.getParameter("ID");

if (ID != null && ID.equals("") == false && ID.equals("0") == false)
{
    strCOD_COR = request.getParameter("ID");
    Long Corsi_id=new Long(strCOD_COR);
    try {
        Corsi = CorsiHome.findByPrimaryKey(Corsi_id);
        if (Corsi!=null){
            if(strDES_COR!=null){
                // Correzione Bug 1.76
                strDES_COR = 
                        StringManager.prepareForJavaScript(Corsi.getDES_COR());
                out.print(strDES_COR);
            } else {
                strDES_COR="";
            }
        }
    }
    catch(Exception ex){
        out.print(Corsi_id);
    }
    %><script>parent.document.all['DES_COR'].value="<%=strDES_COR%>";</script><%
}
else{
    %><script>parent.document.all['DES_COR'].value='';</script>
<%}%>
