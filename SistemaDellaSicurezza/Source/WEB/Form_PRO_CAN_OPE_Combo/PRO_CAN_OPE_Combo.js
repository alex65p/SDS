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

document.write('<script type="text/javascript" src="../_scripts/ajax.js"></script>');

function getPRO_CAN_OPE_Combo(elemento, pro, can, ope, azl, changedElement){
    var uri = "../Form_PRO_CAN_OPE_Combo/PRO_CAN_OPE_Combo.jsp"
    uri += "?PRO=" + pro;
    uri += "&CAN=" + can;
    uri += "&OPE=" + ope;
    uri += "&AZL=" + azl;
    uri += "&changedElement=" + changedElement;
    eseguiChiamataAjax(uri, elemento, true);
}
