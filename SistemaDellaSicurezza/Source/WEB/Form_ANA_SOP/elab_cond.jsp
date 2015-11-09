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

<%-- 
    Document   : getdat_rev
    Created on : 24-mag-2011, 12.42.26
    Author     : Alessandro
--%>
<%@ page import="com.apconsulting.luna.ejb.Sopraluogo.*"%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%
        Long lcod_doc = Long.parseLong(request.getParameter("COD_DOC"));
        Long lcod_sop = Long.parseLong(request.getParameter("COD_SOP"));
        try {
            if (lcod_doc.equals(lcod_sop)){
                out.print("1");
                return;
            }
            ISopraluogoHome home = null;
            home = (ISopraluogoHome) PseudoContext.lookup("SopraluogoBean");
            Boolean brc = home.chkCOD_DOC(lcod_doc, lcod_sop);
            if (brc == false) {
                out.print("0");
                return;
            }
            home.addSOP_COL(lcod_sop, lcod_doc, 0);
        } catch (Exception ex) {
            ex.printStackTrace();
            return;
        }
%>
