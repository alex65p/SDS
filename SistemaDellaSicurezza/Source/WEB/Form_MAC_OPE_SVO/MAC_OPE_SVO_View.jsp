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
            <version number="1.0" date="09/02/2004" author="Pogrebnoy Yura">
            <comments>
            <comment date="09/02/2004" author="Pogrebnoy Yura">
            <description>Chernovik vieW</description>
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */
%>
<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
    <body>
        <div id="divContent">
            <table class="VIEW_TABLE" border=0>
                <tr class="VIEW_HEADER_TR">
                    <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</td>
                    <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                    <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Modello")%>&nbsp;</td>
                    <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Identificativo")%>&nbsp;</td>
                </tr>
                <%

                            String strDES_MAC = "";
                            String strMDL_MAC = "";
                            String strIDE_MAC = "";
                            String strCOD_TPL_MAC = "";
                            long lCOD_TPL_MAC = 0;

                            String NomeParent = "";
                            String strID_PARENT = "";
                            long lID_PARENT = 0;

                            strCOD_TPL_MAC = Formatter.format(request.getParameter("COD_TPL_MAC"));
                            if (!"".equals(strCOD_TPL_MAC)) {
                                lCOD_TPL_MAC = new Long(strCOD_TPL_MAC).longValue();
                            }
                            strID_PARENT = Formatter.format(request.getParameter("ID_PARENT"));
                            if (!"".equals(strID_PARENT)) {
                                lID_PARENT = new Long(strID_PARENT).longValue();
                            }
                            NomeParent = Formatter.format(request.getParameter("NomeParent"));
                            strDES_MAC = Formatter.format(request.getParameter("DES_MAC"));
                            strMDL_MAC = Formatter.format(request.getParameter("MDL_MAC"));
                            strIDE_MAC = Formatter.format(request.getParameter("IDE_MAC"));

                            IMacchinaHome aHome = (IMacchinaHome) PseudoContext.lookup("MacchinaBean");
                            long lCOD_AZL = Security.getAzienda();
                            java.util.Collection macol = aHome.getMacchineAtt_View(lCOD_AZL, lCOD_TPL_MAC, strDES_MAC, strMDL_MAC, strIDE_MAC, NomeParent, lID_PARENT);
                            java.util.Iterator it = macol.iterator();
                            int iCount = 0;
                            //out.print("<script>alert('"+request.getQueryString()+"');</script>");
                            while (it.hasNext()) {
                                MacchineAttrezzatureAll_View obj = (MacchineAttrezzatureAll_View) it.next();
                %>
                <tr class="VIEW_TR" valign="top" INDEX="<%=Formatter.format(obj.lCOD_MAC)%>"
                    onclick="g_Handler.OnRowClick(this)" ondblclick="g_Handler.OnRowDblClick(this)">
                    <% out.println("<td>&nbsp;" + ++iCount + "&nbsp;</td><td>&nbsp;"
                                            + Formatter.format(obj.strDES_MAC) + "&nbsp;</td><td>&nbsp;"
                                            + Formatter.format(obj.strMDL_MAC) + "&nbsp;</td><td>&nbsp;"
                                            + Formatter.format(obj.strIDE_MAC) + "&nbsp;</td>");
                                }
                    %>
            </table>
        </div>
        <script>
            function OnBeforeDelete(id, tr){
                return confirm(arraylng["MSG_0016"]);
            }
    function OnViewLoad(){
                parent.g_Handler.setCaptionHTML("<%=ApplicationConfigurator.LanguageManager.getString(
                            ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                            ? "Associativa.macchine.attrezzature.impianti"
                            : "Associativa.macchine/attrezzature"
                            )%>");

                parent.g_Handler.New.URL="/luna/WEB/Form_MAC_OPE_SVO/MAC_OPE_SVO_Form.jsp";
                parent.g_Handler.New.Width="880px";
                parent.g_Handler.New.Height="500px";

                parent.g_Handler.Open=parent.g_Handler.New;

                parent.g_Handler.Delete.URL="/luna/WEB/Form_MAC_OPE_SVO/MAC_OPE_SVO_Delete.jsp";
                parent.g_Handler.Delete.OnBefore=OnBeforeDelete;
                parent.g_Handler.Help.URL="/luna/WEB/Form_MAC_OPE_SVO/MAC_OPE_SVO_Help.jsp";
            }
            parent.g_Handler.OnViewChange(divContent, OnViewLoad);
        </script>
