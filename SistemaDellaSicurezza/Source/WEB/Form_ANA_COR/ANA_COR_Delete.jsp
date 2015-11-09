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
     <version number="1.0" date="21/01/2004" author="Pogrebnoy Yura">
     <comments>
     <comment date="21/01/2004" author="Pogrebnoy Yura">
     <description>Shablon formi ANA_COR_Delete.jsp</description>
     </comment>		
     <comment date="26/02/2004" author="Podmasteriev Alexander">
     <description>Izmenil script v konce dla peragruzki</description>
     </comment>
     </comments> 
     </version>
     </versions>
     </file> 
     */
%>
<%@ page import="com.apconsulting.luna.ejb.Corsi.*" %>
<%@ page import="com.apconsulting.luna.ejb.PercorsiFormativi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script>
    var err = false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%    ICorsi bean = null;
    ICorsiHome home = (ICorsiHome) PseudoContext.lookup("CorsiBean");

    IPercorsiFormativi PercorsiFormativi = null;
    String IDD = request.getParameter("LOCAL_MODE");

    if (request.getParameter("ID") != null) {
        if ("COR".equals(IDD)) {
            try {
                String COD_COR_DEL = request.getParameter("ID");
                long lCOD_COR_DEL = Long.parseLong(COD_COR_DEL);
                Long lCOD_PCS_FRM_DEL = new Long(request.getParameter("ID_PARENT"));

                IPercorsiFormativiHome vhome = (IPercorsiFormativiHome) PseudoContext.lookup("PercorsiFormativiBean");
                PercorsiFormativi = vhome.findByPrimaryKey(lCOD_PCS_FRM_DEL);

                PercorsiFormativi.removeCOD_COR(lCOD_COR_DEL);
            } catch (Exception ex) {
                out.print("<script>err=true; Alert.Error.showDelete();</script>");
                return;
            }
        } else if ("TES_VRF".equals(IDD)) {
            try {
                long lCOD_TES_VRF = Long.parseLong(request.getParameter("ID"));
                Long lCOD_COR = new Long(request.getParameter("ID_PARENT"));

                bean = home.findByPrimaryKey(lCOD_COR);
                bean.removeCOD_TES_VRF(lCOD_TES_VRF);
            } catch (Exception ex) {
                out.print("<script>err=true; Alert.Error.showDelete();</script>");
                return;
            }
        } else if ("DOC".equals(IDD)) {
            try {
                long lCOD_DOC = Long.parseLong(request.getParameter("ID"));
                Long lCOD_COR = new Long(request.getParameter("ID_PARENT"));

                bean = home.findByPrimaryKey(lCOD_COR);
                bean.removeCOD_DOC(lCOD_DOC);
            } catch (Exception ex) {
                out.print("<script>err=true; Alert.Error.showDelete();</script>");
                return;
            }
        } else {
            String strCOD_COR = request.getParameter("ID");
            Long lCOD_COR = new Long(strCOD_COR);
            try {
                home.remove(lCOD_COR);
            } catch (Exception ex) {
                manageException(request, out, ex);
            }
        }
    }
%>

<script>
    var IDD = "<%=IDD%>";
    if (!err) {
        Alert.Success.showDeleted();
        if (IDD != "null") {
            parent.del_localRow();
        }
        else {
            parent.g_Handler.OnRefresh();
        }
    }
    else {
        Alert.Error.showDelete();
    }
</script>
<script>
///commented by podmaster 
    /*	if (window.name == "ifrmWork"){
     if (!err) {	
     parent.del_localRow();
     } else {
     alert(arraylng["MSG_0057"] + " " + (String.fromCharCode("0232")) + " " + arraylng["MSG_0058"] + errDescr);
     } 
     }	
     else{
     if (!err) {
     parent.g_Handler.OnRefresh();
     alert(arraylng["MSG_0050"]);
     } else {
     alert(arraylng["MSG_0057"] + " " + (String.fromCharCode("0232")) + " " + arraylng["MSG_0058"] + errDescr);
     }	
     }*/
</script>
