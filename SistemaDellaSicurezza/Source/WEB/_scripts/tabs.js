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

//----------TabBar---------------------------
var buttonsSrc = new Array();
/* buttonsSrc["btnNew"] ="../_images/NUOVO.gif";
 buttonsSrc["btnEdit"]="../_images/EDIT.gif";
 buttonsSrc["btnCancel"]="../_images/DEL_DET.gif";
 buttonsSrc["btnRefresh"]="../_images/refresh.gif";
 */
buttonsSrc["btnNew"] = "../_images/new/NEW_ASSOCIATE.gif";
buttonsSrc["btnEdit"] = "../_images/new/OPEN_ASSOCIATE.gif";
buttonsSrc["btnCancel"] = "../_images/new/DELETE_ASSOCIATE.gif";
buttonsSrc["btnRefresh"] = "../_images/new/REFRESH.GIF";
buttonsSrc["btnAssociate"] = "../_images/new/pen3.gif";
buttonsSrc["btnHelp"] = "../_images/new/HELP.GIF";
function  TabBar(id, container) {
    this.container = container;
    this.id = id;
    this.tabs = new Array();
    this.activeTab = null;
    this.buttonBar = null;
    this.addTab = add_tab;
    this.delTab = del_tab;
    this.addButtonBar = add_button_bar;
    this.tabBar = createTabbar(this.id, this.container);
    this.tabCont = document.all["tabCont"];
    this.idParentRecord = 0;
    this.refreshTabUrl = null;
    this.GetTabById = get_tab_by_id;
    this.RefreshAllTabs = refresh_all_tabs;
    this.ReloadTabTable = reload_tab_table;
    this.ResetAllTabsContent = reset_tabs_content;
    this.DEBUG_TABS_IFRM = false;
    this.bCanAssociate = bCanAssociate;
    this.bCanAssociateDelete = bCanAssociateDelete;
    this.activeColumnsSorting = activeColumnsSorting;
    this.sortableColumns = false;
}
function createTabbar(id, container) {
    var str = "<table width=\"100%\" id=\"" + id + "\" align=\"left\" style=\"height:100%\" border=0 cellpadding=\"0\" cellspacing=\"0\"><tr><td colspan=\"100%\">&nbsp;</td></tr><tr id=\"tr_tabCaption\"><td class=\"emptyTd\" width=\"1000\">&nbsp;</td></tr><tr><td colspan=\"100%\" style=\"border:	0px solid red;\"><div  id = \"tabCont\" class=\"tblCont\"></div></tr></table>";
//    var str = "<table width=\"100%\" id=\""+id+"\" ></div></tr></table>";
    container.insertAdjacentHTML("AfterBegin", str);
    return document.getElementById(id);
}
function add_tab(tab) {
    tab.init();

}
function del_tab(tab) {
    ;
}
function add_button_bar(btnBar) {
    this.buttonBar = btnBar;
    this.tabCont.appendChild(this.buttonBar.panel);
}
function get_tab_by_id(tabName) {
    for (i = 0; i < this.tabs.length; i++) {
        if (this.tabs[i].tabObj.id == tabName)
            return this.tabs[i].tabObj;
    }
    return null;
}
function refresh_all_tabs() {
    for (i = 0; i < this.tabs.length; i++) {
        this.tabs[i].tabObj.Refresh();
    }
}
function reload_tab_table(doc) {
    for (i = 0; i < this.tabs.length; i++) {
        tab = this.tabs[i].tabObj;
        if (document.frames(tab.ifrmWork.id).document == doc) {
            if (doc.all["dContent"])
                tab.ReloadTable(doc.all["dContent"].innerHTML);
            else
                alert("div 'dContent' not defined");
        }
    }
}
function reset_tabs_content() {
    this.idParentRecord = 0;
    this.RefreshAllTabs();
    /*for (i=0; i<this.tabs.length; i++){
     this.tabs[i].tabObj.Refresh();
     }*/
}
//--------Tab-------------
function Tab(id, caption, tabbar) {
    this.id = id;
    this.tabCaption = caption;
    this.isActive = false;
    this.table = null;
    this.objType = "tab";

    this.tabContainer = null;
    this.actionParams = null;
    this.setCaption = set_caption;
    this.activate = tab_activate;
    this.deactivate = tab_deactivate;
    this.OnActivate = null;
    this.tabBar = tabbar;
    this.tab = createTab(this.id, this.tabCaption, tabbar);
    this.tab.init = tab_init;
    this.addTable = add_table;
    this.ReloadTable = reload_table;
    this.RestoreTab = restore_tab;
    this.tabCopy = new Array();
    this.tab.tabObj = this;
    //------------------
    this.Refresh = refresh_tab;
    this.ifrmWork = this.tab.ifrmWork;
    this.refreshTabUrl = "";
    this.attachDependedTab = add_depended_tab;
    this.ResetContent = reset_content;
    //----------------
    this.DEBUG_TAB_IFRM = false;
    this.dependedTabs = null;
    
    this.columnOrdered = null;
    this.orderType = null;
    
    return this.tab;

}

function tab_init() {
    this.center.onclick = this.tabObj.activate;
    this.center.parent = this;
}
function tab_activate() {
    activeTab = this.parent.tabObj.tabBar.activeTab;
    buttonBar = this.parent.tabObj.tabBar.buttonBar;
    tabBar = this.parent.tabObj.tabBar;
    if (activeTab) {
        activeTab.deactivate();
    }
    tab = this.parent;
    tab.center.className = "pageTopSel";
    tab.tabHeaderContainer.style.display = "inline";
    tab.tabContainer.style.display = "inline";
    tab.tabObj.tabBar.activeTab = tab.tabObj;
    if (this.parent.tabObj.tabBar.DEBUG_TABS_IFRM || this.parent.tabObj.DEBUG_TAB_IFRM) {
        this.parent.tabObj.ifrmWork.style.display = "inline";
    }
    else {
        this.parent.tabObj.ifrmWork.style.display = "none";
    }

    params = tab.tabObj.actionParams;
    butbar = tab.tabObj.tabBar.buttonBar;
    if (params) {
        for (key in params) {
            disabledProp = params[key]["disabled"];
            buttonIndex = params[key]["buttonIndex"];
            if (butbar.buttons[buttonIndex]) {
                butbar.buttons[buttonIndex].disabled = disabledProp;
                butbar.buttons[buttonIndex].style.visibility = (disabledProp) ? "hidden" : "visible";
            }
        }
    }
    if (butbar.panel.New)
        if (!butbar.panel.New.disabled) {

            butbar.panel.New.style.visibility = (tabBar.bCanAssociate) ? "visible" : "hidden";
            butbar.panel.New.disabled = !tabBar.bCanAssociate;

        }
    if (butbar.panel.Edit) {
        if (!butbar.panel.Edit.disabled) {
            butbar.panel.Edit.style.visibility = (tabBar.bCanAssociate) ? "visible" : "hidden";
            butbar.panel.Edit.disabled = !tabBar.bCanAssociate;
        }
    }
    if (butbar.panel.Delete) {
        if (!butbar.panel.Delete.disabled) {
            butbar.panel.Delete.style.visibility = (tabBar.bCanAssociateDelete) ? "visible" : "hidden";
            butbar.panel.Delete.disabled = !tabBar.bCanAssociateDelete;
        }
    }

    //-----
    if (!(tab.tabObj.table && tab.tabObj.tableHeader))
        return;
    table = tab.tabObj.table;
    tableHeader = tab.tabObj.tableHeader;

    adaptTable(tableHeader, table);

    if (typeof (tab.tabObj.OnActivate) == "function") {
        tab.tabObj.OnActivate();
    }

}
function refresh_tab(isRefreshDepTab) {
    id = this.id;
    id_parent = tabbar.idParentRecord;
    var url;
    var target;
    
    if (this.ifrmWork) {
        target = this.ifrmWork;
    }
    else {
        alert("Target iframe not defined");
        return;
    }
    if (!this.refreshTabUrl) {
        if (!this.tabBar.refreshTabUrl) {
            alert("Target url not defined");
            return;
        }
        else {
            url = this.tabBar.refreshTabUrl;
        }
    }
    else {
        url = this.refreshTabUrl;
    }
    if (url.indexOf('?') != -1) {
        src = url + "&TAB_NAME=" + id + "&ID_PARENT=" + id_parent;
    }
    else {
        src = url + "?TAB_NAME=" + id + "&ID_PARENT=" + id_parent;
    }
    
    if (this.tableHeader) {
        this.tableHeader.removeNode(true);
        this.tableHeader = null;
    }
    if (this.table) {
        this.table.removeNode(true);
        this.table = null;
    }
    if (id_parent == 0)
        return;
    this.tab.tabScrContainer.innerHTML = "Caricamento in corso..."
    
    if (this.columnOrdered != null){
        src += "&columnOrdered="+this.columnOrdered;
    }
    if (this.orderType != null){
        src += "&orderType="+this.orderType;
    }

    target.src = src;

    if (isRefreshDepTab) {
        refreshDependedTabs(this);
    }
}

function refreshDependedTabs(tab) {
    if (tab.dependedTabs) {
        if (tab.dependedTabs.length > 0) {
            for (i = 0; i < tab.dependedTabs.length; i++) {
                tab.dependedTabs[i].Refresh(true);
            }
        }
    }
}

function add_depended_tab(tArray) {
    if (tArray.length > 0) {
        for (i = 0; i < tArray.length; i++) {
            if (tArray[i].objType != "tab") {
                alert("Parameter " + i + " is not tab");
                return;
            }
        }
        this.dependedTabs = tArray;
    }
    else {
        alert("Must be array of tabs");
        return;
    }
}

function restore_tab() {
    this.tab.tabHeaderContainer.innerHTML = this.tabCopy["header"];
    this.tab.tabScrContainer.innerHTML = this.tabCopy["body"];
}

function tab_deactivate() {

    if (this.tab.tabIndex == tabbar.tabs.length - 1) {
        this.tab.center.className = "pageLastUnsel";
    }
    else
        this.tab.center.className = "pageTopUnsel";
    this.tab.tabContainer.style.display = "none";
    this.tab.tabHeaderContainer.style.display = "none";
}
function set_caption(caption) {
}
function on_activate() {
    ;
}
function on_deactivate() {
    ;
}
function createTab(id, caption, tabbar) {

    var tab = new Object();
    var tabCaption = tabbar.tr_tabCaption;
    var tabIndex = tabbar.tabs.length;
    strCenter = "<div id=\"spanCaption_" + id + "\" style=\"word-wrap : normal;width:5px\" nowrap class=\"tabText\">&nbsp;" + caption + "&nbsp;</div>";
    tdCenter = tr_tabCaption.insertCell(tr_tabCaption.cells.length - 1);
    tdCenter.className = "pageTopUnsel";
    tdCenter.id = "center" + id;
    tdCenter.innerHTML = strCenter;
    spanCaption = document.getElementById("spanCaption_" + id);
    tdCenter.caption = spanCaption.innerText;
    tab.center = tdCenter;
    tab.tabIndex = tabIndex;
    //----------------------------
    tabCnt = document.createElement("DIV");
    tabCnt.id = "headerContainer_" + id;
    tabCnt.className = "tabHeaderDiv";
    tab.tabHeaderContainer = tabbar.tabCont.appendChild(tabCnt);
    //----------------------------
    tabCnt = document.createElement("DIV");
    tabCnt.id = "container_" + id;
    tabCnt.className = "tabDiv";
    tabScrCont = document.createElement("DIV");
    tabScrCont.id = "scrContainer_" + id;
    tabScrCont.className = "tabScrDiv";
    //------------------------------------
    ifrmRefresh = document.createElement("IFRAME");
    ifrmRefresh.id = "ifrmRefresh_" + id;
    ifrmRefresh.name = "ifrmRefresh_" + id;
    ifrmRefresh.className = "ifrm1";
    ifrmRefresh.style.display = "none";
    ifrmRefresh.src = "../empty.txt";
    tab.tabScrContainer = tabCnt.appendChild(tabScrCont);
    tab.tabContainer = tabbar.tabCont.appendChild(tabCnt);
    tab.ifrmWork = tabbar.tabCont.appendChild(ifrmRefresh);
    tabbar.tabs[tabIndex] = tab;
    return tab;
}

function add_table(tblHeader, tbl, isSelRows) {
    tableHeader = this.tab.tabHeaderContainer.appendChild(tblHeader);
    table = this.tab.tabScrContainer.appendChild(tbl);
    this.table = table;
    this.tableHeader = tableHeader;
    //----------------------------
    //this.tabCopy["header"] = tableHeader.outerHTML;
    //this.tabCopy["body"] = table.outerHTML;
    //---------------------------
    init_rows(this.table, 0, isSelRows, this);
}
function reload_table(content) {
    el = document.createElement("DIV");
    el.innerHTML = content;
    if (el.getElementsByTagName("TABLE").length == 0)
    {
        this.tab.tabScrContainer.innerHTML = "It's not possible to load the content.";
        return;
    }
    this.tab.tabHeaderContainer.innerHTML = el.getElementsByTagName("TABLE")[0].outerHTML;
    this.tab.tabScrContainer.innerHTML = el.getElementsByTagName("TABLE")[1].outerHTML;
    this.table = this.tab.tabScrContainer.getElementsByTagName("TABLE")[0];
    this.tableHeader = this.tab.tabHeaderContainer.getElementsByTagName("TABLE")[0];
    el.removeNode(true);
    
    // Preparo la tabella per l'ordinamento dinamico delle proprie colonne.
    prepareTableHeader4DynamicOrder(this);
    
    // Adatta la tabella 
    adaptTable(this.tableHeader, this.table);
    
    // Ricostruisce l'Header della tabella impostabdo l'ordinamento eseguito.
    adaptTableHeader4DynamicOrder(this);
    
    // Inizializza le righe della tabella
    init_rows(this.table, 0, true, this);
    
    return;
}

function init_rows(table, index, isSelRows, tabObj) {
    counter = new Object();
    counter.i = 0;
    table.className += " tabTable";

    for (counter.i = 0; counter.i < table.rows.length; counter.i++) {
        if (isSelRows) {
            table.rows[counter.i].onclick = selectRow;
            table.rows[counter.i].action = "Edit";
            table.rows[counter.i].ondblclick = editRow;
        }
        table.rows[counter.i].Index = counter.i;
        if (i == index) {
            table.selectedRow = table.rows[counter.i];
        }
    }
    counter = null;
    if (index == 0)
        table.selectedRow = null;
    if (table.rows.length == 1) {
        table.style.display = "none";
    }
    else {
        table.style.display = "inline";
    }
}

function activeColumnsSorting(activeColumnsSorting){
    this.sortableColumns = activeColumnsSorting; 
}

function adaptTableHeader4DynamicOrder(tab){
    if (tab.columnOrdered > 0){
        // Identifico la colonna cliccata.
        var clickedColumn = tab.tableHeader.getElementsByTagName("TD")[tab.columnOrdered-1];
        
        // Salvo la descrizione HTML del nome della colonna.
        var colLabel = clickedColumn.getElementsByTagName("STRONG")[0].outerHTML;

        // Azzero il contenuto della colonna
        clickedColumn.innerHTML = "";

        // Ricreo la colonna con descrizione...
        var tbl = document.createElement("table");
        tbl.setAttribute("class", "dataTableHeader");
        tbl.cellPadding = "0";
        tbl.cellSpacing = "0";
        var row = document.createElement("tr");

        var td1 = document.createElement("td");
        td1.innerHTML = colLabel + "&nbsp";
        row.appendChild(td1);

        // ...  e icona di ordinamento.
        var td2 = document.createElement("td");
        var img = document.createElement("img");
        switch (tab.orderType) {
            case "desc":
                img.src = "../_images/ORDINE_UP.GIF";
                img.alt = "premi per ordinare in maniera ascendente";
                break;
            default:
                img.src = "../_images/ORDINE_DOWN.gif";
                img.alt = "premi per ordinare in maniera discendente";
        }
        td2.appendChild(img);
        row.appendChild(td2);

        tbl.appendChild(row);
        clickedColumn.innerHTML = tbl.outerHTML;    
    }
}

function orderTableColumn(tab, clickedColumn) {

    // Determino il criterio di ordinamento
    var orderType = tab.orderType;
    
    if (tab.columnOrdered !== clickedColumn.columnIndex){
        tab.orderType = "asc";
    } else {
        switch (orderType) {
            case "asc":
                tab.orderType = "desc";
                break;
            default:
                tab.orderType = "asc";
        }
    }
    
    // Registro l'indice della colonna da ordinare
    tab.columnOrdered = clickedColumn.columnIndex;

    // Ricarico il tab.
    tab.Refresh();
}

function prepareTableHeader4DynamicOrder(tab) {
    if (tab.tabBar.sortableColumns){
        var colCounter = 0;
        var el = null;
        var attr = null;
        var colList = tab.tableHeader.getElementsByTagName("TD");

        for (colCounter = 0; colCounter < colList.length; colCounter++) {
            el = colList[colCounter];
            attr = el.getAttribute("ordered");

            // Se individuo una colonna che può essere ordinata... 
            if (attr && attr.toLowerCase() === "true") {
                // Imposto il cursore alla tipologia "hand" (mano che clicca),
                // per far capire all'utente che siamo in presenza di una colonna
                // che può essere ordinata.
                el.style.cursor = "hand";

                // Registro l'indice della colonna, come attributo della colonna stessa.
                el.columnIndex = colCounter+1;

                // Imposto un metodo da eseguire al click della colonna da ordinare
                el.onclick = function() {
                    orderTableColumn(tab, this);
                };
            }
        }
    }
}

function adaptTable(tableHeader, table) {
    counter = new Object();
    counter.i = 0;
    counter.y = 0;
    counter.z = 0;
    for (counter.i = 0; counter.i < table.rows.length; counter.i++) {
        for (counter.y = 0; counter.y < table.rows[counter.i].cells.length; counter.y++) {
            iCol = table.rows[counter.i].cells[counter.y].getElementsByTagName("INPUT");
            for (counter.z = 0; counter.z < iCol.length; counter.z++) {
                if (iCol[counter.z].type == "text") {
                    width = tableHeader.rows[0].cells[counter.y].offsetWidth;
                    iCol[counter.z].width = width;
                    table.rows[counter.i].cells[counter.y].style.width = width;
                    break;
                }
            }
        }
    }
    counter = null;
}
function reset_content() {
    if (this.tableHeader) {
        this.tableHeader.removeNode(true);
        this.tableHeader = null;
    }
    if (this.table) {
        this.table.removeNode(true);
        this.table = null;
    }
}
//-------ButtonPanel------
function ButtonPanel(id, ArrButtons) {
    this.id = id;
    this.buttons = new Array();
    this.panel = createButtonPanel(id, ArrButtons, this);
    this.addButton = add_button;
    this.deleteButton = del_button;
    return this;
}
function createButtonPanel(id, ArrButtons, butPanel) {
    btnBarObj = document.createElement("DIV");
    btnBarObj.id = "btnBar" + id;
    btnBarObj.className = "btnBar";
    tab = document.createElement("TABLE");
    tab.cellPadding = "0";
    tab.cellSpacing = "0";
    tab.border = "0";
    row = tab.insertRow();
    //row.style.height="7px";
    cell = row.insertCell();
    //cell.innerText=" ";
    //row=tab.insertRow();
    if (ArrButtons.length != 0) {
        for (i = 0; i < ArrButtons.length; i++) {
            params = ArrButtons[i];
            cell = row.insertCell();
            cell.style.border = "0px solid blue";
            cell.style.background = "#ffffcc";
            cell.style.width = "20px";
            BtnObj = document.createElement("BUTTON");
            if (params.id)
                BtnObj.id = params.id;
            if (params.url)
                BtnObj.url = params.url;
            if (params.dialogParams)
                BtnObj.dialogParams = params.dialogParams;
            if (params.onmousedown)
                BtnObj.onmousedown = params.onmousedown;
            else
                BtnObj.onmousedown = btnDown;
            if (params.onmouseup)
                BtnObj.onmouseup = params.onmouseup;
            else
                BtnObj.onmouseup = btnOver;
            if (params.onmouseover)
                BtnObj.onmouseover = params.onmouseover;
            else
                BtnObj.onmouseover = btnOver;
            if (params.onmouseout)
                BtnObj.onmouseout = params.onmouseout;
            else
                BtnObj.onmouseout = btnOut;
            if (params.onclick)
                BtnObj.onclick = params.onclick;
            if (params.action)
                BtnObj.action = params.action;
            if (params.id == "btnNew") {
                BtnObj.title = arraylng["MSG_0111"];
                btnBarObj.New = BtnObj;
            }
            if (params.id == "btnEdit") {
                BtnObj.title = arraylng["MSG_0112"];
                btnBarObj.Edit = BtnObj;
            }
            if (params.id == "btnCancel") {
                BtnObj.title = arraylng["MSG_0113"];
                btnBarObj.Delete = BtnObj;
            }
            if (params.id == "btnHelp") {
                BtnObj.title = arraylng["MSG_0114"];
            }
            if (params.id == "btnAssociate") {
                BtnObj.title = arraylng["MSG_0178"];
            }
            BtnObj.className = "btnNormal";
            img = new Image(25, 25);

            img.src = buttonsSrc[params["id"]];
            BtnObj.appendChild(img);
            butPanel.buttons[butPanel.buttons.length] = cell.appendChild(BtnObj);
        }
        if (DEBUG_TABS_OPEN) {
            cell = row.insertCell();
            BtnObj = document.createElement("BUTTON");
            BtnObj.id = "REFRESH_DEBUG";
            BtnObj.onmousedown = btnDown;
            BtnObj.onmouseup = btnOver;
            BtnObj.onmouseover = btnOver;
            BtnObj.onmouseout = btnOut;
            BtnObj.onclick = RefreshTab;
            BtnObj.className = "btnNormal";
            img = new Image;
            img.src = buttonsSrc["btnRefresh"];
            BtnObj.appendChild(img);
            butPanel.buttons[butPanel.buttons.length] = cell.appendChild(BtnObj);
        }
    }
    btnBarObj.appendChild(tab);
    return btnBarObj;
}
function add_button() {
    ;
}
function del_button() {
    ;
}

//--------------Button functions-------------
function btnOver() {
    //this.className="btnOver";
}
function btnOut() {
    //this.className="btnNormal";
}

function btnDown() {
    //this.className="btnDown";
}
//--------------Dialog parameters------------
function DialogParameters() {
    this.ID = null;
}
