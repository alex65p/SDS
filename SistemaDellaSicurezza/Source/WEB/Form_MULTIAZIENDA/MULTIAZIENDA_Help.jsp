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
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuGestione,0) + "</title>");
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
                                    document.write(getCompleteMenuPathHelp(SubMenuGestione,0));
                                </script>
                            </td>
                        </tr>
                        <tr>
                            <td width="35"><img id='btnClose' onclick="window.returnValue='CANCEL';window.close();" title='<%=ApplicationConfigurator.LanguageManager.getString("Uscita")%>' src='../_images/new/EXIT.GIF'></td>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <fieldset style="height:450px">
                        <table width="100%" height="100%" border="0">
                            <tr>
                                <td valign="top">
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
                                            %>
                                            <div align="justify">
                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Multiazienda.frase.1")%>
                                                <p>
                                                <img src="../_images/new/RETURN.GIF">
                                                &nbsp;
                                                <B><%=ApplicationConfigurator.LanguageManager.getString("Associa")%></B>
                                            </div>
                                        <% } %>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
        </table>
    </body>
</html>
