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
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<%
    String associazioneAttivita = ApplicationConfigurator.LanguageManager.getString("Associazione.misure.preventive.attivita.lavorative");
    String associazioneLuoghi = ApplicationConfigurator.LanguageManager.getString("Associazione.misure.preventive.luoghi.fisici");
    String tornaSu = ApplicationConfigurator.LanguageManager.getString("Help.Torna.su");
%>
<html>
    <head>
        <script>
            window.dialogWidth = "350px";
            document.write("<title>" + getCompleteMenuPath(SubMenuVerificheSPP,0) + "</title>");
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
                                    document.write(getCompleteMenuPathHelp(SubMenuVerificheSPP,0));
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
                                            %>
                                                <div align="justify" style="width:335px;height:475px;overflow-y: scroll; border:0px solid black;">
                                                <table width="100%" border="0">
                                                    <tr>
                                                        <td>
                                                            <A href="#section1" name="menu_section1"><%=associazioneAttivita%></A>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <A href="#section2"><%=associazioneLuoghi%></A>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td width="75%">
                                                                        <b><%=associazioneAttivita%></b>
                                                                    </td>
                                                                    <td width="25%">
                                                                        <A href="#menu_section1" name="section1" valign="top"><%=tornaSu%></A>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <p align="justify">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.associazione.misure.preventive.attivita.lavorative.audit.frase.1")%>
                                                                <br><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.associazione.misure.preventive.attivita.lavorative.audit.frase.2")%>
                                                            </p>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td width="75%">
                                                                        <b><%=associazioneLuoghi%></b>
                                                                    </td>
                                                                    <td width="25%">
                                                                        <A href="#menu_section1" name="section2" valign="top"><%=tornaSu%></A>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <p align="justify">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.associazione.misure.preventive.luoghi.fisici.audit.frase.1")%>
                                                                <br><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.associazione.misure.preventive.luoghi.fisici.audit.frase.2")%> 
                                                            </p>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>                                            
                                            <%
                                            }
                                            else {
                                                out.println("PROVENIENZA NON RICONOSCIUTA O NON IMPOSTATA");
                                            }
                                        } else {
                                            out.println("HELP GENERALE");
                                        } %>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
        </table>
    </body>
</html>
