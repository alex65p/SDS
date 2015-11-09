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

//
// FUNZIONI
//

var LastOpenHelpWindow = null;
var LastAboutWindow = null;

function g_get_DialogWindow_HelpFeachures(){
    var windowWidth=300;
    var windowHeight=600;
    var borderSpace=20;
    var windowParams =  "dialogHeight:"+windowHeight+"px; dialogWidth:"+windowWidth+"px; help:0; resizable:0; status:0; scroll:0; " + 
                        "dialogLeft:" + (screen.width - windowWidth - borderSpace) + "px; " +
                        "dialogTop:" + (borderSpace+50) + "px;";
    return windowParams;
}

function g_get_StandardWindow_HelpFeachures(){
    var windowWidth=300;
    var windowHeight=600;
    var borderSpace=20;
    var windowParams =  "height="+windowHeight+"px; width="+windowWidth+"px; help=0; resizable=0; status=0; scroll=0; " + 
                        "left=" + (screen.width - windowWidth - borderSpace) + "px; " +
                        "top=" + (borderSpace+50) + "px;";
    return windowParams;
}

function g_getAboutFeachures(){
    var windowWidth=550;
    var windowHeight=605;
    var borderSpace=20;
    var windowParams =  "dialogHeight:"+windowHeight+"px;dialogWidth:"+windowWidth+"px;help:0;resizable:0;status:0;scroll:0" + 
                        ";dialogLeft:" + ((screen.width / 2) - (windowWidth / 2) - borderSpace) +
                        ";dialogTop:" + ((screen.height / 2) - (windowHeight / 2)) + ";";
    return windowParams;
}

function g_getExceptionMessageFeachures(){
  
    
    
    var windowWidth=1000;
    var windowHeight=530;
    var borderSpace=20;
    var windowParams =  "height=" + windowHeight + "," + 
                        "width=" + windowWidth + "," +
                        "resizable=no," + 
                        "status=no," + 
                        "scrollbars=no," + 
                        "menubar=no," +
                        "toolbar=no," +
                        "location=no," +
                        ",left=" + ((screen.width / 2) - (windowWidth / 2) - borderSpace) +
                        ",top=" + ((screen.height / 2) - (windowHeight / 2));
    return windowParams;
}

function g_openHelpWindow(url){
    if (LastOpenHelpWindow){
        LastOpenHelpWindow.close();
        LastOpenHelpWindow = null;
    }
    
    // for Internet explorer
    if (window.showModelessDialog){
        LastOpenHelpWindow = window.showModelessDialog(url, null, g_get_DialogWindow_HelpFeachures());
    // for all browser
    } else {
        LastOpenHelpWindow = window.open(url, null, g_get_StandardWindow_HelpFeachures());
    }
}

function g_openAboutWindow(url){
    if (LastAboutWindow != null){
        LastAboutWindow.close();
    }
    var openWin = window.showModelessDialog(url, null, g_getAboutFeachures());
    LastAboutWindow = openWin;
    return openWin;
}

function g_openExceptionMessageWindow(url){
    var WindowName = "ExceptionManagerWindow";
    var openWin = window.open(url, WindowName, g_getExceptionMessageFeachures());
    return openWin;
}
