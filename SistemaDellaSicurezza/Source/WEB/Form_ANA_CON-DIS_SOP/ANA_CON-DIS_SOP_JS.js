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
 * FATRSO
 * CONST
 * RISC
 * DISP
 * GENDIS
 * RETLEG
 */

var bFlgSync = false; // controlla la sincronizzazione delle chiamate ad Ajax

function apriEditor(lista){
    var lista_selected_item = lista.options[lista.selectedIndex];    
    if (lista_selected_item){
        alert(lista_selected_item.text);
    }
}

function clearAttivita(){
    document.forms[0].CON_DIS_COD_DOC.value = '';
    document.forms[0].CON_DIS_NOM_ATT.value = '';
}

function getAttivita(){
    var obj = new Object();
    var url="Form_ANA_ATT/ANA_ATT_View.jsp?noFindEx=1";
    if(showSearch(url, obj, "dialogHeight:30;dialogWidth:35;help:no;resizable:yes;status:yes;scroll:no;")=="OK"){
        document.forms[0].CON_DIS_COD_DOC.value = obj.CELLS[4];
        document.forms[0].CON_DIS_NOM_ATT.value = obj.CELLS[1] +"-"+ obj.CELLS[2];
    }
}

function clearDitteEsterne(){
    document.forms[0].CON_DIS_COD_DTE.value = '';
    document.forms[0].CON_DIS_RAG_SCL_DTE.value = '';
}

function getDitteEsterne(){
    var obj = new Object();
    var url="Form_ANA_DTE/ANA_DTE_View.jsp?noFindEx=1";
    if(showSearch(url, obj, "dialogHeight:30;dialogWidth:35;help:no;resizable:yes;status:yes;scroll:no;")=="OK"){
        document.forms[0].CON_DIS_COD_DTE.value = obj.CELLS[6];
        document.forms[0].CON_DIS_RAG_SCL_DTE.value = obj.CELLS[1];
    }
}
    
function gestCONSTadditionalInfo(){
    var status = !document.getElementById("lista_constatazioni").value;
    
    // Ditta
    document.forms[0].CON_DIS_COD_DTE.disabled = status;
    document.forms[0].CON_DIS_RAG_SCL_DTE.disabled = status;
    document.forms[0].btnGetDitteEsterneName.disabled = status;
    document.forms[0].btnClearDitteEsterneName.disabled = status;
    clearDitteEsterne();
    
    // Attività
    document.forms[0].CON_DIS_COD_DOC.disabled = status;
    document.forms[0].CON_DIS_NOM_ATT.disabled = status;
    document.forms[0].btnAttivitaName.disabled = status;
    document.forms[0].btnClearAttivitaName.disabled = status;
    clearAttivita();
    
    // Campo a testo libero
    document.forms[0].CON_DIS_DES_LIB.disabled = status;
    document.forms[0].CON_DIS_DES_LIB.value = '';
    
    // Tabelle contenitrici
    document.getElementById("constDittaAttivitaTable").disabled = status;
    document.getElementById("constFreeFieldTable").disabled = status;
}

function prepare4FatRsoChange(){
    document.getElementById("lista_constatazioni").options.length = 0;
}

function setListsUneditable(){
    var lista_fattori = document.getElementById("lista_fattori");
    var lista_constatazioni = document.getElementById("lista_constatazioni");
    
    lista_fattori.disabled='disabled';
    lista_constatazioni.disabled='disabled';
    
    var lista_fattori_selected_item = lista_fattori.options[lista_fattori.selectedIndex];
    var lista_constatazioni_selected_item = lista_constatazioni.options[lista_constatazioni.selectedIndex];
    
    lista_fattori_selected_item.style.backgroundColor="navy";
    lista_constatazioni_selected_item.style.backgroundColor="navy";
}

function ajaxListCONST(cod_fat_rso, cod_cst, onlyDisp){
    var ajaxRetFATRSO = document.getElementById('ajaxRetFATRSO');
    var ajaxRetCONST = document.getElementById('ajaxRetCONST');
    var ajaxRetRISC = document.getElementById('ajaxRetRISC');
    var ajaxRetDISP = document.getElementById('ajaxRetDISP');
    var ajaxRetGENDIS = document.getElementById('ajaxRetGENDIS');
    var ajaxRetRETLEG = document.getElementById('ajaxRetRETLEG');
    var cmdHTML;
    
    // Determino il "CODICE SOPRALLUOGO-CONSTATAZIONE"
    var cod_sop_cst = document.getElementById("ID_PARENT").value;
    if(cod_sop_cst==null || cod_sop_cst=='null'){
        cod_sop_cst = 0;
    }

    // Determino il "CODICE FATTORE DI RISCHIO"
    if(cod_fat_rso==null||cod_fat_rso==undefined){
        cod_fat_rso = 0;
        var lista_fattori=document.getElementById("lista_fattori");
        if(lista_fattori!=null && lista_fattori.value!=''){
            cod_fat_rso = lista_fattori.value;
        }
    }

    // Determino il "CODICE CONSTATAZIONE"
    if(cod_cst==null||cod_cst==undefined){
        cod_cst = 0;
        var lista_constatazioni=document.getElementById("lista_constatazioni");
        if(lista_constatazioni!=null && lista_constatazioni.value!=''){
            cod_cst = lista_constatazioni.value;
        }
    }

    /*
    alert("codice sopralluogo-constatazione: " + cod_sop_cst + "\n" + 
          "codice fattore di rischio: " + cod_fat_rso + "\n" +
          "codice constatazione: " + cod_cst);
    */
   
    if(cod_fat_rso == 0)
    { // Avvio constatazione
        // Fattori di rischio
        cmdHTML = "../Form_ANA_CON-DIS_SOP/elab_condis.jsp?COD_FAT_RSO=0&COD=0&TIPO=FATRSO";
        eseguiChiamataAjax(cmdHTML, ajaxRetFATRSO, bFlgSync);
        // Constatazioni
        cmdHTML = "../Form_ANA_CON-DIS_SOP/elab_condis.jsp?COD_FAT_RSO=0&COD=0&TIPO=CONST";
        eseguiChiamataAjax(cmdHTML, ajaxRetCONST, bFlgSync);
        // Rischi
        cmdHTML = "../Form_ANA_CON-DIS_SOP/elab_condis.jsp?COD_FAT_RSO=0&COD=0&TIPO=RISC";
        eseguiChiamataAjax(cmdHTML, ajaxRetRISC, bFlgSync);
        // Disposizioni
        cmdHTML = "../Form_ANA_CON-DIS_SOP/elab_condis.jsp?COD_FAT_RSO=0&COD=0&TIPO=DISP";
        eseguiChiamataAjax(cmdHTML, ajaxRetDISP, bFlgSync);
        // Disposizione generata
        cmdHTML = "../Form_ANA_CON-DIS_SOP/elab_condis.jsp?COD_SOP_CST=0&COD_FAT_RSO=0&COD=0&TIPO=GENDIS"+(onlyDisp?"&onlyDisp="+onlyDisp:"");
        eseguiChiamataAjax(cmdHTML, ajaxRetGENDIS, bFlgSync);
        // Articoli di legge
        cmdHTML = "../Form_ANA_CON-DIS_SOP/elab_condis.jsp?COD_FAT_RSO=0&COD=0&TIPO=RETLEG";
        eseguiChiamataAjax(cmdHTML, ajaxRetRETLEG, bFlgSync);
    }
    else
    { // Selezione constatazione
        // Fattori di rischio
        cmdHTML = "../Form_ANA_CON-DIS_SOP/elab_condis.jsp?COD_FAT_RSO="+cod_fat_rso+"&COD="+cod_cst+"&TIPO=FATRSO";
        eseguiChiamataAjax(cmdHTML, ajaxRetFATRSO, bFlgSync);
        // Constatazioni
        cmdHTML = "../Form_ANA_CON-DIS_SOP/elab_condis.jsp?COD_FAT_RSO="+cod_fat_rso+"&COD="+cod_cst+"&TIPO=CONST";
        eseguiChiamataAjax(cmdHTML, ajaxRetCONST, bFlgSync);
        // Rischi
        cmdHTML = "../Form_ANA_CON-DIS_SOP/elab_condis.jsp?COD_FAT_RSO="+cod_fat_rso+"&COD="+cod_cst+"&TIPO=RISC";
        eseguiChiamataAjax(cmdHTML, ajaxRetRISC, bFlgSync);
        // Disposizioni
        cmdHTML = "../Form_ANA_CON-DIS_SOP/elab_condis.jsp?COD_FAT_RSO="+cod_fat_rso+"&COD="+cod_cst+"&TIPO=DISP";
        eseguiChiamataAjax(cmdHTML, ajaxRetDISP, bFlgSync);
        // Disposizione generata
        cmdHTML = "../Form_ANA_CON-DIS_SOP/elab_condis.jsp?COD_SOP_CST="+cod_sop_cst+"&COD_FAT_RSO="+cod_fat_rso+"&COD="+cod_cst+"&TIPO=GENDIS"+(onlyDisp?"&onlyDisp="+onlyDisp:"");
        eseguiChiamataAjax(cmdHTML, ajaxRetGENDIS, bFlgSync);
        // Articoli di legge
        cmdHTML = "../Form_ANA_CON-DIS_SOP/elab_condis.jsp?COD_FAT_RSO="+cod_fat_rso+"&COD="+cod_cst+"&TIPO=RETLEG";
        eseguiChiamataAjax(cmdHTML, ajaxRetRETLEG, bFlgSync);
    }
    
    if (cod_sop_cst > 0){
        setListsUneditable();
    }
}
