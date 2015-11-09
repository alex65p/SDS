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


var lastAttivitaWindow = null;
            
function g_openAttivitaWindow(url){
    url="../Form_ANA_ATT/ANA_ATT_Sel.jsp";
    if (lastAttivitaWindow != null){
        lastAttivitaWindow.close();
    }
    var openWin = window.showModelessDialog(url, null, g_getAttivitaFeachures());
    lastAttivitaWindow = openWin;
    return openWin;
}

function g_getAttivitaFeachures(){
    var windowWidth=400;
    var windowHeight=600;
    var borderSpace=20;
    var windowParams =  "dialogHeight:"+windowHeight+"px;dialogWidth:"+windowWidth+"px;help:0;resizable:0;status:0;scroll:0" + 
    ";dialogLeft:" + (screen.width - windowWidth - borderSpace) +
    ";dialogTop:" + (borderSpace+50) + ";";
    return windowParams;
}
