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
    <version number="1.0" date="20/02/2004" author="Podmasteriev Alexandr">
    <comments>
    <comment date="20/02/2004" author="Podmasteriev Alexandr">
    <description>Shablon formi Delete.jsp</description>
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

<%@ page import="com.apconsulting.luna.ejb.AttivitaSegnalazione.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
    var err=false;
</script>

<%
    IAttivitaSegnalazione AttivitaSegnalazione = null;

    String ID = request.getParameter("ID");
    String ID_PARENT = request.getParameter("ID_PARENT");
    String LOCAL_MODE = request.getParameter("LOCAL_MODE");
    
    long ID_TO_DEL=0;
    Checker c = new Checker();

    if (ID != null) {
        IAttivitaSegnalazioneHome home = (IAttivitaSegnalazioneHome) PseudoContext.lookup("AttivitaSegnalazioneBean");
        if (LOCAL_MODE != null) {
            if ("B".equals(LOCAL_MODE)) {
                ID_TO_DEL = c.checkLong("Documento", ID, true);
                AttivitaSegnalazione = home.findByPrimaryKey(Long.valueOf(ID_PARENT));
                AttivitaSegnalazione.removeCOD_DOC(ID_TO_DEL);
            } else
            if ("MISURA".equals(LOCAL_MODE)) {
                ID_TO_DEL = c.checkLong("Misura", ID, true);
                AttivitaSegnalazione = home.findByPrimaryKey(Long.valueOf(ID_PARENT));
                AttivitaSegnalazione.removeMisura(ID_TO_DEL);
            } else
            if ("A".equals(LOCAL_MODE)) {
                try {
                    home.remove(Long.valueOf(ID));
                } catch (Exception ex) {
                    out.print("<script>	Alert.Error.showDelete();err=true;</script>");
                    return;
                }
            }
        } else {
            try {
                home.remove(Long.valueOf(ID));
            } catch (Exception ex) {
                out.print("<script>	Alert.Error.showDelete();err=true;</script>");
                return;
            }
        }
    }
%>
<script>
    var LOCAL_MODE="<%=LOCAL_MODE%>";	
    if (!err){
        Alert.Success.showDeleted();
        if (LOCAL_MODE!="null") {
            parent.del_localRow();
        }
        else{
            parent.g_Handler.OnRefresh();	
        }			
    }
    else{
        Alert.Error.showDelete();
    }
</script>
