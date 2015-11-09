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

<%@page import="s2s.utils.text.StringManager"%>
<%
    /*
     * <file> <versions> <version number="1.0" date="09/02/2004" author="Mike
     * Kondratyuk"> <comments> <comment date="09/02/2004" author="Mike
     * Kondratyuk"> <description>Shablon formi ANA_FOR_Delete.jsp</description>
     * </comment> </comments> </version> </versions> </file>
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.GestioniSezioni.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script>
    var err=false;
</script>

<%
    IGestioniSezioni GestioniSezioni = null;
    String COD_CPL = request.getParameter("ID");
    boolean deleteFromArea = 
            StringManager.isNotEmpty(request.getParameter("DELETE_FROM_AREA"));
    
    if (StringManager.isNotEmpty(COD_CPL)){
        String COD_ARE = request.getParameter("ID_PARENT");
        
        IGestioniSezioniHome home = (IGestioniSezioniHome) PseudoContext.lookup("GestioniSezioniBean");
        try {
            GestioniSezioni = home.findByPrimaryKey(Long.parseLong(COD_ARE));
            GestioniSezioni.removeCOD_CPL(Long.parseLong(COD_CPL));
        } catch (Exception ex) {
            out.print("<script>err=true;</script>");
            ex.printStackTrace();
        }
    } else {
        out.print("<script>err=true;</script>");
    }
%>
<script>
    if (!err) {	
        Alert.Success.showDeleted();
        if (<%=deleteFromArea%>){
            parent.del_localRow();
        } else {
            parent.ToolBar.OnDelete();
        }
    } else {
        Alert.Error.showDelete();
    } 
</script>

