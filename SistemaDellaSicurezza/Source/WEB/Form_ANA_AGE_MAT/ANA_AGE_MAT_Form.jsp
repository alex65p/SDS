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

<%    /*
     <file>
     <versions>	
     <version number="1.0" date="27/01/2004" author="Valentina Ruggieri">
     <comments>
     <comment date="27/01/2004" author="Valentina Ruggieri">
     <description>ANA_AGE_MAT_Form.jsp</description>
     </comment>		
     </comments> 
     </version>
     </versions>
     </file> 
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server

%>
<%@ page import="com.apconsulting.luna.ejb.AgenteMateriale.*" %>
<%@ page import="com.apconsulting.luna.ejb.CategoriaAgeMateriale.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuInfortuni, 3) + "</title>");
        </script>
    </head>
    <link rel="stylesheet" href="../_styles/style.css">
    <body style="margin:0 0 0 0;">
        <%    long lCOD_AGE_MAT = 0;
            long lCOD_CAG_AGE_MAT = 0;
            String strCOD_AGE_MAT = new String();
            String strNOM_AGE_MAT = new String();

            String selected = new String();
            IAgenteMateriale agente = null;
            IAgenteMaterialeHome home = (IAgenteMaterialeHome) PseudoContext.lookup("AgenteMaterialeBean");

            ICategoriaAgeMaterialeHome catHome = (ICategoriaAgeMaterialeHome) PseudoContext.lookup("CategoriaAgeMaterialeBean");
            ICategoriaAgeMateriale categoria = null;

            if (request.getParameter("ID") != null) {
                strCOD_AGE_MAT = (String) request.getParameter("ID");
                Long cod_age_mat = new Long(strCOD_AGE_MAT);
                agente = home.findByPrimaryKey(cod_age_mat);
                lCOD_AGE_MAT = cod_age_mat.longValue();
                lCOD_CAG_AGE_MAT = agente.getCOD_CAG_AGE_MAT();
                strNOM_AGE_MAT = agente.getNOM_AGE_MAT();
            }
        %>
        <form action="ANA_AGE_MAT_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <table  cellpadding="0" cellspacing="0">
                <tr>
                    <td width="658" align="center" valign="top" class="title">
                        <script>
                            document.write(getCompleteMenuPathFunction
                                    (SubMenuInfortuni, 3,<%=request.getParameter("ID")%>));
                        </script>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table>
                            <%@ include file="../_include/ToolBar.jsp" %>
                            <%ToolBar.bShowPrint = false;%>
                            <%=ToolBar.build(4)%>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table border="0" width="100%">
                            <tr>
                                <td>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Agente.materiale")%></legend>
                                        <br>
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td></td>
                                                <td>
                                                    <input name="SBM_MODE" type="hidden" value="<%if (lCOD_AGE_MAT != 0) {
                                                            out.print("edt");
                                                        } else {
                                                            out.print("new");
                                                        }%>">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>	
                                                    <input name="COD_AGE_MAT" type="hidden" value="<%=lCOD_AGE_MAT%>">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">&nbsp;<b><%=ApplicationConfigurator.LanguageManager.getString("Categoria")%>&nbsp;</td>
                                                <td>
                                                    <select name="COD_CAG_AGE_MAT" style="width:450px">
                                                        <option value=""></option>
                                                        <%
                                                            java.util.Collection col_view = catHome.getCategoriaAge_Materiali_View();
                                                            java.util.Iterator it_view = col_view.iterator();
                                                            while (it_view.hasNext()) {
                                                                CategoriaAge_Materiali_View vw = (CategoriaAge_Materiali_View) it_view.next();
                                                                if (vw.COD_CAG_AGE_MAT == lCOD_CAG_AGE_MAT) {
                                                                    selected = "selected";
                                                                } else {
                                                                    selected = "";
                                                                }
                                                                out.println("<option " + selected + "  value='" + vw.COD_CAG_AGE_MAT + "'>" + vw.NOM_CAG_AGE_MAT + "</option>");
                                                            }
                                                        %>
                                                    </select>	
                                                </td>
                                            </tr> 
                                            <tr>
                                                <td colspan="2" height="4"></td>
                                            </tr>
                                            <tr>
                                                <td align="left" nowrap><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                                <td><input style="width:450px" type="text" name="NOM_AGE_MAT" maxlength="150"  value="<%=strNOM_AGE_MAT%>"></td>
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
