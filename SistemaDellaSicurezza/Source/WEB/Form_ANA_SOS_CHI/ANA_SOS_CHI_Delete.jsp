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
     <version number="1.0" date="14/12/2004" author="Artur Denysenko">
     <comments>
     <comment date="14/12/2004" author="Artur Denysenko">
     <description>ANA_SOS_CHI_Delete.jsp</description>
     </comment>
     <comment date="13/04/2004" author="Roman Chumachenko">
     <description>Deleting of Risc from Agente Chimico</description>
     </comment>
     </comments> 
     </version>
     </versions>
     </file> 
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.AssociativaAgentoChimico.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/ExtendedMode.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script>
    var err = false;
    var errDescr;
</script>

<%
    long lCOD_AZL = Security.getAzienda();
    long ID = 0;
    long ID_PARENT = 0;
    java.util.ArrayList AZIENDA_ID_LIST = null;
    Checker c = new Checker();

    IAssociativaAgentoChimicoHome home = (IAssociativaAgentoChimicoHome) PseudoContext.lookup("AssociativaAgentoChimicoBean");
    IAttivitaLavorativeHome home_att = (IAttivitaLavorativeHome) PseudoContext.lookup("AttivitaLavorativeBean");

    String LOCAL_MODE = request.getParameter("LOCAL_MODE");
    if (LOCAL_MODE != null) {
        ID_PARENT = c.checkLong("Agenti Chimici", request.getParameter("ID_PARENT"), true);
        if (LOCAL_MODE.equals("RSO")) {
            ID = c.checkLong("Rischio", request.getParameter("ID"), true);
        }
        if (LOCAL_MODE.equals("LUO_FSC")) {
            ID = c.checkLong("Luoghi Fisici", request.getParameter("ID"), true);
        }
        if (LOCAL_MODE.equals("FRS_R")) {
            ID = c.checkLong("Frasi 'R'", request.getParameter("ID"), true);
        }
        if (LOCAL_MODE.equals("FRS_S")) {
            ID = c.checkLong("Frasi 'S'", request.getParameter("ID"), true);
        }
        if (LOCAL_MODE.equals("DOC")) {
            ID = c.checkLong("Documento", request.getParameter("ID"), true);
        }
        if (LOCAL_MODE.equals("NOR_SEN")) {
            ID = c.checkLong("Norm./Sent.", request.getParameter("ID"), true);
        }
    } else {
        ID = c.checkLong("Agenti Chimici", request.getParameter("ID"), true);
    }

    if (Security.isExtendedMode()) {
        AZIENDA_ID_LIST = ExtendedMode.getAziende(c); //EXTENDED
    }

    if (c.isError) {
        String err = c.printErrors();
%><script>alert("<%=err%>");</script><%
        return;
    }
    out.print(ID + " ");
    out.print(ID_PARENT);

    try {
        if (LOCAL_MODE != null) {
            IAssociativaAgentoChimico bean = home.findByPrimaryKey(new Long(ID_PARENT));
            if (LOCAL_MODE.equals("RSO")) {
                //bean.removeCOD_RSO(ID);
                out.println("<br>lCOD_RSO ():" + ID + "<br>");
                out.println("lCOD_AZL (lCOD_AZL):" + lCOD_AZL + "<br>");
                out.println("lCOD_SOS_CHI (ID_PARENT):" + ID_PARENT + "<br>");
                out.println("-----------------------------------------<br>");
                //---------------------------------------------------
                String res = home_att.EXdeleteAssociationOfRiscFromAgente(
                        ID, lCOD_AZL, ID_PARENT, AZIENDA_ID_LIST);
                out.print("RESULT:" + res);
                if (res.indexOf("...FAILED") != -1) {
                    throw new Exception();
                }
            }
            if (LOCAL_MODE.equals("LUO_FSC")) {
                bean.removeSOS_CHI_LUO_FSC(ID);
            }
            if (LOCAL_MODE.equals("FRS_R")) {
                bean.removeCOD_FRS_R(ID);
            }
            if (LOCAL_MODE.equals("FRS_S")) {
                bean.removeCOD_FRS_S(ID);
            }
            if (LOCAL_MODE.equals("DOC")) {
                bean.removeCOD_DOC(ID);
            }
            if (LOCAL_MODE.equals("NOR_SEN")) {
                bean.removeCOD_NOR_SEN(ID);
            }
        } else {
            home.remove(new Long(ID));
        }
    } catch (Exception ex) {
        manageException(request, out, ex);
%>
<div id="divErr"><%=ex.getMessage()%></div>
<script>err = true;</script>
<%}%>

<script>
    if (err)
        Alert.Error.showDelete();
    <%if (LOCAL_MODE == null) {%>
    parent.g_Handler.OnRefresh();
    Alert.Success.showDeleted();
    <%} else {%>
    parent.del_localRow();
    Alert.Success.showDeleted();
    <%}%>
</script>
