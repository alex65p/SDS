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

<%@ include file="../WEB/_include/Global.jsp" %>
<%@ page import="s2s.luna.conf.ApplicationConfigurator" %>
<%
    // Inizializza l'ambiente per poter eseguire correttamete il "Sistema della Sicrezza".
    // Variabili, gestori del linguaggio, parametri di configurazione, ecc.
    ApplicationConfigurator.inizializeApplicationEnvironment((HttpServletRequest) request);
    String LOGIN_PAGE = ApplicationConfigurator.getApplicationURI() + "_security/logon.jsp";
%>
<html>
<head>
    <title><%=APP_WINDOW_TITLE%></title>
</head>
<body> 
<script type="text/javascript" language="JavaScript1.2">
	var wShow;
	var _scr_wid = screen.width-10;
	var _scr_heh = screen.height-55;
	wShow=window.open("<%=LOGIN_PAGE%>?<%=request.getQueryString()%>" ,"_Window"
            ,
            "toolbar=no," +             // la barra degli strumenti del browser (con i pulsanti "indietro", "avanti")
            "location=no," +            // la barra degli indirizzi del browser
            "scrollbars=no," +          // le barre di scorrimento laterali
            "resizable=yes," +          // indica se la finestra può essere ridimensionata o no
            "status=yes," +             // la barra di stato (quella in basso)
            "menubar=no," +             // la barra del menu (quella con scritto "file", "modifica", ecc.)
            "width="+_scr_wid+ "," +    // la larghezza della finestra in pixel
            "height="+_scr_heh+"," +    // l'altezza della finestra in pixel
            "top=0," +                  // la distanza dal lato superiore del monitor
            "left=0"                    // la distanza dalla sinistra del monitor
            );
	if (window.parent) window.parent.close();
	if (wShow!=null) wShow.focus();
</script>
<br>
</body></html>
