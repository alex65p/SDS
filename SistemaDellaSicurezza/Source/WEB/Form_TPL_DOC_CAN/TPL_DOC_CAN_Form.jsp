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
    <version number="1.0" date="23/01/2004" author="Pogrebnoy Yura">
    <comments>
    <comment date="23/01/2004" author="Pogrebnoy Yura">
    <description>Shablon formi ANA_TPL_DOC_Form.jsp</description>
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

<%@ page import="com.apconsulting.luna.ejb.TipologiaDocumentiCantiere.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuDocumentiAreaSicurezza,0) + "</title>");
        </script>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">

    <script>
        window.dialogWidth="740px";
        window.dialogHeight="290px";
    </script>
    </head>
    <body>
        <%
            //boolean EdFlag=false;		//flag of editing
            //   *require Fields*
            String strCOD_TPL_DOC = "";
            String strNOM_TPL_DOC = "";
            //   *Not require Fields*
            String strDES_TPL_DOC = "";
            String strCOL_SOP = "";
            String strALL_STA_SOP = "";
            String strTPL_ACQ_POS = "";


            ITipologiaDocumentiCantiere tpldoc = null;
            if (request.getParameter("ID") != null) {
                strCOD_TPL_DOC = request.getParameter("ID");
                // editing of tpldoc
                //getting of tpldoc object
                ITipologiaDocumentiCantiereHome home = (ITipologiaDocumentiCantiereHome) PseudoContext.lookup("TipologiaDocumentiCantiereBean");
                Long COD_TPL_DOC = new Long(strCOD_TPL_DOC);
                tpldoc = home.findByPrimaryKey(COD_TPL_DOC);
                // getting of object variables
                strNOM_TPL_DOC = Formatter.format(tpldoc.getNOM_TPL_DOC());
                //---
                strDES_TPL_DOC = Formatter.format(tpldoc.getDES_TPL_DOC());
                strCOL_SOP = Formatter.format(tpldoc.getCOL_SOP());
                strALL_STA_SOP = Formatter.format(tpldoc.getALL_STA_SOP());
                strTPL_ACQ_POS = Formatter.format(tpldoc.getTPL_ACQ_POS());
            }
        %>

        <!-- form for addind  -->
        <form action="TPL_DOC_CAN_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <table width="100%" border="0">
                <tr>
                    <td width="10" height="100%" valign="top">
                    </td>
                    <td valign="top">
                        <table  width="100%" border="0">
                            <tr><td class="title" colspan="2">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                        (SubMenuDocumentiAreaSicurezza,0,<%=request.getParameter("ID")%>));
                                    </script>
                                </td></tr>
                            <input name="SBM_MODE" type="Hidden" value="<%if (strCOD_TPL_DOC == "") {
        out.print("new");
    } else {
        out.print("edt");
    }%>">
                            <input name="COD_TPL_DOC" type="Hidden" value="<%=strCOD_TPL_DOC%>">

                            <tr>
                                <td>
                                    <table width="100%">
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%ToolBar.bCanDelete = (tpldoc != null);%>
                                        <%=ToolBar.build(2)%>
                                    </table>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Tipologia.documento")%></legend>
                                        <table  width="100%" border="0">
                                            <tr >
                                                <td align="right" width="20%"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
                                                <td  colspan="5"><input tabindex="1" size="120" type="text" maxlength="100" name="NOM_TPL_DOC" value="<%=strNOM_TPL_DOC%>">
                                                </td></tr>
                                            <tr><td valign="top" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                                <td colspan="5"><textarea tabindex="2" cols="120" rows="4" name="DES_TPL_DOC"><%=strDES_TPL_DOC%></textarea></td>
                                            </tr>
                                            <tr>
                                            <td align="right" ><%=ApplicationConfigurator.LanguageManager.getString("Collegamento.con.sopralluogo")%>&nbsp;</td>
                                                <td>
                                                    <input type="checkbox" name="COL_SOP" id="COL_SOP" class="checkbox" <%=strCOL_SOP.equals("S") ? "checked" : ""%>>
                                                    
                                                </td>
                                            <td align="right" ><%=ApplicationConfigurator.LanguageManager.getString("Allegato.stampa.sopralluogo")%>&nbsp;</td>
                                                <td>
                                                    <input type="checkbox" name="ALL_STA_SOP" class="checkbox" <%=strALL_STA_SOP.equals("S") ? "checked" : ""%>>
                                                </td>
                                            <td align="right" ><%=ApplicationConfigurator.LanguageManager.getString("Tipologia.acquisizione.POS")%>&nbsp;</td>
                                                <td>
                                                    <input type="checkbox" name="TPL_ACQ_POS" class="checkbox" <%=strTPL_ACQ_POS.equals("S") ? "checked" : ""%>>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset></td></tr>
                        </table>
                    </td>
                </tr>
                <tr><td colspan="100%"><iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe></td></tr>
            </table>
        </form>
        <!-- /form for addind  -->

    </body>
</html>
