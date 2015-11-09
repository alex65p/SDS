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

function checkBloccoDescrizioni(value){
    var ritorno =
    value == 'BA' ||
    value == 'BI' ||
    value == 'BN' ||
    value == 'BL' ||
    value == 'BM' ||
    value == 'BR' ||
    value == 'BP' ||
    value == 'BU' ||
    value == 'BS';
    return ritorno;
}

function clearAllStandardCheck(){
    var arr = document.getElementsByName('type_is');
    for(var i = 0; i < arr.length; i++) {
        arr.item(i).checked = false;
    }    
}

function visualizzaBloccoDescrizioni(visible){
    if (visible==true){
        document.all['td_descrizioni'].style.display = 'block';
    } else
    if (visible==false){
        document.all['td_descrizioni'].style.display = 'none';
    }
}

function radioClick(value){
    // Ho selezionato il check box "Descrizioni"
    if (value == 'B'){
        clearAllStandardCheck();
        document.all['type'].value = '';
        visualizzaBloccoDescrizioni(true);
    // Gestisco il box "Descrizioni"
    } else if (checkBloccoDescrizioni(value) == true){
        document.all['type'].value = value;
    // Tutti gli altri casi.
    } else {
        visualizzaBloccoDescrizioni(false);
        document.all['type_is_B'].checked = false;
        document.all['type'].value = value;
    }
}

function OpenTabForm()
{
    radVal=document.all['type'].value;
    id=document.all['COD_PRG'].value;
    id_sch=document.all['COD_SCH_PRG'].value;
    
    if((radVal==null)||(radVal==""))alert(arraylng["MSG_0054"]);
    else if (radVal=='B'){
        radDes=document.getElementById('type_des_'+radVal).innerHTML;
        result=window.showModalDialog('ANA_SCH_PRG2_Form.jsp?TYPE='+radVal+'&TYPEDES='+radDes+'&ID_PRG='+id+'&ID_SCH='+id_sch,'','dialogHeight:250px;dialogwidth:450px;scroll:yes;status:no;help:no');
    } 
    else if (radVal=='D' || radVal=='V' || radVal=='R')
    {
        mod=document.all['SBM_MODE'].value;
        document.all.ifrmWork.src='ANA_SCH_PRG2_Set.jsp?SBM_MODE='+mod+'&TYPE='+radVal+'&ID_PRG='+id+'&COD_SCH_PRG='+id_sch;
    }
    else
    {
        radDes=document.getElementById('type_des_'+radVal).innerHTML;
        result=window.showModalDialog('ANA_SCH_PRG2_Form.jsp?TYPE='+radVal+'&TYPEDES='+radDes+'&ID_PRG='+id+'&ID_SCH='+id_sch,'','dialogHeight:250px;dialogwidth:450px;scroll:yes;status:no;help:no');
    }
}

function setChecked(val,mode,id)
{
    var id_before="";
    if(mode=="add")
    {
        if (val!="0")
        {
            if (document.all['IDS'].value.indexOf(","+val+",",0)>=0)
            {
                pos1=document.all['IDS'].value.indexOf(","+val+",",0);
                pos2=document.all['IDS'].value.indexOf(",",pos1+1);
                document.all['IDS'].value=document.all['IDS'].value.substring(0,pos1)+document.all['IDS'].value.substring(pos2,document.all['IDS'].value.length);
            }
            else
            {
                document.all['IDS'].value=document.all['IDS'].value+val+",";
            }
        }
    }
    else
    {
        id_before=document.all['id_bef'].value;
        if (document.all['IDS'].value.length>1)
        {
            if (id!=id_before){
                if (confirm(arraylng["MSG_0035"]));
                {
                    if(val!="0")
                    {
                        document.all['IDS'].value=","+val+",";
                        document.all[id_before].checked=false;
                    }
                }
            }
            else
            {
                document.all['IDS'].value=",";
                document.all[id_before].checked=false;
            }
        }
        else
        {
            document.all['IDS'].value=document.all['IDS'].value+val+",";
        }
        id_before=id;
        document.all['id_bef'].value=id_before;
    }
}
