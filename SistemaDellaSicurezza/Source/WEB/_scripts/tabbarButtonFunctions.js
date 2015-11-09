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

//--------------- Table functions --------------------------------------

var winFeachures="";
var f_getFeachures = new Function();

//--------------- CHANGING OLD or NEW style setting window Feachers ----
function changeFeachers(actParams, dialogParams){
    if (dialogParams.height && dialogParams.whidth){
        winFeachures=dialogParams;
        f_getFeachures = l_getFeachures;
    }
    else if (actParams.Feachures){
        winFeachures=actParams.Feachures;
        f_getFeachures = new_getFeachures;
    }
}
//-------------- Show modal dialog window for tabs assotiation --------
function showWindow(url, row, vArgs, modal){
    var res="";
    if(dialogParams.url.indexOf('?')!=-1){

        idStr = "&ID_PARENT=" + row.INDEX;
        if (row.id) idStr = idStr + "&ID=" + row.id;
        if (row.paramsList) idStr = idStr + "&" + row.paramsList;
        u = url + idStr;
      
        if(!DEBUG_TABS_OPEN && modal == true){
            res = window.showModalDialog(u, vArgs, f_getFeachures(winFeachures));
        }else{
            window.open(u);
        }
    }
    else{
        idStr = "?ID_PARENT=" + row.INDEX;
        if (row.id) idStr = idStr + "&ID=" + row.id;
        if (row.paramsList) idStr = idStr + "&" + row.paramsList;
        u = url + idStr;
           
        if(!DEBUG_TABS_OPEN){
         res = window.showModalDialog(u, vArgs, f_getFeachures(winFeachures));
        }else{
            window.open(u);
        }
    }
    return res;
}

function windowHelp(){
    actionParams = tabbar.activeTab.actionParams[this.action];
    if (actionParams != null){
        var HelpPar = "";
        if (actionParams.url.indexOf('?') > -1)
            HelpPar = "&";
        else
            HelpPar = "?";
        HelpPar += "HelpFrom=ASSOCIATE";
        g_openHelpWindow(actionParams.url+HelpPar);        
    }
}

//-----------------------------------------------------------------------
//------Add new record to assotiated table-------------------------------
//-----------------------------------------------------------------------
function addRow(action){
    tab = tabbar.activeTab.table;
    actParams = tabbar.activeTab.actionParams;
    if (!this.action){
        if (!action) return;
        dialogParams = actParams[action];
    }
    else{
        dialogParams = actParams[this.action];
    }
    if (!dialogParams){
        alert("Can not get dialogParams object.\n Pass the 'action' parameter to addRow function");
        return;
    }
    changeFeachers(actParams, dialogParams);
    if (dialogParams.alert){
        showAlert(dialogParams.alert);
        return;
    }
    dialogArgs = dialogParams.addDialogParameters;
    if (tab){
        id = tab.id;
        if (tab.rows.length>0){
            row = tab.rows[0];
            
            /* 
             * Questo blocco di codice abilita il seguente meccanismo:
             * 
             * - Inserisco un nuovo record premendo il pulsante "Nuova associazione".
             * - Il parametro "useSelectedRowParamsList" è impostato a "true".
             * - Ho una riga selezionata all'interno del tab.
             * - La lista di parametri "paramsList" della riga selezionata 
             *   è passata alla finestra aperta per l'inserimento della nuova associazione.
             * 
             *  Tale meccanismo è stato utilizzato per un esigenza di roma metropolitane
             *  e reso generico per eventuali utilizzi futuri.
             *  
             *  INIZIO
             *  
             */
            
            if (row.oldParamsList){
                row.paramsList = row.oldParamsList;
                row.oldParamsList = null;
            }
            if (dialogParams.useSelectedRowParamsList != null && 
                dialogParams.useSelectedRowParamsList == true &&
                tab.selectedRow ){
                    row.oldParamsList = row.paramsList;
                    row.paramsList = tab.selectedRow.paramsList;
            }
            if (dialogParams.checkBeforeInsert != null && 
                dialogParams.checkBeforeInsert == true){
                    if (dialogParams.useSelectedRowParamsList != null && 
                        dialogParams.useSelectedRowParamsList == true){
                        if (tab.selectedRow){
                            if (window.beforeInsert){
                                if (!window.beforeInsert.call(null, row.paramsList)){
                                    return;
                                }
                            }
                        }
                         else {
                        if (window.beforeInsert){
                            if (!window.beforeInsert.call(null, row.paramsList)){
                                return;
                            }
                        }
                    }
                    } else {
                        if (window.beforeInsert){
                            if (!window.beforeInsert.call(null, row.paramsList)){
                                return;
                            }
                        }
                    }
            }
            
            /* 
             * Questo blocco di codice abilita il seguente meccanismo:
             * 
             * - Inserisco un nuovo record premendo il pulsante "Nuova associazione".
             * - Il parametro "useSelectedRowParamsList" è impostato a "true".
             * - Ho una riga selezionata all'interno del tab.
             * - La lista di parametri "paramsList" della riga selezionata 
             *   è passata alla finestra aperta per l'inserimento della nuova associazione.
             * 
             *  Tale meccanismo è stato utilizzato per un esigenza di roma metropolitane
             *  e reso generico per eventuali utilizzi futuri.
             *  
             *  FINE
             *  
             */
            
            if (dialogParams.addDialogParameters){
                if (row.INDEX){
                    res=showWindow(dialogParams.url,row, dialogArgs, true);
                    
                  if (res!="OK"){
                        if (res=="ERROR") {
                            alert(arraylng["MSG_0104"]);
                            return;
                        }else
                        if (res=="CANCEL"){
                            return;
                        }
                        else   {
                            return;
                        }
                    }
                    if (dialogArgs.toRow){
                        newRow = dialogArgs.toRow(row.cloneNode(true));
                        if (newRow==null){
                            return;
                        }
                    }
                    else{
                        alert("Not defined method that creates row in local table");
                        return;
                    }
                }
                else{
                    alert(arraylng["MSG_0105"]);
                    return;
                }
            }
            else{
                res = showWindow(dialogParams.url,row, null, true);
                tabbar.activeTab.Refresh(true);
                return;
            }
            newRow.style.display="inline";
            strTab = tab.outerHTML;

            strTab = strTab.substr(0, strTab.indexOf("</TBODY>"))
            strTab +=newRow.outerHTML + "</TBODY></TABLE>";
            if (tabbar.activeTab.table.selectedRow){
                index=tabbar.activeTab.table.selectedRow.Index;
            }
            else{
                index=0;
            }
            tab.removeNode(true);
            tabbar.activeTab.tab.tabScrContainer.insertAdjacentHTML("BeforeEnd",strTab);
            tabbar.activeTab.table = document.getElementById(id);
			
            init_rows(tabbar.activeTab.table, index, true, tabbar.activeTab);
            tabbar.activeTab.tab.center.click();
        }
    }
    else{
//alert("Errore! Tabella di destinazione non è trovata.\n");
}
}


//---------------------------------------------------------------------
//------- Creazione di un nuovo record, senza -------------------------
//------- aprire successivamente un form corrispondente ---------------
//---------------------------------------------------------------------
function executeOperation(){
    actionParams = tabbar.activeTab.actionParams[this.action];
    tab = tabbar.activeTab.table;
    aTab = tabbar.activeTab;
    if (actionParams.alert!=null){
        showAlert(actionParams.alert);
        return;
    }
    if(tab){
        actionParams.target_element.src=actionParams.url;
    }
}


//-----------------------------------------------------------
//------- Delete record from associated table ---------------
//-----------------------------------------------------------
function delRow(){
	
    actionParams = tabbar.activeTab.actionParams[this.action];
    //alert(actionParams.ExtendedMode);
    if (actionParams.ExtendedMode) {
        delRowEx();
        return;
    }
    tab = tabbar.activeTab.table;
    aTab = tabbar.activeTab;
    if (actionParams.alert!=null){
        showAlert(actionParams.alert);
        return;
    }
    if(tab){
        if (tab.selectedRow){

            cnf=confirm(arraylng["MSG_0097"]);
            //confirm(actionParams["Extended"]);

            //return;
            if(cnf){
                row=tab.selectedRow;
                //<comment date="25/01/2004" text="Added id_parent">

                idStr = "ID_PARENT=" + row.INDEX;
                if (row.id) idStr = idStr + "&ID=" + row.id;
                if (row.paramsList) idStr = idStr + "&" + row.paramsList;
                
                if(actionParams.url.indexOf('?')!=-1){
                    actionParams.target_element.src=actionParams.url+"&"+idStr;
                }
                else{
                    actionParams.target_element.src=actionParams.url+"?"+idStr;
                }
            }// confirm
        }
    }
}// function
//-----------------------------------
function del_localRow(){
    tab = tabbar.activeTab.table;
    if(tab){
        if (tab.selectedRow){
            row=tab.selectedRow;
            tab.selectedRow = null;
            row.removeNode(true);
            refreshDependedTabs(tabbar.activeTab);
        }
    }
}
//-----------------------------------------------------------
function delRowEx(){
    tab = tabbar.activeTab.table;
    aTab = tabbar.activeTab;
    if(tab){
        if (confirm(arraylng["MSG_0097"])){
            frs="dialogHeight:350px;dialogWidth:720px;help:no;resizable:no;status:no;scroll:no;unadorned:yes;";
            url="../Form_GEST_AZIENDA/GEST_AZIENDA_Form.jsp";
            res = window.showModalDialog(url, document, frs);
            colAzl = document.getElementsByName("AZIENDA_ID");
            var str="";
            for (i=0;i<colAzl.length;i++){
                str+="&AZIENDA_ID="+colAzl[i].value;
            }
            row=tab.selectedRow;
            if(actionParams.url.indexOf('?')!=-1){
                urlDel=actionParams.url+"&ID="+row.id+"&ID_PARENT="+row.INDEX+str;
            }
            else{
                urlDel=actionParams.url+"?ID="+row.id+"&ID_PARENT="+row.INDEX+str;
            }
            //alert(urlDel);
            actionParams.target_element.src=urlDel;
        }
    }
}
//------- Edit record in associatad table -------------------
//-----------------------------------------------------------

function editRow(action){
    document.selection.empty();
    tab = tabbar.activeTab.table;
    actParams = tabbar.activeTab.actionParams;
   
    if (!this.action){
        if (!action) return;
        dialogParams = actParams[action];
        alert(dialogParams);
    }
    else{
        dialogParams = actParams[this.action];
    }
    if (!dialogParams){
        alert("Can not get dialogParams object.\n Pass the 'action' parameter to addRow function");
        return;
    }
    //------------------------------------//
    changeFeachers(actParams, dialogParams);
    //------------------------------------//
    if (dialogParams.alert){
        showAlert(dialogParams.alert);
        return;
    }
    if (!tabbar.bCanAssociate) return;
    if (dialogParams.disabled) return;
		
    dialogArgs = dialogParams.editDialogParameters;
    if (tab){
        id = tab.id;
        if (tab.selectedRow){
            row = tab.selectedRow;
            
            if (dialogParams.editDialogParameters){
                if (row.id){
                    if (row.rowDetailEnabled==null || row.rowDetailEnabled=="true"){
                        if (row.personalizedUrl != null && row.personalizedUrl != ""){
                            dialogParams.url = row.personalizedUrl;
                       
                        }
                        res=showWindow(dialogParams.url,row, dialogArgs, true);
                        if (res!="OK"){
                            if (res=="ERROR") {
                                alert(arraylng["MSG_0104"]);
                                return;
                            }else
                            if (res=="CANCEL"){
                                return;
                            }
                            else   {
                                return;
                            }
                        }
                        if (dialogArgs.toRow){
                            row=dialogArgs.toRow(row);
                        }
                        else{
                            alert("Not defined method that creates row in local table");
                            return;
                        }
                    }
                }
                else{
                    alert("Id not difined");
                    return;
                }
            }
            else{
                if (row.rowDetailEnabled==null || row.rowDetailEnabled=="true"){
                    if (row.personalizedUrl != null && row.personalizedUrl != ""){
                        dialogParams.url = row.personalizedUrl;
                    }
                    if (dialogParams.modalWindow == null || row.modalWindow == true){
                        res = showWindow(dialogParams.url,row, null, true);
                        tabbar.activeTab.Refresh(true);
                    } else {
                        res = showWindow(dialogParams.url,row, null, false);
                    }
                }
                return;
            }
        }
    }
}
//----------Refresh Active Tab---------------------------
function RefreshTab(){
    activeTab= tabbar.activeTab;
    activeTab.Refresh(true);
}

//----- Select row ---------------------------------------
function selectRow(){
    if (this.parentElement.parentElement.selectedRow){
        // Deseleziono la riga precedentemente selezionata
        row = this.parentElement.parentElement.selectedRow;
        row.className="dataTr";
        for (i=0; i<row.cells.length; i++){
            row.cells[i].className="dataTd";
        }
        colInputs = row.getElementsByTagName("INPUT");
        for (i=0; i<colInputs.length; i++){
            if (colInputs[i].fixedStyle==null){
                colInputs[i].className = "inputstyle";
            }
        }
    }
    
    // Se la riga precedentemente selezionata e quella attuale coincidono,
    // non eseguo una nuova selezione di tale riga, implementando di fatto
    // il meccanismo di deselezione.
    if (this.parentElement.parentElement.selectedRow == this){
        this.parentElement.parentElement.selectedRow = null;
        return;
    }
    
    // Evidenzio la riga attualmente selezionata
    this.className = "dataTrSelected";
    this.parentElement.parentElement.selectedRow = this;
    for (i=0; i<this.cells.length; i++){
        this.cells[i].className="dataTdSelected";
    }
    colInputs=this.getElementsByTagName("INPUT");
    for (i=0; i<colInputs.length; i++){
        if (colInputs[i].fixedStyle==null){
            colInputs[i].className = "dataInputSelected";
        }
    }
}
//-------------------------------------------------------
function l_getFeachures(obj){
    return "dialogHeight:"+obj.height+"; dialogWidth:"+obj.whidth+";help:no;resizable:no;status:no;scroll:no;";
}
function new_getFeachures(params){
    var strFeachers="";
    defaultParams = {
        "dialogHeight":"300px",
        "dialogWidth":"300px",
        "dialogLeft":"",
        "dialogTop":"",
        "center":"yes",
        "dialogHide":"no",
        "edge":"rised",
        "help":"yes",
        "resizable":"no",
        "scroll":"no",
        "status":"no",
        "unadorned":"no"
    }
    for (key in defaultParams){
        if (params[key]){
            strFeachers+= key+":"+params[key]+";";
        }
        else{
            strFeachers+= key+":"+defaultParams[key]+";";
        }
    }
    return strFeachers;
}
//---<comment author="Alex Kyba" date="26/01/2004">
function showAlert(str){
    alert(str);
}
//---</comment>
