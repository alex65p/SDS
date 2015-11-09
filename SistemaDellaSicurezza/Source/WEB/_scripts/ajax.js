/**   ======================================================================== */
/**                                                                            */
/** @copyright Copyright (c) 2010-2015, S2S s.r.l. */
/** @license   http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2 */
/** @version   6.0  */
/** This file is part of SdS - Sistema della Sicurezza  . */
/** SdS - Sistema della Sicurezza   is free software: you can redistribute it and/or modify */
/** it under the terms of the GNU General Public License as published by  */
/** the Free Software Foundation, either version 3 of the License, or  */
/** (at your option) any later version.  */

/** SdS - Sistema della Sicurezza  is distributed in the hope that it will be useful, */
/** but WITHOUT ANY WARRANTY; without even the implied warranty of */
/** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the */
/** GNU General Public License for more details. */

/** You should have received a copy of the GNU General Public License */
/** along with SdS - Sistema della Sicurezza .  If not, see <http://www.gnu.org/licenses/gpl-2.0.html>  GNU Public License v.2 */
/**                                                                            */
/**   ======================================================================== */

/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

// funzione per assegnare l'oggetto XMLHttpRequest
// compatibile con i browsers più recenti e diffusi
function assegnaXMLHttpRequest() {
    // lista delle variabili locali
    var
    // variabile di ritorno, nulla di default
    XHR = null,

    // informazioni sul nome del browser
    browserUtente = navigator.userAgent.toUpperCase();

    // browser standard con supporto nativo
    // non importa il tipo di browser
    if(typeof(XMLHttpRequest) == "function" || typeof(XMLHttpRequest) == "object")
        XHR = new XMLHttpRequest();

    // browser Internet Explorer
    // è necessario filtrare la versione 4
    else if(
        window.ActiveXObject &&
        browserUtente.indexOf("MSIE 4") < 0
        ) {

        // la versione 6 di IE ha un nome differente
        // per il tipo di oggetto ActiveX
        if(browserUtente.indexOf("MSIE 5") < 0)
            XHR = new ActiveXObject("Msxml2.XMLHTTP");

        // le versioni 5 e 5.5 invece sfruttano lo stesso nome
        else
            XHR = new ActiveXObject("Microsoft.XMLHTTP");
    }

    return XHR;
}

// Esegue la pagina (uri) passata in input e torna il risultato della 
// chiamata ajax nell'oggetto html (elemento) passato in input.
function eseguiChiamataAjax(uri, elemento, asincrono){
    
    // Imposto la chiamata ajax come asincrona per default.
    if (asincrono == null) 
        asincrono = true;
    
    // variabili di funzione
    var
    // assegnazione oggetto XMLHttpRequest
    ajax = assegnaXMLHttpRequest();
    // se l'oggetto XMLHttpRequest non è nullo
    if(ajax) {

        // impostazione richiesta asincrona in GET
        // del file specificato
        ajax.open ("GET", uri, asincrono);

        // rimozione dell'header "connection" come "keep alive"
        ajax.setRequestHeader("connection", "close");

        // impostazione controllo e stato della richiesta
        ajax.onreadystatechange = function() {

            // verifica dello stato
            if(ajax.readyState == 4 /*COMPLETATO*/) {
                // verifica della risposta da parte del server
                if(ajax.status == 200 /*OK*/){
                    // operazione avvenuta con successo
                    elemento.innerHTML = ajax.responseText;
                } else {
                    // errore di caricamento
                    elemento.innerHTML = arraylng["MSG_0203"] + "<br />";
                    elemento.innerHTML += arraylng["MSG_0204"] + statusText[ajax.status];
                }
            }
        }

        ajax.send(null);
    }
}
