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
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function  checkDataEvento(dateE,dateC,dateI, dateF  ) {
  
    var error = "OK";
    var test1 = dateNotGreatherThanCurrentDate(dateE, false);
    if (test1 == true) {
        dateNotGreatherThanCurrentDate(dateE, true);
        error = "KO";
    }
    if (error == "KO") {
        checkDataComunicazione(dateC,dateE);
        checkDataInizioAssenza(dateI, dateF,dateE);
        checkDataFineAssenza(dateF,dateI,dateE);
        return;
    }

    return;
     
}

function  checkDataComunicazione(dateC, dateE) {
    var messages = "";
    var error = "OK";
    var test1 = dateNotGreatherThanCurrentDate(dateC, false);
    if (test1 == true) {
        dateNotGreatherThanCurrentDate(dateC, true);
        return;
    }

    arrDS = dateC.split("/");
    var dateDS = new Date(arrDS[2], arrDS[1], arrDS[0]);
    arrDC = dateE.split("/");
    var dateDC = new Date(arrDC[2], arrDC[1], arrDC[0]);

    if (dateDS.getTime() < dateDC.getTime()) {
        messages = 'La Data Comuniazione ('+dateC+') non può essere Minore della data Evento ('+dateE+'). ';
        error = "KO";
       
    }
    if (error == "KO") {
        alert(messages);
        setDataComunicazione(dateE);
        return;
    }

    return;
}

function  checkDataInizioAssenza(dateI, dateF, dateE) {


    var messages = "";
    var error = "OK";

    var test1 = dateNotGreatherThanCurrentDate(dateI, false);
    if (test1 == true) {
        dateNotGreatherThanCurrentDate(dateI, true);
        return null;
    }

    test1 = dateTwoConsecutiveDateOne(dateI, dateF, false);
    if (test1 == true) {
        dateTwoConsecutiveDateOne(dateI, dateF, true);
        return;
    }
    arrDS = dateI.split("/");
    var dateDS = new Date(arrDS[2], arrDS[1], arrDS[0]);
    arrDC = dateE.split("/");
    var dateDC = new Date(arrDC[2], arrDC[1], arrDC[0]);

    if (dateDS.getTime() < dateDC.getTime()) {
        messages = 'La Data Inizio Assenza ('+dateI+') non può essere Minore della Data Evento ('+dateE+'). ';
        error = "KO";
      
    }
    if (error == "KO") {
        alert(messages);
        setDataInizioAssenza(dateE);
        return;
    }
     if (error == "OK") {
          var dayBetween = daysBetween(dateI, dateF);
            
        if(isNaN(dayBetween))
         setGiorniAssenza('0');
       else 
          setGiorniAssenza(dayBetween);
    }

    return;
}
function  checkDataFineAssenza(dateF, dateI, dateE) {


    var messages = "";
    var error = "OK";

    var test1 = dateNotGreatherThanCurrentDate(dateI, false);
    if (test1 == true) {
        dateNotGreatherThanCurrentDate(dateI, true);
        return;
    }

    test1 = dateTwoConsecutiveDateOne(dateI, dateF, false);
    if (test1 == true) {
        dateTwoConsecutiveDateOne(dateI, dateF, true);
        return;
    }
    arrDS = dateF.split("/");
    var dateDS = new Date(arrDS[2], arrDS[1], arrDS[0]);
    arrDC = dateE.split("/");
    var dateDC = new Date(arrDC[2], arrDC[1], arrDC[0]);

    if (dateDS.getTime() < dateDC.getTime()) {
        messages = 'La Data Fine Assenza '+dateF+' non può essere Minore della Data Evento. '+dateE;
        error = "KO";
    }
    if (error == "KO") {
        alert(messages);
        setDataFineAssenza(dateI);
        return;
    }
    if (error == "OK") {
          var dayBetween = daysBetween(dateI, dateF);
       
        
        if(isNaN(dayBetween))
         setGiorniAssenza('0');
       else 
          setGiorniAssenza(dayBetween);
    }
    return;
}

function dateNotGreatherThanCurrentDate(dateS, showAlert) {


    var messages = "";
    var error = "OK";
    var dateCurrent = new Date();

    arrDa = dateS.split("/");
    var dateDa = new Date(arrDa[2], (arrDa[1] - 1), arrDa[0]);

    if (dateDa.getTime() > dateCurrent.getTime()) {
        messages = 'La Data selezionata ('+dateS+') non può essere maggiore della data Odierna ('+dateCurrent.toLocaleDateString()+'). ';
        error = "KO";
    }

    if (error == "KO" && showAlert == true) {
        alert(messages);
        return;
    } else if (error == "KO" && showAlert == false) {
        return true;
    }

}
function dateNotGreatherThanOtherDate(dateOne, dateTwo) {


    var messages = "";
    var error = "OK";
    var date1 = new Date(dateOne);
    var date2 = new Date(dateTwo);
    arrDa = dateSelected.split("/");
    var dateDa = new Date(arrDa[2], arrDa[1], arrDa[0]);

    if (date1.getTime() > date2.getTime()) {
        messages = 'La Data ('+date1+')selezionata non può essere maggiore di ('+date2+'). ';
        error = "KO";
    }
    if (error == "KO") {
        alert(messages);
        return;
    }

    return;
}

function dateTwoConsecutiveDateOne(dateI, dateF, showAlert) {
    var messages = "";
    var error = "OK";
 
    arrDa = dateI.split("/");
    var dateDa = new Date(arrDa[2], arrDa[1], arrDa[0]);
    arrA = dateF.split("/");
    var dateA = new Date(arrA[2], arrA[1], arrA[0]);


    if (dateDa.getTime() > dateA.getTime()) {
        messages = 'La Data Inizio Assenza ('+dateDa+')  non può essere maggiore della Data Fine Assenza ('+dateA+'). ';
        error = "KO";
    }
    if (error == "KO" && showAlert == true) {
        alert(messages);
        return;
    } else if (error == "KO" && showAlert == false) {
        return true;
    }

    return;
}
function daysBetween(date1, date2) {
    arrDA = date1.split("/");
    var dateA = new Date(arrDA[2], (arrDA[1] - 1), arrDA[0]);
    arrA = date2.split("/");
    var dateB = new Date(arrA[2], (arrA[1] - 1), arrA[0]);
    alert(dateA+'  -  '+dateB);
    //Get 1 day in milliseconds
       
    var one_day = 1000 * 60 * 60 * 24;

    // Convert both dates to milliseconds
    var date1_ms = dateA.getTime();
    var date2_ms = dateB.getTime();
   
    // Calculate the difference in milliseconds
    var difference_ms = date2_ms - date1_ms;
   
    // Convert back to days and return
    return Math.round(difference_ms / one_day)+1;
   
}
//Set the value of Field
function setDataInizioAssenza(data) {
    document.getElementById('DAT_INZ_ASZ_LAV').value = data;
}
function setDataFineAssenza(data) {
    document.getElementById('DAT_FIE_ASZ_LAV').value = data;
}
function setDataComunicazione(data) {
    document.getElementById('DAT_COM_INO').value = data;
}
function setGiorniAssenza(data) {
    document.getElementById('GOR_ASZ').value = data;
}


// Controllo tra Flag_malattia e GG malattia
         
function enableDisable( check, nameElement) {
  
   var oggEnableDisable= document.getElementById(nameElement);
  
   if(check!= 'undefined')
       if(check.checked == true){
        
          oggEnableDisable.disabled = false;
       }
       if(check.checked == false){
             oggEnableDisable.value =0;
             oggEnableDisable.disabled = true;
       }
}
function validate(evt) {
  var theEvent = evt || window.event;
  var key = theEvent.keyCode || theEvent.which;
  key = String.fromCharCode( key );
  var regex = /[0-9]|\./;
  if( !regex.test(key) ) {
    theEvent.returnValue = false;
    if(theEvent.preventDefault) theEvent.preventDefault();
  }
}
