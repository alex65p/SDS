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
            <version number="1.0" date="27/02/2004" author="Yuriy Kushkarov">
            <comments>
            <comment date="27/02/2004" author="Yuriy Kushkarov">
            <description>Shablon formi COR_DPD_Form.jsp</description>
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
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<html>
    <head>
        <title><%=ApplicationConfigurator.LanguageManager.getString("Date.degli.eventi")%></title>
        <!-- autocompose data field -->
        <script type="text/javascript" src="../_scripts/calendar/utility.js"></script>
        <!-- import the calendar script -->
        <script type="text/javascript" src="../_scripts/calendar/calendar.js"></script>
        <!-- import the language module -->
        <script type="text/javascript" src="../_scripts/calendar/lang.js"></script>
        <!-- import calendar utility function -->
        <script type="text/javascript" src="../_scripts/calendar/showCalendar.js"></script>
        <!-- style sheet for calendar -->
        <link rel="stylesheet" type="text/css" media="all" href="../_styles/calendar/skins/aqua/theme.css" title="Aqua" />
        
        <script type="text/javascript" src="../_scripts/formatDate.js"></script>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
        <script>
            window.dialogHeight="220px"
        </script>
    </head>
    <body>
        <script src="../_scripts/Alert.js" type="text/javascript"></script>
        <%

        %>
        <!-- form for addind  corbean-->
        <form action=""  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <table width="100%" border="0">
                <tr>
                    <td align="center" class="title" valign="top" >
                        <%=ApplicationConfigurator.LanguageManager.getString("Date.degli.eventi")%>
                    </td>
                </tr> 
            </table>
                <!-- ############################ -->  		
<%@ include file="../_include/ToolBar.jsp" %>      
<%ToolBar.bShowDelete = false;
            ToolBar.bShowSave = false;
            ToolBar.bShowReturn = false;
            ToolBar.bShowSearch = false;
            ToolBar.bCanPrint = true;
            ToolBar.bAlwaysShowPrint = true;
%>	
<%=ToolBar.build(2)%> 
                <!-- ########################### --> 
            <table width="100%" border="0">
                <tr>
                    <td valign="top">
                        <fieldset>
                           <legend><%=ApplicationConfigurator.LanguageManager.getString("Data.evento")%></legend>
                                        <table  width="100%" border="0">
                                <tr>
                                    <td align="right" width="15%" nowrap><strong><%=ApplicationConfigurator.LanguageManager.getString("Data.dal")%>&nbsp;</strong></td>
                                    <td>
                                        <s2s:Date id="DAT_DAL" name="DAT_DAL" value=""/>
                                    </td>
                                    <td  align="right" nowrap><strong><%=ApplicationConfigurator.LanguageManager.getString("al")%>&nbsp;</strong></td>
                                    <td>
                                        <s2s:Date id="DAT_AL" name="DAT_AL" value=""/>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>  
            </table>
        </form>
        <!-- /form for addind  corbean-->
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <script>
            function init(){
                btn = ToolBar.Print.getButton();
                btn.onclick= OnPrint;
            }
            function OnPrint(){
                strDat1 = document.all["DAT_DAL"].value;
                strDat2 = document.all["DAT_AL"].value
                dat1 = Date.parse(strDat1);
                dat2 = Date.parse(strDat2);
                now = Date.parse((new Date()).formatDate("d/m/Y"));

                if (!dat1 || !dat2){
                    Alert.Error.showCustomError(arraylng["MSG_0106"]);		
                    return;
                }
                if (dat1>dat2){
                    Alert.Error.showCustomError(arraylng["MSG_0107"]);		
                    return;
                }
                if (dat2>now.valueOf()){
                    Alert.Error.showCustomError(arraylng["MSG_0108"]);		
                    return;
                }
                
                ToolBar.openReport("ElencoInfortuniIncidenti.jsp?DAT_DAL="+strDat1+"&DAT_AL="+strDat2+"&");
            }
        </script> 
    </body>
</html>
