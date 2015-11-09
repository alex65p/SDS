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
    <version number="1.0" date="25/02/2004" author="Alex Kyba">
    <comments>
    <comment date="25/02/2004" author="AlexKyba">
    <description>function, stroyaschaya strukturu unita sicurezza</description>
    </comment>		
    </comments> 
    </version>
    </versions>
    </file> 
     */
%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.UnitaSicurezza.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%
    String strCOD_MIS_PET_AZL = "";
    long lCOD_AZL = Security.getAzienda();
//-------------------------------------------------

    String strRAG_SCL_AZL = new String();
    //------------------
    long lCOD_UNI_SIC = 0;
    String strCOD_UNI_SIC = "";
    String strNOM_UNI_SIC = "";
    String strDES_UNI_SIC = "";
    long lCOD_UNI_SIC_ASC = 0;
    //---------------------------

    java.util.Collection col;
    java.util.Iterator it;

    if (request.getParameter("ID_ASC") != null) {
        lCOD_UNI_SIC_ASC = (new Long(request.getParameter("ID_ASC"))).longValue();
    }

    out.println(lCOD_UNI_SIC_ASC);
//------------------------------------------------------------------
//----------------Interfaces & Beans--------------------------------
//------------------------------------------------------------------

//------ Unita Organizzativa-------------
    IUnitaSicurezza bean = null;
    IUnitaSicurezzaHome home = (IUnitaSicurezzaHome) PseudoContext.lookup("UnitaSicurezzaBean");

    if (request.getParameter("ID") != null) {
        try {
            Long ID = new Long(request.getParameter("ID"));
            bean = home.findByPrimaryKey(ID);
            lCOD_UNI_SIC = bean.getCOD_UNI_SIC();
            lCOD_AZL = bean.getCOD_AZL();
            strNOM_UNI_SIC = Formatter.format(bean.getNOM_UNI_SIC());
            strDES_UNI_SIC = Formatter.format(bean.getDES_UNI_SIC());
            lCOD_UNI_SIC_ASC = bean.getCOD_UNI_SIC_ASC();
        } catch (Exception ex) {
            out.print("<strong>" + ex.getMessage() + "</strong>");
            return;
        }
    }
%>
<div id="divContent">
    <fieldset>
        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.unità.sicurezza")%></legend>
        <table border="0" cellpadding="1" cellspacing="2" width="100%">
            <tr>
                <td nowrap align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome.unità.sic.")%>&nbsp;</b></td>
                <td width="80%">
                    <input name="SBM_MODE" type="Hidden" value="<%=(lCOD_UNI_SIC == 0) ? "new" : "edt"%>">
                    <input name="COD_UNI_SIC" type="hidden" value="<%=lCOD_UNI_SIC%>">
                    <input name="COD_AZL" type="Hidden" value="<%=lCOD_AZL%>">
                    <input type="text" style="width:100%" maxlength="50" name="NOM_UNI_SIC"  value="<%=strNOM_UNI_SIC%>">
                </td>
            </tr>
            <tr>
                <td valign=top align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                <td>
                    <textarea style="width:100%"  name="DES_UNI_SIC"><%=strDES_UNI_SIC%></textarea>
                </td>
            </tr>
        </table>
        <table width="100%" border="0">
        <tr>
            <td>
                <fieldset>
                    <legend>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Unita.sicurezza.associata")%>&nbsp;</legend>
                    <table width="100%" border="0">
                        <tr>
                            <td width="94" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</td>
                            <td>
                                <select name="COD_UNI_SIC_ASC" style="width:100%">
                                    <option value="0"></option>
                                    <%
                                        String nodes = buildTreeNodes(bean, home, 0, lCOD_UNI_SIC_ASC);
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
            parent.setUNI_SIC(document.all["divContent"]);
            if (parent.editor){
                parent.editor.init();
            }
    <%if (bean != null) {%>
            parent.tabbar.idParentRecord = <%=lCOD_UNI_SIC%>;
            parent.tabbar.RefreshAllTabs();
	
    <% }%>
        }
        catch(e){
            alert(e);
        }	
    }
</script>

<%!boolean isError = false;
    String strError = "";

    String buildTreeNodes(IUnitaSicurezza bean, IUnitaSicurezzaHome home, long n, long COD_UNI_SIC) {
        Collection c;
        Iterator i;
        String selected;
        long az = Security.getAzienda();
        String strNodes = "";
        try {
            if (n == 0) {
                c = home.getTopOfTree(az);
                i = c.iterator();
                n++;
                if (i != null) {
                    while (i.hasNext()) {

                        UnitaSicurezzaView view = (UnitaSicurezzaView) i.next();

                        String strNOM_UNI_SIC = view.strNOM_UNI_SIC;
                        long lCOD_UNI_SIC = view.lCOD_UNI_SIC;
                        if (COD_UNI_SIC == lCOD_UNI_SIC) {
                            selected = "selected";
                        } else {
                            selected = "";
                        }
                        strNodes += "<option value=\"" + lCOD_UNI_SIC + "\" " + selected + ">" + strNOM_UNI_SIC + "</option>";
                        bean = home.findByPrimaryKey(new Long(lCOD_UNI_SIC));
                        strNodes += buildTreeNodes(bean, home, n, COD_UNI_SIC);
                        if (isError) {
                            return "";
                        }
                    }
                }
            } else {
                c = bean.getChildren(az);
                i = c.iterator();
                n++;
                if (i != null) {
                    while (i.hasNext()) {
                        UnitaSicurezzaView view = (UnitaSicurezzaView) i.next();
                        String strNOM_UNI_SIC = view.strNOM_UNI_SIC;
                        long lCOD_UNI_SIC = view.lCOD_UNI_SIC;
                        if (COD_UNI_SIC == lCOD_UNI_SIC) {
                            selected = "selected";
                        } else {
                            selected = "";
                        }
                        strNodes += "<option value=\"" + lCOD_UNI_SIC + "\" " + selected + ">";
                        for (long y = 0; y < n; y++) {
                            strNodes += "&nbsp;&nbsp;&nbsp;";
                        }
                        strNodes += strNOM_UNI_SIC + "</option>";
                        bean = home.findByPrimaryKey(new Long(view.lCOD_UNI_SIC));
                        strNodes += buildTreeNodes(bean, home, n, COD_UNI_SIC);
                        if (isError) {
                            return "";
                        }
                    }
                }
            }
        } catch (Exception ex) {
            strError += ex.getMessage();
            return "";
        }
        return strNodes;
    }
%>
