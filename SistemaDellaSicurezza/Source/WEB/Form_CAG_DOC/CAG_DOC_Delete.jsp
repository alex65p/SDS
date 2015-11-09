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
     <version number="1.0" date="20/01/2004" author="Kushkarov Yura">
     <comments>
     <comment date="20/01/2004" author="Kushkarov Yura">
     <description>Shablon formi ANA_CAG_DOC_Delete.jsp</description>
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

<%@ include file="../src/com/apconsulting/luna/ejb/CategoriaDocumento/CategoriaDocumentoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/CategoriaDocumento/CategoriaDocumentoBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script>var err = false;</script>

<%    if (request.getParameter("ID") != null) {
        String COD_CAG_DOC_DEL = request.getParameter("ID");
        ICategoriaDocumentoHome home = (ICategoriaDocumentoHome) PseudoContext.lookup("CategoriaDocumentoBean");
        Long lCOD_CAG_DOC = new Long(COD_CAG_DOC_DEL);
        try {
            home.remove(lCOD_CAG_DOC);
        } catch (Exception ex) {
            manageException(request, out, ex);
        }
    }
%>
<script>
    if (!err) {
        Alert.Success.showDeleted();
        //parent.g_Handler.OnRefresh();
        parent.ToolBar.OnDelete();
    }
</script>
