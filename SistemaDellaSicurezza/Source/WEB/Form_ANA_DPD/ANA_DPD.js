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


function ControllaDataCessazione(){
    var oggi = new Date();
    var G = oggi.getDate();
    var M = (oggi.getMonth() + 1);
    var A = oggi.getFullYear();

    if (G < 10) G = "0" + G;
    if (M < 10) M = "0" + M

    var dataodierna = Date.parse(G + "/" + M + "/" + A);
    var DAT_CES_DPD = document.getElementById('DAT_CES_DPD');
    var espressione = /^[0-9]{2}\/[0-9]{2}\/[0-9]{4}$/;
    if (!espressione.test(DAT_CES_DPD.value)) {
        return true;
    }else{
        anno = parseInt(DAT_CES_DPD.value.substr(6),10);
        mese = parseInt(DAT_CES_DPD.value.substr(3, 2),10);
        giorno = parseInt(DAT_CES_DPD.value.substr(0, 2),10);
        var dataValida=new Date(anno, mese-1, giorno);
        if(dataValida.getFullYear()==anno && dataValida.getMonth()+1==mese && dataValida.getDate()==giorno){
            var datacessazione = Date.parse(DAT_CES_DPD.value);
            if((DAT_CES_DPD.value !="")&&(dataodierna<=datacessazione)){
                return confirm(arraylng["MSG_0192"]);}
            else if((DAT_CES_DPD.value !="")&&(dataodierna>datacessazione)){
                return confirm(arraylng["MSG_0193"]);
            }
        }
    }
    return true;
}
