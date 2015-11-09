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
        <version number="1.0" date="19/02/2004" author="Alex Kyba">
        <comments>
        <comment date="19/02/2004" author="AlexKyba">
        <description>function, stroyaschaya strukturu unita organizzativa</description>
        </comment>
        </comments>
        </version>
        </versions>
        </file>
         */
%>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/TipologieUnitaOrganizzativa/TipologieUnitaOrganizzativaBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/TipologieUnitaOrganizzativa/TipologieUnitaOrganizzativaBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%
        String strCOD_MIS_PET_AZL = "";
        long lCOD_AZL = Security.getAzienda();
//-------------------------------------------------

        String strRAG_SCL_AZL = new String();
        //------------------
        long lCOD_UNI_ORG = 0;
        String strNOM_UNI_ORG = "";
        String strDES_UNI_ORG = "";
        String strEMAIL = "";
        long lCOD_TPL_UNI_ORG = 0;
        long lCOD_UNI_ORG_ASC = 0;
        long lCOD_DPD = 0;
        String strNOM_DPD = "";
        String strMTR_DPD = "";
        String strCOG_DPD = "";
        //---------------------------

        java.util.Collection col;
        java.util.Iterator it;

        if (request.getParameter("ID_ASC") != null) {
            lCOD_UNI_ORG_ASC = (new Long(request.getParameter("ID_ASC"))).longValue();
        }
        out.println(lCOD_UNI_ORG_ASC);
//------------------------------------------------------------------
//----------------Interfaces & Beans--------------------------------
//------------------------------------------------------------------

//------ Unita Organizzativa-------------
        IUnitaOrganizzativa bean = null;
        IUnitaOrganizzativaHome home = (IUnitaOrganizzativaHome) PseudoContext.lookup("UnitaOrganizzativaBean");
//------ Tipologia Unita -----------------
        ITipologieUnitaOrganizzativaHome tplHome = (ITipologieUnitaOrganizzativaHome) PseudoContext.lookup("TipologieUnitaOrganizzativaBean");
        if (request.getParameter("ID") != null) {
            // getting parameters of azienda
            try {
                Long ID = new Long(request.getParameter("ID"));
                bean = home.findByPrimaryKey(ID);
                lCOD_UNI_ORG = bean.getCOD_UNI_ORG();
                strNOM_UNI_ORG = bean.getNOM_UNI_ORG();
                strDES_UNI_ORG = bean.getDES_UNI_ORG();
                strEMAIL = bean.getEMAIL();
                lCOD_TPL_UNI_ORG = bean.getCOD_TPL_UNI_ORG();
                lCOD_UNI_ORG_ASC = bean.getCOD_UNI_ORG_ASC();
                lCOD_DPD = bean.getCOD_DPD();
            } catch (Exception ex) {
                out.print("<strong>" + ex.getMessage() + "</strong>");
                return;
            }
        }
%>
<div id="divContent">
    <fieldset>
        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.unità.organizzativa")%></legend>
        <br>
        <table width="100%" border="0" cellpadding="2">
            <tr>
                <td align="right" nowrap width="15%">
                    <strong><%=ApplicationConfigurator.LanguageManager.getString("Nome.unità")%>&nbsp;</strong>
                </td>
                <td width="85%">
                    <input name="SBM_MODE" type="Hidden" value="<%if (lCOD_UNI_ORG != 0) {
            out.print("edt");
        } else {
            out.print("new");
        }%>">
                    <input type="hidden" size="20" maxlength="20"  name="COD_UNI_ORG" value="<%=Formatter.format(lCOD_UNI_ORG)%>">
                    <input type="text" size="90"  maxlength="110"  name="NOM_UNI_ORG" value="<%=Formatter.format(strNOM_UNI_ORG)%>">
                </td>
            </tr>
            <tr>
                <td align="right" nowrap width="15%"><strong><%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%>&nbsp;</strong></td>
                <td width="85%">

                    <select name="COD_TPL_UNI_ORG" style="width:100%">
                        <option value=""></option>
                        <%
        col = tplHome.getTipologiaUnitaView();
        String tplString = BuildTipologiaUnitaComboBox(col, lCOD_TPL_UNI_ORG);
        out.println(tplString);
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="right" nowrap width="15%"><%=ApplicationConfigurator.LanguageManager.getString("D.V.R.")%>&nbsp;</td>
                <td width="85%">
                    <input type="checkbox" name="DVR" value="S"   <%if (bean != null && "S".equals(bean.getDVR())) {
            out.print("checked");
        }%>>
                </td>
            </tr>
            <tr>
                <td align="right" valign="top" width="15%">
                    <%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;
                </td>
                <td width="85%">
                    <s2s:textarea tabindex="4" name="DES_UNI_ORG" maxlength="3500" rows="4" cols="100" style="height:70px"><%=Formatter.format(strDES_UNI_ORG)%></s2s:textarea>
                </td>
            </tr>
            <tr>
                <td width="15%" align="right" nowrap>
                    <%=ApplicationConfigurator.LanguageManager.getString("E-mail")%>&nbsp;
                </td>
                <td width="85%" >
                    <input type="text" name="EMAIL" style="width:50%" tabindex="5" value="<%=Formatter.format(strEMAIL)%>">

                </td>
            </tr>
            <tr>
                <td colspan="100%" id="RESP">
                    <jsp:include page="ANA_UNI_ORG_Responsabile.jsp">
                        <jsp:param name="RESP_ID" value="<%=lCOD_DPD%>"></jsp:param>
                    </jsp:include>

                </td>
            </tr>
            <tr>
                <td colspan="100%">
                    <fieldset style="width:100%">
                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Unita.organizzativa.associata")%></legend>
                        <table width="100%" cellpadding="2" cellspacing="2">
                            <tr>
                                <td width="14%" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Nome")%></td>
                                <td width="86%">
                                    <select name="COD_UNI_ORG_ASC" style="width:100%">
                                        <option value="0"></option>
                                        <%
                                           String nodes = home.buildTreeNodes(bean, home, 0, lCOD_UNI_ORG_ASC,lCOD_AZL,false);
                                           out.println(nodes);
                                        %>
                                    </select>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
        </table>
    </fieldset>

</div>
<script>
    if (parent){
        try{
            parent.setUNI_ORG(document.all["divContent"]);
            if (parent.editor){
                parent.editor.init();
            }
                <%if (bean != null) {%>
                            parent.tabbar.idParentRecord = <%=lCOD_UNI_ORG%>;
                            parent.tabbar.RefreshAllTabs();
                <% }%>
                        }
                    catch(e){
                        alert(e);
                    }
            }
</script>

<%!    boolean isError = false;
    String strError = "";

    String BuildTipologiaUnitaComboBox(java.util.Collection col, long lCOD_TPL_UNI_ORG) {
        String str = "";
        String selected = "";
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            TipologiaUnitaView view = (TipologiaUnitaView) it.next();
            if (lCOD_TPL_UNI_ORG == view.lCOD_TPL_UNI_ORG) {
                selected = "selected";
            } else {
                selected = "";
            }
            str += "<option value='" + view.lCOD_TPL_UNI_ORG + "' " + selected + " >" + view.strNOM_TPL_UNI_ORG + "</option>";
        }
        return str;
    }

   
%>
