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

document.write("<script type='text/javascript' src='../_scripts/help.js'></script>");

var tbl_onload_orig = document.onload;
document.onload = tbl_onload;
function tbl_onload() {
    alert("v 0.07");
    if (tbl_onload_orig != null)
        tbl_onload_orig();

}

var tbl_strFeach = "dialogHeight:30; dialogWidth:55;help:no;resizable:yes;status:yes;scroll:no;";

var tbl_bAlreadyRefreshed = false;
var isExtendedMode = false;
var isExtendedForm = false;
var isExtendedFormParName = "";

var EXTENDED_OPERATION_INSERT_EDIT = arraylng["MSG_0190"];
var EXTENDED_OPERATION_DELETE = arraylng["MSG_0191"];

function tb_ShowRefreshFrame() {
    if (tbl_bAlreadyRefreshed)
        return;
    var fr = window.document.getElementById("frameRefresh");
    fr.style.display = "";
    fr.style.width = document.body.clientWidth;
    fr.style.height = document.body.clientHeight;
    fr.style.position = "absolute";
    fr.style.top = 0;
    fr.style.left = 0;
    tbl_bAlreadyRefreshed = true;
}

function tb_ReloadDialog(url) {

    frameRefresh.document.location.replace(url);
    //document.location.replace(url);
}

function tb_OnNew() {
    tb_ReloadDialog(tb_url_Edit);
}

function tb_OnCopy() {
    ifrmWork.location.reload(tb_url_Copy);
}

function tb_OnSearch() {
    var obj = new Object()
    if (showSearch(null, obj) == "OK") {
        tb_ReloadDialog(tb_url_Edit + "&ID=" + obj.ID + "&IDD=XXX");
    }
}

function showModelessSearch(url, obj, strFeach) {
    if (url == null)
        url = tb_url_Search;
    if (strFeach == null)
        strFeach = tbl_strFeach;
    if (url.indexOf("?") == -1)
        url = url + "?";
    url += buildQuery((pFields.length != 0));
    url = url.replace(/&/g, "|");
    return  answ = showModelessDialog("../search.jsp?URL=" + url, obj, strFeach);
}

function showSearch(url, obj, strFeach) {
    if (url == null)
        url = tb_url_Search;
    if (strFeach == null)
        strFeach = tbl_strFeach;
    if (url.indexOf("?") == -1)
        url = url + "?";
    url += buildQuery((pFields.length != 0));
    url = url.replace(/&/g, "|");
    return  answ = showModalDialog("../search.jsp?URL=" + url, obj, strFeach);
}

function tb_extendedMode(strOperation) {
    var str = arraylng["MSG_0098"];
    if (isExtendedMode && isExtendedForm) {
        if (tb_url_Edit.indexOf("ANA_PRO_SAN_Form") != -1)
            str = arraylng["MSG_0099"];
        if (tb_url_Edit.indexOf("ANA_MIS_PET_Form") != -1)
            str = arraylng["MSG_0100"];
        if (tb_url_Edit.indexOf("ANA_MAN_Form") != -1)
            str = arraylng["MSG_0101"];
        if (tb_url_Edit.indexOf("ANA_MAC_Form") != -1)
            str = arraylng["MSG_0102"];
        if (tb_url_Edit.indexOf("ANA_LUO_FSC_Form") != -1)
            str = arraylng["MSG_0189"];

        if (confirm(arraylng["MSG_0095"] + " " + strOperation + " " + str + " " + arraylng["MSG_0096"])) {
            frs = "dialogHeight:410px;dialogWidth:740px;help:no;resizable:no;status:no;scroll:no;unadorned:yes;";
            url = "../Form_GEST_AZIENDA/GEST_AZIENDA_Form.jsp";
            if (str == arraylng["MSG_0098"]) {
                url = url + "?fromANA_RSO=true";
                if (isExtendedFormParName != null) {
                    url = url + "&isExtendedFormParName=" +
                            document.getElementById(isExtendedFormParName).value;
                }
            }
            res = window.showModalDialog(url, document, frs);
            return res;
        }
    }
    return "OK";
}

function tb_OnSave() {
    if (tb_extendedMode(EXTENDED_OPERATION_INSERT_EDIT) == "OK") {

        if (!window.beforeSave || (window.beforeSave && window.beforeSave())) {
            document.forms[0].submit();
        }
    }
}

function tb_OnDelete(DEL_MSG_EXT) {
    if (confirm(arraylng[(DEL_MSG_EXT?"MSG_0216":"MSG_0036")])) {
        var str = "";
        if (tb_url_Edit.indexOf("ANA_LUO_FSC_Form") != -1 &&
                tb_extendedMode(EXTENDED_OPERATION_DELETE) == "OK") {
            colAzl = document.getElementsByName("AZIENDA_ID");
            for (i = 0; i < colAzl.length; i++) {
                str += "&AZIENDA_ID=" + colAzl[i].value;
            }
        }
        ifrmWork.location.reload(tb_url_Delete + str);
    } else
        return;
}
//Funzione che gestisce l'on-click sul bottone "riabilita"
function tb_OnEnable() {
    var risposta=confirm(arraylng["MSG_0095"] + " " + arraylng["MSG_0225"]);
    if (risposta) {
        var str = "";
          codDpd = document.getElementsByName("COD_DPD");
            for (i = 0; i < codDpd.length; i++) {
                str += "&COD_DPD=" + codDpd[i].value;
            }
       
       ifrmWork.location.reload(tb_url_Enable + str);
    } else
        return;
}

function tb_OnPrint() {
    tb_OpenReport(tb_url_Print);
}

function tb_OnPrint2() {
    tb_OpenReport(tb_url_Print2);
}

function tb_OnPrint3() {
    tb_OpenReport(tb_url_Print3);
}

function tb_OnExit() {
    window.returnValue = 'CANCEL';
    window.close();
}

function tb_OnGetAziende() {
    colAzl = document.getElementsByName("AZIENDA_ID");
    frs = "dialogHeight:350px;dialogWidth:720px;help:no;resizable:no;status:no;scroll:no;unadorned:yes;";
    url = "../Form_GEST_AZIENDA/GEST_AZIENDA_Form.jsp";
    res = window.showModalDialog(url, document, frs);
}

function tb_OnHelp() {
    g_openHelpWindow(tb_url_Help + "?HelpFrom=FORM");
}

function tb_OnReturnNew() {
    if (isExtendedMode && (tb_isExtendedAttach)) {

        if (confirm(arraylng["MSG_0103"])) {
            frs = "dialogHeight:350px;dialogWidth:720px;help:no;resizable:no;status:no;scroll:no;unadorned:yes;";
            url = "../Form_GEST_AZIENDA/GEST_AZIENDA_Form.jsp";
            res = window.showModalDialog(url, document, frs);
            if (res != "OK")
                return;
            colAzl = document.getElementsByName("AZIENDA_ID");
            var str = "";
            for (i = 0; i < colAzl.length; i++) {
                str += "&AZIENDA_ID=" + colAzl[i].value;
            }
            tb_url_Attach += str;
        }
    }
    
    ifrmWork.location.reload(tb_url_Attach);
}

function tb_OnReturnOld() {
    window.returnValue = 'OK';
    window.close();
}

function tb_OnReturn() {
    if (tb_url_Attach == null)
        return tb_OnReturnOld();
    return tb_OnReturnNew();
}


function tb_OnDiv(obj) {
    alert(obj.innerHTML);
}

function tb_OnRefresh(iframe) {
    if (window.parent == window)
        return;
    if (iframe.readyState == "interactive") {
        parent.tb_ShowRefreshFrame();
    }
}
//<handler>
var g_Handler = new Object();
g_Handler.OnRefresh = tb_OnNew;
//<handler>

function tb_OnNewSaved(params) {
    //return tb_OnReturn();
    tb_ReloadDialog(tb_url + "?" + params + "&" + tb_url_Query + "&IDD=XXX"); ///???
}

function tb_OpenReport(url) {
    if (url.indexOf('?') == -1)
        url += "?";
    var w = window.open("../Reports/prepair.jsp", "_blank");
    w.location.reload("../Reports/" + url + (url.indexOf('&') == -1 ? "&" : "") + tb_strAziendaId + "&" + tb_strQueryString);
}
//<alex>
function buildQuery(isRegFields) {
    var strQuery = "";
    var counter = 0;
    if (isRegFields) {
        for (i = 0; i < pFields.length; i++) {
            strQuery += getString(document.all[pFields[i]]);
        }
    }
    else {
        frm = document.forms[0];
        fObjects = frm.elements;
        strQuery = "";
        for (z = 0; z < fObjects.length; z++) {
            if (counter == 24)
                break;
            obj = fObjects[z];
            if (obj.tagName == "INPUT" || obj.tagName == "SELECT" || obj.tagName == "TEXTAREA") {
                counter++;
                strQuery += getString(obj);

            }
        }
    }
    return strQuery;
}

function getString(obj) {
    strQuery = "";
    var txt, val, val2;
    if (obj) {
        if (obj.tagName == "INPUT") {
            if (obj.type == "checkbox" || obj.type == "radio") {
                strQuery += (obj.checked) ? "&" + obj.name + "=" + obj.value : "";
            }
            else {
                strQuery += (obj.value != "") ? "&" + obj.name + "=" + obj.value : "";
            }
        }
        if (obj.tagName == "SELECT") {
            if (obj.selectedIndex == -1)
                return ""; //fixed by Artur
            strQuery += (obj.options[obj.selectedIndex].value != "") ? "&" + obj.name + "=" + obj.options[obj.selectedIndex].value : "";
        }
        if (obj.tagName == "TEXTAREA") {
            if (obj.value == "")
                return "";
            val = ((obj.value.length > 30) ? obj.value.substr(0, 30) : obj.value);
            txt = "&" + obj.name + "=" + val;
            strQuery += txt;
        }
    }
    //return encodeURI(strQuery);
    return strQuery;
}
//</alex>

function ZToolBar() {
    this.OnDelete = g_Handler.OnRefresh;
    this.OnNew = tb_OnNewSaved;

    this.New = new Object();
    this.New.getButton = function() {
        return document.getElementById("btnNew");
    };
    this.New.setEnabled = function(b) {
        this.getButton().disabled = !b;
    };
    this.New.getEnabled = function() {
        return !this.getButton().disabled
    };
    this.New.OnClick = tb_OnNew;
//button Copy
    this.Copy = new Object();
    this.Copy.getButton = function() {
        return document.getElementById("btnCopy");
    };
    this.Copy.setEnabled = function(b) {
        this.getButton().disabled = !b;
    };
    this.Copy.getEnabled = function() {
        return !this.getButton().disabled
    };
    this.Copy.OnClick = tb_OnCopy;

    this.Search = new Object();
    this.Search.getButton = function() {
        return document.getElementById("btnSearch");
    };
    this.Search.setEnabled = function(b) {
        this.getButton().disabled = !b;
    };
    this.Search.getEnabled = function() {
        return !this.getButton().disabled
    };
    this.Search.OnClick = tb_OnSearch;

    this.Detail = new Object();
    this.Detail.getButton = function() {
        return document.getElementById("btnDetail");
    };
    this.Detail.setEnabled = function(b) {
        this.getButton().disabled = !b;
    };
    this.Detail.getEnabled = function() {
        return !this.getButton().disabled
    };
    this.Detail.OnClick = null;

    this.Save = new Object();
    this.Save.getButton = function() {
        return document.getElementById("btnSave");
    };
    this.Save.setEnabled = function(b) {
        this.getButton().disabled = !b;
    };
    this.Save.getEnabled = function() {
        return !this.getButton().disabled
    };
    this.Save.OnClick = tb_OnSave;

    this.Delete = new Object();
    this.Delete.getButton = function() {
        return document.getElementById("btnDelete");
    };
    this.Delete.setEnabled = function(b) {
        this.getButton().disabled = !b;
    };
    this.Delete.getEnabled = function() {
        return !this.getButton().disabled
    };
    this.Delete.OnClick = tb_OnDelete;
//Button Enabled
    this.Enable= new Object();
    this.Enable.getButton = function() {
        return document.getElementById("btnEnable");
    };
    this.Enable.setEnabled = function(b) {
        this.getButton().disabled = !b;
    };
    this.Enable.getEnabled = function() {
        return !this.getButton().disabled
    };
    this.Enable.OnClick = tb_OnEnable;

//

    this.Help = new Object();
    this.Help.getButton = function() {
        return document.getElementById("btnHelp");
    };
    this.Help.setEnabled = function(b) {
        this.getButton().disabled = !b;
    };
    this.Help.getEnabled = function() {
        return !this.getButton().disabled
    };
    this.Help.OnClick = tb_OnHelp;

    this.Print = new Object();
    this.Print.getButton = function() {
        return document.getElementById("btnPrint");
    };
    this.Print.setEnabled = function(b) {
        this.getButton().disabled = !b;
    };
    this.Print.getEnabled = function() {
        return !this.getButton().disabled
    };
    this.Print.OnClick = tb_OnPrint;

    this.Print2 = new Object();
    this.Print2.getButton = function() {
        return document.getElementById("btnPrint2");
    };
    this.Print2.setEnabled = function(b) {
        this.getButton().disabled = !b;
    };
    this.Print2.getEnabled = function() {
        return !this.getButton().disabled
    };
    this.Print2.OnClick = tb_OnPrint2;

    this.Print3 = new Object();
    this.Print3.getButton = function() {
        return document.getElementById("btnPrint3");
    };
    this.Print3.setEnabled = function(b) {
        this.getButton().disabled = !b;
    };
    this.Print3.getEnabled = function() {
        return !this.getButton().disabled
    };
    this.Print3.OnClick = tb_OnPrint3;

    this.Exit = new Object();
    this.Exit.getButton = function() {
        return document.getElementById("btnExit");
    };
    this.Exit.setEnabled = function(b) {
        this.getButton().disabled = !b;
    };
    this.Exit.getEnabled = function() {
        return !this.getButton().disabled
    };
    this.Exit.OnClick = tb_OnExit;

    this.Return = new Object();
    this.Return.getButton = function() {
        return document.getElementById("btnReturn");
    };
    this.Return.setEnabled = function(b) {
        this.getButton().disabled = !b;
    };
    this.Return.getEnabled = function() {
        return !this.getButton().disabled
    };
    this.Return.OnClick = tb_OnReturn;//??????
    this.Return.Do = tb_OnReturnOld;//??????

    this.Aziende = new Object();
    this.Aziende.getButton = function() {
        return document.getElementById("");
    }
    this.Aziende.setEnabled = function(b) {
        this.getButton().disabled = !b;
    };
    this.Aziende.getEnabled = function() {
        return !this.getButton().disabled
    };
    this.Aziende.OnClick = tb_OnGetAziende;

    this.submitReport = function(REP_NAME, url) {
        if (url != null)
            action = url;
        else
            action = "../Reports/ScadenzarioReport.jsp"
        frm = document.forms[0];
        frm.oldAction = frm.action;
        frm.oldTarget = frm.target;
        frm.action = action;
        var w = window.open("../Reports/prepair.jsp", REP_NAME);
        w.focus();
        frm.target = REP_NAME;
        frm.submit();
        w.document.title = "Scadenzario report";
        this.restoreFrmProps(frm);
    }
    this.restoreFrmProps = function(form) {
        form.target = form.oldTarget;
        form.action = form.oldAction;
    }

    this.openReport = tb_OpenReport;
    return this;
}
var ToolBar = new ZToolBar();
window.ToolBar = ToolBar;


