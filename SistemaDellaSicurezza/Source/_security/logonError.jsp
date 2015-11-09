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
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>                                                                                          
<%@ page import="s2s.luna.conf.ApplicationConfigurator" %>
<%@ taglib uri="http://jakarta.apache.org/taglibs/session-1.0" prefix="sess" %>
<sess:invalidate/>
<html>
    <head>
        <title>
            Login Error
        </title>
        <style type="text/css">
            body
            {
                font-family:Tahoma;                
                background: #15138a; 
                color:#ffffff;
            }
            
            input  { color: #ffffff;   font-family: Tahoma;}
            select { color: #ffffff;   font-family: Tahoma;}
            
            a { 
                color: #FF9400;
                text-decoration: none;
            }
            
        </style>
        <META http-equiv=imagetoolbar content=no>
        <script type="text/javascript">
            function centerToScreen(win, width, height) {
                var x = screen.availWidth - width - ((screen.availWidth - width) / 2);
                var y = screen.availHeight - height - ((screen.availHeight - height) / 2);
                win.moveTo(x, y);
            }
        </script>
    </head>
    <body>
        <script type="text/javascript">
            window.resizeTo(500, 565);
            centerToScreen(window, 500, 565);
        </script>
        <table width="100%" style="height: 50%;" border=0>
            <tr>
                <td  valign="middle" align="center">
                    <h2>
                        <%=ApplicationConfigurator.LanguageManager.getString("Utente.o.Password.errati")%>
                        <br><br>
                        <a href="<%=ApplicationConfigurator.getApplicationURI() + "_security/logon.jsp"%>"><%=ApplicationConfigurator.LanguageManager.getString("Riprovare")%></a>
                    </h2>
                </td>
            </tr>
        </table>
    </body>
</html>
