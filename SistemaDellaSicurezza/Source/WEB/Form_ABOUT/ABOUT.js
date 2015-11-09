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

function hideAllPanel(){
    panelListaModuli = document.getElementById("listaModuliID");
    panelListaModuli.style.display = "none";

    panelInfo = document.getElementById("altreInfoID");
    panelInfo.style.display = "none";
    
    panelCredits = document.getElementById("listaCreditsID");
    panelCredits.style.display = "none";
}

function viewInfo(viewInfo) {
    hideAllPanel();
    panelInfo = document.getElementById("altreInfoID");
    if (viewInfo) {
        panelInfo.style.display = "block";
        window.dialogWidth = "1010px";
    } else {
        panelInfo.style.display = "none";
        window.dialogWidth = "500px";
    }
}

function viewListaModuli(viewListaModuli) {
    hideAllPanel();
    panelListaModuli = document.getElementById("listaModuliID");
    if (viewListaModuli) {
        panelListaModuli.style.display = "block";
        window.dialogWidth = "800px";
    } else {
        panelListaModuli.style.display = "none";
        window.dialogWidth = "500px";
    }
}

function viewCredits(viewCredits) {
    hideAllPanel();
    panelCredits = document.getElementById("listaCreditsID");
    if (viewCredits) {
        panelCredits.style.display = "block";
        window.dialogWidth = "800px";
    } else {
        panelCredits.style.display = "none";
        window.dialogWidth = "500px";
    }
}
