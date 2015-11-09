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

function DisableAllFormsFields(targetWindow){
    for (f=0; f<targetWindow.document.forms.length; f++){
        for (e=0; e<targetWindow.document.forms[f].elements.length; e++){
            if (targetWindow.document.forms[f].elements[e].type == "text" ||
                targetWindow.document.forms[f].elements[e].type == "checkbox" ||
                targetWindow.document.forms[f].elements[e].type == "file" ||
                targetWindow.document.forms[f].elements[e].type == "select-one"){
                    targetWindow.document.forms[f].elements[e].disabled=true;
            }
        }
    }
}

function ArrayContainsItemByID(list, itemToCheck){
    if (list != null && itemToCheck != null){
        for (i=0; i <list.length; i++) {
            if (list[i]==itemToCheck){
                return true;
            }
        }
    }
    return false;
}

function ReadOnlyAllFormsFields(targetWindow, excludedObjectsByID){
    for (f=0; f<targetWindow.document.forms.length; f++){
        for (e=0; e<targetWindow.document.forms[f].elements.length; e++){
            var obj = targetWindow.document.forms[f].elements[e];
            if ((obj.type == "text" || obj.type == "file" || obj.type == "textarea") &&
                ArrayContainsItemByID(excludedObjectsByID, obj.id)==false)
            {
                    obj.readOnly=true;
                    if (obj.custom_type=="s2s_date"){
                        targetWindow.document.getElementById(obj.id+'_CalendarImg').disabled = true;
                    }
            } else
            if ((obj.type == "checkbox" || obj.type == "select-one") &&
                ArrayContainsItemByID(excludedObjectsByID, obj.id)==false)
            {
                    targetWindow.document.forms[f].elements[e].disabled=true;
            }
        }
    }
}
