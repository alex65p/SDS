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
            <version number="1.0" date="26/02/2004" author="Alex Kyba">
            <comments>
            <comment date="26/02/2004" author="AlexKyba">
            <description>refresh responsabile dlia formy DPD_UNI_SIC</description>
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */
%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%
    long lCOD_DPD = 0;
    String strNOM_DPD = "";
    String strMTR_DPD = "";
    String strCOG_DPD = "";

    IDipendenteHome home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
    IDipendente bean = null;

    if (request.getParameter("ID") != null) {
        // getting parameters of azienda
        try {
            Long ID = new Long(request.getParameter("ID"));
            bean = home.findByPrimaryKey(ID);
            lCOD_DPD = bean.getCOD_DPD();
            strNOM_DPD = bean.getNOM_DPD();
            strMTR_DPD = bean.getMTR_DPD();
            strCOG_DPD = bean.getCOG_DPD();
        } catch (Exception ex) {
            out.print("<strong>" + ex.getMessage() + "</strong>");
            return;
        }
    }
%>
<div id="divContent">
    <br>
    <fieldset>
        <legend>
            <%=ApplicationConfigurator.isModuleEnabled(MODULES.UNI_SIC_4_DIP)==true?
                ApplicationConfigurator.LanguageManager.getString("Lavoratore"):
                ApplicationConfigurator.LanguageManager.getString("Responsabile")%>
        </legend>
        <table width="100%" cellpadding="0" cellspacing="2" border="0">
            <tr>
                
                <td rowspan="100%">&nbsp;&nbsp;</td>
                <td align="right" ><strong><%=ApplicationConfigurator.LanguageManager.getString("Matricola")%>&nbsp;</strong></td>
                <td width="100%">
                    <input type="text" size="15" maxlength="20" readonly  name="MTR_DPD" value="<%= Formatter.format(strMTR_DPD)%>">
                </td>
                <td rowspan="100%">&nbsp;&nbsp;</td>
            </tr>
            <tr>
                <td align="right"><strong><%=ApplicationConfigurator.LanguageManager.getString("Cognome")%>&nbsp;</strong></td>
                <td  nowrap>
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="100%"><input type="text" readonly style="width:100%" maxlength="20"  name="COG_DPD" value="<%= Formatter.format(strCOG_DPD)%>"></td>
                            <td><button class="getlist" onclick="getDipenedentiList()" id="btnGetDipendenti">
                                    <strong>&middot;&middot;&middot;</strong>
                                </button>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="right"><strong><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</strong></td>
                <td>
                    <table width="100%" cellpadding="0" border="0" cellspacing="0">
                        <tr>
                            <td width="100%">
                                <input type="hidden" size="20" maxlength="20"  name="COD_DPD" value="<%=Formatter.format(lCOD_DPD)%>">
                                <input type="text" readonly style="width:100%" maxlength="20"  name="NOM_DPD" value="<%= Formatter.format(strNOM_DPD)%>">
                            </td>
                            <td><button class="getlist" style="visibility:hidden" >
                                    <strong>&middot;&middot;&middot;</strong>
                                </button>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </fieldset>
</div>
<script type="text/javascript">
    parent.RESP.innerHTML=document.all["divContent"].innerHTML;
</script>


