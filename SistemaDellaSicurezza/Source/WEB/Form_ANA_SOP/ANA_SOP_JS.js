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

/*
 * CONST
 * RISC
 * DISP
 * GENDIS
 * RETLEG
 */

var bFlgSync = false; // controlla la sincronizzazione delle chiamate ad Ajax

function ajaxListPROCEDIMENTO(cod_pro){
    //    alert("in ajaxListPROCEDIMENTO - cod_sop = "+cod_sop);
    //    return;
    
    var ajaxRetPROC = document.getElementById('ajaxRetPROC');
    var ajaxRetOPER = document.getElementById('ajaxRetOPER');
    var ajaxRetCANT = document.getElementById('ajaxRetCANT');
    var cmdHTML;
    
    var obj = document.getElementsByName("PARENT");
    var obj = document.getElementById("ID_PARENT");

    var cod_sop;
    if(obj!=null)
        cod_sop = obj.value;
    else
        cod_sop = 0;

    var cod_pro_lst = 0;
    if(cod_pro==null||cod_pro==undefined)
    {
        if(document.getElementById("lista_procedimenti")!=null)
        {
            var lista_procedimenti=document.getElementById("lista_procedimenti");
            cod_pro_lst = lista_procedimenti.value;
        }
    }
    else
    {
        cod_pro_lst=cod_pro;
    }

    if(cod_pro_lst == 0)
    { // Avvio constatazione
        cmdHTML = "../Form_ANA_SOP/elab_POC_ajax.jsp?COD=0&TIPO=PROC";
        eseguiChiamataAjax(cmdHTML, ajaxRetPROC, bFlgSync);
        cmdHTML = "../Form_ANA_SOP/elab_POC_ajax.jsp?COD=0&TIPO=OPER";
        eseguiChiamataAjax(cmdHTML, ajaxRetOPER, bFlgSync);
        cmdHTML = "../Form_ANA_SOP/elab_POC_ajax.jsp?COD=0&TIPO=CANT";
        eseguiChiamataAjax(cmdHTML, ajaxRetCANT, bFlgSync);
    }
    else
    { // Selezione constatazione
        cmdHTML = "../Form_ANA_SOP/elab_POC_ajax.jsp?COD_SOP="+cod_sop+"&COD="+cod_pro_lst+"&TIPO=PROC";
        eseguiChiamataAjax(cmdHTML, ajaxRetPROC, bFlgSync);
        cmdHTML = "../Form_ANA_SOP/elab_POC_ajax.jsp?COD="+cod_pro_lst+"&TIPO=OPER";
        eseguiChiamataAjax(cmdHTML, ajaxRetOPER, bFlgSync);
        cmdHTML = "../Form_ANA_SOP/elab_POC_ajax.jsp?COD="+cod_pro_lst+"&TIPO=CANT";
        eseguiChiamataAjax(cmdHTML, ajaxRetCANT, bFlgSync);
    }
}

function chkCOD_DOC(cod_doc,cod_sop){
    var ajaxReturn = document.getElementById('ajaxReturn');
    eseguiChiamataAjax('../Form_ANA_SOP/elab_cond.jsp?COD_DOC='+cod_doc+'&COD_SOP='+cod_sop,ajaxReturn, false);
    if (ajaxReturn.value=='1'){
        ajaxReturn.value = "";
        alert("Non è possibile collegare il sopralluogo a se stesso.");
        return false;
    } else if (ajaxReturn.value=='0'){
        ajaxReturn.value = "";
        alert("Documento già collegato.");
        return false;
    } else {
        ajaxReturn.value = "";
        return true;
    }

/*
function ajaxListRISC(){
    var ajaxRetDISP = document.getElementById('ajaxRetDISP');
    var ajaxRetGENDIS = document.getElementById('ajaxRetGENDIS');
    var ajaxRetRETLEG = document.getElementById('ajaxRetRETLEG');
    var cmdHTML;

    var cod = 0;
    if(document.getElementById("lista_rischi")!=null)
    {
	var lista_rischi=document.getElementById("lista_rischi");
	cod = lista_rischi.value;
    }
    if(cod == 0)
    {
	cmdHTML = "../Form_ANA_CON-DIS_SOP/elab_condis.jsp?COD=0&TIPO=DISP";
	eseguiChiamataAjax(cmdHTML, ajaxRetDISP, false);
    }
    else
    {
	cmdHTML = "../Form_ANA_CON-DIS_SOP/elab_condis.jsp?COD="+cod+"&TIPO=DISP";
	eseguiChiamataAjax(cmdHTML, ajaxRetDISP, false);
    }
    cmdHTML = "../Form_ANA_CON-DIS_SOP/elab_condis.jsp?COD=0&TIPO=GENDIS";
    eseguiChiamataAjax(cmdHTML, ajaxRetGENDIS, false);
    cmdHTML = "../Form_ANA_CON-DIS_SOP/elab_condis.jsp?COD=0&TIPO=RETLEG";
    eseguiChiamataAjax(cmdHTML, ajaxRetRETLEG, false);
}

function ajaxListDISP(){
    var ajaxReturn = document.getElementById('ajaxReturnCAN');
    var cmdHTML="../Form_ANA_CON-DIS_SOP/elab_condis.jsp?CONT=XXX&TIPO=DISP";
    eseguiChiamataAjax(cmdHTML, ajaxReturn, false);
}

function ajaxListGENDIS(){
    var ajaxReturn = document.getElementById('ajaxReturnCAN');
    var cmdHTML="../Form_ANA_CON-DIS_SOP/elab_condis.jsp?CONT=XXX&TIPO=GENDIS";
    eseguiChiamataAjax(cmdHTML, ajaxReturn, false);
}
function ajaxListRETLEG(){
    var ajaxReturn = document.getElementById('ajaxReturnCAN');
    var cmdHTML="../Form_ANA_CON-DIS_SOP/elab_condis.jsp?CONT=XXX&TIPO=RETLEG";
    eseguiChiamataAjax(cmdHTML, ajaxReturn, false);
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
*/
}
