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
String generalita = ApplicationConfigurator.LanguageManager.getString("Help.Generalità");
String leIconeFunzionali = ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali");
String leMaschere = ApplicationConfigurator.LanguageManager.getString("Help.Le.maschere");
String leMaschereElenco = ApplicationConfigurator.LanguageManager.getString("Help.Le.maschere.elenco");
String leMaschereDiDettaglioFunzionale = ApplicationConfigurator.LanguageManager.getString("Help.Le.maschere.di.dettaglio.funzionale");
String laParteAlta = ApplicationConfigurator.LanguageManager.getString("Help.La.parte.alta");
String laParteBassa = ApplicationConfigurator.LanguageManager.getString("Help.La.parte.bassa");
String inserimento = ApplicationConfigurator.LanguageManager.getString("Help.Inserimento");
String associazione = ApplicationConfigurator.LanguageManager.getString("Help.Associazione");
String ricerca = ApplicationConfigurator.LanguageManager.getString("Help.Ricerca");
String specializzazione = ApplicationConfigurator.LanguageManager.getString("Help.Specializzazione");
String copiaDa = ApplicationConfigurator.LanguageManager.getString("Copia.da");
String multiaziendalità = ApplicationConfigurator.LanguageManager.getString("Help.Multiaziendalità");
String tornaSu = ApplicationConfigurator.LanguageManager.getString("Help.Torna.su");
String richiamo = ApplicationConfigurator.LanguageManager.getString("Help.Richiamo");

%>

<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuHelp,0) + "</title>");
        </script>
    </head>
    <link rel="stylesheet" href="../_styles/style.css">
    <body>
        <table border="0" style="width:290px">
            <tr>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td align="center" class="title" width="100%">
                                <script>
                                    document.write(getCompleteMenuPath(SubMenuHelp,0));
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
                        <table border="0">
                            <tr>
                                <td >
                                  
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
                                            
                                            <div align="justify" style="width:275px;height:495px;overflow-y: scroll; border:0px solid black;">
                                                <table width="100%" border="0">
                                                    <tr>
                                                        <td>
                                                            <A href="#section1" name="menu_section1"><%=generalita%></A>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <A href="#section2"><%=leIconeFunzionali%></A>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <A href="#section3"><%=leMaschere%></A>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                            <td>
                                                                <table width="100%" border="0">
                                                                    <tr>
                                                                        <td width="10%">
                                                                            &nbsp;
                                                                        </td>
                                                                        <td width="90%">
                                                                            <A href="#section3.1"><%=leMaschereElenco%></A>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="10%">
                                                                            &nbsp;
                                                                        </td>
                                                                        <td width="90%">
                                                                            <A href="#section3.2"><%=leMaschereDiDettaglioFunzionale%></A>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="10%">
                                                                            &nbsp;
                                                                        </td>
                                                                        <td width="90%">
                                                                            <table width="100%" border="0">
                                                                                <tr>
                                                                                    <td width="10%">
                                                                                        &nbsp;
                                                                                    </td>
                                                                                    <td width="90%">
                                                                                        <A href="#section3.2.1"><%=laParteAlta%></A>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td width="10%">
                                                                                        &nbsp;
                                                                                    </td>
                                                                                    <td width="90%">
                                                                                        <A href="#section3.2.2"><%=laParteBassa%></A>
                                                                                    </td>
                                                                                </tr>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <A href="#section4"><%=inserimento%></A>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <A href="#section5"><%=associazione%></A>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <A href="#section6"><%=ricerca%></A>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <A href="#section7"><%=specializzazione%></A>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <A href="#section8"><%=copiaDa%></A>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <A href="#section9"><%=multiaziendalità%></A>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <A href="#section10"><%=richiamo%></A>
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
                                                                        <b><%=generalita%></b>
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
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Generalità.frase.1")%><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Generalità.frase.2")%><br>
                                                                <!--L'Help on Line è disponibile in ogni maschera del Sistema, di cui indica sinteticamente la funzionalità e segnala eventuali accorgimenti specifici.<br>-->
                                                                <br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Generalità.frase.3")%><br>
                                                                <br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Inserimento")%><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Modifica")%><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Cancellazione")%><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Consultazione")%><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Stampa")%><br>
                                                                <br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Generalità.frase.4")%>
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
                                                                        <b><%=leIconeFunzionali%></b>
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
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.frase.1")%><br>
                                                                <br>
                                                                <img src="..\_images\new\NEW.GIF"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nuovo")%>:&nbsp;&nbsp;</b><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.frase.2")%><br>
                                                                <br>
                                                                <img src="..\_images\new\COPY.GIF"><b>&nbsp;<%=copiaDa%>:&nbsp;&nbsp;</b><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.frase.17")%> <%=ApplicationConfigurator.LanguageManager.getString("L.icona")%> <%=ApplicationConfigurator.LanguageManager.getString("Presente.sulla.maschera")%> <script>document.write(getCompleteMenuPath(SubMenuContrattiServizi,0));</script>.<br><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.frase.18")%> <A href="#section8"><%=copiaDa%></A><br>
                                                                <br>
                                                                <img src="..\_images\new\NEW_ASSOCIATE.gif"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nuova.associazione")%>:&nbsp;&nbsp;</b><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.frase.3")%><br>
                                                                <br>
                                                                <img src="..\_images\new\OPEN.GIF"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Apri")%>:&nbsp;&nbsp;</b><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.frase.4")%><br>
                                                                <br>
                                                                <img src="..\_images\new\OPEN_ASSOCIATE.gif"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Modifica.associazione")%>:&nbsp;&nbsp;</b><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.frase.5")%><br>
                                                                <br>
                                                                <img src="..\_images\new\SAVE.GIF"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Salva")%>:&nbsp;&nbsp;</b><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.frase.6")%><br>
                                                                <br>
                                                                <img src="..\_images\new\PRINT.GIF"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.stampa")%>:&nbsp;&nbsp;</b><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.stampa").toLowerCase()%><br>
                                                                <br>
                                                                <img src="..\_images\new\PRINTM2.gif"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.stampa.gruppi")%>:&nbsp;&nbsp;</b><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.frase.7")%><br>
                                                                <br>
                                                                <img src="..\_images\new\SEARCH.GIF"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.stampa.ricerca")%>:&nbsp;&nbsp;</b><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.frase.8")%><br>
                                                                <br>
                                                                <img src="..\_images\new\DETAILS.GIF"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Dettaglio")%>:&nbsp;&nbsp;</b><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.frase.9")%><br>
                                                                <br>
                                                                <img src="..\_images\new\pen3.gif"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Specializza")%>:&nbsp;&nbsp;</b><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.frase.10")%>: <A href="#section7"><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.frase.11")%></A><br>
                                                                <br>
                                                                <img src="..\_images\new\REFRESH.GIF"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Refresh")%>:&nbsp;&nbsp;</b><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.frase.12")%><br>
                                                                <br>
                                                                <img src="..\_images\new\DELETE.GIF"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.elimina")%>:&nbsp;&nbsp;</b><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.frase.13")%><br>
                                                                <br>
                                                                <img src="..\_images\new\DELETE_ASSOCIATE.gif"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Elimina.associazione")%>:&nbsp;&nbsp;</b><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.frase.14")%><br>
                                                                <br>
                                                                <img src="..\_images\new\RETURN.GIF"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Associa")%>:&nbsp;&nbsp;</b><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.frase.15")%><br>
                                                                <br>
                                                                <img src="..\_images\new\EXIT.GIF"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Chiudi")%>:&nbsp;&nbsp;</b><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.frase.16")%><br>
                                                                <br>
                                                                <img src="..\_images\new\HELP.GIF"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.Help.on.line")%>&nbsp;&nbsp;</b><br>
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
                                                                        <b><%=leMaschere%></b>
                                                                    </td>
                                                                    <td width="25%">
                                                                        <A href="#menu_section1" name="section3" valign="top"><%=tornaSu%></A>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <p align="justify">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Le.maschere.frase.1")%>:
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
                                                                        <b><%=leMaschereElenco%></b>
                                                                    </td>
                                                                    <td width="25%">
                                                                        <A href="#menu_section1" name="section3.1" valign="top"><%=tornaSu%></A>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <p align="justify">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Le.maschere.elenco.frase.1")%> <A href="#section2"><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.maschere.elenco.frase.2")%></A>, <%=ApplicationConfigurator.LanguageManager.getString("Help.Le.maschere.elenco.frase.3")%>:<br>
                                                                <br>
                                                                <img src="..\_images\new\NEW.GIF"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nuovo")%></b> <%=ApplicationConfigurator.LanguageManager.getString("Rischio").toLowerCase()%>&nbsp;&nbsp;<br>
                                                                <br>
                                                                <img src="..\_images\new\OPEN.GIF"><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.maschere.elenco.frase.4")%>&nbsp;&nbsp;<br>
                                                                <br>
                                                                <img src="..\_images\new\DELETE.GIF"><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.maschere.elenco.frase.5")%>&nbsp;&nbsp;<br>
                                                                <br>
                                                                <img src="..\_images\new\REFRESH.GIF"><b>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Refresh")%><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.maschere.elenco.frase.6")%>&nbsp;&nbsp;<br>
                                                                <br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Le.maschere.elenco.frase.7")%> <img src="..\_images\new\SEARCH.GIF"> <i><%=ApplicationConfigurator.LanguageManager.getString("Cerca").toLowerCase()%></i><br>(<%=ApplicationConfigurator.LanguageManager.getString("Vai.a").toLowerCase()%> <A href="#section6"><%=ApplicationConfigurator.LanguageManager.getString("La.ricerca")%></A>). <%=ApplicationConfigurator.LanguageManager.getString("Help.Le.maschere.elenco.frase.8")%> <img src="..\_images\new\RETURN.GIF"> <i><%=ApplicationConfigurator.LanguageManager.getString("Associa").toLowerCase()%></i><br>(<%=ApplicationConfigurator.LanguageManager.getString("Vai.a").toLowerCase()%> <A href="#section5"><%=ApplicationConfigurator.LanguageManager.getString("La.associazione")%></A>) <%=ApplicationConfigurator.LanguageManager.getString("Help.Le.maschere.elenco.frase.9")%>.
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
                                                                        <b><%=leMaschereDiDettaglioFunzionale%></b>
                                                                    </td>
                                                                    <td width="25%">
                                                                        <A href="#menu_section1" name="section3.2" valign="top"><%=tornaSu%></A>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <p align="justify">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Le.maschere.di.dettaglio.funzionale.frase.1")%>
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
                                                                        <b><%=laParteAlta%></b>
                                                                    </td>
                                                                    <td width="25%">
                                                                        <A href="#menu_section1" name="section3.2.1" valign="top"><%=tornaSu%></A>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <p align="justify">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.La.parte.alta.frase.1")%><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.La.parte.alta.frase.2")%><br>
                                                                <br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Rischi").toUpperCase()%> > <%=ApplicationConfigurator.LanguageManager.getString("Rischi").toUpperCase()%><br>
                                                                <br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.La.parte.alta.frase.3")%> <img src="..\_images\new\OPEN.GIF"><i><%=ApplicationConfigurator.LanguageManager.getString("Apri").toLowerCase()%></i> <%=ApplicationConfigurator.LanguageManager.getString("Help.La.parte.alta.frase.4")%><br>
                                                                <br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Rischi").toUpperCase()%> > <%=ApplicationConfigurator.LanguageManager.getString("Rischi").toUpperCase()%> >> <%=ApplicationConfigurator.LanguageManager.getString("Gestione").toUpperCase()%><br>
                                                                <br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.La.parte.alta.frase.5")%><br>
                                                                <br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.La.parte.alta.frase.6")%>
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
                                                                        <b><%=laParteBassa%></b>
                                                                    </td>
                                                                    <td width="25%">
                                                                        <A href="#menu_section1" name="section3.2.2" valign="top"><%=tornaSu%></A>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <p align="justify">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.La.parte.bassa.frase.1")%><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.La.parte.bassa.frase.2")%><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.La.parte.bassa.frase.3")%>
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
                                                                        <b><%=inserimento%></b>
                                                                    </td>
                                                                    <td width="25%">
                                                                        <A href="#menu_section1" name="section4" valign="top"><%=tornaSu%></A>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <p align="justify">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("La.icona")%> <img src="..\_images\new\NEW.GIF"> <%=ApplicationConfigurator.LanguageManager.getString("Help.Inserimento.frase.1")%><br>
                                                                <br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Inserimento.frase.2")%><img src="..\_images\new\SAVE.GIF"><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Inserimento.frase.3")%><br>
                                                                <br>
                                                                <%="<img src=\"..\\_images\\new\\RECORD_SAVED_" + ApplicationConfigurator.LanguageManager.getLocale().getLanguage() + ".JPG\">"%><br>
                                                                <br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Inserimento.frase.4")%> <A href="#section3.2.2"><%=ApplicationConfigurator.LanguageManager.getString("Help.Inserimento.frase.5")%></A> <%=ApplicationConfigurator.LanguageManager.getString("Help.Inserimento.frase.6")%>
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
                                                                        <b><%=associazione%></b>
                                                                    </td>
                                                                    <td width="25%">
                                                                        <A href="#menu_section1" name="section5" valign="top"><%=tornaSu%></A>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <p align="justify">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("La.icona")%> <img src="..\_images\new\RETURN.GIF"> <i><%=ApplicationConfigurator.LanguageManager.getString("Associa").toLowerCase()%></i> <%=ApplicationConfigurator.LanguageManager.getString("Help.Associazione.frase.1")%> <i><%=ApplicationConfigurator.LanguageManager.getString("Sistema.della.Sicurezza")%>.</i> <%=ApplicationConfigurator.LanguageManager.getString("Help.Associazione.frase.2")%><br>
                                                                <br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Associazione.frase.3")%> <A href="#section3.2.2"><%=ApplicationConfigurator.LanguageManager.getString("Help.Inserimento.frase.5")%></A>) <%=ApplicationConfigurator.LanguageManager.getString("Help.Associazione.frase.4")%> <img src="..\_images\new\RETURN.GIF"> <%=ApplicationConfigurator.LanguageManager.getString("Help.Associazione.frase.5")%>
                                                                <br><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Associazione.frase.6")%> <img src="..\_images\new\SAVE.GIF"> <%=ApplicationConfigurator.LanguageManager.getString("Help.Associazione.frase.7")%> <img src="..\_images\new\EXIT.GIF">
                                                                <br><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Associazione.frase.8")%> <%=ApplicationConfigurator.LanguageManager.getString("Anagrafiche.azienda").toUpperCase()%> > <%=ApplicationConfigurator.LanguageManager.getString("Lavoratori").toUpperCase()%> <%=ApplicationConfigurator.LanguageManager.getString("Help.Associazione.frase.9")%> <img src="..\_images\new\NEW.GIF"> <%=ApplicationConfigurator.LanguageManager.getString("Help.Associazione.frase.10")%>
                                                                <br><br>
                                                                <%="<img src=\"..\\_images\\new\\tab_lingue_straniere_" + ApplicationConfigurator.LanguageManager.getLocale().getLanguage() + ".jpg\">"%>
                                                                <br><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Associazione.frase.11")%> <img src="..\_images\new\SAVE.GIF"><%=ApplicationConfigurator.LanguageManager.getString("Help.Associazione.frase.12")%> <img src="..\_images\new\EXIT.GIF">
                                                                <br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Associazione.frase.13")%> <%=ApplicationConfigurator.LanguageManager.getString("Anagrafiche.azienda").toUpperCase()%> > <%=ApplicationConfigurator.LanguageManager.getString("Lavoratori").toUpperCase()%>
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
                                                                        <b><%=ricerca%></b>
                                                                    </td>
                                                                    <td width="25%">
                                                                        <A href="#menu_section1" name="section6" valign="top"><%=tornaSu%></A>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <p align="justify">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("La.icona")%> <img src="..\_images\new\SEARCH.GIF"> <i><%=ApplicationConfigurator.LanguageManager.getString("Help.Le.icone.funzionali.stampa.ricerca").toLowerCase()%></i> <%=ApplicationConfigurator.LanguageManager.getString("Help.Ricerca.frase.1")%><br>
                                                                <br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Ricerca.frase.2")%><br>
                                                                <br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Ricerca.frase.3")%> <A href="#section3.1"><%=ApplicationConfigurator.LanguageManager.getString("Help.Ricerca.frase.4")%>.</A> <%=ApplicationConfigurator.LanguageManager.getString("Help.Ricerca.frase.5")%> <img src="..\_images\new\RETURN.GIF"> <i><%=ApplicationConfigurator.LanguageManager.getString("Associa").toLowerCase()%></i>.<br>
                                                                <br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Ricerca.frase.6")%><br>
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
                                                                        <b><%=specializzazione%></b>
                                                                    </td>
                                                                    <td width="25%">
                                                                        <A href="#menu_section1" name="section7" valign="top"><%=tornaSu%></A>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <p align="justify">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("La.icona")%> <img src="..\_images\new\pen3.gif"> <i><%=ApplicationConfigurator.LanguageManager.getString("Help.Specializzazione.frase.1")%></i> <%=ApplicationConfigurator.LanguageManager.getString("Help.Specializzazione.frase.2")%> <A href="#section3.2.2"><%=ApplicationConfigurator.LanguageManager.getString("Help.Inserimento.frase.5")%></A> <%=ApplicationConfigurator.LanguageManager.getString("Help.Specializzazione.frase.3")%><br>
                                                                <br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Specializzazione.frase.4")%><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Specializzazione.frase.5")%><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Specializzazione.frase.6")%><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Specializzazione.frase.7")%> <img src="..\_images\new\pen3.gif">.<br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Specializzazione.frase.8")%><A href="#section2"> <%=ApplicationConfigurator.LanguageManager.getString("Icona.funzionale").toLowerCase()%></A> <%=ApplicationConfigurator.LanguageManager.getString("Help.Specializzazione.frase.9")%><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Specializzazione.frase.10")%> <img src="..\_images\new\pen3.gif">.
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
                                                                        <b><%=copiaDa%></b>
                                                                    </td>
                                                                    <td width="25%">
                                                                        <A href="#menu_section1" name="section8" valign="top"><%=tornaSu%></A>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <p align="justify">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("L.icona")%> <img src="..\_images\new\COPY.GIF"> <%=ApplicationConfigurator.LanguageManager.getString("Presente.sulla.maschera")%> <script>document.write(getCompleteMenuPath(SubMenuContrattiServizi,0));</script> <%=ApplicationConfigurator.LanguageManager.getString("Help.Copia.da.frase.2")%>.<br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Copia.da.frase.1")%><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Copia.da.frase.3")%>.<br>
                                                                <br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Sul.campo")%> <%=ApplicationConfigurator.LanguageManager.getString("Copia.da")%> <img src="..\_images\new\copia_da.jpg"> <%=ApplicationConfigurator.LanguageManager.getString("Help.Copia.da.frase.4")%> <img src="..\_images\new\COPY.GIF">.<br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Copia.da.frase.5")%><br>
                                                                <%="<img src=\"..\\_images\\new\\copia_da_ok_" + ApplicationConfigurator.LanguageManager.getLocale().getLanguage() + ".jpg\">"%><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Copia.da.frase.6")%><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Copia.da.frase.7")%><br>
                                                                <br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Quindi.cliccare.sull.icona")%> <img src="..\_images\new\SEARCH.GIF"> <%=ApplicationConfigurator.LanguageManager.getString("Help.Copia.da.frase.8")%>
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
                                                                        <b><%=multiaziendalità%></b>
                                                                    </td>
                                                                    <td width="25%" valign="top">
                                                                        <A href="#menu_section1" name="section9" valign="top"><%=tornaSu%></A>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <p align="justify">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Multiaziendalita.frase.1")%><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Multiaziendalita.frase.2")%><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Multiaziendalita.frase.3")%><br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Multiaziendalita.frase.4")%><br>
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
                                                            <table>
                                                                
                                                                <tr>
                                                                    <td width="80%">
                                                                        <p align="justify">
                                                                            <b><%=ApplicationConfigurator.LanguageManager.getString("Help.Richiamo.frase.1")%></b>
                                                                                
                                                                        </p>
                                                                    </td>
                                                                    <td width="50%">
                                                                        <p align="justify">
                                                                            <A href="#menu_section1" name="section10" valign="top"><%=tornaSu%></A>
                                                                        </p>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="80%">
                                                            <b><%=ApplicationConfigurator.LanguageManager.getString("Help.Richiamo.frase.2")%></b>
                                                        </td>
                                                            
                                                    </tr>
                                                        
                                                    <tr>
                                                        <td width="125%">
                                                            <p align="justify">
                                                               
                                                              <%=ApplicationConfigurator.LanguageManager.getString("Help.Richiamo.frase.3")%>
                                                            </p>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <p align="justify">
                                                                <u>
                                                                    <li><p align="justify"> <%=ApplicationConfigurator.LanguageManager.getString("Help.Caricamento")%></p></li>
                                                                </u>
                                                            </p>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <p align="justify">
                                                                <img src="..\_images\new\File_2.gif"><br><br>
                                                            </p>
                                                        </td>
                                                    </tr>
                                                    
                                                    <tr>
                                                        <td>
                                                            <p align="justify">
                                                                <u>
                                                                    <li><p align="justify"> <%=ApplicationConfigurator.LanguageManager.getString("Help.Associazione")%></p></li>
                                                                </u>
                                                            </p>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <p align="justify">
                                                                <img align="top" src="..\_images\new\FileLink_2.gif"><br><br>
                                                            </p>
                                                        </td>
                                                    </tr>
                                                    
                                                    <tr>
                                                        <td>
                                                            <p align="justify">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Richiamo.frase.4")%><br>
                                                                <br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Richiamo.frase.5")%><br>
                                                                <br>
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Help.Richiamo.frase.6")%><br>
                                                            </p>
                                                        </td>
                                                    </tr>
                                                </table>
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
