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
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
            response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="ANA_MAN_Util.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script type="text/javascript">
    err = false;
</script>
<div id="dContent">
    <%
                long lCOD_AZL = Security.getAzienda();
                String nameTab = new String();
                String err = new String();
                String str = new String();
                boolean isError = false;
                java.util.Collection col;
                java.util.Iterator it;
                //---------------------------------------------------------------------------------------------------
                IAttivitaLavorative bean = null;
                IAttivitaLavorativeHome home = (IAttivitaLavorativeHome) PseudoContext.lookup("AttivitaLavorativeBean");
                //---------------------------------------------------------------------------------------------------
                if (request.getParameter("ID_PARENT") != null) {
                    Long ID = new Long(request.getParameter("ID_PARENT"));
                    try {
                        bean = home.findByPrimaryKey(new AttivitaLavorativePK(lCOD_AZL, ID.longValue()));
                    } catch (Exception ex) {
                        err = "Cannot find record with ID=" + ID.toString();
                        err += "\\n" + ex.getMessage();
                        out.print("<script>alert(\"" + err + "\");</script>");
                        return;
                    }
                }
                //-----------------------------------------------------------------------------------------------
                if (request.getParameter("TAB_NAME") != null) {
                    nameTab = request.getParameter("TAB_NAME");
                } else {
                    err = "Parameter TAB_NAME not defined";
                    out.print("<script>err = true</script>");
                }
                //-----------Tabs reloaddefinitions----------
                try {
                    //--------------------------------------
                    if (!isError && nameTab.equals("tab1")) {
                        out.print(BuildOperazioniSvolteTab(bean));
                    }
                    if (!isError && nameTab.equals("tab2")) {
                        out.print(BuildRischiTab(bean, lCOD_AZL));
                    }
                    if (!isError && nameTab.equals("tab3")) {
                        out.print(BuildAgentiChimiciTab(bean));
                    }
                    if (!isError && nameTab.equals("tab4")) {
                        out.print(BuildCorsiTab(bean));
                    }
                    if (!isError && nameTab.equals("tab5")) {
                        out.print(BuildProtocoliSanitariTab(bean));
                    }
                    if (!isError && nameTab.equals("tab6")) {
                        out.print(BuildDPITab(bean));
                    }
                    if (!isError && nameTab.equals("tab7")) {
                        out.print(BuildRischioChimicoTab(bean));
                    } 
                    if (!isError && nameTab.equals("tab8")) {
                        out.print(BuildMacchinaTab(bean));
                    }
                    if (!isError && nameTab.equals("tab9")) {
                        out.print(BuildDocumentiTab(bean));
                    }
                    
                    //----------------------------------------
                } catch (Exception ex) {
                    err = "Impossibile ricostruire il contenuro della tab " + nameTab;
                    err += "\\n" + ex.getMessage();
                    out.print("<script>alert(\"" + err + "\");</script>");
                    return;
                }
    %>
</div>
<script type="text/javascript">
    if (!err){
        top.document.forms[0].IDX_RSO_CHI.value = "<%=bean.getIDX_RSO_CHI() + " (" + bean.getDescRischio(bean.getIDX_RSO_CHI()) + ")"%>";
        parent.tabbar.ReloadTabTable(document);
    }
</script>
