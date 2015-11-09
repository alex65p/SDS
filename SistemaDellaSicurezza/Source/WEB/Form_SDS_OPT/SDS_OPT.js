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

function resetAllPanel4Select(){
    document.getElementById("td-panelBO").style.backgroundColor="#00a8ec";
    document.getElementById("td-panelGenerale").style.backgroundColor="#00a8ec";
    document.getElementById("td-panelEmail").style.backgroundColor="#00a8ec";
    document.getElementById("td-panelLDAP").style.backgroundColor="#00a8ec";
    document.getElementById("td-panelLog4j").style.backgroundColor="#00a8ec";

    document.getElementById("panelBO").style.display='none';
    document.getElementById("panelGenerale").style.display='none';
    document.getElementById("panelEmail").style.display='none';
    document.getElementById("panelLDAP").style.display='none';
    document.getElementById("panelLog4j").style.display='none';
}

function resetAllPanel4Underline(){
    document.getElementById("td-panelBO").style.border = '';
    document.getElementById("td-panelGenerale").style.border = '';
    document.getElementById("td-panelEmail").style.border = '';
    document.getElementById("td-panelLDAP").style.border = '';
    document.getElementById("td-panelLog4j").style.border = '';
}

function selectPanel(panelName){
    resetAllPanel4Select();
    
    document.getElementById("td-"+panelName).style.backgroundColor="#C1DAD7";
    document.getElementById(panelName).style.display='block';
}

function underlinePanel(panelName){
    resetAllPanel4Underline();
    
    document.getElementById("td-"+panelName).style.border = '1px solid navy';
}

function deleteBrowserOption(url, elemento){
    if (confirm(arraylng["MSG_0220"])) { 
        eseguiChiamataAjax(url, elemento);
    }
}
