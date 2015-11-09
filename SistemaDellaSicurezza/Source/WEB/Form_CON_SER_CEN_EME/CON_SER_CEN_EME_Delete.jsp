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
    Document   : CON_SER_CEN_EME_Delete
    Created on : 21-mag-2008, 11.45.32
    Author     : Giancarlo Servadei
--%>
<%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache");        //HTTP 1.0
            response.setDateHeader("Expires", 0);          //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServCentriEmergenza.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script type="text/javascript" src="../_scripts/Alert.js"></script>
<script type="text/javascript">
    var err=false;
    </script>

<%
            IContServCentriEmergenza ContServCentriEmergenza = null;
            IAnaContServ AnaContServ = null;
            
            String strCOD_CEN_EME = request.getParameter("ID");
            
            if (strCOD_CEN_EME != null) {
                IContServCentriEmergenzaHome home = (IContServCentriEmergenzaHome) PseudoContext.lookup("ContServCentriEmergenzaBean");
                IAnaContServHome con_ser_home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");
                try {
                    long lCOD_SRV = Long.parseLong(request.getParameter("ID_PARENT"));
                    long lCOD_CEN_EME = Long.parseLong(strCOD_CEN_EME);
                    home.remove(new ContServCentriEmergenzaPK(lCOD_SRV, lCOD_CEN_EME));
                    
                    boolean vuoto = home.getInfoOnDescCentriEmergenza(lCOD_SRV);
                    // il getInfoOnDescCentriEmergenza(lCOD_SRV) è implementato
                    // nel bean relativo ai CentriEmergenza
                    
                    if (vuoto) {
                        con_ser_home.deleteDescCentriEmergenza(lCOD_SRV);
                        // il deleteDescCentriEmergenza(lCOD_SRV) è implementato
                        // nel bean relativo ai Contratti/Servizi
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                    out.print("<script>	Alert.Error.showDelete();err=true;</script>");
                    return;
                }
            }
%>
<script type="text/javascript">	
    if (!err){
        Alert.Success.showDeleted();
        <%
            String strDeleteFrom = request.getParameter("DELETE_FROM");
            if (strDeleteFrom != null && strDeleteFrom.equals("tab")) {
                out.println("parent.del_localRow();");
            } else {
                out.println("parent.ToolBar.OnDelete();");
            }
        %>
        }else{
        Alert.Error.showDelete();
    }	
</script>
