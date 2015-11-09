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

// Questa funzione disabilita tutti i campi delle schede di sezione
// (Generale, di sicurezza, particolari) e del fascicolo dell'opera,
// una volta inserita la data emissione

function dis(val) {
    if((val != "")){
        document.getElementById('OGG').readOnly=true;
        if (document.getElementById('TIT')){
            document.getElementById('TIT').readOnly=true;
        }
    }
    else{
        document.getElementById('OGG').readOnly=false;
        if (document.getElementById('TIT')){
            document.getElementById('TIT').readOnly=false;
        }
    }
}

function beforeInsert(paramsList){
    var cod_pro=document.getElementById('COD_PRO').value;
    var cod=document.getElementById('COD').value;
    var ajaxReturn = document.getElementById('ajaxReturn');
    eseguiChiamataAjax(
        '../Form_ANA_PSC/getdat_rev.jsp? paramList='+paramsList+'&COD_PRO='+cod_pro+'&COD='+cod,
        ajaxReturn, false);
    
    if (ajaxReturn.value==0){
        ajaxReturn.value = "";
        return true;
    } else {
        ajaxReturn.value = "";
        alert("Prima di inserire una nuova revisione bisogna definire la data protocollo alla revisione precedente");
        return false;
    } 
}

function checkDateRevisionePrecedente(paramsList){
    var cod_pro=document.getElementById('COD_PRO').value;
    var dat_pro_pre=document.getElementById('DAT_EMI').value;
    var cod=document.getElementById('COD').value;
    var ajaxReturn = document.getElementById('ajaxReturn');
    eseguiChiamataAjax(
        '../Form_ANA_PSC/getdat_pro_pre.jsp? paramList='+paramsList+'&COD_PRO='+cod_pro+'&COD='+cod+'&DAT_EMI='+dat_pro_pre,
        ajaxReturn, false);
    if (ajaxReturn.value==0){
        ajaxReturn.value = "";
        return true;
    } else {
        ajaxReturn.value = "";
        alert("La data emissione deve essere maggiore della data protocollo della revisione precedente");
        return false;
    }
}
    
function CodiceProcedimento(codice) {
    var cod=codice.options[codice.selectedIndex].codiceprocedimento;
    if(cod){
        strCOD_PSC="PSC-"+cod;
    }
    else{
        strCOD_PSC="PSC-";
    }
    document.all["COD_PSC"].value=strCOD_PSC;
    return strCOD_PSC;
}
