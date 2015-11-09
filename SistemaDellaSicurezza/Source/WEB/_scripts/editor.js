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

function TextEditor()
{
	this.url="editor.html";
	this.showEditor= e_show;
	this.textAreas = new Array();
	this.currentTxtArea = null;
	this.init= text_init;
}

function text_init()
{
	this.textAreas = document.getElementsByTagName("TEXTAREA");
	for (i=0; i<this.textAreas.length; i++){
		this.textAreas[i].parObj= this;
		this.textAreas[i].onclick = function(){
			this.parObj.currentTxtArea=this;
		}
		this.textAreas[i].ondblclick = this.showEditor; 
	}
}
function e_show()
{
	if (!this.parObj.currentTxtArea.readOnly){
		res = window.showModalDialog(this.parObj.url, this.parObj.currentTxtArea, getFeachures());
		document.selection.empty();
	}	
}
function e_hide(){}
function getFeachures(){
		return "dialogHeight:500px; dialogWidth:400px;help:no;resizable:yes;status:no;scroll:no;";
}
function initTextAreas(){
	editor.init();
}
var editor = new TextEditor;
 





