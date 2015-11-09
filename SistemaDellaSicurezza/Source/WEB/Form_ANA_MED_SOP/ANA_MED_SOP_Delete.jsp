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
    <version number="1.0" date="19/01/2004" author="Pogrebnoy Yura">
    <comments>
    <comment date="19/01/2004" author="Pogrebnoy Yura">
    <description>Shablon formi ANA_ALA_Delete.jsp</description>
    </comment>		
    </comments> 
    </version>
    </versions>
    </file> 
     */
%>
<%@ page import="com.apconsulting.luna.ejb.Sopraluogo.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script>var err=false;</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
    ISopraluogoHome home = (ISopraluogoHome) PseudoContext.lookup("SopraluogoBean");
    String COD_MED_SOP = request.getParameter("ID");
    if (COD_MED_SOP != null) {
        try {
            home.removeMEDIA(Long.valueOf(COD_MED_SOP));
        } catch (Exception ex) {
            out.print("<script>err=true;</script>");
        }
    } else {
        out.print("<script>err=true;</script>");
    }
%>
<script>
    if (!err){
        Alert.Success.showDeleted();
        parent.ToolBar.OnDelete();
    }else{
        Alert.Error.showDelete();
    }
</script>
