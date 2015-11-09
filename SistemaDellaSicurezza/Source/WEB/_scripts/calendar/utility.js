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

// Formatta la data
function DateFormat(vDateName) {
	/*Formatta la data digitata dall'utente in formato dd/mm/yyyy
	  impostando automaticamente il separatore /ed i  giorni e mesi in 2 caratteri
	  (es. 1/1/2001 è trasformato in 01/01/2001)
	  da richiamere con il metodo onKeyUp
	 <input type="text" name="testDateFormat" size='10' maxlength="10" onKeyUp="DateFormat(this)"
	  */

	//Controllo validità caratteri digitati

	for (i=0 ; i <= vDateName.value.length - 1 ; i++){
		var strKeyPress = vDateName.value.slice(i,i+1);
		//Eliminate all the ASCII codes that are not valid
		var alphaCheck = "1234567890/";
		if (alphaCheck.indexOf(strKeyPress) == -1) {
			vDateName.value = vDateName.value.substr(0, (vDateName.value.length-1));
			return false;
		 }

		 if (i>5 && strKeyPress=="/"){
			vDateName.value = vDateName.value.substr(0, (vDateName.value.length-1));
			return false;
		 }

	}

	// Aggiunge 0 iniziale a gg di 1 cifra
	if (vDateName.value.length==2 && strKeyPress == "/") {
		vDateName.value = "0" + vDateName.value.replace("/","");
		return false;
	}

	// Aggiunge 0 iniziale a mm di 1 cifra
	if (vDateName.value.length==5 && strKeyPress == "/") {
		vDateName.value = vDateName.value.substr(0, 3) + "0" + vDateName.value.substr(3, 1) + "/";
		return false;
	}

	// Aggiunge separatore
	if (vDateName.value.length==2 || vDateName.value.length == 5) {
		vDateName.value = vDateName.value.concat("/");
		return false;
	}

	if (vDateName.value.length>6 && strKeyPress == "/") {
		vDateName.value = vDateName.value.substr(0, (vDateName.value.length-1));
		return false;
	}

	// Aggiune secolo se digitato anno di due cifre
        if (vDateName.value.length==8 &&  vDateName.value.substr(6,2)!= "19" && vDateName.value.substr(6,2)!= "20"){
		if (vDateName.value.substr(6,2) > "20") {
			vDateName.value = vDateName.value.substr(0,6) + "19" + vDateName.value.substr(6,2);
		}else {
			vDateName.value = vDateName.value.substr(0,6) + "20" + vDateName.value.substr(6,2);
		}
                // Se la data è completata dal meccanismo di autocompletamento lancio a mano l'evento onchange.
                // var calendarImage = document.getElementById(vDateName.id + "_CalendarImg");
                if (vDateName.onchange) vDateName.onchange();
	}
}
