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
     <version number="1.0" date="25/01/2004" author="Treskina Maria">
     <comments>
     <comment date="25/01/2004" author="Treskina Maria">
     <description>ydalenie dannih iz</description>
     </comment>	
     <comment date="28/01/2004" author="Treskina Maria">
     <description>ydaleni iz tab Lotti DPI per Form_TPL_DPI</description>
     </comment>	
     <comment date="17/01/2004" author="Treskina Maria">
     <description>novoe ydalenie Lotti DPI i SchedeInterventoDPI</description>
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
<%@ page import="com.apconsulting.luna.ejb.LottiDPI.*" %>
<%@ page import="com.apconsulting.luna.ejb.SchedeInterventoDPI.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script>
    var err = false;
    var errDescr;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
    Checker c = new Checker();

    long ID;
    long lCOD_SCH_INR_DPI = 0;

    String LOCAL_MODE = request.getParameter("LOCAL_MODE");
    out.print("LOCAL_MODE=" + LOCAL_MODE + "<br>");
    if (LOCAL_MODE != null) {
        ID = c.checkLong("Rischio", request.getParameter("ID_PARENT"), true);

        if (LOCAL_MODE.equals("si")) {
            lCOD_SCH_INR_DPI = c.checkLong("Corso", request.getParameter("ID"), true);
        }
    } else {
        ID = c.checkLong("Lotti DPI", request.getParameter("ID"), true);
    }

    if (c.isError) {
        out.println("<script>err=true;alert(\"" + c.printErrors() + "\");</script>");
        return;
    }

    ILottiDPIHome home = (ILottiDPIHome) PseudoContext.lookup("LottiDPIBean");
    ISchedeInterventoDPIHome homeSI = (ISchedeInterventoDPIHome) PseudoContext.lookup("SchedeInterventoDPIBean");
    try {
        if (LOCAL_MODE != null) {

            if (lCOD_SCH_INR_DPI != 0) {
                out.print("lCOD_SCH_INR_DPI=" + lCOD_SCH_INR_DPI);
                homeSI.remove(new Long(lCOD_SCH_INR_DPI));
            } else {
                throw new Exception("Invalid operation");
            }
        } else {
            home.remove(new Long(ID));
        }
    } catch (Exception ex) {
            manageException(request, out, ex);
%>
<div id="divErr">
    <%=ex.getMessage()%>
</div>
<script>err = true;</script>
<%
    }

%>
<script>
    /*
     <comment date="30/01/2004" author="Treskina Maria">
     <description>Dobavlen kod dlya tabika s formy ANA_LOT_DPI_Form.jsp</description>
     */
    /*if(window.name == "ifrmWork")
     { // Udalenie iz tabika
     if (!err)
     parent.del_localRow();
     else
     alert(arraylng["MSG_0051"] + errDescr);	
     }
     else
     { */// Obychnoe udalenie
    /*	if (err) 
     Alert.Error.showDelete();	
     else{		  
     Alert.Success.showDeleted();	  
     parent.ToolBar.OnDelete(); 
     }*/
    //}


//				</comment>		
    if (err)
        Alert.Error.showDelete();//alert(divErr.innerText);

    <%if (LOCAL_MODE == null) {%>
    else{
        Alert.Success.showDeleted();
        parent.g_Handler.OnRefresh();
    }
    <%} else {%>

    if (!err) {
        parent.del_localRow();
        Alert.Success.showDeleted();
    }

    <%}%>
</script>
