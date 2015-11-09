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
    <version number="1.0" date="23/01/2004" author="Kushkarov Yura">
    <comments>
    <comment date="23/01/2004" author="Kushkarov Yura">
    <description>Shablon formi TPL_MAC_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.TipologieMacchine.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuMacchinari,0) + "</title>");
        </script>
        <script>
            window.dialogWidth="650px";
            window.dialogHeight="230px";
        </script>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">

    </head>
    <body>
        <%
            //boolean EdFlag=false;		//flag of editing
            //   *require Fields*
            String strCOD_TPL_MAC = "";
            //String strNOM_TPL_MAC="";
            String strDES_TPL_MAC = "";


            ITipologieMacchine TipologieMacchine = null;
            if (request.getParameter("ID") != null) {
                strCOD_TPL_MAC = request.getParameter("ID");
                // editing of ala
                //getting of ala object
                ITipologieMacchineHome home = (ITipologieMacchineHome) PseudoContext.lookup("TipologieMacchineBean");
                Long COD_TPL_MAC = new Long(strCOD_TPL_MAC);
                TipologieMacchine = home.findByPrimaryKey(COD_TPL_MAC);
                // getting of object variables
                strDES_TPL_MAC = TipologieMacchine.getDES_TPL_MAC();
                //---		
            }
        %>

        <!-- form for addind  -->
        <form action="TPL_MAC_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <table width="100%" border="0">
                <!-- posizione precedente della toolbar -->

                <tr>
                    <td width="10" height="100%" valign="top">
                        <!-- <button type="button" class="menu" >&nbsp;1&nbsp;</button><br>
                        <button type="button" class="menu">&nbsp;2&nbsp;</button>
                        <button type="button" class="menu">&nbsp;3&nbsp;</button><br>
                        <button type="button" class="menu">&nbsp;4&nbsp;</button>
                        <button type="button" class="menu">&nbsp;5&nbsp;</button><br>
                        -->

                    </td>
                    <td valign="top">
                        <table width="100%">
                            <tr><td  align="left" class="title">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                        (SubMenuMacchinari,0,<%=request.getParameter("ID")%>));
                                    </script>
                                </td></tr>

                            <input name="SBM_MODE" type="Hidden" value="<%if (strCOD_TPL_MAC == "") {
                                    out.print("new");
                                } else {
                                    out.print("edt");
                                }%>">
                            <input name="COD_TPL_MAC" type="Hidden" value="<%=strCOD_TPL_MAC%>">

                            <tr>
                                <td>
                                    <table  width="100%" border="0">
                                        <tr>
                                            <!--inserimento toolbar -->
                                            <td colspan="9" align="left" > <table width="100%" border="0">
                                                    <tr> 
                                                        <!-- toolbar --> 
                                                        <!-- ############################ -->
                                                        <%@ include file="../_include/ToolBar.jsp" %>
                                                        <%ToolBar.bCanDelete = (TipologieMacchine != null);%>
                                                        <%=ToolBar.build(2)%>
                                                        <!-- ########################### -->
                                                    </tr> </table>
                                                <fieldset>
                                                    <legend><%=ApplicationConfigurator.LanguageManager.getString(
                                                                ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                                                    ?"Tipologia.macchina.attrezzatura.impianto"
                                                                    :"Tipologia.macchina/attrezzatura"
                                                                )%></legend>
                                                    <table border="0">

                                                        <tr>
                                                            <!--fine  inserimento -->

                                                            <td valign="top" align="left"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</b></td>
                                                            <td><input tabindex="1" maxlength="70" size="100" style="height:'50'" name="DES_TPL_MAC" type="text" value="<%=strDES_TPL_MAC%>" ></td>
                                                        </tr>
                                                        </td></tr>

                                                    </table>	 
                                                </fieldset></td></tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        </form>
                        <!-- /form for addind  -->

                        <iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
                        </body>
                        </html>
