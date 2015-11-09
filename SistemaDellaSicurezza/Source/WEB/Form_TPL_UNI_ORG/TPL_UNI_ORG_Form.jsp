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
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/TipologieUnitaOrganizzativa/TipologieUnitaOrganizzativaBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TipologieUnitaOrganizzativa/TipologieUnitaOrganizzativaBean.jsp" %>

<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<html>
    <head>
        <script type="text/javascript" src="../_scripts/textarea.js"></script>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuOrganizzazione,0) + "</title>");
        </script>
        <LINK REL=STYLESHEET TYPE="text/css" HREF="../_styles/style.css" >
    </head>
    <script>
        window.dialogWidth="700px";
        window.dialogHeight="290px";
    </script>
    <%
        ITipologieUnitaOrganizzativa TipologieUnitaOrganizzativa = null;

        long lCOD_TPL_UNI_ORG = 0;
        String strNOM_TPL_UNI_ORG = "";
        String strDES_TPL_UNI_ORG = "";

        if (request.getParameter("ID") != null) {
            String strCOD_TPL_UNI_ORG = request.getParameter("ID");

            ITipologieUnitaOrganizzativaHome home = (ITipologieUnitaOrganizzativaHome) PseudoContext.lookup("TipologieUnitaOrganizzativaBean");
            Long pno_id = new Long(strCOD_TPL_UNI_ORG);
            TipologieUnitaOrganizzativa = home.findByPrimaryKey(pno_id);

            lCOD_TPL_UNI_ORG = pno_id.longValue(); 						//1
            strNOM_TPL_UNI_ORG = TipologieUnitaOrganizzativa.getNOM_TPL_UNI_ORG();					//2
            strDES_TPL_UNI_ORG = TipologieUnitaOrganizzativa.getDES_TPL_UNI_ORG();					//3 - Nullable
        }
    %>
    <body>
        <form action="TPL_UNI_ORG_Set.jsp" method="post" target="ifrmWork" style="margin:10 10 10 10;">
            <input name="SBM_MODE" type="Hidden" value="<%=(lCOD_TPL_UNI_ORG == 0) ? "new" : "edt"%>">
            <input type="hidden" name="TPL_UNI_ORG_ID" value="<%=lCOD_TPL_UNI_ORG%>">
            <table cellpadding="0" cellspacing="0" border="0"> 
                <tr><td valign="top">
                        <table cellpadding="0" cellspacing="0" border="0"> 
                            <tr><td class="title">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                        (SubMenuOrganizzazione,0,<%=request.getParameter("ID")%>));
                                    </script>
                                </td></tr>
                            <tr><td>
                                    <table>
                                        <tr>
                                            <td>
                                                <!-- ############################ -->
                                                <%@ include file="../_include/ToolBar.jsp" %>	
                                                <%ToolBar.bCanDelete = (TipologieUnitaOrganizzativa != null);%>
                                                <%=ToolBar.build(2)%> 
                                                <!-- ########################### -->
                                    </table>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.tipologia.unità.organizzativa")%></legend>
                                        <table width="100%">
                                            <tr>
                                                <td align="right"><div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></div></td>
                                                <td><input tabindex="1" type="text" maxlength="45" name="NOME" value="<%=strNOM_TPL_UNI_ORG%>" size="110"></td>
                                            </tr>
                                            <tr>
                                                <td align="right" valign="top"><div align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</div></td>
                                                <td><s2s:textarea tabindex="2" maxlength="300" rows="5" cols="80" name="DESC" ><%=strDES_TPL_UNI_ORG%></s2s:textarea></td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
    </body>
</html>
