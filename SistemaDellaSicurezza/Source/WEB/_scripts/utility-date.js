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

// Questa serie di funzioni opera sulle date con il formato italiano dd/mm/yyyy.
// (es. 12/01/1920), senza la parte relativa al tempo (ore, min., sec., millis.)

// Verifica che la data sia corretta formalmente, il formato,
// e sostanzialmente, il valore.
// Torna un booleano con il risultato.
function checkValidDate(stringDate){
    var espressione = /^[0-9]{2}\/[0-9]{2}\/[0-9]{4}$/;
    if (!espressione.test(stringDate)) {
        return false;
    }
    var anno = parseInt(stringDate.substr(6),10);
    var mese = parseInt(stringDate.substr(3, 2),10);
    var giorno = parseInt(stringDate.substr(0, 2),10);
    var dataValida = new Date(anno, mese-1, giorno);
    return (dataValida.getFullYear() == anno && dataValida.getMonth()+1 == mese && dataValida.getDate() == giorno);
}

// Converte una oggetto stringa in un oggetto Date.
function stringToDate(stringDate){
    if (checkValidDate(stringDate)){
        var anno = parseInt(stringDate.substr(6),10);
        var mese = parseInt(stringDate.substr(3, 2),10);
        var giorno = parseInt(stringDate.substr(0, 2),10);
        return new Date(anno, mese-1, giorno);
    } else {
        return null;
    }
}

// Torna il giorno della settimana nel formato descrittivo esteso.
function getDayOfWeek(day){
    var weekday=new Array(7);
    weekday[0]="Domenica";
    weekday[1]="Lunedì";
    weekday[2]="Martedì";
    weekday[3]="Mercoledì";
    weekday[4]="Giovedì";
    weekday[5]="Venerdì";
    weekday[6]="Sabato";

    if (day != null && day != '' && day >=0 && day <=7){
        return weekday[day];
    } else {
        return '';
    }
}

// Verifica l'ugualianza di due date, nel formato stringa.
function isEqualTo(date1, date2){
    date1 = stringToDate(date1);
    date2 = stringToDate(date2);
    if (date1 != null && date2 != null){
        return date1 == date2;
    } else {
        return false;
    }
}

// Verifica che la data1 sia minore della data2, nel formato stringa.
function isLessThan(date1, date2){
    date1 = stringToDate(date1);
    date2 = stringToDate(date2);
    if (date1 != null && date2 != null){
        return date1 < date2;
    } else {
        return false;
    }
}

// Verifica che la data1 sia minore o uguale alla data2, nel formato stringa.
function isLessOrEqualThan(date1, date2){
    date1 = stringToDate(date1);
    date2 = stringToDate(date2);
    if (date1 != null && date2 != null){
        return date1 <= date2;
    } else {
        return false;
    }
}

// Verifica che la data1 sia maggiore della data2, nel formato stringa.
function isGreaterThan(date1, date2){
    date1 = stringToDate(date1);
    date2 = stringToDate(date2);
    if (date1 != null && date2 != null){
        return date1 > date2;
    } else {
        return false;
    }
}

// Verifica che la data1 sia maggiore o uguale alla data2, nel formato stringa.
function isGreaterOrEqualThan(date1, date2){
    date1 = stringToDate(date1);
    date2 = stringToDate(date2);
    if (date1 != null && date2 != null){
        return date1 >= date2;
    } else {
        return false;
    }
}

// Determina la data odierna, nel formato stringa.
function getCurrentDate(){
    var currentDate = new Date();
    return (currentDate.getDate() + "/" + (currentDate.getMonth()+1) + "/" + currentDate.getFullYear());
}

// Torna la differenza in giorni tra 2 date.
function getDifference2Days(data1,data2){
    if (
        checkValidDate(data1) && 
        checkValidDate(data2) &&
        isLessOrEqualThan(data1, data2)){

        // Converte le stringe in oggetti data.
        data1 = stringToDate(data1);
        data2 = stringToDate(data2);

        // Unità di tempo "Giorno" espressa in millisecondi.
        var giornoMill = 86400000;
        
        // Differenza tra le date espressa in millisecondi.
        return Math.floor(((data2-data1)/giornoMill)+1);
    }
    return 0;
}
// Torna la differenza in giorni tra 2 date escluso il giorno iniziale.
function getDifference2Days_CAN(data1,data2){
    if (
        checkValidDate(data1) &&
        checkValidDate(data2) &&
        isLessOrEqualThan(data1, data2)){

        // Converte le stringe in oggetti data.
        data1 = stringToDate(data1);
        data2 = stringToDate(data2);

        // Unità di tempo "Giorno" espressa in millisecondi.
        var giornoMill = 86400000;

        // Differenza tra le date espressa in millisecondi.
        return Math.floor(((data2-data1)/giornoMill));
    }
    return 0;
}
