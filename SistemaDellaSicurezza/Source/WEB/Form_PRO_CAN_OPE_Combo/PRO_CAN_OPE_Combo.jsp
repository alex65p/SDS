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

<%@page import="s2s.utils.text.StringManager"%>
<%@ page import="com.apconsulting.luna.ejb.Procedimento.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrOpere.*" %>
<%@ page import="com.apconsulting.luna.ejb.Cantiere.*" %>
<%@ page import="s2s.luna.conf.ApplicationConfigurator"%>

<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="PRO_CAN_OPE_Combo_Util.jsp" %>
<%
    String strCOD_PRO = request.getParameter("PRO");
    String strCOD_CAN = request.getParameter("CAN");
    String strCOD_OPE = request.getParameter("OPE");
    String strCOD_AZL = request.getParameter("AZL");
    String changedElement = request.getParameter("changedElement");
    
    long lCOD_PRO = StringManager.isNotEmpty(strCOD_PRO)?Long.parseLong(strCOD_PRO):0;
    long lCOD_CAN = StringManager.isNotEmpty(strCOD_CAN)?Long.parseLong(strCOD_CAN) :0;
    long lCOD_OPE = StringManager.isNotEmpty(strCOD_OPE)?Long.parseLong(strCOD_OPE) :0;
    long lCOD_AZL = StringManager.isNotEmpty(strCOD_AZL)?Long.parseLong(strCOD_AZL) :0;
%>
<table width="100%" border="0" cellpadding="2" cellspacing="2">
    <tr>
        <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Procedimento")%></b>&nbsp;</td>
        <td>
            <select style="width: 200px;" 
                    id="procedimento_id" name="procedimento" rows="1" tabindex="1" 
                    onchange='preparePRO_CAN_OPE_Combo("PRO");'>
                <option value='' ></option>
                <%
                    IProcedimentoHome pro_home = (IProcedimentoHome) PseudoContext.lookup("ProcedimentoBean");
                    out.print(BuildProcedimentoComboBox(pro_home, lCOD_PRO, lCOD_AZL));
                %>
            </select>
        </td>
        <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Cantiere")%></b>&nbsp;</td>
        <td>
            <select style="width: 200px;" 
                    id="cantiere_id" name="cantiere" rows="1" tabindex="2" 
                    onchange='preparePRO_CAN_OPE_Combo("CAN");'>
                <option value=''></option>
                <%
                    ICantiereHome can_home = (ICantiereHome) PseudoContext.lookup("CantiereBean");
                    out.print(BuildCantiereComboBox(can_home, lCOD_PRO, (changedElement.equals("PRO")?0:lCOD_CAN), lCOD_AZL));
                %>
            </select>
        </td>
        <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Opera")%>&nbsp;</td>
        <td>
            <select style="width: 200px;" 
                    id="opera_id" name="opera" rows="1" tabindex="3">
                <option value=''></option>
                <%
                    IAnagrOpereHome ope_home = (IAnagrOpereHome) PseudoContext.lookup("AnagrOpereBean");
                    if (changedElement.equals("PRO")){
                        out.print(BuildOperaComboBox(ope_home, 0, 0, lCOD_AZL));
                    } else {
                        out.print(BuildOperaComboBox
                                (ope_home, lCOD_CAN, (changedElement.equals("CAN")?0:lCOD_OPE), lCOD_AZL));    
                    } 
                %>
            </select>
        </td>
    </tr>
</table> 
