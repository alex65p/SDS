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
     <version number="1.0" date="04/02/2004" author="Alex Kyba">
     <comments>
     <comment date="04/02/2004" author="Alex Kyba">
     <description>ANA_MAC_Delete.jsp</description>
     </comment>
     <comment date="13/04/2004" author="Roman Chumachenko">
     <description>Deleting of Ri</description>
     </comment>
     </comments>
     </version>
     </versions>
     </file> 
     */
%>
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/ExtendedMode.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script>
    var err = false;
    var errDescr;
</script>
<%    Checker c = new Checker();
    long lCOD_AZL = Security.getAzienda();
    long ID = 0;
    long lCOD_DOC = 0;
    long lCOD_NOR_SEN = 0;
    long lCOD_FOR = 0;
    long lCOD_MNT_MAC = 0;
    long lCOD_RSO = 0;
    IMacchina bean = null;
    java.util.ArrayList AZIENDA_ID_LIST = null;

    String LOCAL_MODE = request.getParameter("LOCAL_MODE");
    if (LOCAL_MODE != null) {
        ID = c.checkLong(
                ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                ? "Macchina.attrezzatura.impianto"
                : "Macchina/Attrezzatura", request.getParameter("ID_PARENT"), true);
        if (LOCAL_MODE.equals("doc")) {
            lCOD_DOC = c.checkLong("Documento", request.getParameter("ID"), true);
        }
        if (LOCAL_MODE.equals("nor")) {
            lCOD_NOR_SEN = c.checkLong("Normativa sentenza", request.getParameter("ID"), true);
        }
        if (LOCAL_MODE.equals("for")) {
            lCOD_FOR = c.checkLong("Fornitore", request.getParameter("ID"), true);
        }
        if (LOCAL_MODE.equals("mnt")) {
            lCOD_MNT_MAC = c.checkLong("Attivita manutenzione", request.getParameter("ID"), true);
        }
        if (LOCAL_MODE.equals("risc")) {
            lCOD_RSO = c.checkLong("Rischio", request.getParameter("ID"), true);
        }
    } else {
        ID = c.checkLong("Misura preventiva", request.getParameter("ID"), true);
    }
//---------------------------------
    if (Security.isExtendedMode()) {
        AZIENDA_ID_LIST = ExtendedMode.getAziende(c); //EXTENDED
    }
//
    if (c.isError) {
        String err = c.printErrors();
%><script>alert("<%=err%>");</script><%
                return;
            }
//---
            IMacchinaHome home = (IMacchinaHome) PseudoContext.lookup("MacchinaBean");
            IAttivitaLavorativeHome home_att = (IAttivitaLavorativeHome) PseudoContext.lookup("AttivitaLavorativeBean");

            try {
                if (LOCAL_MODE != null) {
                    bean = home.findByPrimaryKey(new MacchinaPK(Security.getAzienda(), ID));
                    if (LOCAL_MODE.equals("doc")) {
                        bean.deleteDocument(lCOD_DOC);
                        out.print("local doc deleted");
                    }
                    if (LOCAL_MODE.equals("nor")) {
                        bean.deleteNormativa(lCOD_NOR_SEN);
                        out.println("local normativa deleted");
                    }
                    if (LOCAL_MODE.equals("for")) {
                        bean.deleteFornitore(lCOD_FOR);
                        out.println("local fornitore deleted");
                    }
                    if (LOCAL_MODE.equals("mnt")) {
                        bean.deleteAttManutenzione(lCOD_MNT_MAC);
                        out.println("local attivita manutenzione deleted");
                    }
                    //
                    if (LOCAL_MODE.equals("risc")) {
                        //bean.deleteRischio(lCOD_RSO);	
                        out.println("lCOD_RSO ():" + lCOD_RSO + "<br>");
                        out.println("lCOD_AZL (lCOD_AZL):" + lCOD_AZL + "<br>");
                        out.println("lCOD_MAC (ID):" + ID + "<br>");
                        out.println("-----------------------------------------<br>");
                        //---------------------------------------------------
                        String res = home_att.EXdeleteAssociationOfRiscFromMacchina(
                                lCOD_RSO, lCOD_AZL, ID, AZIENDA_ID_LIST);
                        out.print("RESULT:" + res);
                        if (res.indexOf("...FAILED") != -1) {
                            throw new Exception();
                        }
                        //
                    }
                //
                    //----
                } else {
                    home.remove(new MacchinaPK(Security.getAzienda(), ID), AZIENDA_ID_LIST);
                    out.println("bean deleted");
                }
            } catch (Exception ex) {
                manageException(request, out, ex);
%>
<div id="divErr"><%=ex.getMessage()%></div>
<script>err = true;</script>
<%}%>
<script>
    if (err) {
        if (divErr)
            Alert.Error.showDelete();
    } else {
    <%if (LOCAL_MODE != null) { %>
        parent.del_localRow();
    <% } else { %>
        parent.g_Handler.OnRefresh();
    <%}%>
        Alert.Success.showDeleted()
    }
</script>
