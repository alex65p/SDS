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
<%@ page import="s2s.utils.text.StringManager" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="ANA_CON-DIS_SOP_Util.jsp"%>
<%
    Long lcod_sop_cst = 0L;
    Long lcod_fat_rso = 0L;
    Long lcod_cst_lst = null;
    
    if (request.getParameter("COD_SOP_CST") != null) {
        lcod_sop_cst = Long.parseLong(request.getParameter("COD_SOP_CST"));
    }
    if (request.getParameter("COD_FAT_RSO") != null) {
        lcod_fat_rso = Long.parseLong(request.getParameter("COD_FAT_RSO"));
    }
    if (request.getParameter("COD") != null) {
        lcod_cst_lst = Long.parseLong(request.getParameter("COD"));
    }
    String tipo = request.getParameter("TIPO");
    boolean onlyDisp = request.getParameter("onlyDisp")!=null
            ?Boolean.parseBoolean(request.getParameter("onlyDisp"))
            :false;
    
    if (tipo != null) {
        Long lCOD_AZL = Security.getAzienda();
        ISopraluogoHome home = (ISopraluogoHome) PseudoContext.lookup("SopraluogoBean");
        
        if (tipo.equals("FATRSO")) {
            out.print(ListaFattoriRischio(home, lcod_fat_rso, lCOD_AZL));
        } else if (tipo.equals("CONST")) {
            out.println(ListaConstatazioni(home, lcod_fat_rso, lcod_cst_lst, lCOD_AZL));
        } else if (tipo.equals("RISC")) {
            out.println(ListaRischi(home, 0L, lCOD_AZL, lcod_cst_lst));
        } else if (tipo.equals("DISP")) {
            out.println(ListaDisposizioni(home, 0L, lCOD_AZL, lcod_cst_lst));
        } else if (tipo.equals("GENDIS")) {
            out.println(ListaDisposizioniGenerate(home, 0L, lCOD_AZL, lcod_cst_lst, lcod_sop_cst, 1, onlyDisp));
        } else if (tipo.equals("RETLEG")) {
            out.println(ListaArticoliLegge(home, 0L, lCOD_AZL, lcod_cst_lst, 1));
        }
   }
%>
