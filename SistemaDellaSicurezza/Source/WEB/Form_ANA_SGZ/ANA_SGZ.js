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

function setImmobile(luogoFisicoComboBox, COD_AZL){
    // Determino il luogo fisico selezionato
    var luogoFisicoSelezionato = 
        luogoFisicoComboBox.options[luogoFisicoComboBox.selectedIndex];

    // Estraggo il codice del luogo fisico selezionato
    var COD_LUO_FSC = luogoFisicoSelezionato.value;

    // Determino l'immobile di appartenenza del luogo fisico selezionato
    var COD_IMM_3LV = luogoFisicoSelezionato.COD_IMM_3LV;

    // Ottengo il puntamento alla lista di immobibli
    var immobileComboBox = document.getElementById('COD_IMM_ID');

    if (COD_IMM_3LV != 0){

        // Imposto l'immobile corrente con quello del luogo fisico selezionato
        immobileComboBox.value=COD_IMM_3LV;

        // Ricarico le lista dei luoghi fisici presentando solo quelli appartenenti
        // all'immobile selezionato, se non ho selezionato alcun immobile li presento
        // tutti
        reloadLuoghiFisici(COD_IMM_3LV, COD_LUO_FSC, COD_AZL);
    }
}

function reloadLuoghiFisici(COD_IMM_3LV, COD_LUO_FSC, COD_AZL){
    // Ottengo il puntamento al div contenente il comboBox del luoghi fisici
    var divLuoghiFisici = document.getElementById('luoghiFisiciDIV');
    
    // Eseguo la chiamata ajax che ricarica il comboBox dei luoghi fisici
    // in base all'immobile selezionato
    eseguiChiamataAjax("reloadLuoghiFisici_ajax.jsp"
        +"?COD_IMM_3LV="+COD_IMM_3LV
        +"&COD_LUO_FSC="+COD_LUO_FSC
        +"&COD_AZL="+COD_AZL, divLuoghiFisici);
}
