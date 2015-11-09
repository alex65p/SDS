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
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="s2s.luna.util.DBInfo"%>
<%@ page import="s2s.luna.util.EnvironmentInfo"%>
<%@ page import="s2s.utils.text.StringManager" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<%@ include file="../_include/Global.jsp" %>
<%!    String BuildMailString(DBInfo DB, EnvironmentInfo Environment) throws Exception{
        String newLineHTMLcode="%0D%0A";
        String returnString =
                "subject=Sistema della Sicurezza - "
                + ApplicationConfigurator.CUSTOMER_NAME + " - "
                + ApplicationConfigurator.LanguageManager.getString("Richiesta.supporto")
                + " &amp;body="
                + ApplicationConfigurator.LanguageManager.getString("Inserire.qui.la.propria.richiesta").toUpperCase()
                + newLineHTMLcode + newLineHTMLcode
                + ApplicationConfigurator.LanguageManager.getString("Dati.per.il.supporto") + newLineHTMLcode
                + "---------------------------" + newLineHTMLcode
                + ApplicationConfigurator.LanguageManager.getString("Versione.del.software") + ": "
                + APP_VERSION + newLineHTMLcode
                + ApplicationConfigurator.LanguageManager.getString("Versione.del.database") + ": "
                + APP_DB_VERSION + newLineHTMLcode
                + ApplicationConfigurator.LanguageManager.getString("Profilo") + ": "
                + ApplicationConfigurator.getProfile().getDesc() + newLineHTMLcode
                + ApplicationConfigurator.LanguageManager.getString("Sistema.operativo") + ": "
                + System.getProperty("os.name") + " " + System.getProperty("os.version") + " " + System.getProperty("os.arch") + newLineHTMLcode
                + ApplicationConfigurator.LanguageManager.getString("Database") + ": "
                + DB.getDatabaseProductName() + " " + DB.getDatabaseProductVersion() + newLineHTMLcode
                + ApplicationConfigurator.LanguageManager.getString("Application.server") + ": "
                + getServletContext().getServerInfo() + newLineHTMLcode
                + ApplicationConfigurator.LanguageManager.getString("Java.runtime.environment") + ": "
                + System.getProperty("java.version") + newLineHTMLcode
                + ApplicationConfigurator.LanguageManager.getString("Variabili.di.ambiente") + ": "
                + "ExternalFilesProperties (" + Environment.getEnvProperty("java:comp/env/ExternalFilesProperties") + "), "
                + "ExternalFilesPath (" + Environment.getEnvProperty("java:comp/env/ExternalFilesPath") + ")" + newLineHTMLcode;
                return returnString;
    }

    String BuildHTML4Modulo(MODULES modulo) {
        return "<tr><td><li><a href=\"#\" title=\"" + StringManager.prepare(modulo.getDesc()) + "\">"
                + modulo.getName()
                + "</a></li></td></tr>";
    }
%>
<%
            DBInfo DBInfo = new DBInfo();
            EnvironmentInfo environmentManager = new EnvironmentInfo();
%>

<html>
    <head>
        <script type="text/javascript" src="ABOUT.js"></script>
        <script type="text/javascript">
            function BuildMailString(){
                var mailString = '<%=BuildMailString(DBInfo, environmentManager)%>';
                var newLineHTMLcode = '%0D%0A';
                mailString += newLineHTMLcode
                    + '<%=ApplicationConfigurator.LanguageManager.getString("Browser.internet")%>: '
                    + navigator.appName + navigator.appVersion + newLineHTMLcode
                    + '<%=ApplicationConfigurator.LanguageManager.getString("Cookies.abilitati")%>: '
                    + navigator.cookieEnabled + newLineHTMLcode
                    + '<%=ApplicationConfigurator.LanguageManager.getString("Impostazioni.dello.schermo")%>: '
                    + screen.width + ' x ' + screen.height + ' (' + screen.colorDepth + ' bit)';
                return mailString;
            }
            window.dialogWidth="500px";
            window.dialogHeight="430px";
            document.write("<title>" + getCompleteMenuPath(SubMenuHelp,1) + "</title>");
        </script>        
    <link rel="stylesheet" href="../_styles/style.css">
    </head>
    <body>
        <table border="0" width='100%'>
            <tr>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0"  width='100%'>
                        <tr>
                            <td align="center" class="title" width="100%">
                                <script type="text/javascript">
                                    document.write(getCompleteMenuPath(SubMenuHelp,1));
                                </script>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table border="0" width="100%">
                        <tr>
                            <td valign="center" align="center">
                                <img border="0" src="../_images/nostre img/626Logo.gif" alt="Sistema della Sicurezza" width="150" height="100">
                            </td>
                            <td valign="top">
                                <table width="100%" border="0">
                                    <tr>
                                        <td>
                                            <b>Sistema della Sicurezza</b>
                                        </td>
                                        <td align="right">
                                            <a href="#" id="altreInfoLabelID" 
                                               onclick="viewInfo(document.getElementById('altreInfoID').style.display=='none');"><%=ApplicationConfigurator.LanguageManager.getString("Informazioni.aggiuntive")%></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <hr>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap>
                                            <b><%=ApplicationConfigurator.LanguageManager.getString("Versione.del.software")%>:</b>
                                        </td>
                                        <td align="left">
                                            <b><%=APP_VERSION%></b>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap>
                                            <%=ApplicationConfigurator.LanguageManager.getString("Versione.del.database")%>:
                                        </td>
                                        <td align="left">
                                            <%=APP_DB_VERSION%>    
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap>
                                            <%=Security.isConsultant()
                                                    ?ApplicationConfigurator.LanguageManager.getString("Consulente.connesso")
                                                    :ApplicationConfigurator.LanguageManager.getString("Utente.connesso")%>    
                                        </td>
                                        <td align="left">
                                            <%=Security.getUserPrincipal().getName()%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=ApplicationConfigurator.LanguageManager.getString("Cliente")%>:
                                        </td>
                                        <td align="left">
                                            <%=ApplicationConfigurator.CUSTOMER_NAME%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=ApplicationConfigurator.LanguageManager.getString("Azienda")%>:
                                        </td>
                                        <td align="left">
                                            <%=Security.getAziendaNameEx()%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=ApplicationConfigurator.LanguageManager.getString("Profilo")%>:
                                        </td>
                                        <td align="left">
                                            <a href="#"
                                               onclick="viewListaModuli(document.getElementById('listaModuliID').style.display=='none');"><%=ApplicationConfigurator.getProfile().getDesc()%></a>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td rowspan="4" valign="top" id="altreInfoID" style="display:none">
                                <fieldset>
                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Informazioni.aggiuntive")%></legend>
                                    <div style="width:590px; height:365px; overflow:auto;">
                                        <table width="100%" border="0">
                                            <tr>
                                                <td>
                                                    <table border="0" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td colspan="2" valign="top">
                                                                <b><u><%=ApplicationConfigurator.LanguageManager.getString("Sistema.operativo")%></u></b>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Nome")%>:
                                                            </td>
                                                            <td>
                                                                <%=System.getProperty("os.name")%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Versione")%>:
                                                            </td>
                                                            <td>
                                                                <%=System.getProperty("os.version")%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Architettura")%>:
                                                            </td>
                                                            <td>
                                                                <%=System.getProperty("os.arch")%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2" valign="top">
                                                                <b><u><%=ApplicationConfigurator.LanguageManager.getString("Database")%></u></b>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Produttore")%>:
                                                            </td>
                                                            <td align="left">
                                                                <%=DBInfo.getDatabaseProductName()%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Versione")%>:
                                                            </td>
                                                            <td align="left">
                                                                <%=DBInfo.getDatabaseProductVersion()%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("URL")%>:
                                                            </td>
                                                            <td align="left">
                                                                <%=DBInfo.getURL()%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Database.nome.dello.schema")%>:
                                                            </td>
                                                            <td align="left">
                                                                <%=DBInfo.getSchemaName()%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Database.utente.connesso")%>:&nbsp;
                                                            </td>
                                                            <td align="left">
                                                                <%=DBInfo.getUserName()%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2" valign="top">
                                                                <b><u><%=ApplicationConfigurator.LanguageManager.getString("Application.server")%></u></b>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Server")%>:
                                                            </td>
                                                            <td align="left">
                                                                <%=getServletContext().getServerInfo()%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2" valign="top">
                                                                <b><u><%=ApplicationConfigurator.LanguageManager.getString("Java.runtime.environment")%></u></b>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Versione")%>:
                                                            </td>
                                                            <td align="left">
                                                                <%=System.getProperty("java.version")%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2" valign="top">
                                                                <b><u><%=ApplicationConfigurator.LanguageManager.getString("Browser.internet")%></u></b>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Nome.in.codice")%>:
                                                            </td>
                                                            <td align="left">
                                                                <script type="text/javascript">
                                                                    document.write(navigator.appCodeName);
                                                                </script>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Nome")%>:
                                                            </td>
                                                            <td align="left">
                                                                <script type="text/javascript">
                                                                    document.write(navigator.appName);
                                                                </script>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Versione")%>:
                                                            </td>
                                                            <td align="left">
                                                                <script type="text/javascript">
                                                                    document.write(navigator.appVersion);
                                                                </script>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Cookies.abilitati")%>:
                                                            </td>
                                                            <td align="left">
                                                                <script type="text/javascript">
                                                                    document.write(navigator.cookieEnabled);
                                                                </script>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Piattaforma")%>:
                                                            </td>
                                                            <td align="left">
                                                                <script type="text/javascript">
                                                                    document.write(navigator.platform);
                                                                </script>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("User.agent.header")%>:
                                                            </td>
                                                            <td align="left">
                                                                <script type="text/javascript">
                                                                    document.write(navigator.userAgent);
                                                                </script>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2" valign="top">
                                                                <b><u><%=ApplicationConfigurator.LanguageManager.getString("Impostazioni.dello.schermo")%></u></b>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Risoluzione")%>:
                                                            </td>
                                                            <td align="left">
                                                                <script type="text/javascript">
                                                                    document.write(screen.width + ' x ' + screen.height);
                                                                </script>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Profondita.colore")%>:
                                                            </td>
                                                            <td align="left">
                                                                <script type="text/javascript">
                                                                    document.write(screen.colorDepth + " bit");
                                                                </script>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2" valign="top">
                                                                <b><u><%=ApplicationConfigurator.LanguageManager.getString("Variabili.di.ambiente")%></u></b>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                ExternalFilesProperties:&nbsp;
                                                            </td>
                                                            <td align="left">
                                                                <%=environmentManager.getEnvProperty("java:comp/env/ExternalFilesProperties")%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                ExternalFilesPath:
                                                            </td>
                                                            <td align="left">
                                                                <%=environmentManager.getEnvProperty("java:comp/env/ExternalFilesPath")%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <hr>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table border="0" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td colspan="2" valign="top">
                                                                <b><u><%=ApplicationConfigurator.LanguageManager.getString("Altre.proprieta.di.sistema")%></u></b>
                                                            </td>
                                                        </tr>
                                                        <%
                                                                    Properties props = System.getProperties();
                                                                    String propertyName = "";
                                                                    for (Enumeration plist = props.keys(); plist.hasMoreElements();) {
                                                                        propertyName = (String) plist.nextElement();
                                                                        if (!(propertyName.equals("os.name")
                                                                                || propertyName.equals("os.version")
                                                                                || propertyName.equals("os.arch")
                                                                                || propertyName.equals("java.version"))) {
                                                        %>
                                                        <tr>
                                                            <td valign="top">
                                                                <%=propertyName%>:
                                                            </td>
                                                            <td align="left">
                                                                <%=(propertyName.toLowerCase().indexOf("path") != -1) ? System.getProperty(propertyName).replaceAll(":", "<br>") : System.getProperty(propertyName)%>
                                                            </td>
                                                        </tr>
                                                        <%      }
                                                                    }
                                                        %>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </fieldset>
                            </td>
                            <td rowspan="4" valign="top" id="listaModuliID" style="display:none">
                                <fieldset>
                                    <legend>Lista moduli</legend>
                                    <div style="width:300px; height:365px; overflow:auto">
                                        <table width="100%" border="0" cellpadding="2" cellspacing="2">
                                            <tr>
                                                <td>
                                                    (Posizionati sul singolo modulo per visualizzarne la descrizione dettagliata)
                                                </td>
                                            </tr>
                                            <tr style="display: block;">
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <ol>
                                                <%
                                                            Collection<MODULES> listaModuli = ApplicationConfigurator.getProfileModules();
                                                            for (MODULES Modulo : listaModuli) {
                                                                out.println(BuildHTML4Modulo(Modulo));
                                                            }
                                                %>
                                            </ol>
                                        </table>
                                    </div>
                                </fieldset>
                            </td>
                            <td rowspan="4" valign="top" id="listaCreditsID" style="display:none">
                                <fieldset>
                                    <legend>Credits</legend>
                                    <div style="width:300px; height:365px; overflow:auto">
                                        <table width="100%" border="0" cellpadding="4" cellspacing="4">
                                            <tr>
                                                <td>
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Hanno.collaborato")%>:
                                                </td>
                                            </tr>
                                            <!--tr style="display: block;">
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr-->
                                            <ol>
                                                <tr><td><li>Marcello Arrabito</li></td></tr>
                                                <tr><td><li>Maria Beatrice Di Pietro</li></td></tr>
                                                <tr><td><li>Alessandro Berti</li></td></tr>
                                                <tr><td><li>Laura Bonventi</li></td></tr>
                                                <tr><td><li>Sara Bucci</li></td></tr>
                                                <tr><td><li>Alessandro Carosi</li></td></tr>
                                                <tr><td><li>Agnese Cavola</li></td></tr>
                                                <tr><td><li>Gabriele Costantini</li></td></tr>
                                                <tr><td><li>Massimiliano D'Annucci</li></td></tr>
                                                <tr><td><li>Raffaella Danzi</li></td></tr>
                                                <tr><td><li>Isabella de Silva</li></td></tr>
                                                <tr><td><li>Alessandro Di Cristanziano</li></td></tr>
                                                <tr><td><li>Adamo Ferrazzo</li></td></tr>
                                                <tr><td><li>Viviana Ferro</li></td></tr>
                                                <tr><td><li>Gianfranco Fragomeni</li></td></tr>
                                                <tr><td><li>Mauro Gazzelloni</li></td></tr>
                                                <tr><td><li>Dario Massaroni</li></td></tr>
                                                <tr><td><li>Alessandro Mauro</li></td></tr>
                                                <tr><td><li>Gabriele Mengoli</li></td></tr>
                                                <tr><td><li>Pierpaolo Pacione</li></td></tr>
                                                <tr><td><li>Cosmo Pepe</li></td></tr>
                                                <tr><td><li>Stefano Picozzi</li></td></tr>
                                                <tr><td><li>Cinzia Plateroti</li></td></tr>
                                                <tr><td><li>Giancarlo Servadei</li></td></tr>
                                                <tr><td><li>Paolo Spadaccia</li></td></tr>
                                                <tr><td><li>Antonella Spisto</li></td></tr>
                                                <tr><td><li>Natalia Tramontano</li></td></tr>
                                                <tr><td><li>Alessandro Trosino</li></td></tr>
                                                <tr><td><li>Nunzia Vaiano</li></td></tr>
                                                <tr><td><li>Chiara Vultaggio</li></td></tr>
                                            </ol>
                                        </table>
                                    </div>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <hr>
                            </td>
                        </tr>
                        <tr>
                            <td valign="center" align="center">
                                <img border="0" src="../_images/nostre img/S2S_logo_white_small-2.png" width="132" height="102" alt="S2S s.r.l. Open Software">
                            </td>
                            <td valign="top">
                                <table width="100%" border="0">
                                    <tr>
                                        <td colspan="2">
                                            Via Salaria, 292
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            00199 Roma
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <a href="http://www.s2sprodotti.it" title="http://www.s2sprodotti.it" >S2S s.r.l.</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Tel.
                                        </td>
                                        <td align="left">
                                            +39 06 88805551 
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <script type="text/javascript">
                                                document.write(
                                                    '<a  title="supporto@s2sprodotti.it" href="mailto:supporto@s2sprodotti.it?' 
                                                    + BuildMailString() 
                                                    + '"><%=ApplicationConfigurator.LanguageManager.getString("Supporto")%></a>');
                                            </script>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <a href="mailto:pepe@s2sprodotti.it"  title="pepe@s2sprodotti.it"><%=ApplicationConfigurator.LanguageManager.getString("Supporto.commerciale")%></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <a href="#"
                                               onclick="viewCredits(document.getElementById('listaCreditsID').style.display=='none')"><%=ApplicationConfigurator.LanguageManager.getString("Credits")%></a>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <hr>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </body>
</html>
