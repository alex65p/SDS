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
var g_objCurrentRow=null;

function checkRiaperturaInfortuni(uri, elemento){
    // variabili di funzione
    var
    // assegnazione oggetto XMLHttpRequest
    ajax = assegnaXMLHttpRequest();
    // se l'oggetto XMLHttpRequest non è nullo
    if(ajax) {

        // impostazione richiesta asincrona in GET
        // del file specificato
        ajax.open ("GET", uri, true);
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
                    selezionaRiga();
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

function g_OnRowClick_Form(tr){
    infRel = document.getElementById("ID_COD_REL_INO");
    if(g_objCurrentRow!=null){
        if (g_objCurrentRow.id == tr.id){
            if (tr.className=="VIEW_TR"){
                tr.className="dataTrSelected";
                infRel.value = tr.id;
            } else {
                tr.className="VIEW_TR";
                infRel.value = "0";
            }
        } else {
            g_objCurrentRow.className="VIEW_TR";
            tr.className="dataTrSelected";
            infRel.value = tr.id;
        }
    } else {
        tr.className="dataTrSelected";
        infRel.value = tr.id;
    }
    g_objCurrentRow=tr;
}

function selezionaRiga() {
    var infRel = document.getElementById('ID_COD_REL_INO');
    var tr = document.getElementById(infRel.value);
    if (tr != null){
        tr.click();
        self.location.hash=infRel.value;
    } else {
        infRel.value="0";
    }
}

function setGiornoLavorativo(){
    // Estraggo la data evento.
    var dataEvento = stringToDate(document.getElementById("DAT_EVE_INO").value);
    // Estraggo la combo 'Giorno Lavorativo'.
    var giornoLavorativo = document.getElementById("GOR_LAV_INO_ID");
    // Estraggo il campo input 'Giorno Lavorativo'.
    var giornoLavorativoTxt = document.getElementById("GOR_LAV_INO_TXT_ID");

    if (dataEvento != null){
        giornoLavorativo.value = dataEvento.getDay();
        giornoLavorativoTxt.value = getDayOfWeek(giornoLavorativo.value);
    } else {
        giornoLavorativo.value = '-1';
        giornoLavorativoTxt.value = '';
    }
}

// Restituisce la differenza in giorni tra due date
function giorni_differenza(data1,data2){
    document.getElementById('GOR_ASZ').value = getDifference2Days(data1,data2);   
}
function giorni_differenza_CAN(data1,data2){
    document.getElementById('GOR_ASZ').value = getDifference2Days_CAN(data1,data2);
}

// Mette a confornto le seguenti date: data comunicazione infortunio, data evento, data inizio assenza
// e data fine assenza e ne verifica la coerenza, restituendo in caso di errore gli opportuni messaggi.
function data_valida(called4Save){
    var currentDate = getCurrentDate();
    var data1=document.getElementById('DAT_COM_INO').value;
    var data2=document.getElementById('DAT_EVE_INO').value;
    var data3=document.getElementById('DAT_INZ_ASZ_LAV').value;
    var data4=document.getElementById('DAT_FIE_ASZ_LAV').value;
    var mess = "";

    if(data1!=0){
        if(checkValidDate(data1)){
            if(isGreaterThan(data1,currentDate)){
                mess += arraylng["MSG_0194"] + "\n";
            }
        }
    }
    if(data2!=0){
        if(checkValidDate(data2)){
            if(isGreaterThan(data2,currentDate)){
                mess += arraylng["MSG_0195"] + "\n";
            }
        }
    }    
    if(data3!=0){
        if(checkValidDate(data3)){
            if(isGreaterThan(data3,currentDate)){
                mess += arraylng["MSG_0196"] + "\n";
            }
        }
    }    
    if(data4!=0){
        if(checkValidDate(data4)){
            if(isGreaterThan(data4,currentDate)){
                mess += arraylng["MSG_0197"] + "\n";
            }
        }
    }
    if((data1!=0)&&(data2!=0)&&(data2!=null)){
        if(checkValidDate(data1)&& checkValidDate(data2)){
            if(isGreaterThan(data2, data1)){
                mess += arraylng["MSG_0198"] + "\n";
            }
        }
    }
    if((data2!=0)&&(data3!=null)&&(data3!=0)){
        if(checkValidDate(data2)&& checkValidDate(data3)){
            if(isGreaterThan(data2, data3)){
                mess += arraylng["MSG_0199"] + "\n";
            }
        }
    }
    if((data4!=null)&&(data4!=0)&&(data1!=0)){
        if(checkValidDate(data1)&& checkValidDate(data4)){
            if(isGreaterThan(data1, data4)){
                mess += arraylng["MSG_0200"] + "\n";
            }
        }
    }
    if((data4!=null)&&(data4!=0)&&(data2!=0)){
        if(checkValidDate(data2)&& checkValidDate(data4)){
            if(isGreaterThan(data2, data4)){
                mess += arraylng["MSG_0201"] + "\n";
            }
        }
    }
    if((data3!=null)&&(data4!=0)&&(data4!=0)){
        if(checkValidDate(data3)&& checkValidDate(data4)){
            if(isGreaterThan(data3, data4)){
                mess += arraylng["MSG_0202"] + "\n";
            }
        }
    }
    if (!called4Save && mess != "") alert(mess);
    return mess;
}

function data_valida_cantiere(called4Save){
    var currentDate = getCurrentDate();
    var data1=document.getElementById('DAT_COM_INO').value;
    var data2=document.getElementById('DAT_EVE_INO').value;
    var data3=document.getElementById('DAT_INZ_ASZ_LAV').value;
    var data4=document.getElementById('DAT_FIE_ASZ_LAV').value;
    var mess = "";

    if(data1!=0){
        if(checkValidDate(data1)){
            if(isGreaterThan(data1,currentDate)){
                mess += arraylng["MSG_0194"] + "\n";
            }
        }
    }
    if(data2!=0){
        if(checkValidDate(data2)){
            if(isGreaterThan(data2,currentDate)){
                mess += arraylng["MSG_0195"] + "\n";
            }
        }
    }
    if(data3!=0){
        if(checkValidDate(data3)){
            if(isGreaterThan(data3,currentDate)){
                mess += arraylng["MSG_0196"] + "\n";
            }
        }
    }
    if(data4!=0){
        if(checkValidDate(data4)){
            if(isGreaterThan(data4,currentDate)){
                mess += arraylng["MSG_0197"] + "\n";
            }
        }
    }
    if((data1!=0)&&(data2!=0)&&(data2!=null)){
        if(checkValidDate(data1)&& checkValidDate(data2)){
            if(isGreaterThan(data2, data1)){
                mess += arraylng["MSG_0208"] + "\n";
            }
        }
    }
    if((data2!=0)&&(data3!=null)&&(data3!=0)){
        if(checkValidDate(data2)&& checkValidDate(data3)){
            if(isGreaterThan(data2, data3)){
                mess += arraylng["MSG_0199"] + "\n";
            }
        }
    }
    if((data4!=null)&&(data4!=0)&&(data1!=0)){
        if(checkValidDate(data1)&& checkValidDate(data4)){
            if(isGreaterThan(data1, data4)){
                mess += arraylng["MSG_0209"] + "\n";
            }
        }
    }
    if((data4!=null)&&(data4!=0)&&(data2!=0)){
        if(checkValidDate(data2)&& checkValidDate(data4)){
            if(isGreaterThan(data2, data4)){
                mess += arraylng["MSG_0210"] + "\n";
            }
        }
    }
    if((data3!=null)&&(data4!=0)&&(data4!=0)){
        if(checkValidDate(data3)&& checkValidDate(data4)){
            if(isGreaterThan(data3, data4)){
                mess += arraylng["MSG_0202"] + "\n";
            }
        }
    }
    if (!called4Save && mess != "") alert(mess);
    return mess;
}


function saveForm(){
    var mess = data_valida(true);
    if (mess != ""){
        alert(mess);
    } else {
        tb_OnSave();
    }
}
