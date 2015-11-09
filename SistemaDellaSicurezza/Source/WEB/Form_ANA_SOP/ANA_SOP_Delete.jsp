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
    String LOCAL_MODE = request.getParameter("LOCAL_MODE");

    if (request.getParameter("ID") != null) {
        Long lCOD_AZL = Security.getAzienda();
        String sCOD_SOP = request.getParameter("ID");

        if (LOCAL_MODE == null) {
            Long lCOD_SOP = new Long(sCOD_SOP);
            try {
                home.remove(lCOD_SOP);
            } catch (Exception ex) {
                ex.printStackTrace();
                out.print("<script>err=true;</script>");
            }
        } else if (LOCAL_MODE.equals("DPD_INT")) {
            String sCOD_DPD = request.getParameter("ID");
            sCOD_SOP = request.getParameter("ID_PARENT");
            try {
                home.removeDPD(Long.parseLong(sCOD_SOP), Long.parseLong(sCOD_DPD), lCOD_AZL);
            } catch (Exception ex) {
                ex.printStackTrace();
                out.print("<script>err=true;</script>");
            }
        } else if (LOCAL_MODE.equals("DPD_EST")) {
            String sCOD_DPD = request.getParameter("ID");
            sCOD_SOP = request.getParameter("ID_PARENT");
            try {
                home.removeDPDImp(Long.parseLong(sCOD_SOP), Long.parseLong(sCOD_DPD), lCOD_AZL);
            } catch (Exception ex) {
                ex.printStackTrace();
                out.print("<script>err=true;</script>");
            }
        } else if (LOCAL_MODE.equals("CONDIS")) {
            String sCOD_SOP_CST = request.getParameter("ID");
            try {
                home.removeCONDIS(Long.parseLong(sCOD_SOP_CST));
            } catch (Exception ex) {
                ex.printStackTrace();
                out.print("<script>err=true;</script>");
            }
        } else if (LOCAL_MODE.equals("COL")) {
            String sCOD_DPD = request.getParameter("ID");
            String COD_SOP = request.getParameter("ID_PARENT");

            try {
                home.removeCOLLEGAMENTO(Long.parseLong(COD_SOP), Long.parseLong(sCOD_DPD), lCOD_AZL);
            } catch (Exception ex) {
                ex.printStackTrace();
                out.print("<script>err=true;</script>");
            }
        } else if (LOCAL_MODE.equals("MEDIA")) {
            String sCOD_MED = request.getParameter("ID");
            try {
                home.removeMEDIA(Long.parseLong(sCOD_MED));
            } catch (Exception ex) {
                ex.printStackTrace();
                out.print("<script>err=true;</script>");
            }
        } else if (LOCAL_MODE.equals("DOC_SOP")) {
            String sCOD_DPD = request.getParameter("ID");
            String COD_SOP = request.getParameter("ID_PARENT");
            try {
                home.removeDOC_GES_CAN_SOP(Long.parseLong(COD_SOP), Long.parseLong(sCOD_DPD), lCOD_AZL);
            } catch (Exception ex) {
                ex.printStackTrace();
                out.print("<script>err=true;</script>");
            }
        } else {
            out.print("<script>err=true;</script>");
        }
    }
%>
<script>
    if (err) Alert.Error.showDelete();
    <%if (LOCAL_MODE == null) {%>
        if (!err){
            Alert.Success.showDeleted();
            if(parent.ToolBar != null){
                parent.ToolBar.OnDelete();
            }
            parent.g_Handler.OnRefresh();
        }
    <%} else {%>
        if (!err){
            parent.del_localRow();
            if (<%=LOCAL_MODE.equals("CONDIS")%>){
                parent.tabbar.tabs[2].tabObj.Refresh();
            }
            Alert.Success.showDeleted();
        }
    <%}%>
</script>
