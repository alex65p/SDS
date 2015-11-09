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
     <version number="1.0" date="25/01/2004" author="Kushkarov Yura">
     <comments>
     <comment date="25/01/2004" author="Kushkarov Yura">
     <description>Shablon formi SCH_INR_PSD_Delete.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.ErogazioneCorsi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
    var err = false;
</script>

<%
    IErogazioneCorsi ErogazioneCorsi = null;
    if (request.getParameter("ID") != null) {
        if (request.getParameter("ID_PARENT") != null) {
            String strCOD_SCH_EGZ_COR = request.getParameter("ID_PARENT");
            String strCOD_DPD = request.getParameter("ID");
            long lCOD_DPD = new Long(strCOD_DPD).longValue();
            Long lCOD_SCH_EGZ_COR = new Long(strCOD_SCH_EGZ_COR);
            long llCOD_SCH_EGZ_COR = new Long(strCOD_SCH_EGZ_COR).longValue();
            IErogazioneCorsiHome home = (IErogazioneCorsiHome) PseudoContext.lookup("ErogazioneCorsiBean");
            ErogazioneCorsi = home.findByPrimaryKey(lCOD_SCH_EGZ_COR);
            long lCOD_COR = ErogazioneCorsi.getCOD_COR();
            long lCOD_AZL = ErogazioneCorsi.getCOD_AZL();
            out.print(strCOD_DPD);
            if (ErogazioneCorsi != null) {
                try {
                    java.sql.Date dtDAT_EFT_COR = ErogazioneCorsi.getDAT_PIF_EGZ_COR();
                    ErogazioneCorsi.removeCOR_DPD(lCOD_COR, lCOD_DPD, lCOD_AZL, dtDAT_EFT_COR);

                    ErogazioneCorsi.removeISC_COR_DPD(llCOD_SCH_EGZ_COR, lCOD_DPD, lCOD_AZL);
                } catch (Exception ex) {
                    ex.printStackTrace();
                    out.print("<script>err=true;</script>");
                }
            } else {
                out.print("Nifiga ne udalios");
            }
        } else {
            String COD_SCH_EGZ_COR_DEL = request.getParameter("ID");
            IErogazioneCorsiHome home = (IErogazioneCorsiHome) PseudoContext.lookup("ErogazioneCorsiBean");
            Long lCOD_SCH_EGZ_COR = new Long(COD_SCH_EGZ_COR_DEL);
            try {
                home.remove(lCOD_SCH_EGZ_COR);
            } catch (Exception ex) {
                manageException(request, out, ex);
            }
        }
    }
%>
<script>
    if (<%=request.getParameter("ID_PARENT")%> != null) {
        if (!err) {
            Alert.Success.showDeleted();
            parent.del_localRow();
        } else {
            Alert.Error.showDelete();
        }
    }
    else {
        if (!err)
        {
            Alert.Success.showDeleted();
            //parent.g_Handler.OnRefresh();
            parent.ToolBar.OnDelete();
        }
        else {
            Alert.Error.showDelete();
        }
    }
</script>
