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
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuGestione, 2) + "</title>");
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
                                    document.write(getCompleteMenuPathHelp(SubMenuGestione, 2));
                                </script>
                            </td>
                        </tr>
                        <tr>
                            <td width="35"><img id='btnClose' onclick="window.returnValue = 'CANCEL';
                                    window.close();" title='<%=ApplicationConfigurator.LanguageManager.getString("Uscita")%>' src='../_images/new/EXIT.GIF'></td>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <fieldset style="height:490px">
                        <table width="100%" height="100%" border="0">
                            <tr>
                                <td valign="top">
                                    <div align="justify" style="width:285px;height:465px;overflow-y: scroll; border:0px solid black;">
                                    <%  String HelpFrom = request.getParameter("HelpFrom");
                                        if (HelpFrom != null) {
                                            if (HelpFrom.equals("VIEW")) {
                                                out.println("LISTA INIZIALE");
                                            } else if (HelpFrom.equals("SEARCH")) {
                                                out.println("FUNZIONE DI RICERCA E ASSOCIAZIONE");
                                            } else if (HelpFrom.equals("FORM")) {
                                                %>
                                                <!--
                                                    HELP GENERALE
                                                -->
                                                <table width="100%" height="100%" border="0">
                                                    <tr>
                                                        <td valign="top">
                                                            <p align="justify">
                                                                La pagina di opzioni gestisce tutte quelle configurazioni del "Sistema della Sicurezza" relative al singolo utente.
                                                                <br><br>
                                                                Quando necessario, al fianco di ogni singola opzione, sarà presente, tra le altre, un ulteriore icona di "Help contestuale" (<img src="../_images/context-help.png">) che fornirà indicazioni "specifiche".
                                                            </p>
                                                            <p align="justify" style="text-decoration:underline;">
                                                                <b>NB</b>    
                                                            </p>
                                                            <p align="justify">
                                                                L'impostazione di alcune opzioni utente (es. "Percorso eseguibile di Firefox") può generare degli avvisi di protezione durante l'utilizzo del "Sistema della Sicurezza", come quello riportato di seguito:
                                                                <br>
                                                                <img src="../_images/activex-protection-message.png">
                                                                <b>E' necessario rispondere "SI" a tali richieste.</b> 
                                                                <br><br>
                                                                Nel caso accidentalmente si selezionasse il "NO" è sufficiente uscrire (Effettuare il <b>Logout</b>) dal "Sistema della Sicurezza" ed effettuare nuovamente l'accesso.
                                                                <br>
                                                                A questo punto l'avviso di protezione verrà ripresentato e sarà possibile rispondere in maniera affermativa.
                                                                <br><br>
                                                                E' anche possibile registrare una tantum ed in maniera definitiva tale risposta affermativa andando a modificare le impostazioni di protezione del browser "Internet Explorer".
                                                                <br>
                                                                Per questa modifica consultare il proprio reparto informativo.
                                                            </p>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                                <%
                                            } else if (HelpFrom.equals("ASSOCIATE")) {
                                                out.println("TAB FOLDER DI ASSOCIAZIONE INFORMAZIONI");
                                            } else if (HelpFrom.equals("CONTEXT-FIREFOX")) {
                                                %>
                                                <!--
                                                    HELP CONTESTUALE ("Percorso eseguibile di Firefox")
                                                -->
                                                <table width="100%" height="100%" border="0">
                                                    <tr>
                                                        <td valign="top">
                                                            <p align="justify">
                                                                <b>Percorso eseguibile di Firefox</b>
                                                            </p>
                                                            <p align="justify">
                                                                Questa opzione indica al "Sistema della Sicurezza" dove si trova il file eseguibile del browser "Firefox".
                                                            </p>
                                                            <p align="justify" style="font-style:italic;">
                                                                Tale browser è utilizzato per la navigazione e l'utilizzo del modulo di <b>"Safety Intelligence"</b> integrato col "Sistema della Sicurezza". Questa opzione pertanto deve essere correttamente impostata per il funzionamento di detto modulo.
                                                            </p>
                                                            <p align="justify">
                                                                <b>Per impostare questa opzione eseguire nell'ordine riportato i seguenti passi:</b>
                                                            </p>
                                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <p align="justify" style="font-style:italic; text-decoration:underline;">
                                                                            <b>Download del browser Firefox</b>
                                                                        </p>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td valign="top">
                                                                        <b>1</b>&nbsp;-&nbsp;
                                                                    </td>
                                                                    <td>
                                                                        <p align="justify">
                                                                            Avviare il download del browser Firefox attraverso l'apposita icona <img src="../_images/download.png">.
                                                                            <br><br>
                                                                            Il browser "Internet Explorer" richiederà il percorso nel quale scaricare il file attraverso questa finestra (clicca per ingrandire):
                                                                            <br><br>
                                                                            <a href="../_images/saveAs.png"><img src="../_images/saveAsSmall.png" alt="Ingrandisci"></a>
                                                                        </p>
                                                                        <p align="justify" style="text-decoration:underline;">
                                                                            <b>NB</b>    
                                                                        </p>
                                                                        <p align="justify">
                                                                            E' possibile che la finestra di download di "Internet Explorer", seppur aperta, resti iconizzata (e lampeggiante) nella barra delle applicazioni di Windows.
                                                                            <br>
                                                                            In questo caso è sufficiente, per mostrarla, cliccare su di essa nella barra delle applicazioni.
                                                                        </p>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td valign="top">
                                                                        <b>2</b>&nbsp;-&nbsp;
                                                                    </td>
                                                                    <td>
                                                                        <p align="justify">
                                                                            Selezionare la cartella nella quale scaricare il browser Firefox <b>attraverso la voce "Salva con nome"</b>, ad esempio "Documenti" sul disco "D", e premere il pulsante <b>"Salva"</b> (clicca per ingrandire):
                                                                            <br><br>
                                                                            <a href="../_images/saveFolder.png"><img src="../_images/saveFolderSmall.png" alt="Ingrandisci"></a>
                                                                            <br><br>
                                                                            Al termine dell'operazione chiudere la finestra di download tramite il pultante <b>"Chiudi"</b> 
                                                                        </p>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <p align="justify" style="font-style:italic; text-decoration:underline;">
                                                                            <b>Estrazione del browser Firefox</b>
                                                                        </p>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td valign="top">
                                                                        <b>3</b>&nbsp;-&nbsp;
                                                                    </td>
                                                                    <td>
                                                                        <p align="justify">
                                                                            Tramite gli strumenti di gestione risorse di Windows (lasciando aperta questa finestra di opzioni), andare nella cartella dove si è deciso di scaricare il browser Firefox, nel nostro esempio D:\Documenti.
                                                                        </p>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td valign="top">
                                                                        <b>4</b>&nbsp;-&nbsp;
                                                                    </td>
                                                                    <td>
                                                                        <p align="justify">
                                                                            Decomprimere il file di Firefox scaricato <b>"Firefox-Portable-3.5.19-for-BO-XI-3.1.zip" usando l'opzione "Estrai qui"</b>
                                                                            <br><br>
                                                                            Per eseguire tale operazione può essere usato un qualsiasi programma che legga tale formato compresso, es. <a href="http://www.winzip.com/">WinZip</a> o <a href="http://www.winrar.it/">WinRar</a>.
                                                                            <br><br>
                                                                            <a href="../_images/fileExtract.png"><img src="../_images/fileExtractSmall.png" alt="Ingrandisci"></a>
                                                                        </p>    
                                                                        <p align="justify" style="font-style:italic;">
                                                                            (Al termine dell'operazione di estrazione il file "Firefox-Portable-3.5.19-for-BO-XI-3.1.zip" può essere cancellato)
                                                                        </p>
                                                                        <p align="justify">
                                                                            L'operazione di estrazione, se eseguita nelle modalità descritte, genera nel percorso scelto (nel nostro esempio "D:\Documenti") una cartella dal nome <b>"Firefox-Portable-3.5.19-for-BO-XI-3.1"</b>. 
                                                                        </p>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td valign="top">
                                                                        <b>5</b>&nbsp;-&nbsp;
                                                                    </td>
                                                                    <td>
                                                                        <p align="justify">
                                                                            Chiudere la cartella dove si è estratto Firefox (nel nostro esempio "D:\Documenti") e tornare alla pagina di opzioni del "Sistema della Sicurezza".
                                                                        </p>    
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <p align="justify" style="font-style:italic; text-decoration:underline;">
                                                                            <b>Impostazione dell'opzione<br>"Percorso eseguibile di Firefox"</b>
                                                                        </p>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td valign="top">
                                                                        <b>6</b>&nbsp;-&nbsp;
                                                                    </td>
                                                                    <td>
                                                                        <p align="justify">
                                                                            Aprire, attraverso il tasto "Sfoglia", il percorso nel quale è stato estratto Firefox, nel nostro esempio <b>"D:\Documenti\Firefox-Portable-3.5.19-for-BO-XI-3.1"</b>.
                                                                        </p>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td valign="top">
                                                                        <b>7</b>&nbsp;-&nbsp;
                                                                    </td>
                                                                    <td>
                                                                        <p align="justify">
                                                                            Selezionare file <b>"FirefoxPortable.exe"</b> e premere il pulsante "Apri".
                                                                            <br><br>
                                                                            <a href="../_images/fileSelect.png"><img src="../_images/fileSelectSmall.png" alt="Ingrandisci"></a>
                                                                        </p>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td valign="top">
                                                                        <b>8</b>&nbsp;-&nbsp;
                                                                    </td>
                                                                    <td>
                                                                        <p align="justify">
                                                                            Allinterno della maschera delle opzioni, premere il pulsante "Salva".
                                                                        </p>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <p align="justify" style="text-decoration:underline;">
                                                                <b>NB</b>    
                                                            </p>
                                                            <p align="justify">
                                                                Il download di Firefox è un operazione da effettuare una tantum ma, ove necessario, ripetibile.
                                                                <br><br>
                                                                Se necessario è anche possibile modificare il valore della proprietà "Percorso eseguibile di Firefox" eliminandola tramite il pulsante <img src="../_images/erase-context.png"> e reimpostandola.
                                                            </p>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <%
                                            } else {
                                                out.println("PROVENIENZA NON RICONOSCIUTA O NON IMPOSTATA: " + HelpFrom);
                                            }
                                        } else {
                                        }%>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
        </table>
    </body>
</html>
