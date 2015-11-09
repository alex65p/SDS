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
     <comment date="04/02/2004" author="Roman Chumachenko">
     <description>Shablon formi ANA_MIS_PET_Delete.jsp</description>
     </comment>
     </comments>
     </version>
     </versions>
     </file>
     */
%>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>
<%@ page import="com.apconsulting.luna.ejb.ValutazioneRischi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
    var err = false;
    var errDescr;
</script>
<%    Checker c = new Checker();

    IUnitaOrganizzativa bean = null;
    long ID = 0;
    long lCOD_LUO_FSC = 0;
    long lCOD_MAN = 0;

    String LOCAL_MODE = request.getParameter("LOCAL_MODE");
    if (LOCAL_MODE != null) {
        ID = c.checkLong("Unita organizzativa", request.getParameter("ID_PARENT"), true);
        if (LOCAL_MODE.equals("luo")) {
            lCOD_LUO_FSC = c.checkLong("Luogo fisico", request.getParameter("ID"), true);
        }
        if (LOCAL_MODE.equals("att")) {
            lCOD_MAN = c.checkLong("Attivita lavorativa", request.getParameter("ID"), true);
        }
    } else {
        ID = c.checkLong("Unita organizzativa", request.getParameter("ID"), true);
    }

    if (c.isError) {
        out.println("<script>err=true;alert(\"" + c.printErrors() + "\");</script>");
        return;
    }
    IUnitaOrganizzativaHome home = (IUnitaOrganizzativaHome) PseudoContext.lookup("UnitaOrganizzativaBean");
    try {
        if (LOCAL_MODE != null) {
            bean = home.findByPrimaryKey(new Long(ID));
            if (LOCAL_MODE.equals("luo")) {
                bean.deleteLuogoFisico(lCOD_LUO_FSC);
                out.print("local luogo fisico deleted");
            }
            if (LOCAL_MODE.equals("att")) {
                bean.deleteAttivitaLavorativa(lCOD_MAN);
                out.println("local attivita lavorativa deleted");
            }
        } else {
            // Controllo che l'unità organizzativa che si vuole eliminare non sia
            // associata ad uno o più D.V.R.
            IValutazioneRischiHome doc_vlu_home = (IValutazioneRischiHome) PseudoContext.lookup("ValutazioneRischiBean");
            Collection col = doc_vlu_home.findEx(Security.getAzienda(), null, null, null, ID, 0);

            // Se trovo questo tipo di associazione avviso l'utente e impedisco la cancellazione.
            if (!col.isEmpty()) {
                out.println("<script>alert(arraylng[\"MSG_0188\"]);</script>");
                return;
            }
            home.remove(new Long(ID));
            out.println("bean deleted");
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
    if (err) {
        if (divErr)
            Alert.Error.showDelete();
        //alert(divErr.innerText);
    }
    else {
        Alert.Success.showDeleted()
    <% 		if (LOCAL_MODE != null) {%>
        parent.del_localRow();

    <% } else {%>
        parent.getNodes();
        parent.ifrmWork.src = "ANA_UNI_ORG_Node.jsp";
        //parent.g_Handler.OnRefresh();
    <% }%>
    }
</script>
