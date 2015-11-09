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
    <version number="1.0" date="27/01/2004" author="Pogrebnoy Yura">
	      <comments>
				  <comment date="27/01/2004" author="Pogrebnoy Yura">
				   <description>Udalenie zapisi v tabe</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Consulente.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script>var err=false;</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
    IConsultant cou=null;
    if(request.getParameter("ID")!=null)
    {	
        String strCOD_AZL=request.getParameter("ID");
        String strCOD_COU=request.getParameter("ID_PARENT");
        IConsultantHome home=(IConsultantHome)PseudoContext.lookup("ConsultantBean");
	try{
            if (home.getAZL_COU_TABCount() > 1){
                home.removeCOD_AZL(strCOD_COU,strCOD_AZL);
            } else {
                out.print("<script>alert(arraylng[\"MSG_0187\"]);</script>");
                return;
            }
	}catch(Exception ex){
            out.print("<script>err=true;</script>");
	}
    } else {
        out.print("<script>err=true;</script>");
    }
%>
<script>
    if (!err){
        Alert.Success.showDeleted();
        parent.del_localRow();
        parent.returnValue="OK"; 
    }else{
        Alert.Error.showDelete();
        parent.returnValue="CANCEL"; 
    }
</script>
