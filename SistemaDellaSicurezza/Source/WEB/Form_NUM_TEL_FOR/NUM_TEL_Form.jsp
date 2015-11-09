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
            <version number="1.0" date="14/01/2004" author="Roman Chumachenko">
            <comments>
            <comment date="23/01/2004" author="Treskina Maria">
            <description>Forma dla NUM_TEL_FOR_AZL_TAB - FornitoreTelefono</description>
            </comment>		
            </comments> 
            </version>
            </versions>
            </file> 
             */
%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/FornitoreTelefono/FornitoreTelefonoBean_Interfaces.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/FornitoreTelefono/FornitoreTelefonoBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../_include/ToolBar.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
    <head><title><%=ApplicationConfigurator.LanguageManager.getString("Numeri.telefonici")%></title></head>
    <link rel="stylesheet" href="../_styles/style.css">
    <body>
        <script>
            
        </script>
        <%
            long lCOD_NUM_TEL_FOR_AZL = 0;  //1
            long lCOD_FOR_AZL = 0;          //2
            String strTPL_NUM_TEL = new String();    //3
            String strNUM_TEL = new String();        //4

            IFornitoreTelefono Tel = null;
            IFornitoreTelefonoHome TelHome = (IFornitoreTelefonoHome) PseudoContext.lookup("FornitoreTelefonoBean");


            // stub for debuging
            //strCOD_FOR_AZL="1042315978732";  //1074126717718
            //if (true) return;
            if (request.getParameter("ID") != null) {
                // getting parameters of azienda
                String strCOD_NUM_TEL_FOR_AZL = (String) request.getParameter("ID");
                //getting of azienda object
                Long tel_id = new Long(strCOD_NUM_TEL_FOR_AZL);
                Tel = TelHome.findByPrimaryKey(tel_id);
                // getting of object variables
                lCOD_NUM_TEL_FOR_AZL = tel_id.longValue();
                lCOD_FOR_AZL = Tel.getCOD_FOR_AZL();
                strTPL_NUM_TEL = Tel.getTPL_NUM_TEL();
                strNUM_TEL = Tel.getNUM_TEL();
            }// if request
            Checker c = new Checker();
            lCOD_FOR_AZL = c.checkLong("", request.getParameter("ID_PARENT"), false);
        %>
        
        <form action="NUM_TEL_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <table border=0 style='height:150'>
                <!--	<tr style="height:10 "> -->
                <tr>
                    <td colspan="100%" valign="top">
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="center" class="title" valign="top">
                                    <%=ApplicationConfigurator.LanguageManager.getString("Numeri.telefonici")%>
                                </td>
                            </tr>
                            <tr><td>
                                    <table width="100%">
                                        <!-- ############################ -->  		

                                     <%ToolBar.bShowNew = false;
            ToolBar.bShowSearch = false;
            ToolBar.bShowPrint = false;
            ToolBar.bShowDelete = false;
                                     %>
                                       <%=ToolBar.build(3)%> 
                                       <% if (lCOD_NUM_TEL_FOR_AZL == 0) {
                out.print("<script>ToolBar.Return.setEnabled(false);</script>");
            }%>
                                    <!-- ########################### -->

                                    </table>
                                    <fieldset style="padding:10 10 10 10">					
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Contatto.telefonico")%></legend>
                                        <table>
                                            <tr>
                                                <td>
                                                    <input name="SBM_MODE" type="hidden" value="<%if (lCOD_NUM_TEL_FOR_AZL != 0) {
                out.print("edt");
            } else {
                out.print("new");
            }%>">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan='100%'>	<input name="COD_NUM_TEL_FOR_AZL" id="COD_NUM_TEL_FOR_AZL" type="hidden" value="<%=lCOD_NUM_TEL_FOR_AZL%>"><input name="COD_FOR_AZL" type="hidden" value="<%=lCOD_FOR_AZL%>">
                                                </td>
                                            </tr>
                                            <tr>
                                                <br>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%>&nbsp;</b></td>
                                                <td>
                                                    <select name="TPL_NUM_TEL" style="width:'201'">
                                                        <option value="FISSO" <%=(strTPL_NUM_TEL.equals("FISSO")) ? "selected" : ""%>><%=ApplicationConfigurator.LanguageManager.getString("FISSO")%></option>
                                                        <option value="CELLULARE" <%=(strTPL_NUM_TEL.equals("CELLULARE")) ? "selected" : ""%>><%=ApplicationConfigurator.LanguageManager.getString("CELLULARE")%></option>
                                                        <option value="FAX" <%=(strTPL_NUM_TEL.equals("FAX")) ? "selected" : ""%>><%=ApplicationConfigurator.LanguageManager.getString("FAX")%></option>
                                                        <option value="CERCA PERSONE" <%=(strTPL_NUM_TEL.equals("CERCA PERSONE")) ? "selected" : ""%>><%=ApplicationConfigurator.LanguageManager.getString("CERCA.PERSONE")%></option>
                                                    </select>                                                                                                                            
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</b></td>
                                                <td><input size="35" id="NUM_TEL" type="text" name="NUM_TEL" maxlength="15" value="<%=strNUM_TEL%>"></td>
                                            </tr>
                                        </table>
                                    </fieldset>
                            </td></tr>
                        </table>	  
                    </td>
                </tr>
            </table>
        </form>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" style="width:400; height:150"></iframe>
        
    </body>
</html>
