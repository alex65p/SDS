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
     <version number="1.0" date="22/01/2004" author="Mike Kondratyuk">
     <comments>
     <comment date="22/01/2004" author="Mike Kondratyuk">
     <description>Shablon formi ANA_FOR_Delete.jsp</description>
     </comment>
     <comment date="28/01/2004" author="Juliya Khomenko">
     <description>Delete dlya tabi</description>
     </comment>
     </comments>
     </version>
     </versions>
     </file>
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.ValutazioneRischi.*" %>
<%@ page import="com.apconsulting.luna.ejb.GestioniSezioni.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script>
    var err = false;
    var errDescr;
</script>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
    IValutazioneRischi ValutazioneRischi = null;
    if (request.getParameter("ID") != null) {
        String COD_ARE_DEL = request.getParameter("ID");
        String COD_DOC_VLU_DEL = request.getParameter("ID_PARENT");
        if (COD_DOC_VLU_DEL != null && !COD_DOC_VLU_DEL.equals("") && !COD_DOC_VLU_DEL.equals("null")) {
            long lCOD_ARE_DEL = Long.parseLong(COD_ARE_DEL);
            Long lCOD_DOC_VLU_DEL = new Long(COD_DOC_VLU_DEL);
            IValutazioneRischiHome vhome = (IValutazioneRischiHome) PseudoContext.lookup("ValutazioneRischiBean");
            ValutazioneRischi = vhome.findByPrimaryKey(lCOD_DOC_VLU_DEL);
            try {
                ValutazioneRischi.removeCOD_ARE(lCOD_ARE_DEL);
            } catch (Exception ex) {
                manageException(request, out, ex);
            }
        } else {
            IGestioniSezioniHome home = (IGestioniSezioniHome) PseudoContext.lookup("GestioniSezioniBean");
            Long ana_sit_azl_id = new Long(COD_ARE_DEL);
            try {
                home.remove(ana_sit_azl_id);
            } catch (Exception ex) {
                manageException(request, out, ex);            
            }
        }
    } else {
        out.print("<script>err=true; errDescr = 'Non puoi trovare ID di Risposta'</script>");
    }
%>

<script>
    <%
        if (request.getParameter("ID_PARENT") != null) {
    %>
    if (!err) {
        parent.del_localRow();
    } else {
        Alert.Error.ShowDelete();
    }
    <%
    } else {
    %>
    if (!err) {
        parent.ToolBar.OnDelete();
        Alert.Success.showDeleted();
    } else {
        Alert.Error.showDelete();
    }
    <%
        }
    %>
</script>
