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
            document.write("<title>" + getCompleteMenuPath(SubMenuAttivitaLavorative,2) + "</title>");
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
                                    document.write(getCompleteMenuPathHelp(SubMenuAttivitaLavorative,2));
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
                    <fieldset style="height:450px;">
                    <div align="justify" style="width:285px;height:450px;overflow-y: scroll; border:0px solid black;">
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
                                            %>
                                                <table width="100%" border="0">
                                                    <tr>
                                                        <td>
                                                            <p align="justify">
                                                                Questa funzionalità permette di associare i "Lavoratori / Mansioni SAP" con le "Unità Organizzative / Attività Lavorative - S2S".<br><br>
                                                                La parte sinistra dello schermo riporta, per ogni lavoratore presente sul sistema SAP, le informazioni relative all'unità 
                                                                organizzativa, alla mansione ed alla posizione di appartenenza.<br><br>
                                                                Per visualizzare tutte le informazioni della <i>"Tabella SAP"</i> utilizzare 
                                                                la icona funzionale <i>"Espandi vista tabella"</i> <img src="..\_images\new\espandi.gif" height="25" width="25" alt="Espandi vista tabella" > 
                                                                che "espande" la visibilità  delle informazioni per l'intera lunghezza della maschera.
                                                                La icona funzionale <i>"Riduci vista tabella"</i> <img src="..\_images\new\comprimi.gif" height="25" width="25" alt="Riduci vista tabella" > 
                                                                ripristina la visualizzazione standard.<br><br>
                                                                La parte destra dello schermo riporta la 
                                                                lista delle Unità Organizzative / Attività Lavorative presenti nel Sistema della Sicurezza.<br><br>
                                                                Per associare uno o più lavoratori ad ogni singola Organizzazione/Attività Lavorativa 
                                                                selezionare gli elementi prescelti cliccando su un punto qualsiasi della riga.<br><br>
                                                                Salvare l'associazione creata cliccando sul tasto <i>"Salva Associazione"</i>. <img src="..\_images\new\SAVE.GIF" alt="Salva Associazione"><br><br>
                                                                Per eliminare uno o più lavoratori dalla <i>"Tabella SAP"</i>, impedendone quindi, tramite questa funzionalità, la futura associazione alle "Unità organizzative/Attività lavorative - S2S, selezionare gli elementi prescelti cliccando su un punto qualsiasi della riga.<br><br>
                                                                Eliminare gli elementi selezionati cliccando sul tasto <i>"Elimina dipendenti SAP"</i>. <img src="..\_images\new\DELETE.GIF" alt="Elimina dipendenti SAP"><br><br>
                                                                Sarà comunque possibile, in ogni momento, associare una Unità organizzativa / Attività lavorativa al dipendente, dalla funzionalità "Anagrafiche Azienda > Lavoratori - Gestione".
                                                            </p>
                                                        </td>
                                                    </tr>
                                                </table>
                                            <%
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
                        </table>
                    </div>
                    </fieldset>
                </td>
            </tr>
        </table>
    </body>
</html>
