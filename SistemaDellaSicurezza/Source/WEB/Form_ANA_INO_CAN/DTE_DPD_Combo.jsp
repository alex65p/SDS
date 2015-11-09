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

<%@ page import="com.apconsulting.luna.ejb.DittaEsterna.*" %>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="s2s.luna.conf.ApplicationConfigurator"%>
<%@ page import="com.apconsulting.luna.ejb.ErogazioneCorsi.ErogazioneCorsi_DTEGet_View"%>
<%@ page import="s2s.utils.text.StringManager"%>
<%@ page import="com.apconsulting.luna.ejb.ErogazioneCorsi.*" %>
<%@ page import="s2s.luna.conf.ApplicationConfigurator"%>
<%@ include file="../_include/ComboBox-Dipendente.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<script type="text/javascript" src="../Form_ANA_INO/ANA_INO.js"></script>
<script language="JavaScript" src="DTE_DPD_Combo.js"></script>
<%
    String strCOD_DTE = request.getParameter("DTE");
    String strCOD_DPD = request.getParameter("DPD");
    String strCOD_AZL = request.getParameter("AZL");

    long lCOD_DTE = StringManager.isNotEmpty(strCOD_DTE) ? Long.parseLong(strCOD_DTE) : 0;
    long lCOD_DPD = StringManager.isNotEmpty(strCOD_DPD) ? Long.parseLong(strCOD_DPD) : 0;
    long lCOD_AZL = StringManager.isNotEmpty(strCOD_AZL) ? Long.parseLong(strCOD_AZL) : 0;
    IErogazioneCorsiHome home1 = (IErogazioneCorsiHome) PseudoContext.lookup("ErogazioneCorsiBean");
    IDipendenteHome dhome = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
%>
<table width="100%" border="0" cellpadding="2" cellspacing="2">
    <tr>
        <td>
            <select tabindex="1" name="COD_DTE" id="COD_DTE" style="width:100%"
                    onchange='prepareDTE_DPD_Combo("DTE");'>
                <option></option>
                <%
                    String str = "";
                    String strSEL = "";
                    java.util.Collection col = home1.getErogazioneCorsi_DTEGet_View();
                    java.util.Iterator it = col.iterator();
                    while (it.hasNext()) {
                        ErogazioneCorsi_DTEGet_View dt = (ErogazioneCorsi_DTEGet_View) it.next();
                        long var1 = dt.COD_DTE;
                        if (lCOD_DTE == var1) {
                            strSEL = "selected";
                        } else {
                            strSEL = "";
                        }
                        str = str + "<option " + strSEL + " value=\"" + var1 + "\">" + dt.RAG_SCL_DTE + "</option>";
                    }
                    out.print(str);
                %>
            </select>
        </td>
        <td align="right" width="10%"><b><%=ApplicationConfigurator.LanguageManager.getString("Lavoratore")%>&nbsp;</b></td>
        <td align="left">
            <select tabindex="2" onchange="checkRiaperturaInfortuni('checkRiaperturaInfortuniCantiere.jsp?COD_DPD='+this.value+'&DAT_EVE_INO='+document.getElementById('DAT_EVE_INO').value+'&COD_INO='+document.getElementById('COD_INO').value+'&COD_INO_REL='+document.getElementById('ID_COD_REL_INO').value,document.getElementById('IDMessage'));" name="COD_DPD" id="COD_DPD" style="width:100%;">
                <option value=""></option>=
                <%=BuildDipendenteComboBox1(dhome, lCOD_DPD, lCOD_AZL, lCOD_DTE)%>
            </select>
        </td>
    </tr>
</table>
