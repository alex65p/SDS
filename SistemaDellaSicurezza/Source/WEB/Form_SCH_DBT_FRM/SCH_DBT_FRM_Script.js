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

var oldSel=0;
var oldI=0;

function selCOR_DPD(theId, i){
    if (oldSel != 0){
        // Deseleziono la riga precedentemente selezionata.
        document.all[oldI+oldSel+"1"].className="dataInput";
        document.all[oldI+oldSel+"2"].className="dataInput";
        document.all[oldI+oldSel+"3"].className="dataInput";
    }
    
    // Evidenzio la riga selezionata
    document.all[i+theId+"1"].className="dataInputSelected";
    document.all[i+theId+"2"].className="dataInputSelected";
    document.all[i+theId+"3"].className="dataInputSelected";

    oldSel=theId;
    oldI=i;

    document.all['COD_COR'].value=theId.substring(2,theId.length);
    document.all['COD_DPD'].value=document.all[i+"hid"+theId].value;
    document.all['DAT_COR'].value=document.all[i+theId+"3"].value;
    
    ToolBar.Detail.setEnabled(true);
}

function openCORDPD(){
    if(oldSel!=0){
        document.all["ifrmWork"].src = 'SCH_DBT_FRM_UtilFind.jsp' + 
                '?ID_PARENT='+document.all["COD_DPD"].value + 
                '&ID='+document.all["COD_COR"].value + 
                '&DAT_COR='+document.all["DAT_COR"].value +
                '&operation=checkCorso';
    }else{
        alert(arraylng["MSG_0080"]);
    }
}

function ChangeSelect(id_sel){
    var obj=document.all["ORGANIZZATIVA"];
    document.all["ifrmWork"].src="SCH_DBT_FRM_UtilFind.jsp?ID="+obj.value+"&ID_SEL="+id_sel+"&operation=changeUO";
    ToolBar.Search.setEnabled(true);
}

function search(){
    goTab("up");
}

var order="up";
function goTab(ord){
    var obj=document.all["ATTIVITA"];
    if(obj.value!=0){
        document.all["ifrmFile"].src="SCH_DBT_FRM_Tab.jsp?ID="+obj.value+"&ORDER="+ord;
    }else{
        document.all["ifrmFile"].src="SCH_DBT_FRM_Tab.jsp?ID=0&ORDER="+ord;
    }
    order=ord;
    oldSel=0;
    oldI=0;
    ToolBar.Detail.setEnabled(false);
}

function sortList(){
    if(order=="up"){
        goTab("dw");
    }else{
        goTab("up");
    }
}

function OnPrint(){
    COD_UNI=document.all["ORGANIZZATIVA"].value;
    COD_ATT=document.all["ATTIVITA"].value;
    ToolBar.openReport("DebitoFormativo.jsp?COD_UNI="+COD_UNI+"&COD_ATT="+COD_ATT+"&");
}  

