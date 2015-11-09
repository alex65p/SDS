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

<%-- 
    Document   : DOC_ASS_INF_Form
    Created on : 7-mar-2011, 12.22.17
    Author     : Alessandro
--%>
<%
            /*
            <file>
            <versions>
            <version number="1.0" date="30/01/2004" author="Roman Chumachenko">
            <comments>
            <comment date="30/01/2004" author="Roman Chumachenko">
            <description>DOC_CSG_DTE_Form.jsp</description>
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
            response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>
<%@ page import="com.apconsulting.luna.ejb.DittaEsterna.*" %>
<%@ page import="com.apconsulting.luna.ejb.InfortuniIncidenti.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
    <head><title><%=ApplicationConfigurator.LanguageManager.getString("Documenti.associati")%></title></head>
    <script type="text/javascript">
        window.dialogWidth="500px";
        window.dialogHeight="200px";
    </script>
    <link rel="stylesheet" href="../_styles/style.css">
    <body style="margin:0 0 0 0;">
        <%
                    long COD_AZL = 0;			//1
                    long COD_INO = 0;	  		//2
                    long COD_DOC = 0;     		//3

                    IInfortuniIncidenti bean = null;
                    IInfortuniIncidentiHome home = (IInfortuniIncidentiHome) PseudoContext.lookup("InfortuniIncidentiBean");


                    // /if request
                    if (request.getParameter("ID") != null) {
                        // --------
                        String strCOD_DOC = (String) request.getParameter("ID");
                        COD_DOC = new Long(strCOD_DOC).longValue();

                    }// /if request
                    Checker c = new Checker();
                    COD_INO = c.checkLong("", request.getParameter("ID_PARENT"), false);
                    bean = home.findByPrimaryKey(new Long(COD_INO));
                    COD_AZL = bean.getCOD_AZL();
                    //---------------------------------------------------------------------
        %>

        <form action="DOC_ASS_INF_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr style='height:10px'>
                    <td align="center"></td>
                </tr>
                <tr valign="top">
                    <td>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="center" class="title" valign="top">
                                    <%=ApplicationConfigurator.LanguageManager.getString("Documenti.associati")%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <!-- ##################################################################################### -->
                                    <table width="100%" border="0">
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%ToolBar.bShowNew = false;%>
                                        <%ToolBar.bShowSearch = false;%>
                                        <%ToolBar.bShowDelete = false;%>
                                        <%ToolBar.bShowPrint = false;%>
                                        <%ToolBar.bShowReturn = false;%>
                                        <%=ToolBar.build(4)%>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <!-- ##################################################################################### -->
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                <fieldset>
                                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Documento")%></legend>
                                                    <table width="100%"  border="0" cellpadding="0" cellspacing="3">
                                                        <tr>
                                                            <td width="15%" align="left"></td>
                                                            <td><input name="SBM_MODE" type="hidden"  value="<%if (COD_DOC != 0) {
                                                                            out.print("edt");
                                                                        } else {
                                                                            out.print("new");
                                                                        }%>">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="15%" align="left"></td>
                                                            <td>
                                                                <input name="COD_INO" id="COD_INO" type="hidden" value="<%=COD_INO%>">
                                                                <%if (COD_DOC != 0) {%>
                                                                <input name="COD_DOC" id="COD_DOC" type="hidden" value="<%=COD_DOC%>">
                                                                <%}%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <br>
                                                            <td width="15%" height="4" align="left">
                                                                <b><%=ApplicationConfigurator.LanguageManager.getString("Documento")%></b></td>
                                                            <td>
                                                                    <SELECT name="COD_DOC" style="width:100%;" <%if (COD_DOC != 0) {
                                                                                    out.print("disabled");
                                                                                }%>>
                                                                    <option></option>
                                                                    <%
                                                                                IAnagrDocumentoHome adHome = (IAnagrDocumentoHome) PseudoContext.lookup("AnagrDocumentoBean");
                                                                                String cb = BuildDocumentiComboBox(adHome, COD_DOC, COD_AZL);
                                                                                out.print(cb);
                                                                    %>
                                                                </SELECT>
                                                            </td>
                                                        </tr>
                                                        <!-- RadioButtons -->
                                                        <tr>
                                                            <td width="15%" colspan="2" height="1" align="left"></td>
                                                        </tr>
                                                        <tr>
                                                            <td width="15%" height="2" align="left">&nbsp;</td>
                                                            <td align="center" height="2">
                                                            </td>
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
        <br>
        <script type="text/javascript">
            function clearFields(){
                document.all["COD_DTE"].value="0";
                document.all["CONSEGNATO"].checked=true;
                document.all["COD_DOC"].selectedIndex=0;
            }
            function showDP(){
                obj=window.dialogArguments;
            }
        </script>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <%!// ------------ combobox for documenti ---------------
        /* 	IAnagrDocumentoHome home = home interface of AnagrDocumentoBean
            long SELECTED_ID = ID (COD_DOC) of current document, if not exists then =0
            long AZL_ID = ID of current Azienda
             */
            String BuildDocumentiComboBox(IAnagrDocumentoHome home, long SELECTED_ID, long AZL_ID) {
                String str = "";
                String strSEL = "";
                java.util.Collection col = home.getAnagrDocumento_TIT_DOC_ByAZLID_View(AZL_ID);
                java.util.Iterator it = col.iterator();
                while (it.hasNext()) {
                    AnagrDocumento_TIT_DOC_ByAZLID_View dt = (AnagrDocumento_TIT_DOC_ByAZLID_View) it.next();
                    strSEL = "";
                    if (SELECTED_ID != 0) {
                        if (SELECTED_ID == dt.COD_DOC) {
                            strSEL = "selected";
                        }
                    }
                    str = str + "<option " + strSEL + " value=\"" + Formatter.format(dt.COD_DOC) + "\">" + Formatter.format(dt.TIT_DOC) + "</option>";
                }
                return str;
            }
        %>
        <script type="text/javascript">
            //---------------
            ToolBar.Return.setEnabled(false);
        </script>
    </body>
</html>
