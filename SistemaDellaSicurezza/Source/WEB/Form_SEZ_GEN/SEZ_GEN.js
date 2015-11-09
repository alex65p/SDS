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

function beforeSave(){
    getRev();
    return true;
}

function getRev(){
    var par = document.getElementById('frmCode').value;
    var REV_ajaxReturnDiv = document.getElementById('REV_ajaxReturnDiv');
    
    var data1 = document.getElementById('DAT_EMI').value;
    var cod_pro = document.getElementById('COD_PRO').value;
    var cod = document.getElementById('COD').value;
    var rev = document.getElementById('REV').value;
    
    // Chiamata Ajax SINCRONA al metodo che determina la revisione.
    eseguiChiamataAjax(
        '../Form_ANA_PSC/getRev.jsp?DAT_EMI='+data1+'&REV='+rev+'&COD_PRO='+cod_pro+'&par='+par+'&COD='+cod, 
        REV_ajaxReturnDiv, 
        false)
}

function confronta_date(called4Save){

    var currentDate = getCurrentDate();
    var data1=document.getElementById('DAT_EMI').value;
    var data2=document.getElementById('DAT_PRO').value;

    var mess = "";
    if(data1!=0){

        if(checkValidDate(data1)){
            if(isGreaterThan(data1,currentDate)){
                mess += arraylng["MSG_0211"] + "\n";

            }
        }
    }
    if(data2!=0){
        if(checkValidDate(data2)){
            if(isGreaterThan(data2,currentDate)){
                mess += arraylng["MSG_0212"] + "\n";
            }
        }
    }
    if((data1!=0)&&(data2!=0)&&(data2!=null)){
        if(checkValidDate(data1)&& checkValidDate(data2)){
            if(isGreaterThan(data1, data2)){
                // mess += "data2 deve essere maggiore della data1" + "\n";
                mess += arraylng["MSG_0205"] + "\n";
            }
        }
    }
    if (!called4Save && mess != "") alert(mess);
    return mess;
}

function data_protocollo(val) {
    if(val !=""){}
    else{
        document.getElementById('DAT_PRO').value='';
        alert('prima di inserire la data protocollo devo definire la data emissione');
    }

}
