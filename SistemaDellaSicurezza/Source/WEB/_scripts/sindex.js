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


function g_LoadView(url) {
    if (url == null)
        return;
    DocOnClick();
    g_navigateFrame(frameView, url);
}

function getLocation(frame){
    // for Internet explorer
    if (frame.document) return frame.document.location;
    else
    // for all browser
    if (frame.contentWindow) return frame.contentWindow.location;
}

function g_navigateFrame(frame, url) {
    url = g_preParseUrl(url);
    getLocation(frame).replace(url);
}

function g_Clear() {
    g_objCurrentRow = null;
    g_Handler = new Object();
    g_Handler.New = new Object();
    g_Handler.New.OnBefore = null;
    g_Handler.New.OnAfter = null;
    g_Handler.New.URL = "";
    g_Handler.New.Width = 0;
    g_Handler.New.Height = 0;

    g_Handler.Delete = new Object();
    g_Handler.Delete.URL = "";
    g_Handler.Delete.OnBefore = null;
    g_Handler.Delete.OnAfter = null;

    g_Handler.Open = new Object();
    g_Handler.Open.URL = "";
    g_Handler.Open.OnBefore = null;
    g_Handler.Open.OnAfter = null;

    g_Handler.Help = new Object();
    g_Handler.Help.URL = "";
    g_Handler.Help.OnBefore = null;
    g_Handler.Help.OnAfter = null;

    g_Handler.OnRefresh = g_OnRefresh;

    g_Handler.OnRowClick = g_OnRowClick;
    g_Handler.OnRowDblClick = g_OnRowDblClick;

    g_Handler.OnViewChange = g_OnViewChange;
    g_Handler.setCaption = g_setCaption;
    g_Handler.setCaptionHTML = g_setCaptionHTML;

    g_Handler.New.getButton = function() {
        return document.getElementById("btnNew");
    };
    if( g_Handler.New.getButton()!= null)
      g_Handler.New.getButton().disabled = false;

    g_Handler.Delete.getButton = function() {
        return document.getElementById("btnDelete");
    };
      if( g_Handler.Delete.getButton()!= null)
         g_Handler.Delete.getButton().disabled = false;
     
    //Gestione delle dimensioni delle colonne della table dataTable
     g_Handler.dataTableArrayWidth = new Array();
     g_Handler.dataTableOn="";
      
}

function g_setCaption(strCaption) {
    lbCaption.innerText = strCaption.toUpperCase();
}

function g_setCaptionHTML(strCaption) {
    
    var captionModify="";
    
    if(strCaption!=""){
       captionModify=parseBlankHTML(strCaption);
       strCaption=captionModify;
    }
    
    lbCaption.innerHTML = strCaption.toUpperCase();
}
function parseBlankHTML(strCaption) {
    var mySplitResult = strCaption.split(" "); 
    var captionModify="";
    var contaBlank=0;
   // alert('1'+strCaption);
    if(mySplitResult.length>1){
        for(i = 0; i < mySplitResult.length; i++){
        
            if(mySplitResult[i]=="&nbsp;"){    
               contaBlank++;
          
            if(contaBlank >2 && mySplitResult[i]=="&nbsp;"){
                mySplitResult[i]=" "; 
                //alert('2'+mySplitResult[i]);
            }
        }
	captionModify+= ' '+mySplitResult[i]; 
       }
       
    }
   // alert('3'+captionModify);
    return captionModify;
}
function g_getIDURL(url, id) {
    return url + "?ID=" + id;
}

function g_getRowIndex() {
    if (g_objCurrentRow == null)
        return null;
    return g_objCurrentRow.getAttribute("INDEX");
}

function g_getFeachures(obj) {
    return "dialogHeight:" + obj.Height + "; dialogWidth:" + obj.Width + ";help:no;resizable:no;status:no;scroll:no;";
}

function g_OnHelp(obj) {
    var HelpPar = "";
    if (g_Handler.Help.URL.indexOf('?') > -1)
        HelpPar = "&";
    else
        HelpPar = "?";
    HelpPar += "HelpFrom=VIEW";

    if (g_Handler.Help.URL != null && g_Handler.Help.URL != "") {
        if (g_Handler.Help.OnBefore != null) {
            if (!g_Handler.Help.OnBefore())
                return;
        }
        g_openHelpWindow(g_Handler.Help.URL + HelpPar);
        if (g_Handler.Help.OnAfter != null) {
            g_Handler.Help.OnAfter()
        }
    }
}

function g_OnOpen(obj) {
    var strIndex = g_getRowIndex()
    if (strIndex == null)
        return;
    if (g_Handler.Open.OnBefore != null) {
        if (!g_Handler.Open.OnBefore())
            return;
    }

    var answ = g_showModalDialog(g_getIDURL(g_Handler.Open.URL, strIndex), null, g_Handler.Open);
    //--- mary 22/06/2004 dla ydalenija aziendi - begin
    if (answ == "DELETE") {
        document.location.reload();
        return;
    }
    //--- mary 22/06/2004 dla ydalenija aziendi - begin
    //if (answ=="OK")
    g_Handler.OnRefresh();
}

function g_OnNew(obj) {
    if (g_Handler.New.OnBefore != null) {
        if (!g_Handler.New.OnBefore())
            return;
    }

    var answ = g_showModalDialog(g_Handler.New.URL, null, g_Handler.New);
    //if (answ=="OK")
    g_Handler.OnRefresh();
}

function g_OnDelete(obj, DEL_MSG_EXT) {
    var strIndex = g_getRowIndex()
    if (strIndex == null)
        return;

    //if(g_Handler.Delete.OnBefore!=null){
    //if(!g_Handler.Delete.OnBefore(g_getRowIndex(obj), obj)) return;
    //}
    //else{
    if (!confirm(arraylng[(DEL_MSG_EXT ? "MSG_0215" : "MSG_0094")]))
        return;

    //}
    //frameDelete.src=g_getIDURL(g_Handler.Delete.URL, strIndex);
    g_navigateFrame(frameDelete, g_getIDURL(g_Handler.Delete.URL, strIndex));
}

function g_OnSearch(obj) {
    return g_Handler.OnSearch()
}

function g_OnRefresh(obj) {
    getLocation(frameView).reload(g_lastUrl);
}

function g_OnViewChange(obj, pInitialize) {
    tblIntro.style.display = "none";
    tblAll.style.display = "";
    OnInit(obj, pInitialize);
    //divTable.innerHTML=obj.outerHTML;
    //g_Clear()
    //pInitialize();
    g_lastUrl = getLocation(frameView).toString();
}
