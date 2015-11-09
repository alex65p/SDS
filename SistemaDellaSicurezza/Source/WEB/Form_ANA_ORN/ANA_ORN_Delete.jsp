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
     <version number="1.0" date="23/01/2004" author="Kushkarov Yura">
     <comments>
     <comment date="23/01/2004" author="Kushkarov Yura">
     <description>Shablon formi ANA_ORN_Delete.jsp</description>
     </comment>		
     </comments> 
     </version>
     </versions>
     </file> 
     */
%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/Organi/OrganiBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/Organi/OrganiBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>var err = false;</script>
<%    if (request.getParameter("ID") != null) {
        String COD_ORN_DEL = request.getParameter("ID");
        IOrganiHome home = (IOrganiHome) PseudoContext.lookup("OrganiBean");
        Long lCOD_ORN = new Long(COD_ORN_DEL);
        try {
            home.remove(lCOD_ORN);
        } catch (Exception ex) {
            manageException(request, out, ex);
        }
    }
%>
<script>
    if (err)
        Alert.Error.showDelete();
    else {
        Alert.Success.showDeleted();
        //parent.g_Handler.OnRefresh();
        parent.ToolBar.OnDelete();
    }
</script>

