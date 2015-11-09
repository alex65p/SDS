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
     <description>CAG_AGE_MAT_Set.jsp</description>
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

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%    
    ICategoriaAgeMateriale categoria = null;
    ICategoriaAgeMaterialeHome cathome = (ICategoriaAgeMaterialeHome) PseudoContext.lookup("CategoriaAgeMaterialeBean");

    Checker c = new Checker();
    Long lCOD_CAG_AGE_MAT = new Long(c.checkLong(ApplicationConfigurator.LanguageManager.getString("Categoria.agente.materiale"), request.getParameter("COD_CAG_AGE_MAT"), false));
    String strNOM_CAG_AGE_MAT = c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"), request.getParameter("NOM_CAG_AGE_MAT"), true);

    if (c.isError) {
        String err = c.printErrors();
%><script>alert("<%=err%>");</script><%
        return;
    }
%>
<script>
    var err = false;
    var isNew = false;
</script>
<%
    String ReqMODE;	// parameter of request
    if (request.getParameter("SBM_MODE") != null) {
        ReqMODE = request.getParameter("SBM_MODE");
        if (ReqMODE.equals("edt")) {
            categoria = cathome.findByPrimaryKey(lCOD_CAG_AGE_MAT);
            try {
                categoria.setNOM_CAG_AGE_MAT(strNOM_CAG_AGE_MAT);		//1
            } catch (Exception ex) {
                out.println("<script>Alert.Error.showDublicate();err=true</script>");
                return;
            }
        }
        if (ReqMODE.equals("new")) {
            try {
                categoria = cathome.create(strNOM_CAG_AGE_MAT);
%><script>isNew = true;</script><%
        } catch (Exception ex) {
            out.println("<script>Alert.Error.showDublicate();err=true</script>");
            return;
        }
    }
%>
<script>
    if (parent.dialogArguments) {
        if (!err) {
            da = parent.dialogArguments;
            da.ID = "<%= categoria.getCOD_CAG_AGE_MAT()%>";
            da.NOM_CAG_AGE_MAT = "<%= categoria.getNOM_CAG_AGE_MAT()%>";
            parent.returnValue = "OK";
            if (isNew) {
                Alert.Success.showCreated();
                parent.ToolBar.Return.OnClick();
            } else {
                Alert.Success.showSaved();
            }
        } else {
            parent.returnValue = "ERROR";
        }
    } else {
        if (!err) {
            parent.returnValue = "OK";
            if (isNew) {
                Alert.Success.showCreated();
                parent.ToolBar.OnNew("ID=<%=categoria.getCOD_CAG_AGE_MAT()%>");
            } else {
                Alert.Success.showSaved();
            }
        } else {
            parent.returnValue = "ERROR";
        }
    }
</script>
<%}%>

