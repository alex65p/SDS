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

<%@page import="s2s.luna.conf.ApplicationConfigurator"%>
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.DipendenteCorsi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server

    String operation = request.getParameter("operation");
    if (operation.equals("changeUO")) {
//-----start check section--------------------------------
        IAttivitaLavorativeHome l_home = (IAttivitaLavorativeHome) PseudoContext.lookup("AttivitaLavorativeBean");
        String lORG = request.getParameter("ID");
        long lCOD_AZL = Security.getAzienda();
        String sNOM_MAN;
        String str = "<select name='ATTIVITA' id='ATTIVITA' style='width:600px'><option value='0'></option>";
        long COD_SEL = new Long(request.getParameter("ID_SEL")).longValue();
        java.util.Collection col_nr = l_home.getAttivitaLavorative_AZL_Name_View(lCOD_AZL, new Long(lORG).longValue());
        java.util.Iterator it_nr = col_nr.iterator();
        while (it_nr.hasNext()) {
            AttivitaLavorative_AZL_Name_View nr = (AttivitaLavorative_AZL_Name_View) it_nr.next();
            sNOM_MAN = nr.NOM_MAN;
            out.println(sNOM_MAN);
            if (nr.COD_MAN == COD_SEL) {
            } else {
                str += "<option value='" + sNOM_MAN + "'>" + sNOM_MAN + "</option>";
            }
        }
        str += "</select>";
%>
<div id="srcDiv"><%out.print(str);%></div>
<script type="text/javascript">
    parent.document.all['selDiv'].innerHTML=document.all['srcDiv'].innerHTML;
</script>        
<%
} else if (operation.equals("checkCorso")) {
    Checker c = new Checker();
    long COD_DPD = c.checkLongEx(ApplicationConfigurator.LanguageManager.getString("Dipendente"),request.getParameter("ID_PARENT"),false);
    long COD_COR = c.checkLongEx(ApplicationConfigurator.LanguageManager.getString("Corso"),request.getParameter("ID"),false);
    java.sql.Date DAT_COR = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.corso"),request.getParameter("DAT_COR"),false);
    
    IDipendenteCorsiHome homeCorsi = (IDipendenteCorsiHome) PseudoContext.lookup("DipendenteCorsiBean");
                    Collection<DipendentiCorsi> col =
                            homeCorsi.getDipendentiCorsi(COD_COR, Security.getAzienda(), COD_DPD, DAT_COR);
    if (col != null && !col.isEmpty()){
        %>
        <script>
            result=window.showModalDialog(
                '../Form_COR_DPD/COR_DPD_Form.jsp' +
                    '?ID_PARENT=<%=COD_DPD%>' + 
                    '&ID=<%=COD_COR%>' + 
                    '&dat_eft_cor=<%=DAT_COR%>'
                        ,'','dialogHeight:400px;dialogwidth:900px;scroll:yes;status:no;help:no');
        </script>
        <%
    } else {
        out.println("<script>alert(arraylng[\"MSG_0206\"]);</script>");
    }
}
%>
