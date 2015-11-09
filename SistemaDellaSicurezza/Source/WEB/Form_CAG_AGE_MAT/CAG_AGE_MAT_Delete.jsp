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
     <version number="1.0" date="26/01/2004" author="Valentina Ruggieri">
     <comments>
     <comment date="26/01/2004" author="Valentina Ruggieri">
     <description>CAG_AGE_MAT_Delete.jsp</description>
     </comment>
     </comments>
     </version>
     </versions>
     </file>
     */
%>
<%@ page import="com.apconsulting.luna.ejb.CategoriaAgeMateriale.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script>
    var err = false;
</script>

<%    ICategoriaAgeMaterialeHome cathome = (ICategoriaAgeMaterialeHome) PseudoContext.lookup("CategoriaAgeMaterialeBean");
    if (request.getParameter("ID") != null) {
        String COD_CAG_AGE_MAT = request.getParameter("ID");
        Long cod_cag_age_mat = new Long(COD_CAG_AGE_MAT);
        try {
            cathome.remove(cod_cag_age_mat);
        } catch (Exception ex) {
            manageException(request, out, ex);
        }
    } else {
        out.print("<script>err=true;</script>");
    }
%>

<script>
    if (parent.dialogArguments) {
        if (!err) {
            Alert.Success.showDeleted();
            parent.returnValue = "OK";
        } else {
            parent.returnValue = "CANCEL";
        }
        parent.close();
    }
    else {
        if (!err) {
            Alert.Success.showDeleted();
            if (parent.ToolBar != null) {
                parent.ToolBar.OnDelete();
            }
            parent.g_Handler.OnRefresh();
        } else {
            Alert.Error.showDelete();
        }
    }
</script>
