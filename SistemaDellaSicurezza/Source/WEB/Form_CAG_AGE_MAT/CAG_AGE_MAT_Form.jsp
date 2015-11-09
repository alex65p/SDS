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
     <version number="1.0" date="26/01/2004" author="Valentina Ruggieri">
     <comments>
     <comment date="26/01/2004" author="Valentina Ruggieri">
     <description>CAG_AGE_MAT_Form.jsp</description>
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
            document.write("<title>" + getCompleteMenuPath(SubMenuInfortuni, 2) + "</title>");
        </script>
    </head>
    <link rel="stylesheet" href="../_styles/style.css">
    <body style="margin:0 0 0 0;">
        <%
            long lCOD_CAG_AGE_MAT = 0;
            String strCOD_CAG_AGE_MAT = new String();
            String strNOM_CAG_AGE_MAT = new String();
            ICategoriaAgeMateriale categoria = null;
            ICategoriaAgeMaterialeHome cathome = (ICategoriaAgeMaterialeHome) PseudoContext.lookup("CategoriaAgeMaterialeBean");

            if (request.getParameter("ID") != null) {
                strCOD_CAG_AGE_MAT = (String) request.getParameter("ID");
                Long cod_cag_age_mat = new Long(strCOD_CAG_AGE_MAT);
                categoria = cathome.findByPrimaryKey(cod_cag_age_mat);
                lCOD_CAG_AGE_MAT = cod_cag_age_mat.longValue();
                strNOM_CAG_AGE_MAT = categoria.getNOM_CAG_AGE_MAT();
            }
        %>
        <form action="CAG_AGE_MAT_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr valign="top">
                    <td>
                        <table cellpadding="0" cellspacing="0" width="100%" border="0">  
                            <tr>
                                <td height="4"></td>
                            </tr>
                            <tr>
                                <td align="center" class="title" valign="top">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                                (SubMenuInfortuni, 2,<%=request.getParameter("ID")%>));
                                    </script>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="100%">
                                        <!-- ##################################################################################### -->
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%ToolBar.bShowPrint = false;%>
                                        <%=ToolBar.build(2)%>
                                        <!-- ###################################################################################### -->
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table cellpadding="0" cellspacing="0" width="100%" border="0">
                                        <tr>
                                            <td>
                                                <fieldset>
                                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Categoria.agente.materiale")%></legend>
                                                    <br>
                                                    <table style="width:100%"  border="0" cellpadding="0" cellspacing="0">
                                                        <input name="SBM_MODE" type="hidden" value="<%if (lCOD_CAG_AGE_MAT != 0) {
                                                                out.print("edt");
                                                            } else {
                                                                out.print("new");
                                                            }%>">
                                                        <input name="COD_CAG_AGE_MAT" id="COD_CAG_AGE_MAT" type="hidden" value="<%=lCOD_CAG_AGE_MAT%>">
                                                        <tr>
                                                            <td align="left"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</td>
                                                            <td colspan="2"><input tabindex="1" size="110" type="text" id="NOM_CAG_AGE_MAT" name="NOM_CAG_AGE_MAT" maxlength="150" value="<%=Formatter.format(strNOM_CAG_AGE_MAT)%>"></td><td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" height="15"></td>
                                                        </tr>
                                                    </table>	
                                                </fieldset>
                                            </td>
                                        </tr>
                                    </table>
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
