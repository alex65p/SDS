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
    <version number="1.0" date="21/05/2007" author="Dario Massaroni">
	      <comments>
                <comment date="21/05/2007" author="Dario Massaroni">
                    <description>Shablon formi ANA_ORN_Form.jsp</description>
                </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuOrganizzazione,0) + "</title>");
        </script>
    </head>
    <link rel="stylesheet" href="../_styles/style.css">
    <body>
        <table border="0" width="100%">
            <tr>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0"  width='100%'>
                        <tr>
                            <td align="center" class="title" width="100%">
                                <script>
                                    document.write(getCompleteMenuPathHelp(SubMenuOrganizzazione,0));
                                </script>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%@ include file="../_include/ToolBar.jsp" %>
                                <%=ToolBar.buildForHelp(3)%>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <fieldset>
                        <table width="100%" border="0">
                            <tr>
                                <td>
                                    FUNZIONE DI PROVENIENZA: 
                                    <%  String HelpFrom = request.getParameter("HelpFrom");
                                        if (HelpFrom != null){
                                            if (HelpFrom.equals("VIEW")){
                                                out.println("LISTA INIZIALE");
                                            }
                                            else if (HelpFrom.equals("SEARCH")){
                                                out.println("FUNZIONE DI RICERCA E ASSOCIAZIONE");
                                            }
                                            else if (HelpFrom.equals("FORM")){
                                                out.println("FORM DI DETTAGLIO");
                                            }
                                            else if (HelpFrom.equals("ASSOCIATE")){
                                                out.println("TAB FOLDER DI ASSOCIAZIONE INFORMAZIONI");
                                            }
                                            else {
                                                out.println("PROVENIENZA NON RICONOSCIUTA O NON IMPOSTATA");
                                            }
                                        } else {
                                            out.println("HELP GENERALE");
                                        } %>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Testo dell'Help.
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    DA IMPLEMENTARE.
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
        </table>
    </body>
</html>
